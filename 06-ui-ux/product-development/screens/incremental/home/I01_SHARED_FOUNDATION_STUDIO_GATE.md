# CMMS 2.0 — scr_Home I01 Shared Foundation Studio Gate

**Fecha:** 2026-08-23  
**Estado:** `I01 CANDIDATE / PENDING POWER APPS STUDIO GATE`

## Objetivo

Validar en una única pantalla la coordinación de la primera `CMMS Shared UI Foundation RC0`:

- `cmp_CMMS_PageHeaderPro_RC0`
- `cmp_CMMS_ProjectContextPro_RC0`
- `cmp_CMMS_StatePanelPro_RC0`
- `cmp_CMMS_SidebarPro_RC0`

## Candidate

`06-ui-ux/product-development/screens/incremental/home/scr_Home_I01_SharedFoundation_Candidate.pa.yaml`

## Condiciones previas

Los cuatro Canvas Components deben existir ya en la app. No eliminar `scr_Home` S01 ni los labs validados.

## Gate funcional

1. Crear una pantalla nueva desde Source Code con el YAML candidato.
2. Confirmar ausencia de errores de Source Code Schema y Power Fx.
3. Al abrir la pantalla debe mostrarse:
   - sidebar expandido;
   - selector de proyecto con `Select project`;
   - header `CMMS 2.0` sin status;
   - state panel `NO_CONTEXT` con `No project selected`.
4. Abrir el selector y elegir `P-001 · SYNTHETIC DEMO PROJECT A`.
5. Confirmar que, sin navegar ni recargar:
   - el footer del sidebar muestra `P-001` y `SYNTHETIC DEMO PROJECT A`;
   - el Page Header muestra `PROJECT READY`;
   - el subtítulo del header refleja el proyecto aceptado;
   - el State Panel cambia a `READY / Project context ready`.
6. Cambiar a `P-002` y confirmar que los mismos tres consumidores actualizan el contexto.
7. Volver a `Select project` y confirmar regreso a `NO_CONTEXT` sin conservar residuos del proyecto anterior.
8. Usar el toggle del sidebar y confirmar que cambia entre 248 px y 72 px sin perder el proyecto aceptado.
9. Confirmar que solo `Home` está habilitado; Project Setup y áreas futuras permanecen visibles pero deshabilitadas.
10. Confirmar ausencia de clipping/overlap a ancho desktop normal.
11. Capturar pantalla completa de Studio en estado `NO_CONTEXT` y, si es posible, otra en `READY`.

## PASS esperado

`I01-HOME = PASS / STUDIO VALIDATED`

Al pasar este gate:

- la `CMMS Shared UI Foundation RC0` puede promoverse a foundation canónica de nuevas pantallas;
- `scr_Home S01` permanece como rollback/reference;
- el siguiente incremento funcional autorizado es `Project Setup`, empezando por `Project Profile`.