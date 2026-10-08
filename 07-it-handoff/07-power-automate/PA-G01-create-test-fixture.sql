/*
PA-G01 runtime fixture
Creates one committed RELEASED MaintenanceOccurrence for manual Power Automate testing.
Target: db-omm-dev
Safe: uses unique PA-G01 codes and can be cleaned with PA-G01-cleanup-fixture.sql.
*/
SET NOCOUNT ON;
SET XACT_ABORT ON;

IF DB_NAME()<>N'db-omm-dev'
    THROW 53200,'PA-G01 FIXTURE STOP: current database is not db-omm-dev.',1;

IF EXISTS(SELECT 1 FROM cmms.JobPlan WHERE JobPlanCode=N'PAG01-JP')
    THROW 53201,'PA-G01 FIXTURE STOP: fixture already exists. Run cleanup first.',1;

BEGIN TRANSACTION;
BEGIN TRY
    DECLARE @JobPlanId bigint,@JobPlanRevisionId bigint,@ActivityId bigint,@PlanVersionId bigint,
            @PlanItemId bigint,@PolicyId bigint,@OccurrenceId bigint;

    INSERT cmms.JobPlan(JobPlanCode,Name,CreatedBy)
    VALUES(N'PAG01-JP',N'PA-G01 Manual Flow Test',N'PA-G01');
    SET @JobPlanId=SCOPE_IDENTITY();

    INSERT cmms.JobPlanRevision(JobPlanId,RevisionCode,Title,StatusCode,CreatedBy)
    VALUES(@JobPlanId,N'R1',N'PA-G01 Manual Flow Test',N'PUBLISHED',N'PA-G01');
    SET @JobPlanRevisionId=SCOPE_IDENTITY();

    INSERT cmms.MaintenanceActivity(ActivityCode,Title,DefaultJobPlanRevisionId,SourceBasisCode,CreatedBy)
    VALUES(N'PAG01-ACT',N'PA-G01 Manual Activity',@JobPlanRevisionId,N'PROJECT',N'PA-G01');
    SET @ActivityId=SCOPE_IDENTITY();

    INSERT cmms.ProjectMaintenancePlanVersion(ProjectCode,PlanCode,RevisionCode,StatusCode,CreatedBy)
    VALUES(N'PAG01',N'PAG01-PLAN',N'R1',N'PUBLISHED',N'PA-G01');
    SET @PlanVersionId=SCOPE_IDENTITY();

    INSERT cmms.ProjectMaintenancePlanItem(ProjectMaintenancePlanVersionId,AssetKey,MaintenanceActivityId)
    VALUES(@PlanVersionId,N'PAG01-ASSET-001',@ActivityId);
    SET @PlanItemId=SCOPE_IDENTITY();

    INSERT cmms.MaintenanceTriggerPolicy(ProjectMaintenancePlanItemId,VersionNo,PolicyModeCode,RecurrenceBasisCode,StatusCode)
    VALUES(@PlanItemId,1,N'SIMPLE',N'FIXED_SCHEDULE',N'PUBLISHED');
    SET @PolicyId=SCOPE_IDENTITY();

    INSERT cmms.TriggerRule(TriggerPolicyId,SequenceNo,RuleTypeCode,IntervalValue,IntervalUnitCode,AnchorAt)
    VALUES(@PolicyId,1,N'TIME',1,N'MONTH',SYSUTCDATETIME());

    INSERT cmms.MaintenanceTriggerState(TriggerPolicyId,ConditionStateCode)
    VALUES(@PolicyId,N'NORMAL');

    INSERT cmms.MaintenanceOccurrence(ProjectMaintenancePlanItemId,TriggerPolicyId,EpisodeKey,ReleaseAt,DueAt,StatusCode,OriginReasonCode)
    VALUES(@PlanItemId,@PolicyId,N'PAG01-EP-001',DATEADD(day,-1,SYSUTCDATETIME()),DATEADD(day,7,SYSUTCDATETIME()),N'RELEASED',N'TIME');
    SET @OccurrenceId=SCOPE_IDENTITY();

    UPDATE cmms.MaintenanceTriggerState
    SET OpenMaintenanceOccurrenceId=@OccurrenceId
    WHERE TriggerPolicyId=@PolicyId;

    COMMIT;

    SELECT
        @OccurrenceId AS MaintenanceOccurrenceId,
        N'PAG01-WO-001' AS SuggestedWorkOrderNo,
        N'PAG01-ASSET-001' AS AssetKey,
        N'RELEASED' AS StatusCode;
END TRY
BEGIN CATCH
    IF XACT_STATE()<>0 ROLLBACK;
    THROW;
END CATCH;
