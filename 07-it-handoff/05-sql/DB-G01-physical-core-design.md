# CMMS 2.0 — DB-G01 Physical SQL Core Design

**Date:** 2026-10-08  
**Target:** SQL Server — database `db-omm-dev`, schema `cmms`  
**Status:** DESIGN_READY_FOR_RUNTIME_VALIDATION

## Scope

DB-G01 translates the frozen logical runtime core into SQL Server physical objects for:

- Maintenance Engineering execution definitions;
- Project Maintenance Plan binding;
- Triggering & Condition Monitoring;
- Work Management;
- Planning & Scheduling;
- Execution Feedback.

Asset Master and Reliability Engineering remain upstream references in this increment. DB-G01 does **not** duplicate their masters.

## Architecture constraints

- Power Apps → Power Automate → SQL Server.
- Stored procedures will later be executed from Power Automate using the user's existing SQL identity.
- No SQL roles are created by this increment.
- No UI-driven denormalization becomes Product Truth.
- Published versions remain immutable by contract; DML enforcement will be added in later controlled increments where needed.

## Physical identity strategy

- Internal PKs: `bigint IDENTITY(1,1)`.
- Stable business codes: `nvarchar`.
- Times: `datetime2(3)`.
- Quantities/hours/thresholds: `decimal(18,6)`.
- Flags: `bit`.
- Long descriptions/instructions: `nvarchar(max)` only where justified.

## External references

DB-G01 deliberately uses external keys rather than guessed FKs for domains whose physical table is not yet contracted:

- `AssetKey nvarchar(100)`;
- person/user references;
- discipline/craft references;
- item/tool/service references;
- Equipment Type where needed later.

This preserves ownership and allows later FK promotion without inventing table names today.

## Core table groups

### Maintenance Engineering
- SourceReference
- JobPlan
- JobPlanRevision
- JobPlanOperation
- ResourceRequirement
- ToolRequirement
- MaterialRequirement
- MaintenanceActivity
- ProjectMaintenancePlanVersion
- ProjectMaintenancePlanItem

### Triggering
- MaintenanceTriggerPolicy
- TriggerRule
- MeasurementPoint
- MeasurementReading
- MaintenanceTriggerState
- MaintenanceOccurrence
- MaintenanceDueEvent

`ForecastOccurrence` remains derived in V1 and therefore has no authoritative table.

`TriggerEvaluation` is not persisted by default in DB-G01; material outcomes are preserved through occurrence/due-event audit.

### Work / Planning / Scheduling
- WorkOrder
- PlanningPackage
- WorkConstraint
- ReadinessAssessment
- OperationalCalendar
- ShiftCalendar
- ResourcePool
- Crew
- CapacityBucket
- ScheduleAssignment
- ScheduleRevision

### Execution
- ExecutionRecord
- LaborActual
- MaterialActual
- ToolActual
- ServiceActual
- ChecklistResult
- ExecutionFinding
- FollowUpWorkOrderLink
- WorkOrderClosure

## Important physical invariants

1. One ProjectMaintenancePlanItem belongs to one ProjectMaintenancePlanVersion, one AssetKey and one MaintenanceActivity.
2. TriggerPolicy belongs to ProjectMaintenancePlanItem, not directly to MaintenanceActivity.
3. TriggerRule CONDITION/METER requires MeasurementPointId.
4. MaintenanceOccurrence has an `EpisodeKey` unique per plan item/policy version to enforce idempotency.
5. At most one WorkOrder may materialize one MaintenanceOccurrence.
6. WorkOrder schedule dates never overwrite MaintenanceOccurrence.DueAt.
7. At most one current committed ScheduleAssignment is allowed per WorkOrder.
8. ActualStartAt <= ActualFinishAt when both exist.
9. TechnicalClosedAt is independent from ActualFinishAt.
10. Follow-up corrective work preserves explicit finding linkage.

## Versioning strategy

Versioned objects carry:
- RevisionCode / VersionNo;
- StatusCode;
- ValidFrom / ValidTo where applicable;
- PublishedAt / PublishedBy where applicable.

DB-G01 creates structural constraints and uniqueness. Full immutable-published DML enforcement is a later DB increment because it requires controlled procedures/triggers and rollback tests.

## Status catalogs

V1 uses CHECK constraints for small closed code sets to avoid premature lookup-table sprawl. When codes become customer-configurable they can be promoted into reference tables without changing entity ownership.

## Transaction/concurrency notes

- Occurrence materialization must later run inside a transaction and use unique keys to guarantee idempotency under concurrent Power Automate calls.
- WorkOrder creation from MaintenanceOccurrence must trap duplicate-key violations and return the already materialized WO.
- Schedule commit/reschedule must protect the single-current-assignment invariant.
- Trigger state update and occurrence creation must be atomic.

## Security

DB-G01 creates no users and no roles. Permissions remain on the existing execution identity and will be reviewed when stored procedures are introduced.

## Rollback

The DDL file is intentionally additive. It contains no DROP statements. Runtime rollback should be performed by a separately reviewed rollback script after a test deployment inventory is captured.

## DB-G01 acceptance

Design is ready for runtime validation when:

1. script parses in SQL Server;
2. schema/tables/constraints/indexes are created in `db-omm-dev`;
3. object inventory matches expected counts/names;
4. FK integrity checks pass;
5. idempotency/unique-index tests pass;
6. no role/user is created;
7. no existing object is modified unexpectedly.

Until those checks are executed against the real database, DB-G01 is **DESIGN_READY_FOR_RUNTIME_VALIDATION**, not PASS.
