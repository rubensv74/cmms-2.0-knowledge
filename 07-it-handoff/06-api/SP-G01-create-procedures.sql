/*
CMMS 2.0 — SP-G01
Core Stored Procedures for Power Automate
Target: db-omm-dev / cmms
*/

SET NOCOUNT ON;
SET XACT_ABORT ON;
GO

IF OBJECT_ID(N'cmms.CommandReceipt', N'U') IS NULL
BEGIN
    CREATE TABLE cmms.CommandReceipt (
        CommandReceiptId bigint IDENTITY(1,1) NOT NULL CONSTRAINT PK_CommandReceipt PRIMARY KEY,
        RequestId uniqueidentifier NOT NULL,
        ProcedureName sysname NOT NULL,
        Actor nvarchar(200) NOT NULL,
        RequestHash varbinary(32) NULL,
        ResultJson nvarchar(max) NULL,
        StatusCode nvarchar(20) NOT NULL,
        CreatedAt datetime2(3) NOT NULL CONSTRAINT DF_CommandReceipt_CreatedAt DEFAULT(sysutcdatetime()),
        CompletedAt datetime2(3) NULL,
        CONSTRAINT UQ_CommandReceipt_RequestId UNIQUE(RequestId),
        CONSTRAINT CK_CommandReceipt_Status CHECK(StatusCode IN ('STARTED','COMPLETED','FAILED'))
    );
END;
GO

CREATE OR ALTER PROCEDURE cmms.usp_WorkOrder_GetJson
    @RequestJson nvarchar(max)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @WorkOrderId bigint = TRY_CONVERT(bigint, JSON_VALUE(@RequestJson,'$.workOrderId'));

    IF @WorkOrderId IS NULL
    BEGIN
        SELECT N'ERROR' ReadState, NULL ResultJson, N'CMMS-400' ErrorCode,
               N'workOrderId is required.' ErrorMessage;
        RETURN;
    END;

    IF NOT EXISTS (SELECT 1 FROM cmms.WorkOrder WHERE WorkOrderId=@WorkOrderId)
    BEGIN
        SELECT N'ERROR' ReadState, NULL ResultJson, N'CMMS-404' ErrorCode,
               N'WorkOrder not found.' ErrorMessage;
        RETURN;
    END;

    DECLARE @Result nvarchar(max);

    SELECT @Result = (
        SELECT
            wo.WorkOrderId,
            wo.WorkOrderNo,
            wo.WorkOrderTypeCode,
            wo.AssetKey,
            wo.StatusCode,
            wo.PriorityCode,
            wo.PlannedDueAt,
            wo.PlannedDurationHours,
            wo.MaintenanceOccurrenceId,
            wo.MaintenanceActivityId,
            wo.ProjectMaintenancePlanItemId,
            wo.EffectiveJobPlanRevisionId,
            mo.ReleaseAt,
            mo.DueAt,
            ma.ActivityCode,
            ma.Title AS ActivityTitle,
            jp.JobPlanCode,
            jpr.RevisionCode AS JobPlanRevisionCode,
            er.ActualStartAt,
            er.ActualFinishAt,
            er.ExecutionResultCode,
            er.ValidationStatusCode,
            wc.TechnicalClosedAt,
            wc.DataQualityStatusCode,
            (
                SELECT COUNT(*)
                FROM cmms.ExecutionFinding f
                WHERE f.WorkOrderId=wo.WorkOrderId
                  AND f.StatusCode NOT IN ('WAIVED','CLOSED')
            ) AS OpenFindingCount
        FROM cmms.WorkOrder wo
        LEFT JOIN cmms.MaintenanceOccurrence mo ON mo.MaintenanceOccurrenceId=wo.MaintenanceOccurrenceId
        LEFT JOIN cmms.MaintenanceActivity ma ON ma.MaintenanceActivityId=wo.MaintenanceActivityId
        LEFT JOIN cmms.JobPlanRevision jpr ON jpr.JobPlanRevisionId=wo.EffectiveJobPlanRevisionId
        LEFT JOIN cmms.JobPlan jp ON jp.JobPlanId=jpr.JobPlanId
        LEFT JOIN cmms.ExecutionRecord er ON er.WorkOrderId=wo.WorkOrderId
        LEFT JOIN cmms.WorkOrderClosure wc ON wc.WorkOrderId=wo.WorkOrderId
        WHERE wo.WorkOrderId=@WorkOrderId
        FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
    );

    SELECT N'READY' ReadState, @Result ResultJson, N'' ErrorCode, N'' ErrorMessage;
END;
GO

