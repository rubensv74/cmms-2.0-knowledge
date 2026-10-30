# AS-01 Assets — DVP target and host contract candidate

**Status:** DVP target candidate; not approved, not Studio-validated.  
**Screen ID:** AS-01.  
**Target:** [assets-list-v1-candidate.svg](targets/assets-list-v1-candidate.svg).  
**Authority:** [ASSETS UX Contract V1](../../../CMMS_ASSETS_LIST_UX_CONTRACT_V1.md), [Asset Screen Architecture V1](../../../CMMS_ASSET_SCREEN_ARCHITECTURE_V1.md), [Asset Premium Components V1](../../../CMMS_ASSET_PREMIUM_COMPONENTS_V1.md), [Asset Visual System V1](../../../CMMS_ASSET_VISUAL_SYSTEM_V1.md), [Screen Map V1](../../../../07-it-handoff/05-ui/screen-map.md).

## 1. Functional baseline

| Item | Contract |
|---|---|
| Primary user task | Find the asset needed and understand enough context to open the correct record. |
| Success criterion | Locate one unambiguous Asset by identity, type, location or filter, then open its detail. |
| Primary archetype | Data Explorer. |
| Search | AssetCode and Description. Add Manufacturer/Model/Serial only when the actual read model supplies them. |
| Filters | Equipment Type, FLH Location/hierarchy scope, Lifecycle Status and Criticality. |
| Data surface | Type icon, AssetCode, Description, Equipment Type, Location, Criticality, Lifecycle Status. Manufacturer/Model remain optional. |
| Primary action | Open Asset, using an explicit AssetCode route to AS-02. |
| Secondary action | Create Asset stays outside this read-only increment until write and permission contracts are verified. |
| States | LOADING, READY, EMPTY, ERROR and UNAVAILABLE_SOURCE. Error/unavailable must not look like a valid empty list. |

The product Screen Map calls the surface “Assets List / Hierarchy Explorer”; the accepted AS-01 UX Contract specifies a Data Explorer with an FLH location/scope filter. This target therefore shows a filterable list. It does **not** introduce a separate hierarchy tree. FLH and ADR physical parentage remain distinct.

## 2. Target interpretation

The SVG is a visual reference for hierarchy, content and interaction intent. Its 1600×1040 viewBox is presentation framing, not a Power Apps geometry contract. The DesignSystemLab YAML is approximately two months old and labels its colors/tokens as candidates; this target uses that palette only to make a reviewable candidate.

The table rows are illustrative examples, not Asset Master data. The connected read model, source freshness, runtime project context and permissions are not represented as verified. No KPI, health score, export, bulk action, thumbnail gallery or 3D interaction is introduced.

## 3. Component mapping

| Region | Candidate | Status and responsibility |
|---|---|---|
| Navigation shell | Existing cmp_FL_SidebarPro | Visible as imported in the provided current Studio component tree. Its public inputs/events and current source were not included; inspect them before binding. |
| Page identity | Existing cmp_FL_PageHeaderPro | Visible as imported. Do not assume its property signature or that it has the current approved CMMS header contract. |
| Search and filters | Host controls; optional IAP FilterChips for showing active filter values | No IAP component is installed. Host owns the query and filter state. FilterChips does not replace the filter input controls. |
| Asset grid | IAP DataGridPro main candidate source | Not installed in the app or Studio-validated for CMMS. Current source blob SHA: d0f5e601fb46c97a02480bab1e65a965f3421553. A held alternate in IAP PR #10 has the same Canvas component identity; do not import both or promote the alternate until reconciled. |
| Hierarchy | No tree component selected | cmp_FL_TreePro is present in the app, but AS-01’s accepted contract does not specify a standalone tree region. Do not force it into this screen. |
| Screen states | Host state plus a compatible CMMS/IAP state component only after source and install gates | A component's visual state is not proof that the corresponding data request or permission check ran. |

