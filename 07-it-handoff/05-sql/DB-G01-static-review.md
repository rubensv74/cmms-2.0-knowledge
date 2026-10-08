# CMMS 2.0 — DB-G01 Static Review

**Date:** 2026-10-08  
**Result:** PASS_STATIC / RUNTIME_PENDING

## Static inventory

- 37 `cmms` tables in the DDL increment.
- 12 explicit non-PK indexes, including filtered uniqueness for:
  - one WorkOrder per MaintenanceOccurrence;
  - one current PlanningPackage per WorkOrder;
  - one current ScheduleAssignment per WorkOrder.
- No duplicate table names detected.
- No duplicate explicit index names detected.
- No duplicate constraint names detected.
- No `CREATE ROLE`.
- No `CREATE USER`.
- No destructive `DROP TABLE/SCHEMA/ROLE/USER`.
- Conditional creation of schema `cmms`.

## Reconciliation corrections applied before freeze

- Trigger policy physical FK is `ProjectMaintenancePlanItemId`, not `MaintenanceActivityId`.
- WorkOrder preventive origin is `MaintenanceOccurrenceId`, not `MaintenanceDueEventId`.
- `ForecastOccurrence` remains derived.
- `MaintenanceDueEvent` remains append-only audit evidence.

## Runtime validation artifact

`DB-G01-validate-core.sql` performs:

- database/schema guard;
- 37-table inventory check;
- trusted FK/check verification;
- positive smoke path;
- duplicate occurrence rejection;
- duplicate WO-per-occurrence rejection;
- second-current PlanningPackage rejection;
- second-current ScheduleAssignment rejection;
- invalid execution date rejection;
- full smoke-test rollback.

## Remaining limitations

A static repository review cannot prove:

- SQL Server parser compatibility in the actual target version;
- pre-existing object/name conflicts in `db-omm-dev`;
- actual permissions of the existing Power Automate SQL identity;
- runtime transaction/concurrency behavior;
- performance under representative data.

Therefore the next gate is real execution in `db-omm-dev`.
