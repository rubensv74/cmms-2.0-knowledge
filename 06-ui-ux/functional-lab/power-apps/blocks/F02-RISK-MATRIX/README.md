# F02 — Risk Matrix Premium

**Objetivo:** incorporar una matriz visual de riesgo configurable a FL-09 antes de iniciar los smoke tests integrados de arquitectura v2.

## Archivos canónicos

1. `../../components/cmp_FL_RiskMatrixPro.pa.yaml`
2. `../../screens/scr_FL_AMEF.pa.yaml`

## Decisión de diseño

`cmp_FL_RiskMatrixPro` no queda limitado estructuralmente a 10×10.

El caso P-101 utiliza:

```text
RowScale    Severidad 1..10
ColumnScale Ocurrencia 1..10
MatrixMode  PRODUCT
Resultado   S×O
Detección   separada
NPR         S×O×D calculado por el host
```

El mismo componente puede recibir escalas distintas, por ejemplo 5×5 o categorías con rating numérico subyacente.

## Contrato configurable

### RowScale / ColumnScale

Cada escala es una tabla con:

```text
ScaleIndex
ScaleLabel
ScaleScore
```

La cantidad de filas y columnas se deriva de `CountRows(...)`; no existe un `10` estructural fijo en el layout.

### MatrixMode = PRODUCT

Cada celda deriva su score mediante:

```text
RowScale.ScaleScore × ColumnScale.ScaleScore
```

Las bandas se obtienen con `LowMax`, `ModerateMax` y `HighMax`.

### MatrixMode = CONFIGURED

El host puede suministrar `MatrixCells`:

```text
RowIndex
ColumnIndex
CellScore
BandKey     LOW | MODERATE | HIGH | CRITICAL
```

Esto permite representar matrices cuya criticidad no sea simplemente el producto de los dos ejes.

## Compatibilidad AMEF

Se conservan los outputs existentes:

```text
SelectedSeverityOut
SelectedOccurrenceOut
```

Por tanto, `scr_FL_AMEF` no necesita modificarse para seguir usando la matriz 10×10 de P-101.

Se añaden además:

```text
SelectedRowLabelOut
SelectedColumnLabelOut
MatrixScoreOut
MatrixBandOut
```

## Orden

1. Crear o sustituir `cmp_FL_RiskMatrixPro` con el Source Code completo.
2. Guardar la definición del componente.
3. Sustituir el Source Code completo de `scr_FL_AMEF` por la versión canónica actual si todavía no está instalada.
4. Abrir Home una vez si el runtime v2 todavía no está inicializado.
5. Abrir AMEF y realizar una sola validación integrada.

## Validación única P-101

- la configuración por defecto debe producir 10×10 = 100 celdas;
- S=8 y O=4 deben identificar la celda actual;
- la celda actual debe mostrar score S×O = 32;
- D=3 debe mostrarse aparte;
- NPR inicial esperado: 96;
- seleccionar otra celda debe actualizar S y O y recalcular NPR;
- editar D debe recalcular NPR sin mover la posición S×O;
- la banda visual de matriz debe mantenerse separada del NPR;
- consecuencia recomendada y decisión humana deben seguir diferenciadas;
- el control de avance debe seguir explicando el estado.

## Configuraciones futuras soportadas

```text
AMEF / FMEA          10×10 S × O + D separada
Risk matrix          5×5 Severity × Likelihood
RCM                  Probability × Consequence
Matriz corporativa   celdas y bandas definidas por configuración
```

No se crean componentes diferentes para cada metodología.

## Criterio de aceptación

Responder:

```text
RISK MATRIX OK
```

si la carga, interacción, cálculo y composición visual son correctos.

Si aparece un error de Studio, enviar el mensaje completo y/o captura. Se corregirá la clase completa del error antes de continuar.

## Nota metodológica

Los umbrales 20 / 40 / 70 y la escala 10×10 son configuración demostrativa del caso P-101. No constituyen una regla universal ni una configuración corporativa aprobada.
