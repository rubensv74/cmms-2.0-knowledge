/*
CMMS 2.0 — DB-G01
Physical SQL Core DDL
Target: db-omm-dev / schema cmms
Date: 2026-10-08

ADDITIVE ONLY.
NO ROLES. NO USERS. NO DROPS.
*/

SET NOCOUNT ON;
SET XACT_ABORT ON;

IF SCHEMA_ID(N'cmms') IS NULL
    EXEC(N'CREATE SCHEMA cmms');
GO

CREATE TABLE cmms.SourceReference (
    SourceReferenceId bigint IDENTITY(1,1) NOT NULL CONSTRAINT PK_SourceReference PRIMARY KEY,
    SourceTypeCode nvarchar(40) NOT NULL,
    SourceDocumentNo nvarchar(150) NULL,
    SourceRevision nvarchar(50) NULL,
    SourceDate date NULL,
    ProjectCode nvarchar(50) NULL,
    UnitCode nvarchar(50) NULL,
    SourceFileName nvarchar(260) NULL,
    SourceObjectCode nvarchar(150) NULL,
    SourceUri nvarchar(1000) NULL,
    AmbiguityFlag bit NOT NULL CONSTRAINT DF_SourceReference_AmbiguityFlag DEFAULT(0),
    AmbiguityNotes nvarchar(max) NULL,
    CreatedAt datetime2(3) NOT NULL CONSTRAINT DF_SourceReference_CreatedAt DEFAULT(sysutcdatetime()),
    CreatedBy nvarchar(200) NOT NULL
);
GO

CREATE TABLE cmms.JobPlan (
    JobPlanId bigint IDENTITY(1,1) NOT NULL CONSTRAINT PK_JobPlan PRIMARY KEY,
    JobPlanCode nvarchar(100) NOT NULL,
    Name nvarchar(250) NOT NULL,
    IsActive bit NOT NULL CONSTRAINT DF_JobPlan_IsActive DEFAULT(1),
    CreatedAt datetime2(3) NOT NULL CONSTRAINT DF_JobPlan_CreatedAt DEFAULT(sysutcdatetime()),
    CreatedBy nvarchar(200) NOT NULL,
    CONSTRAINT UQ_JobPlan_Code UNIQUE(JobPlanCode)
);
GO

CREATE TABLE cmms.JobPlanRevision (
    JobPlanRevisionId bigint IDENTITY(1,1) NOT NULL CONSTRAINT PK_JobPlanRevision PRIMARY KEY,
    JobPlanId bigint NOT NULL,
    RevisionCode nvarchar(50) NOT NULL,
    Title nvarchar(250) NOT NULL,
    Description nvarchar(max) NULL,
    PlannedTotalDurationHours decimal(18,6) NULL,
    StatusCode nvarchar(20) NOT NULL,
    SourceReferenceId bigint NULL,
    PublishedAt datetime2(3) NULL,
    PublishedBy nvarchar(200) NULL,
    CreatedAt datetime2(3) NOT NULL CONSTRAINT DF_JobPlanRevision_CreatedAt DEFAULT(sysutcdatetime()),
    CreatedBy nvarchar(200) NOT NULL,
    CONSTRAINT FK_JobPlanRevision_JobPlan FOREIGN KEY(JobPlanId) REFERENCES cmms.JobPlan(JobPlanId),
    CONSTRAINT FK_JobPlanRevision_Source FOREIGN KEY(SourceReferenceId) REFERENCES cmms.SourceReference(SourceReferenceId),
    CONSTRAINT UQ_JobPlanRevision UNIQUE(JobPlanId, RevisionCode),
    CONSTRAINT CK_JobPlanRevision_Status CHECK(StatusCode IN ('DRAFT','REVIEW','APPROVED','PUBLISHED','SUPERSEDED','RETIRED')),
    CONSTRAINT CK_JobPlanRevision_Duration CHECK(PlannedTotalDurationHours IS NULL OR PlannedTotalDurationHours >= 0)
);
GO

CREATE TABLE cmms.JobPlanOperation (
    JobPlanOperationId bigint IDENTITY(1,1) NOT NULL CONSTRAINT PK_JobPlanOperation PRIMARY KEY,
    JobPlanRevisionId bigint NOT NULL,
    SequenceNo int NOT NULL,
    Title nvarchar(250) NULL,
    InstructionDetail nvarchar(max) NOT NULL,
    PlannedDurationHours decimal(18,6) NULL,
    DisciplineCode nvarchar(100) NULL,
    MeasurementReference nvarchar(250) NULL,
    IsMandatory bit NOT NULL CONSTRAINT DF_JobPlanOperation_IsMandatory DEFAULT(1),
    CONSTRAINT FK_JobPlanOperation_Revision FOREIGN KEY(JobPlanRevisionId) REFERENCES cmms.JobPlanRevision(JobPlanRevisionId),
    CONSTRAINT UQ_JobPlanOperation_Sequence UNIQUE(JobPlanRevisionId, SequenceNo),
    CONSTRAINT CK_JobPlanOperation_Sequence CHECK(SequenceNo > 0),
    CONSTRAINT CK_JobPlanOperation_Duration CHECK(PlannedDurationHours IS NULL OR PlannedDurationHours >= 0)
);
GO

CREATE TABLE cmms.ResourceRequirement (
    ResourceRequirementId bigint IDENTITY(1,1) NOT NULL CONSTRAINT PK_ResourceRequirement PRIMARY KEY,
    JobPlanRevisionId bigint NOT NULL,
    JobPlanOperationId bigint NULL,
    DisciplineCode nvarchar(100) NOT NULL,
    RequiredQuantity decimal(18,6) NULL,
    PlannedHours decimal(18,6) NULL,
    Notes nvarchar(1000) NULL,
    CONSTRAINT FK_ResourceRequirement_Revision FOREIGN KEY(JobPlanRevisionId) REFERENCES cmms.JobPlanRevision(JobPlanRevisionId),
    CONSTRAINT FK_ResourceRequirement_Operation FOREIGN KEY(JobPlanOperationId) REFERENCES cmms.JobPlanOperation(JobPlanOperationId),
    CONSTRAINT CK_ResourceRequirement_Qty CHECK(RequiredQuantity IS NULL OR RequiredQuantity >= 0),
    CONSTRAINT CK_ResourceRequirement_Hours CHECK(PlannedHours IS NULL OR PlannedHours >= 0)
);
GO

CREATE TABLE cmms.ToolRequirement (
    ToolRequirementId bigint IDENTITY(1,1) NOT NULL CONSTRAINT PK_ToolRequirement PRIMARY KEY,
    JobPlanRevisionId bigint NOT NULL,
    JobPlanOperationId bigint NULL,
    ToolCode nvarchar(100) NULL,
    ToolDescription nvarchar(250) NOT NULL,
    RequiredQuantity decimal(18,6) NULL,
    Notes nvarchar(1000) NULL,
    CONSTRAINT FK_ToolRequirement_Revision FOREIGN KEY(JobPlanRevisionId) REFERENCES cmms.JobPlanRevision(JobPlanRevisionId),
    CONSTRAINT FK_ToolRequirement_Operation FOREIGN KEY(JobPlanOperationId) REFERENCES cmms.JobPlanOperation(JobPlanOperationId),
    CONSTRAINT CK_ToolRequirement_Qty CHECK(RequiredQuantity IS NULL OR RequiredQuantity >= 0)
);
GO

