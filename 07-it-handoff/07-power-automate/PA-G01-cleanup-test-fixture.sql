/*
PA-G01 runtime fixture cleanup
Run only after PA-G01 manual tests.
*/
SET NOCOUNT ON;
SET XACT_ABORT ON;

BEGIN TRANSACTION;
BEGIN TRY
    DECLARE @OccurrenceIds TABLE(Id bigint PRIMARY KEY);
    INSERT @OccurrenceIds
    SELECT mo.MaintenanceOccurrenceId
    FROM cmms.MaintenanceOccurrence mo
    JOIN cmms.ProjectMaintenancePlanItem pi ON pi.ProjectMaintenancePlanItemId=mo.ProjectMaintenancePlanItemId
    JOIN cmms.ProjectMaintenancePlanVersion pv ON pv.ProjectMaintenancePlanVersionId=pi.ProjectMaintenancePlanVersionId
    WHERE pv.ProjectCode=N'PAG01';

    DELETE cr
    FROM cmms.CommandReceipt cr
    WHERE cr.ResultJson LIKE N'%PAG01-WO-001%'
       OR cr.Actor=N'PA-G01';

    DELETE FROM cmms.WorkOrderClosure
    WHERE WorkOrderId IN (SELECT WorkOrderId FROM cmms.WorkOrder WHERE MaintenanceOccurrenceId IN (SELECT Id FROM @OccurrenceIds));

    DELETE FROM cmms.ExecutionRecord
    WHERE WorkOrderId IN (SELECT WorkOrderId FROM cmms.WorkOrder WHERE MaintenanceOccurrenceId IN (SELECT Id FROM @OccurrenceIds));

    DELETE FROM cmms.ScheduleRevision
    WHERE ScheduleAssignmentId IN (
        SELECT ScheduleAssignmentId FROM cmms.ScheduleAssignment
        WHERE WorkOrderId IN (SELECT WorkOrderId FROM cmms.WorkOrder WHERE MaintenanceOccurrenceId IN (SELECT Id FROM @OccurrenceIds))
    );

    DELETE FROM cmms.ScheduleAssignment
    WHERE WorkOrderId IN (SELECT WorkOrderId FROM cmms.WorkOrder WHERE MaintenanceOccurrenceId IN (SELECT Id FROM @OccurrenceIds));

    DELETE FROM cmms.PlanningPackage
    WHERE WorkOrderId IN (SELECT WorkOrderId FROM cmms.WorkOrder WHERE MaintenanceOccurrenceId IN (SELECT Id FROM @OccurrenceIds));

    DELETE FROM cmms.WorkOrder
    WHERE MaintenanceOccurrenceId IN (SELECT Id FROM @OccurrenceIds);

    UPDATE cmms.MaintenanceTriggerState
    SET OpenMaintenanceOccurrenceId=NULL
    WHERE TriggerPolicyId IN (
        SELECT tp.TriggerPolicyId
        FROM cmms.MaintenanceTriggerPolicy tp
        JOIN cmms.ProjectMaintenancePlanItem pi ON pi.ProjectMaintenancePlanItemId=tp.ProjectMaintenancePlanItemId
        JOIN cmms.ProjectMaintenancePlanVersion pv ON pv.ProjectMaintenancePlanVersionId=pi.ProjectMaintenancePlanVersionId
        WHERE pv.ProjectCode=N'PAG01'
    );

    DELETE FROM cmms.MaintenanceDueEvent WHERE MaintenanceOccurrenceId IN (SELECT Id FROM @OccurrenceIds);
    DELETE FROM cmms.MaintenanceOccurrence WHERE MaintenanceOccurrenceId IN (SELECT Id FROM @OccurrenceIds);

    DELETE tr
    FROM cmms.TriggerRule tr
    JOIN cmms.MaintenanceTriggerPolicy tp ON tp.TriggerPolicyId=tr.TriggerPolicyId
    JOIN cmms.ProjectMaintenancePlanItem pi ON pi.ProjectMaintenancePlanItemId=tp.ProjectMaintenancePlanItemId
    JOIN cmms.ProjectMaintenancePlanVersion pv ON pv.ProjectMaintenancePlanVersionId=pi.ProjectMaintenancePlanVersionId
    WHERE pv.ProjectCode=N'PAG01';

    DELETE mts
    FROM cmms.MaintenanceTriggerState mts
    JOIN cmms.MaintenanceTriggerPolicy tp ON tp.TriggerPolicyId=mts.TriggerPolicyId
    JOIN cmms.ProjectMaintenancePlanItem pi ON pi.ProjectMaintenancePlanItemId=tp.ProjectMaintenancePlanItemId
    JOIN cmms.ProjectMaintenancePlanVersion pv ON pv.ProjectMaintenancePlanVersionId=pi.ProjectMaintenancePlanVersionId
    WHERE pv.ProjectCode=N'PAG01';

    DELETE tp
    FROM cmms.MaintenanceTriggerPolicy tp
    JOIN cmms.ProjectMaintenancePlanItem pi ON pi.ProjectMaintenancePlanItemId=tp.ProjectMaintenancePlanItemId
    JOIN cmms.ProjectMaintenancePlanVersion pv ON pv.ProjectMaintenancePlanVersionId=pi.ProjectMaintenancePlanVersionId
    WHERE pv.ProjectCode=N'PAG01';

    DELETE pi
    FROM cmms.ProjectMaintenancePlanItem pi
    JOIN cmms.ProjectMaintenancePlanVersion pv ON pv.ProjectMaintenancePlanVersionId=pi.ProjectMaintenancePlanVersionId
    WHERE pv.ProjectCode=N'PAG01';

    DELETE FROM cmms.ProjectMaintenancePlanVersion WHERE ProjectCode=N'PAG01';
    DELETE FROM cmms.MaintenanceActivity WHERE ActivityCode=N'PAG01-ACT';
    DELETE FROM cmms.JobPlanRevision WHERE JobPlanId IN (SELECT JobPlanId FROM cmms.JobPlan WHERE JobPlanCode=N'PAG01-JP');
    DELETE FROM cmms.JobPlan WHERE JobPlanCode=N'PAG01-JP';

    COMMIT;
    PRINT 'PA-G01 fixture cleanup: PASS';
END TRY
BEGIN CATCH
    IF XACT_STATE()<>0 ROLLBACK;
    THROW;
END CATCH;
