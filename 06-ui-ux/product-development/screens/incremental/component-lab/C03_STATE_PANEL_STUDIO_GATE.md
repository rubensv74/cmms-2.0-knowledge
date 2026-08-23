# CMMS 2.0 — C03 State Panel Studio Gate

**Fecha:** 2026-08-23  
**Estado:** `C03 CANDIDATE / PENDING POWER APPS STUDIO GATE`  
**Método:** `CREATE_SHARED_COMPONENT`

## Objetivo

Validar `cmp_CMMS_StatePanelPro_RC0` como primitive transversal para estados de superficie.

## Carencia reusable demostrada

CMMS 2.0 necesitará representar de forma consistente estados no-ready y ready en Home, Project Setup, Assets, Libraries, Maintenance Engineering, Plans y Governance.

- `REUSE`: no existe todavía State Panel CMMS compartido.
- `EXTEND_SHARED`: no existe un primitive CMMS previo con este contrato.
- `CREATE_SHARED`: procede.
- `LOCAL_ONLY`: descartado porque el patrón es transversal.

## Contrato RC0

Estados soportados:

- `READY`
- `LOADING`
- `EMPTY`
- `ERROR`
- `UNAVAILABLE`
- `NO_CONTEXT`

Inputs:

- `State`
- `Title`
- `Message`
- `ActionText`
- `ShowAction`
- `IsActionBusy`
- `ActionBusyText`

Evento:

- `OnAction`

El componente no ejecuta consultas, flows, navegación ni escrituras. La acción solicita al host una operación y debe respetar `IsActionBusy` como guard visual contra doble ejecución.

## Candidate component

`06-ui-ux/product-development/components/experimental/cmp_CMMS_StatePanelPro_RC0.pa.yaml`

## Candidate lab

`06-ui-ux/product-development/screens/incremental/component-lab/scr_CMMS_ComponentLab_C03_Candidate.pa.yaml`

## Gate Studio

1. Importar/crear `cmp_CMMS_StatePanelPro_RC0` desde Source Code.
2. Confirmar ausencia de errores de Source Code Schema y Power Fx.
3. Crear una nueva pantalla temporal desde Source Code.
4. Pegar `scr_CMMS_ComponentLab_C03_Candidate.pa.yaml`.
5. Confirmar que aparecen seis variantes: `LOADING`, `EMPTY`, `ERROR`, `UNAVAILABLE`, `NO_CONTEXT`, `READY`.
6. Confirmar que colores y símbolos distinguen los estados sin depender solo del color: cada card debe tener título explícito.
7. Confirmar que `ERROR` y `NO_CONTEXT` muestran acción y que las demás no muestran botones cuando `ShowAction=false`.
8. Pulsar una acción una vez y confirmar ausencia de runtime error aunque `OnAction=false` en el lab.
9. Confirmar que no existe overlap/clipping a ancho desktop normal.
10. Capturar una imagen completa del lab.

## Resultado esperado

`C03-SP = PASS / STUDIO VALIDATED`

Tras PASS queda autorizado `C04 — Sidebar`.

No sustituir todavía los primitives locales de `scr_Home S01`; la adopción se hará después de validar Page Header + Project Context + State Panel + Sidebar como foundation compartida.
