# F03 — Actualización in situ en Power Apps Studio — SUPERSEDED

**Estado:** `SUPERSEDED` desde 2026-08-11.  
**No ejecutar la secuencia de ocho actualizaciones descrita en la versión histórica.**

## Aprendizaje que se conserva

La regla de identidad sigue siendo obligatoria:

```text
componente existente
→ actualizar definición in situ
→ conservar identidad
```

No usar una copia `_1` como mecanismo de actualización.

## Procedimiento retirado

La versión histórica indicaba actualizar de una vez:

```text
Sidebar
PageHeader
ProcessRail
Lineage
RiskMatrix
DecisionPanel
GatePanel
scr_FL_AMEF
```

y validar al final.

Ese método queda retirado porque mezcla varios componentes, geometría de pantalla, integración y color antes de aislar el bloque que falla.

## Procedimiento vigente

Seguir el playbook modular:

```text
S skeleton
→ validate / freeze
C component
→ validate / freeze
I integration
→ validate / freeze
FIX si falla
```

Para componentes reutilizables:

```text
SOURCE_VALID
→ COMPONENT_DEFINITION_ACCEPTED
→ INSTANCE_SAFE
→ PUBLIC_CONTRACT_VALIDATED
→ VISUAL_QA_VALIDATED
→ READY_FOR_INTEGRATION
```

La instancia de prueba se valida primero en `scr_DesignSystemLab`.

## AMEF

No actualizar `scr_FL_AMEF` desde una versión completa histórica.

Contrato vigente:

`../S-AMEF-01/CONTRACT.md`

## Referencias vigentes

```text
../../../../development/TOMORROW_RUNBOOK_2026-08-12.md
../../../../development/FREEZE_REGISTER_2026-08-11.md
../../../../development/RECOVERY_HARDENING_AUDIT_2026-08-11.md
```
