# CMMS 2.0 — Entity Catalog v0.1

**Date:** 2026-10-08  
**Status:** G01 BASELINE

This catalog promotes fragmented concepts into one cross-domain vocabulary. It is not a SQL schema.

## Asset & Context

| Entity | Type | Purpose | Status |
|---|---|---|---|
| Asset | Master | Maintainable physical object identity | CONFIRMED |
| EquipmentType | Master/reference | Governing classification/type | CONFIRMED |
| AssetRelationship | Master relation | Governed asset relationship | CONFIRMED |
| OperationalContext | Context | Operating/service context relevant to reliability/applicability | CONFIRMED |
| AssetTechnicalValue | Master value | Technical value for an Asset | CONFIRMED |
| TechnicalFieldDefinition | Master definition | Definition of technical property | CONFIRMED |

## Reliability Engineering

| Entity | Type | Purpose | Status |
|---|---|---|---|
| FmeaDefinition | Versioned master root | Stable FMEA/RCM identity | CONFIRMED |
| FmeaRevision | Version | Governed revision | CONFIRMED |
| FmeaFunction | Version child | Required function/performance | CONFIRMED |
| FunctionalFailure | Version child | Failure to fulfil a function | CONFIRMED |
| FailureMode | Version child | Event/condition producing functional failure | CONFIRMED |
| FailureCause | Version child | Cause/mechanism | CONFIRMED |
| FailureEffect | Version child | Failure effect | CONFIRMED |
| ConsequenceAssessment | Assessment | Contextual consequence/risk | CONFIRMED |
| RcmAssessment | Assessment | Governed RCM traversal/decision | CONFIRMED |
| RcmAssessmentAnswer | Assessment detail | Answer/evidence/justification | CONFIRMED |
| MaintenanceRecommendation | Engineering output | Recommended response before executable activity | NORMALIZED / CONFIRMED CONCEPT |
| RecommendationFailureMode | Relation | N:M recommendation to failure modes | NORMALIZED |
| NoScheduledTaskDecision | Engineering output | Explicit no-task/run-to-failure/redesign outcome | CONFIRMED |

## Maintenance Engineering

| Entity | Type | Purpose | Status |
|---|---|---|---|
| MaintenanceStandardLibrary | Master root | Corporate governed maintenance knowledge | PROPOSED |
| EquipmentTypeStandard | Master relation | Standard applicable to Equipment Type | PROPOSED |
| StandardPlanVersion | Versioned master | Published corporate standard plan | PROPOSED |
| StandardMaintenanceActivity | Version child | Activity in corporate standard | PROPOSED |
| ProjectStandardAdoption | Version relation | Snapshot/adoption into project | PROPOSED |
| ProjectMaintenancePlanVersion | Versioned project master | Governed project maintenance plan | CONFIRMED CONCEPT |
| MaintenanceActivity | Version child/master | Plan-able, schedulable, closable maintenance unit | CONFIRMED CONCEPT |
| JobPlan | Reusable master | Reusable preparation/execution template | CONFIRMED CONCEPT |
| ProcedureChecklist | Reusable content/master | Detailed execution steps/checklist | OPEN BOUNDARY |
| ResourceRequirement | Child definition | Planned labor/discipline requirement | PROPOSED |
| ToolRequirement | Child definition | Planned tool/equipment requirement | PROPOSED |
| MaterialRequirement | Child definition | Planned material/spare requirement | PROPOSED |
| ProjectPlanOverride | Version delta | Project-specific modification | PROPOSED |
| CorporateChangeProposal | Governance transaction | Project learning proposed to master | PROPOSED |

## Triggering & Condition Monitoring

| Entity | Type | Purpose | Status |
|---|---|---|---|
| MaintenanceTriggerPolicy | Versioned rule set | Defines when MaintenanceActivity becomes due | NEW / PROPOSED |
| TriggerRule | Rule child | TIME, METER, CONDITION or component rule | NEW / PROPOSED |
| MeasurementPoint | Master/reference | Measurable characteristic/counter | NEW / PROPOSED |
| MeasurementReading | Transaction | Timestamped measurement value | NEW / PROPOSED |
| TriggerEvaluation | Derived/audit | Evaluation of rules against current state | NEW / OPEN PERSISTENCE |
| ForecastOccurrence | Derived/projected | Future expected occurrence | NORMALIZED / PROPOSED |
| MaintenanceDueEvent | Transaction/audit | Evidence that activity became due | NEW / PROPOSED |

## Work Management

| Entity | Type | Purpose | Status |
|---|---|---|---|
| WorkOrder | Transaction | Executable work instance | CONFIRMED CONCEPT |
| WorkOrderAssignment | Transaction child | Team/person/shift assignment | PROPOSED |
| ExecutionPackage | Derived/package | Resolved work package | CONFIRMED CONCEPT / PHYSICAL OPEN |
| OperationsPermissive | Transaction/reference | Operational permission/readiness dependency | PARTIAL |
| WorkOrderAttachment | Transaction child | WO-specific attachment/reference | PROPOSED |
| WorkOrderClosure | Transaction child/state evidence | Closure evidence | PARTIAL |

## Execution & Feedback

| Entity | Type | Purpose | Status |
|---|---|---|---|
| ExecutionResult | Transaction | Outcome/result of execution | PARTIAL |
| ExecutionActual | Transaction child | Actual timing/resources/duration/material values | PARTIAL |
| ExecutionFinding | Transaction | Finding discovered during execution | CONFIRMED CONCEPT |
| CorrectiveLink | Relation | Finding/source to corrective work | PROPOSED |
| PlanVsActualMetric | Derived | Planned vs actual metric | PARTIAL |
| ReliabilityReviewReference | Relation | Execution evidence to reliability review | PROPOSED |

## Naming reconciliation

| Historical/local name | Canonical interpretation |
|---|---|
| ProposedMaintenanceTask | MaintenanceRecommendation |
| StandardMaintenanceActivity | Corporate/master-side activity definition; adopted into project MaintenanceActivity |
| NextDueOccurrence | MaintenanceDueEvent when real; ForecastOccurrence when projected |
| PreventiveRecurrence | MaintenanceTriggerPolicy + TriggerRule |
| CorrectiveWorkOrder | WorkOrder with corrective origin/type |
| ScheduledMaintenanceActivity | Project MaintenanceActivity + trigger policy |

## Gate rule

Entities marked PROPOSED, PARTIAL or OPEN cannot drive physical SQL as if final.