# CMMS 2.0 Functional Lab — Contratos de dominio

**Estado:** base conceptual para UI y futuro backend  
**Fecha:** 2026-08-10

## 1. Objetivo

Definir objetos persistentes suficientemente estables para que las pantallas Power Apps no dependan de la forma temporal del fixture P-101.

## 2. Convenciones

Toda entidad persistente debe prever:

```text
Id
CreatedAt
CreatedBy
UpdatedAt
UpdatedBy
RowVersion / mecanismo equivalente
Status cuando aplique
```

Las claves se expresan aquí conceptualmente. Los tipos SQL concretos se decidirán en la especificación de datos.

## 3. Activos

### TechnicalObject

```text
TechnicalObjectId
Code
Name
ObjectType
Description
Status
ParentTechnicalObjectId?
PlantCode?
LocationCode?
```

### AssetHierarchyNode

```text
HierarchyNodeId
HierarchyType        FLH | otra
TechnicalObjectId?
ParentNodeId?
Level
SortPath
PathText
NodeType
ValidFrom?
ValidTo?
```

### AssetClassification

```text
ClassificationId
TechnicalObjectId
Scheme               ISO14224 | corporate | other
ClassCode
ClassName
Level
ParentClassCode?
Source
```

### ADRRelation

```text
ADRRelationId
SourceTechnicalObjectId
TargetTechnicalObjectId
RelationType
Direction
Criticality?
Description
ValidFrom?
ValidTo?
```

## 4. Caso de análisis

### AnalysisCase

```text
AnalysisCaseId
CaseCode
Title
TechnicalObjectId
CaseType
LifecycleStatus      Draft | InReview | Approved | Frozen | Reopened
CurrentStageId
CurrentVersion
OwnerRole
OpenedAt
ClosedAt?
```

### AnalysisStageExecution

```text
StageExecutionId
AnalysisCaseId
StageId              FL-01 ... FL-28
StageStatus          NotStarted | Draft | Blocked | Warning | Confirmed | Approved
ScreenKey
GateStatus?
GateReason?
ResponsibleRole
StartedAt?
ConfirmedAt?
ConfirmedBy?
```

### Evidence

```text
EvidenceId
AnalysisCaseId
StageId?
EvidenceType
SourceReference
Description
Confidence
IsConfirmed
ConfirmedBy?
ConfirmedAt?
```

## 5. Funciones y fallos

### Function

```text
FunctionId
AnalysisCaseId
FunctionType
Statement
PerformanceStandard?
OperatingMode?
Sequence
Status
```

### FunctionalFailure

```text
FunctionalFailureId
FunctionId
FailureType          Total | Partial
Statement
Threshold?
Sequence
```

### FailureMode

Catálogo o modo contextual según decisión futura:

```text
FailureModeId
Code
Name
Description
MechanismCategory?
```

### FailureModeSelection

```text
FailureModeSelectionId
AnalysisCaseId
FunctionalFailureId?
FailureModeId
Included
SystemRecommended
HumanConfirmed
DecisionReason?
ActorRole
DecisionAt?
```

## 6. AMEF / riesgo

### FailureEffect

```text
FailureEffectId
AnalysisCaseId
FailureModeSelectionId
LocalEffect
SystemEffect
OperationalEffect
EvidenceSummary?
```

### RiskAssessment

```text
RiskAssessmentId
AnalysisCaseId
FailureModeSelectionId
ConsequenceClass
Severity
Occurrence
Detection
RiskScore
CriticalOverride
OverrideReason?
ExistingControls
Confidence
ExceptionText?
AssessmentStatus
```

## 7. Decisión RCM

### RCMAnalysis

```text
RCMAnalysisId
AnalysisCaseId
FailureModeSelectionId
IsEvident
IsDetectable
PFEvidence
PFDays?
InterventionDays?
DetectionProbabilityPct?
AgeRelatedStatus
TechnicalPolicyStatus
SelectedStrategy?
FallbackStrategy?
AuthorityRole
Status
```

