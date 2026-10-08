/*
CMMS 2.0 — SP-G01 Runtime Validation
Run AFTER SP-G01-create-procedures.sql
All smoke data rolls back.
*/
SET NOCOUNT ON;
SET XACT_ABORT OFF;

IF DB_NAME()<>N'db-omm-dev'
    THROW 53100,'SP-G01 STOP: current database is not db-omm-dev.',1;

DECLARE @Expected TABLE(ProcedureName sysname PRIMARY KEY);
INSERT @Expected VALUES
(N'usp_WorkOrder_GetJson'),
(N'usp_WorkQueue_ListJson'),
(N'usp_WorkOrder_MaterializeFromOccurrence'),
(N'usp_Planning_SetReadiness'),
(N'usp_Schedule_Commit'),
(N'usp_Execution_Start'),
(N'usp_Execution_Complete'),
(N'usp_WorkOrder_TechnicalClose');

IF EXISTS(
 SELECT 1 FROM @Expected e
 WHERE OBJECT_ID(N'cmms.'+QUOTENAME(e.ProcedureName),N'P') IS NULL
)
BEGIN
 SELECT e.ProcedureName MissingProcedure FROM @Expected e
 WHERE OBJECT_ID(N'cmms.'+QUOTENAME(e.ProcedureName),N'P') IS NULL;
 THROW 53101,'SP-G01 STOP: missing procedure.',1;
END;

IF OBJECT_ID(N'cmms.CommandReceipt',N'U') IS NULL
    THROW 53102,'SP-G01 STOP: CommandReceipt missing.',1;

PRINT 'SP-G01 object inventory: PASS';

