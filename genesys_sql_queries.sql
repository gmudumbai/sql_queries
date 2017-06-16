DECLARE @scenario_name NVARCHAR(255) = 'ShortScriptSaturday'
DECLARE @start_time DATETIME = '2016-03-05 00:00:00.000'
DECLARE @end_time DATETIME = '2016-03-05 23:59:59.997'

/* 1. Total # of distinct scripts that ran */
SELECT DISTINCT ScriptUID FROM VSessionRun
WHERE ScenarioID IN
(SELECT ScenarioID FROM ScenarioDef
WHERE ScenarioName = @scenario_name) AND 
FinishTime BETWEEN @start_time AND @end_time


/* 2. List of distinct scripts that ran and # of times each ran */
SELECT ScriptUID, COUNT(0) num_runs FROM VSessionRun
WHERE ScenarioID IN
(SELECT ScenarioID FROM ScenarioDef
WHERE ScenarioName = @scenario_name) AND 
FinishTime BETWEEN @start_time AND @end_time
GROUP BY ScriptUID


/* 3. List of distinct scripts that only passed */
SELECT distinct vsr.ScriptUID FROM VSessionRun vsr, VCall vc
WHERE vsr.SessionRunID = vc.SessionRunID AND
vsr.ScenarioID IN
(SELECT ScenarioID FROM ScenarioDef
WHERE ScenarioName = @scenario_name) AND 
vsr.FinishTime BETWEEN @start_time AND @end_time
AND vc.CallID = 1
GROUP BY vsr.ScriptUID 
HAVING SUM(CASE WHEN vc.ErrorFlag = 1 THEN 1 ELSE 0 END) = 0


/* 4. List of distinct scripts that failed on all 3 (more than 3 also included) attempts */
SELECT distinct vsr.ScriptUID, COUNT(0) num_failures FROM VSessionRun vsr, VCall vc
WHERE vsr.SessionRunID = vc.SessionRunID AND
vsr.ScenarioID IN
(SELECT ScenarioID FROM ScenarioDef
WHERE ScenarioName = @scenario_name) AND 
vsr.FinishTime BETWEEN @start_time AND @end_time
AND vc.CallID = 1 AND vc.ErrorFlag = 1
GROUP BY vsr.ScriptUID HAVING COUNT(0) > 2


/* 5. List of distinct scripts that failed at least once */
SELECT distinct vsr.ScriptUID, COUNT(0) num_failures FROM VSessionRun vsr, VCall vc
WHERE vsr.SessionRunID = vc.SessionRunID AND
vsr.ScenarioID IN
(SELECT ScenarioID FROM ScenarioDef
WHERE ScenarioName = @scenario_name) AND 
vsr.FinishTime BETWEEN @start_time AND @end_time
AND vc.CallID = 1 AND vc.ErrorFlag = 1
GROUP BY vsr.ScriptUID HAVING COUNT(0) > 0


/* 6. Call Details by scriptUID */
/* Uncomment the last line if all the steps for the call are NOT needed and only the step with error should be displayed */
DECLARE @scriptUID NVARCHAR(255) = 'TOO_SHORT_0001_1_VS.SBX'

SELECT SessionRunID, Label, Mode, ErrorReason FROM VAction WHERE SessionRunID IN(
SELECT vsr.SessionRunID FROM VSessionRun vsr, VCall vc
WHERE vsr.SessionRunID = vc.SessionRunID AND
vsr.ScenarioID IN
(SELECT ScenarioID FROM ScenarioDef
WHERE ScenarioName = @scenario_name) AND 
vsr.FinishTime BETWEEN @start_time AND @end_time
AND vc.CallID = 1 AND vc.ErrorFlag = 1
AND vsr.ScriptUID = @scriptUID
) --AND NULLIF(ErrorReason, '') IS NOT NULL