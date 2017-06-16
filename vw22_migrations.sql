/*********************************************************** BEGIN SPEECH REC ***********************************************************/
ALTER TABLE hammer_groups ADD has_speech_rec BIT DEFAULT 0

ALTER TABLE scripts ADD has_speech_rec BIT DEFAULT 0

SET IDENTITY_INSERT [dbo].[available_step_metrics] ON 
INSERT [dbo].[available_step_metrics] ([id], [action_id], [icon_name], [data_group], [metric_name], [metric_display_name], [description], [category], [response_type], [response_unit], [addl_notes], [display], [metric_type], [created_at], [updated_at]) VALUES (109,167, N'SpeechRec Init', N'RESPONSE', N'IP Address', N'Speech Server Address', N'Speech Server Address', N'IP', N'string', N'none', N'Added in CM 5.10',0,1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP)
INSERT [dbo].[available_step_metrics] ([id], [action_id], [icon_name], [data_group], [metric_name], [metric_display_name], [description], [category], [response_type], [response_unit], [addl_notes], [display], [metric_type], [created_at], [updated_at]) VALUES (110,167, N'SpeechRec Init', N'RESPONSE_LENGTH', N'Time to Execute', N'Response Time', N'Time to enable Speech Recognition', N'Duration', N'integer', N'ms', N'Added in CM 5.10',0,1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP)
INSERT [dbo].[available_step_metrics] ([id], [action_id], [icon_name], [data_group], [metric_name], [metric_display_name], [description], [category], [response_type], [response_unit], [addl_notes], [display], [metric_type], [created_at], [updated_at]) VALUES (111,168, N'SpeechRec Release', N'RESPONSE_LENGTH', N'Time to Execute', N'Response Time', N'Time to release Speech Recognition', N'Duration', N'integer', N'ms', N'Added in CM 5.10',0,1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP)
INSERT [dbo].[available_step_metrics] ([id], [action_id], [icon_name], [data_group], [metric_name], [metric_display_name], [description], [category], [response_type], [response_unit], [addl_notes], [display], [metric_type], [created_at], [updated_at]) VALUES (112,169, N'Recognize Speech', N'RESPONSE', N'Link', N'Prompt', N'Expected and Actual Prompt', N'Recognition URI', N'string', N'none', N'Only logged this way if Save Waveform is YES',1,0,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP)
INSERT [dbo].[available_step_metrics] ([id], [action_id], [icon_name], [data_group], [metric_name], [metric_display_name], [description], [category], [response_type], [response_unit], [addl_notes], [display], [metric_type], [created_at], [updated_at]) VALUES (113,169, N'Recognize Speech', N'RESPONSE', N'Recognized Phrase', N'Recognized Prompt', N'Tag:Prompt', N'Recognition', N'string', N'none', N'Only logged if recognition was successful and Save Waveform is NO',0,1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP)
INSERT [dbo].[available_step_metrics] ([id], [action_id], [icon_name], [data_group], [metric_name], [metric_display_name], [description], [category], [response_type], [response_unit], [addl_notes], [display], [metric_type], [created_at], [updated_at]) VALUES (114,169, N'Recognize Speech', N'RESPONSE_LENGTH', N'Phrase Length', N'Prompt Length', N'Recognized Prompt Length', N'Duration', N'integer', N'ms', N'Includes the length of time it took to analyze the phrase (always reported)',1,1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP)
INSERT [dbo].[available_step_metrics] ([id], [action_id], [icon_name], [data_group], [metric_name], [metric_display_name], [description], [category], [response_type], [response_unit], [addl_notes], [display], [metric_type], [created_at], [updated_at]) VALUES (115,169, N'Recognize Speech', N'RESPONSE_SCORE', N'Confidence Score', N'Confidence Score', N'Confidence Score for Recognition (%)', N'Score', N'integer', N'none', N'Percentage (only if recognized)',1,0,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP)
INSERT [dbo].[available_step_metrics] ([id], [action_id], [icon_name], [data_group], [metric_name], [metric_display_name], [description], [category], [response_type], [response_unit], [addl_notes], [display], [metric_type], [created_at], [updated_at]) VALUES (116,169, N'Recognize Speech', N'RESPONSE_TIME', N'Start Time', N'Response Time', N'Voice Detected after x ms', N'Duration', N'integer', N'ms', N'Icon entry to start of recognition (always reported)',1,0,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP)
INSERT [dbo].[available_step_metrics] ([id], [action_id], [icon_name], [data_group], [metric_name], [metric_display_name], [description], [category], [response_type], [response_unit], [addl_notes], [display], [metric_type], [created_at], [updated_at]) VALUES (117,174, N'Verify Speech', N'RESPONSE', N'Verified Phrase', N'Verified Prompt', N'Tag:Prompt', N'Recognition', N'string', N'none', N'Only logged this way if not verifying any slots',1,0,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP)
INSERT [dbo].[available_step_metrics] ([id], [action_id], [icon_name], [data_group], [metric_name], [metric_display_name], [description], [category], [response_type], [response_unit], [addl_notes], [display], [metric_type], [created_at], [updated_at]) VALUES (118,174, N'Verify Speech', N'RESPONSE', N'Verified Slots', N'Verified Slots', N'Tag;Slot:Value[;Slot:Value...]', N'Recognition Slots', N'string', N'none', N'Only logged this way if verifying one or more slots',1,0,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP)
INSERT [dbo].[available_step_metrics] ([id], [action_id], [icon_name], [data_group], [metric_name], [metric_display_name], [description], [category], [response_type], [response_unit], [addl_notes], [display], [metric_type], [created_at], [updated_at]) VALUES (119,174, N'Verify Speech', N'RESPONSE_LENGTH', N'Phrase Length', N'Prompt Length', N'Verified Prompt Length', N'Duration', N'integer', N'ms', N'Includes the length of time it took to analyze the phrase',0,1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP)
INSERT [dbo].[available_step_metrics] ([id], [action_id], [icon_name], [data_group], [metric_name], [metric_display_name], [description], [category], [response_type], [response_unit], [addl_notes], [display], [metric_type], [created_at], [updated_at]) VALUES (120,174, N'Verify Speech', N'RESPONSE_SCORE', N'Confidence Score', N'Confidence Score', N'Confidence Score for Recognition (%)', N'Score', N'integer', N'none', N'Percentage',0,1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP)
SET IDENTITY_INSERT [dbo].[available_step_metrics] OFF
GO

