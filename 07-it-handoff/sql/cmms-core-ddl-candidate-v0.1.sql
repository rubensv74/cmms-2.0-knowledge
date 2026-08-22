/* ============================================================================
   CMMS 2.0 Functional Lab — Core DDL Candidate v0.1
   Date: 2026-08-22
   Branch: baseline/premium-powerapps-v1

   STATUS: CANDIDATE / NOT PRODUCTION APPROVED

   Purpose
   -------
   Provide a relational target for the structurally mature part of the
   Functional Lab without forcing the Power Apps prototype to connect to SQL.

   This script deliberately covers only:
     - Analysis case
     - Asset context snapshot
     - Operating modes
     - Evidence sources
     - Functions
     - Functional failures
     - Failure modes
     - Failure effects
     - Generic decision/gate trace

   Intentionally NOT modeled yet:
     - RiskProfile details / risk matrix implementation
     - RCM question tree implementation
     - Maintenance plan physical schema
     - Applicability / overrides physical schema
     - Work orders / planning / scheduling
     - Cost / contract / billing
     - Authentication / authorization

   Reason: those areas still require explicit contract gates or discovery.

   Design rule
   -----------
   UI logical keys are opaque text keys. SQL uses internal bigint PKs and
   exposes unique logical keys so the future provider can preserve the same
   Power Apps contract without exposing physical database identities.
   ============================================================================ */

SET NOCOUNT ON;
SET XACT_ABORT ON;
GO

IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = N'cmmslab')
BEGIN
    EXEC(N'CREATE SCHEMA cmmslab AUTHORIZATION dbo;');
END;
GO

/* --------------------------------------------------------------------------
   AnalysisCase
   -------------------------------------------------------------------------- */
CREATE TABLE cmmslab.AnalysisCase
(
    AnalysisCaseId       bigint IDENTITY(1,1) NOT NULL,
    CaseKey              nvarchar(80) NOT NULL,
    CaseName             nvarchar(250) NOT NULL,
    FixtureVersion       nvarchar(30) NULL,
    ValidationStatus     nvarchar(40) NOT NULL CONSTRAINT DF_AnalysisCase_ValidationStatus DEFAULT (N'draft'),
    Disclaimer           nvarchar(max) NULL,
    IsActive             bit NOT NULL CONSTRAINT DF_AnalysisCase_IsActive DEFAULT (1),
    CreatedAtUtc         datetime2(3) NOT NULL CONSTRAINT DF_AnalysisCase_CreatedAtUtc DEFAULT (SYSUTCDATETIME()),
    UpdatedAtUtc         datetime2(3) NULL,
    RowVer               rowversion NOT NULL,

    CONSTRAINT PK_AnalysisCase PRIMARY KEY CLUSTERED (AnalysisCaseId),
    CONSTRAINT UQ_AnalysisCase_CaseKey UNIQUE (CaseKey)
);
GO

/* --------------------------------------------------------------------------
   AssetContext

   This is a case-scoped analytical snapshot, not yet the enterprise asset
   master. It avoids coupling the Functional Lab DDL to the future ALEP/HCS/
   corporate asset-master integration decision.
   -------------------------------------------------------------------------- */
CREATE TABLE cmmslab.AssetContext
(
    AssetContextId       bigint IDENTITY(1,1) NOT NULL,
    AnalysisCaseId       bigint NOT NULL,
    AssetKey             nvarchar(80) NOT NULL,
    AssetCode            nvarchar(100) NOT NULL,
    AssetName            nvarchar(250) NOT NULL,
    Plant                nvarchar(200) NULL,
    UnitName             nvarchar(200) NULL,
    ServiceDescription   nvarchar(1000) NULL,
    BoundaryDescription  nvarchar(max) NULL,
    DutyFlowM3h           decimal(18,4) NULL,
    DutyPressureBar       decimal(18,4) NULL,
    RedundancyDescription nvarchar(1000) NULL,
    ConstraintsDescription nvarchar(max) NULL,
    DataConfidence       nvarchar(40) NULL,
    CreatedAtUtc         datetime2(3) NOT NULL CONSTRAINT DF_AssetContext_CreatedAtUtc DEFAULT (SYSUTCDATETIME()),
    UpdatedAtUtc         datetime2(3) NULL,
    RowVer               rowversion NOT NULL,

    CONSTRAINT PK_AssetContext PRIMARY KEY CLUSTERED (AssetContextId),
    CONSTRAINT FK_AssetContext_AnalysisCase
        FOREIGN KEY (AnalysisCaseId) REFERENCES cmmslab.AnalysisCase (AnalysisCaseId),
    CONSTRAINT UQ_AssetContext_Case_AssetKey UNIQUE (AnalysisCaseId, AssetKey)
);
GO

