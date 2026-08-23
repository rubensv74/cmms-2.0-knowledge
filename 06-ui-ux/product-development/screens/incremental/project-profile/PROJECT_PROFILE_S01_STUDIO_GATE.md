# CMMS 2.0 — Project Profile S01 Studio Gate

**Fecha:** 2026-08-23  
**Estado:** `S01 CANDIDATE / PENDING POWER APPS STUDIO GATE`  
**Método:** `CREATE_NEW_SCREEN`

## Pantalla

`SCR-010 — Project Profile`

## Objetivo

Validar el primer `Configuration Studio` funcional de CMMS 2.0 sobre la Shared UI Foundation RC0.

La pantalla debe permitir editar un Project Profile sintético de forma local, detectar cambios, guardar un draft local y resetear cambios sin persistencia productiva.

## Candidate

`06-ui-ux/product-development/screens/incremental/project-profile/scr_ProjectProfile_S01_Candidate.pa.yaml`

## Componentes compartidos consumidos

- `cmp_CMMS_SidebarPro_RC0`
- `cmp_CMMS_ProjectContextPro_RC0`
- `cmp_CMMS_PageHeaderPro_RC0`
- `cmp_CMMS_StatePanelPro_RC0`

## Gate Studio

1. Crear una pantalla nueva desde Source Code con el YAML candidato.
2. Confirmar ausencia de errores de Source Code Schema y Power Fx.
3. Confirmar que el sidebar muestra `Project Setup` como activo.
4. Confirmar que el top context muestra `P-001 · SYNTHETIC DEMO PROJECT A` en modo de solo contexto.
5. Confirmar Page Header `Project Profile` con estado inicial `DRAFT`.
6. Confirmar que se muestran los campos principales de identidad y alcance del proyecto.
7. Modificar `Project Name`.
8. Confirmar cambio inmediato del status a `UNSAVED CHANGES` y del inspector a estado no-ready.
9. Pulsar `Save draft`.
10. Confirmar que el status pasa a `DRAFT SAVED` y desaparece el estado dirty.
11. Modificar un segundo campo y pulsar `Reset`.
12. Confirmar que vuelve al valor sintético inicial y se limpia el estado dirty.
13. Vaciar `Project Code` o `Project Name` y confirmar que `Save draft` queda deshabilitado.
14. Confirmar ausencia de overlap/clipping a ancho desktop normal.
15. Capturar una imagen completa con la pantalla en estado `DRAFT` o `DRAFT SAVED`.

## Límite funcional S01

- no SQL;
- no Power Automate;
- no API;
- no creación real de proyecto;
- no unicidad real de ProjectCode;
- no security model productivo;
- no Activate/Archive productivo.

La pantalla valida el patrón de interacción y el contrato lógico, no la persistencia.

## PASS esperado

`PP-S01 = PASS / STUDIO VALIDATED`

Tras PASS queda autorizado el siguiente incremento de Project Setup: `SCR-011 — Maintenance Configuration`.
