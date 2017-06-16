DECLARE @msg NVARCHAR(100)

/************************************ test_instance_id TO STRING ************************************************/
/* ON tests_instances */
SET @msg = 'UPDATING test_instance_id TO STRING IN test_instances TABLE'
RAISERROR (@msg, 0, 1) WITH NOWAIT
ALTER TABLE test_instances
ALTER COLUMN test_instance_id nvarchar(20)
SET @msg = 'DONE CHANGING test_instance_id TO STRING ON test_instances'
RAISERROR (@msg, 0, 1) WITH NOWAIT

/* ON triggered_alerts */
SET @msg = 'UPDATING test_instance_id TO STRING IN triggered_alerts TABLE'
RAISERROR (@msg, 0, 1) WITH NOWAIT
ALTER TABLE triggered_alerts
ALTER COLUMN test_instance_id nvarchar(20)
SET @msg = 'DONE CHANGING test_instance_id TO STRING ON triggered_alerts'
RAISERROR (@msg, 0, 1) WITH NOWAIT


SET @msg = 'UPDATING test_instance_id TO STRING IN ALL call_result_x TABLES'
RAISERROR (@msg, 0, 1) WITH NOWAIT
/* DELETE index on test_instance_id from call_result_* tables */
DECLARE @qry nvarchar(max);
SELECT @qry = 
(SELECT  'DROP INDEX ' + ix.name + ' ON ' + OBJECT_NAME(ID) + '; '
FROM  sysindexes ix
WHERE   ix.Name IS NOT null AND ix.Name LIKE '%index_call_result_%'
FOR xml path(''));
EXEC sp_executesql @qry
SET @msg = 'DONE DELETING INDEX ON test_instance_id ON ALL call_result_x TABLES'
RAISERROR (@msg, 0, 1) WITH NOWAIT

/* ALTER test_instance_id column
RECREATE index on test_instance_id */
EXEC sp_MSforeachtable 
@command1 = '
ALTER TABLE ? ALTER COLUMN test_instance_id nvarchar(20)
IF NOT EXISTS(SELECT * FROM sys.indexes WHERE name = ''idx_instance_details'' AND object_id = OBJECT_ID(''?''))
BEGIN
  CREATE NONCLUSTERED INDEX idx_instance_details ON ? (test_instance_id, test_id) INCLUDE (category, metric_id, metric_value, details)
  CREATE NONCLUSTERED INDEX idx_metric_results ON ? (test_id, metric_id, created_at) INCLUDE (test_instance_id, metric_type, metric_value, unit)
END
RAISERROR (''DONE ?'', 0, 1) WITH NOWAIT',
@whereand='AND O.name LIKE ''%call_result_%'''


/************************************ INDEXES ON triggered_alerts TABLE ************************************************/
SET @msg = 'CREATING INDEXES ON triggered_alerts TABLE'
RAISERROR (@msg, 0, 1) WITH NOWAIT
IF NOT EXISTS(SELECT * FROM sys.indexes WHERE name = 'idx_test_instance_details' AND object_id = OBJECT_ID('triggered_alerts'))
BEGIN
  CREATE NONCLUSTERED INDEX idx_test_instance_details ON triggered_alerts (test_instance_id, metric_id, severity)
END

IF NOT EXISTS(SELECT * FROM sys.indexes WHERE name = 'idx_triggered_alerts' AND object_id = OBJECT_ID('triggered_alerts'))
BEGIN
  CREATE NONCLUSTERED INDEX idx_triggered_alerts ON triggered_alerts (client_id, created_at)
END
SET @msg = 'DONE INDEXES ON triggered_alerts TABLE'
RAISERROR (@msg, 0, 1) WITH NOWAIT


/******************* DO NOT RUN THE FOLLOWING SPLIT test_instances MORE THAN ONCE ***********************/

/************************************ SPLIT test_instances TABLE ************************************************/
SET @msg = 'SPLITTING test_instances TO MULTIPLE TABLES (PER CLIENT)'
RAISERROR (@msg, 0, 1) WITH NOWAIT
DECLARE @client_id INT
DECLARE @tbl_name NVARCHAR(100)
DECLARE @dbcursor CURSOR

SET @dbcursor = CURSOR FOR
SELECT distinct test_instances.client_id FROM test_instances