CREATE INDEX IX_AssetContext_AssetCode
    ON cmmslab.AssetContext (AssetCode)
    INCLUDE (AssetName, Plant, UnitName);
GO

/* --------------------------------------------------------------------------
   OperatingMode
   -------------------------------------------------------------------------- */
CREATE TABLE cmmslab.OperatingMode
(
    OperatingModeId      bigint IDENTITY(1,1) NOT NULL,
    AssetContextId       bigint NOT NULL,
    OperatingModeKey     nvarchar(80) NOT NULL,
    ModeName             nvarchar(200) NOT NULL,
    SortOrder            int NOT NULL CONSTRAINT DF_OperatingMode_SortOrder DEFAULT (0),

    CONSTRAINT PK_OperatingMode PRIMARY KEY CLUSTERED (OperatingModeId),
    CONSTRAINT FK_OperatingMode_AssetContext
        FOREIGN KEY (AssetContextId) REFERENCES cmmslab.AssetContext (AssetContextId),
    CONSTRAINT UQ_OperatingMode_Asset_Key UNIQUE (AssetContextId, OperatingModeKey)
);
GO

/* --------------------------------------------------------------------------
   EvidenceSource
   -------------------------------------------------------------------------- */
CREATE TABLE cmmslab.EvidenceSource
(
    EvidenceSourceId     bigint IDENTITY(1,1) NOT NULL,
    AnalysisCaseId       bigint NOT NULL,
    EvidenceKey          nvarchar(80) NOT NULL,
    SourceName           nvarchar(250) NOT NULL,
    SourceType           nvarchar(100) NULL,
    AvailabilityStatus   nvarchar(40) NOT NULL CONSTRAINT DF_Evidence_Availability DEFAULT (N'to_confirm'),
    IsCritical           bit NOT NULL CONSTRAINT DF_Evidence_IsCritical DEFAULT (0),
    Notes                nvarchar(1000) NULL,
    CreatedAtUtc         datetime2(3) NOT NULL CONSTRAINT DF_Evidence_CreatedAtUtc DEFAULT (SYSUTCDATETIME()),

    CONSTRAINT PK_EvidenceSource PRIMARY KEY CLUSTERED (EvidenceSourceId),
    CONSTRAINT FK_EvidenceSource_AnalysisCase
        FOREIGN KEY (AnalysisCaseId) REFERENCES cmmslab.AnalysisCase (AnalysisCaseId),
    CONSTRAINT UQ_EvidenceSource_Case_Key UNIQUE (AnalysisCaseId, EvidenceKey),
    CONSTRAINT CK_EvidenceSource_AvailabilityStatus
        CHECK (AvailabilityStatus IN (N'available', N'missing', N'to_confirm'))
);
GO

CREATE INDEX IX_EvidenceSource_Case_Status
    ON cmmslab.EvidenceSource (AnalysisCaseId, AvailabilityStatus)
    INCLUDE (IsCritical, SourceName);
GO

/* --------------------------------------------------------------------------
   AssetFunction
   -------------------------------------------------------------------------- */