CREATE TABLE cmms.MaterialRequirement (
    MaterialRequirementId bigint IDENTITY(1,1) NOT NULL CONSTRAINT PK_MaterialRequirement PRIMARY KEY,
    JobPlanRevisionId bigint NOT NULL,
    JobPlanOperationId bigint NULL,
    ItemCode nvarchar(100) NULL,
    ItemDescription nvarchar(250) NOT NULL,
    RequiredQuantity decimal(18,6) NULL,
    UnitCode nvarchar(40) NULL,
    Notes nvarchar(1000) NULL,
    CONSTRAINT FK_MaterialRequirement_Revision FOREIGN KEY(JobPlanRevisionId) REFERENCES cmms.JobPlanRevision(JobPlanRevisionId),
    CONSTRAINT FK_MaterialRequirement_Operation FOREIGN KEY(JobPlanOperationId) REFERENCES cmms.JobPlanOperation(JobPlanOperationId),
    CONSTRAINT CK_MaterialRequirement_Qty CHECK(RequiredQuantity IS NULL OR RequiredQuantity >= 0)
);
GO

CREATE TABLE cmms.MaintenanceActivity (
    MaintenanceActivityId bigint IDENTITY(1,1) NOT NULL CONSTRAINT PK_MaintenanceActivity PRIMARY KEY,
    ActivityCode nvarchar(100) NOT NULL,
    Title nvarchar(250) NOT NULL,
    Description nvarchar(max) NULL,
    StrategyCode nvarchar(50) NULL,
    DisciplineCode nvarchar(100) NULL,
    OperationalStateRequirementCode nvarchar(50) NULL,
    DefaultJobPlanRevisionId bigint NULL,
    SourceBasisCode nvarchar(50) NOT NULL,
    SourceReferenceId bigint NULL,
    IsActive bit NOT NULL CONSTRAINT DF_MaintenanceActivity_IsActive DEFAULT(1),
    CreatedAt datetime2(3) NOT NULL CONSTRAINT DF_MaintenanceActivity_CreatedAt DEFAULT(sysutcdatetime()),
    CreatedBy nvarchar(200) NOT NULL,
    CONSTRAINT UQ_MaintenanceActivity_Code UNIQUE(ActivityCode),
    CONSTRAINT FK_MaintenanceActivity_JobPlanRevision FOREIGN KEY(DefaultJobPlanRevisionId) REFERENCES cmms.JobPlanRevision(JobPlanRevisionId),
    CONSTRAINT FK_MaintenanceActivity_Source FOREIGN KEY(SourceReferenceId) REFERENCES cmms.SourceReference(SourceReferenceId),
    CONSTRAINT CK_MaintenanceActivity_SourceBasis CHECK(SourceBasisCode IN ('RCM','CORPORATE_STANDARD','OEM_VENDOR','EXPERT','HISTORICAL','REGULATORY','PROJECT'))
);
GO

CREATE TABLE cmms.ProjectMaintenancePlanVersion (
    ProjectMaintenancePlanVersionId bigint IDENTITY(1,1) NOT NULL CONSTRAINT PK_ProjectMaintenancePlanVersion PRIMARY KEY,
    ProjectCode nvarchar(50) NOT NULL,
    PlanCode nvarchar(100) NOT NULL,
    RevisionCode nvarchar(50) NOT NULL,
    StatusCode nvarchar(20) NOT NULL,
    ValidFrom date NULL,
    ValidTo date NULL,
    PublishedAt datetime2(3) NULL,
    PublishedBy nvarchar(200) NULL,
    CreatedAt datetime2(3) NOT NULL CONSTRAINT DF_ProjectPlanVersion_CreatedAt DEFAULT(sysutcdatetime()),
    CreatedBy nvarchar(200) NOT NULL,
    CONSTRAINT UQ_ProjectPlanVersion UNIQUE(ProjectCode, PlanCode, RevisionCode),
    CONSTRAINT CK_ProjectPlanVersion_Status CHECK(StatusCode IN ('DRAFT','REVIEW','APPROVED','PUBLISHED','SUPERSEDED','RETIRED')),
    CONSTRAINT CK_ProjectPlanVersion_Dates CHECK(ValidTo IS NULL OR ValidFrom IS NULL OR ValidTo >= ValidFrom)
);
GO

CREATE TABLE cmms.ProjectMaintenancePlanItem (
    ProjectMaintenancePlanItemId bigint IDENTITY(1,1) NOT NULL CONSTRAINT PK_ProjectMaintenancePlanItem PRIMARY KEY,
    ProjectMaintenancePlanVersionId bigint NOT NULL,
    AssetKey nvarchar(100) NOT NULL,
    MaintenanceActivityId bigint NOT NULL,
    JobPlanRevisionOverrideId bigint NULL,
    ApplicabilityStatusCode nvarchar(20) NOT NULL CONSTRAINT DF_ProjectPlanItem_Applicability DEFAULT('APPLICABLE'),
    OverrideReason nvarchar(1000) NULL,
    IsActive bit NOT NULL CONSTRAINT DF_ProjectPlanItem_IsActive DEFAULT(1),
    CONSTRAINT FK_ProjectPlanItem_PlanVersion FOREIGN KEY(ProjectMaintenancePlanVersionId) REFERENCES cmms.ProjectMaintenancePlanVersion(ProjectMaintenancePlanVersionId),
    CONSTRAINT FK_ProjectPlanItem_Activity FOREIGN KEY(MaintenanceActivityId) REFERENCES cmms.MaintenanceActivity(MaintenanceActivityId),
    CONSTRAINT FK_ProjectPlanItem_JobPlanOverride FOREIGN KEY(JobPlanRevisionOverrideId) REFERENCES cmms.JobPlanRevision(JobPlanRevisionId),
    CONSTRAINT UQ_ProjectPlanItem UNIQUE(ProjectMaintenancePlanVersionId, AssetKey, MaintenanceActivityId),
    CONSTRAINT CK_ProjectPlanItem_Applicability CHECK(ApplicabilityStatusCode IN ('APPLICABLE','NOT_APPLICABLE','OVERRIDDEN','SUSPENDED'))
);
GO

