# Annual Preventive Work Order Aggregation — Logical Contract Candidate

**Decision:** DEC-025 (2026-10-30)  
**Status:** CONTRACT CANDIDATE — no physical/runtime validation  
**Risk:** C — changes persisted core relationships and command semantics

## Functional shape

    Published Project Maintenance Plan
    → one annual preventive WorkOrder
       → multiple periodic WorkOrderVisit records
          → due/release occurrence when applicable
          → visit-specific schedule and execution feedback
    → annual technical review/closure

The annual grouping is selected per approved activity. Condition measurement cadence remains separate from any intervention WorkOrder. A major repair may reset affected time-based frequencies from its effective repair date while condition-monitoring rounds retain their own cadence; the criteria for a major repair and the affected plan items remain to be defined.

## Recommended entity ownership

| Entity | Owns | Proposed relation |
|---|---|---|
| WorkOrder | Annual work identity, plan/version provenance, shared scope and lifecycle | 1:N WorkOrderVisit |
| WorkOrderVisit | One execution slot under a WorkOrder; several are confirmed for selected annual PM tasks. Cardinality for other work types remains to be confirmed | 0..1 MaintenanceOccurrence; 0..1 accepted ExecutionRecord |
| MaintenanceOccurrence | Triggering release/due evidence for one periodic visit | 0..1 WorkOrderVisit |
| ExecutionRecord | Actual start/finish, performed-by, result and validation for one visit | 1:1 WorkOrderVisit for V1 candidate |
| LaborActual / MaterialActual / ToolActual / ServiceActual / ChecklistResult | Actuals captured for one visit | N:1 ExecutionRecord |
| ExecutionFinding | Finding raised during one visit, including corrective follow-up reference | N:1 WorkOrderVisit or its ExecutionRecord; final FK owner to be fixed in SQL contract |
| PlanningPackage | Prepared scope and shared instructions/resources | N:1 WorkOrder; whether visit override packages are allowed remains open |
| ScheduleAssignment / ScheduleRevision | Date/resource commitment and its revisions | Candidate: N:1 WorkOrderVisit; retain a parent summary only if an approved use case requires it |
| WorkOrderClosure | Final technical closure evidence for the annual order | 0..1 WorkOrder |

The candidate model represents the confirmed annual preventive order through several WorkOrderVisit rows. Each periodic visit keeps its own date and result; the parent distinguishes completed and pending work. The distributed proposal explicitly leaves pending-visit disposition open. Cardinality for non-annual work, including corrective orders, is not specified in that proposal and remains a contract decision. The synthetic corrective example has one visit for demonstration only. Execution timestamps, results and actuals belong to the visit's ExecutionRecord; the WorkOrder carries shared scope and aggregate lifecycle.

## Natural keys and idempotency

Proposed identifiers, not yet physical keys:

- Annual order: ProjectMaintenancePlanItemId + TriggerPolicyId + CycleKey + WorkOrderTypeCode.
- Visit: WorkOrderId + VisitKey, where VisitKey is stable across retries and plan recalculation.
- Occurrence link: one MaintenanceOccurrenceId can be attached to at most one WorkOrderVisitId.
- Request replay: RequestId remains command-level idempotency; it is not a substitute for natural uniqueness across different RequestIds.

No key may assume calendar-year boundaries until CycleKey policy is approved.

## Existing contract incompatibilities

The current runtime core enforces one MaintenanceOccurrence per WorkOrder through a filtered unique index; one ExecutionRecord per WorkOrderId; planning and schedule records keyed to the parent WorkOrder; and MaintenanceTriggerState.OpenMaintenanceOccurrenceId as a single pointer. These constraints cannot represent several execution visits under one WorkOrder with independent results. The schema and all consuming procedures/flows must be changed together.

## Required transaction behavior

For an occurrence materialized into an annual order:

1. Validate the occurrence and plan version.
2. Resolve the correct annual WorkOrder by the approved CycleKey.
3. Create or find that WorkOrder under a natural unique key.
4. Create or find the matching WorkOrderVisit by stable VisitKey.
5. Attach the occurrence to the visit once.
6. Persist the command receipt and return the same WorkOrder/Visit identifiers on replay.
7. On competing requests, return the canonical existing order/visit or a controlled conflict; never create duplicates.

The annual order's lifecycle cannot be finalized merely because one visit completed. Closure must evaluate the cycle and its visits, while the open year-end policy remains visible and non-automatic.

## Migration strategy candidate

1. Capture object inventory and backup/restore point for the current development schema.
2. Add WorkOrderVisit and its natural keys without dropping old columns.
3. Backfill one visit for each existing WorkOrder linked to a MaintenanceOccurrence.
4. Add visit linkage to ExecutionRecord and ScheduleAssignment; backfill deterministically.
5. Add query/command procedures with compatibility only where it does not preserve incorrect annual semantics.
6. Verify FK/unique/idempotency behavior on a disposable copy or controlled dev transaction.
7. Keep old columns read-only during a compatibility window; remove only in a later approved cleanup after consumers move.
8. Rollback by restoring prior procedure definitions and removing only newly added objects after confirming no dependent data needs preservation.

This is a design sequence, not an executed migration.

## Open contract items

Before executable SQL is accepted, decide and document eligible task/time trigger policy; CycleKey boundaries and effective plan-version changes within a cycle; order creation timing vs occurrence release timing; forecast vs persisted visit schedule; schedule/crew/resource ownership at order and visit levels; order/visit state vocabulary and aggregate transition rules; annual closure and pending-visit outcomes; criteria for a major repair, affected time-based plan items and reset timing; preserve independent condition cadence; duplicate/reopen/cancel/reissue behavior; identity of the actor/authority for each transition.

## Acceptance for PM-GROUP-G01

- Logical cardinalities are approved and agree with DEC-025.
- Existing rows map to one visit with no lost history.
- One annual order may contain several visits; each visit retains a separate result and actuals.
- Duplicate RequestId and different RequestIds for the same natural cycle do not create duplicates.
- Parallel materialization of visits in one cycle converges on one annual WorkOrder.
- DueAt remains unchanged by scheduling.
- Old and new Power Automate payloads cannot silently produce different meanings.
- Rollback preserves pre-migration data and restores the prior valid runtime.