CREATE TABLE cmmslab.AssetFunction
(
    AssetFunctionId      bigint IDENTITY(1,1) NOT NULL,
    AnalysisCaseId       bigint NOT NULL,
    AssetContextId       bigint NOT NULL,
    FunctionKey          nvarchar(80) NOT NULL,
    FunctionType         nvarchar(40) NOT NULL,
    FunctionText         nvarchar(max) NOT NULL,
    PerformanceStandard  nvarchar(max) NULL,
    SortOrder            int NOT NULL CONSTRAINT DF_AssetFunction_SortOrder DEFAULT (0),
    ValidationStatus     nvarchar(40) NOT NULL CONSTRAINT DF_AssetFunction_ValidationStatus DEFAULT (N'draft'),
    CreatedAtUtc         datetime2(3) NOT NULL CONSTRAINT DF_AssetFunction_CreatedAtUtc DEFAULT (SYSUTCDATETIME()),
    UpdatedAtUtc         datetime2(3) NULL,
    RowVer               rowversion NOT NULL,

    CONSTRAINT PK_AssetFunction PRIMARY KEY CLUSTERED (AssetFunctionId),
    CONSTRAINT FK_AssetFunction_AnalysisCase
        FOREIGN KEY (AnalysisCaseId) REFERENCES cmmslab.AnalysisCase (AnalysisCaseId),
    CONSTRAINT FK_AssetFunction_AssetContext
        FOREIGN KEY (AssetContextId) REFERENCES cmmslab.AssetContext (AssetContextId),
    CONSTRAINT UQ_AssetFunction_Case_Key UNIQUE (AnalysisCaseId, FunctionKey),
    CONSTRAINT CK_AssetFunction_FunctionType
        CHECK (FunctionType IN (N'main', N'secondary', N'other'))
);
GO

CREATE INDEX IX_AssetFunction_AssetContext
    ON cmmslab.AssetFunction (AssetContextId, SortOrder);
GO

/* --------------------------------------------------------------------------
   FunctionalFailure
   -------------------------------------------------------------------------- */
CREATE TABLE cmmslab.FunctionalFailure
(
    FunctionalFailureId bigint IDENTITY(1,1) NOT NULL,
    AssetFunctionId     bigint NOT NULL,
    FunctionalFailureKey nvarchar(80) NOT NULL,
    FailureType         nvarchar(40) NOT NULL,
    FailureText         nvarchar(max) NOT NULL,
    SortOrder           int NOT NULL CONSTRAINT DF_FunctionalFailure_SortOrder DEFAULT (0),
    ValidationStatus    nvarchar(40) NOT NULL CONSTRAINT DF_FunctionalFailure_ValidationStatus DEFAULT (N'draft'),
    CreatedAtUtc        datetime2(3) NOT NULL CONSTRAINT DF_FunctionalFailure_CreatedAtUtc DEFAULT (SYSUTCDATETIME()),
    UpdatedAtUtc        datetime2(3) NULL,
    RowVer              rowversion NOT NULL,

    CONSTRAINT PK_FunctionalFailure PRIMARY KEY CLUSTERED (FunctionalFailureId),
    CONSTRAINT FK_FunctionalFailure_AssetFunction
        FOREIGN KEY (AssetFunctionId) REFERENCES cmmslab.AssetFunction (AssetFunctionId),
    CONSTRAINT UQ_FunctionalFailure_Function_Key UNIQUE (AssetFunctionId, FunctionalFailureKey),
    CONSTRAINT CK_FunctionalFailure_FailureType
        CHECK (FailureType IN (N'full', N'partial', N'other'))
);
GO

CREATE INDEX IX_FunctionalFailure_Function
    ON cmmslab.FunctionalFailure (AssetFunctionId, SortOrder);
GO

/* --------------------------------------------------------------------------
   FailureMode
   -------------------------------------------------------------------------- */