The IAP candidate source is [cmp_IAP_DataGridPro_WC_Candidate.pa.yaml](https://github.com/rubensv74/industrial-application-platform/blob/main/components/canvas/candidates/cmp_IAP_DataGridPro_WC_Candidate.pa.yaml). Its normalized slots are C1…C10; rows carry RowKey and C1…C10; State supports READY, LOADING, EMPTY, ERROR and UNAVAILABLE. It exposes OnRowSelect(p_key) and OnSort(p_sortKey). It does not provide local search or pagination.

The candidate FilterChips source is [cmp_IAP_FilterChips_WC_Candidate.pa.yaml](https://github.com/rubensv74/industrial-application-platform/blob/main/components/canvas/candidates/cmp_IAP_FilterChips_WC_Candidate.pa.yaml), blob SHA 8477dd1994e891cc84a59e027633d7a229307e67. It can represent active filters; the host must keep filter state and respond to OnFilterSelect/OnClearAll.

## 4. Host-to-grid data and event contract

When an approved Asset read adapter is available, map its records to the grid without adding domain formulas to the shared component:

| Grid property | Host mapping |
|---|---|
| Columns C1 | AssetCode; primary text; sort key AssetCode. |
| Columns C2 | Description; sort key Description. |
| Columns C3 | EquipmentType display value; sort key from the approved read model. |
| Columns C4 | FLH Location display value; do not substitute ADR parent. |
| Columns C5 | Criticality label; text treatment until project criticality color semantics are defined. |
| Columns C6 | Lifecycle Status; state treatment only from governed status values. |
| Rows RowKey | Stable AssetCode for this list. |
| Rows C1…C6 | The corresponding values above; omit C7…C10 unless a governed field is added. |
| OnRowSelect(p_key) | Host resolves the row by RowKey, obtains AssetCode and navigates to AS-02 with that identity. |
| OnSort(p_sortKey) | Host applies a stable sort to the data; component does not own the domain query. |

Search, filters, permissions, data retrieval, paging, empty/error decisions and navigation remain host responsibilities. The source of the Asset read data and the exact adapter/action name must be resolved from the current CMMS data contract before creating Power Fx bindings. This DVP does not guess a flow or stored procedure.

## 5. Current readiness

| Gate | Result |
|---|---|
| Functional screen contract | PASS — existing AS-01 UX Contract. |
| Target visual | CANDIDATE — this SVG; not human-approved. |
| Installed IAP components | NONE — user-confirmed. |
| IAP DataGridPro source | CANDIDATE — main source pinned above; held alternate-source conflict remains in IAP PR #10. |
| Host/data bindings | GATED — exact Asset read adapter and current app schema not provided. |
| Power Apps composition | GATED — no AS-01 screen exists in the app; installed FL component signatures/source are not in the provided snapshots. |
| Studio render, App Checker, Save/Reopen | NOT_RUN — no runtime evidence in the supplied capture/YAML. |
| Geometry/tokens | CANDIDATE — use current Studio Foundation baseline before fixing measurements or promoting colors. |

## 6. Next implementable increment

1. Refresh the current First-Touch baseline for DesignSystemLab and ComponentLab in Studio; record full renders and current YAML because the supplied exports are about two months old.
2. Inspect current public properties and source/version for cmp_FL_SidebarPro and cmp_FL_PageHeaderPro. Reconcile Component1 and cmp_FL_RiskMatrixPro_1 before changing either.
3. Resolve whether CMMS DataGridPro or IAP DataGridPro is the intended shared grid. If IAP is selected, use only the pinned main candidate and keep PR #10’s alternate on hold.
4. Resolve the Asset read contract, exact output fields and source/host operation before writing screen formulas.
5. Import only the selected component into the app; verify import, save/reopen, App Checker, row selection, sorting, filter state and responsive behavior in Studio.
6. Build the AS-01 Canvas screen against this target only after the above inputs are fixed.

Do not create product PaYaml from this reference alone. It is a DVP target, not proof of an installed component or working Asset screen.
