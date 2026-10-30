# PM-GROUP-G01 — Functional decision brief

**Status:** analyst baseline accepted; TR stakeholder ratification pending  
**Date:** 2026-10-30  
**Decision source:** CMMS Solution Proposal distributed 2026-10-30, especially pages 3, 6 and 8  
**Related decision:** DEC-025  
**Purpose:** close only the operating rules needed for the annual preventive-order contract.

## Terminology

The Spanish user-facing term is **actuación preventiva programada** for the planned item under the annual order. Its linked `ExecutionRecord` stores actual dates, result and feedback. `MaintenanceOccurrence` remains Triggering due/release evidence.

## What the proposal already establishes

- Selected preventive tasks based on time may be grouped into one annual Work Order containing several periodic executions.
- Each execution has its own date and result; the cycle-end view distinguishes completed from pending work.
- Condition-monitoring rounds keep their own cadence; a reading or alarm does not automatically create a repair order.
- A major repair may reset affected time-based frequencies, but the classification and scope need definition.

## Recommended wording for ratification

| Decision | Recommended rule | Boundary still needing confirmation |
|---|---|---|
| Eligible activities | Only time-based activities explicitly designated for annual grouping in the Approved Maintenance Plan. Group by asset + plan activity + cycle; do not combine unrelated activities. | Which current plan activities are designated. |
| Cycle boundary | Use explicit start/end dates and a CycleKey from the approved plan or approved planning period. Do not assume calendar year. | Whether TR uses plan-validity, fiscal, calendar or another period in each case. |
| Pending actions | At cycle end, do not close, transfer or replace a pending planned action automatically. Keep it pending until an authorized person records a disposition and reason. Do not technically close the parent while an action lacks execution evidence or a recorded disposition. | Authorized role and allowed dispositions (for example, keep open, replan, or cancel with reason). |
| Major repair | Reset only the time-based activities explicitly identified and approved as affected after the repair is completed, from the agreed effective date. Record source repair, affected policies, previous/new due dates, approver and reason. Never reset condition-monitoring cadence. | TR criteria for classifying “major repair,” affected scope and approval authority. |

## Decision status and traceability

Rubén accepts the recommendations as a functional baseline for the candidate design. The original proposal remains an accurate record of what was distributed and continues to show these items as decisions requiring TR confirmation. This brief adds a recommendation; it does not claim that the responsible managers have ratified it.

Until ratification, technical design may use the baseline only as an explicitly provisional assumption. SQL DDL and runtime flows must not encode the open boundaries as defaults. Synthetic data must label cycle dates, actions and repair cases as illustrative.

## Gate completion evidence

PM-GROUP-G01 can close when Responsables de TR Mantenimiento and TR Servicios either:

1. Ratify the recommended wording as written; or
2. Amend the wording and identify the owner for any remaining rule.

The resulting decision must be reflected in the functional proposal revision, DEC-025, logical/physical contracts, synthetic scenarios and DVP read model before runtime implementation.
