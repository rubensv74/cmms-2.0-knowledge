# CMMS 2.0 — Logical Data Dictionary v0.1

**Date:** 2026-10-08  
**Status:** G01 BASELINE / PARTIAL  
**Important:** logical business attributes, not final SQL columns.

## Common governance attributes

| Attribute | Meaning |
|---|---|
| StableId / Code | Stable business identity |
| Version / Revision | Version identity |
| StatusCode | Lifecycle state |
| ValidFrom / ValidTo | Temporal validity |
| SourceBasisCode | RCM, CORPORATE_STANDARD, OEM_VENDOR, EXPERT, etc. |
| SourceReferenceId | Provenance |
| CreatedAt / CreatedBy | Audit |
| UpdatedAt / UpdatedBy | Draft audit |
| PublishedAt / PublishedBy | Publication evidence |
| ChangeReason | Reason for governed change |

## MaintenanceRecommendation

- RecommendationId
- RcmAssessmentId when applicable
- RecommendationTypeCode
- TechnicalBasis
- SourceBasisCode
- StatusCode

## MaintenanceActivity

- ProjectMaintenancePlanItemId
- PlanVersionId
- ActivityCode
- Title
- Description
- DisciplineCode
- OperationalStateRequirement
- JobPlan reference
- SourceBasisCode
- SourceReferenceId
- IsActive

**Not canonical here:** frequency/interval. It belongs to Trigger Policy/Rule.

## JobPlanRevision

- JobPlanRevisionId
- JobPlanId
- RevisionCode
- Title / Description
- PlannedTotalDuration
- StatusCode
- SourceReferenceId
- PublishedAt / PublishedBy

## JobPlanOperation

- JobPlanOperationId
- JobPlanRevisionId
- Sequence
- Title / Description
- InstructionDetail
- PlannedDuration when supplied
- MeasurementReference when supplied
- Discipline/Craft when supplied

## ProjectMaintenancePlanItem

- ProjectMaintenancePlanItemId
- ProjectMaintenancePlanVersionId
- AssetId
- MaintenanceActivityId
- JobPlanRevisionOverrideId when applicable
- ApplicabilityStatusCode
- OverrideReason / provenance when applicable
- IsActive

## MaintenanceTriggerPolicy

- TriggerPolicyId
- MaintenanceActivityId
- PolicyVersion
- PolicyModeCode (SIMPLE / COMPOSITE)
- RecurrenceBasisCode (FIXED_SCHEDULE / LAST_COMPLETION / TBD)
- CombinationOperatorCode
- ReleaseLeadValue
- ReleaseLeadUnitCode
- EffectiveFrom / EffectiveTo
- StatusCode

## MaintenanceTriggerState

- TriggerStateId
- TriggerPolicyId
- LastEvaluationAt
- LastCompletionAt
- LastDueAt
- NextDueAt (derived/cache)
- BaselineMeasurementReadingId / BaselineValue
- ConditionStateCode
- OpenMaintenanceOccurrenceId

## TriggerRule

- TriggerRuleId
- TriggerPolicyId
- RuleTypeCode (TIME / METER / CONDITION)
- Sequence
- IntervalValue
- IntervalUnitCode
- MeasurementPointId when relevant
- ComparisonOperatorCode
- ThresholdValue
- WarningThresholdValue
- ThresholdUnitCode

## MeasurementPoint

- MeasurementPointId
- AssetId
- Code
- CharacteristicCode
- MeasurementKindCode (COUNTER / GAUGE / CHARACTERISTIC)
- UnitCode
- SourceSystemCode
- AuthorityPolicyCode
- IsActive

## MeasurementReading

- MeasurementReadingId
- MeasurementPointId
- ReadingAt
- ValueNumeric / ValueText (type model open)
- UnitCode
- SourceReference
- QualityStatusCode
- SupersedesReadingId

## MaintenanceOccurrence

- MaintenanceOccurrenceId
- ProjectMaintenancePlanItemId
- TriggerPolicyId / version
- ForecastAt
- ReleaseAt
- DueAt
- ReleasedAt
- MaterializedWorkOrderId when applicable
- FulfilledAt when applicable
- StatusCode
- OriginReasonCode
- EpisodeKey / idempotency key

## MaintenanceDueEvent

- DueEventId
- TriggerPolicyId
- MaintenanceActivityId
- AssetId
- DueAt
- ReleaseAt
- DueReasonCode
- TriggerEvaluationId if persisted
- MeasurementReadingId when relevant
- ForecastOccurrenceId if applicable
- StatusCode
- MaintenanceOccurrenceId

## WorkOrder — minimum cross-domain contract

- WorkOrderId
- WorkOrderTypeCode
- AssetId
- MaintenanceActivityId when planned
- MaintenanceOccurrenceId when trigger-driven
- PlannedDueAt
- PlannedDuration
- StatusCode (OPEN CONTRACT)
- ExecutionPackage reference
- TechnicalClosedAt / ClosedBy

## ExecutionActual / Finding

Minimum fields already supported by discovery: actualStart, actualFinish, actualDuration, actualResources, executionResult, findings, correctiveReference, executor, feedbackCapturedAt, technicalClosedAt, closedBy.

## Gate

This dictionary is sufficient for conceptual reconciliation only. It is not sufficient for DDL. Each domain must promote proposed attributes through its domain gate before SQL.

## Planning / Scheduling logical fields

### PlanningPackage
- PlanningPackageId
- WorkOrderId
- RevisionNo
- PlannedDuration
- PlannerNotes
- ReadinessStatusCode
- CreatedAt / CreatedBy

### WorkConstraint
- WorkConstraintId
- PlanningPackageId
- CategoryCode
- StatusCode
- OwnerReference
- RequiredBy
- ResolvedAt
- ResolutionNote
- WaiverReason

### ScheduleAssignment
- ScheduleAssignmentId
- WorkOrderId
- ScheduledStart
- ScheduledFinish
- AssignmentTargetType
- AssignmentTargetId
- ShiftCode
- StatusCode
- ScheduledBy / ScheduledAt
- ScheduleRevisionNo

### CapacityBucket
- CapacityBucketId
- ResourceScopeType
- ResourceScopeId
- CalendarDate
- ShiftCode
- AvailableHours
- CommittedHours
- RemainingHours (derived)
- CapacitySourceCode


## Execution Feedback logical fields

### ExecutionRecord
- ExecutionRecordId
- WorkOrderId
- ActualStartAt
- ActualFinishAt
- ExecutionResultCode
- PerformedBy/CrewReference
- ExecutionSubmittedAt
- SubmittedBy
- ValidationStatusCode
- ValidatedAt / ValidatedBy

### LaborActual
- LaborActualId
- ExecutionRecordId
- Person/CrewReference
- Craft/DisciplineReference
- WorkDate
- StartAt / FinishAt
- ActualHours
- EntryAt / EnteredBy

### MaterialActual / ToolActual / ServiceActual
- structured resource reference
- quantity/hours
- unit
- transaction timestamp
- enteredBy/source
- planned requirement reference when applicable

### ExecutionFinding
- ExecutionFindingId
- WorkOrderId
- JobPlanOperation/ChecklistReference
- AssetId
- FindingTypeCode
- Description
- Severity/Priority
- FoundAt / FoundBy
- RequiresFollowUp
- StatusCode

### WorkOrderClosure
- WorkOrderClosureId
- WorkOrderId
- TechnicalClosedAt
- ClosedBy
- ClosureResultCode
- ValidationNotes
- DataQualityStatusCode
- OpenFollowUpCount
- Exception/WaiverReference
