# CL-C05-FIX-03 — Validación Studio

## Objetivo

Demostrar que `cmp_FL_RiskMatrixPro` deja de depender de una geometría lógica 5×5 y obtiene sus dimensiones de `RowScale` y `ColumnScale`, preservando RC5, S/O/D y NPR.

## Preparación

Aplicar sobre la identidad existente `cmp_FL_RiskMatrixPro`:

1. `CL-C05-FIX-03_component_properties.pa.yaml` → reemplazar el bloque `Properties` del componente.
2. `CL-C05-FIX-03_matrix_controls.pa.yaml` → reemplazar únicamente `galFLRiskRows` y `galFLRiskMatrix` dentro de `conFLRiskMatrixPanel.Children`.
3. En `scr_ComponentLab`, sustituir `ph_ComponentUnderTest` y `ph_TestControls` con `CL-C05-FIX-03_dynamic_dimensions_harness.pa.yaml`.

No crear una nueva identidad del componente.

## Gate único

### A — 5×5

Pulsar `5 × 5 · S4 / O3 / D3`.

Esperado:

```text
5 filas
5 columnas
selección S4/O3
S×O = 12
Banda = Alto
D = 3
NPR = 36
```

### B — 4×6

Pulsar `4 × 6 · S4 / O6 / D2`.

Esperado:

```text
4 filas
6 columnas
selección S4/O6
S×O = 24
Banda = Crítico
D = 2
NPR = 48
```

Después seleccionar manualmente la celda `S2/O5`.

Esperado:

```text
S×O = 10
Banda = Moderado
NPR = 20
Evento = CELL
```

### C — 6×4

Pulsar `6 × 4 · S6 / O4 / D2`.

Esperado:

```text
6 filas
4 columnas
selección S6/O4
S×O = 24
Banda = Crítico
D = 2
NPR = 48
```

### D — reset dimensional

Volver a pulsar `5 × 5 · S4 / O3 / D3`.

Esperado:

```text
5×5 restaurado
S4/O3 restaurado
12 / Alto / NPR 36
sin selección residual de 4×6 o 6×4
```

## QA visual

```text
[ ] headers alineados con las columnas
[ ] labels de severidad alineados con las filas
[ ] ninguna celda se solapa
[ ] selección azul inequívoca
[ ] bandas Bajo/Moderado/Alto/Crítico conservadas
[ ] texto >=11
[ ] sin clipping
[ ] sin superficies negras
[ ] panel lateral RC5 no cambia de geometría
[ ] footer RC5 sigue legible
```

## Criterio de cierre

Si A+B+C+D pasan:

`CL-C05 RISKMATRIX PASS`

Promoción esperada:

`cmp_FL_RiskMatrixPro RC6 → READY_FOR_INTEGRATION`