CREATE OR ALTER PROCEDURE cmms.usp_WorkQueue_ListJson
    @RequestJson nvarchar(max)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @StatusCode nvarchar(30)=NULLIF(JSON_VALUE(@RequestJson,'$.statusCode'),N'');
    DECLARE @AssetKey nvarchar(100)=NULLIF(JSON_VALUE(@RequestJson,'$.assetKey'),N'');
    DECLARE @Top int=COALESCE(TRY_CONVERT(int,JSON_VALUE(@RequestJson,'$.top')),100);

    IF @Top < 1 SET @Top=1;
    IF @Top > 500 SET @Top=500;

    DECLARE @Result nvarchar(max);

    SELECT @Result = (
        SELECT TOP (@Top)
            wo.WorkOrderId,
            wo.WorkOrderNo,
            wo.WorkOrderTypeCode,
            wo.AssetKey,
            wo.StatusCode,
            wo.PriorityCode,
            wo.PlannedDueAt,
            mo.ReleaseAt,
            mo.DueAt,
            sa.ScheduledStart,
            sa.ScheduledFinish,
            sa.AssignmentTargetType,
            pp.ReadinessStatusCode
        FROM cmms.WorkOrder wo
        LEFT JOIN cmms.MaintenanceOccurrence mo ON mo.MaintenanceOccurrenceId=wo.MaintenanceOccurrenceId
        LEFT JOIN cmms.ScheduleAssignment sa ON sa.WorkOrderId=wo.WorkOrderId AND sa.IsCurrent=1
        LEFT JOIN cmms.PlanningPackage pp ON pp.WorkOrderId=wo.WorkOrderId AND pp.IsCurrent=1
        WHERE (@StatusCode IS NULL OR wo.StatusCode=@StatusCode)
          AND (@AssetKey IS NULL OR wo.AssetKey=@AssetKey)
        ORDER BY COALESCE(mo.DueAt,wo.PlannedDueAt),wo.WorkOrderId
        FOR JSON PATH
    );

    SELECT N'READY' ReadState, COALESCE(@Result,N'[]') ResultJson, N'' ErrorCode, N'' ErrorMessage;
END;
GO

