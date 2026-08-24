# CMMS 2.0 — ASSETS Capability Procedure Preflight

**Fecha:** 2026-08-24  
**Capability:** `ASSETS-CAP-01 — Assets Data Explorer`  
**Pantalla estable:** `scr_Assets`  
**Estado:** `PROCEDURE_READINESS = PASS`

## 1. Procedure preflight

```text
Repository: rubensv74/cmms-2.0-knowledge
Branch de implementación: feat/assets-capability-payaml
Canonical procedure: 30-playbooks/ai-assisted-engineering/incremental-ai-assisted-implementation.md
Procedure version: 3.0

Capability: ASSETS-CAP-01 — Assets Data Explorer
Risk: B
Dependencies:
  - Canvas app CMMS real
  - responsive foundation
  - gblTheme
  - gblLayout
  - gblSidebarCollapsed
  - gblSelectedNavKey
  - gblShellReady
  - cmp_CMMS_SidebarPro_RC0
  - cmp_CMMS_ProjectContextPro_RC0
  - cmp_CMMS_PageHeaderPro_RC0
  - cmp_CMMS_StatePanelPro_RC0
  - CMMS_ASSETS_LIST_FUNCTIONAL_BASELINE_V1
  - CMMS_ASSETS_LIST_READ_CONTRACT_V1
  - CMMS_ASSETS_LIST_UX_CONTRACT_V1
First-Touch Baseline required: YES
First-Touch status:
  - target scr_Assets: NEW / no previous runtime source exists
  - App bootstrap: CONFIRMED_IN_RUNTIME_SOURCE by Studio evidence
  - responsive settings: CONFIRMED_IN_RUNTIME_SOURCE
  - App Checker baseline: CONFIRMED_IN_RUNTIME_SOURCE
  - core component installation: CONFIRMED_IN_RUNTIME_SOURCE
  - full component custom-property source: UNKNOWN / runtime gate item
Runtime/Studio interaction strategy:
  repository candidate -> one cumulative PaYaml paste/import -> parser/render/runtime check -> one FIX batch if needed
Validation strategy:
  static source review -> YAML structural parse -> scalar-safety scan -> Studio parser -> render -> responsive -> local interaction -> App Checker delta -> save/close/reopen
Human gates:
  - MANUAL_RUNTIME_EVIDENCE for Power Apps Studio parse/render
  - later EXTERNAL_INPUT / architecture gate for physical Asset source + authorization model
Applicable skills:
  - requested @build-power-platform-frameworks: NOT EXPOSED in this session; not fabricated
  - execution method applied directly from canonical framework/playbooks
PROCEDURE_READINESS = PASS
```

## 2. Risk rationale

Risk `B` because this capability introduces functional UI behavior:

- screen state;
- local read-model fixture;
- search;
- four filters;
- sorting;
- row selection;
- output identity contract for Asset Detail;
- responsive Data Explorer composition.

It does **not** change:

- SQL schema;
- persistence;
- authentication;
- permissions;
- external API contracts;
- irreversible data;
- shared high-fan-out component definitions.

The future physical read adapter can require a new risk assessment.

## 3. Canonical procedures and standards consulted

### Primary

- `rubensv74/functional-engineering-knowledge-base/30-playbooks/ai-assisted-engineering/incremental-ai-assisted-implementation.md` — v3.0.
- `30-playbooks/power-platform/modular-power-apps-screen-construction.md`.

### Power Apps

- `15-standards/power-platform/power-apps-source-code-compatibility-standard.md`.
- `15-standards/power-platform/reusable-power-apps-component-contract.md`.
- `15-standards/power-platform/power-apps-component-identity-standard.md`.
- `15-standards/power-platform/power-apps-payaml-scalar-safety-standard.md`.

### UX/UI

- `15-standards/ux-ui/power-apps-visual-quality-standard.md`.
- `15-standards/ux-ui/enterprise-design-system-token-governance.md`.

### Delivery

- `15-standards/software-delivery/dependency-preflight-and-increment-readiness-standard.md`.
- `15-standards/software-delivery/studio-repository-source-synchronization-standard.md`.
- `15-standards/software-delivery/duplicate-execution-protection-standard.md`.
- `30-playbooks/power-platform/repository-first-artifact-delivery.md`.

