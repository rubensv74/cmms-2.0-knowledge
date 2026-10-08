# CMMS 2.0 — Relationships & Cardinalities v0.1

**Date:** 2026-10-08  
**Status:** G01 BASELINE

## Confirmed / strongly supported

| From | Cardinality | To | Note |
|---|---:|---|---|
| FmeaDefinition | 1:N | FmeaRevision | CONFIRMED |
| FmeaRevision | 1:N | FmeaFunction | CONFIRMED |
| FmeaFunction | 1:N | FunctionalFailure | CONFIRMED |
| FunctionalFailure | 1:N | FailureMode | CONFIRMED |
| FailureMode | 1:N | FailureCause | CONFIRMED |
| FailureMode | 1:N | FailureEffect | CONFIRMED |
| FailureMode | 1:N | ConsequenceAssessment | CONFIRMED historical model |
| FailureMode | 1:N | RcmAssessment | CONFIRMED historical model |
| RcmAssessment | 1:N | RcmAssessmentAnswer | CONFIRMED |
| MaintenanceRecommendation | N:M | FailureMode | normalized from ProposedMaintenanceTask |
| FmeaRevision | N:M | Asset | through application relation |
| Asset | N:1 | EquipmentType | confirmed business rule |

## Maintenance Engineering — proposed

| From | Cardinality | To | Gate |
|---|---:|---|---|
| MaintenanceStandardLibrary | 1:N | EquipmentTypeStandard | MSL-G02 |
| EquipmentTypeStandard | 1:N | StandardPlanVersion | MSL-G02 |
| StandardPlanVersion | 1:N | StandardMaintenanceActivity | MSL-G02 |
| ProjectStandardAdoption | N:1 | StandardPlanVersion | MSL-G03 |
| ProjectMaintenancePlanVersion | 1:N | MaintenanceActivity | MSL-G02/G03 |
| MaintenanceActivity | 0..N | MaintenanceRecommendation | exact provenance relation MSL-G02 |
| MaintenanceActivity | 0..1 | JobPlanRevision | V1 contract; revision reusable by many activities |
| JobPlan | 1:N | JobPlanRevision | governed versioning |
| JobPlanRevision | 1:N | JobPlanOperation | confirmed by real source |
| JobPlanRevision | 0..N | ProcedureChecklist | optional external/controlled artifacts |
| JobPlan | 0..N | ResourceRequirement | MSL-G02 |
| JobPlan | 0..N | ToolRequirement | MSL-G02 |
| JobPlan | 0..N | MaterialRequirement | MSL-G02 |

## Project plan binding

| From | Cardinality | To | Rule |
|---|---:|---|---|
| ProjectMaintenancePlanVersion | 1:N | ProjectMaintenancePlanItem | published project-plan lines |
| ProjectMaintenancePlanItem | N:1 | Asset | concrete maintained asset/context |
| ProjectMaintenancePlanItem | N:1 | MaintenanceActivity | reusable project activity definition |
| ProjectMaintenancePlanItem | 0..1 | JobPlanRevision | optional project/item override |

## Triggering — confirmed contract

| From | Cardinality | To | Rule |
|---|---:|---|---|
| MaintenanceActivity | 1:N | MaintenanceTriggerPolicy | active-policy invariant required |
| MaintenanceTriggerPolicy | 1:N | TriggerRule | simple or composite |
| TriggerRule | 0..1 | MeasurementPoint | required for METER/CONDITION |
| Asset | 1:N | MeasurementPoint | asset-scoped measurement source |
| MeasurementPoint | 1:N | MeasurementReading | timestamped readings |
| MaintenanceTriggerPolicy | 1:N | TriggerEvaluation | only if evaluations persisted |
| MaintenanceTriggerPolicy | 0..N | ForecastOccurrence | potentially derived |
| MaintenanceTriggerPolicy | 0..N | MaintenanceDueEvent | auditable due occurrences |
| MaintenanceDueEvent | 0..1 | WorkOrder | exact materialization/reissue rule open |

## Work / feedback

| From | Cardinality | To | Status |
|---|---:|---|---|
| WorkOrder | N:1 | Asset | CONFIRMED concept |
| WorkOrder | 0..1 | MaintenanceDueEvent | preventive origin |
| WorkOrder | 0..1 | MaintenanceActivity | recommended traceability; snapshot/reference open |
| WorkOrder | 0..1 | ExecutionPackage | logical resolved package |
| WorkOrder | 0..N | ExecutionActual | PARTIAL |
| WorkOrder | 0..N | ExecutionFinding | CONFIRMED concept |
| ExecutionFinding | 0..N | WorkOrder | corrective follow-up rule OPEN |
| WorkOrder | 0..1 | WorkOrderClosure | PARTIAL |

## Invariants

1. Published plan/revision is immutable.
2. Project override never mutates corporate standard version.
3. One Due Event must not materialize duplicate active WOs without explicit reissue/reopen rule.
4. CONDITION/METER rules require a compatible measurement/counter source.
5. Warning does not necessarily create a Due Event.
6. Preventive finding requiring repair creates traceable corrective work.
7. Asset identity is referenced, not duplicated.
8. Cross-domain references preserve source version/snapshot where historical reproducibility requires it.

## Cardinalities blocking physical schema

- Multi-JobPlan composition for one MaintenanceActivity (out of V1 unless new evidence requires it).
- Recommendation ↔ Activity conversion cardinality.
- Finding ↔ corrective WorkOrder.
- persistence vs derivation for forecast/evaluation.

## Planning / Scheduling relations

| From | Cardinality | To | Status |
|---|---:|---|---|
| WorkOrder | 1:N | PlanningPackage | revisions/history; one current effective | CONFIRMED CONTRACT |
| PlanningPackage | 0..N | WorkConstraint | CONFIRMED CONTRACT |
| PlanningPackage | 0..N | ReadinessAssessment | CONFIRMED CONTRACT |
| WorkOrder | 0..N | ScheduleAssignment | revisions/history; max one current committed | CONFIRMED CONTRACT |
| ScheduleAssignment | N:1 | ResourcePool/Crew/Person reference | target type abstraction | CONFIRMED CONTRACT |
| ScheduleAssignment | 1:N | ScheduleRevision | history of schedule changes | CONFIRMED CONTRACT |
| ResourcePool/Crew | 0..N | CapacityBucket | date/shift capacity | CONFIRMED CONTRACT |


## Execution Feedback relations

| From | Cardinality | To | Status |
|---|---:|---|---|
| WorkOrder | 1:1 | ExecutionRecord | V1 current execution header | CONFIRMED CONTRACT |
| ExecutionRecord | 0..N | LaborActual | CONFIRMED CONTRACT |
| ExecutionRecord | 0..N | MaterialActual | CONFIRMED CONTRACT |
| ExecutionRecord | 0..N | ToolActual | CONFIRMED CONTRACT |
| ExecutionRecord | 0..N | ServiceActual | CONFIRMED CONTRACT |
| ExecutionRecord | 0..N | ChecklistResult | CONFIRMED CONTRACT |
| WorkOrder | 0..N | ExecutionFinding | CONFIRMED CONTRACT |
| ExecutionFinding | 0..N | FollowUpWorkOrderLink | explicit corrective linkage | CONFIRMED CONTRACT |
| FollowUpWorkOrderLink | N:1 | WorkOrder | target corrective WO | CONFIRMED CONTRACT |
| WorkOrder | 0..1 | WorkOrderClosure | technical close evidence | CONFIRMED CONTRACT |
