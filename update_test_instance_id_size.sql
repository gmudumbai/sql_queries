EXEC sp_MSforeachtable 
@command1 = '
ALTER TABLE ?
ALTER COLUMN test_instance_id NVARCHAR(100)
RAISERROR (''DONE ?'', 0, 1) WITH NOWAIT',
@whereand='AND O.name LIKE ''%test_instances_%'''


EXEC sp_MSforeachtable 
@command1 = '
ALTER TABLE ?
ALTER COLUMN test_instance_id NVARCHAR(100)
RAISERROR (''DONE ?'', 0, 1) WITH NOWAIT',
@whereand='AND O.name LIKE ''%call_result_%'''

ALTER TABLE triggered_alerts
ALTER COLUMN test_instance_id NVARCHAR(100)

ALTER TABLE hidden_instances
ALTER COLUMN test_instance_id NVARCHAR(100)