# Matriz de trazabilidad — Correcciones D-01…D-14

**Fecha:** 2026-08-11  
**Estado:** corrección funcional implementada / `PASS_STATIC` / Studio pendiente

Esta matriz permite comprobar que cada desviación detectada en la auditoría tiene reflejo en dominio, experiencia y Source Code. `Implementado` significa que existe capacidad funcional y representación en el laboratorio; no implica todavía `INSTANCE_SAFE` ni aprobación corporativa de reglas configurables.

| ID | Corrección | Dominio / contrato | Evidencia de experiencia | Estado |
|---|---|---|---|---|
| D-01 | Biblioteca AMEF reusable | `FmeaDefinition`, `FmeaRevision`, `Function`, `FunctionalFailure`, `FailureMode`, `FailureEffect`, `ProposedMaintenanceTask` | `scr_FL_FmeaLibrary`, `scr_FL_FmeaRevision`, lineage en AnalysisCase | Implementado |
| D-02 | Criticidad del activo separada del riesgo AMEF | `AssetCriticalityAssessment` ≠ `RiskAssessment` | `scr_FL_AssetCriticality`; AMEF muestra criticidad como input externo y usa `Matriz de riesgo AMEF` | Implementado |
| D-03 | Aplicación multi-activo | `FmeaAssetApplication`, `FmeaApplicabilityRule` | `scr_FL_AssetApplication`, `cmp_FL_ApplicabilityMatrixPro`; P-101/P-102/P-103 reutilizan R01 | Implementado |
| D-04 | Perfiles / variantes por contexto | `MaintenanceApplicabilityProfile`, `TaskProfileVariant` | `scr_FL_AssetApplication`, `scr_FL_Task`; perfil y frecuencia contextual visibles | Implementado en capacidad |
| D-05 | Causa / mecanismo de fallo | `FailureCause` | `scr_FL_FmeaRevision`, `scr_FL_FailureModes`, `scr_FL_AMEF` muestran modo + causa | Implementado |
| D-06 | Relación N:M tarea ↔ modo | `ProposedTaskFailureMode` | `scr_FL_FmeaRevision` y `scr_FL_Task` muestran cobertura N:M | Implementado |
| D-07 | Procedimiento/checklist opcional | `MaintenanceProcedure`, `TaskProcedureLink` | `scr_FL_Task` distingue tarea de procedimiento y admite ausencia de link | Implementado |
| D-08 | Condiciones operativas por tarea | `RequiredOperatingState`, `RequiresShutdown`, `IsolationRequirement`, `PermitRequirement` en `MaintenanceTask` | `scr_FL_Task` muestra/edita las condiciones a nivel de tarea | Implementado |
| D-09 | Duración, cuadrilla y H-H | `EstimatedDuration`, `CrewSize`, `EstimatedManHours`, `Discipline`, `WorkCenter` | `scr_FL_Task` calcula H-H; `scr_FL_PlanPackage` consolida carga | Implementado |
| D-10 | Tres capas de coste | `EconomicAssessment`, `MaintenanceCostEstimate`, `ActualMaintenanceCost` | `scr_FL_Economics`, `scr_FL_Task`, `scr_FL_MaintenancePlans` / efectividad | Implementado |
| D-11 | Lógica RCM versionable | `DecisionLogic`, `DecisionLogicRevision`, `DecisionQuestion`, `DecisionTransition`, `RcmAssessment`, `RcmAssessmentAnswer` | `scr_FL_RCM` consume `RCM-DEMO-01 / R01` y declara abierta la lógica corporativa | Implementado en arquitectura |
| D-12 | Alcance físico por objeto técnico | `PlanScopeItem` con `TechnicalObjectId` y `RoleInScope` | `scr_FL_PlanPackage` conserva equipo principal y soportes; handoff mantiene identidad | Implementado |
| D-13 | Job Plan / PM / WO / resultado separados | `JobPlan`, `JobPlanTask`, `PreventiveMaintenancePlan`, `WorkOrder`, `ExecutionResult` | `scr_FL_MaintenancePlans` presenta los objetos como conceptos distintos | Implementado |
| D-14 | Agrupación sin pérdida de tag | `MaintenanceCycle`, `RouteGroupingRule`, `ObjectList`, `ObjectListItem` | `scr_FL_PlanPackage` y `scr_FL_MaintenancePlans`; WO/resultados conservan `TechnicalObjectId` | Implementado en capacidad |

## Evidencia transversal

### Componentes

```text
cmp_FL_LineagePanelPro
→ hace visible Biblioteca → Aplicación → Activo → ejecución

cmp_FL_ApplicabilityMatrixPro
→ demuestra reutilización de una revisión sobre múltiples activos

cmp_FL_RiskMatrixPro
→ matriz configurable; P-101 usa 5×5 sin confundirla con criticidad del activo
```

### Fixture de referencia

```text
FmeaDefinition     AMEF-BOMBA-CENTRIFUGA
FmeaRevision       R01
P-101              APP-P101-R01 · criticidad Alta · perfil HIGH
P-102              misma R01 · contexto/perfil distinto
P-103              misma R01 · contexto/perfil distinto
```

### Cadena de trazabilidad objetivo

```text
FmeaDefinition / FmeaRevision
→ FmeaAssetApplication
→ AnalysisCase
→ FailureMode / FailureCause / RiskAssessment
→ RcmAssessment / HumanDecision
→ ProposedMaintenanceTask
→ TaskProfileVariant
→ MaintenanceTask
→ MaintenanceProcedure? / JobPlan
→ PreventiveMaintenancePlan
→ WorkOrder
→ ExecutionResult / ActualMaintenanceCost
→ EffectivenessMeasurement
→ ChangeRequest
```

## Interpretación de estados

`Implementado en capacidad` no fija una política corporativa. Indica que el modelo puede representar la decisión una vez acordada, sin una nueva reconstrucción estructural.

La aceptación final de estas 14 correcciones requiere ahora los 11 smoke tests de `power-apps/V2_INSTALLATION.md`.