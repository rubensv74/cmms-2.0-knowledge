# CMMS 2.0 — ASSETS Capability Studio Gate

**Fecha:** 2026-08-24  
**Capability:** `ASSETS-CAP-01 — Assets Data Explorer`  
**Candidate:** `08-resources/power-apps/screens/assets/scr_Assets.pa.yaml`  
**Estado:** `MANUAL_RUNTIME_EVIDENCE_PENDING`

## 1. Purpose

Validate the cumulative repository candidate in the real CMMS Canvas app with one runtime interaction, avoiding control-by-control construction.

## 2. Preconditions

Runtime evidence already confirmed:

```text
Canvas app = CMMS
layout = Responsive
core CMMS components installed
App.OnStart globals confirmed
App Checker baseline captured
```

Do not modify shared component definitions before testing the screen candidate.

## 3. Runtime action

Use the cumulative PaYaml candidate as the unit of integration:

```text
08-resources/power-apps/screens/assets/scr_Assets.pa.yaml
```

Expected product screen identity:

```text
scr_Assets
```

Do not rename to `scr_Assets_I01`, `scr_Assets_Final` or another construction identifier.

## 4. First parser check

Capture the complete parser result.

Classify:

```text
DEFINITION_ACCEPTED
or
PARSER_ERROR
```

If parser errors exist, do not manually redesign the screen in Studio. Capture the errors and return them for one consolidated FIX batch.

## 5. Functional smoke

When parser accepts:

```text
[ ] scr_Assets renders
[ ] sidebar renders
[ ] project context renders
[ ] page title = Assets
[ ] six synthetic asset rows are available initially
[ ] search P-101 returns the expected asset
[ ] search compressor returns C-201
[ ] Type filter works
[ ] Location filter works
[ ] Lifecycle filter works
[ ] Criticality filter works
[ ] Reset restores the baseline
[ ] Asset code sort direction toggles
[ ] Select sets a visible selected state
```

## 6. Truthfulness check

The screen must visibly remain a non-productive candidate:

```text
Synthetic read model • physical source pending
```

Do not remove that indicator until the real read adapter is validated.

## 7. Responsive check

Test at least:

```text
normal desktop width
reduced/compact desktop width
```

Capture:

- filter clipping;
- row/header alignment;
- unexpected horizontal scroll;
- sidebar/content collision;
- gallery height behavior.

## 8. Component contract check

The two first-touch unknowns are existing component custom properties.

Confirm whether Studio accepts:

```text
cmp_CMMS_PageHeaderPro_RC0.Title
cmp_CMMS_PageHeaderPro_RC0.Subtitle

cmp_CMMS_StatePanelPro_RC0.State
cmp_CMMS_StatePanelPro_RC0.Title
cmp_CMMS_StatePanelPro_RC0.Message
cmp_CMMS_StatePanelPro_RC0.ShowAction
```

If any property is rejected, capture its exact error. Do not edit the component definition as an immediate workaround.

## 9. App Checker delta

Baseline before Assets:

```text
Accessibility = 208
Performance = 3
```

After candidate integration record:

```text
Accessibility = ?
Performance = ?
Formula/parser findings = ?
```

The capability owns only new findings attributable to `scr_Assets`.

## 10. Reopen smoke

After successful functional smoke:

```text
save
→ close Studio
→ reopen app
→ open scr_Assets
→ repeat search/filter/select smoke
```

## 11. Gate outcomes

### PASS

```text
STUDIO_VALIDATED
```

requires parser acceptance + render + interaction + responsive smoke + App Checker delta + reopen smoke.

### FIX BATCH

Use when multiple related parser/render defects exist.

```text
runtime check
→ diagnose all related defects
→ one FIX batch
→ second runtime validation
```

### BLOCKED

Only when a real external dependency prevents validation, for example a required installed component is missing from the actual app.

## 12. What this gate does not validate

Even after PASS:

```text
physical Asset source
project authorization model
server-side filtering/delegation
productive Asset Detail navigation
Create/Edit Asset
```

remain separate downstream contracts/gates.
