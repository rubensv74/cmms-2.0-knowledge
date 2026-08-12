# CL-C05-FIX-03 — Dynamic Matrix Dimensions

## Estado

`IN_CONSTRUCTION / STUDIO PENDING`

## Decisión

`cmp_FL_RiskMatrixPro` no tendrá propiedades redundantes `RowCount` ni `ColumnCount`.

La dimensión de la matriz se deriva del contrato ya existente:

```text
Rows    = CountRows(RowScale)
Columns = CountRows(ColumnScale)
Cells   = Rows × Columns
```

`RowScale` y `ColumnScale` continúan siendo tablas con:

```text
ScaleIndex
ScaleLabel
ScaleScore
```

`ScaleIndex` define el orden visual. `ScaleScore` define el valor usado en S×O.

## Default

La configuración por defecto continúa siendo 5×5 para preservar el caso AMEF P-101 actual.

## Alcance del FIX

Se modifica únicamente la lógica interna que todavía estaba codificada para 5×5:

- número de celdas;
- `WrapCount`;
- altura de filas;
- tamaño de celda;
- posición/ranking de la selección por defecto;
- conversión `Gallery.Selected` → score de fila/columna;
- cálculo del score de cada celda;
- cálculo directo de `MatrixBandOut`.

No se modifica:

- identidad `cmp_FL_RiskMatrixPro`;
- geometría externa 900×650;
- composición visual RC5 aprobada;
- semántica S/O/D;
- NPR = S×O×D;
- umbrales/bandas corporativas;
- `scr_ComponentLab` geometry.

## Regla de escala

El componente no presupone que `ScaleScore = ScaleIndex`. El score se obtiene de la fila/columna correspondiente según el orden de `ScaleIndex`.

Esto permite que en el futuro una organización utilice etiquetas o scores configurados sin reescribir la matriz.

## Gate Studio

Se validarán tres configuraciones en una sola sesión:

```text
5×5 → S4/O3/D3 → S×O 12 → NPR 36
4×6 → S4/O6/D2 → S×O 24 → NPR 48
6×4 → S6/O4/D2 → S×O 24 → NPR 48
```

Después se volverá a 5×5 para comprobar que no queda estado residual.

El PASS requiere además:

- headers y filas correctos;
- ninguna celda solapada;
- selección visual coherente;
- `MatrixBandOut` no vacío;
- cuatro bandas cromáticas disponibles;
- D no modifica la posición S×O;
- ausencia de superficies negras y clipping.

## Estado esperado tras PASS

`CL-C05 RISKMATRIX PASS / RC6 READY_FOR_INTEGRATION`