### CMMS local governance

- `AGENTS.md`.
- `00-governance/ai/CMMS_AGENT_REGISTRY_V1.yaml`.
- `00-governance/ai/prompts/RUN_ENGINEERING_ORCHESTRATOR.md`.
- `06-ui-ux/CMMS_PREMIUM_SCREEN_STANDARD_V1.md`.
- `06-ui-ux/CMMS_PAGE_HEADER_HIERARCHY_V1.md`.
- `06-ui-ux/CMMS_COMPONENT_CATALOG_V1.md`.

## 4. Skill deviation

The requested skill identifier `@build-power-platform-frameworks` was searched in:

- installed plugin catalogue;
- accessible GitHub code;
- accessible repositories.

It is not exposed in the current session. No substitute skill name is invented.

This does not block execution because the canonical methodology that the skill is expected to orchestrate is directly available and has been read from current `main`.

## 5. Product baseline reconstructed

The repository already contained:

- accepted Assets functional baseline;
- accepted Assets list read contract;
- accepted Assets UX contract;
- earlier incremental plan;
- earlier shell candidate `08-resources/power-apps/screens/assets/blocks/01_shell.pa.yaml`.

The older candidate uses `scr_Assets_I01`. Current capability governance requires a stable product identity, so the cumulative candidate is normalized to:

```text
scr_Assets
```

`I01`, `S01`, `C01`, etc. remain construction trace identifiers only.

## 6. Runtime baseline already captured

Studio evidence from the active CMMS Canvas app confirms:

```text
App layout = Responsive
Lock aspect ratio = Off
Lock orientation = Off

Installed components:
  cmp_CMMS_SidebarPro_RC0
  cmp_CMMS_ProjectContextPro_RC0
  cmp_CMMS_PageHeaderPro_RC0
  cmp_CMMS_StatePanelPro_RC0

App.OnStart globals:
  gblTheme
  gblLayout
  gblSidebarCollapsed
  gblSelectedNavKey
  gblShellReady

Power Fx notation:
  function/record arguments = comma
  statements = semicolon

App Checker baseline:
  Accessibility = 208 pre-existing findings
  Performance = 3 pre-existing findings
```

## 7. Capability boundary

### Included now

```text
responsive shell
page/context foundation reuse
synthetic read model conforming to list contract
search AssetCode + Description
filters: Equipment Type / Location / Lifecycle / Criticality
sort
result count
data surface
row selection
explicit unavailable values
READY / EMPTY / ERROR / UNAVAILABLE state plumbing
Asset Detail identity handoff globals
```

### Deliberately not claimed

```text
productive Asset source
project authorization enforcement
server-side delegation/paging
Asset Detail navigation installed in runtime
Create/Edit Asset
bulk actions
3D thumbnails per row
```

## 8. Component classification

### A — reuse existing runtime components

- `cmp_CMMS_SidebarPro_RC0`
- `cmp_CMMS_ProjectContextPro_RC0`
- `cmp_CMMS_PageHeaderPro_RC0`
- `cmp_CMMS_StatePanelPro_RC0`

### D — local in this first consumer

- search/filter composition;
- data header;
- asset row/data gallery;
- result metadata.

The reusable candidates `FilterBarPro` and `DataGridPro` are not promoted to shared CMMS components in this capability because they do not yet have CMMS runtime identity or multi-consumer evidence. The implementation follows validated PaYaml patterns from AssetPlan without importing AssetPlan component identity.

## 9. Async Action Guard

No non-repeatable or transactional action exists in this capability. Search, filters, sorting and selection are local/read-only and intentionally repeatable.

Therefore Async Action Guard is **not applied** here. It becomes mandatory when Create/Edit/write/Flow/API commands enter scope.

## 10. Gate status

```text
PROCEDURE_READINESS = PASS
REPOSITORY_BUILD = AUTHORIZED
STUDIO_VALIDATION = PENDING HUMAN RUNTIME GATE
PHYSICAL_ASSET_SOURCE = DEFERRED ARCHITECTURE GATE
```