CREATE TABLE cmms.MeasurementPoint (
    MeasurementPointId bigint IDENTITY(1,1) NOT NULL CONSTRAINT PK_MeasurementPoint PRIMARY KEY,
    AssetKey nvarchar(100) NOT NULL,
    PointCode nvarchar(100) NOT NULL,
    CharacteristicCode nvarchar(100) NOT NULL,
    MeasurementKindCode nvarchar(20) NOT NULL,
    UnitCode nvarchar(40) NULL,
    SourceSystemCode nvarchar(100) NULL,
    AuthorityPolicyCode nvarchar(30) NOT NULL,
    IsActive bit NOT NULL CONSTRAINT DF_MeasurementPoint_IsActive DEFAULT(1),
    CONSTRAINT UQ_MeasurementPoint UNIQUE(AssetKey, PointCode),
    CONSTRAINT CK_MeasurementPoint_Kind CHECK(MeasurementKindCode IN ('COUNTER','GAUGE','CHARACTERISTIC')),
    CONSTRAINT CK_MeasurementPoint_Authority CHECK(AuthorityPolicyCode IN ('CMMS_OWNED','EXTERNAL_READ_ONLY','EXTERNAL_SYNCED'))
);
GO

CREATE TABLE cmms.MeasurementReading (
    MeasurementReadingId bigint IDENTITY(1,1) NOT NULL CONSTRAINT PK_MeasurementReading PRIMARY KEY,
    MeasurementPointId bigint NOT NULL,
    ReadingAt datetime2(3) NOT NULL,
    ValueNumeric decimal(18,6) NULL,
    ValueText nvarchar(500) NULL,
    UnitCode nvarchar(40) NULL,
    QualityStatusCode nvarchar(20) NOT NULL CONSTRAINT DF_MeasurementReading_Quality DEFAULT('VALID'),
    SourceReferenceId bigint NULL,
    SupersedesReadingId bigint NULL,
    EnteredAt datetime2(3) NOT NULL CONSTRAINT DF_MeasurementReading_EnteredAt DEFAULT(sysutcdatetime()),
    EnteredBy nvarchar(200) NOT NULL,
    CONSTRAINT FK_MeasurementReading_Point FOREIGN KEY(MeasurementPointId) REFERENCES cmms.MeasurementPoint(MeasurementPointId),
    CONSTRAINT FK_MeasurementReading_Source FOREIGN KEY(SourceReferenceId) REFERENCES cmms.SourceReference(SourceReferenceId),
    CONSTRAINT FK_MeasurementReading_Supersedes FOREIGN KEY(SupersedesReadingId) REFERENCES cmms.MeasurementReading(MeasurementReadingId),
    CONSTRAINT CK_MeasurementReading_Value CHECK(ValueNumeric IS NOT NULL OR ValueText IS NOT NULL),
    CONSTRAINT CK_MeasurementReading_Quality CHECK(QualityStatusCode IN ('VALID','SUSPECT','CORRECTED','VOID'))
);
GO

CREATE TABLE cmms.MaintenanceTriggerPolicy (
    TriggerPolicyId bigint IDENTITY(1,1) NOT NULL CONSTRAINT PK_MaintenanceTriggerPolicy PRIMARY KEY,
    ProjectMaintenancePlanItemId bigint NOT NULL,
    VersionNo int NOT NULL,
    PolicyModeCode nvarchar(20) NOT NULL,
    RecurrenceBasisCode nvarchar(30) NOT NULL,
    CombinationOperatorCode nvarchar(10) NULL,
    ReleaseLeadValue decimal(18,6) NULL,
    ReleaseLeadUnitCode nvarchar(20) NULL,
    EffectiveFrom datetime2(3) NULL,
    EffectiveTo datetime2(3) NULL,
    StatusCode nvarchar(20) NOT NULL,
    PublishedAt datetime2(3) NULL,
    PublishedBy nvarchar(200) NULL,
    CONSTRAINT FK_TriggerPolicy_PlanItem FOREIGN KEY(ProjectMaintenancePlanItemId) REFERENCES cmms.ProjectMaintenancePlanItem(ProjectMaintenancePlanItemId),
    CONSTRAINT UQ_TriggerPolicy_Version UNIQUE(ProjectMaintenancePlanItemId, VersionNo),
    CONSTRAINT CK_TriggerPolicy_Mode CHECK(PolicyModeCode IN ('SIMPLE','COMPOSITE')),
    CONSTRAINT CK_TriggerPolicy_Basis CHECK(RecurrenceBasisCode IN ('FIXED_SCHEDULE','LAST_COMPLETION')),
    CONSTRAINT CK_TriggerPolicy_Combination CHECK(CombinationOperatorCode IS NULL OR CombinationOperatorCode IN ('ANY','ALL')),
    CONSTRAINT CK_TriggerPolicy_Status CHECK(StatusCode IN ('DRAFT','REVIEW','APPROVED','PUBLISHED','SUPERSEDED','RETIRED')),
    CONSTRAINT CK_TriggerPolicy_Lead CHECK(ReleaseLeadValue IS NULL OR ReleaseLeadValue >= 0),
    CONSTRAINT CK_TriggerPolicy_Dates CHECK(EffectiveTo IS NULL OR EffectiveFrom IS NULL OR EffectiveTo >= EffectiveFrom)
);
GO

CREATE TABLE cmms.TriggerRule (
    TriggerRuleId bigint IDENTITY(1,1) NOT NULL CONSTRAINT PK_TriggerRule PRIMARY KEY,
    TriggerPolicyId bigint NOT NULL,
    SequenceNo int NOT NULL,
    RuleTypeCode nvarchar(20) NOT NULL,
    IntervalValue decimal(18,6) NULL,
    IntervalUnitCode nvarchar(20) NULL,
    MeasurementPointId bigint NULL,
    ComparisonOperatorCode nvarchar(10) NULL,
    ThresholdValue decimal(18,6) NULL,
    WarningThresholdValue decimal(18,6) NULL,
    ThresholdUnitCode nvarchar(40) NULL,
    AnchorAt datetime2(3) NULL,
    CONSTRAINT FK_TriggerRule_Policy FOREIGN KEY(TriggerPolicyId) REFERENCES cmms.MaintenanceTriggerPolicy(TriggerPolicyId),
    CONSTRAINT FK_TriggerRule_Point FOREIGN KEY(MeasurementPointId) REFERENCES cmms.MeasurementPoint(MeasurementPointId),
    CONSTRAINT UQ_TriggerRule_Sequence UNIQUE(TriggerPolicyId, SequenceNo),
    CONSTRAINT CK_TriggerRule_Type CHECK(RuleTypeCode IN ('TIME','METER','CONDITION')),
    CONSTRAINT CK_TriggerRule_Sequence CHECK(SequenceNo > 0),
    CONSTRAINT CK_TriggerRule_Interval CHECK(IntervalValue IS NULL OR IntervalValue > 0),
    CONSTRAINT CK_TriggerRule_Operator CHECK(ComparisonOperatorCode IS NULL OR ComparisonOperatorCode IN ('>','>=','<','<=','=','<>')),
    CONSTRAINT CK_TriggerRule_Measurement CHECK(
        (RuleTypeCode = 'TIME' AND MeasurementPointId IS NULL)
        OR (RuleTypeCode IN ('METER','CONDITION') AND MeasurementPointId IS NOT NULL)
    )
);
GO

