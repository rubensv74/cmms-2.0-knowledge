# F02 — Risk Matrix Premium

**Objetivo:** incorporar una matriz visual de riesgo configurable a FL-09 antes de iniciar los smoke tests integrados de arquitectura v2.

## Archivos canónicos

1. `../../components/cmp_FL_RiskMatrixPro.pa.yaml`
2. `../../screens/scr_FL_AMEF.pa.yaml`

## Decisión de diseño

`cmp_FL_RiskMatrixPro` no queda limitado estructuralmente a una dimensión concreta.

El **caso P-101 del Functional Lab utiliza 5×5** porque esa es la escala ya utilizada en los prototipos AMEF revisados:

```text
RowScale    Severidad 1..5
ColumnScale Ocurrencia 1..5
MatrixMode  PRODUCT
Resultado   S×O
Detección   1..5 y separada de la matriz
NPR         S×O×D calculado por el host
```

Valores iniciales heredados del prototipo:

```text
S = 4
O = 3
D = 3
S×O = 12
NPR = 36
```

La elección 5×5 es una **configuración funcional vigente del laboratorio**, no una restricción técnica del componente ni una regla universal de CMMS 2.0.

## Contrato configurable

### RowScale / ColumnScale

Cada escala es una tabla con:

```text
ScaleIndex
ScaleLabel
ScaleScore
```

La cantidad de filas y columnas se deriva de `CountRows(...)`.

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

Esto permite representar una futura matriz corporativa cuya criticidad no dependa simplemente del producto de los ejes.

## Compatibilidad AMEF

Se conservan:

```text
SelectedSeverityOut
SelectedOccurrenceOut
```

Y se exponen además:

```text
SelectedRowLabelOut
SelectedColumnLabelOut
MatrixScoreOut
MatrixBandOut
```

## Configuración actual de P-101

`scr_FL_AMEF` suministra expresamente dos escalas de cinco niveles.

Las bandas visuales del laboratorio se configuran provisionalmente como:

```text
Bajo       S×O <= 5
Moderado   S×O <= 10
Alto       S×O <= 15
Crítico    S×O > 15
```

**Estas bandas son demostrativas y quedan pendientes de validación corporativa.** La decisión validada ahora es la escala 1–5 heredada del prototipo, no esos umbrales.

## Orden

1. Crear o sustituir `cmp_FL_RiskMatrixPro` con el Source Code completo.
2. Guardar la definición.
3. Sustituir `scr_FL_AMEF` por la versión canónica actual.
4. Abrir Home una vez si el runtime v2 todavía no está inicializado.
5. Abrir AMEF y realizar una única validación integrada.

## Validación única P-101

- deben verse **5×5 = 25 celdas**;
- S=4 y O=3 deben identificar la celda actual;
- el resultado S×O inicial debe ser 12;
- D=3 debe mostrarse aparte;
- NPR inicial esperado: 36;
- seleccionar otra celda debe actualizar S y O y recalcular NPR;
- Detección solo admite 1..5 y no mueve la posición S×O;
- la banda visual se mantiene separada del NPR;
- consecuencia recomendada y decisión humana permanecen diferenciadas;
- el control de avance explica el estado y solo permite continuar con el AMEF completo.

## Configuraciones futuras soportadas

```text
P-101 / AMEF actual  5×5 S × O + D separada
FMEA alternativo     10×10 si se valida expresamente
RCM / Risk           Probability × Consequence
Matriz corporativa   escalas, celdas y bandas configuradas
```

No se crean componentes diferentes para cada metodología.

## Criterio de aceptación

Responder:

```text
RISK MATRIX OK
```

si carga, interacción, cálculo y composición visual son correctos.

Si aparece un error de Studio, enviar el mensaje completo y/o captura.
