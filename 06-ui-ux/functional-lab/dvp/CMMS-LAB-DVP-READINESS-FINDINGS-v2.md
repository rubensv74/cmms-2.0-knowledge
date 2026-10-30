# CMMS Lab DVP — Readiness findings v2

**Date:** 2026-10-30  
**Status:** candidate scope corrected; human review, canonical source inventory, target approval and Studio evidence pending  
**Target blobs:** Work Queue f15d2a5ea4654c91791ee6f0b1b4c7c5aa02010d; Annual Order Detail 360ca111366f5f0e13caa051a762587715285bb2  
**Scope:** read-only annual PM queue → annual order detail → return with context.

## Findings from the v1 trace

| ID | Prior finding | Current disposition | Remaining evidence |
|---|---|---|---|
| GAP-01 | Corrective row had no compatible detail route | CLOSED IN CANDIDATE: queue is annual PM only | Confirm functional scope review. |
| GAP-02 | Export behavior/permissions were undefined | CLOSED IN CANDIDATE: Export absent | Reopen only with a supported task and data/permission contract. |
| GAP-03 | Separate execution-record button lacked route | CLOSED IN CANDIDATE: execution shown inline in selected action | Verify source control and selected-action state in D2P/Studio. |
| GAP-04 | KPI population/formulas were vague | CLOSED FOR SYNTHETIC PROFILE: 62 orders, 248 planned actions, 124 annual ExecutionRecords, 124 not-completed actions (=62 scheduled +62 planned) | Preserve the profile version and formula in every rendering; not operational KPIs. |
| GAP-05 | Shell destinations exceeded the two-view slice | BOUNDED: destinations remain host shell; only queue/detail/back are in-slice | Source/host integration and navigation ownership still need Phase A evidence. |
| GAP-06 | Refresh control had no read/query contract | CLOSED IN CANDIDATE: removed from both target SVGs and screen contract | If later added, specify source, observable result, loading/error and permission behavior. |
| GAP-07 | Detail action titles did not align to selected activity | CLOSED IN TARGET: all four action titles now use Heat exchanger inspection | Validate binding from selected plan/action in PaYaml; current SVG is a design artifact. |

## Readiness assessment

- Functional dataset and four visible rows are internally connected to profile v1.1; selected order is HX-0004, activity ACT-HX-PM, plan SYN-PLAN-000004, with four planned actions and two ExecutionRecords.
- Target and screen contract agree on no corrective/CBM rows, no Export/Refresh, and inline execution evidence.
- Annual completion/pending states are visible. Cycle-end disposition stays OPEN_DECISION; this detail screen does not resolve it.
- Functional scope candidate is v2 and still has baseline_review.status PENDING. FE-COVERAGE is not reported as PASS.
- IAP inventory now pins 12 source blob SHAs and extracts primary CustomProperties at commit 377a6b3c. Formula internals, dependency graph, canonical usage, host contract and Studio rendering remain unreviewed; the inventory and region map are still drafts.
- SVG dimensions and visual regions do not constitute Canvas layout measurements. Responsive capacity, navigation focus, keyboard behavior and initial-view action remain unverified.
- No product PaYaml, Studio import/render, SQL or Power Automate work is claimed.

## Next gates

1. Record functional baseline review for the v2 scope.
2. Review and approve the exact two target blobs.
3. Complete IAP source registry and host contract against a pinned source revision.
4. Complete measured region/budget, responsive, state and interaction evidence.
5. Run D2P v3.3 coverage reports, including the separate initial-view action gate, on a single coherent source/target set.
6. Prepare candidate PaYaml only when readiness is complete; then conduct First-Touch in Studio and preserve evidence.
