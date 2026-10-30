# CMMS Lab DVP — Readiness findings from first functional trace

**Date:** 2026-10-30  
**Status:** analysis complete; target/interaction refinements required before PaYaml  
**Sources reviewed:** CMMS Proposal v12 (30/10), DVP screen contract, first-touch brief, curated synthetic full-cycle fixture, and the two target SVGs at commit `94aab551f792041407f5c4260422cd40348a69ab`.

## Confirmed in the functional source

The first two-screen journey may demonstrate a preventive order that references the Approved Maintenance Plan and its version, contains several periodic planned actions, and shows each actual execution separately. The cycle-end example must distinguish completed from pending actions and leave the pending disposition open. The demonstration must label all fixture data as synthetic and must not assign authority to Hernando or Eduardo.

## Findings that must be resolved before screen source

| ID | Finding | Evidence | Recommended resolution |
|---|---|---|---|
| GAP-01 | Work Queue shows annual PM and a corrective follow-up row, while its only detail route is Annual Work Order Detail. A corrective row cannot safely open the annual detail. | Queue target contains `LAB-CM-2026-018`; the screen contract defines only annual-order detail. | Scope this first queue view to annual preventive orders. Keep corrective and CBM cases for later DVP slices; do not imply a generic detail route. |
| GAP-02 | The target exposes **Export**, but neither the screen contract nor the first functional journey defines its output, permissions, or behavior. | Queue target contains an Export control; no export operation appears in the DVP interaction inventory. | Remove Export from this first slice. Revisit it only when a concrete user task and data contract justify it. |
| GAP-03 | Detail target exposes **Open execution record**, but the view graph does not define a separate execution screen or return path. | Detail target has the button; the screen contract presents execution as linked information in the order detail. | Keep the execution evidence in the selected-action panel. Treat selection as an in-screen interaction; defer a separate execution view. |
| GAP-04 | The work queue uses counts 128, 24 and 09, but their population and formulas are not specified by the functional source or the read contract. | Queue target shows three operational KPIs; screen contract only describes these counts generally. | Derive them from the exact selected demo profile and document each numerator, population, state inclusion and as-of date. Until then label them as illustrative, not validated KPIs. |
| GAP-05 | Both targets include app-wide navigation surfaces outside the first journey. Their routes and retention behavior are not part of the current screen-view graph. | Targets display Work Orders, Planning & Schedule, Execution History, Assets, Approved Plans and Condition Monitoring. | Keep the canonical shell, but classify those destinations as host navigation outside this capability. Do not mark them as implemented by this DVP slice. |

## Recommended first-slice boundary

- One read-only journey: **annual preventive Work Queue → Annual Work Order Detail → return to the same queue context**.
- The initial queue dataset contains annual preventive orders only; action counts and dates come from the selected deterministic synthetic profile.
- The detail shows plan/version provenance, explicit demo cycle label, each planned action, and its linked execution record when present.
- Search/filter/sort/paging/refresh remain candidate read interactions only when each has a source formula and observable demo result.
- No export, schedule, assign, execute, close, cancel, carry-forward, frequency reset, or permission-dependent command.
- Corrective and condition-monitoring scenarios stay in the full-cycle data pack but are not routed through this initial detail screen.
- Existing visual direction (premium layout, compact queue header, HERO order detail header with the right-side photo) is retained. Content refinements require a new target revision and matching SHA; do not silently change the current SVG while presenting it as the same approved target.

## Scope inventory status

A draft `iap-functional-scope-v1` is in `cmms-work-queue-annual-detail.functional_scope.candidate-v1.json`. It maps six source-derived requirements to the two views, but the independent human baseline review is still **PENDING**. It must be reconciled with GAP-01 through GAP-05 before Phase A/B and before any product PaYaml. The D2P functional scope script/report has not been run, and no Studio/runtime validation is claimed.

## Next actions

1. Revise the screen contract and target candidates to the first-slice boundary above; pin the new immutable target revision and retain the previous files.
2. Update the functional scope inventory, including only supported routes and the explicit shell boundary; obtain the functional baseline review before product PaYaml.
3. Run D2P Phase A on the exact chosen components and host source, then Phase B, capacity/responsive gates, Phase C and the v3.3 delivery reports on one screen-source revision.
4. Prepare one complete Canvas source package for the eventual Studio first-touch. Do not ask for Studio work before source readiness reaches `READY_FOR_STUDIO`.