CREATE OR ALTER PROCEDURE cmms.usp_WorkOrder_MaterializeFromOccurrence
    @RequestJson nvarchar(max)
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    DECLARE @RequestId uniqueidentifier=TRY_CONVERT(uniqueidentifier,JSON_VALUE(@RequestJson,'$.requestId'));
    DECLARE @Actor nvarchar(200)=NULLIF(JSON_VALUE(@RequestJson,'$.actor'),N'');
    DECLARE @OccurrenceId bigint=TRY_CONVERT(bigint,JSON_VALUE(@RequestJson,'$.maintenanceOccurrenceId'));
    DECLARE @WorkOrderNo nvarchar(100)=NULLIF(JSON_VALUE(@RequestJson,'$.workOrderNo'),N'');

    IF @RequestId IS NULL OR @Actor IS NULL OR @OccurrenceId IS NULL OR @WorkOrderNo IS NULL
    BEGIN
        SELECT N'ERROR' ReadState,NULL ResultJson,N'CMMS-400' ErrorCode,
               N'requestId, actor, maintenanceOccurrenceId and workOrderNo are required.' ErrorMessage;
        RETURN;
    END;

    DECLARE @ExistingResult nvarchar(max);

    SELECT @ExistingResult=ResultJson
    FROM cmms.CommandReceipt
    WHERE RequestId=@RequestId AND StatusCode='COMPLETED';

    IF @ExistingResult IS NOT NULL
    BEGIN
        SELECT N'READY' ReadState,@ExistingResult ResultJson,N'' ErrorCode,N'' ErrorMessage;
        RETURN;
    END;

    BEGIN TRY
        BEGIN TRANSACTION;

        IF EXISTS (SELECT 1 FROM cmms.CommandReceipt WITH (UPDLOCK,HOLDLOCK) WHERE RequestId=@RequestId)
        BEGIN
            SELECT @ExistingResult=ResultJson
            FROM cmms.CommandReceipt
            WHERE RequestId=@RequestId AND StatusCode='COMPLETED';

            IF @ExistingResult IS NOT NULL
            BEGIN
                COMMIT;
                SELECT N'READY' ReadState,@ExistingResult ResultJson,N'' ErrorCode,N'' ErrorMessage;
                RETURN;
            END;

            THROW 53001, 'RequestId already exists but is not completed.', 1;
        END;

        INSERT cmms.CommandReceipt(RequestId,ProcedureName,Actor,StatusCode)
        VALUES(@RequestId,N'cmms.usp_WorkOrder_MaterializeFromOccurrence',@Actor,N'STARTED');

        DECLARE
            @PlanItemId bigint,
            @ActivityId bigint,
            @AssetKey nvarchar(100),
            @DueAt datetime2(3),
            @OccurrenceStatus nvarchar(20),
            @JobPlanRevisionId bigint,
            @WorkOrderId bigint;

        SELECT
            @PlanItemId=mo.ProjectMaintenancePlanItemId,
            @DueAt=mo.DueAt,
            @OccurrenceStatus=mo.StatusCode,
            @AssetKey=pi.AssetKey,
            @ActivityId=pi.MaintenanceActivityId,
            @JobPlanRevisionId=COALESCE(pi.JobPlanRevisionOverrideId,ma.DefaultJobPlanRevisionId)
        FROM cmms.MaintenanceOccurrence mo WITH (UPDLOCK,HOLDLOCK)
        JOIN cmms.ProjectMaintenancePlanItem pi ON pi.ProjectMaintenancePlanItemId=mo.ProjectMaintenancePlanItemId
        JOIN cmms.MaintenanceActivity ma ON ma.MaintenanceActivityId=pi.MaintenanceActivityId
        WHERE mo.MaintenanceOccurrenceId=@OccurrenceId;

        IF @PlanItemId IS NULL THROW 53004,'MaintenanceOccurrence not found.',1;
        IF @OccurrenceStatus IN ('CANCELLED','SUPERSEDED','FULFILLED')
            THROW 53009,'MaintenanceOccurrence is not materializable in its current state.',1;

        SELECT @WorkOrderId=WorkOrderId
        FROM cmms.WorkOrder
        WHERE MaintenanceOccurrenceId=@OccurrenceId;

        IF @WorkOrderId IS NULL
        BEGIN
            INSERT cmms.WorkOrder
                (WorkOrderNo,WorkOrderTypeCode,AssetKey,MaintenanceOccurrenceId,MaintenanceActivityId,
                 ProjectMaintenancePlanItemId,EffectiveJobPlanRevisionId,StatusCode,PlannedDueAt,
                 PlannedDurationHours,CreatedBy)
            SELECT
                @WorkOrderNo,N'PREVENTIVE',@AssetKey,@OccurrenceId,@ActivityId,@PlanItemId,
                @JobPlanRevisionId,N'PLANNING',@DueAt,jpr.PlannedTotalDurationHours,@Actor
            FROM (VALUES(1)) v(x)
            LEFT JOIN cmms.JobPlanRevision jpr ON jpr.JobPlanRevisionId=@JobPlanRevisionId;

            SET @WorkOrderId=SCOPE_IDENTITY();

            UPDATE cmms.MaintenanceOccurrence
            SET StatusCode='MATERIALIZED'
            WHERE MaintenanceOccurrenceId=@OccurrenceId
              AND StatusCode IN ('RELEASED','DUE','OVERDUE');
        END;

        DECLARE @Result nvarchar(max)=(
            SELECT @WorkOrderId WorkOrderId,@OccurrenceId MaintenanceOccurrenceId,@WorkOrderNo WorkOrderNo
            FOR JSON PATH,WITHOUT_ARRAY_WRAPPER
        );

        UPDATE cmms.CommandReceipt
        SET ResultJson=@Result,StatusCode='COMPLETED',CompletedAt=sysutcdatetime()
        WHERE RequestId=@RequestId;

        COMMIT;
        SELECT N'READY' ReadState,@Result ResultJson,N'' ErrorCode,N'' ErrorMessage;
    END TRY
    BEGIN CATCH
        IF XACT_STATE()<>0 ROLLBACK;
        DECLARE @Msg nvarchar(2048)=ERROR_MESSAGE();
        SELECT N'ERROR' ReadState,NULL ResultJson,
               CASE WHEN ERROR_NUMBER() IN (53004) THEN N'CMMS-404'
                    WHEN ERROR_NUMBER() IN (53001,53009,2601,2627) THEN N'CMMS-409'
                    ELSE N'CMMS-500' END ErrorCode,
               @Msg ErrorMessage;
    END CATCH
END;
GO

