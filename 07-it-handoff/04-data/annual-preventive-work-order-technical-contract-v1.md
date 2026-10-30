# Annual Preventive Work Order — Functional/Technical Contract Candidate

**Decision source:** DEC-025 and CMMS Solution Proposal dated 2026-10-30 (pp. 3, 6 and 8)  
**Status:** design candidate for PM-GROUP-G01; not an approved SQL schema and not runtime-validated  
**Risk:** C — changes parent/child cardinality and commands in the deployed CMMS core

## 1. Purpose and authority

This document translates the functional behavior in the distributed proposal into a candidate data and service contract. The proposal is authoritative for product behavior. This document may recommend a technical representation, but it cannot close an operational decision left open in the proposal.

The existing DB-G01/SP-G01 runtime remains valid evidence for its October model only. It does not validate annual grouping.

## 2. Requirements traceability

| ID | Functional rule | Source | Contract consequence |
|---|---|---|---|
| PMA-01 | Selected time-based tasks can be represented by one annual preventive Work Order with several periodic executions | Proposal p. 3, p. 6 | Parent WorkOrder with multiple visit/execution children |
| PMA-02 | Each execution preserves its own date and result | Proposal p. 3, p. 6 | Actual dates/results are recorded per WorkOrderVisit |
| PMA-03 | At cycle end the order distinguishes completed from pending visits | Proposal p. 3, p. 6 | Parent read model summarizes child state; it must not flatten away visit detail |
| PMA-04 | Pending-visit outcome is an operational decision; options are not yet selected | Proposal p. 8 | Preserve pending state and expose decision options; no automatic carry, close or replacement |
| PMA-05 | A major repair may reset affected time-based frequencies from its effective repair date | Proposal p. 3, p. 6 | Auditable recurrence adjustment linked to the repair and affected time-based policy |
| PMA-06 | Condition-monitoring rounds retain an independent cadence | Proposal p. 3–4, p. 6 | A time-based reset must not change condition cadence |
| PMA-07 | A condition reading/alarm is evidence, not an automatic repair order; a recommendation goes to Planning | Proposal p. 2, p. 4, p. 6 | Keep measurement, technical recommendation and intervention WorkOrder separate |
| PMA-08 | No unlimited lifetime materialization | Proposal p. 3, p. 6 | Cycle/horizon controls remain explicit and governed |

## 3. Confirmed behavior versus open decisions

### Confirmed by the proposal

- Annual grouping applies only to selected time-based tasks.
- The annual Work Order groups periodic executions; for this pattern, do not create a separate Work Order per visit.
- Every visit has its own actual date and result.
- At cycle end, the system shows what is complete and what remains pending.
- A major repair may reset affected time-based cadence from the effective repair date; condition rounds continue independently.
- A major repair reset is not defined as an unconditional reset of every plan frequency.

### Explicitly open

- Eligibility criteria for annual grouping and whether any tasks may be grouped together.
- Cycle boundary: calendar, fiscal, plan-validity or another approved project period.
- When the parent order and its visit rows are created versus when an occurrence is released.
- Pending-visit disposition and the responsible authority.
- What qualifies as a major repair, which plan items it affects and whether reset is automatic under an approved rule or requires a decision.
- Shared versus visit-specific preparation, readiness, scheduling and crew/resource assignment.
- State vocabulary and aggregate transition rules.
- Visit cardinality for non-annual work, including corrective orders.
- Reopen, cancel, replace and reissue behavior.
- Interaction with the current single OpenMaintenanceOccurrenceId pointer.

No field default, fixture value or sample date in this document closes these items.

## 4. Candidate logical model

