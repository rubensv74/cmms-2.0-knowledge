# CMMS 2.0 Functional Lab — Contratos de dominio alineados

**Estado:** base conceptual corregida para UI y futuro backend  
**Fecha:** 2026-08-10

## 1. Objetivo

Definir objetos persistentes que reflejen las conclusiones funcionales de las reuniones y eviten que el caso P-101 se convierta accidentalmente en el modelo de datos.

La regla principal es separar:

```text
biblioteca de ingeniería
contexto de planta
aplicación a activo
planificación / ejecución
gobernanza / mejora
```

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

Los tipos SQL concretos quedan fuera del Functional Lab.

# PARTE A — ACTIVOS Y CONTEXTO DE PLANTA

## 3. TechnicalObject

```text
TechnicalObjectId
Code
Name
ObjectType
Description
Status
PlantCode?
LocationCode?
```

## 4. AssetHierarchyNode

```text
HierarchyNodeId
HierarchyType       FLH | other
TechnicalObjectId?
ParentNodeId?
Level
SortPath
PathText
NodeType
ValidFrom?
ValidTo?
```

## 5. AssetClassification

```text
ClassificationId
TechnicalObjectId
Scheme              ISO14224 | corporate | other
ClassCode
ClassName
Level
ParentClassCode?
Source
```

## 6. ADRRelation

```text
ADRRelationId
SourceTechnicalObjectId
TargetTechnicalObjectId
RelationType
Direction
Description
ValidFrom?
ValidTo?
```

ADR no se fuerza a una jerarquía única. La UI puede agrupar relaciones padre/hijo visualmente, pero el contrato persistente sigue siendo `origen → relación → destino`.

## 7. AssetCriticalityAssessment

```text
AssetCriticalityAssessmentId
TechnicalObjectId
CriticalitySchemeId?
CriticalityClass          High | Medium | Low | Negligible | other
CriticalityScore?
ProductionImpact?
SafetyImpact?
EnvironmentalImpact?
RedundancyContext?
ServiceContext?
AssessmentReason
SourceReference?
Revision
ValidFrom
ValidTo?
Status
```

Este objeto representa la **criticidad del activo dentro de la planta**. No es el RiskAssessment AMEF.

# PARTE B — BIBLIOTECA AMEF / RCM

## 8. FmeaDefinition

```text
FmeaDefinitionId
Code
Name
EquipmentFamilyCode
EquipmentFamilyName
TaxonomyReference?
Description
OwnerRole
LifecycleStatus        Draft | InReview | Approved | Retired
```

Ejemplo:

```text
AMEF-BOMBA-CENTRIFUGA
```

## 9. FmeaRevision

```text
FmeaRevisionId
FmeaDefinitionId
RevisionCode
RevisionStatus        Draft | InReview | Approved | Superseded
EffectiveFrom?
EffectiveTo?
ChangeSummary
ApprovedBy?
ApprovedAt?
IsFrozen
```

Funciones, fallos, modos, causas, efectos y tareas base se versionan respecto a esta revisión.

## 10. Function

```text
FunctionId
FmeaRevisionId
FunctionType
Statement
PerformanceStandard?
OperatingMode?
Sequence
Status
```

## 11. FunctionalFailure

```text
FunctionalFailureId
FunctionId
FailureType          Total | Partial
Statement
Threshold?
Sequence
```

## 12. FailureMode

```text
FailureModeId
FmeaRevisionId
FunctionalFailureId?
Code
Name
Description
MechanismCategory?
Sequence
Status
```

## 13. FailureCause

```text
FailureCauseId
FailureModeId
CauseCode?
CauseType?
Statement
Mechanism
EvidenceReference?
Sequence
Status
```

Un modo puede disponer de una o varias causas/mecanismos.

## 14. FailureEffect

```text
FailureEffectId
FailureModeId
LocalEffect
SystemEffect
OperationalEffect
SafetyEffect?
EnvironmentalEffect?
EvidenceSummary?
Status
```

## 15. ProposedMaintenanceTask

```text
ProposedMaintenanceTaskId
FmeaRevisionId
TaskCode
Name
TaskType
Technique
BaseAcceptanceCriterion?
BaseActionIfFailed?
BaseIntervalValue?
BaseIntervalUnit?
ProcedureRequiredByDefault
Status
```

Es una propuesta de ingeniería reusable. Todavía no es un Job Plan ni una orden de trabajo.

## 16. ProposedTaskFailureMode

```text
ProposedTaskFailureModeId
ProposedMaintenanceTaskId
FailureModeId
CoverageType          Detect | Prevent | Test | Restore | Mitigate | other
CoverageRationale
Status
```

Resuelve la relación N:M entre tareas y modos.

# PARTE C — LÓGICA RCM VERSIONABLE

