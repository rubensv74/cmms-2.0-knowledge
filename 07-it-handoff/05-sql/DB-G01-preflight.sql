/*
CMMS 2.0 — DB-G01 Preflight
Run in db-omm-dev BEFORE DB-G01-create-core.sql.
Read-only. No changes.
*/
SET NOCOUNT ON;

IF DB_NAME() <> N'db-omm-dev'
    THROW 50901, 'DB-G01 PREFLIGHT STOP: current database is not db-omm-dev.', 1;

DECLARE @Expected TABLE (ObjectName sysname PRIMARY KEY);
INSERT @Expected(ObjectName) VALUES
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

SELECT DB_NAME() AS CurrentDatabase,
       SCHEMA_ID(N'cmms') AS CmmsSchemaId;

SELECT
    e.ObjectName,
    ExistingObjectType = o.type_desc,
    ExistingSchema = s.name
FROM @Expected e
JOIN sys.objects o ON o.name=e.ObjectName
JOIN sys.schemas s ON s.schema_id=o.schema_id
ORDER BY s.name,e.ObjectName;

IF EXISTS (
    SELECT 1
    FROM @Expected e
    JOIN sys.objects o ON o.name=e.ObjectName
    JOIN sys.schemas s ON s.schema_id=o.schema_id
    WHERE s.name=N'cmms'
)
BEGIN
    SELECT e.ObjectName AS ConflictingCmmsObject
    FROM @Expected e
    JOIN sys.objects o ON o.name=e.ObjectName
    JOIN sys.schemas s ON s.schema_id=o.schema_id
    WHERE s.name=N'cmms'
    ORDER BY e.ObjectName;

    THROW 50902, 'DB-G01 PREFLIGHT STOP: one or more target cmms objects already exist. Reconcile before running create script.', 1;
END;

SELECT
    DatabasePrincipal = name,
    Type = type_desc
FROM sys.database_principals
WHERE principal_id > 4
ORDER BY name;

PRINT 'DB-G01 PREFLIGHT PASS: no target table collision detected in schema cmms.';
