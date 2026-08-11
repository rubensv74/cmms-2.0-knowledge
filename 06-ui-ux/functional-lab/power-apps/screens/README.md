# Power Apps Screens — Functional Lab alineado

**Fuente canónica:** rama `feature/f01-premium-foundation`  
**Estado:** 25 fuentes publicadas / instalación completa y Visual QA pendientes de Power Apps Studio.

## Regla de instalación

Estas pantallas forman un **grafo único**. Varias contienen `Navigate(...)` hacia otras pantallas del mismo conjunto.

Por tanto:

```text
crear primero las 25 identidades en Studio
→ actualizar los 9 componentes in situ
→ sustituir después el Source Code de las 25 pantallas desde esta carpeta
```

No evaluar `Name isn't valid. 'scr_FL_...'` con un grafo parcial si el nombre señalado pertenece a esta lista y aún no ha sido creado en Studio.

No instalar pantallas desde commits históricos individuales.

## Canónicas — 25 pantallas

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

`scr_FL_Home.OnVisible` es la autoridad del fixture alineado. No reinstalar el bootstrap legacy.

## Visual QA

Las pantallas aún contienen deuda tipográfica histórica en algunos textos auxiliares. No aplicar reemplazos globales ciegos. El estándar obligatorio es:

```text
mínimo visible 11
supporting     12
body           13–14
section title  16–18
page title     24–28
button         12–13
```

Primero cerrar `FOUNDATION INTEGRATED PASS`; después corregir una pantalla de referencia y propagar el patrón una vez validado que no introduce clipping.

## Legacy

`scr_FL_WorkspaceShell.pa.yaml` pertenece a la arquitectura v1. Se conserva como evidencia histórica y no se instala como pantalla canónica.

## Guías

- `../V2_INSTALLATION.md`
- `../../development/RECOVERY_HARDENING_AUDIT_2026-08-11.md`
- `../../development/TOMORROW_RUNBOOK_2026-08-12.md`
