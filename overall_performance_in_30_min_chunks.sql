DECLARE
    @hours TINYINT,
    @minute_interval TINYINT,
    @start SMALLDATETIME;

SELECT
    @hours = #{duration_in_hrs},
    @minute_interval = #{time_interval},
    @start = '#{retrieval_timestamp.strftime("%F %T")}';
IF exists (SELECT * FROM sysobjects WHERE name='test_instances_#{client_id}' AND xtype='U')
BEGIN
  WITH x AS
  (
  SELECT TOP (@hours * (60 / @minute_interval)) n = ROW_NUMBER() OVER (ORDER BY column_id) FROM msdb.sys.all_columns),
  intervals(boundary) AS
  ( SELECT CONVERT(SMALLDATETIME, DATEADD(MINUTE, (-n * @minute_interval), @start)) FROM x )
  SELECT
    interval = DATEDIFF(second,{d '1970-01-01'},i.boundary),
    total_calls = COUNT(d.id),
    total_passed = COUNT(CASE d.failed WHEN 0 THEN 1 END),
    total_failed = COUNT(CASE d.failed WHEN 1 THEN 1 END),
    total_alerts = SUM(d.total_alerts)
  FROM
      intervals AS i
  LEFT OUTER JOIN
      (dbo.test_instances_#{client_id} AS d
      INNER JOIN (select distinct test_id from schedules) AS s ON d.test_id = s.test_id)
      ON d.start_time >= i.boundary
      AND d.start_time < DATEADD(MINUTE, @minute_interval, i.boundary)
      AND d.end_time IS NOT NULL
  GROUP BY i.boundary
  ORDER BY i.boundary desc;
END
ELSE
BEGIN
  WITH x AS
    (
    SELECT TOP (@hours * (60 / @minute_interval)) n = ROW_NUMBER() OVER (ORDER BY column_id) FROM msdb.sys.all_columns),
    intervals(boundary) AS
    ( SELECT CONVERT(SMALLDATETIME, DATEADD(MINUTE, (-n * @minute_interval), @start)) FROM x )
    SELECT
    interval = DATEDIFF(second,{d '1970-01-01'},i.boundary),
    total_calls = 0,
    total_passed = 0,
    total_failed = 0,
    total_alerts = 0
    FROM
      intervals AS i
    GROUP BY i.boundary
    ORDER BY i.boundary desc;
END