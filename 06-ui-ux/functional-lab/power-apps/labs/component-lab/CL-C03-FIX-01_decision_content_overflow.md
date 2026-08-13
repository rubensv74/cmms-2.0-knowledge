# CL-C03-FIX-01 — DecisionPanelPro content overflow repair

**Type:** `FIX`  
**Target:** existing `cmp_FL_DecisionPanelPro` identity + current CL-C03 harness  
**Dependency:** CL-C03 Studio visual evidence 2026-08-12  
**Expected result:** `CL-C03 DECISIONPANEL PASS`

## Defect

The P-101 recommendation plus explanation clips at the lower edge of the blue system card.

This is a geometry/overflow defect. Do not reduce typography and do not remove recommendation content.

## Scope

Touch only the six properties below.

### Existing component `cmp_FL_DecisionPanelPro`

| Control | Property | Current | New |
|---|---|---:|---:|
| component root | `Height` | `214` | `252` |
| `conFLDecisionSystem` | `Height` | `80` | `104` |
| `conFLDecisionHuman` | `Height` | `80` | `104` |

### Current `scr_ComponentLab` / CL-C03 harness

| Control | Property | Current | New |
|---|---|---:|---:|
| `cmpCLDecision` | `Height` | `214` | `252` |
| `lblCLDecisionExpectedTitle` | `Y` | `330` | `370` |
| `lblCLDecisionExpected` | `Y` | `360` | `400` |

## Do not modify

- DecisionPanel public contract;
- `OnConfirmDecision` / `OnOverrideDecision`;
- colors or semantic roles;
- typography;
- `scr_ComponentLab` slot geometry;
- TreePro or ProcessRail;
- any functional product screen.

## Why this layout works

The two cards end at `Y 76 + Height 104 = 180`. The action buttons remain bottom-anchored and, with component `Height=252`, begin at `Y=202`. This leaves a 22 px separation between content cards and actions while preserving the current 12/13 px typography.

## Validation

After applying the six property changes:

1. load the P-101 fixture;
2. confirm the complete recommendation and explanation are visible;
3. confirm the human authority/reason area is fully visible;
4. press `Confirmar recomendación` and verify the harness event/state updates;
5. reset and press `Modificar decisión`; verify override styling, decision and reason;
6. disable confirmation and verify the confirm action becomes disabled;
7. check no black surfaces, clipping or overlap.

If all pass, declare:

```text
CL-C03-FIX-01 PASS
CL-C03 DECISIONPANEL PASS
```