CREATE OR ALTER PROCEDURE cmms.usp_Planning_SetReadiness
    @RequestJson nvarchar(max)
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    DECLARE @RequestId uniqueidentifier=TRY_CONVERT(uniqueidentifier,JSON_VALUE(@RequestJson,'$.requestId'));
    DECLARE @Actor nvarchar(200)=NULLIF(JSON_VALUE(@RequestJson,'$.actor'),N'');
    DECLARE @WorkOrderId bigint=TRY_CONVERT(bigint,JSON_VALUE(@RequestJson,'$.workOrderId'));
    DECLARE @Readiness nvarchar(30)=JSON_VALUE(@RequestJson,'$.readinessStatusCode');
    DECLARE @Notes nvarchar(max)=JSON_VALUE(@RequestJson,'$.plannerNotes');

    IF @RequestId IS NULL OR @Actor IS NULL OR @WorkOrderId IS NULL
       OR @Readiness NOT IN ('NOT_READY','READY_WITH_WARNINGS','READY')
    BEGIN
        SELECT N'ERROR' ReadState,NULL ResultJson,N'CMMS-400' ErrorCode,N'Invalid readiness request.' ErrorMessage;
        RETURN;
    END;

    BEGIN TRY
        BEGIN TRANSACTION;

        DECLARE @Existing nvarchar(max);
        SELECT @Existing=ResultJson FROM cmms.CommandReceipt WITH (UPDLOCK,HOLDLOCK)
        WHERE RequestId=@RequestId AND StatusCode='COMPLETED';
        IF @Existing IS NOT NULL
        BEGIN
            COMMIT;
            SELECT N'READY' ReadState,@Existing ResultJson,N'' ErrorCode,N'' ErrorMessage;
            RETURN;
        END;

        IF NOT EXISTS(SELECT 1 FROM cmms.CommandReceipt WHERE RequestId=@RequestId)
            INSERT cmms.CommandReceipt(RequestId,ProcedureName,Actor,StatusCode)
            VALUES(@RequestId,N'cmms.usp_Planning_SetReadiness',@Actor,N'STARTED');

        DECLARE @CurrentRevision int,@WorkStatus nvarchar(30);
        SELECT @WorkStatus=StatusCode FROM cmms.WorkOrder WITH(UPDLOCK,HOLDLOCK) WHERE WorkOrderId=@WorkOrderId;
        IF @WorkStatus IS NULL THROW 53014,'WorkOrder not found.',1;
        IF @WorkStatus NOT IN ('PLANNING','READY') THROW 53019,'WorkOrder cannot change readiness in current state.',1;

        SELECT @CurrentRevision=MAX(RevisionNo) FROM cmms.PlanningPackage WHERE WorkOrderId=@WorkOrderId;

        UPDATE cmms.PlanningPackage SET IsCurrent=0
        WHERE WorkOrderId=@WorkOrderId AND IsCurrent=1;

        INSERT cmms.PlanningPackage(WorkOrderId,RevisionNo,PlannerNotes,ReadinessStatusCode,IsCurrent,CreatedBy)
        VALUES(@WorkOrderId,COALESCE(@CurrentRevision,0)+1,@Notes,@Readiness,1,@Actor);

        UPDATE cmms.WorkOrder
        SET StatusCode=CASE WHEN @Readiness IN ('READY','READY_WITH_WARNINGS') THEN 'READY' ELSE 'PLANNING' END
        WHERE WorkOrderId=@WorkOrderId;

        DECLARE @Result nvarchar(max)=(
            SELECT @WorkOrderId WorkOrderId,@Readiness ReadinessStatusCode,COALESCE(@CurrentRevision,0)+1 RevisionNo
            FOR JSON PATH,WITHOUT_ARRAY_WRAPPER
        );
        UPDATE cmms.CommandReceipt SET ResultJson=@Result,StatusCode='COMPLETED',CompletedAt=sysutcdatetime()
        WHERE RequestId=@RequestId;

        COMMIT;
        SELECT N'READY' ReadState,@Result ResultJson,N'' ErrorCode,N'' ErrorMessage;
    END TRY
    BEGIN CATCH
        IF XACT_STATE()<>0 ROLLBACK;
        SELECT N'ERROR' ReadState,NULL ResultJson,
               CASE WHEN ERROR_NUMBER()=53014 THEN N'CMMS-404'
                    WHEN ERROR_NUMBER() IN (53019,2601,2627) THEN N'CMMS-409'
                    ELSE N'CMMS-500' END ErrorCode,ERROR_MESSAGE() ErrorMessage;
    END CATCH
END;
GO

