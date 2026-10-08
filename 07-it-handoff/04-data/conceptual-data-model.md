# CMMS 2.0 — Conceptual Data Model v0.1

**Date:** 2026-10-08  
**Status:** G01 BASELINE  
**Scope:** logical business model, not physical SQL.

## End-to-end model

Asset / Equipment Type / Context → Reliability Engineering → Maintenance Engineering → Project Maintenance Plan → Triggering → Work Management → Execution & Feedback → Controlled Revision.

## Aggregates

### 1. Asset & Context
- Asset
- EquipmentType
- AssetRelationship
- OperationalContext
- Criticality reference
- TechnicalFieldDefinition
- EquipmentTypeTechnicalField
- AssetTechnicalValue
- EngineeringSourceLink / EngineeringDocumentLink

### 2. Reliability Engineering
- FmeaDefinition
- FmeaRevision
- FmeaFunction
- FunctionalFailure
- FailureMode
- FailureCause
- FailureEffect
- ConsequenceAssessment
- RcmAssessment
- RcmAssessmentAnswer
- DecisionLogic / DecisionQuestion / DecisionTransition
- MaintenanceRecommendation
- RecommendationFailureMode
- NoScheduledTaskDecision
- ApplicabilityRule / AssetApplication
- RevisionApproval / RevisionChangeLog / PublishedRevisionSnapshot

### 3. Maintenance Engineering
- MaintenanceStandardLibrary
- EquipmentTypeStandard
- StandardPlanVersion
- StandardMaintenanceActivity
- ProjectStandardAdoption
- ProjectMaintenancePlanVersion
- ProjectMaintenancePlanItem
- MaintenanceActivity
- JobPlan
- ProcedureChecklist
- ResourceRequirement
- ToolRequirement
- MaterialRequirement
- ProjectPlanOverride
- CorporateChangeProposal
- SourceReference

### 4. Triggering & Condition Monitoring
- MaintenanceTriggerPolicy
- TriggerRule
- MaintenanceTriggerState
- MeasurementPoint
- MeasurementReading
- TriggerEvaluation
- ForecastOccurrence
- MaintenanceOccurrence
- MaintenanceDueEvent

### 5. Work Management
- WorkOrder
- WorkOrderAssignment
- ExecutionPackage
- OperationsPermissive
- WorkOrderAttachment
- AssetDocumentReference
- WorkOrderClosure

### 6. Execution & Feedback
- ExecutionResult
- ExecutionActual
- ExecutionFinding
- CorrectiveLink
- PlanVsActualMetric
- ReliabilityReviewReference

## Canonical transitions

### Engineering to maintenance
MaintenanceRecommendation → governed conversion/adoption → MaintenanceActivity.
A recommendation is not automatically executable.

### Standard to project
StandardPlanVersion → ProjectStandardAdoption → ProjectMaintenancePlanVersion → project MaintenanceActivity snapshot/override.
A project override does not mutate the corporate master.

### Plan to work
ProjectMaintenancePlanVersion → ProjectMaintenancePlanItem → MaintenanceTriggerPolicy → TriggerEvaluation → ForecastOccurrence → MaintenanceOccurrence → WorkOrder. MaintenanceDueEvent records the due/action boundary as audit evidence.

### Condition path
Asset → MeasurementPoint → MeasurementReading → TriggerEvaluation → warning OR MaintenanceDueEvent.

### Feedback path
WorkOrder → ExecutionActual / ExecutionFinding → Reliability Review candidate → new governed revision when approved.

## Important normalization decisions

1. ProposedMaintenanceTask is normalized conceptually to **MaintenanceRecommendation** at the cross-domain boundary.
2. Frequency is not owned by MaintenanceActivity; it becomes a Trigger Policy/Rule concern.
3. NextDueOccurrence is not retained as a canonical entity name: projected work is ForecastOccurrence; a satisfied due condition is MaintenanceDueEvent.
4. CorrectiveWorkOrder is treated as a WorkOrder type/origin, not automatically as a separate aggregate.
5. ExecutionPackage is a resolved execution package/view around WorkOrder; physical persistence remains open.
6. Read models are not business masters.

## Not yet in G01 scope

- inventory/warehouse;
- purchasing/procurement;
- contracts/subcontracts;
- invoicing;
- full Permit-to-Work domain;
- predictive/AI degradation models.

These must not be improvised into current entities.