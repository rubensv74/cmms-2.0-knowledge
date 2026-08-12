# scr_ComponentLab — validación aislada de componentes

**Tipo:** utility screen técnica.  
**No forma parte:** de las 25 pantallas funcionales ni de la navegación del CMMS.  
**Autoridad:** `30-playbooks/power-platform/modular-power-apps-screen-construction.md`.

## Por qué existe

`scr_DesignSystemLab` queda con su geometría `FROZEN` después de `COLOR FOUNDATION APPROVED`. Sus slots no tienen altura suficiente para validar correctamente componentes grandes como:

```text
cmp_FL_TreePro              540×560
cmp_FL_RiskMatrixPro        900×650
cmp_FL_ApplicabilityMatrix  ~920×350
```

No se reabre el DesignSystemLab para hacer caber componentes. Se crea una superficie técnica separada.

## Secuencia

```text
CL-S01  Component Lab skeleton
        ↓ validate / freeze geometry
CL-C01  cmp_FL_TreePro isolated instance
        ↓ component gate
CL-C02  cmp_FL_LineagePanelPro isolated instance
CL-C03  cmp_FL_ApplicabilityMatrixPro isolated instance
CL-C04  cmp_FL_ProcessRailPro isolated instance
CL-C05  cmp_FL_RiskMatrixPro isolated instance
CL-C06  cmp_FL_DecisionPanelPro isolated instance
CL-C07  cmp_FL_GatePanelPro isolated instance
```

Cada componente se retira/reemplaza dentro del mismo `ph_ComponentUnderTest`; no se acumulan siete instancias simultáneas.

## CL-S01 — contrato

```text
BLOCK CL-S01 — Component Lab skeleton
Type: S — Structural
Target: scr_ComponentLab
Dependencies: COLOR FOUNDATION APPROVED
TOUCHES: scr_ComponentLab only
DO NOT MODIFY: scr_DesignSystemLab, Functional Lab screens, reusable components
Expected result: COMPONENT LAB STRUCTURE FROZEN
```

### ph_ComponentUnderTest

```text
Purpose: área principal para una única instancia bajo prueba
Target useful size: >= 980×680 desktop cuando App.Width lo permita
Future content: un componente reutilizable cada vez
Status: STRUCTURAL
```

### ph_TestControls

```text
Purpose: fixture, instrucciones y resultados de smoke
Target width: ~300 px desktop
Future content: controles mínimos del bloque CL-Cxx correspondiente
Status: STRUCTURAL
```

## Regla de componentes

No integrar una revisión en pantalla funcional hasta superar:

```text
SOURCE_VALID
→ COMPONENT_DEFINITION_ACCEPTED
→ INSTANCE_SAFE
→ PUBLIC_CONTRACT_VALIDATED
→ VISUAL_QA_VALIDATED
→ READY_FOR_INTEGRATION
```
