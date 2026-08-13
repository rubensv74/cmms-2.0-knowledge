# CL-C05-FIX-03 — Source precheck

**Fecha:** 2026-08-12  
**Estado:** `SOURCE PRECHECK PASS / STUDIO PENDING`

## Autoridades revisadas

- `functional-engineering-knowledge-base/30-playbooks/power-platform/modular-power-apps-screen-construction.md`
- `06-ui-ux/functional-lab/development/compatibility.md`

## Alcance

Pre-flight estático de:

- `CL-C05-FIX-03_component_properties.pa.yaml`
- `CL-C05-FIX-03_matrix_controls.pa.yaml`
- `CL-C05-FIX-03_dynamic_dimensions_harness.pa.yaml`

## Comprobaciones

```text
[PASS] identidad cmp_FL_RiskMatrixPro preservada
[PASS] geometría externa 900×650 preservada
[PASS] RC5 visual composition no se reestructura
[PASS] número de celdas deriva de RowScale × ColumnScale
[PASS] WrapCount deriva de ColumnScale
[PASS] altura/template de filas deriva de RowScale
[PASS] score de celda deriva de ScaleScore, no de un 5 hardcoded
[PASS] default selection deriva del ranking ScaleIndex
[PASS] MatrixBandOut calcula el score directamente
[PASS] umbrales usan fallback 5/10/20 y el harness los enlaza explícitamente
[PASS] Gallery template mantiene un control plano; no GroupContainer anidado
[PASS] Classic/Button@2.2.0 y ModernText@1.0.0 son versiones ya utilizadas
[PASS] ModernText nuevo/modificado usa AutoHeight=true
[PASS] no SVG
[PASS] fórmulas complejas usan bloque `|-`
[PASS] no se detecta un nuevo scalar Power Fx inline con literal sensible `: ` o ` #`
```

## Alcance visual validable

El código deja la matriz estructuralmente dimensionable por `RowScale`/`ColumnScale`.

Este gate de Studio valida específicamente:

```text
5×5
4×6
6×4
```

No se declara todavía soporte visual universal para dimensiones arbitrariamente grandes. Con el host actual 900×650 y densidad Comfortable, cualquier dimensión por encima de las probadas requiere QA específico antes de considerarse soportada.

## Estado

La revisión estática no equivale a `INSTANCE_SAFE` ni `VISUAL_QA_VALIDATED`.