### SystemRecommendation

```text
SystemRecommendationId
AnalysisCaseId
StageId
RecommendationType
RecommendationValue
Explanation
RuleId?
EngineType           Rule | Analytics | Expert | AI
EngineVersion?
GeneratedAt
```

### HumanDecision

```text
HumanDecisionId
AnalysisCaseId
StageId
DecisionType
DecisionValue
RelatedRecommendationId?
IsOverride
Reason?
ActorRole
ActorId?
DecisionAt
Status
```

## 8. Economía, tarea y plan

### EconomicAssessment

```text
EconomicAssessmentId
AnalysisCaseId
AlternativeCode
ExpectedAnnualCost
InvestmentCost
AvoidedRiskValue?
AssumptionsJson/structured equivalent
SystemRank?
HumanSelected
```

### MaintenanceStrategy

```text
MaintenanceStrategyId
AnalysisCaseId
StrategyType
Rationale
Authority
Status
```

### MaintenanceTask

```text
MaintenanceTaskId
AnalysisCaseId
MaintenanceStrategyId
Name
Technique
AcceptanceCriterion
ActionIfFailed
TaskType
Status
```

### IntervalJustification

```text
IntervalJustificationId
MaintenanceTaskId
IntervalValue
IntervalUnit
PFFactor?
PlanningWindowDays?
CalculatedRecommendation?
HumanConfirmedInterval
Reason?
```

### ResourceRequirement

```text
ResourceRequirementId
MaintenanceTaskId
ResourceType
ResourceCode?
Description
Quantity?
Unit?
```

### MaintenancePlanPackage

```text
MaintenancePlanPackageId
AnalysisCaseId
Discipline
WorkCenter
Crew
ShutdownRequirement
PermitRequirement
ScopeSummary
Grouping
ExportModel
GateStatus
```

## 9. Gobernanza

### TraceLink

```text
TraceLinkId
AnalysisCaseId
FromEntityType
FromEntityId
ToEntityType
ToEntityId
TraceType
Status
```

### QualityFinding

```text
QualityFindingId
AnalysisCaseId
StageId?
Severity
FindingType
Description
Status
Resolution?
ResolvedBy?
ResolvedAt?
```

### Review

```text
ReviewId
AnalysisCaseId
ReviewType
ReviewerRole
Position
Comment
Status
ReviewedAt?
```

### Approval

```text
ApprovalId
AnalysisCaseId
ApprovalRole
ApprovalStatus
Comment?
ApprovedBy?
ApprovedAt?
```

### VersionSnapshot

```text
VersionSnapshotId
AnalysisCaseId
Version
SnapshotStatus
SnapshotReference
CreatedAt
CreatedBy
IsImmutable
```

## 10. Efectividad y cambio

### EffectivenessMeasurement

```text
EffectivenessMeasurementId
AnalysisCaseId
MetricCode
HypothesisValue?
ActualValue
Unit
PeriodStart
PeriodEnd
Assessment
```

### ChangeRequest

```text
ChangeRequestId
AnalysisCaseId
Reason
Scope
RequestedByRole
Status
OpenedAt
ClosedAt?
```

### AuditEvent

```text
AuditEventId
AnalysisCaseId?
EntityType
EntityId
EventType
ActorRole
ActorId?
Timestamp
BeforeReference?
AfterReference?
Reason?
```

## 11. Contrato de pantalla

Cada pantalla debe declarar qué entidades:

```text
READS
EDITS_AS_DRAFT
CALCULATES
RECOMMENDS
CONFIRMS
CREATES
TRANSITIONS
```

Ejemplo `scr_FL_AMEF`:

```text
READS          FailureModeSelection, Evidence
EDITS_AS_DRAFT FailureEffect, RiskAssessment inputs
CALCULATES     RiskScore
RECOMMENDS     ConsequenceClass / priority when rules exist
CONFIRMS       HumanDecision for consequence/override
CREATES        RiskAssessment
TRANSITIONS    AnalysisStageExecution FL-07..FL-11
```