## 17. DecisionLogic

```text
DecisionLogicId
Code
Name
MethodologyReference?
OwnerRole
Status
```

## 18. DecisionLogicRevision

```text
DecisionLogicRevisionId
DecisionLogicId
RevisionCode
Status
EffectiveFrom?
EffectiveTo?
ApprovedBy?
ApprovedAt?
```

## 19. DecisionQuestion

```text
DecisionQuestionId
DecisionLogicRevisionId
QuestionCode
QuestionText
QuestionType
Sequence
RequiredEvidenceType?
ResponsibleRole?
```

## 20. DecisionTransition

```text
DecisionTransitionId
DecisionQuestionId
AnswerCode
AnswerLabel
NextQuestionId?
OutcomeCode?
RecommendationCode?
```

El árbol concreto puede configurarse sin reconstruir la pantalla.

# PARTE D — APLICACIÓN A ACTIVOS

## 21. FmeaAssetApplication

```text
FmeaAssetApplicationId
TechnicalObjectId
FmeaRevisionId
AssetCriticalityAssessmentId
ApplicationCode
ApplicabilityStatus       Proposed | Applicable | PartiallyApplicable | NotApplicable
ApplicabilityProfileCode?
ContextSummary
AppliedAt?
AppliedBy?
Status
```

## 22. FmeaApplicabilityRule

```text
FmeaApplicabilityRuleId
FmeaRevisionId
RuleCode
RuleDescription
RuleType
ConditionExpression / structured equivalent
RecommendedProfile?
Status
```

## 23. MaintenanceApplicabilityProfile

```text
MaintenanceApplicabilityProfileId
FmeaRevisionId
ProfileCode
ProfileName
CriticalityClass?
Description
Status
```

Ejemplo conceptual:

```text
HIGH
MEDIUM
LOW
NEGLIGIBLE
```

Las denominaciones definitivas siguen pendientes de validación corporativa.

## 24. TaskProfileVariant

```text
TaskProfileVariantId
FmeaAssetApplicationId
ProposedMaintenanceTaskId
MaintenanceApplicabilityProfileId?
IsApplicable
IntervalValue?
IntervalUnit?
TaskTypeOverride?
TechniqueOverride?
Reason
IsOverride
ActorRole?
ConfirmedAt?
```

Permite modificar frecuencia/tratamiento sin duplicar el AMEF base.

# PARTE E — ANALYSIS CASE Y TRAZABILIDAD DEL RAZONAMIENTO

## 25. AnalysisCase

```text
AnalysisCaseId
CaseCode
Title
TechnicalObjectId
FmeaRevisionId
FmeaAssetApplicationId
AssetCriticalityAssessmentId
CaseType
LifecycleStatus      Draft | InReview | Approved | Frozen | Reopened
CurrentStageId
CurrentVersion
OwnerRole
OpenedAt
ClosedAt?
```

`AnalysisCase` organiza la revisión contextual; no posee la ingeniería de biblioteca.

## 26. AnalysisStageExecution

```text
StageExecutionId
AnalysisCaseId
StageId
StageStatus          NotStarted | Draft | Blocked | Warning | Confirmed | Approved
ScreenKey
GateStatus?
GateReason?
ResponsibleRole
StartedAt?
ConfirmedAt?
ConfirmedBy?
```

## 27. Evidence

```text
EvidenceId
AnalysisCaseId?
FmeaRevisionId?
StageId?
EvidenceType
SourceReference
Description
Confidence
IsConfirmed
ConfirmedBy?
ConfirmedAt?
```

La evidencia puede pertenecer a biblioteca o a aplicación contextual.

## 28. FailureModeApplication

```text
FailureModeApplicationId
FmeaAssetApplicationId
FailureModeId
Included
SystemRecommended
HumanConfirmed
DecisionReason?
ActorRole
DecisionAt?
```

Sustituye conceptualmente a `FailureModeSelection` como propiedad del caso y deja claro que el modo procede de biblioteca.

# PARTE F — AMEF CONTEXTUAL

## 29. RiskAssessment

```text
RiskAssessmentId
AnalysisCaseId
FailureModeApplicationId
ConsequenceClass
Severity
Occurrence
Detection
MatrixScore
RiskScore            NPR u otro indicador configurado
CriticalOverride
OverrideReason?
ExistingControls
Confidence
ExceptionText?
AssessmentStatus
```

`RiskAssessment` evalúa el modo dentro de la aplicación. No representa `AssetCriticalityAssessment`.

## 30. SystemRecommendation

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

## 31. HumanDecision

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

# PARTE G — RCM CONTEXTUAL

## 32. RcmAssessment

