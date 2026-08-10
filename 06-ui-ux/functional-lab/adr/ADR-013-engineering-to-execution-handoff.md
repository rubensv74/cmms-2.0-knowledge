# ADR-013 — Separar ingeniería, tarea, procedimiento, PM y ejecución

**Estado:** accepted  
**Fecha:** 2026-08-10  
**Origen:** auditoría de alineación con las últimas reuniones y presentación O&M.

## Contexto

La arquitectura anterior agrupaba demasiado pronto conceptos distintos bajo `MaintenanceTask` y `MaintenancePlanPackage`. Las reuniones y la documentación O&M distinguen claramente la decisión de ingeniería, la tarea propuesta, el procedimiento/Job Plan, la estrategia preventiva, el PM y la orden de trabajo.

## Decisión

Adoptar el siguiente handoff conceptual:

```text
FmeaRevision / RCM
        ↓
ProposedMaintenanceTask
        ↓
FmeaAssetApplication / TaskProfileVariant
        ↓
MaintenanceTask
        ↓
MaintenanceProcedure / InspectionFormat (opcional)
        ↓
JobPlan / Route
        ↓
PreventiveMaintenancePlan
        ↓
WorkOrder
        ↓
ExecutionResult + ActualMaintenanceCost
        ↓
EffectivenessMeasurement / ChangeRequest
```

## Reglas

1. una tarea propuesta puede cubrir varios modos de fallo;
2. un modo de fallo puede requerir varias tareas;
3. la relación se modela N:M mediante `ProposedTaskFailureMode`;
4. una tarea puede no requerir procedimiento;
5. estado operativo, aislamiento y permisos pertenecen a la tarea/variante ejecutable, no solo al paquete;
6. duración, cuadrilla y H-H son propiedades necesarias para planificación y coste;
7. `EconomicAssessment` es una comparación previa de alternativas; `MaintenanceCostEstimate` es coste planificado; `ActualMaintenanceCost` procede de ejecución;
8. agrupar tareas en rutas/planes no elimina la identidad ni trazabilidad por `TechnicalObject`;
9. `PlanScopeItem` conserva el alcance físico y el rol de cada tag dentro del paquete;
10. el Functional Lab puede demostrar el handoff sin imponer todavía el sistema productivo destino.

## Consecuencias

Se incorporan contratos para:

```text
ProposedMaintenanceTask
ProposedTaskFailureMode
TaskProfileVariant
MaintenanceProcedure
TaskProcedureLink
MaintenanceCostEstimate
PlanScopeItem
MaintenanceCycle
RouteGroupingRule
ObjectList
JobPlan
PreventiveMaintenancePlan
WorkOrder
ExecutionResult
ActualMaintenanceCost
```

La UI debe diferenciar claramente `estrategia`, `tarea`, `procedimiento`, `ruta/Job Plan`, `PM` y `WO`.