RAISERROR ('DONE WITH SPEECH REC MIGRATION', 0, 1) WITH NOWAIT
/*********************************************************** END SPEECH REC ***********************************************************/




/*********************************************************** BEGIN SEQUENCE ID ***********************************************************/
--Script to alter the column type
--Modify the @tableName, @columnName, @toType
DECLARE @defaultconstraint sysname
DECLARE @tableName NVARCHAR(20)
DECLARE @columnName NVARCHAR(20)
DECLARE @toType NVARCHAR(20)
SET  @tableName = 'dbo.metrics'
SET @columnName = 'sequence_id'
SET @toType = 'FLOAT'

--Search the constraint
--In the current scenario we have constraints of the pattern metrics_sequ... Using sequ for now
SELECT @defaultconstraint = NAME
FROM sys.default_constraints
WHERE parent_object_id = object_ID(@tableName)  and name like '%sequ%'

-- declare a "DROP" statement to drop that default constraint
DECLARE @DropStmt NVARCHAR(500)
SET @DropStmt = 'ALTER TABLE ' + @tableName + ' DROP CONSTRAINT ' + @defaultconstraint
EXEC(@DropStmt)

-- declare a "Alter" statement to change the column type
DECLARE @AlterStmt NVARCHAR(500)
SET @AlterStmt = 'ALTER TABLE ' + @tableName + ' ALTER COLUMN ' + @columnName + ' '+ @toType
EXEC(@AlterStmt)


/* Adding customLabel to display and sequence_id for sorting*/
ALTER TABLE script_input_params ADD custom_label NVARCHAR(100), sequence_id FLOAT DEFAULT 0.0
GO

RAISERROR ('DONE WITH SEQUENCE ID', 0, 1) WITH NOWAIT
/*********************************************************** END SEQUENCE ID ***********************************************************/