CREATE TABLE cmms.MaintenanceTriggerState (
    TriggerStateId bigint IDENTITY(1,1) NOT NULL CONSTRAINT PK_MaintenanceTriggerState PRIMARY KEY,
    TriggerPolicyId bigint NOT NULL,
    LastEvaluationAt datetime2(3) NULL,
    LastCompletionAt datetime2(3) NULL,
    LastDueAt datetime2(3) NULL,
    NextDueAt datetime2(3) NULL,
    BaselineMeasurementReadingId bigint NULL,
    BaselineValue decimal(18,6) NULL,
    ConditionStateCode nvarchar(20) NULL,
    OpenMaintenanceOccurrenceId bigint NULL,
    RowVersion rowversion NOT NULL,
    CONSTRAINT FK_TriggerState_Policy FOREIGN KEY(TriggerPolicyId) REFERENCES cmms.MaintenanceTriggerPolicy(TriggerPolicyId),
    CONSTRAINT FK_TriggerState_BaselineReading FOREIGN KEY(BaselineMeasurementReadingId) REFERENCES cmms.MeasurementReading(MeasurementReadingId),
    CONSTRAINT UQ_TriggerState_Policy UNIQUE(TriggerPolicyId),
    CONSTRAINT CK_TriggerState_Condition CHECK(ConditionStateCode IS NULL OR ConditionStateCode IN ('NORMAL','WARNING','ACTION'))
);
GO

CREATE TABLE cmms.MaintenanceOccurrence (
    MaintenanceOccurrenceId bigint IDENTITY(1,1) NOT NULL CONSTRAINT PK_MaintenanceOccurrence PRIMARY KEY,
    ProjectMaintenancePlanItemId bigint NOT NULL,
    TriggerPolicyId bigint NOT NULL,
    EpisodeKey nvarchar(200) NOT NULL,
    ForecastAt datetime2(3) NULL,
    ReleaseAt datetime2(3) NOT NULL,
    DueAt datetime2(3) NOT NULL,
    ReleasedAt datetime2(3) NOT NULL CONSTRAINT DF_MaintenanceOccurrence_ReleasedAt DEFAULT(sysutcdatetime()),
    FulfilledAt datetime2(3) NULL,
    StatusCode nvarchar(20) NOT NULL,
    OriginReasonCode nvarchar(30) NOT NULL,
    CONSTRAINT FK_MaintenanceOccurrence_PlanItem FOREIGN KEY(ProjectMaintenancePlanItemId) REFERENCES cmms.ProjectMaintenancePlanItem(ProjectMaintenancePlanItemId),
    CONSTRAINT FK_MaintenanceOccurrence_Policy FOREIGN KEY(TriggerPolicyId) REFERENCES cmms.MaintenanceTriggerPolicy(TriggerPolicyId),
    CONSTRAINT UQ_MaintenanceOccurrence_Episode UNIQUE(ProjectMaintenancePlanItemId, TriggerPolicyId, EpisodeKey),
    CONSTRAINT CK_MaintenanceOccurrence_Status CHECK(StatusCode IN ('RELEASED','DUE','OVERDUE','MATERIALIZED','FULFILLED','CANCELLED','SUPERSEDED')),
    CONSTRAINT CK_MaintenanceOccurrence_Dates CHECK(DueAt >= ReleaseAt)
);
GO

ALTER TABLE cmms.MaintenanceTriggerState
ADD CONSTRAINT FK_TriggerState_OpenOccurrence
FOREIGN KEY(OpenMaintenanceOccurrenceId) REFERENCES cmms.MaintenanceOccurrence(MaintenanceOccurrenceId);
GO

CREATE TABLE cmms.MaintenanceDueEvent (
    DueEventId bigint IDENTITY(1,1) NOT NULL CONSTRAINT PK_MaintenanceDueEvent PRIMARY KEY,
    MaintenanceOccurrenceId bigint NOT NULL,
    DueEventAt datetime2(3) NOT NULL,
    DueReasonCode nvarchar(30) NOT NULL,
    MeasurementReadingId bigint NULL,
    EventTypeCode nvarchar(20) NOT NULL,
    CreatedAt datetime2(3) NOT NULL CONSTRAINT DF_MaintenanceDueEvent_CreatedAt DEFAULT(sysutcdatetime()),
    CONSTRAINT FK_DueEvent_Occurrence FOREIGN KEY(MaintenanceOccurrenceId) REFERENCES cmms.MaintenanceOccurrence(MaintenanceOccurrenceId),
    CONSTRAINT FK_DueEvent_Reading FOREIGN KEY(MeasurementReadingId) REFERENCES cmms.MeasurementReading(MeasurementReadingId),
    CONSTRAINT CK_DueEvent_Type CHECK(EventTypeCode IN ('DUE','OVERDUE','ACTION'))
);
GO

CREATE TABLE cmms.WorkOrder (
    WorkOrderId bigint IDENTITY(1,1) NOT NULL CONSTRAINT PK_WorkOrder PRIMARY KEY,
    WorkOrderNo nvarchar(100) NOT NULL,
    WorkOrderTypeCode nvarchar(20) NOT NULL,
    AssetKey nvarchar(100) NOT NULL,
    MaintenanceOccurrenceId bigint NULL,
    MaintenanceActivityId bigint NULL,
    ProjectMaintenancePlanItemId bigint NULL,
    EffectiveJobPlanRevisionId bigint NULL,
    StatusCode nvarchar(30) NOT NULL,
    PriorityCode nvarchar(30) NULL,
    PlannedDueAt datetime2(3) NULL,
    PlannedDurationHours decimal(18,6) NULL,
    CreatedAt datetime2(3) NOT NULL CONSTRAINT DF_WorkOrder_CreatedAt DEFAULT(sysutcdatetime()),
    CreatedBy nvarchar(200) NOT NULL,
    CONSTRAINT UQ_WorkOrder_No UNIQUE(WorkOrderNo),
    CONSTRAINT FK_WorkOrder_Occurrence FOREIGN KEY(MaintenanceOccurrenceId) REFERENCES cmms.MaintenanceOccurrence(MaintenanceOccurrenceId),
    CONSTRAINT FK_WorkOrder_Activity FOREIGN KEY(MaintenanceActivityId) REFERENCES cmms.MaintenanceActivity(MaintenanceActivityId),
    CONSTRAINT FK_WorkOrder_PlanItem FOREIGN KEY(ProjectMaintenancePlanItemId) REFERENCES cmms.ProjectMaintenancePlanItem(ProjectMaintenancePlanItemId),
    CONSTRAINT FK_WorkOrder_JobPlanRevision FOREIGN KEY(EffectiveJobPlanRevisionId) REFERENCES cmms.JobPlanRevision(JobPlanRevisionId),
    CONSTRAINT CK_WorkOrder_Type CHECK(WorkOrderTypeCode IN ('PREVENTIVE','CORRECTIVE','INSPECTION','OTHER')),
    CONSTRAINT CK_WorkOrder_Status CHECK(StatusCode IN ('PLANNING','READY','RELEASED_TO_EXECUTION','IN_PROGRESS','EXECUTION_COMPLETE','TECHNICALLY_CLOSED','CANCELLED')),
    CONSTRAINT CK_WorkOrder_Duration CHECK(PlannedDurationHours IS NULL OR PlannedDurationHours >= 0)
);
GO
CREATE UNIQUE INDEX UX_WorkOrder_MaintenanceOccurrence
ON cmms.WorkOrder(MaintenanceOccurrenceId)
WHERE MaintenanceOccurrenceId IS NOT NULL;
GO

