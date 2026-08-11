# Power Apps Screens — Functional Lab alineado

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

## Legacy

`scr_FL_WorkspaceShell.pa.yaml` pertenece a la arquitectura v1. Se conserva como evidencia histórica de trabajo ya validado, pero no se instala ni amplía como pantalla canónica.

## Instalación

Seguir `../V2_INSTALLATION.md`.
