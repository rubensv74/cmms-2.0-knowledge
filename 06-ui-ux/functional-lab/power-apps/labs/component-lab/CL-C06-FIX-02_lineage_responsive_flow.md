# CL-C06-FIX-02 — LineagePanelPro responsive flow

**Target:** existing `cmp_FL_LineagePanelPro` identity  
**Base:** RC4 visual evidence 2026-08-14  
**Candidate:** RC5  
**Goal:** `CL-C06 LINEAGEPANEL PASS`

## Root cause

The RC4 2×2 compact layout removes ellipsis but remains structurally fragile at 700 px because two engineering stages must share one row while values can grow vertically through wrapping. The lower traceability hint then competes for the same vertical band.

This is a layout problem, not a typography problem.

## RC5 strategy

### Width >= 780 px

Preserve the proven desktop composition:

```text
Biblioteca / revisión → Aplicación → Activo / contexto → Handoff
```

Recommended host height: `160`.

### Width < 780 px

Use a full-width vertical lineage:

```text
Biblioteca / revisión
        ↓
Aplicación
        ↓
Activo / contexto
        ↓
Handoff
        ↓
hint de trazabilidad
```

Recommended host height: `400`.

Every value uses the full content width and `Wrap=true`. Vertical positions are derived from the real `AutoHeight` of the preceding value, so longer engineering codes increase spacing instead of colliding with the next stage.

## Implementation rule

RC5 uses one set of semantic controls with conditional geometry instead of separate Wide/Compact duplicate control sets. This reduces mode-specific drift and removes the possibility of two responsive representations competing inside the same component.

## Do not modify

- component identity;
- public custom-property contract;
- semantic ordering;
- visible typography;
- approved safe palette;
- Functional Lab product screens;
- unrelated component-lab cases.

## Validation

### Normal 900

Must preserve:

- four-stage horizontal layout;
- complete values;
- complete hint;
- arrows in sequence;
- no black surfaces.

### Stress 700

Must prove:

- vertical four-stage flow;
- full long stress values;
- no ellipsis;
- no overlap;
- no clipped hint;
- typography unchanged;
- 400 px host height.

### Save / reopen

After both modes pass, save and reopen Studio and repeat both modes.

PASS declaration:

```text
CL-C06-FIX-02 PASS
CL-C06 LINEAGEPANEL PASS
cmp_FL_LineagePanelPro RC5 READY_FOR_INTEGRATION
```
