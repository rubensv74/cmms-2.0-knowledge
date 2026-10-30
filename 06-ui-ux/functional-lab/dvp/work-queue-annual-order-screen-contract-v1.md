# CMMS Lab — DVP screen contract candidate

**Status:** functional screen contract candidate; suitable for provisional DVP composition, not Studio-validated  
**Baseline:** DEC-025 and analyst-accepted recommendations; synthetic data only  
**Users:** Hernando and Eduardo as first walkthrough users; no roles or permissions inferred  
**Proposal authority:** CMMS Solution Proposal, 2026-10-30, pp. 3, 6 and 8

## 1. Purpose and decision boundary

Define the first visible slice of the CMMS Lab so screen work can continue while TR feedback is pending. Business recommendations accepted by the functional analyst may shape the lab prototype as provisional behavior. They must remain labelled as candidates until TR Mantenimiento and TR Servicios ratify them.

This screen contract is not runtime authorization, a final data schema, or a claim that the screens have been generated or tested in Power Apps Studio.

## 2. First-touch journey

The walkthrough has two screens. Users can find an order, understand what it covers, inspect the planned actions and see each recorded execution result. Each shared page header includes the hero image, a plain-language purpose and the actions available on that screen. No mutation command is included in this slice.

### Screen A — Work Queue

**Question answered:** Which maintenance work needs my attention?

| Region | Content | Interaction |
|---|---|---|
| Global context | CMMS Lab identity, project selector/context, breadcrumb, current data freshness | Change project context; no role choice is inferred |
| Shared PageHeaderPro hero | Industrial hero image with readable overlay, screen title, one-sentence purpose, refresh timestamp and refresh action | Refresh the read model with visible loading/complete/error feedback; image is decorative and has accessible text alternative |
| Attention summary | Total open orders, due/upcoming planned actions, incomplete annual orders, orders with findings | Open the matching filtered queue; counts are synthetic |
| Filters and views | Work type, order state, plan provenance, asset, cycle label, planned-action state; saved views as a candidate | Combine filters; clear filters; preserve the current view |
| Work grid | Order number, asset, activity, plan/version, cycle label, completed/total actions, next planned date, aggregate order state | Sort, page, open a row without losing the current queue context |

Cycle values are read from the explicit CycleKey/display label. The interface does not manufacture a calendar-year cycle when no cycle label is supplied.

### Screen B — Annual Work Order Detail

**Question answered:** What does this order cover, what is planned, and what has been recorded?

| Region | Content | Interaction |
|---|---|---|
| Shared PageHeaderPro hero | Industrial hero image, order identity/status, one-sentence explanation, return-to-queue and refresh actions | Return with filters/page retained; refresh read data with visible feedback |
| Order context | Asset, approved plan/version, activity, explicit cycle label and aggregate status | Follow plan provenance; cycle label is displayed as supplied |
| Summary strip | Planned-action count, completed count, scheduled count, pending count | Selecting a count filters the action list |
| Planned-action timeline | Chronological “Actuaciones programadas” with planned date, state, schedule/resource summary | Select an action; timeline selection does not mutate the order |
| Execution detail | Linked ExecutionRecord, actual start/finish, outcome, labor/material actuals, checklist/evidence and findings where available | Open linked finding or evidence in context |
| Provenance | Plan/version, trigger/occurrence evidence, related corrective follow-up, when present | Navigate to linked source without conflating it with the annual order |

The 2026 synthetic scenario shows four planned actions: two completed, one scheduled and one still planned. The separate cycle-end scenario shows three completed and one pending; it carries no selected disposition. Neither dataset defines TR policy.

## 3. Screen states

The hero image remains decorative: it must not carry instructions or status information, and overlay contrast must preserve readable text.

The screen-level actions are read-only in this slice: refresh, search, combine/clear filters, choose a saved view, sort/page, open an order, return to the queue, select a planned action and follow an existing relationship. Each action must produce an understandable result; no write behavior is implied.

Both screens must represent these states explicitly:

- Loading: stable layout with skeletons; do not shift the page when results arrive.
- Populated: show the selected project, filter context and result freshness.
- Empty: distinguish “no matching rows” from “no orders exist.”
- Partial data: preserve available order/action data and identify which linked detail is unavailable.
- Read failure: show a retry action and a user-readable error; retain filters and current selection.
- Stale data: show the refresh time and allow a deliberate refresh.

Completed actions display actual execution data from their linked ExecutionRecord. Planned or scheduled actions show planned/scheduled information without fabricated actual dates or results. DueAt from Triggering remains distinct from a scheduled commitment.

## 4. Candidate IAP component placement

Use only components whose task fits the surface. The 32-component inventory remains an app-wide coverage target, not a requirement to place all components on these two screens.

| Surface | IAP candidates | Intended use |
|---|---|---|
| Shared shell | PageHeaderPro with hero image, GlobalContextBar, ContextBreadcrumb | Identity, project context, location in the app; provide a readable title/purpose and screen-level refresh or return actions |
| Work Queue | MiniMetricStrip, FilterChips, SavedViews, DataGridPro, NeedsAttentionInbox, ActionFeedbackBar | Orient, narrow, inspect and open work |
| Annual detail | EntityInspector, ActivityTimeline, RelationshipsExplorer, SmartDrawer | Explain order context, sequence, links and selected action details |
| Responsive behavior | ResponsiveLayoutMetrics, ResponsiveScreenBudget | Check tablet density and narrow layouts |
| User feedback | SkeletonLoader, ActionFeedbackBar | Loading and refresh states; no write-action assumptions |

Component names are candidate identities from the IAP source inventory. Before screen generation, pin exact source revisions and host contracts in the DVP evidence package.

## 5. Candidate data read contract

This is a read-model requirement, not a physical schema approval.

### Work Queue row

- WorkOrderId and order number.
- Work type and aggregate order state.
- Asset identity and display description.
- Approved plan item and version.
- Explicit CycleKey and display label, when applicable.
- Planned-action counts grouped by state.
- Next planned date, distinct from DueAt and ScheduledAt.
- Data freshness and any attention reason.

### Work Order detail

- Parent WorkOrder summary and plan provenance.
- Ordered WorkOrderPlannedAction collection with identity, planned date, schedule, state, and optional MaintenanceOccurrence link.
- Linked ExecutionRecord for performed actions, with actual dates, result, performer, actuals, evidence and findings.
- Related corrective follow-up when a finding leads to planning review.

The read contract must not infer “completed” from the parent state alone. A completed action requires its own linked execution evidence. A pending action remains visibly pending until its disposition is resolved under the approved rule.

## 6. Actions deliberately outside this slice

No create, reschedule, assign, execute, close, carry-forward, cancel, or frequency-reset command is exposed in this walkthrough. Those actions need approved transitions, authority and backend contracts. This keeps the first screen useful for discovery and explanation while write behavior is still being defined.

When later screens add asynchronous commands, apply the CMMS Async Action Guard, server-side authorization, idempotency, controlled errors and the matching SQL/flow contract.

## 7. DVP production inputs and remaining evidence

This contract supports provisional visual composition. A Studio-ready DVP package still requires:

- Approved target visual or explicit product-design approval.
- Canonical source PaYaml for an existing host screen, or a governed new-screen baseline.
- Current render when revising an implemented screen.
- Exact IAP component source revisions and host inputs/outputs/events/states.
- Desktop and tablet viewport budgets.
- Studio parse/render evidence and current-to-target visual QA.

Until those inputs are pinned, the deliverable is a functional screen contract candidate; it must not be labelled Studio-ready.


## 8. Provisional visual references

- [Work Queue target candidate](targets/work-queue-v1-candidate.svg)
- [Annual Work Order Detail target candidate](targets/annual-order-detail-v1-candidate.svg)

Both SVGs are synthetic design drafts, not approved target images or Power Apps renders. They are enough to conduct a visual review and update the candidate layout while the business rules remain provisional.
