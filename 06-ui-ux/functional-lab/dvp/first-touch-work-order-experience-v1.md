# CMMS Lab — First-touch DVP brief: Work Queue and Annual Order

**Status:** interaction brief and functional screen contract candidate; not a Studio-ready package  
**Business source:** CMMS Solution Proposal, 2026-10-30  
**Technical dependency:** DEC-025 / PM-GROUP-G01 candidate contract  
**Primary users for walkthrough:** Hernando and Eduardo; operational roles/permissions not inferred here

## 1. DVP objective

Detailed layout/data contract: [Work Queue and Annual Order screen contract](work-queue-annual-order-screen-contract-v1.md).

Prove that a first-time user can follow the narrative from approved plan to annual preventive order, understand the execution outcome attached to each planned action and identify pending work without confusing parent order state with planned action state.

The initial walkthrough is a two-surface journey:

1. Work Queue — identify and open the correct work.
2. Annual Work Order Detail — understand the order and its planned actions; open one planned action to inspect its execution record.

The initial slice is not the full CMMS product, and it does not assign a named role to either stakeholder.

## 2. Scenario source

Use the 2026 annual PM parent in the versioned functional fixture for completed, scheduled and upcoming planned action states. Use the separate SCN-ANNUAL-YEAR-END-PENDING scenario in the curated walkthrough fixture to show three completed planned actions and one pending at cycle end; its cycle boundary and disposition options are illustrative and no outcome is selected. Use the major-repair cadence-reset records only as a separate scenario; they are DEMO-only and do not assert an approved scope rule.

No real asset, person, corporate standard or production inventory is represented.

## 3. Screen contract

### WQ-01 — Work Queue

**User question:** What work needs attention, and which annual order should I open?

Candidate regions:
- CMMS app shell and project context;
- page header and compact action/search area;
- attention summary for overdue, pending decision, blocked readiness and due soon;
- filter chips for work type, planned action state, asset and plan provenance;
- paged work grid with stable parent identity, asset, activity, cycle label, completed planned-action count, next planned action date and aggregate state.

Required interactions:
- Apply/remove filters without losing project context.
- Open parent detail from a row.
- Show loading, empty, error, blocked and stale-data states explicitly.
- Do not imply that a synthetic row is live runtime data.
- Do not present a measurement threshold as an auto-generated repair order.

### WO-01 — Annual Work Order Detail

**User question:** What does this order cover, and what is planned for each action? What execution result is recorded when it is performed?

Candidate regions:
- parent identity, asset and approved plan/version provenance;
- cycle label as supplied by the approved contract;
- summary of completed, pending and upcoming planned actions;
- ordered planned action list/timeline, with date, status and result per planned action;
- selected planned action detail with execution evidence, actual dates, hours/materials/findings as available;
- linked corrective follow-up kept visibly separate from preventive parent.

Required interactions:
- Select a planned action and navigate to its details without changing the parent context.
- See planned/due/actual dates distinctly and preserve null/unknown values.
- Show a pending planned action as pending until an explicit decision is made; do not auto-transfer or close it.
- Keep annual parent completion distinct from completion of one planned action.
- Do not offer release, schedule, execute, close or cancel commands before their authority and state contracts are approved.

## 4. IAP coverage map — candidates, not CMMS-certified components

Current IAP source records show candidate/source states; they do not establish CMMS Studio validation. Pin exact source commit/SHA and check the host contract before use.

| Journey region | IAP candidate capability | Placement purpose | Current caveat |
|---|---|---|---|
| App shell | GlobalContextBar, navigation shell | Project/case context and primary movement | Cross-product source/host gate required |
| Work queue header | PageHeaderPro | Name, context and primary action | Existing evidence is not automatic CMMS certification |
| Work queue | FilterChips, DataGridPro | Filtering and paged work list | DataGridPro source reconciliation and host contract required |
| Attention summary | NeedsAttentionInbox, MiniMetricStrip | Surface actionable workload and counts | Candidate styling/source/Studio state must be checked |
| Commands | ContextualCommandBar, ActionFeedbackBar | Context-sensitive actions and result feedback | Command authority and async guard contract required |
| Detail | EntityInspector, ActivityTimeline, RelationshipsExplorer | Parent identity, planned action history and linked records | Host binding and planned-action-level contract required |
| Loading/empty states | SkeletonLoader | Localized loading state | Cross-product runtime evidence still required |
| Plan change review | DiffViewer, SideBySideComparison | Compare plan/strategy revisions when that journey is built | Not needed in first queue screen |

Use components where the interaction fits, and map remaining applicable IAP capabilities to their proper CMMS workspace. Maintain a coverage ledger with exact source, host inputs/outputs, events, states and validation gate; do not force unrelated components into WQ-01.

### 4A. App-wide IAP candidate coverage target

Inventory checked against IAP main commit 377a6b3c00c7bef7a8d9e1cfdb5eeb968fbdfe2c (32 Canvas candidate sources). This is a coverage plan across the CMMS experience, not a claim that any candidate is CMMS-certified or belongs on WQ-01.

| CMMS experience | IAP candidate identities |
|---|---|
| App shell and navigation | PageHeaderPro, GlobalContextBar, ContextBreadcrumb, GlobalSearch, RecentFavorites, NotificationCenter, CommandPalette, ContextualAssistant |
| Work queue and actions | FilterChips, DataGridPro, SavedViews, NeedsAttentionInbox, MiniMetricStrip, BulkActionBar, ContextualCommandBar, ActionFeedbackBar, SkeletonLoader |
| Work Order and planned action detail | EntityInspector, ActivityTimeline, RelationshipsExplorer, SmartDrawer |
| Planning, standards and choices | AvailabilityMatrix, GroupedCardExplorer, OptionPicker |
| Asset context and evidence | HierarchyTreePro, MediaGallery, PageHeaderPhotoPro, PhotographicStage |
| Governed plan comparison | DiffViewer, SideBySideComparison |
| Responsive design and capacity | ResponsiveLayoutMetrics, ResponsiveScreenBudget |

Before adoption, pin each candidate source SHA and prove its host inputs, outputs, events and states. For each source, record consumer screen, reuse/adapt decision, source caveat and Studio gate. A component with no credible CMMS task remains deferred with a reason; the coverage target does not justify adding UI without user value.

## 5. DVP/D2P 3.3 production inputs

Before producing a final PaYaml screen:
- approved functional/image blueprint and region archetypes;
- exact IAP source revisions and instance host bindings;
- explicit screen states and action/error journeys;
- target viewport and responsive alternatives;
- UX-capacity counts per active mode and a scrolling/access policy;
- pinned approved planned target image (identity/revision/hash) separate from any later current render;
- region-to-function-to-IAP-to-Canvas traceability.

No current CMMS render or approved first-touch image target is pinned in the repository. Therefore this brief is a preflight artifact; it is not READY_FOR_STUDIO and does not replace an actual DVP screen package.

## 6. Acceptance walkthrough with Hernando and Eduardo

Ask each stakeholder to complete these tasks unaided:
1. Find an annual preventive order and explain what the parent represents.
2. Identify which planned actions are complete, pending and upcoming.
3. Open a planned action and report its own outcome and evidence.
4. Explain why a condition reading alone did not create a repair order.
5. Identify which policy questions remain for the maintenance decision owners.

Record confusion points by step, screen, fixture record and viewport. A successful synthetic walkthrough does not approve the SQL/Flow contract and does not count as Studio validation.


## User-facing terminology

In the Spanish walkthrough, label the child records **Actuaciones programadas**. The detail shows the planned date/state and, when performed, the linked execution record with actual dates, result and evidence. Do not label these records as visits.