CREATE TABLE cmmslab.FailureMode
(
    FailureModeId        bigint IDENTITY(1,1) NOT NULL,
    FunctionalFailureId bigint NOT NULL,
    FailureModeKey       nvarchar(80) NOT NULL,
    ModeCode             nvarchar(50) NULL,
    ModeName             nvarchar(250) NOT NULL,
    ModeDescription      nvarchar(max) NULL,
    IsFocusMode          bit NOT NULL CONSTRAINT DF_FailureMode_IsFocus DEFAULT (0),
    IsExcluded           bit NOT NULL CONSTRAINT DF_FailureMode_IsExcluded DEFAULT (0),
    ExclusionReason      nvarchar(max) NULL,
    ValidationStatus     nvarchar(40) NOT NULL CONSTRAINT DF_FailureMode_ValidationStatus DEFAULT (N'draft'),
    SortOrder            int NOT NULL CONSTRAINT DF_FailureMode_SortOrder DEFAULT (0),
    CreatedAtUtc         datetime2(3) NOT NULL CONSTRAINT DF_FailureMode_CreatedAtUtc DEFAULT (SYSUTCDATETIME()),
    UpdatedAtUtc         datetime2(3) NULL,
    RowVer               rowversion NOT NULL,

    CONSTRAINT PK_FailureMode PRIMARY KEY CLUSTERED (FailureModeId),
    CONSTRAINT FK_FailureMode_FunctionalFailure
        FOREIGN KEY (FunctionalFailureId) REFERENCES cmmslab.FunctionalFailure (FunctionalFailureId),
    CONSTRAINT UQ_FailureMode_Failure_Key UNIQUE (FunctionalFailureId, FailureModeKey),
    CONSTRAINT CK_FailureMode_ExcludedReason
        CHECK (IsExcluded = 0 OR ExclusionReason IS NOT NULL)
);
GO

CREATE INDEX IX_FailureMode_FunctionalFailure
    ON cmmslab.FailureMode (FunctionalFailureId, SortOrder)
    INCLUDE (ModeCode, ModeName, IsFocusMode, IsExcluded);
GO

/* --------------------------------------------------------------------------
   FailureEffect
   -------------------------------------------------------------------------- */
CREATE TABLE cmmslab.FailureEffect
(
    FailureEffectId      bigint IDENTITY(1,1) NOT NULL,
    FailureModeId        bigint NOT NULL,
    FailureEffectKey     nvarchar(80) NOT NULL,
    LocalEffect          nvarchar(max) NULL,
    SystemEffect         nvarchar(max) NULL,
    OperationalEffect    nvarchar(max) NULL,
    CreatedAtUtc         datetime2(3) NOT NULL CONSTRAINT DF_FailureEffect_CreatedAtUtc DEFAULT (SYSUTCDATETIME()),
    UpdatedAtUtc         datetime2(3) NULL,
    RowVer               rowversion NOT NULL,

    CONSTRAINT PK_FailureEffect PRIMARY KEY CLUSTERED (FailureEffectId),
    CONSTRAINT FK_FailureEffect_FailureMode
        FOREIGN KEY (FailureModeId) REFERENCES cmmslab.FailureMode (FailureModeId),
    CONSTRAINT UQ_FailureEffect_Mode_Key UNIQUE (FailureModeId, FailureEffectKey)
);
GO

/* --------------------------------------------------------------------------
   DecisionTrace

   Generic trace structure only. It intentionally does not encode the future
   RCM tree or risk algorithm. Payload snapshots are stored as JSON text in this
   candidate because their exact relational contracts are not yet frozen.
   -------------------------------------------------------------------------- */
CREATE TABLE cmmslab.DecisionTrace
(
    DecisionTraceId      bigint IDENTITY(1,1) NOT NULL,
    AnalysisCaseId       bigint NOT NULL,
    TraceKey             nvarchar(80) NOT NULL,
    StageId              nvarchar(30) NOT NULL,
    RuleId               nvarchar(80) NULL,
    ConfigurationKey     nvarchar(80) NULL,
    InputSnapshotJson    nvarchar(max) NULL,
    SystemResultJson     nvarchar(max) NULL,
    SystemRecommendation nvarchar(max) NULL,
    HumanDecision        nvarchar(max) NULL,
    Reason               nvarchar(max) NULL,
    ActorRole            nvarchar(150) NULL,
    ValidationStatus     nvarchar(40) NULL,
    OccurredAtUtc        datetime2(3) NOT NULL CONSTRAINT DF_DecisionTrace_OccurredAtUtc DEFAULT (SYSUTCDATETIME()),

    CONSTRAINT PK_DecisionTrace PRIMARY KEY CLUSTERED (DecisionTraceId),
    CONSTRAINT FK_DecisionTrace_AnalysisCase
        FOREIGN KEY (AnalysisCaseId) REFERENCES cmmslab.AnalysisCase (AnalysisCaseId),
    CONSTRAINT UQ_DecisionTrace_Case_Key UNIQUE (AnalysisCaseId, TraceKey),
    CONSTRAINT CK_DecisionTrace_InputJson
        CHECK (InputSnapshotJson IS NULL OR ISJSON(InputSnapshotJson) = 1),
    CONSTRAINT CK_DecisionTrace_ResultJson
        CHECK (SystemResultJson IS NULL OR ISJSON(SystemResultJson) = 1)
);
GO