CREATE TABLE cmms.PlanningPackage (
    PlanningPackageId bigint IDENTITY(1,1) NOT NULL CONSTRAINT PK_PlanningPackage PRIMARY KEY,
    WorkOrderId bigint NOT NULL,
    RevisionNo int NOT NULL,
    PlannedDurationHours decimal(18,6) NULL,
    PlannerNotes nvarchar(max) NULL,
    ReadinessStatusCode nvarchar(30) NOT NULL,
    IsCurrent bit NOT NULL CONSTRAINT DF_PlanningPackage_IsCurrent DEFAULT(1),
    CreatedAt datetime2(3) NOT NULL CONSTRAINT DF_PlanningPackage_CreatedAt DEFAULT(sysutcdatetime()),
    CreatedBy nvarchar(200) NOT NULL,
    CONSTRAINT FK_PlanningPackage_WorkOrder FOREIGN KEY(WorkOrderId) REFERENCES cmms.WorkOrder(WorkOrderId),
    CONSTRAINT UQ_PlanningPackage_Revision UNIQUE(WorkOrderId, RevisionNo),
    CONSTRAINT CK_PlanningPackage_Status CHECK(ReadinessStatusCode IN ('NOT_READY','READY_WITH_WARNINGS','READY')),
    CONSTRAINT CK_PlanningPackage_Duration CHECK(PlannedDurationHours IS NULL OR PlannedDurationHours >= 0)
);
GO
CREATE UNIQUE INDEX UX_PlanningPackage_Current
ON cmms.PlanningPackage(WorkOrderId)
WHERE IsCurrent = 1;
GO

CREATE TABLE cmms.WorkConstraint (
    WorkConstraintId bigint IDENTITY(1,1) NOT NULL CONSTRAINT PK_WorkConstraint PRIMARY KEY,
    PlanningPackageId bigint NOT NULL,
    CategoryCode nvarchar(20) NOT NULL,
    StatusCode nvarchar(20) NOT NULL,
    OwnerReference nvarchar(200) NULL,
    RequiredBy datetime2(3) NULL,
    ResolvedAt datetime2(3) NULL,
    ResolutionNote nvarchar(1000) NULL,
    WaiverReason nvarchar(1000) NULL,
    CONSTRAINT FK_WorkConstraint_PlanningPackage FOREIGN KEY(PlanningPackageId) REFERENCES cmms.PlanningPackage(PlanningPackageId),
    CONSTRAINT CK_WorkConstraint_Category CHECK(CategoryCode IN ('MATERIAL','TOOL','LABOR','DOCUMENT','OPERATIONS','PERMIT','ACCESS','OTHER')),
    CONSTRAINT CK_WorkConstraint_Status CHECK(StatusCode IN ('OPEN','RESOLVED','WAIVED'))
);
GO

CREATE TABLE cmms.ReadinessAssessment (
    ReadinessAssessmentId bigint IDENTITY(1,1) NOT NULL CONSTRAINT PK_ReadinessAssessment PRIMARY KEY,
    PlanningPackageId bigint NOT NULL,
    ResultCode nvarchar(30) NOT NULL,
    AssessedAt datetime2(3) NOT NULL CONSTRAINT DF_ReadinessAssessment_AssessedAt DEFAULT(sysutcdatetime()),
    AssessedBy nvarchar(200) NOT NULL,
    Notes nvarchar(1000) NULL,
    CONSTRAINT FK_ReadinessAssessment_PlanningPackage FOREIGN KEY(PlanningPackageId) REFERENCES cmms.PlanningPackage(PlanningPackageId),
    CONSTRAINT CK_ReadinessAssessment_Result CHECK(ResultCode IN ('NOT_READY','READY_WITH_WARNINGS','READY'))
);
GO

CREATE TABLE cmms.OperationalCalendar (
    OperationalCalendarId bigint IDENTITY(1,1) NOT NULL CONSTRAINT PK_OperationalCalendar PRIMARY KEY,
    CalendarCode nvarchar(100) NOT NULL,
    Name nvarchar(250) NOT NULL,
    TimeZoneId nvarchar(100) NOT NULL,
    IsActive bit NOT NULL CONSTRAINT DF_OperationalCalendar_IsActive DEFAULT(1),
    CONSTRAINT UQ_OperationalCalendar_Code UNIQUE(CalendarCode)
);
GO

CREATE TABLE cmms.ShiftCalendar (
    ShiftCalendarId bigint IDENTITY(1,1) NOT NULL CONSTRAINT PK_ShiftCalendar PRIMARY KEY,
    OperationalCalendarId bigint NOT NULL,
    ShiftCode nvarchar(50) NOT NULL,
    ShiftName nvarchar(150) NOT NULL,
    StartTime time(0) NOT NULL,
    EndTime time(0) NOT NULL,
    IsActive bit NOT NULL CONSTRAINT DF_ShiftCalendar_IsActive DEFAULT(1),
    CONSTRAINT FK_ShiftCalendar_OperationalCalendar FOREIGN KEY(OperationalCalendarId) REFERENCES cmms.OperationalCalendar(OperationalCalendarId),
    CONSTRAINT UQ_ShiftCalendar UNIQUE(OperationalCalendarId, ShiftCode)
);
GO

CREATE TABLE cmms.ResourcePool (
    ResourcePoolId bigint IDENTITY(1,1) NOT NULL CONSTRAINT PK_ResourcePool PRIMARY KEY,
    ResourcePoolCode nvarchar(100) NOT NULL,
    Name nvarchar(250) NOT NULL,
    DisciplineCode nvarchar(100) NULL,
    OperationalCalendarId bigint NULL,
    IsActive bit NOT NULL CONSTRAINT DF_ResourcePool_IsActive DEFAULT(1),
    CONSTRAINT FK_ResourcePool_Calendar FOREIGN KEY(OperationalCalendarId) REFERENCES cmms.OperationalCalendar(OperationalCalendarId),
    CONSTRAINT UQ_ResourcePool_Code UNIQUE(ResourcePoolCode)
);
GO

CREATE TABLE cmms.Crew (
    CrewId bigint IDENTITY(1,1) NOT NULL CONSTRAINT PK_Crew PRIMARY KEY,
    CrewCode nvarchar(100) NOT NULL,
    Name nvarchar(250) NOT NULL,
    ResourcePoolId bigint NULL,
    OperationalCalendarId bigint NULL,
    IsActive bit NOT NULL CONSTRAINT DF_Crew_IsActive DEFAULT(1),
    CONSTRAINT FK_Crew_ResourcePool FOREIGN KEY(ResourcePoolId) REFERENCES cmms.ResourcePool(ResourcePoolId),
    CONSTRAINT FK_Crew_Calendar FOREIGN KEY(OperationalCalendarId) REFERENCES cmms.OperationalCalendar(OperationalCalendarId),
    CONSTRAINT UQ_Crew_Code UNIQUE(CrewCode)
);
GO

