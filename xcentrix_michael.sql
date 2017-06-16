-- TO LOOP THROUGH THE WHOLE RDB_LOAD_TABLE_DATES AND LOOK FOR ALL tableName STARTING WITH 'LOAD_COMMON_CALL_%'

DECLARE @MyCursor CURSOR;
DECLARE @LoadTableName NVARCHAR(100);
BEGIN
    SET @MyCursor = CURSOR FOR
    SELECT DISTINCT tableName FROM RDB_LOAD_TABLE_DATES 
      WHERE tableName LIKE 'LOAD_COMMON_CALL_%'

    OPEN @MyCursor 
    FETCH NEXT FROM @MyCursor 
    INTO @LoadTableName

    WHILE @@FETCH_STATUS = 0
    BEGIN
      
      DECLARE @date_id_count INT;
      SELECT @date_id_count = (SELECT COUNT(dateid) FROM RDB_LOAD_TABLE_DATES WHERE tableName=@LoadTableName)

      --RAISERROR ('Number of dateid: %d',10,1, @date_id_count) WITH NOWAIT

      -- 1.        LOAD table must have two or more DATEIDs 
      IF @date_id_count > 2
      BEGIN
        DECLARE @processing_count INT;
        SELECT @processing_count = 
                (SELECT COUNT(0) FROM RDB_LOAD_TABLE_DATES 
                  WHERE tableName=@LoadTableName AND status='AWAITING_OLAP_PROCESSING')
        --RAISERROR ('Number of Processing Count: %d',10,1, @processing_count) WITH NOWAIT

        -- 3.      All other entries have status of IN_AGGREGATED_STORAGE
        IF @processing_count = 1
        BEGIN
          DECLARE @last_status NVARCHAR(100);
          SELECT @last_status = (SELECT TOP 1 status FROM RDB_LOAD_TABLE_DATES 
            WHERE tableName=@LoadTableName
            ORDER BY dateid ASC)
          --RAISERROR ('Status of Oldest Call: %s',10,1, @last_status) WITH NOWAIT

          --2.     Only the oldest date entry has status of AWAITING_OLAP_PROCESSING
          IF @last_status = 'AWAITING_OLAP_PROCESSING'
          BEGIN
                        RAISERROR ('Changing Table: %s',10,1, @LoadTableName) WITH NOWAIT
          
            UPDATE RDB_LOAD_TABLE_DATES SET status='IN_AGGREGATED_STORAGE' 
              WHERE tableName=@LoadTableName AND status='AWAITING_OLAP_PROCESSING'
           
          END
        END
      END
      
      FETCH NEXT FROM @MyCursor 
      INTO @LoadTableName 
    END; 

    CLOSE @MyCursor ;
    DEALLOCATE @MyCursor;
END;