CREATE INDEX IX_DecisionTrace_Case_Stage_Time
    ON cmmslab.DecisionTrace (AnalysisCaseId, StageId, OccurredAtUtc);
GO

/* --------------------------------------------------------------------------
   GateResult
   -------------------------------------------------------------------------- */
CREATE TABLE cmmslab.GateResult
(
    GateResultId         bigint IDENTITY(1,1) NOT NULL,
    AnalysisCaseId       bigint NOT NULL,
    GateKey              nvarchar(80) NOT NULL,
    StageId              nvarchar(30) NOT NULL,
    GateStatus           nvarchar(30) NOT NULL,
    ReasonCode           nvarchar(80) NULL,
    ReasonText           nvarchar(max) NULL,
    MissingDataJson      nvarchar(max) NULL,
    CheckedAtUtc         datetime2(3) NOT NULL CONSTRAINT DF_GateResult_CheckedAtUtc DEFAULT (SYSUTCDATETIME()),
    RowVer               rowversion NOT NULL,

    CONSTRAINT PK_GateResult PRIMARY KEY CLUSTERED (GateResultId),
    CONSTRAINT FK_GateResult_AnalysisCase
        FOREIGN KEY (AnalysisCaseId) REFERENCES cmmslab.AnalysisCase (AnalysisCaseId),
    CONSTRAINT UQ_GateResult_Case_Gate UNIQUE (AnalysisCaseId, GateKey),
    CONSTRAINT CK_GateResult_Status
        CHECK (GateStatus IN (N'passed', N'blocked', N'warning', N'not_evaluated')),
    CONSTRAINT CK_GateResult_MissingDataJson
        CHECK (MissingDataJson IS NULL OR ISJSON(MissingDataJson) = 1)
);
GO

CREATE INDEX IX_GateResult_Case_Stage
    ON cmmslab.GateResult (AnalysisCaseId, StageId)
    INCLUDE (GateStatus, ReasonCode, CheckedAtUtc);
GO

/* --------------------------------------------------------------------------
   Candidate read model for WS-01

   This view demonstrates the provider boundary. It is NOT intended to be the
   final production read model.
   -------------------------------------------------------------------------- */
CREATE VIEW cmmslab.V_CaseContext
AS
SELECT
    c.CaseKey,
    c.CaseName,
    c.FixtureVersion,
    c.ValidationStatus AS CaseValidationStatus,
    a.AssetKey,
    a.AssetCode,
    a.AssetName,
    a.Plant,
    a.UnitName,
    a.ServiceDescription,
    a.BoundaryDescription,
    a.DutyFlowM3h,
    a.DutyPressureBar,
    a.RedundancyDescription,
    a.ConstraintsDescription,
    a.DataConfidence
FROM cmmslab.AnalysisCase AS c
INNER JOIN cmmslab.AssetContext AS a
    ON a.AnalysisCaseId = c.AnalysisCaseId
WHERE c.IsActive = 1;
GO

/* --------------------------------------------------------------------------
   Review gates before any production use
   --------------------------------------------------------------------------
   [ ] Validate names and ownership with the functional model
   [ ] Validate whether AssetContext remains snapshot vs master relation
   [ ] Validate retention/versioning strategy
   [ ] Validate audit actor identity model
   [ ] Validate JSON use in trace payloads
   [ ] Validate security model and schema ownership
   [ ] Validate indexes with real access patterns
   [ ] Run database integrity/security audit
   [ ] Produce Collection <-> Contract <-> SQL mapping
   [ ] Do not add Risk/RCM/Plan/WO tables until their specific contract gates
       have been completed
   -------------------------------------------------------------------------- */
