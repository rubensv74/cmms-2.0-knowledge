/*
CMMS 2.0 — DB-G01 Runtime Validation
Target: db-omm-dev
Run AFTER DB-G01-create-core.sql
Safe smoke-test data is wrapped in a transaction and rolled back.
*/

SET NOCOUNT ON;
SET XACT_ABORT OFF;

PRINT 'DB-G01 VALIDATION START';

IF DB_NAME() <> N'db-omm-dev'
    THROW 51001, 'DB-G01 STOP: current database is not db-omm-dev.', 1;

IF SCHEMA_ID(N'cmms') IS NULL
    THROW 51002, 'DB-G01 STOP: schema cmms does not exist.', 1;

DECLARE @ExpectedTables TABLE (TableName sysname PRIMARY KEY);
INSERT INTO @ExpectedTables(TableName) VALUES
(N'SourceReference'),(N'JobPlan'),(N'JobPlanRevision'),(N'JobPlanOperation'),
(N'ResourceRequirement'),(N'ToolRequirement'),(N'MaterialRequirement'),
(N'MaintenanceActivity'),(N'ProjectMaintenancePlanVersion'),(N'ProjectMaintenancePlanItem'),
(N'MeasurementPoint'),(N'MeasurementReading'),(N'MaintenanceTriggerPolicy'),(N'TriggerRule'),
(N'MaintenanceTriggerState'),(N'MaintenanceOccurrence'),(N'MaintenanceDueEvent'),
(N'WorkOrder'),(N'PlanningPackage'),(N'WorkConstraint'),(N'ReadinessAssessment'),
(N'OperationalCalendar'),(N'ShiftCalendar'),(N'ResourcePool'),(N'Crew'),(N'CapacityBucket'),
(N'ScheduleAssignment'),(N'ScheduleRevision'),(N'ExecutionRecord'),(N'LaborActual'),
(N'MaterialActual'),(N'ToolActual'),(N'ServiceActual'),(N'ChecklistResult'),
(N'ExecutionFinding'),(N'FollowUpWorkOrderLink'),(N'WorkOrderClosure');

IF EXISTS (
    SELECT 1
    FROM @ExpectedTables e
    WHERE OBJECT_ID(N'cmms.' + QUOTENAME(e.TableName), N'U') IS NULL
)
BEGIN
    SELECT e.TableName AS MissingTable
    FROM @ExpectedTables e
    WHERE OBJECT_ID(N'cmms.' + QUOTENAME(e.TableName), N'U') IS NULL;
    THROW 51003, 'DB-G01 STOP: one or more expected tables are missing.', 1;
END;

SELECT COUNT(*) AS CoreTableCount
FROM sys.tables t
JOIN sys.schemas s ON s.schema_id=t.schema_id
WHERE s.name=N'cmms'
  AND t.name IN (SELECT TableName FROM @ExpectedTables);

IF EXISTS (
    SELECT 1
    FROM sys.foreign_keys fk
    JOIN sys.tables t ON t.object_id=fk.parent_object_id
    JOIN sys.schemas s ON s.schema_id=t.schema_id
    WHERE s.name=N'cmms'
      AND t.name IN (SELECT TableName FROM @ExpectedTables)
      AND fk.is_not_trusted=1
)
    THROW 51004, 'DB-G01 STOP: untrusted foreign key detected.', 1;

IF EXISTS (
    SELECT 1
    FROM sys.check_constraints ck
    JOIN sys.tables t ON t.object_id=ck.parent_object_id
    JOIN sys.schemas s ON s.schema_id=t.schema_id
    WHERE s.name=N'cmms'
      AND t.name IN (SELECT TableName FROM @ExpectedTables)
      AND ck.is_not_trusted=1
)
    THROW 51005, 'DB-G01 STOP: untrusted check constraint detected.', 1;

IF EXISTS (
    SELECT 1 FROM sys.database_principals
    WHERE name LIKE N'cmms[_]db[_]g01%'
)
    THROW 51006, 'DB-G01 STOP: unexpected DB-G01 principal detected.', 1;

PRINT 'Metadata checks: PASS';