/*********************************************************** BEGIN param datatye ***********************************************************/
ALTER TABLE test_input_params ADD datatype NVARCHAR(100)
GO
UPDATE test_input_params set test_input_params.datatype = script_input_params.datatype from test_input_params, script_input_params where test_input_params.input_param_id = script_input_params.id
GO

RAISERROR ('DONE WITH PARAM DATATYPE', 0, 1) WITH NOWAIT
/*********************************************************** END param datatype ***********************************************************/





/*********************************************************** BEGIN call_result_* changes ***********************************************************/
--Add column recording_url to all call_result tables. 
--Also alter the column metric_value to allow more characters
--Delete and recreate required indexes as well
DECLARE @qry nvarchar(max);
SELECT @qry = 
(SELECT  'DROP INDEX ' + ix.name + ' ON ' + OBJECT_NAME(ID) + '; '
FROM  sysindexes ix
WHERE   ix.Name IS NOT null AND 
(ix.Name LIKE '%idx_metric_results%' OR ix.Name LIKE '%idx_instance_details%')
FOR xml path(''));
EXEC sp_executesql @qry

EXEC sp_MSforeachtable 
@command1 = '
ALTER TABLE ? ADD recording_url NVARCHAR(200)

ALTER TABLE ? ALTER COLUMN step NVARCHAR(100) 

ALTER TABLE ? ALTER COLUMN metric_value NVARCHAR(1000) 
IF NOT EXISTS(SELECT * FROM sys.indexes WHERE name = ''idx_metric_results'' AND object_id = OBJECT_ID(''?''))
BEGIN
  CREATE NONCLUSTERED INDEX idx_metric_results ON ? (test_id, created_at, metric_id) INCLUDE (test_instance_id, category, metric_value, details, metric_type, unit, sequence_id, recording_url)
  CREATE NONCLUSTERED INDEX idx_instance_details ON ? (test_instance_id, test_id) INCLUDE (metric_id, category, metric_value, details, sequence_id, recording_url)
END
RAISERROR (''DONE ?'', 0, 1) WITH NOWAIT',
@whereand='AND O.name LIKE ''%call_result_%'''

GO
/*********************************************************** END call_result_* changes ***********************************************************/





/*********************************************************** BEGIN notification schedule ***********************************************************/
ALTER TABLE tests ADD notifications_present BIT DEFAULT 0
GO
SP_RENAME test_alerts, test_alerts_old
GO
SP_RENAME notifications, notifications_old
GO
SP_RENAME triggered_notifications, triggered_notifications_old
GO
SP_RENAME notification_plans, notification_plans_old
GO
SP_RENAME notification_types, notification_types_old
GO

DROP TABLE client_hammer_group

RAISERROR ('DONE WITH NOTIFICATION SCHEDULE SQL MIGRATION', 0, 1) WITH NOWAIT
/*********************************************************** END notification schedule ***********************************************************/





/*********************************************************** BEGIN partner ***********************************************************/
ALTER TABLE clients ADD client_type NVARCHAR(25) DEFAULT 'Client' NOT NULL, partner_id INT, partner_name NVARCHAR(100), 
partner_end_tied BIT DEFAULT 0 NOT NULL, partner_schedule_tied BIT DEFAULT 0 NOT NULL

RAISERROR ('DONE WITH PARTNER MIGRATION', 0, 1) WITH NOWAIT
/*********************************************************** END partner ***********************************************************/




/*********************************************************** BEGIN index on test_instances ***********************************************************/
EXEC sp_MSforeachtable 
@command1 = '
CREATE NONCLUSTERED INDEX idx_parse_results ON ? (test_id, test_instance_id, test_instance_status) INCLUDE (id)
RAISERROR (''DONE ?'', 0, 1) WITH NOWAIT',
@whereand='AND O.name LIKE ''%test_instances_%'''
/*********************************************************** END index on test_instances ***********************************************************/




/*********************************************************** BEGIN test ***********************************************************/
ALTER TABLE tests ADD running_hidden_retry_count INT

RAISERROR ('DONE WITH FILTERED ERRORS SQL MIGRATION', 0, 1) WITH NOWAIT
/*********************************************************** BEGIN test ***********************************************************/