| Entity | Candidate responsibility | Cardinality |
|---|---|---|
| WorkOrder | Shared identity, asset, approved plan provenance, work type and aggregate lifecycle | 1:N WorkOrderVisit for annual PM |
| WorkOrderVisit | One planned periodic execution slot; own state, schedule link and exception context | 0..1 MaintenanceOccurrence; 0..1 ExecutionRecord |
| MaintenanceOccurrence | Triggering evidence for a released/due periodic visit | At most one WorkOrderVisit |
| ExecutionRecord | Actual start/finish, result, performer and validation for one visit | Candidate 1:1 with WorkOrderVisit |
| LaborActual / MaterialActual / ToolActual / ServiceActual / ChecklistResult | Execution feedback | N:1 ExecutionRecord |
| ExecutionFinding | Finding from a particular visit/execution and its follow-up | N:1 visit or execution; physical FK owner to confirm |
| PlanningPackage | Shared job preparation where it applies to all visits | Parent-level by default; per-visit variation remains open |
| ScheduleAssignment / ScheduleRevision | Dated resource commitment and change history | Candidate per visit; whether a parent summary is also required remains open |
| WorkOrderClosure | Technical closure evidence for the annual parent | A single visit completion must not close the annual parent |
| MaintenanceRecurrenceAdjustment | Auditable reset/adjustment caused by an accepted major repair | One repair execution can affect zero or more approved time-based policies; exact scope open |

For non-annual orders, do not enforce a one-visit rule from the synthetic example. The relationship and minimum/maximum cardinality must be agreed in the relevant process contract.

## 5. Candidate SQL Server delta

Names and types below are proposals based on the existing SQL Server core conventions, not migration DDL.

### 5.1 New table: cmms.WorkOrderVisit

| Column | Candidate type | Rule |
|---|---|---|
| WorkOrderVisitId | bigint IDENTITY | Primary key |
| WorkOrderId | bigint | Required parent FK |
| VisitKey | nvarchar(150) | Stable natural visit identity within a parent |
| SequenceNo | smallint | Display/order hint; not a substitute for VisitKey |
| VisitStateCode | nvarchar(30) | State catalog to be approved |
| PlannedAt | datetime2(3) NULL | Planned slot only; must not overwrite occurrence DueAt |
| MaintenanceOccurrenceId | bigint NULL | Optional link to one triggering occurrence |
| ExceptionReasonCode | nvarchar(50) NULL | Required by an approved exception transition |
| CreatedAt / CreatedBy | datetime2(3) / nvarchar(200) | Audit |

Candidate constraints: unique (WorkOrderId, VisitKey); filtered unique MaintenanceOccurrenceId; FK to WorkOrder and MaintenanceOccurrence; date/state checks after vocabulary approval. A composite parent key may be required where a child row also stores WorkOrderId, to prevent cross-parent links.

### 5.2 Existing table changes

| Existing table | Candidate change | Reason |
|---|---|---|
| cmms.WorkOrder | Add a governed cycle/group key and grouping provenance; keep nullable for non-grouped work | Resolve one annual parent without assuming year boundaries |
| cmms.WorkOrder | Retain MaintenanceOccurrenceId only during a compatibility/backfill window | Its current unique index encodes one occurrence per order |
| cmms.ExecutionRecord | Add WorkOrderVisitId; create one execution record per visit; retain WorkOrderId during transition | Current unique WorkOrderId allows only one execution per order |
| cmms.ScheduleAssignment | Add WorkOrderVisitId and revision uniqueness/current-assignment scope per visit after schedule policy approval | Current assignment uniqueness is parent-level |
| cmms.ExecutionFinding | Add visit/execution reference so a finding can be located within a multi-visit parent | Current finding is linked only to WorkOrder |
| cmms.MaintenanceTriggerState | Replace the single open-occurrence pointer as the authoritative representation if multiple concurrent visit occurrences are persisted | Current OpenMaintenanceOccurrenceId is scalar |
| cmms.WorkOrderClosure | Revisit validation so parent technical closure evaluates all visits and governed dispositions | Current uniqueness is one closure per parent |

Existing actual tables already reference ExecutionRecord; they can remain attached to it after execution moves to visit granularity. Do not copy actuals onto the parent.

### 5.3 Candidate recurrence adjustment ledger

A separate append-only relation is recommended rather than silently rewriting a due date:

| Field | Purpose |
|---|---|
| RecurrenceAdjustmentId | Stable key |
| SourceExecutionRecordId / SourceWorkOrderVisitId | Repair evidence and effective completion |
| TargetTriggerPolicyId or PlanItemId | Affected time-based cadence |
| EffectiveAt | Accepted repair completion/effective date |
| AdjustmentTypeCode | Governed reset/recalculation type |
| PreviousDueAt / NewDueAt | Before/after audit values |
| DecisionStatus / ApprovedBy / ApprovedAt | Required if policy is not fully automatic |
| Reason / RuleVersion | Explain scope and reproducibility |

