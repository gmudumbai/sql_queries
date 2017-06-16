CREATE TABLE #all_test_instances(
	[id] [int] IDENTITY(1,1) NOT NULL,
	[test_id] [int] NULL,
	[test_instance_id] [nvarchar](20) NULL,
	[client_id] [int] NULL,
	[start_time] [datetime] NULL,
	[end_time] [datetime] NULL,
	[failed] [bit] NULL,
	[alert_level] [nvarchar](20) NULL,
	[hammer_server] [nvarchar](50) NULL,
	[hammer_channel] [int] NULL,
	[error_step_name] [nvarchar](50) NULL,
	[error_step_detail] [nvarchar](255) NULL
);

EXEC sp_MSforeachtable 
@command1 = '
INSERT INTO #all_test_instances 
SELECT test_id, test_instance_id, client_id, start_time, end_time, failed, alert_level, hammer_server, hammer_channel, error_step_name, error_step_detail
FROM ? WHERE created_at >= DATEADD(hh, -168, GETUTCDATE()) AND failed = 1 
PRINT ''DONE ?''',
@whereand='AND O.name LIKE ''%test_instances_%'''

SELECT * FROM #all_test_instances


If(OBJECT_ID('tempdb..#all_test_instances') Is Not Null)
Begin
    Drop Table #all_test_instances
End