```text
RcmAssessmentId
AnalysisCaseId
FailureModeApplicationId
DecisionLogicRevisionId
AssessmentStatus
SelectedOutcome?
SelectedStrategy?
FallbackStrategy?
AuthorityRole
```

## 33. RcmAssessmentAnswer

```text
RcmAssessmentAnswerId
RcmAssessmentId
DecisionQuestionId
AnswerCode
AnswerValue?
EvidenceId?
SystemRecommendationId?
HumanDecisionId?
AnsweredAt
```

## 34. PFFeasibilityAssessment

```text
PFFeasibilityAssessmentId
RcmAssessmentId
FailureModeApplicationId
IsDetectable
PFEvidence
PFDays?
InterventionDays?
DetectionProbabilityPct?
RecommendedInterval?
Assumptions
Status
```

# PARTE H — ECONOMÍA

## 35. EconomicAssessment

```text
EconomicAssessmentId
AnalysisCaseId
AlternativeCode
ExpectedAnnualCost
InvestmentCost
AvoidedRiskValue?
AssumptionsJson / structured equivalent
SystemRank?
HumanSelected
```

Es una comparación previa de alternativas, no el coste final del plan.

## 36. MaintenanceCostEstimate

```text
MaintenanceCostEstimateId
MaintenanceTaskId
IntervalValue
IntervalUnit
EstimatedLaborCost
EstimatedMaterialCost
EstimatedServiceCost
EstimatedDowntimeCost?
EstimatedAnnualCost
Assumptions
CalculatedAt
```

## 37. ActualMaintenanceCost

```text
ActualMaintenanceCostId
WorkOrderId
LaborCost
MaterialCost
ServiceCost
DowntimeCost?
TotalCost
SourceReference
CalculatedAt
```

# PARTE I — TAREA EJECUTABLE Y PROCEDIMIENTO

## 38. MaintenanceStrategy

```text
MaintenanceStrategyId
AnalysisCaseId
StrategyType
Rationale
Authority
Status
```

## 39. MaintenanceTask

```text
MaintenanceTaskId
AnalysisCaseId
TaskProfileVariantId?
MaintenanceStrategyId
Name
Technique
AcceptanceCriterion
ActionIfFailed
TaskType
RequiredOperatingState
RequiresShutdown
IsolationRequirement?
PermitRequirement?
EstimatedDuration
DurationUnit
CrewSize
EstimatedManHours
Discipline
WorkCenter
Status
```

## 40. IntervalJustification

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

## 41. ResourceRequirement

```text
ResourceRequirementId
MaintenanceTaskId
ResourceType          Labor | Material | Tool | ExternalService | other
ResourceCode?
Description
Discipline?
Quantity?
Unit?
UnitCost?
```

## 42. MaintenanceProcedure

```text
MaintenanceProcedureId
ProcedureCode
Name
ProcedureType        Procedure | Checklist | InspectionFormat
Revision
Status
OwnerRole
```

## 43. TaskProcedureLink

```text
TaskProcedureLinkId
MaintenanceTaskId
MaintenanceProcedureId
IsRequired
Reason?
```

La ausencia de link es válida cuando la tarea no necesita procedimiento.

# PARTE J — ALCANCE, AGRUPACIÓN Y HANDOFF CMMS

## 44. MaintenancePlanPackage

```text
MaintenancePlanPackageId
AnalysisCaseId
Discipline
WorkCenter
Crew
ScopeSummary
ExportModel
GateStatus
```

Las restricciones de parada/permiso se derivan de las tareas incluidas; no viven únicamente aquí.

## 45. PlanScopeItem

```text
PlanScopeItemId
MaintenancePlanPackageId
TechnicalObjectId
MaintenanceTaskId?
TaskProfileVariantId?
RoleInScope           MainEquipment | SupportEquipment | Instrument | Auxiliary | other
Sequence
```

## 46. MaintenanceCycle

```text
MaintenanceCycleId
CycleCode
CycleValue
CycleUnit
Tolerance?
Status
```

## 47. RouteGroupingRule

```text
RouteGroupingRuleId
RuleCode
Name
GroupingDimension    Frequency | Activity | Plant | Executor | Location | other
Priority
ConditionExpression / structured equivalent
Status
```

## 48. ObjectList

```text
ObjectListId
Code
Name
Description
Status
```

## 49. ObjectListItem

```text
ObjectListItemId
ObjectListId
TechnicalObjectId
Sequence
```

## 50. JobPlan

```text
JobPlanId
JobPlanCode
Name
Revision
Discipline
WorkCenter
MaintenanceProcedureId?
ObjectListId?
Status
```

## 51. JobPlanTask

```text
JobPlanTaskId
JobPlanId
MaintenanceTaskId
Sequence
```

## 52. PreventiveMaintenancePlan