The table must reject or ignore condition-monitoring policies for a time-based reset. Exact enforcement depends on the approved rule. The generated synthetic examples use DEMO-only policy and dates.

## 6. Read/write contract across layers

### Read: work queue

Candidate flow: CMMS_CORE_WorkQueue_List → cmms.usp_WorkQueue_ListJson → Power Apps.

The returned parent row should include the parent status and visit summary counts, plus a stable WorkOrderId. The detail response should include a visits array with VisitId/VisitKey, planned date, actual date, status, result and linked occurrence summary. Keep DueAt and ScheduledAt separate.

The current flow payload and query contract are legacy. They must be versioned or replaced together; Canvas must not infer annual completion from the parent status alone.

### Write: create/find parent and visit

Candidate command behavior, name not final:

1. Accept requestId, actor, approved plan item, resolved CycleKey and stable VisitKey; occurrence linkage may be absent until its release, depending on the approved creation-timing rule.
2. Validate that the item is eligible for annual grouping under the applicable published plan version.
3. Resolve/create one canonical parent using the approved natural key.
4. Resolve/create the visit by parent + VisitKey and attach an occurrence at most once.
5. Commit under one transaction; the same requestId returns the original result.
6. Different requestIds for the same natural cycle/visit converge on the same identifiers.
7. A concurrent request either returns the canonical existing rows or a controlled conflict; it must never duplicate the parent or visit.

Until order-creation timing is agreed, this is a behavioral contract, not a final request schema.

### Write: visit schedule and execution

Schedule, start, complete, validate and finding commands must identify WorkOrderVisitId. The service validates that the visit belongs to the stated parent, rejects invalid state transitions, and writes actuals to its ExecutionRecord. Revisions preserve previous schedule and reason. An execution finding requiring repair creates a linked corrective branch; it does not expand the annual preventive visit.

### Shared response/error contract

Preserve the established one-row SQL result contract: ReadState, ResultJson, ErrorCode and ErrorMessage. Keep controlled domain errors (invalid input, not found, conflict, readiness, validation) separate from connector/runtime failures. Do not expose raw SQL errors as business states.

## 7. Migration and compatibility sequence

1. Approve the logical cardinalities and open business rules at PM-GROUP-G01.
2. Capture current object/data inventory and review backup/restore plan for the development schema.
3. Add WorkOrderVisit and natural keys additively.
4. Backfill one visit for each existing WorkOrder and attach its existing occurrence, execution, schedule, findings and actuals without history loss.
5. Add new procedures and versioned flow payloads; keep old columns readable during the compatibility period.
6. Validate uniqueness, FK integrity, idempotency under different RequestIds, concurrent visit materialization, due-vs-schedule separation, visit execution and rollback on a disposable copy or approved dev transaction.
7. Move Canvas to the new response contract only after the new SQL/flow runtime passes.
8. Remove old constraints/columns only in a later, separately reviewed cleanup.

This is not approval to run a migration. No SQL, flow or Canvas changes have been applied to a runtime.

## 8. DVP first-touch contract

The first walkthrough target is the work queue followed by an annual WorkOrder detail and one visit detail. It serves Hernando and Eduardo as stakeholders; it does not infer their security roles.

Required story:
- Open a relevant annual parent and understand the asset, approved plan provenance and cycle label.
- See visit count and completed/pending distribution immediately.
- Open one visit and inspect its own planned date, actual date/result, crew/resource and evidence when present.
- Understand that a reading is evidence, a recommendation is a planner decision point, and an annual PM visit is not a corrective follow-up.

The candidate screen/response mapping is documented in the DVP brief. No production permissions, assignment choices or exact cycle labels are hardcoded.

## 9. PM-GROUP-G01 acceptance

- Trace every approved behavior to the 2026-10-30 proposal.
- Approve cycle boundary, eligibility, pending-visit decision authority, major-repair reset scope and non-annual visit cardinality.
- Confirm parent/visit states and whether preparation/scheduling/resource data are shared or visit-specific.
- Demonstrate lossless backfill and stable natural keys.
- Demonstrate idempotent and concurrent parent/visit resolution.
- Verify due date remains owned by Triggering and schedule revisions never overwrite it.
- Approve versioned SQL/flow/Canvas contracts before any runtime promotion.
