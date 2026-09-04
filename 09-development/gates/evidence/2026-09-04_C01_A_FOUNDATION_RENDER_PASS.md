# CMMS 2.0 — C01-A Foundation Render Evidence

**Date:** 2026-09-04  
**Gate:** C01-A Theme / Layout Foundation  
**Status:** `RENDER_PASS / MOVE_TO_COMPONENT_EXTRACTION`

## Evidence received

Real Power Apps Studio screenshot of `scr_CMMS_Foundation_C01` after installing:

- `C01_A_APP_FORMULAS.powerfx.txt`;
- `C01_A_APP_ONSTART.powerfx.txt`;
- `scr_CMMS_Foundation_C01.pa.yaml`.

## Observed result

The screen renders successfully in the real `CMMS` Canvas app and shows the expected structure:

```text
CMMS sidebar
→ Project Context
→ Reliability Engineering page identity
→ Reliability Studies / Reliability Library / Reviews cards
→ P-101 Reliability Study Backbone
→ Scope / Functions & Failures / FMEA / RCM / Strategy / Review
```

Observed visual characteristics:

- CMMS dark navigation shell renders correctly;
- active navigation state renders on `Reliability Engineering`;
- content canvas remains clean and aligned;
- Project Context surface renders without backend dependency;
- page header hierarchy is clear;
- native cards and Reliability backbone render without clipping at the captured desktop width;
- Source Code schema/control versions used by C01-A are accepted by the current Studio;
- no foreign AssetPlan/TMS branding appears in the CMMS shell.

## Decision

The uncertainty that blocked component extraction is resolved:

```text
Source Code compatibility = PASS
Native foundation render = PASS
CMMS theme/layout grammar = PASS for extraction
```

C01-B may now extract/adapt the repeated shell blocks into canonical CMMS components.

## Remaining validation folded into C01-B integrated gate

The following checks remain required before the shared foundation is marked `VALIDATED_CMMS`:

```text
reduced-width render
sidebar collapse/expand
host navigation event
App Checker delta
save / close / reopen persistence
```

These checks are intentionally performed on the component-based shell rather than forcing an additional manual gate on the disposable native probe screen.

## Marker

```text
C01_A_FOUNDATION_RENDER_PASS
```