BEGIN TRANSACTION;
BEGIN TRY
    DECLARE @JobPlanId bigint, @JobPlanRevisionId bigint, @ActivityId bigint,
            @PlanVersionId bigint, @PlanItemId bigint, @PolicyId bigint,
            @OccurrenceId bigint, @WorkOrderId bigint, @ResourcePoolId bigint;

    INSERT cmms.JobPlan(JobPlanCode,Name,CreatedBy)
    VALUES(N'DBG01-JP',N'DB-G01 Smoke Job Plan',N'DB-G01');
    SET @JobPlanId=SCOPE_IDENTITY();

    INSERT cmms.JobPlanRevision(JobPlanId,RevisionCode,Title,StatusCode,CreatedBy)
    VALUES(@JobPlanId,N'R1',N'DB-G01 Smoke Revision',N'PUBLISHED',N'DB-G01');
    SET @JobPlanRevisionId=SCOPE_IDENTITY();

    INSERT cmms.JobPlanOperation(JobPlanRevisionId,SequenceNo,InstructionDetail)
    VALUES(@JobPlanRevisionId,10,N'Smoke operation');

    INSERT cmms.MaintenanceActivity
        (ActivityCode,Title,DefaultJobPlanRevisionId,SourceBasisCode,CreatedBy)
    VALUES(N'DBG01-ACT',N'DB-G01 Smoke Activity',@JobPlanRevisionId,N'PROJECT',N'DB-G01');
    SET @ActivityId=SCOPE_IDENTITY();

    INSERT cmms.ProjectMaintenancePlanVersion
        (ProjectCode,PlanCode,RevisionCode,StatusCode,CreatedBy)
    VALUES(N'DBG01',N'DBG01-PLAN',N'R1',N'PUBLISHED',N'DB-G01');
    SET @PlanVersionId=SCOPE_IDENTITY();

    INSERT cmms.ProjectMaintenancePlanItem
        (ProjectMaintenancePlanVersionId,AssetKey,MaintenanceActivityId)
    VALUES(@PlanVersionId,N'DBG01-ASSET',@ActivityId);
    SET @PlanItemId=SCOPE_IDENTITY();

    INSERT cmms.MaintenanceTriggerPolicy
        (ProjectMaintenancePlanItemId,VersionNo,PolicyModeCode,RecurrenceBasisCode,StatusCode)
    VALUES(@PlanItemId,1,N'SIMPLE',N'FIXED_SCHEDULE',N'PUBLISHED');
    SET @PolicyId=SCOPE_IDENTITY();

    INSERT cmms.TriggerRule
        (TriggerPolicyId,SequenceNo,RuleTypeCode,IntervalValue,IntervalUnitCode,AnchorAt)
    VALUES(@PolicyId,1,N'TIME',1,N'MONTH',SYSUTCDATETIME());

    INSERT cmms.MaintenanceTriggerState(TriggerPolicyId,ConditionStateCode)
    VALUES(@PolicyId,N'NORMAL');

    INSERT cmms.MaintenanceOccurrence
        (ProjectMaintenancePlanItemId,TriggerPolicyId,EpisodeKey,ReleaseAt,DueAt,StatusCode,OriginReasonCode)
    VALUES(@PlanItemId,@PolicyId,N'DBG01-EP-1',DATEADD(day,-7,SYSUTCDATETIME()),SYSUTCDATETIME(),N'RELEASED',N'TIME');
    SET @OccurrenceId=SCOPE_IDENTITY();

    INSERT cmms.WorkOrder
        (WorkOrderNo,WorkOrderTypeCode,AssetKey,MaintenanceOccurrenceId,MaintenanceActivityId,
         ProjectMaintenancePlanItemId,EffectiveJobPlanRevisionId,StatusCode,PlannedDueAt,CreatedBy)
    VALUES(N'DBG01-WO-1',N'PREVENTIVE',N'DBG01-ASSET',@OccurrenceId,@ActivityId,
           @PlanItemId,@JobPlanRevisionId,N'PLANNING',SYSUTCDATETIME(),N'DB-G01');
    SET @WorkOrderId=SCOPE_IDENTITY();

    INSERT cmms.PlanningPackage
        (WorkOrderId,RevisionNo,ReadinessStatusCode,CreatedBy)
    VALUES(@WorkOrderId,1,N'READY',N'DB-G01');

    INSERT cmms.ResourcePool(ResourcePoolCode,Name)
    VALUES(N'DBG01-RP',N'DB-G01 Resource Pool');
    SET @ResourcePoolId=SCOPE_IDENTITY();

    INSERT cmms.ScheduleAssignment
        (WorkOrderId,ScheduledStart,ScheduledFinish,AssignmentTargetType,ResourcePoolId,
         StatusCode,RevisionNo,ScheduledBy)
    VALUES(@WorkOrderId,SYSUTCDATETIME(),DATEADD(hour,2,SYSUTCDATETIME()),
           N'RESOURCE_POOL',@ResourcePoolId,N'COMMITTED',1,N'DB-G01');

    INSERT cmms.ExecutionRecord
        (WorkOrderId,ActualStartAt,ActualFinishAt,ExecutionResultCode,
         ExecutionSubmittedAt,SubmittedBy,ValidationStatusCode,ValidatedAt,ValidatedBy,FeedbackCapturedAt)
    VALUES(@WorkOrderId,DATEADD(hour,-2,SYSUTCDATETIME()),DATEADD(hour,-1,SYSUTCDATETIME()),
           N'COMPLETED_AS_PLANNED',SYSUTCDATETIME(),N'DB-G01',N'VALIDATED',
           SYSUTCDATETIME(),N'DB-G01',SYSUTCDATETIME());

    PRINT 'Positive smoke path: PASS';

    BEGIN TRY
        INSERT cmms.MaintenanceOccurrence
            (ProjectMaintenancePlanItemId,TriggerPolicyId,EpisodeKey,ReleaseAt,DueAt,StatusCode,OriginReasonCode)
        VALUES(@PlanItemId,@PolicyId,N'DBG01-EP-1',SYSUTCDATETIME(),DATEADD(day,1,SYSUTCDATETIME()),N'RELEASED',N'TIME');
        THROW 51101, 'TEST FAIL: duplicate MaintenanceOccurrence episode was accepted.', 1;
    END TRY
    BEGIN CATCH
        IF ERROR_NUMBER() = 51101 THROW;
        PRINT 'Duplicate occurrence rejection: PASS';
    END CATCH;

    BEGIN TRY
        INSERT cmms.WorkOrder
            (WorkOrderNo,WorkOrderTypeCode,AssetKey,MaintenanceOccurrenceId,StatusCode,CreatedBy)
        VALUES(N'DBG01-WO-2',N'PREVENTIVE',N'DBG01-ASSET',@OccurrenceId,N'PLANNING',N'DB-G01');
        THROW 51102, 'TEST FAIL: second WorkOrder for same occurrence was accepted.', 1;
    END TRY
    BEGIN CATCH
        IF ERROR_NUMBER() = 51102 THROW;
        PRINT 'One WO per occurrence rejection: PASS';
    END CATCH;

    BEGIN TRY
        INSERT cmms.PlanningPackage(WorkOrderId,RevisionNo,ReadinessStatusCode,IsCurrent,CreatedBy)
        VALUES(@WorkOrderId,2,N'READY',1,N'DB-G01');
        THROW 51103, 'TEST FAIL: second current PlanningPackage was accepted.', 1;
    END TRY
    BEGIN CATCH
        IF ERROR_NUMBER() = 51103 THROW;
        PRINT 'Single current PlanningPackage rejection: PASS';
    END CATCH;

    BEGIN TRY
        INSERT cmms.ScheduleAssignment
            (WorkOrderId,ScheduledStart,ScheduledFinish,AssignmentTargetType,ResourcePoolId,
             StatusCode,RevisionNo,IsCurrent,ScheduledBy)
        VALUES(@WorkOrderId,SYSUTCDATETIME(),DATEADD(hour,1,SYSUTCDATETIME()),
               N'RESOURCE_POOL',@ResourcePoolId,N'COMMITTED',2,1,N'DB-G01');
        THROW 51104, 'TEST FAIL: second current ScheduleAssignment was accepted.', 1;
    END TRY
    BEGIN CATCH
        IF ERROR_NUMBER() = 51104 THROW;
        PRINT 'Single current ScheduleAssignment rejection: PASS';
    END CATCH;

    BEGIN TRY
        INSERT cmms.ExecutionRecord(WorkOrderId,ActualStartAt,ActualFinishAt,ValidationStatusCode)
        VALUES(-999, SYSUTCDATETIME(), DATEADD(hour,-1,SYSUTCDATETIME()), N'PENDING');
        THROW 51105, 'TEST FAIL: invalid execution interval was accepted.', 1;
    END TRY
    BEGIN CATCH
        IF ERROR_NUMBER() = 51105 THROW;
        PRINT 'Invalid execution interval rejection: PASS';
    END CATCH;

    ROLLBACK TRANSACTION;
    PRINT 'Smoke test rollback: PASS';
END TRY
BEGIN CATCH
    IF XACT_STATE() <> 0 ROLLBACK TRANSACTION;
    THROW;
END CATCH;

SELECT
    s.name AS SchemaName,
    t.name AS TableName,
    SUM(CASE WHEN i.index_id > 0 THEN 1 ELSE 0 END) AS IndexRows
FROM sys.tables t
JOIN sys.schemas s ON s.schema_id=t.schema_id
LEFT JOIN sys.indexes i ON i.object_id=t.object_id
WHERE s.name=N'cmms'
  AND t.name IN (SELECT TableName FROM @ExpectedTables)
GROUP BY s.name,t.name
ORDER BY t.name;

PRINT 'DB-G01 VALIDATION COMPLETE';