CREATE OR ALTER PROCEDURE cmms.usp_Schedule_Commit
    @RequestJson nvarchar(max)
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    DECLARE @RequestId uniqueidentifier=TRY_CONVERT(uniqueidentifier,JSON_VALUE(@RequestJson,'$.requestId'));
    DECLARE @Actor nvarchar(200)=NULLIF(JSON_VALUE(@RequestJson,'$.actor'),N'');
    DECLARE @WorkOrderId bigint=TRY_CONVERT(bigint,JSON_VALUE(@RequestJson,'$.workOrderId'));
    DECLARE @Start datetime2(3)=TRY_CONVERT(datetime2(3),JSON_VALUE(@RequestJson,'$.scheduledStart'));
    DECLARE @Finish datetime2(3)=TRY_CONVERT(datetime2(3),JSON_VALUE(@RequestJson,'$.scheduledFinish'));
    DECLARE @TargetType nvarchar(20)=JSON_VALUE(@RequestJson,'$.assignmentTargetType');
    DECLARE @ResourcePoolId bigint=TRY_CONVERT(bigint,JSON_VALUE(@RequestJson,'$.resourcePoolId'));
    DECLARE @CrewId bigint=TRY_CONVERT(bigint,JSON_VALUE(@RequestJson,'$.crewId'));
    DECLARE @Person nvarchar(200)=NULLIF(JSON_VALUE(@RequestJson,'$.personReference'),N'');
    DECLARE @Shift nvarchar(50)=NULLIF(JSON_VALUE(@RequestJson,'$.shiftCode'),N'');
    DECLARE @Reason nvarchar(50)=COALESCE(NULLIF(JSON_VALUE(@RequestJson,'$.reasonCode'),N''),N'INITIAL_SCHEDULE');

    IF @RequestId IS NULL OR @Actor IS NULL OR @WorkOrderId IS NULL OR @Start IS NULL OR @Finish IS NULL OR @Finish<@Start
    BEGIN
        SELECT N'ERROR' ReadState,NULL ResultJson,N'CMMS-400' ErrorCode,N'Invalid schedule request.' ErrorMessage;
        RETURN;
    END;

    BEGIN TRY
        BEGIN TRANSACTION;

        DECLARE @Existing nvarchar(max);
        SELECT @Existing=ResultJson FROM cmms.CommandReceipt WITH(UPDLOCK,HOLDLOCK)
        WHERE RequestId=@RequestId AND StatusCode='COMPLETED';
        IF @Existing IS NOT NULL
        BEGIN COMMIT; SELECT N'READY',@Existing,N'',N''; RETURN; END;

        IF NOT EXISTS(SELECT 1 FROM cmms.CommandReceipt WHERE RequestId=@RequestId)
            INSERT cmms.CommandReceipt(RequestId,ProcedureName,Actor,StatusCode)
            VALUES(@RequestId,N'cmms.usp_Schedule_Commit',@Actor,N'STARTED');

        DECLARE @WorkStatus nvarchar(30),@DueAt datetime2(3),@OldStart datetime2(3),@OldFinish datetime2(3),
                @OldAssignmentId bigint,@NextRevision int;

        SELECT @WorkStatus=wo.StatusCode,@DueAt=COALESCE(mo.DueAt,wo.PlannedDueAt)
        FROM cmms.WorkOrder wo WITH(UPDLOCK,HOLDLOCK)
        LEFT JOIN cmms.MaintenanceOccurrence mo ON mo.MaintenanceOccurrenceId=wo.MaintenanceOccurrenceId
        WHERE wo.WorkOrderId=@WorkOrderId;

        IF @WorkStatus IS NULL THROW 53024,'WorkOrder not found.',1;
        IF @WorkStatus NOT IN ('READY','PLANNING') THROW 53029,'WorkOrder is not schedulable in current state.',1;

        SELECT @OldAssignmentId=ScheduleAssignmentId,@OldStart=ScheduledStart,@OldFinish=ScheduledFinish
        FROM cmms.ScheduleAssignment WITH(UPDLOCK,HOLDLOCK)
        WHERE WorkOrderId=@WorkOrderId AND IsCurrent=1;

        SELECT @NextRevision=COALESCE(MAX(RevisionNo),0)+1 FROM cmms.ScheduleAssignment WHERE WorkOrderId=@WorkOrderId;

        UPDATE cmms.ScheduleAssignment SET IsCurrent=0
        WHERE WorkOrderId=@WorkOrderId AND IsCurrent=1;

        INSERT cmms.ScheduleAssignment
            (WorkOrderId,ScheduledStart,ScheduledFinish,AssignmentTargetType,ResourcePoolId,CrewId,PersonReference,
             ShiftCode,StatusCode,RevisionNo,IsCurrent,ScheduledBy)
        VALUES
            (@WorkOrderId,@Start,@Finish,@TargetType,@ResourcePoolId,@CrewId,@Person,
             @Shift,N'COMMITTED',@NextRevision,1,@Actor);

        DECLARE @AssignmentId bigint=SCOPE_IDENTITY();

        IF @OldAssignmentId IS NOT NULL
        BEGIN
            INSERT cmms.ScheduleRevision
                (ScheduleAssignmentId,PreviousScheduledStart,PreviousScheduledFinish,NewScheduledStart,NewScheduledFinish,
                 ReasonCode,ChangedBy,ImpactCode)
            VALUES
                (@AssignmentId,@OldStart,@OldFinish,@Start,@Finish,@Reason,@Actor,
                 CASE WHEN @DueAt IS NULL OR @Finish<=@DueAt THEN 'BEFORE_DUE'
                      WHEN @OldFinish IS NOT NULL AND @OldFinish>@DueAt THEN 'OVERDUE_ALREADY'
                      ELSE 'AFTER_DUE' END);
        END;

        DECLARE @Result nvarchar(max)=(
            SELECT @AssignmentId ScheduleAssignmentId,@WorkOrderId WorkOrderId,@NextRevision RevisionNo,
                   @Start ScheduledStart,@Finish ScheduledFinish
            FOR JSON PATH,WITHOUT_ARRAY_WRAPPER
        );

        UPDATE cmms.CommandReceipt SET ResultJson=@Result,StatusCode='COMPLETED',CompletedAt=sysutcdatetime()
        WHERE RequestId=@RequestId;

        COMMIT;
        SELECT N'READY' ReadState,@Result ResultJson,N'' ErrorCode,N'' ErrorMessage;
    END TRY
    BEGIN CATCH
        IF XACT_STATE()<>0 ROLLBACK;
        SELECT N'ERROR' ReadState,NULL ResultJson,
               CASE WHEN ERROR_NUMBER()=53024 THEN N'CMMS-404'
                    WHEN ERROR_NUMBER() IN (53029,2601,2627,547) THEN N'CMMS-409'
                    ELSE N'CMMS-500' END ErrorCode,ERROR_MESSAGE() ErrorMessage;
    END CATCH
END;
GO

