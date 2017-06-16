DECLARE @days_before VARCHAR(3) = '365'


/* CALL RESULTS TABLES */
DECLARE @call_results_sql NVARCHAR(500)
SET @call_results_sql = '
	DELETE
	 FROM ? WHERE updated_at < DATEADD(hh, -(''' +@days_before+''' * 24), GETUTCDATE())
	RAISERROR (''DONE ?'', 0, 1) WITH NOWAIT'
EXEC sp_MSforeachtable 
@command1 = @call_results_sql,
@whereand='AND O.name LIKE ''%call_result_%'''




/* TEST INSTANCES TABLES */
DECLARE @test_instance_sql NVARCHAR(500)
SET @test_instance_sql = '
	DELETE
	 FROM ? WHERE updated_at < DATEADD(hh, -(''' +@days_before+''' * 24), GETUTCDATE())
	RAISERROR (''DONE ?'', 0, 1) WITH NOWAIT'
EXEC sp_MSforeachtable 
@command1 = @test_instance_sql,
@whereand='AND O.name LIKE ''%test_instances_%'''



/* TRIGGERED ALERT TABLE */
DELETE 
FROM triggered_alerts WHERE updated_at < DATEADD(hh, -(@days_before * 24), GETUTCDATE())




/* AUDIT LOG TABLE */
DELETE 
FROM audit_logs WHERE updated_at < DATEADD(hh, -(@days_before * 24), GETUTCDATE())