BEGIN TRANSACTION;
BEGIN TRY
    DECLARE @JobPlanId bigint,@JobPlanRevisionId bigint,@ActivityId bigint,@PlanVersionId bigint,
            @PlanItemId bigint,@PolicyId bigint,@OccurrenceId bigint;

    INSERT cmms.JobPlan(JobPlanCode,Name,CreatedBy)
    VALUES(N'SPG01-JP',N'SP-G01 Smoke',N'SP-G01');
    SET @JobPlanId=SCOPE_IDENTITY();

    INSERT cmms.JobPlanRevision(JobPlanId,RevisionCode,Title,StatusCode,CreatedBy)
    VALUES(@JobPlanId,N'R1',N'SP-G01 Smoke',N'PUBLISHED',N'SP-G01');
    SET @JobPlanRevisionId=SCOPE_IDENTITY();

    INSERT cmms.MaintenanceActivity(ActivityCode,Title,DefaultJobPlanRevisionId,SourceBasisCode,CreatedBy)
    VALUES(N'SPG01-ACT',N'SP-G01 Activity',@JobPlanRevisionId,N'PROJECT',N'SP-G01');
    SET @ActivityId=SCOPE_IDENTITY();

    INSERT cmms.ProjectMaintenancePlanVersion(ProjectCode,PlanCode,RevisionCode,StatusCode,CreatedBy)
    VALUES(N'SPG01',N'SPG01-PLAN',N'R1',N'PUBLISHED',N'SP-G01');
    SET @PlanVersionId=SCOPE_IDENTITY();

    INSERT cmms.ProjectMaintenancePlanItem(ProjectMaintenancePlanVersionId,AssetKey,MaintenanceActivityId)
    VALUES(@PlanVersionId,N'SPG01-ASSET',@ActivityId);
    SET @PlanItemId=SCOPE_IDENTITY();

    INSERT cmms.MaintenanceTriggerPolicy(ProjectMaintenancePlanItemId,VersionNo,PolicyModeCode,RecurrenceBasisCode,StatusCode)
    VALUES(@PlanItemId,1,N'SIMPLE',N'LAST_COMPLETION',N'PUBLISHED');
    SET @PolicyId=SCOPE_IDENTITY();

    INSERT cmms.TriggerRule(TriggerPolicyId,SequenceNo,RuleTypeCode,IntervalValue,IntervalUnitCode,AnchorAt)
    VALUES(@PolicyId,1,N'TIME',1,N'MONTH',sysutcdatetime());

    INSERT cmms.MaintenanceTriggerState(TriggerPolicyId,ConditionStateCode)
    VALUES(@PolicyId,N'NORMAL');

    INSERT cmms.MaintenanceOccurrence(ProjectMaintenancePlanItemId,TriggerPolicyId,EpisodeKey,ReleaseAt,DueAt,StatusCode,OriginReasonCode)
    VALUES(@PlanItemId,@PolicyId,N'SPG01-EP-1',DATEADD(day,-5,sysutcdatetime()),DATEADD(day,5,sysutcdatetime()),N'RELEASED',N'TIME');
    SET @OccurrenceId=SCOPE_IDENTITY();

    DECLARE @Req nvarchar(max),@R TABLE(ReadState nvarchar(20),ResultJson nvarchar(max),ErrorCode nvarchar(50),ErrorMessage nvarchar(max));

    SET @Req=N'{"requestId":"'+CONVERT(nvarchar(36),NEWID())+N'","actor":"SP-G01","maintenanceOccurrenceId":'+CONVERT(nvarchar(30),@OccurrenceId)+N',"workOrderNo":"SPG01-WO-1"}';
    INSERT @R EXEC cmms.usp_WorkOrder_MaterializeFromOccurrence @Req;
    IF NOT EXISTS(SELECT 1 FROM @R WHERE ReadState='READY') THROW 53110,'Materialize failed.',1;
    DELETE @R;

    DECLARE @WorkOrderId bigint=(SELECT WorkOrderId FROM cmms.WorkOrder WHERE WorkOrderNo=N'SPG01-WO-1');

    SET @Req=N'{"requestId":"'+CONVERT(nvarchar(36),NEWID())+N'","actor":"SP-G01","workOrderId":'+CONVERT(nvarchar(30),@WorkOrderId)+N',"readinessStatusCode":"READY"}';
    INSERT @R EXEC cmms.usp_Planning_SetReadiness @Req;
    IF NOT EXISTS(SELECT 1 FROM @R WHERE ReadState='READY') THROW 53111,'Readiness failed.',1;
    DELETE @R;

    DECLARE @PoolId bigint;
    INSERT cmms.ResourcePool(ResourcePoolCode,Name) VALUES(N'SPG01-RP',N'SP-G01 Pool');
    SET @PoolId=SCOPE_IDENTITY();

    SET @Req=N'{"requestId":"'+CONVERT(nvarchar(36),NEWID())+N'","actor":"SP-G01","workOrderId":'+CONVERT(nvarchar(30),@WorkOrderId)+
             N',"scheduledStart":"2026-10-09T08:00:00","scheduledFinish":"2026-10-09T10:00:00","assignmentTargetType":"RESOURCE_POOL","resourcePoolId":'+CONVERT(nvarchar(30),@PoolId)+N'}';
    INSERT @R EXEC cmms.usp_Schedule_Commit @Req;
    IF NOT EXISTS(SELECT 1 FROM @R WHERE ReadState='READY') THROW 53112,'Schedule failed.',1;
    DELETE @R;

    UPDATE cmms.WorkOrder SET StatusCode='RELEASED_TO_EXECUTION' WHERE WorkOrderId=@WorkOrderId;

    SET @Req=N'{"requestId":"'+CONVERT(nvarchar(36),NEWID())+N'","actor":"SP-G01","workOrderId":'+CONVERT(nvarchar(30),@WorkOrderId)+N',"actualStartAt":"2026-10-09T08:05:00"}';
    INSERT @R EXEC cmms.usp_Execution_Start @Req;
    IF NOT EXISTS(SELECT 1 FROM @R WHERE ReadState='READY') THROW 53113,'Execution start failed.',1;
    DELETE @R;

    SET @Req=N'{"requestId":"'+CONVERT(nvarchar(36),NEWID())+N'","actor":"SP-G01","workOrderId":'+CONVERT(nvarchar(30),@WorkOrderId)+N',"actualFinishAt":"2026-10-09T09:55:00","executionResultCode":"COMPLETED_AS_PLANNED"}';
    INSERT @R EXEC cmms.usp_Execution_Complete @Req;
    IF NOT EXISTS(SELECT 1 FROM @R WHERE ReadState='READY') THROW 53114,'Execution complete failed.',1;
    DELETE @R;

    SET @Req=N'{"requestId":"'+CONVERT(nvarchar(36),NEWID())+N'","actor":"SP-G01","workOrderId":'+CONVERT(nvarchar(30),@WorkOrderId)+N'}';
    INSERT @R EXEC cmms.usp_WorkOrder_TechnicalClose @Req;
    IF NOT EXISTS(SELECT 1 FROM @R WHERE ReadState='READY') THROW 53115,'Technical close failed.',1;

    IF NOT EXISTS(SELECT 1 FROM cmms.WorkOrder WHERE WorkOrderId=@WorkOrderId AND StatusCode='TECHNICALLY_CLOSED')
        THROW 53116,'Final WO state invalid.',1;

    IF NOT EXISTS(SELECT 1 FROM cmms.MaintenanceOccurrence WHERE MaintenanceOccurrenceId=@OccurrenceId AND StatusCode='FULFILLED')
        THROW 53117,'Occurrence was not fulfilled.',1;

    IF NOT EXISTS(SELECT 1 FROM cmms.MaintenanceTriggerState WHERE TriggerPolicyId=@PolicyId AND LastCompletionAt='2026-10-09T09:55:00')
        THROW 53118,'LAST_COMPLETION feedback failed.',1;

    PRINT 'SP-G01 vertical smoke path: PASS';

    ROLLBACK;
    PRINT 'SP-G01 smoke rollback: PASS';
END TRY
BEGIN CATCH
    IF XACT_STATE()<>0 ROLLBACK;
    THROW;
END CATCH;

PRINT 'SP-G01 VALIDATION COMPLETE';
