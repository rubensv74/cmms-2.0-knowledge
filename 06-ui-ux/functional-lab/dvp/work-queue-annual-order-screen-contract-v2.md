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

1. Open **Work Queue** with the active view **Annual PM**. Use **How it works** to read screen guidance and supporting decisions; closing the modal preserves the queue state.
2. Search or filter annual orders by state, asset, activity, or cycle; inspect the plan and child-action counts in the row.
3. Open an annual order.
4. See asset, plan/activity provenance, cycle label, each planned action and its distinct execution evidence.
5. Use **How it works** in Annual Order Detail to review screen guidance and decision rationale. Close it without changing the selected action.
6. Return to the same queue with project, filters, sort, page, and selection retained.

### Screen A — Work Queue

**Question answered:** Which annual preventive orders are in the demo, and what is their current shape?

- Shared page header: hero photo on the right, title/purpose on the left, freshness metadata; no refresh control.
- Active view marker: Annual PM.
- Four synthetic profile summaries with definitions: 62 annual orders; 248 planned actions; 124 annual execution records; 124 not-completed actions (62 scheduled + 62 planned).
- Search and filters: order state, asset, activity and explicit cycle.
- Grid: order number, asset, activity, CycleKey, completed/total action count, next scheduled date, and parent display state.
- Page and sort controls preserve the active filter context.
- The visible **How it works** header action opens a screen-specific modal with purpose, available actions/limits, and meeting/decision rationale with dates and authority status.

These profile totals describe the generated fixture, not operational KPIs. The queue has no export control and does not mix in corrective or CBM orders.

### Screen B — Annual Work Order Detail

**Question answered:** What does this annual order cover, what is planned, and what execution evidence is recorded?

- HERO page header with photo on the right; host-owned Back to Work Queue; no refresh control.
- Asset identity/location; synthetic published plan version and activity; explicit CycleKey and demo disclaimer.
- Summary: total actions, completed, scheduled, and planned.
- Chronological **Actuaciones programadas** with planned due date and state. ScheduledAt and DueAt remain separate.
- Selecting a completed action shows its ExecutionRecord inline: actual start/finish, result, performer reference and any linked finding/follow-up when available.
- No separate “Open execution record” route is implied.
- The visible **How it works** header action opens the detail-specific modal; close retains the selected order/action and return context.

The default example is `LAB-PM-2026-00004`: two completed actions with records, one scheduled action, and one planned action. A separate cycle-end scenario retains one pending action with no selected disposition; it is a different fixture record and does not authorize carry-forward, closure, or cancellation.

## 3. State and interaction contract

Both screens define loading, populated, empty, no-results, partial-data and read-error states. This static synthetic slice has no refresh/retry action. Synthetic labels remain visible. The Help modal is an overlay state; open/close must preserve the underlying screen and its selection/context. A missing ExecutionRecord does not receive invented dates/results. The parent state is not used to infer child completion.

The interactions are read-only: open/close screen help, search, combine/clear filters, sort, page, open an annual row, select an action, inspect inline evidence, and return. Every visible interaction must have an observable result in the demo.

## 4. Candidate component placement

| Region | IAP candidates | Host responsibility |
|---|---|---|
| Shared shell | GlobalContextBar, ContextBreadcrumb | Project context, app navigation and breadcrumb |
| Page identity | cmp_IAP_PageHeaderPhotoPro (TMS-imported definition) | Host supplies photo/purpose; ShowAction=true, ActionText=How it works, ActionBusy=false; component OnAction event opens the screen-specific modal. Do not add a duplicate host button. TMS attachment signature matches 32 IAP properties; use the imported TMS body as source of truth. |
| Queue | MiniMetricStrip, FilterChips, DataGridPro | Host composes accessible local Search TextInput and pager; FilterChips emits filter intent; DataGrid receives normalized rows and emits row-select/sort. It has no search or pagination API. |
| Detail | EntityInspector, ActivityTimeline | Bind provenance and actual executions; compose planned-action selection in the host |
| Loading/feedback | SkeletonLoader, ActionFeedbackBar | Present loading/read errors; no refresh/retry outcome is in scope |
| Screen help | Canvas native overlay/container; no IAP modal candidate exists at pinned source | Version screen-specific usage, action limits and decision provenance; preserve state and implement accessible focus/close behavior |
| Responsive | ResponsiveLayoutMetrics | Candidate only for action-list / execution-panel split inside detail. Work Queue and Detail remain separate screens; do not use ResponsiveScreenBudget for this layout. Measure in Canvas. |

These are candidate sources; pin each used source SHA and host property contract during D2P Phase A. The 32-candidate IAP coverage remains an app-wide inventory, not a demand to place every component here.

The imported TMS component definition supplied by the user is the instance authority; its 32-property signature was compared with IAP main commit `377a6b3c00c7bef7a8d9e1cfdb5eeb968fbdfe2c`, blob `ee19e10cf66b2648f5b91433e990cf988f64fcad`. Names, PropertyKind and DataType match; bodies differ. Work Queue uses COMPACT; detail uses HERO. The target action aligns to the source button width (120 px); Studio import, binding and interaction remain unverified.

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

The v2 SVG targets are candidate revisions preserving the accepted photo-header direction and including the How it works entry point. Modal-open states are separate candidate SVGs. The DVP targets document the design only; screen source and accessible focus behavior remain unimplemented. Before product PaYaml: complete the functional source inventory/review; pin the exact target and approval evidence; map every target region to function, state, component/control and acceptance; run Phase A, Phase B, capacity/responsive, Phase C and v3.3 source reports against one candidate SHA; record the separate initial-view action gate. A first Studio import/render and matched screenshot comparison are still runtime evidence, not implied by this document.

- [Work Queue v2 target](targets/work-queue-v2-candidate.svg)
- [Work Queue help-open state](targets/work-queue-help-open-v1-candidate.svg)
- [Annual Order Detail v2 target](targets/annual-order-detail-v2-candidate.svg)
- [Annual Order Detail help-open state](targets/annual-order-detail-help-open-v1-candidate.svg)
- [First-use brief v2](first-touch-work-order-experience-v2.md)
