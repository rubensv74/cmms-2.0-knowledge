# CMMS Lab — DVP screen contract v2 (candidate)

**Status:** functional and visual candidate; not Studio-validated  
**Functional source:** CMMS Proposal v12, 30/10/2026, pp. 3, 6–7  
**Synthetic source:** Functional profile v1.1 and its DVP projection  
**Walkthrough users:** Hernando and Eduardo; no security role or authority inferred  
**Slice:** read-only Annual Preventive Work Queue → Annual Work Order Detail → return with queue context retained.

## 1. Purpose and boundary

This first Canvas slice demonstrates the confirmed annual preventive pattern: one order groups periodic planned actions; each action has its own state and, when performed, its own ExecutionRecord with actual dates and result. The UI calls the planned child **actuación preventiva programada**. It does not call it a visit.

The queue is deliberately scoped to annual preventive orders because the only detail view in this slice is an Annual Work Order Detail. Corrective and condition-monitoring records remain in the full synthetic dataset for later journeys; they are not shown as rows that would lead to the wrong detail screen.

All values come from a deterministic synthetic profile. No SQL, Power Automate, authorization, export, or production data is connected.

## 2. First-use journey

1. Open **Work Queue** with the active view **Annual PM**.
2. Search or filter annual orders by state, asset, activity, or cycle; inspect the plan and child-action counts in the row.
3. Open an annual order.
4. See asset, plan/activity provenance, cycle label, each planned action and its distinct execution evidence.
5. Return to the same queue with project, filters, sort, page, and selection retained.

### Screen A — Work Queue

**Question answered:** Which annual preventive orders are in the demo, and what is their current shape?

- Shared page header: hero photo on the right, title/purpose on the left, freshness and read-only refresh.
- Active view marker: Annual PM.
- Four synthetic profile summaries with definitions: 62 annual orders; 248 planned actions; 124 annual execution records; 124 not-completed actions (62 scheduled + 62 planned).
- Search and filters: order state, asset, activity and explicit cycle.
- Grid: order number, asset, activity, CycleKey, completed/total action count, next scheduled date, and parent display state.
- Page and sort controls preserve the active filter context.

These profile totals describe the generated fixture, not operational KPIs. The queue has no export control and does not mix in corrective or CBM orders.

### Screen B — Annual Work Order Detail

**Question answered:** What does this annual order cover, what is planned, and what execution evidence is recorded?

- HERO page header with photo on the right; host-owned Back to Work Queue and read-only refresh.
- Asset identity/location; synthetic published plan version and activity; explicit CycleKey and demo disclaimer.
- Summary: total actions, completed, scheduled, and planned.
- Chronological **Actuaciones programadas** with planned due date and state. ScheduledAt and DueAt remain separate.
- Selecting a completed action shows its ExecutionRecord inline: actual start/finish, result, performer reference and any linked finding/follow-up when available.
- No separate “Open execution record” route is implied.

The default example is `LAB-PM-2026-00004`: two completed actions with records, one scheduled action, and one planned action. A separate cycle-end scenario retains one pending action with no selected disposition; it is a different fixture record and does not authorize carry-forward, closure, or cancellation.

## 3. State and interaction contract

Both screens show stable loading, populated, empty, no-results, partial-data, stale and read-error states. Retry retains the current context. Synthetic labels remain visible. A missing ExecutionRecord does not receive invented dates/results. The parent state is not used to infer child completion.

The interactions are read-only: refresh, search, combine/clear filters, sort, page, open an annual row, select an action, inspect inline evidence, and return. Every visible interaction must have an observable result in the demo.

## 4. Candidate component placement

| Region | IAP candidates | Host responsibility |
|---|---|---|
| Shared shell | GlobalContextBar, ContextBreadcrumb | Project context, app navigation and breadcrumb |
| Page identity | cmp_IAP_PageHeaderPhotoPro | Host supplies photo, purpose, refresh/back actions and state |
| Queue | MiniMetricStrip, FilterChips, DataGridPro | Bind synthetic read collections, filter/sort/page and row navigation |
| Detail | EntityInspector, ActivityTimeline, RelationshipsExplorer | Bind order, planned actions and selected execution inline |
| Loading/feedback | SkeletonLoader, ActionFeedbackBar | Present read-only loading, refresh outcome and errors |
| Responsive | ResponsiveLayoutMetrics, ResponsiveScreenBudget | Report/compare responsive layout; source presence is not Studio certification |

These are candidate sources; pin each used source SHA and host property contract during D2P Phase A. The 32-candidate IAP coverage remains an app-wide inventory, not a demand to place every component here.

The header source candidate is `cmp_IAP_PageHeaderPhotoPro`, IAP main commit `377a6b3c00c7bef7a8d9e1cfdb5eeb968fbdfe2c`, blob `ee19e10cf66b2648f5b91433e990cf988f64fcad`. Work Queue uses COMPACT; detail uses HERO. Studio import, rendering and interaction remain unverified.

## 5. Data contract for the DVP projection

Source: `synthetic-data/cases/cmms-work-queue-annual-detail-v1.1.json`.

- Queue rows are filtered to `PREVENTIVE_ANNUAL` in the demo data mode.
- Each row carries WorkOrderId/No, asset identity, activity/plan/version, CycleKey, action-state counts, parent state and next scheduled time.
- Detail carries the ordered WorkOrderPlannedAction set and linked ExecutionRecords/findings. DueAt, ScheduledAt and actual dates are distinct fields.
- The projection exposes only the selected annual order and its relationships; corrective and condition cases remain separate.
- The 2026 cycle and all activity names/records in this profile are illustrative. The generator does not approve cycle rules or plan content.

This is a UI read-model requirement, not a physical SQL schema or a runtime flow contract.

## 6. Explicitly outside this slice

Create, schedule, assign, execute, close, cancel, carry forward, reset frequency, issue permits, reserve inventory, export, modify a plan, and permission-dependent commands. They need separate user tasks, approved transitions/authority, and SQL/flow contracts before appearing as working commands.

## 7. DVP 3.3 readiness still required

The v2 SVG targets are candidate revisions preserving the accepted photo-header direction. Before product PaYaml: complete the functional source inventory/review; pin the exact target and approval evidence; map every target region to function, state, component/control and acceptance; run Phase A, Phase B, capacity/responsive, Phase C and v3.3 source reports against one candidate SHA; record the separate initial-view action gate. A first Studio import/render and matched screenshot comparison are still runtime evidence, not implied by this document.

- [Work Queue v2 target](targets/work-queue-v2-candidate.svg)
- [Annual Order Detail v2 target](targets/annual-order-detail-v2-candidate.svg)
- [First-use brief v2](first-touch-work-order-experience-v2.md)
