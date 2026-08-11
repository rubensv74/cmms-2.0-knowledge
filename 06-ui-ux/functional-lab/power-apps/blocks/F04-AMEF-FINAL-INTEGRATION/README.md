# F04 — AMEF Final Integration Gate

**Fecha:** 2026-08-11  
**Objetivo:** cerrar `cmp_FL_RiskMatrixPro` + `scr_FL_AMEF` y congelar el patrón visual/funcional antes de propagarlo al resto de pantallas.

## Archivos canónicos

- `../../components/cmp_FL_RiskMatrixPro.pa.yaml`
- `../../screens/scr_FL_AMEF.pa.yaml`

## Estado que se valida

### RiskMatrixPro FINAL RC4

- 900×650;
- AMEF 5×5;
- S=4 / O=3 como fixture inicial;
- Gallery `Default` sincronizado con `SeverityValue` + `OccurrenceValue`;
- celda seleccionada mediante `ThisItem.IsSelected`;
- `SelectedSeverityOut=4`;
- `SelectedOccurrenceOut=3`;
- `MatrixScoreOut=12`;
- D=3;
- NPR=36;
- sin texto visible menor de 11;
- sin rediseño adicional previsto si supera el smoke final.

### scr_FL_AMEF Stage-Focused

La pantalla no muestra Efectos + Matriz + Decisión simultáneamente.

```text
FL-07                  → workspace Efectos
FL-09                  → RiskMatrixPro premium 900×650
FL-08 / FL-10 / FL-11  → decisión humana + control de avance
```

El Process Rail permanece visible y el sidebar queda colapsado en este workspace de alta densidad.

## Actualización en Studio

Actualizar **in situ**, preservando identidad:

```text
1. cmp_FL_RiskMatrixPro
2. scr_FL_AMEF
```

No crear copias `_1` / `1`.

## Smoke final único

Ejecutar desde runtime:

```text
Home
→ Registro de análisis
→ P101-AMEF-RCM-001
→ AMEF
```

Validar:

```text
FL-07
[ ] solo se ve Efectos/contexto
[ ] D editable 1–5
[ ] no aparece la matriz superpuesta

FL-09
[ ] solo se ve la matriz premium
[ ] S=4 / O=3 seleccionados inicialmente
[ ] S×O=12
[ ] D=3
[ ] NPR=36
[ ] seleccionar otra celda cambia S/O/S×O y el host recalcula NPR
[ ] ninguna fila/celda se corta

FL-10
[ ] aparece decisión humana + gate
[ ] no aparece matriz ni panel Efectos
[ ] sistema y autoridad humana se distinguen visualmente
```

## Criterio de cierre

Si pasa este smoke:

```text
cmp_FL_RiskMatrixPro     VISUAL_QA_VALIDATED
scr_FL_AMEF              VISUAL_QA_VALIDATED
F03/F04 visual pattern   FROZEN
```

Después de este punto no se realizarán más iteraciones cosméticas sobre AMEF salvo defecto bloqueante. El siguiente trabajo será propagar el patrón Comfortable + stage-focused al resto de Functional Lab.
