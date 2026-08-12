# CL-C05 — RiskMatrixPro RC4 — VISUAL QA FAILURE

**Fecha:** 2026-08-12  
**Resultado Studio:** `FAIL_VISUAL_QA`  
**Componente:** `cmp_FL_RiskMatrixPro` RC4

## Evidencia

La instancia es funcional y muestra correctamente el baseline P-101:

```text
S = 4
O = 3
D = 3
S×O = 12
NPR = 36
```

Sin embargo, la revisión visual en Studio no alcanza el nivel de producto requerido para CMMS 2.0 Functional Lab.

## Problemas observados

1. La composición se percibe como una demostración técnica de matriz y no como una unidad de decisión operativa.
2. La superficie 900×650 no se aprovecha con una jerarquía clara; matriz y métricas aparecen como piezas separadas.
3. D, S×O y NPR quedan desconectados visualmente del punto seleccionado en la matriz.
4. La banda de riesgo no tiene suficiente protagonismo como resultado de la valoración.
5. La selección funciona, pero el componente no explica con suficiente claridad que la celda depende de S×O mientras D solo modifica NPR.
6. La lectura requiere saltar entre matriz, franja inferior y harness lateral.
7. El acabado es correcto como prototipo funcional, pero insuficiente como componente premium reutilizable.

## Decisión

No congelar RC4.

Abrir:

```text
CL-C05-FIX-01 — RiskMatrixPro RC5 visual redesign
```

## Principios del RC5

```text
cabecera contextual
→ matriz S×O como workspace principal
→ panel lateral de valoración S / O / D
→ banda S×O explícita
→ NPR destacado
→ regla de lectura visible
→ leyenda integrada
→ footer de trazabilidad/escala
```

La selección usa el color de interacción aprobado y no el color de la banda de riesgo.

## Invariantes funcionales

El FIX no puede cambiar:

```text
Matriz = S×O
D separada de la posición de matriz
NPR = S×O×D salvo RiskScore explícito del host
SelectedSeverityOut
SelectedOccurrenceOut
MatrixScoreOut
MatrixBandOut
OnSelectCell
```

`RiskAssessment AMEF` continúa separado de `AssetCriticalityAssessment`.
