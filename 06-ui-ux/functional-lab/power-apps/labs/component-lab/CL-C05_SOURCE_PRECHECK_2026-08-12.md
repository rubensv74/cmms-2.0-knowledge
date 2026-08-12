# CL-C05 — RiskMatrixPro — Source precheck

**Fecha:** 2026-08-12  
**Estado:** `SOURCE PRECHECK PASS / STUDIO PENDING`

## Autoridades consultadas

Antes de publicar el harness se releyeron:

- `functional-engineering-knowledge-base/30-playbooks/power-platform/modular-power-apps-screen-construction.md`
- `06-ui-ux/functional-lab/development/compatibility.md`
- fuente canónica `cmp_FL_RiskMatrixPro.pa.yaml` RC4.

## Contrato del bloque

```text
BLOCK       CL-C05
TYPE        C — Component validation harness
TARGET      scr_ComponentLab / ph_ComponentUnderTest + ph_TestControls
ACTION      reemplazar contenido de los dos slots
DEPENDS ON  CL-S01 STRUCTURE FROZEN + COLOR FOUNDATION APPROVED
TOUCHES     solo contenido del harness CL-C05
DO NOT MODIFY
            geometría del Component Lab
            componentes ya validados
            pantallas funcionales
            contrato público de RiskMatrixPro
VALIDATION  S/O sync + selección + D separada + NPR + QA visual
EXPECTED    RiskMatrixPro RC4 READY_FOR_INTEGRATION tras PASS de Studio
```

## Pre-flight PaYaml

Comprobado:

- no hay `GroupContainer` anidado dentro de templates Gallery en el harness;
- no se introduce `AccessibleLabel` en `Classic/Button@2.2.0`;
- los textos visibles respetan el baseline Comfortable;
- no hay fórmulas inline con strings que contengan `: `;
- no hay fórmulas inline con strings que contengan ` #`;
- las fórmulas de eventos multilínea usan `|-`;
- no se crea una segunda identidad de componente;
- no se usa SVG inline;
- no se introducen escalas corporativas definitivas.

## Coherencia matemática comprobada

RC4 sincroniza el `Gallery.Default` con los inputs S/O.

Fixture principal:

```text
S = 4
O = 3
D = 3
S×O = 12
NPR = 36
```

Selección discriminante:

```text
S = 5
O = 5
D = 3
S×O = 25
NPR = 75
```

Cambio exclusivo de detección:

```text
S = 5
O = 5
D = 4
S×O = 25
NPR = 100
```

La modificación de D no debe mover la celda seleccionada porque la matriz representa exclusivamente `S×O`.

## Regla conceptual protegida

```text
RiskAssessment AMEF ≠ AssetCriticalityAssessment
```

Este harness valida riesgo AMEF del modo de fallo. No consume ni representa la criticidad de planta del activo.
