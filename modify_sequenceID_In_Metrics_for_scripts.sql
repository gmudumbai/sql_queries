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
--In the current scenario we have contsraints of the pattern metrics_sequ... Using sequ for now
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