CREATE TABLE cmms.CapacityBucket (
    CapacityBucketId bigint IDENTITY(1,1) NOT NULL CONSTRAINT PK_CapacityBucket PRIMARY KEY,
    ResourceScopeType nvarchar(20) NOT NULL,
    ResourcePoolId bigint NULL,
    CrewId bigint NULL,
    CalendarDate date NOT NULL,
    ShiftCode nvarchar(50) NULL,
    AvailableHours decimal(18,6) NOT NULL,
    CommittedHours decimal(18,6) NOT NULL CONSTRAINT DF_CapacityBucket_Committed DEFAULT(0),
    CapacitySourceCode nvarchar(50) NULL,
    RowVersion rowversion NOT NULL,
    CONSTRAINT FK_CapacityBucket_ResourcePool FOREIGN KEY(ResourcePoolId) REFERENCES cmms.ResourcePool(ResourcePoolId),
    CONSTRAINT FK_CapacityBucket_Crew FOREIGN KEY(CrewId) REFERENCES cmms.Crew(CrewId),
    CONSTRAINT CK_CapacityBucket_Scope CHECK(
        (ResourceScopeType='RESOURCE_POOL' AND ResourcePoolId IS NOT NULL AND CrewId IS NULL)
        OR (ResourceScopeType='CREW' AND CrewId IS NOT NULL AND ResourcePoolId IS NULL)
    ),
    CONSTRAINT CK_CapacityBucket_Hours CHECK(AvailableHours >= 0 AND CommittedHours >= 0)
);
GO

CREATE TABLE cmms.ScheduleAssignment (
    ScheduleAssignmentId bigint IDENTITY(1,1) NOT NULL CONSTRAINT PK_ScheduleAssignment PRIMARY KEY,
    WorkOrderId bigint NOT NULL,
    ScheduledStart datetime2(3) NOT NULL,
    ScheduledFinish datetime2(3) NOT NULL,
    AssignmentTargetType nvarchar(20) NOT NULL,
    ResourcePoolId bigint NULL,
    CrewId bigint NULL,
    PersonReference nvarchar(200) NULL,
    ShiftCode nvarchar(50) NULL,
    StatusCode nvarchar(20) NOT NULL,
    RevisionNo int NOT NULL,
    IsCurrent bit NOT NULL CONSTRAINT DF_ScheduleAssignment_IsCurrent DEFAULT(1),
    ScheduledAt datetime2(3) NOT NULL CONSTRAINT DF_ScheduleAssignment_ScheduledAt DEFAULT(sysutcdatetime()),
    ScheduledBy nvarchar(200) NOT NULL,
    CONSTRAINT FK_ScheduleAssignment_WorkOrder FOREIGN KEY(WorkOrderId) REFERENCES cmms.WorkOrder(WorkOrderId),
    CONSTRAINT FK_ScheduleAssignment_ResourcePool FOREIGN KEY(ResourcePoolId) REFERENCES cmms.ResourcePool(ResourcePoolId),
    CONSTRAINT FK_ScheduleAssignment_Crew FOREIGN KEY(CrewId) REFERENCES cmms.Crew(CrewId),
    CONSTRAINT UQ_ScheduleAssignment_Revision UNIQUE(WorkOrderId, RevisionNo),
    CONSTRAINT CK_ScheduleAssignment_Dates CHECK(ScheduledFinish >= ScheduledStart),
    CONSTRAINT CK_ScheduleAssignment_Target CHECK(
       (AssignmentTargetType='RESOURCE_POOL' AND ResourcePoolId IS NOT NULL AND CrewId IS NULL AND PersonReference IS NULL)
       OR (AssignmentTargetType='CREW' AND CrewId IS NOT NULL AND ResourcePoolId IS NULL AND PersonReference IS NULL)
       OR (AssignmentTargetType='PERSON' AND PersonReference IS NOT NULL AND ResourcePoolId IS NULL AND CrewId IS NULL)
    ),
    CONSTRAINT CK_ScheduleAssignment_Status CHECK(StatusCode IN ('UNSCHEDULED','TENTATIVE','COMMITTED','DISPATCHED','CANCELLED'))
);
GO
CREATE UNIQUE INDEX UX_ScheduleAssignment_Current
ON cmms.ScheduleAssignment(WorkOrderId)
WHERE IsCurrent = 1;
GO

CREATE TABLE cmms.ScheduleRevision (
    ScheduleRevisionId bigint IDENTITY(1,1) NOT NULL CONSTRAINT PK_ScheduleRevision PRIMARY KEY,
    ScheduleAssignmentId bigint NOT NULL,
    PreviousScheduledStart datetime2(3) NULL,
    PreviousScheduledFinish datetime2(3) NULL,
    NewScheduledStart datetime2(3) NOT NULL,
    NewScheduledFinish datetime2(3) NOT NULL,
    PreviousTargetSummary nvarchar(500) NULL,
    NewTargetSummary nvarchar(500) NULL,
    ReasonCode nvarchar(50) NOT NULL,
    RequestedBy nvarchar(200) NULL,
    ChangedBy nvarchar(200) NOT NULL,
    ChangedAt datetime2(3) NOT NULL CONSTRAINT DF_ScheduleRevision_ChangedAt DEFAULT(sysutcdatetime()),
    ImpactCode nvarchar(30) NOT NULL,
    CONSTRAINT FK_ScheduleRevision_Assignment FOREIGN KEY(ScheduleAssignmentId) REFERENCES cmms.ScheduleAssignment(ScheduleAssignmentId),
    CONSTRAINT CK_ScheduleRevision_Dates CHECK(NewScheduledFinish >= NewScheduledStart),
    CONSTRAINT CK_ScheduleRevision_Impact CHECK(ImpactCode IN ('BEFORE_DUE','AFTER_DUE','OVERDUE_ALREADY'))
);
GO

