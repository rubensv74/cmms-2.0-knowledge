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

- MaintenanceActivityId
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
- WorkOrderId if materialized

## WorkOrder — minimum cross-domain contract

- WorkOrderId
- WorkOrderTypeCode
- AssetId
- MaintenanceActivityId when planned
- DueEventId when trigger-driven
- PlannedDueAt
- PlannedDuration
- StatusCode (OPEN CONTRACT)
- ExecutionPackage reference
- TechnicalClosedAt / ClosedBy

## ExecutionActual / Finding

Minimum fields already supported by discovery: actualStart, actualFinish, actualDuration, actualResources, executionResult, findings, correctiveReference, executor, feedbackCapturedAt, technicalClosedAt, closedBy.

## Gate

This dictionary is sufficient for conceptual reconciliation only. It is not sufficient for DDL. Each domain must promote proposed attributes through its domain gate before SQL.