```text
PreventiveMaintenancePlanId
PlanCode
Name
JobPlanId
MaintenanceCycleId
ObjectListId?
StartDate?
SchedulingParameters
Status
```

## 53. WorkOrder

```text
WorkOrderId
PreventiveMaintenancePlanId?
TechnicalObjectId
JobPlanId?
ScheduledStart?
ScheduledEnd?
ActualStart?
ActualEnd?
Status
SourceSystem?
```

## 54. ExecutionResult

```text
ExecutionResultId
WorkOrderId
TechnicalObjectId
MaintenanceTaskId?
ResultCode
ResultText
MeasurementValue?
MeasurementUnit?
FindingCode?
CompletedBy?
CompletedAt?
```

Agrupar en ruta/Job Plan nunca elimina el `TechnicalObjectId` del resultado.

# PARTE K — GOBERNANZA Y MEJORA

## 55. TraceLink

```text
TraceLinkId
AnalysisCaseId?
FromEntityType
FromEntityId
ToEntityType
ToEntityId
TraceType
Status
```

Debe poder reconstruir:

```text
FmeaRevision
→ FailureMode
→ RCM decision
→ ProposedMaintenanceTask
→ TaskProfileVariant
→ MaintenanceTask
→ Procedure / JobPlan
→ PM
→ WO
→ ExecutionResult
```

## 56. QualityFinding

```text
QualityFindingId
AnalysisCaseId?
FmeaRevisionId?
StageId?
Severity
FindingType
Description
Status
Resolution?
ResolvedBy?
ResolvedAt?
```

## 57. Review

```text
ReviewId
AnalysisCaseId?
FmeaRevisionId?
ReviewType
ReviewerRole
Position
Comment
Status
ReviewedAt?
```

## 58. Approval

```text
ApprovalId
AnalysisCaseId?
FmeaRevisionId?
ApprovalRole
ApprovalStatus
Comment?
ApprovedBy?
ApprovedAt?
```

## 59. VersionSnapshot

```text
VersionSnapshotId
AnalysisCaseId?
FmeaRevisionId?
Version
SnapshotStatus
SnapshotReference
CreatedAt
CreatedBy
IsImmutable
```

## 60. EffectivenessMeasurement

```text
EffectivenessMeasurementId
AnalysisCaseId?
FmeaAssetApplicationId?
MaintenanceTaskId?
MetricCode
HypothesisValue?
ActualValue
Unit
PeriodStart
PeriodEnd
Assessment
```

## 61. ChangeRequest

```text
ChangeRequestId
AnalysisCaseId?
FmeaRevisionId?
FmeaAssetApplicationId?
Reason
Scope
RequestedByRole
Status
OpenedAt
ClosedAt?
```

## 62. AuditEvent

```text
AuditEventId
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

# PARTE L — CONTRATOS DE PANTALLA

Cada pantalla declara:

```text
READS
EDITS_AS_DRAFT
CALCULATES
RECOMMENDS
CONFIRMS
CREATES
TRANSITIONS
```

Ejemplo `scr_FL_FmeaRevision`:

```text
READS          FmeaDefinition, FmeaRevision, Function, FunctionalFailure, FailureMode, FailureCause, FailureEffect, ProposedMaintenanceTask
EDITS_AS_DRAFT contenido de revisión si no está congelada
CONFIRMS       revisión técnica / aprobación según rol
CREATES        nueva revisión, nunca sobrescribe silenciosamente una aprobada
```

Ejemplo `scr_FL_AssetApplication`:

```text
READS          TechnicalObject, AssetCriticalityAssessment, FmeaRevision, ApplicabilityRule
CALCULATES     coincidencias y perfil sugerido
RECOMMENDS     aplicabilidad/perfil
CONFIRMS       FmeaAssetApplication + overrides
CREATES        TaskProfileVariant cuando corresponda
```

Ejemplo `scr_FL_AMEF`:

```text
READS          FmeaRevision, FailureModeApplication, AssetCriticalityAssessment, Evidence
EDITS_AS_DRAFT RiskAssessment contextual
CALCULATES     MatrixScore, RiskScore
RECOMMENDS     ConsequenceClass / priority when rules exist
CONFIRMS       HumanDecision for consequence/override
CREATES        RiskAssessment
TRANSITIONS    AnalysisStageExecution FL-07..FL-11
```

Ejemplo `scr_FL_Task`:

```text
READS          ProposedMaintenanceTask, TaskProfileVariant, RcmAssessment, PFFeasibilityAssessment
EDITS_AS_DRAFT MaintenanceTask, IntervalJustification, ResourceRequirement
CALCULATES     EstimatedManHours, MaintenanceCostEstimate
CONFIRMS       tarea e intervalo
CREATES        TaskProcedureLink si se requiere
```
