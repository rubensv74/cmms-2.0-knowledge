# CMMS 2.0 — Project Teams & Roles S01 Studio Gate

**Fecha:** 2026-08-23  
**Estado:** `S01 CANDIDATE / PENDING POWER APPS STUDIO GATE`  
**Método:** `CREATE_NEW_SCREEN`

## Objetivo

Validar `SCR-013 — Project Teams & Roles` como superficie de configuración de responsabilidades y cobertura de autoridad del proyecto.

S01 usa principals sintéticos y no congela el identity provider ni el security model productivo.

## Candidate

`06-ui-ux/product-development/screens/incremental/project-teams-roles/scr_ProjectTeamsRoles_S01_Candidate.pa.yaml`

## Contrato probado

La pantalla debe demostrar:

- roles required vs optional;
- assignment explícita;
- vacante de autoridad visible;
- cobertura 3/4 → 4/4;
- estado dirty;
- Save draft / Reset;
- ausencia de routing universal hardcodeado.

## Gate Studio

1. Crear una pantalla nueva desde Source Code usando el YAML candidato.
2. Confirmar ausencia de errores de Source Code Schema y Power Fx.
3. Confirmar shared shell, proyecto `P-001` y header `Project Teams & Roles`.
4. Estado inicial esperado:
   - `ROLE GAP`;
   - `3 of 4 required roles covered`;
   - `Maintenance Responsible` marcado `VACANT`;
   - inspector `Required role missing`.
5. En `Maintenance Responsible`, seleccionar `Laura Gomez`.
6. Verificar inmediatamente:
   - header `UNSAVED CHANGES`;
   - cobertura `4 of 4 required roles covered`;
   - el rol deja de mostrarse como vacante;
   - inspector `Local changes pending`.
7. Pulsar `Save draft`.
8. Verificar:
   - status `ROLE COVERAGE READY`;
   - inspector `Project role coverage ready`;
   - state panel `READY`.
9. Cambiar la asignación a `Miguel Ortega` y pulsar `Reset`.
10. Verificar que vuelve a `Laura Gomez` y desaparece dirty state.
11. Confirmar que `Operations Representative` y `Corporate Library Governance` aparecen como opcionales.
12. Confirmar que no existe una secuencia universal de aprobación incrustada en la pantalla.
13. Confirmar ausencia de clipping/overlap a ancho desktop normal.

## PASS esperado

`S01-TR = PASS / STUDIO VALIDATED`

Tras PASS se considera completado el núcleo inicial de Project Setup:

- Project Profile;
- Maintenance Configuration;
- Risk Profile / Matrix Configuration;
- Project Teams & Roles.

El siguiente incremento recomendado será completar `Project Home / Needs Attention` y después `Portfolio Overview`, usando señales reales derivadas de estas cuatro superficies.

## Límite S01

- no Entra ID productivo;
- no permisos efectivos de Power Apps;
- no claims;
- no routing productivo;
- no workflow de aprobación definitivo;
- no SQL / API / Power Automate.