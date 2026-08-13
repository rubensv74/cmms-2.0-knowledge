# Power Apps Screens — Functional Lab alineado

**Fuente canónica:** rama `feature/f01-premium-foundation`  
**Estado:** 25 pantallas funcionales publicadas como referencia de fuente; construcción/evolución regida por el playbook modular.

## Autoridad de construcción

Antes de cualquier evolución YAML consultar:

`functional-engineering-knowledge-base/30-playbooks/power-platform/modular-power-apps-screen-construction.md`

Las pantallas forman un grafo único y varias contienen `Navigate(...)` hacia otras del conjunto.

Se pueden crear primero las identidades faltantes como `Blank screen` para resolver referencias cruzadas, pero eso **no autoriza a sustituir después las 25 pantallas de forma monolítica**.

Para una pantalla nueva o abierta a reconstrucción:

```text
S skeleton completo
→ placeholders contratados
→ Studio validation
→ GEOMETRY FROZEN
→ C placeholder → component
→ validation / freeze
→ I integration
→ Theme pass separado
```

Para una pantalla ya aprobada:

```text
conservar geometría y comportamiento congelados
→ tocar únicamente el slot declarado
→ FIX independiente si falla
```

## Canónicas — 25 pantallas funcionales

| Módulo | Pantalla | Propósito |
|---|---|---|
| Inicio | `scr_FL_Home` | Arranque, navegación y fixture alineado |
| Activos | `scr_FL_FLH` | Jerarquía FLH |
| Activos | `scr_FL_Taxonomy` | Clasificación / taxonomía |
| Activos | `scr_FL_ADR` | Relaciones ADR |
| Activos | `scr_FL_AssetCriticality` | Criticidad contextual independiente del AMEF |
| Activos | `scr_FL_Asset360` | Ficha consolidada del TechnicalObject |
| Estrategia | `scr_FL_FmeaLibrary` | Biblioteca AMEF reusable por familia |
| Estrategia | `scr_FL_FmeaRevision` | Revisión versionada de ingeniería base |
| Estrategia | `scr_FL_AssetApplication` | Aplicación multi-activo, perfiles y overrides |
| Estrategia | `scr_FL_AnalysisRegister` | Registro de AnalysisCase contextuales |
| Estrategia | `scr_FL_CaseOverview` | Caso + lineage + Process Rail |
| Estrategia | `scr_FL_Context` | FL-01..03 · alcance, contexto y aplicabilidad |
| Estrategia | `scr_FL_Functions` | FL-04..05 · funciones/fallos heredados y overrides |
| Estrategia | `scr_FL_FailureModes` | FL-06 · modos y causas aplicables |
| Estrategia | `scr_FL_AMEF` | FL-07..11 · riesgo AMEF S/O/D separado de criticidad |
| Estrategia | `scr_FL_RCM` | FL-12..16 · lógica RCM versionable y decisión |
| Estrategia | `scr_FL_Economics` | FL-17 · comparación económica preliminar |
| Estrategia | `scr_FL_Task` | FL-18..19 · tarea ejecutable, recursos, H-H, procedimiento |
| Estrategia | `scr_FL_PlanPackage` | FL-20..22 · alcance físico y agrupación candidata |
| Estrategia | `scr_FL_Traceability` | FL-23..24 · Biblioteca → ejecución |
| Estrategia | `scr_FL_ReviewApproval` | FL-25..26 · revisión, aprobación, snapshot |
| Estrategia | `scr_FL_Effectiveness` | FL-27..28 · resultados y mejora |
| Planes | `scr_FL_MaintenancePlans` | Job Plan/Route, PM, WO y resultados por tag |
| Gobernanza | `scr_FL_Governance` | revisiones, aprobaciones, findings y cambios |
| Configuración | `scr_FL_Settings` | preferencias y reglas conceptuales configurables |

## Utility screen

`scr_DesignSystemLab` no forma parte de las 25 pantallas funcionales ni de la navegación del producto.

Se construye únicamente para validar:

```text
tokens
color
contraste
Classic/Modern controls
interaction states
data visualisation palette
```

Bloques:

`../labs/design-system/`

## Freeze actual

Consultar:

`../../development/FREEZE_REGISTER_2026-08-11.md`

No modificar incidentalmente una pantalla `FUNCTIONAL_FROZEN` o su geometría congelada desde un bloque de otra pantalla.

## Principios protegidos

```text
FmeaRevision ≠ AnalysisCase
AssetCriticality ≠ RiskAssessment AMEF
ProposedMaintenanceTask ≠ MaintenanceTask
MaintenanceTask ≠ MaintenanceProcedure
MaintenanceTask ≠ JobPlan
JobPlan ≠ PreventiveMaintenancePlan
PreventiveMaintenancePlan ≠ WorkOrder
```

## Bootstrap

`scr_FL_Home.OnVisible` es la autoridad del fixture alineado. No reinstalar bootstrap legacy.

## Visual QA

```text
mínimo visible 11
supporting     12
body           13–14
section title  16–18
page title     24–28
button         12–13
```

No aplicar reemplazos globales ciegos de tipografía o color. La paleta se valida primero en `scr_DesignSystemLab`; la tipografía se corrige mediante bloques visuales acotados sin reabrir comportamiento congelado.

## AMEF

`scr_FL_AMEF` permanece `IN_CONSTRUCTION` y es la pantalla que debe reconstruirse mediante `skeleton first`.

No pegar otra versión monolítica completa como método de recuperación.

## Legacy

`scr_FL_WorkspaceShell.pa.yaml` pertenece a la arquitectura v1. Se conserva como evidencia histórica y no se instala como pantalla canónica.

## Guías

- `../V2_INSTALLATION.md`
- `../../development/RECOVERY_HARDENING_AUDIT_2026-08-11.md`
- `../../development/FREEZE_REGISTER_2026-08-11.md`
- `../../development/TOMORROW_RUNBOOK_2026-08-12.md`
