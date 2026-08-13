# Cierre de correcciones D-01…D-14 — CMMS 2.0 Functional Lab

**Fecha:** 2026-08-11  
**Rama:** `feature/f01-premium-foundation`  
**Objetivo:** dejar evidencia verificable de cómo se ha corregido cada desviación detectada en la auditoría de las últimas reuniones.

## 1. Criterio de cierre

Una observación se marca como **CORREGIDA EN MODELO** cuando:

- existe un contrato de dominio que la soporta;
- la arquitectura/pantallas la representan;
- el fixture/runtime demuestra el concepto cuando aplica;
- las guías explican el concepto de forma coherente.

Esto **no equivale** a `INSTANCE_SAFE` ni `VISUAL_QA_VALIDATED`. Las nuevas piezas deben superar Power Apps Studio.

## 2. Matriz de evidencia

| ID | Corrección | Evidencia principal | Validación Studio pendiente |
|---|---|---|---|
| D-01 | Biblioteca AMEF reutilizable | `domain-contracts.md`: `FmeaDefinition/FmeaRevision`; `scr_FL_FmeaLibrary`; `scr_FL_FmeaRevision`; Home bootstrap | abrir biblioteca, revisión y navegación |
| D-02 | Criticidad de activo separada de riesgo AMEF | `AssetCriticalityAssessment`; `scr_FL_AssetCriticality`; `scr_FL_AMEF` usa “Matriz de riesgo AMEF” | confirmar separación visual y semántica |
| D-03 | Aplicación multi-activo | `FmeaAssetApplication`; `scr_FL_AssetApplication`; `cmp_FL_ApplicabilityMatrixPro`; P-101/P-102/P-103 | selección y cambio entre aplicaciones |
| D-04 | Perfiles/variantes contextuales | `MaintenanceApplicabilityProfile`; `TaskProfileVariant`; runtime HIGH/MEDIUM/LOW | comprobar intervalos distintos sin duplicación |
| D-05 | Causa/mecanismo explícito | `FailureCause`; `colFLFmeaFailureCauses`; pantallas Revisión/FailureModes | visualizar causas asociadas al modo |
| D-06 | N:M tarea ↔ modo | `ProposedTaskFailureMode`; `colFLTaskFailureModeLinks`; `scr_FL_Task` muestra cobertura | comprobar un modo con varias tareas y viceversa |
| D-07 | Procedimiento/checklist opcional | `MaintenanceProcedure`; `TaskProcedureLink`; tarea base con `ProcedureRequiredByDefault` | validar tarea con y sin procedimiento |
| D-08 | Estado operativo/restricciones en tarea | `MaintenanceTask.RequiredOperatingState/RequiresShutdown/Isolation/Permit`; `scr_FL_Task` | edición/visualización y derivación al paquete |
| D-09 | Duración, cuadrilla, H-H | `MaintenanceTask.EstimatedDuration/CrewSize/EstimatedManHours`; `scr_FL_Task` | comprobar cálculo y composición visual |
| D-10 | Tres capas de coste | `EconomicAssessment`; `MaintenanceCostEstimate`; `ActualMaintenanceCost`; Economics/Task/Execution | comprobar que no se mezclan en UI |
| D-11 | RCM versionable | `DecisionLogic/Revision/Question/Transition`; `RcmAssessment/Answer`; `scr_FL_RCM` | validar recorrido sin rigidez estructural |
| D-12 | Alcance principal/soportes por tag | `PlanScopeItem`; `scr_FL_PlanPackage` | varios TechnicalObject sin pérdida de identidad |
| D-13 | Job Plan / PM / WO separados | `JobPlan`, `PreventiveMaintenancePlan`, `WorkOrder`, `ExecutionResult`; `scr_FL_MaintenancePlans` | comprobar cadena y trazabilidad por tag |
| D-14 | Optimización/agrupación | `MaintenanceCycle`, `RouteGroupingRule`, `ObjectList`; PlanPackage/MaintenancePlans | validar agrupación sin perder detalle individual |

## 3. Evidencia transversal

### Arquitectura

`../architecture.md`

Define el flujo:

```text
Biblioteca
→ Contexto del activo
→ Aplicación
→ AnalysisCase
→ Ejecutabilidad
→ Handoff
→ Resultados / mejora
```

### Contratos

`../domain-contracts.md`

Contiene los objetos persistentes necesarios para las 14 correcciones.

### Pantallas

`../screen-map.md` y `../power-apps/screens/README.md`

El inventario canónico pasa a 25 pantallas.

### Componentes

`../component-catalog.md`

La Foundation pasa a 9 componentes e incorpora:

- `cmp_FL_LineagePanelPro`;
- `cmp_FL_ApplicabilityMatrixPro`.

### Runtime

`../power-apps/runtime/functional-lab-aligned-bootstrap.powerfx`

El fixture demuestra:

- biblioteca AMEF reusable;
- criticidad P-101/P-102/P-103;
- aplicaciones multi-activo;
- perfiles/variantes;
- causas;
- tareas propuestas y cobertura N:M.

La autoridad ejecutable de la app de validación está en `scr_FL_Home.OnVisible`.

### Guías

- `../guides/GUIA_EXPERIENCIA_FUNCIONAL_USUARIO.md`;
- `../guides/GUIA_DEMOSTRACION_CMMS_FUNCTIONAL_LAB.md`.

Ambas explican ya Biblioteca → Aplicación → AnalysisCase → Ejecución y separan criticidad de planta de riesgo AMEF.

## 4. Qué se ha retirado

Se eliminó el bootstrap anterior:

`power-apps/runtime/functional-lab-v2-bootstrap.powerfx`

Motivo: evitaba que una reinstalación posterior reintrodujera el modelo pre-auditoría centrado en P-101 como propietario implícito de la ingeniería.

`WorkspaceShell` continúa únicamente como evidencia histórica de pruebas ya superadas y no forma parte del modelo canónico.

## 5. Estado de aceptación

```text
D-01…D-14             CORREGIDAS EN MODELO
Arquitectura           ALINEADA
Contratos              ALINEADOS
Pantallas canónicas    25
Componentes canónicos  9
Runtime fixture         ALINEADO
Guías                   ALINEADAS
Studio integrado        PENDIENTE
```

No se declara todavía:

```text
INSTANCE_SAFE
PUBLIC_CONTRACT_VALIDATED
VISUAL_QA_VALIDATED
READY_FOR_INTEGRATION
```

para las nuevas piezas.

## 6. Próximo paso

Ejecutar los smoke tests de `power-apps/V2_INSTALLATION.md`.

Una vez superados, el siguiente bloque de trabajo será decidir de forma explícita los asuntos que la auditoría dejó como **no-desviaciones / decisiones corporativas abiertas**. No deben resolverse por inferencia durante la validación técnica.