CREATE OR ALTER PROCEDURE cmms.usp_Execution_Start
    @RequestJson nvarchar(max)
AS
BEGIN
    SET NOCOUNT ON; SET XACT_ABORT ON;
    DECLARE @RequestId uniqueidentifier=TRY_CONVERT(uniqueidentifier,JSON_VALUE(@RequestJson,'$.requestId'));
    DECLARE @Actor nvarchar(200)=NULLIF(JSON_VALUE(@RequestJson,'$.actor'),N'');
    DECLARE @WorkOrderId bigint=TRY_CONVERT(bigint,JSON_VALUE(@RequestJson,'$.workOrderId'));
    DECLARE @ActualStart datetime2(3)=COALESCE(TRY_CONVERT(datetime2(3),JSON_VALUE(@RequestJson,'$.actualStartAt')),sysutcdatetime());

    IF @RequestId IS NULL OR @Actor IS NULL OR @WorkOrderId IS NULL
    BEGIN SELECT N'ERROR' ReadState,NULL ResultJson,N'CMMS-400' ErrorCode,N'Invalid execution start request.' ErrorMessage; RETURN; END;

    BEGIN TRY
      BEGIN TRANSACTION;
      DECLARE @Existing nvarchar(max);
      SELECT @Existing=ResultJson FROM cmms.CommandReceipt WITH(UPDLOCK,HOLDLOCK) WHERE RequestId=@RequestId AND StatusCode='COMPLETED';
      IF @Existing IS NOT NULL BEGIN COMMIT; SELECT N'READY',@Existing,N'',N''; RETURN; END;
      IF NOT EXISTS(SELECT 1 FROM cmms.CommandReceipt WHERE RequestId=@RequestId)
        INSERT cmms.CommandReceipt(RequestId,ProcedureName,Actor,StatusCode) VALUES(@RequestId,N'cmms.usp_Execution_Start',@Actor,N'STARTED');

      DECLARE @Status nvarchar(30);
      SELECT @Status=StatusCode FROM cmms.WorkOrder WITH(UPDLOCK,HOLDLOCK) WHERE WorkOrderId=@WorkOrderId;
      IF @Status IS NULL THROW 53034,'WorkOrder not found.',1;
      IF @Status NOT IN ('READY','RELEASED_TO_EXECUTION') THROW 53039,'WorkOrder cannot start execution in current state.',1;

      IF EXISTS(SELECT 1 FROM cmms.ExecutionRecord WHERE WorkOrderId=@WorkOrderId)
        UPDATE cmms.ExecutionRecord SET ActualStartAt=COALESCE(ActualStartAt,@ActualStart),PerformedByReference=COALESCE(PerformedByReference,@Actor) WHERE WorkOrderId=@WorkOrderId;
      ELSE
        INSERT cmms.ExecutionRecord(WorkOrderId,ActualStartAt,PerformedByReference,ValidationStatusCode)
        VALUES(@WorkOrderId,@ActualStart,@Actor,N'PENDING');

      UPDATE cmms.WorkOrder SET StatusCode='IN_PROGRESS' WHERE WorkOrderId=@WorkOrderId;

      DECLARE @Result nvarchar(max)=(SELECT @WorkOrderId WorkOrderId,@ActualStart ActualStartAt,N'IN_PROGRESS' StatusCode FOR JSON PATH,WITHOUT_ARRAY_WRAPPER);
      UPDATE cmms.CommandReceipt SET ResultJson=@Result,StatusCode='COMPLETED',CompletedAt=sysutcdatetime() WHERE RequestId=@RequestId;
      COMMIT;
      SELECT N'READY' ReadState,@Result ResultJson,N'' ErrorCode,N'' ErrorMessage;
    END TRY
    BEGIN CATCH
      IF XACT_STATE()<>0 ROLLBACK;
      SELECT N'ERROR',NULL,CASE WHEN ERROR_NUMBER()=53034 THEN N'CMMS-404' WHEN ERROR_NUMBER()=53039 THEN N'CMMS-409' ELSE N'CMMS-500' END,ERROR_MESSAGE();
    END CATCH
END;
GO

CREATE OR ALTER PROCEDURE cmms.usp_Execution_Complete
    @RequestJson nvarchar(max)
