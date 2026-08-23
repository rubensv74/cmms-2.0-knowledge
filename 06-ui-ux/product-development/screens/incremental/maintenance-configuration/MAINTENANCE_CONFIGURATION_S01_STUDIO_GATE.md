# CMMS 2.0 — Maintenance Configuration S01 Studio Gate

**Fecha:** 2026-08-23  
**Estado:** `S01-MC = PASS / STUDIO VALIDATED`  
**Método:** `CREATE_NEW_SCREEN`

## Objetivo

Validar `SCR-011 — Maintenance Configuration` como primera Configuration Studio orientada a settings de proyecto con procedencia explícita.

## Candidate

`06-ui-ux/product-development/screens/incremental/maintenance-configuration/scr_MaintenanceConfiguration_S01_Candidate.pa.yaml`

## Contrato funcional probado

La pantalla demuestra tres procedencias que no deben confundirse:

- `CORPORATE DEFAULT`
- `PROJECT OVERRIDE`
- `PROJECT SPECIFIC`

S01 trabaja solo con estado local sintético. No conecta SQL, Power Automate ni API.

## Resultado Studio — 2026-08-23

Validado en Power Apps Studio con evidencia visual aportada durante el gate.

Comprobaciones confirmadas:

- Source Code aceptado y pantalla renderizada sin errores visibles;
- Shared UI Foundation estable;
- contexto `P-001 · SYNTHETIC DEMO PROJECT A` visible;
- `Project Setup` activo en sidebar;
- header `Maintenance Configuration`;
- cambio de `PROJECT-SPECIFIC TAXONOMY CLASSES` a `Not allowed` genera `UNSAVED CHANGES`;
- el setting modificado muestra procedencia `PROJECT OVERRIDE`;
- el inspector cambia a `Local changes pending`;
- la leyenda diferencia explícitamente `CORPORATE DEFAULT`, `PROJECT OVERRIDE` y `PROJECT SPECIFIC` sin depender solo del color;
- `REQUIRED REVIEW ROLE` conserva procedencia `PROJECT SPECIFIC`;
- composición desktop sin overlap/clipping relevante.

Los comportamientos locales `Save draft` y `Reset` siguen el patrón ya validado en `Project Profile S01`; permanecen como hardening funcional menor, no como bloqueo para avanzar a SCR-012.

## Gate Studio original

1. Crear una pantalla nueva desde Source Code usando el YAML candidato.
2. Confirmar ausencia de errores de Source Code Schema y Power Fx.
3. Confirmar shared shell, proyecto `P-001` y header `Maintenance Configuration`.
4. Confirmar baseline `DRAFT SAVED` y `Reset` deshabilitado.
5. Cambiar `PROJECT-SPECIFIC TAXONOMY CLASSES` de `Allowed` a `Not allowed`.
6. Verificar inmediatamente:
   - status `UNSAVED CHANGES`;
   - `Reset` habilitado;
   - source badge de ese setting pasa a `PROJECT OVERRIDE`;
   - inspector pasa a `Local changes pending`.
7. Pulsar `Save draft`.
8. Verificar que el nuevo valor queda como baseline local y vuelve `DRAFT SAVED`.
9. Cambiar otra opción y pulsar `Reset`.
10. Verificar que recupera el último baseline guardado y desaparece `UNSAVED CHANGES`.
11. Confirmar que `REQUIRED REVIEW ROLE` mantiene procedencia `PROJECT SPECIFIC`.
12. Confirmar que la leyenda distingue las tres procedencias sin depender solo del color.
13. Confirmar ausencia de clipping/overlap a ancho desktop normal.
14. Capturar una imagen baseline y otra con un override sin guardar.

## PASS

`S01-MC = PASS / STUDIO VALIDATED`

Queda autorizado `SCR-012 — Risk Profile / Matrix Configuration S01`.

## Límite

Los settings representados son candidatos P01 ya documentados. No incorporar aquí opciones de Work Orders, planning, scheduling, ejecución, costes o inventario todavía en discovery.
