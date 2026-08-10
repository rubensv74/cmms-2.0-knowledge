# V2 RiskMatrix — validación estática

**Fecha:** 2026-08-10  
**Estado:** PASS_STATIC / Studio pending

## Alcance

- `power-apps/components/cmp_FL_RiskMatrixPro.pa.yaml`
- `power-apps/screens/scr_FL_AMEF.pa.yaml`

## Comprobaciones realizadas

```text
YAML parse                                 PASS
Source Code root shape                     PASS_STATIC
ComponentDefinitions / Screens             PASS_STATIC
CustomProperties metadata                  PASS_STATIC
Known Label + Radius pattern               NOT PRESENT
Classic Button AccessibleLabel             NOT PRESENT
Known inline ': ' scalar class             NOT PRESENT
Nested GroupContainer Children in Gallery  NOT PRESENT
Gallery template contains flat Button      YES
Host-driven state                          YES
S/O selection separated from D             YES
Matrix S×O separated from NPR              YES
Thresholds external to component logic     YES
```

## Diseño funcional comprobado

`cmp_FL_RiskMatrixPro`:

- representa 100 combinaciones S×O mediante una Gallery 10×10;
- emite Severidad y Ocurrencia seleccionadas;
- recibe Detección y NPR como inputs informativos;
- calcula solo la posición/banda S×O según umbrales de entrada;
- no conserva estado global oculto;
- delega en el host el cambio de estado y el cálculo NPR.

`scr_FL_AMEF`:

- actualiza S/O desde `OnSelectCell`;
- recalcula `varFLRiskScore = S × O × D`;
- mantiene Detección como campo separado;
- conserva DecisionPanel para recomendación/decisión;
- mantiene un gate explicable antes de RCM.

## Riesgo pendiente de herramienta

El uso de `Gallery@2.15.0` con `WrapCount=10` debe confirmarse en la app real. La sintaxis estática es válida, pero Power Apps Studio sigue siendo la autoridad para `DEFINITION_ACCEPTED`, `INSTANCE_SAFE` y Visual QA.

## Próximo gate

Ejecutar el recorrido único documentado en:

`power-apps/blocks/F02-RISK-MATRIX/README.md`