CREATE TABLE cmms.ExecutionRecord (
    ExecutionRecordId bigint IDENTITY(1,1) NOT NULL CONSTRAINT PK_ExecutionRecord PRIMARY KEY,
    WorkOrderId bigint NOT NULL,
    ActualStartAt datetime2(3) NULL,
    ActualFinishAt datetime2(3) NULL,
    ExecutionResultCode nvarchar(30) NULL,
    PerformedByReference nvarchar(200) NULL,
    CrewId bigint NULL,
    ExecutionSubmittedAt datetime2(3) NULL,
    SubmittedBy nvarchar(200) NULL,
    ValidationStatusCode nvarchar(20) NOT NULL CONSTRAINT DF_ExecutionRecord_Validation DEFAULT('PENDING'),
    ValidatedAt datetime2(3) NULL,
    ValidatedBy nvarchar(200) NULL,
    FeedbackCapturedAt datetime2(3) NULL,
    RowVersion rowversion NOT NULL,
    CONSTRAINT FK_ExecutionRecord_WorkOrder FOREIGN KEY(WorkOrderId) REFERENCES cmms.WorkOrder(WorkOrderId),
    CONSTRAINT FK_ExecutionRecord_Crew FOREIGN KEY(CrewId) REFERENCES cmms.Crew(CrewId),
    CONSTRAINT UQ_ExecutionRecord_WorkOrder UNIQUE(WorkOrderId),
    CONSTRAINT CK_ExecutionRecord_Dates CHECK(ActualFinishAt IS NULL OR ActualStartAt IS NULL OR ActualFinishAt >= ActualStartAt),
    CONSTRAINT CK_ExecutionRecord_Result CHECK(ExecutionResultCode IS NULL OR ExecutionResultCode IN ('COMPLETED_AS_PLANNED','COMPLETED_WITH_DEVIATION','PARTIALLY_COMPLETED','NOT_COMPLETED')),
    CONSTRAINT CK_ExecutionRecord_Validation CHECK(ValidationStatusCode IN ('PENDING','VALIDATED','REJECTED','CORRECTED'))
);
GO

CREATE TABLE cmms.LaborActual (
    LaborActualId bigint IDENTITY(1,1) NOT NULL CONSTRAINT PK_LaborActual PRIMARY KEY,
    ExecutionRecordId bigint NOT NULL,
    PersonReference nvarchar(200) NULL,
    CrewId bigint NULL,
    DisciplineCode nvarchar(100) NULL,
    WorkDate date NULL,
    StartAt datetime2(3) NULL,
    FinishAt datetime2(3) NULL,
    ActualHours decimal(18,6) NOT NULL,
    EnteredAt datetime2(3) NOT NULL CONSTRAINT DF_LaborActual_EnteredAt DEFAULT(sysutcdatetime()),
    EnteredBy nvarchar(200) NOT NULL,
    SourceCode nvarchar(50) NULL,
    CONSTRAINT FK_LaborActual_Execution FOREIGN KEY(ExecutionRecordId) REFERENCES cmms.ExecutionRecord(ExecutionRecordId),
    CONSTRAINT FK_LaborActual_Crew FOREIGN KEY(CrewId) REFERENCES cmms.Crew(CrewId),
    CONSTRAINT CK_LaborActual_Hours CHECK(ActualHours >= 0),
    CONSTRAINT CK_LaborActual_Dates CHECK(FinishAt IS NULL OR StartAt IS NULL OR FinishAt >= StartAt)
);
GO

CREATE TABLE cmms.MaterialActual (
    MaterialActualId bigint IDENTITY(1,1) NOT NULL CONSTRAINT PK_MaterialActual PRIMARY KEY,
    ExecutionRecordId bigint NOT NULL,
    MaterialRequirementId bigint NULL,
    ItemCode nvarchar(100) NULL,
    ItemDescription nvarchar(250) NULL,
    Quantity decimal(18,6) NOT NULL,
    UnitCode nvarchar(40) NULL,
    TransactionAt datetime2(3) NOT NULL,
    EnteredBy nvarchar(200) NOT NULL,
    CONSTRAINT FK_MaterialActual_Execution FOREIGN KEY(ExecutionRecordId) REFERENCES cmms.ExecutionRecord(ExecutionRecordId),
    CONSTRAINT FK_MaterialActual_Requirement FOREIGN KEY(MaterialRequirementId) REFERENCES cmms.MaterialRequirement(MaterialRequirementId),
    CONSTRAINT CK_MaterialActual_Qty CHECK(Quantity >= 0)
);
GO

CREATE TABLE cmms.ToolActual (
    ToolActualId bigint IDENTITY(1,1) NOT NULL CONSTRAINT PK_ToolActual PRIMARY KEY,
    ExecutionRecordId bigint NOT NULL,
    ToolRequirementId bigint NULL,
    ToolCode nvarchar(100) NULL,
    ToolDescription nvarchar(250) NULL,
    ActualHours decimal(18,6) NULL,
    Quantity decimal(18,6) NULL,
    EnteredAt datetime2(3) NOT NULL CONSTRAINT DF_ToolActual_EnteredAt DEFAULT(sysutcdatetime()),
    EnteredBy nvarchar(200) NOT NULL,
    CONSTRAINT FK_ToolActual_Execution FOREIGN KEY(ExecutionRecordId) REFERENCES cmms.ExecutionRecord(ExecutionRecordId),
    CONSTRAINT FK_ToolActual_Requirement FOREIGN KEY(ToolRequirementId) REFERENCES cmms.ToolRequirement(ToolRequirementId),
    CONSTRAINT CK_ToolActual_Hours CHECK(ActualHours IS NULL OR ActualHours >= 0),
    CONSTRAINT CK_ToolActual_Qty CHECK(Quantity IS NULL OR Quantity >= 0)
);
GO

CREATE TABLE cmms.ServiceActual (
    ServiceActualId bigint IDENTITY(1,1) NOT NULL CONSTRAINT PK_ServiceActual PRIMARY KEY,
    ExecutionRecordId bigint NOT NULL,
    ServiceCode nvarchar(100) NULL,
    ServiceDescription nvarchar(250) NOT NULL,
    Quantity decimal(18,6) NULL,
    UnitCode nvarchar(40) NULL,
    EnteredAt datetime2(3) NOT NULL CONSTRAINT DF_ServiceActual_EnteredAt DEFAULT(sysutcdatetime()),
    EnteredBy nvarchar(200) NOT NULL,
    CONSTRAINT FK_ServiceActual_Execution FOREIGN KEY(ExecutionRecordId) REFERENCES cmms.ExecutionRecord(ExecutionRecordId),
    CONSTRAINT CK_ServiceActual_Qty CHECK(Quantity IS NULL OR Quantity >= 0)
);
GO

CREATE TABLE cmms.ChecklistResult (
    ChecklistResultId bigint IDENTITY(1,1) NOT NULL CONSTRAINT PK_ChecklistResult PRIMARY KEY,
    ExecutionRecordId bigint NOT NULL,
    JobPlanOperationId bigint NULL,
    ResponseTypeCode nvarchar(30) NOT NULL,
    ResponseNumeric decimal(18,6) NULL,
    ResponseText nvarchar(max) NULL,
    ResponseBoolean bit NULL,
    UnitCode nvarchar(40) NULL,
    MeasurementReadingId bigint NULL,
    IsCompliant bit NULL,
    RequiresFollowUp bit NOT NULL CONSTRAINT DF_ChecklistResult_RequiresFollowUp DEFAULT(0),
    EnteredAt datetime2(3) NOT NULL CONSTRAINT DF_ChecklistResult_EnteredAt DEFAULT(sysutcdatetime()),
    EnteredBy nvarchar(200) NOT NULL,
    CONSTRAINT FK_ChecklistResult_Execution FOREIGN KEY(ExecutionRecordId) REFERENCES cmms.ExecutionRecord(ExecutionRecordId),
    CONSTRAINT FK_ChecklistResult_Operation FOREIGN KEY(JobPlanOperationId) REFERENCES cmms.JobPlanOperation(JobPlanOperationId),
    CONSTRAINT FK_ChecklistResult_Reading FOREIGN KEY(MeasurementReadingId) REFERENCES cmms.MeasurementReading(MeasurementReadingId),
    CONSTRAINT CK_ChecklistResult_Type CHECK(ResponseTypeCode IN ('COMPLETE','YES_NO','NUMERIC','MEASUREMENT','QUALITATIVE','TEXT','DATE','REPAIR_NEEDED'))
);
GO