AS
BEGIN
    SET NOCOUNT ON; SET XACT_ABORT ON;
    DECLARE @RequestId uniqueidentifier=TRY_CONVERT(uniqueidentifier,JSON_VALUE(@RequestJson,'$.requestId'));
    DECLARE @Actor nvarchar(200)=NULLIF(JSON_VALUE(@RequestJson,'$.actor'),N'');
    DECLARE @WorkOrderId bigint=TRY_CONVERT(bigint,JSON_VALUE(@RequestJson,'$.workOrderId'));
    DECLARE @Finish datetime2(3)=COALESCE(TRY_CONVERT(datetime2(3),JSON_VALUE(@RequestJson,'$.actualFinishAt')),sysutcdatetime());
    DECLARE @ResultCode nvarchar(30)=JSON_VALUE(@RequestJson,'$.executionResultCode');

    IF @RequestId IS NULL OR @Actor IS NULL OR @WorkOrderId IS NULL
       OR @ResultCode NOT IN ('COMPLETED_AS_PLANNED','COMPLETED_WITH_DEVIATION','PARTIALLY_COMPLETED','NOT_COMPLETED')
    BEGIN SELECT N'ERROR' ReadState,NULL ResultJson,N'CMMS-400' ErrorCode,N'Invalid execution completion request.' ErrorMessage; RETURN; END;

    BEGIN TRY
      BEGIN TRANSACTION;
      DECLARE @Existing nvarchar(max);
      SELECT @Existing=ResultJson FROM cmms.CommandReceipt WITH(UPDLOCK,HOLDLOCK) WHERE RequestId=@RequestId AND StatusCode='COMPLETED';
      IF @Existing IS NOT NULL BEGIN COMMIT; SELECT N'READY',@Existing,N'',N''; RETURN; END;
      IF NOT EXISTS(SELECT 1 FROM cmms.CommandReceipt WHERE RequestId=@RequestId)
        INSERT cmms.CommandReceipt(RequestId,ProcedureName,Actor,StatusCode) VALUES(@RequestId,N'cmms.usp_Execution_Complete',@Actor,N'STARTED');

      DECLARE @Status nvarchar(30),@Start datetime2(3);
      SELECT @Status=wo.StatusCode,@Start=er.ActualStartAt
      FROM cmms.WorkOrder wo WITH(UPDLOCK,HOLDLOCK)
      LEFT JOIN cmms.ExecutionRecord er ON er.WorkOrderId=wo.WorkOrderId
      WHERE wo.WorkOrderId=@WorkOrderId;
      IF @Status IS NULL THROW 53044,'WorkOrder not found.',1;
      IF @Status<>'IN_PROGRESS' THROW 53049,'WorkOrder is not IN_PROGRESS.',1;
      IF @Start IS NULL OR @Finish<@Start THROW 53042,'actualFinishAt cannot be before actualStartAt.',1;

      UPDATE cmms.ExecutionRecord
      SET ActualFinishAt=@Finish,ExecutionResultCode=@ResultCode,ExecutionSubmittedAt=sysutcdatetime(),
          SubmittedBy=@Actor,FeedbackCapturedAt=sysutcdatetime()
      WHERE WorkOrderId=@WorkOrderId;

      UPDATE cmms.WorkOrder SET StatusCode='EXECUTION_COMPLETE' WHERE WorkOrderId=@WorkOrderId;

      DECLARE @Result nvarchar(max)=(SELECT @WorkOrderId WorkOrderId,@Finish ActualFinishAt,@ResultCode ExecutionResultCode,N'EXECUTION_COMPLETE' StatusCode FOR JSON PATH,WITHOUT_ARRAY_WRAPPER);
      UPDATE cmms.CommandReceipt SET ResultJson=@Result,StatusCode='COMPLETED',CompletedAt=sysutcdatetime() WHERE RequestId=@RequestId;
      COMMIT;
      SELECT N'READY' ReadState,@Result ResultJson,N'' ErrorCode,N'' ErrorMessage;
    END TRY
    BEGIN CATCH
      IF XACT_STATE()<>0 ROLLBACK;
      SELECT N'ERROR',NULL,
             CASE WHEN ERROR_NUMBER()=53044 THEN N'CMMS-404' WHEN ERROR_NUMBER() IN (53049,53042) THEN N'CMMS-409' ELSE N'CMMS-500' END,
             ERROR_MESSAGE();
    END CATCH
END;
GO

CREATE OR ALTER PROCEDURE cmms.usp_WorkOrder_TechnicalClose
    @RequestJson nvarchar(max)
