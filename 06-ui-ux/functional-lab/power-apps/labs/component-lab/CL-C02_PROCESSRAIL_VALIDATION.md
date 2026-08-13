# CL-C02 — ProcessRailPro isolated validation

**Target component:** `cmp_FL_ProcessRailPro`  
**Harness:** `scr_ComponentLab`  
**Dependency:** `CL-S01 STRUCTURE FROZEN` + `COLOR FOUNDATION APPROVED`

## 1. Update the existing component in situ

Open the existing `cmp_FL_ProcessRailPro` component in Power Apps Studio and replace its Source Code with the canonical source:

`../../components/cmp_FL_ProcessRailPro.pa.yaml`

Do not add a second copy and do not create a suffixed identity.

Save and confirm that Studio accepts the definition.

If the definition fails, stop and report the exact Studio error. Do not install the harness yet.

## 2. Install CL-C02 in Component Lab

In `scr_ComponentLab`, preserve the frozen CL-S01 geometry.

From `CL-C02_ProcessRailPro_isolated_validation.pa.yaml`, replace only:

```text
ph_ComponentUnderTest
ph_TestControls
```

No other control or screen is part of this gate.

## 3. Load the controlled fixture

Run the screen and press:

```text
Cargar fixture
```

Expected initial semantics:

```text
formal active stage = FL-09
AMEF and RCM phases visible
FL-12 blocked
status dots visible
responsibility markers H / R / C / G visible
rail remains 300 px wide
scroll is used before typography is reduced
```

## 4. Accessible-stage selection

Select `FL-13 · Aplicar lógica RCM`.

Expected:

```text
SelectedStageIdOut = FL-13
SelectedScreenKeyOut = RCM
ActiveStageId remains FL-09
```

This distinction is mandatory:

```text
selection / consultation ≠ formal process progression
```

The selected row may be visually selected, but the formal current stage remains FL-09.

## 5. Blocked-stage smoke

Try to select:

```text
FL-12 · Validar prerrequisitos RCM
```

Expected:

```text
row is disabled / inaccessible
OnSelectStage does not advance the selected-event state
formal active stage remains FL-09
```

Do not reinterpret a blocked stage as merely a warning.

## 6. Density smoke

Press the density button once.

Expected:

```text
Comfortable ↔ Compact changes row height/padding
visible text remains >=11
labels remain readable
no overlap
scroll remains usable
```

Compact mode must not solve space by shrinking text below the agreed baseline.

## 7. Phase-header smoke

Press the phase-header button.

Expected:

```text
AMEF / RCM phase headers hide and show coherently
stage rows remain aligned
selection and active-stage semantics do not change
```

## 8. Visual QA

At normal desktop zoom validate:

```text
[ ] no accidental black surfaces
[ ] stage labels readable at 300 px rail width
[ ] no status-dot overlap
[ ] H / R / C / G markers readable
[ ] active stage visually clear
[ ] blocked stage visually distinguishable
[ ] phase transition AMEF → RCM understandable
[ ] scrollbar does not cover meaningful content
[ ] Comfortable and Compact both remain usable
```

If a realistic label clips at the canonical 300 px width, report it. Do not reduce typography as the first correction.

## 9. Save / reopen

Save the app, reopen or reload Studio, return to `scr_ComponentLab`, press `Cargar fixture`, and repeat one accessible selection.

This closes the instance-safety gate against a reopened app state.

## PASS declaration

If all checks pass:

```text
CL-C02 PROCESSRAIL PASS
```

The current revision can then be promoted through:

```text
COMPONENT_DEFINITION_ACCEPTED
INSTANCE_SAFE
PUBLIC_CONTRACT_VALIDATED
VISUAL_QA_VALIDATED
READY_FOR_INTEGRATION
```

## Failure rule

Any demonstrated failure is repaired with:

```text
CL-C02-FIX-xx
```

The FIX touches only the failing ProcessRail/harness delta. Do not modify AMEF, RCM, or other product screens to compensate for a component failure.