CREATE TABLE cmms.ExecutionFinding (
    ExecutionFindingId bigint IDENTITY(1,1) NOT NULL CONSTRAINT PK_ExecutionFinding PRIMARY KEY,
    WorkOrderId bigint NOT NULL,
    JobPlanOperationId bigint NULL,
    AssetKey nvarchar(100) NOT NULL,
    FindingTypeCode nvarchar(50) NOT NULL,
    Description nvarchar(max) NOT NULL,
    SeverityCode nvarchar(30) NULL,
    PriorityCode nvarchar(30) NULL,
    FoundAt datetime2(3) NOT NULL,
    FoundBy nvarchar(200) NOT NULL,
    RequiresFollowUp bit NOT NULL CONSTRAINT DF_ExecutionFinding_RequiresFollowUp DEFAULT(0),
    StatusCode nvarchar(20) NOT NULL,
    CONSTRAINT FK_ExecutionFinding_WorkOrder FOREIGN KEY(WorkOrderId) REFERENCES cmms.WorkOrder(WorkOrderId),
    CONSTRAINT FK_ExecutionFinding_Operation FOREIGN KEY(JobPlanOperationId) REFERENCES cmms.JobPlanOperation(JobPlanOperationId),
    CONSTRAINT CK_ExecutionFinding_Status CHECK(StatusCode IN ('OPEN','ASSESSED','FOLLOW_UP_CREATED','WAIVED','CLOSED'))
);
GO

CREATE TABLE cmms.FollowUpWorkOrderLink (
    FollowUpWorkOrderLinkId bigint IDENTITY(1,1) NOT NULL CONSTRAINT PK_FollowUpWorkOrderLink PRIMARY KEY,
    ExecutionFindingId bigint NOT NULL,
    FollowUpWorkOrderId bigint NOT NULL,
    LinkReasonCode nvarchar(50) NULL,
    CreatedAt datetime2(3) NOT NULL CONSTRAINT DF_FollowUpWorkOrderLink_CreatedAt DEFAULT(sysutcdatetime()),
    CreatedBy nvarchar(200) NOT NULL,
    CONSTRAINT FK_FollowUpLink_Finding FOREIGN KEY(ExecutionFindingId) REFERENCES cmms.ExecutionFinding(ExecutionFindingId),
    CONSTRAINT FK_FollowUpLink_WorkOrder FOREIGN KEY(FollowUpWorkOrderId) REFERENCES cmms.WorkOrder(WorkOrderId),
    CONSTRAINT UQ_FollowUpLink UNIQUE(ExecutionFindingId, FollowUpWorkOrderId)
);
GO

CREATE TABLE cmms.WorkOrderClosure (
    WorkOrderClosureId bigint IDENTITY(1,1) NOT NULL CONSTRAINT PK_WorkOrderClosure PRIMARY KEY,
    WorkOrderId bigint NOT NULL,
    TechnicalClosedAt datetime2(3) NOT NULL,
    ClosedBy nvarchar(200) NOT NULL,
    ClosureResultCode nvarchar(30) NOT NULL,
    ValidationNotes nvarchar(max) NULL,
    DataQualityStatusCode nvarchar(30) NOT NULL,
    OpenFollowUpCount int NOT NULL CONSTRAINT DF_WorkOrderClosure_OpenFollowUp DEFAULT(0),
    ExceptionReference nvarchar(250) NULL,
    CONSTRAINT FK_WorkOrderClosure_WorkOrder FOREIGN KEY(WorkOrderId) REFERENCES cmms.WorkOrder(WorkOrderId),
    CONSTRAINT UQ_WorkOrderClosure_WorkOrder UNIQUE(WorkOrderId),
    CONSTRAINT CK_WorkOrderClosure_Quality CHECK(DataQualityStatusCode IN ('COMPLETE','COMPLETE_WITH_WARNINGS','INCOMPLETE','CORRECTED')),
    CONSTRAINT CK_WorkOrderClosure_FollowUp CHECK(OpenFollowUpCount >= 0)
);
GO

/* Performance / access-path indexes */

CREATE INDEX IX_ProjectPlanItem_Asset
ON cmms.ProjectMaintenancePlanItem(AssetKey, IsActive)
INCLUDE(ProjectMaintenancePlanVersionId, MaintenanceActivityId);
GO

CREATE INDEX IX_TriggerPolicy_ItemStatus
ON cmms.MaintenanceTriggerPolicy(ProjectMaintenancePlanItemId, StatusCode, EffectiveFrom, EffectiveTo);
GO

CREATE INDEX IX_MeasurementReading_PointTime
ON cmms.MeasurementReading(MeasurementPointId, ReadingAt DESC)
INCLUDE(ValueNumeric, ValueText, QualityStatusCode);
GO

CREATE INDEX IX_MaintenanceOccurrence_StatusDue
ON cmms.MaintenanceOccurrence(StatusCode, DueAt)
INCLUDE(ProjectMaintenancePlanItemId, ReleaseAt, TriggerPolicyId);
GO

CREATE INDEX IX_WorkOrder_StatusDue
ON cmms.WorkOrder(StatusCode, PlannedDueAt)
INCLUDE(AssetKey, WorkOrderTypeCode, MaintenanceOccurrenceId);
GO

CREATE INDEX IX_WorkConstraint_Status
ON cmms.WorkConstraint(StatusCode, CategoryCode, RequiredBy)
INCLUDE(PlanningPackageId);
GO

CREATE INDEX IX_CapacityBucket_Date
ON cmms.CapacityBucket(CalendarDate, ResourceScopeType, ShiftCode)
INCLUDE(AvailableHours, CommittedHours, ResourcePoolId, CrewId);
GO

CREATE INDEX IX_ScheduleAssignment_Window
ON cmms.ScheduleAssignment(StatusCode, ScheduledStart, ScheduledFinish)
INCLUDE(WorkOrderId, AssignmentTargetType, ResourcePoolId, CrewId, PersonReference);
GO

CREATE INDEX IX_ExecutionFinding_Open
ON cmms.ExecutionFinding(StatusCode, RequiresFollowUp, AssetKey)
INCLUDE(WorkOrderId, FoundAt, SeverityCode, PriorityCode);
GO
