# CL-C01 — TreePro RC3 isolated validation

**Target component:** `cmp_FL_TreePro`  
**Harness:** `scr_ComponentLab`  
**Dependency:** `CL-S01 STRUCTURE FROZEN`

## 1. Update component definition in situ

Open the existing component `cmp_FL_TreePro` in Power Apps Studio and replace its Source Code with the canonical RC3 source:

`../../components/cmp_FL_TreePro.pa.yaml`

Do not add a second copy and do not create `_1`.

Save.

### Gate A

```text
[ ] Studio accepts the definition
[ ] app saves
[ ] no new component-definition blocking error
```

If Gate A fails, stop and report the exact Studio error. Do not paste CL-C01 yet.

## 2. Install the isolated harness

In `scr_ComponentLab`, keep the CL-S01 geometry.

From `CL-C01_TreePro_isolated_validation.pa.yaml` replace only:

```text
ph_ComponentUnderTest
ph_TestControls
```

Do not modify slot X/Y/Width/Height outside those replacement blocks.

## 3. Load fixture

Run the screen and press:

```text
Cargar fixture
```

Expected initial state:

```text
P-101 highlighted
P-101 selected
breadcrumb visible
all fixture branches visible
white/light surfaces; no accidental black rendering
```

## 4. Search smoke

Use the internal TreePro search input.

Test:

```text
P-102
```

Expected:

```text
P-102 remains visible as matching node
search field accepts/clears text normally
no black surface
no clipping
```

Clear the search.

## 5. Selection smoke

Select:

```text
P-102
```

Expected right-panel outputs:

```text
SelectedNodeIdOut     CL-P102
SelectedLabelOut      P-102 · Bomba de reserva
SelectedLevelOut      6
SelectedParentIdOut   CL-SET
SelectedPathOut       ... > Conjunto bomba-motor > P-102
```

Then select `P-101` and verify outputs change accordingly.

## 6. Toggle smoke

Click the expand/collapse control of:

```text
Conjunto bomba-motor
```

Expected:

```text
P-101 / P-102 hide on collapse
P-101 / P-102 return on expand
ToggleNodeIdOut = CL-SET when that node is toggled
ToggleTargetExpandedOut changes true/false coherently
```

Repeat once on an upper branch if desired; one successful parent-child toggle is sufficient for the gate.

## 7. Visual QA

Validate at 100% zoom:

```text
[ ] no black accidental surfaces
[ ] body text >=11 and readable
[ ] indentation remains understandable at level 6
[ ] breadcrumb readable
[ ] selected state distinct from highlighted P-101 state
[ ] ACTIVO badge readable
[ ] scrollbar/search do not overlap content
[ ] no unexpected mini-scrollbars inside text controls
```

## 8. Save/reopen

Save the app, reopen/reload Studio, return to `scr_ComponentLab`, press `Cargar fixture` again and repeat one selection.

This closes the `INSTANCE_SAFE` portion of the gate against a real reopened app state.

## PASS declaration

If all tests pass:

```text
CL-C01 TREEPRO PASS
```

This promotes the current TreePro revision to candidate:

```text
COMPONENT_DEFINITION_ACCEPTED
INSTANCE_SAFE
PUBLIC_CONTRACT_VALIDATED
VISUAL_QA_VALIDATED
READY_FOR_INTEGRATION
```

The next work is then a targeted revalidation of the frozen Asset screens; their geometry is not rebuilt.

## Failure rule

If any test fails, report the failing gate and screenshot/error.

The next block will be:

```text
CL-C01-FIX-xx
```

limited to the demonstrated delta. Do not modify FLH, Taxonomy or ADR to compensate for a TreePro failure.