AS
BEGIN
    SET NOCOUNT ON; SET XACT_ABORT ON;
    DECLARE @RequestId uniqueidentifier=TRY_CONVERT(uniqueidentifier,JSON_VALUE(@RequestJson,'$.requestId'));
    DECLARE @Actor nvarchar(200)=NULLIF(JSON_VALUE(@RequestJson,'$.actor'),N'');
    DECLARE @WorkOrderId bigint=TRY_CONVERT(bigint,JSON_VALUE(@RequestJson,'$.workOrderId'));
    DECLARE @ValidationNotes nvarchar(max)=JSON_VALUE(@RequestJson,'$.validationNotes');
    DECLARE @Quality nvarchar(30)=COALESCE(NULLIF(JSON_VALUE(@RequestJson,'$.dataQualityStatusCode'),N''),N'COMPLETE');

    IF @RequestId IS NULL OR @Actor IS NULL OR @WorkOrderId IS NULL OR @Quality NOT IN ('COMPLETE','COMPLETE_WITH_WARNINGS','CORRECTED')
    BEGIN SELECT N'ERROR' ReadState,NULL ResultJson,N'CMMS-400' ErrorCode,N'Invalid technical close request.' ErrorMessage; RETURN; END;

    BEGIN TRY
      BEGIN TRANSACTION;
      DECLARE @Existing nvarchar(max);
      SELECT @Existing=ResultJson FROM cmms.CommandReceipt WITH(UPDLOCK,HOLDLOCK) WHERE RequestId=@RequestId AND StatusCode='COMPLETED';
      IF @Existing IS NOT NULL BEGIN COMMIT; SELECT N'READY',@Existing,N'',N''; RETURN; END;
      IF NOT EXISTS(SELECT 1 FROM cmms.CommandReceipt WHERE RequestId=@RequestId)
        INSERT cmms.CommandReceipt(RequestId,ProcedureName,Actor,StatusCode) VALUES(@RequestId,N'cmms.usp_WorkOrder_TechnicalClose',@Actor,N'STARTED');

      DECLARE @Status nvarchar(30),@ActualFinish datetime2(3),@OccurrenceId bigint,@PolicyId bigint,@Basis nvarchar(30),@OpenFindings int;
      SELECT @Status=wo.StatusCode,@ActualFinish=er.ActualFinishAt,@OccurrenceId=wo.MaintenanceOccurrenceId
      FROM cmms.WorkOrder wo WITH(UPDLOCK,HOLDLOCK)
      LEFT JOIN cmms.ExecutionRecord er ON er.WorkOrderId=wo.WorkOrderId
      WHERE wo.WorkOrderId=@WorkOrderId;

      IF @Status IS NULL THROW 53054,'WorkOrder not found.',1;
      IF @Status<>'EXECUTION_COMPLETE' THROW 53059,'WorkOrder is not EXECUTION_COMPLETE.',1;
      IF @ActualFinish IS NULL THROW 53052,'ActualFinishAt is required.',1;

      SELECT @OpenFindings=COUNT(*) FROM cmms.ExecutionFinding
      WHERE WorkOrderId=@WorkOrderId AND RequiresFollowUp=1 AND StatusCode IN ('OPEN','ASSESSED');

      IF @OpenFindings>0 THROW 53012,'Required follow-up findings are not resolved or linked.',1;

      UPDATE cmms.ExecutionRecord
      SET ValidationStatusCode='VALIDATED',ValidatedAt=sysutcdatetime(),ValidatedBy=@Actor
      WHERE WorkOrderId=@WorkOrderId;

      INSERT cmms.WorkOrderClosure
          (WorkOrderId,TechnicalClosedAt,ClosedBy,ClosureResultCode,ValidationNotes,DataQualityStatusCode,OpenFollowUpCount)
      VALUES(@WorkOrderId,sysutcdatetime(),@Actor,N'TECHNICAL_COMPLETE',@ValidationNotes,@Quality,0);

      UPDATE cmms.WorkOrder SET StatusCode='TECHNICALLY_CLOSED' WHERE WorkOrderId=@WorkOrderId;

      IF @OccurrenceId IS NOT NULL
      BEGIN
          UPDATE cmms.MaintenanceOccurrence
          SET StatusCode='FULFILLED',FulfilledAt=@ActualFinish
          WHERE MaintenanceOccurrenceId=@OccurrenceId;

          SELECT @PolicyId=TriggerPolicyId FROM cmms.MaintenanceOccurrence WHERE MaintenanceOccurrenceId=@OccurrenceId;
          SELECT @Basis=RecurrenceBasisCode FROM cmms.MaintenanceTriggerPolicy WHERE TriggerPolicyId=@PolicyId;

          UPDATE cmms.MaintenanceTriggerState
          SET LastCompletionAt=CASE WHEN @Basis='LAST_COMPLETION' THEN @ActualFinish ELSE LastCompletionAt END,
              OpenMaintenanceOccurrenceId=NULL
          WHERE TriggerPolicyId=@PolicyId;
      END;

      DECLARE @Result nvarchar(max)=(SELECT @WorkOrderId WorkOrderId,N'TECHNICALLY_CLOSED' StatusCode,@ActualFinish AcceptedActualFinishAt FOR JSON PATH,WITHOUT_ARRAY_WRAPPER);
      UPDATE cmms.CommandReceipt SET ResultJson=@Result,StatusCode='COMPLETED',CompletedAt=sysutcdatetime() WHERE RequestId=@RequestId;
      COMMIT;
      SELECT N'READY' ReadState,@Result ResultJson,N'' ErrorCode,N'' ErrorMessage;
    END TRY
    BEGIN CATCH
      IF XACT_STATE()<>0 ROLLBACK;
      SELECT N'ERROR',NULL,
             CASE WHEN ERROR_NUMBER()=53054 THEN N'CMMS-404'
                  WHEN ERROR_NUMBER() IN (53059,53052) THEN N'CMMS-409'
                  WHEN ERROR_NUMBER()=53012 THEN N'CMMS-412'
                  WHEN ERROR_NUMBER() IN (2601,2627) THEN N'CMMS-409'
                  ELSE N'CMMS-500' END,
             ERROR_MESSAGE();
    END CATCH
END;
GO
