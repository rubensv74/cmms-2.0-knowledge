# CMMS 2.0 — ASSETS Capability Build Report

**Fecha:** 2026-08-24  
**Capability:** `ASSETS-CAP-01 — Assets Data Explorer`  
**Pantalla:** `scr_Assets`  
**Riesgo:** `B`  
**Rama:** `feat/assets-capability-payaml`  
**Estado:** `CANDIDATE / REPOSITORY_STATIC_VERIFIED / STUDIO_PENDING`

## 1. Resultado

Se ha construido un candidato acumulativo de la pantalla `Assets` mediante Power Apps Source Code / PaYaml.

Archivo acumulativo:

```text
08-resources/power-apps/screens/assets/scr_Assets.pa.yaml
```

La pantalla no requiere construcción manual control por control.

## 2. Functional baseline implementada

```text
scope/context
→ search
→ filter
→ list
→ sort
→ identify asset
→ select identity for Asset Detail handoff
```

La pantalla sigue siendo un `Data Explorer`; no duplica Asset Detail ni Maintenance.

## 3. Árbol implementado

```text
scr_Assets
└─ conAssets_Root
   ├─ conAssets_SidebarSlot
   │  └─ cmpAssets_Sidebar
   └─ conAssets_Content
      ├─ cmpAssets_ProjectContext
      ├─ cmpAssets_PageHeader
      └─ conAssets_Workspace
         ├─ conAssets_Search
         │  ├─ txtAssets_Search
         │  └─ btnAssets_Sort
         ├─ conAssets_Filters
         │  ├─ drpAssets_Type
         │  ├─ drpAssets_Location
         │  ├─ drpAssets_Lifecycle
         │  ├─ drpAssets_Criticality
         │  └─ btnAssets_Reset
         ├─ lblAssets_Meta
         ├─ conAssets_Header
         ├─ galAssets_Rows
         │  └─ conAssets_Row
         │     ├─ asset identity columns
         │     └─ btnAssets_Select
         └─ cmpAssets_StatePanel
```

## 4. Component classification

### A — reused, already installed in CMMS runtime

```text
cmp_CMMS_SidebarPro_RC0
cmp_CMMS_ProjectContextPro_RC0
cmp_CMMS_PageHeaderPro_RC0
cmp_CMMS_StatePanelPro_RC0
```

No shared component definition is modified.

### D — local, first consumer

```text
search input
four filter dropdowns
sort action
reset action
data header
asset gallery/rows
selection action
```

`FilterBarPro` and `DataGridPro` remain candidates for future promotion if reuse/fan-out appears. This avoids manufacturing new shared CMMS identity before multi-consumer evidence and Studio validation.

## 5. State model

```text
INITIAL
READY
EMPTY
ERROR
UNAVAILABLE_SOURCE
```

The synthetic adapter transitions synchronously from `INITIAL` to `READY` or `EMPTY`.

`cmp_CMMS_StatePanelPro_RC0` hosts non-ready states. Its custom-property binding must still be confirmed by Studio because complete runtime source for that component was not available in repository baseline.

## 6. Read-model fixture

The source is deliberately explicit:

```text
gblAssetsDataMode = SYNTHETIC_FIXTURE
```

Six records are loaded with variation in:

- Asset code;
- equipment type;
- location;
- criticality;
- lifecycle state;
- manufacturer/model availability.

This is not presented as production data evidence.

## 7. Interaction

### Search

Searches:

```text
AssetCode
Description
```

as required by the accepted V1 read contract.

### Filters

```text
Equipment Type
Location
Lifecycle Status
Criticality
```

### Sort

V1 candidate sorts Asset Code ascending/descending.

The read contract allows broader sort keys later; they are not needed to prove the current interaction contract.

### Selection / handoff

Selecting a row sets:

```text
gblAssetsTargetAssetId
gblAssetsTargetAssetCode
```

This prepares explicit identity handoff without referencing a screen that is not yet confirmed as installed.

Navigation itself remains a dependent integration gate.

## 8. Responsive implementation

The candidate reuses the runtime-confirmed responsive foundation:

```text
App.Width / App.Height
responsive root AutoLayout
gblLayout.SidebarCollapsed / Expanded
gblLayout.PagePaddingCompact / Desktop
FillPortions
```

No 1366×768 fixed canvas is embedded in the architecture.

## 9. PaYaml sources used as syntax evidence

### CMMS current baseline

```text
08-resources/power-apps/screens/assets/blocks/01_shell.pa.yaml
```

provided the CMMS shell/root/component instance syntax.

