# CL-C03 — DecisionPanelPro visual finding

**Date:** 2026-08-12  
**Status:** `FIX REQUIRED`  
**Block:** `CL-C03`  
**Repair:** `CL-C03-FIX-01`

## Studio evidence

The isolated DecisionPanel rendered correctly in `scr_ComponentLab` with the P-101 RCM fixture. The screenshot confirmed:

- system and human decision areas render with the intended semantic separation;
- no accidental black surfaces;
- title, context, buttons and harness status are readable;
- the component identity is instance-safe in the isolated host.

A visual defect remains: the representative recommendation plus explanation in `conFLDecisionSystem` extends beyond the available 80 px card height and is clipped at the lower edge.

## Interpretation

This is a geometry/overflow defect, not a typography, data-contract, event or color defect.

Do not solve by reducing visible font size or removing the recommendation explanation.

## Repair scope

`CL-C03-FIX-01` changes only:

- component height `214 → 252`;
- system card height `80 → 104`;
- human card height `80 → 104`;
- isolated harness instance height to `252`;
- harness explanatory content Y positions to remain below the component.

Buttons remain bottom-anchored and therefore move automatically with the component height.

## Freeze rule

Until the repair passes Studio visual QA:

```text
cmp_FL_DecisionPanelPro
SOURCE_VALID                    PASS
COMPONENT_DEFINITION_ACCEPTED   PASS
INSTANCE_SAFE                   PASS
PUBLIC_CONTRACT_VALIDATED       PENDING FINAL EVENT SMOKE
VISUAL_QA_VALIDATED             FAIL — clipping
READY_FOR_INTEGRATION           NO
```

After `CL-C03-FIX-01 PASS`, the component may be promoted without reopening its public contract or palette.