OPEN @dbcursor
FETCH NEXT
FROM @dbcursor INTO @client_id
WHILE @@FETCH_STATUS = 0
BEGIN
  SET @tbl_name = 'test_instances_' + CONVERT(nvarchar(3), @client_id)
  SET @msg = 'Processing ' + @tbl_name
  RAISERROR (@msg, 0, 1) WITH NOWAIT

  IF not exists (SELECT * FROM sysobjects WHERE name=@tbl_name AND xtype='U')
  BEGIN
    SET @msg = @tbl_name + ' not found! Creating...'
    RAISERROR (@msg, 0, 1) WITH NOWAIT
    EXEC('CREATE TABLE ' + @tbl_name + ' (
          [id] [int] IDENTITY(1,1) PRIMARY KEY,
          [test_id] [int] NULL,
          [test_instance_id] [nvarchar](20) NULL,
          [client_id] [int] NULL,
          [start_time] [datetime] NULL,
          [end_time] [datetime] NULL,
          [failed] [bit] NULL,
          [total_alerts] [int] NULL,
          [alert_level] [nvarchar](20) NULL,
          [notification_status] [nvarchar](20) NULL,
          [test_instance_status] [nvarchar](50) NULL,
          [call_recording_url] [nvarchar](200) NULL,
          [hammer_server] [nvarchar](50) NULL,
          [hammer_channel] [int] NULL,
          [error_step_name] [nvarchar](50) NULL,
          [error_step_detail] [nvarchar](255) NULL,
          [created_at] [datetime] NULL,
          [updated_at] [datetime] NULL 
        )

        CREATE NONCLUSTERED INDEX idx_test_ids_sorted ON ' + @tbl_name + ' (start_time, end_time) INCLUDE (test_id, failed, created_at)
        CREATE NONCLUSTERED INDEX idx_overall_performance ON ' + @tbl_name + ' (start_time, end_time) INCLUDE (id, failed, total_alerts)
      ')
    SET @msg = @tbl_name + ' created!!'
    RAISERROR (@msg, 0, 1) WITH NOWAIT    
  END

  EXEC('INSERT ' + @tbl_name + ' ([test_id], [test_instance_id], [client_id], [start_time], [end_time], [failed], [total_alerts], [alert_level],
           [notification_status], [test_instance_status], [call_recording_url], [hammer_server], [hammer_channel], [error_step_name], [error_step_detail],
           [created_at], [updated_at]) 
        SELECT [test_id], [test_instance_id], [client_id], [start_time], [end_time], [failed], [total_alerts], [alert_level],
           [notification_status], [test_instance_status], [call_recording_url], [hammer_server], [hammer_channel], [error_step_name], [error_step_detail],
           [created_at], [updated_at]
        FROM test_instances WHERE client_id = ' + @client_id)

  FETCH NEXT
  FROM @dbcursor INTO @client_id
END

CLOSE @dbcursor
DEALLOCATE @dbcursor


/************************************ CHANGE PESQ TO FLOAT ************************************************/
SET @msg = 'UPDATING PESQ TO FLOAT'
RAISERROR (@msg, 0, 1) WITH NOWAIT
UPDATE [dbo].[available_step_metrics] set response_type = 'float' where category = 'PESQ'
UPDATE [dbo].[metrics] set datatype = 'float' where category = 'PESQ'


SET @msg = 'ADD NEW COLUMN client_end_tied ON tests TABLE'
RAISERROR (@msg, 0, 1) WITH NOWAIT
/************************************ DEFAULT FOR client_end_tied ************************************************/
ALTER TABLE tests ADD client_end_tied BIT DEFAULT 1


SET @msg = 'ADD DEFAULT FOR masked ON tests TABLE'
RAISERROR (@msg, 0, 1) WITH NOWAIT
/************************************ DEFAULT FOR masked ************************************************/
ALTER TABLE test_input_params ADD CONSTRAINT DF_masked DEFAULT 0 FOR masked;


SET @msg = 'ADDING email_ids COLUMN IN notification_plans'
RAISERROR (@msg, 0, 1) WITH NOWAIT
/************************************ ADD email_ids TO notification_plans ************************************************/
IF NOT EXISTS(SELECT * FROM sys.columns WHERE name = 'email_ids' AND object_id = OBJECT_ID('notification_plans'))
BEGIN
  ALTER TABLE notification_plans ADD email_ids NVARCHAR(800)
END


SET @msg = 'ADDING min_test_schedule_period_in_minutes COLUMN IN clients'
RAISERROR (@msg, 0, 1) WITH NOWAIT
/************************************ ADD min_test_schedule_period_in_minutes TO clients ************************************************/
IF NOT EXISTS(SELECT * FROM sys.columns WHERE name = 'min_test_schedule_period_in_minutes' AND object_id = OBJECT_ID('clients'))
BEGIN
  ALTER TABLE clients ADD min_test_schedule_period_in_minutes INT NOT NULL DEFAULT 15
END