### AssetPlan verified/reference PaYaml

Used only as syntax/reference, not copied as CMMS component identity:

```text
power-apps/components/adapted/cmp_AP_FilterBarPro_RC0.pa.yaml
power-apps/components/adapted/cmp_AP_DataGridPro_RC0.pa.yaml
power-apps/screens/original/scr_Home.pa.yaml
```

Evidence used includes:

```text
GroupContainer@1.5.0
Gallery@2.15.0
Classic/TextInput@2.3.2
Classic/Button@2.2.0
DropDown@0.0.45
DropDownDataField@1.5.0
Label@2.5.1
CanvasComponent instances
```

## 10. Static validation executed

The cumulative file was checked before repository delivery.

### Generic YAML structural parse

```text
YAML_PARSE = PASS
```

This proves generic YAML structure only. It does **not** equal Power Apps parser validation.

### Stable screen identity

```text
root = Screens
screen = scr_Assets
scr_Assets_I01 absent
PASS
```

### Scalar safety heuristic

Checked inline formulas for ambiguous `: ` / ` #` patterns requiring block scalars.

```text
PASS
```

### Compatibility blacklist

```text
Label@2.5.1 + Radius*             absent
Classic/Button + AccessibleLabel  absent
TabList + Reset                   absent
fake Patch root                   absent
```

### Write boundary

No productive write operation is present:

```text
Patch
Remove
SubmitForm
Flow.Run
SQL DML
```

are absent from the candidate.

## 11. Requirements Guardian review

### Covered

- stable screen identity;
- Data Explorer role;
- search minimum;
- four filters;
- sorting baseline;
- explicit empty/error/source state distinction;
- optional data not required for list validity;
- selected asset identity output;
- no write behavior;
- synthetic data labeled as synthetic.

### Deferred by explicit contract

- physical source;
- project/user security enforcement in adapter;
- paging/delegation;
- productive Asset Detail navigation;
- Create/Edit Asset.

No deferred item is silently represented as complete.

## 12. Architecture Guardian review

PASS for repository candidate with the following boundary:

```text
UI
→ CMMS_ASSETS_LIST_READ_CONTRACT_V1
→ synthetic read model now
→ physical adapter later
```

No ALEP/SQL table name is embedded in the screen.

No second engineering master is introduced.

## 13. UI Guardian review

### Positive

- uses common shell;
- uses semantic theme globals;
- uses governed spacing/radius globals where available;
- one dominant data surface;
- no KPI decoration;
- synthetic-source label is visible;
- selection state is visible;
- no 3D thumbnail load per row.

### Runtime items to inspect

- custom properties `Title/Subtitle` of PageHeader;
- `State/Title/Message/ShowAction` contract of StatePanel;
- dropdown fit at compact widths;
- row/header clipping;
- gallery vertical sizing;
- selected row visual contrast;
- keyboard/focus behavior;
- App Checker delta.

## 14. Async Action Guardian

`NOT_APPLICABLE` in current scope.

All implemented actions are local/read-only/repeatable. There is no asynchronous or non-repeatable write operation.

## 15. Red Team summary

Main credible failures remaining are runtime compatibility rather than data loss:

1. a custom property name of an existing component differs from the reference contract;
2. a control property accepted in reference PaYaml is rejected by the current CMMS Studio version;
3. compact-width layout clips filters or columns;
4. future real data volume makes client-side filtering invalid;
5. selected asset handoff exists but target navigation is not installed.

Mitigation:

- one Studio parser/render gate;
- consolidate any parser/render defects into one FIX batch;
- do not connect physical data until source + authorization model is confirmed.

## 16. Construction state

```text
IN_CONSTRUCTION       = complete in repository
FUNCTIONAL            = candidate source only
FUNCTIONAL_FROZEN     = no, pending Studio
VISUAL_APPROVED       = no
FINAL_FROZEN          = no
```

Formal state:

```text
CANDIDATE
+ REPOSITORY_STATIC_VERIFIED
+ STUDIO_VALIDATION_PENDING
```

## 17. Real gate

The next real gate is a single Studio validation of the cumulative file.

Required evidence:

```text
1. PaYaml paste/import accepted or parser errors captured
2. scr_Assets renders
3. PageHeader/ProjectContext/Sidebar render
4. search works
5. all four filters work
6. reset works
7. sort direction works
8. selection sets visible selected state
9. resize desktop -> compact does not destructively clip
10. App Checker delta captured
11. save -> close -> reopen
```

If multiple related defects appear, treat them as one `FIX batch` before a second runtime validation.
