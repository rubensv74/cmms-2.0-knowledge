# CL-C07-FIX-01 — ApplicabilityMatrixPro RC3 responsive cards

**Type:** `FIX`  
**Target:** existing `cmp_FL_ApplicabilityMatrixPro` identity  
**Dependency:** CL-C07 RC2 Studio evidence 2026-08-14  
**Expected result:** `CL-C07 APPLICABILITYMATRIX PASS`

## Root cause

RC2 uses a five-column desktop table with fixed X/Width values. At 760 px, long profile and interval values are forced into narrow columns while the asset field remains `Wrap=false`. The resulting density is structurally incompatible with the Comfortable typography baseline.

## Strategy

Preserve the desktop table at wide widths and change representation below the responsive breakpoint.

```text
Width >= 840 px
ACTIVO | CRITICIDAD | APLICABILIDAD | PERFIL | INTERVALO

Width < 840 px
[AssetCode · AssetName]
Criticidad                 Aplicabilidad
Perfil                     Intervalo
```

Each compact row becomes a full-width selectable card. The same gallery, same record and same event/output contract are preserved.

## Responsive envelope

```text
Wide    >= 840 px   host Height 350   Gallery TemplateSize 60
Compact <  840 px   host Height 500   Gallery TemplateSize 128
```

## Public contract — unchanged

- `Items`
- `UseHostTheme`
- `Title`
- `OnSelectApplication`
- `SelectedAssetCodeOut`
- `SelectedApplicationCodeOut`
- `SelectedRecordOut`
- existing color inputs

## Compact layout rules

1. Desktop column headers are hidden below 840 px.
2. Asset consumes full card width and wraps.
3. Criticality / Applicability share row 2 with approximately half width each.
4. Profile / Interval share row 3 with approximately half width each.
5. Compact values include their field label so semantics do not depend on hidden headers.
6. The selectable background button remains behind all text and keeps `Select(Parent)`.
7. Gallery TemplateSize increases rather than reducing font size.

## Do not modify

- business semantics;
- event/output behavior;
- selection highlight semantics;
- Comfortable typography baseline;
- other components or Functional Lab screens.

## Validation

1. `Normal 920`: desktop table remains visually equivalent to RC2.
2. Select P-102: outputs must become P-102 / APP-P102-R01 / P-102 record and `OnSelect event = 1`.
3. `Stress 760`: three full-width compact cards; all long values readable; no overlap, elipsis or black surfaces.
4. Select P-103 in Stress: outputs and event remain coherent.
5. Save / reopen; repeat Normal and Stress plus one selection.

Only after all five pass may RC3 replace the canonical source.
