# CMMS 2.0 — Risk Profile / Matrix Configuration S01 Studio Gate

**Fecha:** 2026-08-23  
**Estado:** `S01 CANDIDATE / PENDING POWER APPS STUDIO GATE`  
**Método:** `CREATE_NEW_SCREEN`

## Objetivo

Validar `SCR-012 — Risk Profile / Matrix Configuration` como Configuration Studio capaz de representar Risk Profiles estructuralmente distintos sin hardcodear una matriz 5×5 en la pantalla.

## Candidate

`06-ui-ux/product-development/screens/incremental/risk-profile/scr_RiskProfile_S01_Candidate.pa.yaml`

## Shared foundation consumida

- `cmp_CMMS_SidebarPro_RC0`
- `cmp_CMMS_ProjectContextPro_RC0`
- `cmp_CMMS_PageHeaderPro_RC0`
- `cmp_CMMS_StatePanelPro_RC0`

## Fixtures sintéticos S01

### Profile A

- nombre: `Project Risk Profile A`
- display: `5 × 5`
- X: `Likelihood`
- Y: `Consequence`
- mapping fixture: product-based thresholds

### Profile B

- nombre: `Client Risk Profile B`
- display: `4 × 4`
- X: `Probability`
- Y: `Impact`
- mapping fixture: additive thresholds

Estos fixtures no definen una metodología universal. Su única finalidad es demostrar que la misma superficie puede renderizar configuraciones diferentes.

## Gate Studio

1. Crear una pantalla nueva desde Source Code con el YAML candidato.
2. Confirmar ausencia de errores de Source Code Schema y Power Fx.
3. Confirmar sidebar, contexto `P-001` y header `Risk Profile / Matrix Configuration`.
4. Confirmar baseline `DRAFT SAVED`.
5. Confirmar que `Profile A · 5 × 5` muestra:
   - matriz 5×5;
   - ejes `Likelihood × Consequence`;
   - cuatro bandas semánticas;
   - state panel `Risk profile candidate ready`.
6. Pulsar `Profile B · 4 × 4`.
7. Confirmar sin cambiar YAML ni pantalla:
   - matriz pasa a 4×4;
   - ejes pasan a `Probability × Impact`;
   - cambia el texto de regla fixture;
   - el layout sigue estable.
8. Volver a Profile A y confirmar reconstrucción 5×5.
9. Modificar `PROFILE NAME` o un eje.
10. Confirmar:
   - header `UNSAVED CHANGES`;
   - `Reset` habilitado;
   - cambio de fixture queda bloqueado mientras existe dirty state;
   - State Panel muestra `Local changes pending`.
11. Pulsar `Save draft` y confirmar retorno a `DRAFT SAVED`.
12. Modificar otro valor, pulsar `Reset` y confirmar retorno al último baseline local.
13. Confirmar que el significado de bandas no depende solo del color; todas muestran label textual.
14. Confirmar ausencia de clipping/overlap a ancho desktop normal.
15. Capturar una imagen de Profile A y otra de Profile B.

## PASS esperado

`S01-RP = PASS / STUDIO VALIDATED`

Al pasar este gate queda demostrada la condición arquitectónica mínima:

> Risk Profile is data/configuration-driven; 5×5 is a fixture, not a screen rule.

Tras PASS queda autorizado `SCR-013 — Project Teams & Roles`.

## Límite S01

S01 no congela todavía:

- editor completo de niveles/rangos;
- creación/eliminación dinámica de dimensiones;
- editor formal de RiskRule / RiskOverrideRule;
- comparación de versiones;
- aprobación/publicación productiva;
- persistencia SQL/API.

Estas capacidades se añadirán por incrementos sobre el contrato ya validado.
