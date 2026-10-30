# Annual Preventive Work Order Aggregation — Logical Contract Candidate

**Decision:** DEC-025 (2026-10-30)  
**Status:** CONTRACT CANDIDATE — no physical/runtime validation  
**Risk:** C — changes persisted core relationships and command semantics

## Functional shape

    Published Project Maintenance Plan
    → one annual preventive WorkOrder
       → multiple periodic WorkOrderPlannedAction records
          → due/release occurrence when applicable
          → schedule specific to each planned action and execution feedback
    → annual technical review/closure

The annual grouping is selected per approved activity. Condition measurement cadence remains separate from any intervention WorkOrder. A major repair may reset affected time-based frequencies from its effective repair date while condition-monitoring rounds retain their own cadence; the criteria for a major repair and the affected plan items remain to be defined.

## Recommended entity ownership

| Entity | Owns | Proposed relation |
|---|---|---|
| WorkOrder | Annual work identity, plan/version provenance, shared scope and lifecycle | 1:N WorkOrderPlannedAction |
| WorkOrderPlannedAction | One planned preventive action under a WorkOrder; it stores planned date/state. Its linked ExecutionRecord captures actual work. Cardinality for other work types remains to be confirmed | 0..1 MaintenanceOccurrence; 0..1 accepted ExecutionRecord |
| MaintenanceOccurrence | Triggering release/due evidence for one periodic planned action | 0..1 WorkOrderPlannedAction |
| ExecutionRecord | Actual start/finish, performed-by, result and validation for one planned action | 1:1 WorkOrderPlannedAction for V1 candidate |
| LaborActual / MaterialActual / ToolActual / ServiceActual / ChecklistResult | Actuals captured for one planned action | N:1 ExecutionRecord |
| ExecutionFinding | Finding raised during one planned action, including corrective follow-up reference | N:1 WorkOrderPlannedAction or its ExecutionRecord; final FK owner to be fixed in SQL contract |
| PlanningPackage | Prepared scope and shared instructions/resources | N:1 WorkOrder; whether planned action override packages are allowed remains open |
| ScheduleAssignment / ScheduleRevision | Date/resource commitment and its revisions | Candidate: N:1 WorkOrderPlannedAction; retain a parent summary only if an approved use case requires it |
| WorkOrderClosure | Final technical closure evidence for the annual order | 0..1 WorkOrder |

The candidate model represents the confirmed annual preventive order through several WorkOrderPlannedAction rows. Each periodic planned action has its own planned date and state; its linked ExecutionRecord stores actual dates and result. The parent distinguishes completed and pending work. The distributed proposal explicitly leaves pending action disposition open. Cardinality for non-annual work, including corrective orders, is not specified in that proposal and remains a contract decision. The synthetic corrective example has one planned action for demonstration only. Execution timestamps, results and actuals belong to its linked ExecutionRecord; the WorkOrder carries shared scope and aggregate lifecycle.

## Recommended operational baseline — pending stakeholder ratification

The functional analyst accepts this candidate baseline for review with TR Maintenance and TR Services. It is not yet an approved operating policy:

- Eligibility is explicit on the Approved Maintenance Plan; group by asset, plan activity and governed cycle. Keep condition rounds outside this annual time-based grouping.
- The cycle has explicit plan-approved start/end boundaries and a CycleKey; do not default the key to a calendar year.
- At cycle end, do not automatically close, carry forward or replace pending planned actions. Keep them pending until an authorized, reasoned disposition is recorded; technical closure must evaluate every action.
- A major repair resets only the time-based activities explicitly reviewed and approved as affected, from the agreed effective date. Preserve before/after due dates and authority; never change condition-monitoring cadence. The classification criteria for “major repair” remain open.

## Natural keys and idempotency

Proposed identifiers, not yet physical keys:

- Annual order: ProjectMaintenancePlanItemId + TriggerPolicyId + CycleKey + WorkOrderTypeCode.
- Planned action: WorkOrderId + PlannedActionKey, where PlannedActionKey is stable across retries and plan recalculation.
- Occurrence link: one MaintenanceOccurrenceId can be attached to at most one WorkOrderPlannedActionId.
- Request replay: RequestId remains command-level idempotency; it is not a substitute for natural uniqueness across different RequestIds.

No key may assume calendar-year boundaries until CycleKey policy is approved.

## Existing contract incompatibilities

The current runtime core enforces one MaintenanceOccurrence per WorkOrder through a filtered unique index; one ExecutionRecord per WorkOrderId; planning and schedule records keyed to the parent WorkOrder; and MaintenanceTriggerState.OpenMaintenanceOccurrenceId as a single pointer. These constraints cannot represent multiple planned actions under one WorkOrder, each with its own linked execution record and result. The schema and all consuming procedures/flows must be changed together.

## Required transaction behavior

For an occurrence materialized into an annual order:

1. Validate the occurrence and plan version.
2. Resolve the correct annual WorkOrder by the approved CycleKey.
3. Create or find that WorkOrder under a natural unique key.
4. Create or find the matching WorkOrderPlannedAction by stable PlannedActionKey.
5. Attach the occurrence to the planned action once.
6. Persist the command receipt and return the same WorkOrder/Planned action identifiers on replay.
7. On competing requests, return the canonical existing order/planned action or a controlled conflict; never create duplicates.

The annual order's lifecycle cannot be finalized merely because one planned action completed. Closure must evaluate the cycle and its planned actions, while the open year-end policy remains visible and non-automatic.

## Migration strategy candidate

1. Capture object inventory and backup/restore point for the current development schema.
2. Add WorkOrderPlannedAction and its natural keys without dropping old columns.
3. Backfill one planned action for each existing WorkOrder linked to a MaintenanceOccurrence.
4. Add planned action linkage to ExecutionRecord and ScheduleAssignment; backfill deterministically.
5. Add query/command procedures with compatibility only where it does not preserve incorrect annual semantics.
6. Verify FK/unique/idempotency behavior on a disposable copy or controlled dev transaction.
7. Keep old columns read-only during a compatibility window; remove only in a later approved cleanup after consumers move.
8. Rollback by restoring prior procedure definitions and removing only newly added objects after confirming no dependent data needs preservation.

This is a design sequence, not an executed migration.

## Open contract items

Before executable SQL is accepted, decide and document eligible task/time trigger policy; CycleKey boundaries and effective plan-version changes within a cycle; order creation timing vs occurrence release timing; forecast vs persisted planned-action schedule; schedule/crew/resource ownership at order and planned action levels; order/planned action state vocabulary and aggregate transition rules; annual closure and pending action outcomes; criteria for a major repair, affected time-based plan items and reset timing; preserve independent condition cadence; duplicate/reopen/cancel/reissue behavior; identity of the actor/authority for each transition.

## Acceptance for PM-GROUP-G01

- Logical cardinalities are approved and agree with DEC-025.
- Existing rows map to one planned action with no lost history.
- One annual order may contain several planned actions; each completed action has its own linked ExecutionRecord with result and actuals.
- Duplicate RequestId and different RequestIds for the same natural cycle do not create duplicates.
- Parallel materialization of planned actions in one cycle converges on one annual WorkOrder.
- DueAt remains unchanged by scheduling.
- Old and new Power Automate payloads cannot silently produce different meanings.
- Rollback preserves pre-migration data and restores the prior valid runtime.
