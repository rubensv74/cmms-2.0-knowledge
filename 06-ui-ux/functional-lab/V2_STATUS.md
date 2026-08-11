# CMMS 2.0 Functional Lab — Estado canónico alineado

**Fecha:** 2026-08-11  
**Rama:** `feature/f01-premium-foundation`  
**Estado global:** modelo funcional corregido tras auditoría / `PASS_STATIC` de base / validación integrada en Studio pendiente

## 1. Cambio de modelo

La auditoría de las últimas reuniones detectó 14 desviaciones entre la v2 inicial y el modelo funcional realmente acordado.

La corrección no elimina `AnalysisCase`; cambia su papel.

El modelo canónico pasa a ser:

```text
BIBLIOTECA DE INGENIERÍA
FmeaDefinition
  └─ FmeaRevision
      ├─ funciones
      ├─ fallos funcionales
      ├─ modos
      ├─ causas / mecanismos
      ├─ efectos
      ├─ lógica RCM versionada
      └─ tareas propuestas
                ↓
CONTEXTO DE PLANTA
TechnicalObject + FLH + Taxonomía + ADR + AssetCriticalityAssessment
                ↓
APLICACIÓN
FmeaAssetApplication + perfil + variantes + overrides
                ↓
ANÁLISIS CONTEXTUAL
AnalysisCase + 28 etapas + riesgo AMEF + decisión RCM
                ↓
EJECUTABILIDAD
MaintenanceTask + intervalo + recursos + procedimiento opcional
                ↓
AGRUPACIÓN / HANDOFF
PlanScopeItem → JobPlan/Route → PM → WorkOrder → ExecutionResult
                ↓
MEJORA
coste real + efectividad + cambio de biblioteca/aplicación
```

P-101 es una aplicación contextual de `AMEF-BOMBA-CENTRIFUGA / R01`; ya no es propietario de la ingeniería AMEF reusable.

## 2. Las 14 observaciones de auditoría

| ID | Observación | Corrección canónica | Estado de modelo |
|---|---|---|---|
| D-01 | Falta biblioteca AMEF reutilizable | `FmeaDefinition` + `FmeaRevision` + pantallas Biblioteca/Revisión | CORREGIDO |
| D-02 | Riesgo AMEF confundido con criticidad del activo | `AssetCriticalityAssessment` separado; S×O = Matriz de riesgo AMEF | CORREGIDO |
| D-03 | Falta aplicación a múltiples activos | `FmeaAssetApplication` + `ApplicabilityMatrixPro` | CORREGIDO |
| D-04 | Falta perfil por criticidad/contexto | `MaintenanceApplicabilityProfile` + `TaskProfileVariant` | CORREGIDO |
| D-05 | Falta causa/mecanismo | `FailureCause` | CORREGIDO |
| D-06 | Falta N:M tarea ↔ modo | `ProposedTaskFailureMode` | CORREGIDO |
| D-07 | Procedimiento/checklist no modelado | `MaintenanceProcedure` + `TaskProcedureLink` opcional | CORREGIDO |
| D-08 | Estado operativo solo en paquete | restricciones pasan a `MaintenanceTask` | CORREGIDO |
| D-09 | Duración/H-H/carga insuficientes | duración, crew, H-H, disciplina y work center | CORREGIDO |
| D-10 | Economía mezclaba capas de coste | `EconomicAssessment` / `MaintenanceCostEstimate` / `ActualMaintenanceCost` | CORREGIDO |
| D-11 | Árbol RCM codificado | `DecisionLogic` + revisión + preguntas + transiciones + respuestas | CORREGIDO |
| D-12 | Alcance principal/soportes insuficiente | `PlanScopeItem` conserva `TechnicalObjectId` | CORREGIDO |
| D-13 | Handoff Job Plan / PM / WO poco preciso | contratos separados + `ExecutionResult` | CORREGIDO |
| D-14 | Falta optimización de planes/rutas | `MaintenanceCycle`, `RouteGroupingRule`, `ObjectList` | CORREGIDO |

`CORREGIDO` significa que el **modelo funcional, contratos, runtime de demostración y arquitectura de pantallas** ya lo contemplan. No significa que todas las nuevas piezas hayan superado Power Apps Studio.

## 3. Pantallas canónicas

### Inicio
- `scr_FL_Home`

### Activos
- `scr_FL_FLH`
- `scr_FL_Taxonomy`
- `scr_FL_ADR`
- `scr_FL_AssetCriticality`
- `scr_FL_Asset360`

### Estrategia — ingeniería reutilizable
- `scr_FL_FmeaLibrary`
- `scr_FL_FmeaRevision`
- `scr_FL_AssetApplication`

### Estrategia — aplicación / AnalysisCase
- `scr_FL_AnalysisRegister`
- `scr_FL_CaseOverview`
- `scr_FL_Context`
- `scr_FL_Functions`
- `scr_FL_FailureModes`
- `scr_FL_AMEF`
- `scr_FL_RCM`
- `scr_FL_Economics`
- `scr_FL_Task`
- `scr_FL_PlanPackage`
- `scr_FL_Traceability`
- `scr_FL_ReviewApproval`
- `scr_FL_Effectiveness`

### Handoff / producto
- `scr_FL_MaintenancePlans`
- `scr_FL_Governance`
- `scr_FL_Settings`

**Total: 25 pantallas canónicas.**

El antiguo `scr_FL_WorkspaceShell` queda únicamente como evidencia histórica y no forma parte del modelo actual.

## 4. Componentes canónicos

| Componente | Función | Estado |
|---|---|---|
| `cmp_FL_SidebarPro` | navegación global | INSTANCE_SAFE PASS |
| `cmp_FL_PageHeaderPro` | cabecera contextual | INSTANCE_SAFE PASS |
| `cmp_FL_TreePro` | FLH / Taxonomía / representación ADR | QA final pendiente |
| `cmp_FL_ProcessRailPro` | 28 etapas | PASS_STATIC / Studio pending |
| `cmp_FL_DecisionPanelPro` | recomendación vs decisión humana | PASS_STATIC / Studio pending |
| `cmp_FL_GatePanelPro` | control de avance explicable | PASS_STATIC / Studio pending |
| `cmp_FL_RiskMatrixPro` | matriz de riesgo configurable | PASS_STATIC / Studio pending |
| `cmp_FL_LineagePanelPro` | Biblioteca → Aplicación → Activo → ejecución | PASS_STATIC / Studio pending |
| `cmp_FL_ApplicabilityMatrixPro` | aplicación multi-activo/perfil | PASS_STATIC / Studio pending |

No se crea un componente nuevo para cada observación. Solo se extrae a componente lo que realmente es visual y reutilizable.

## 5. P-101 como caso de demostración

```text
FmeaDefinition        AMEF-BOMBA-CENTRIFUGA
FmeaRevision          R01 · aprobada / congelada
Application           APP-P101-R01
TechnicalObject       P-101
AssetCriticality      Alta · CRIT-P101-R03
ApplicabilityProfile  HIGH
AnalysisCase          P101-AMEF-RCM-001
```

La misma revisión R01 se demuestra aplicada también a P-102 y P-103, con perfiles e intervalos distintos sin duplicar la ingeniería base.

## 6. AMEF — separación corregida

```text
CRITICIDAD DEL ACTIVO
AssetCriticalityAssessment
→ dato contextual de planta

RIESGO DEL MODO DE FALLO
Severidad + Ocurrencia
→ Matriz de riesgo AMEF S×O

Detección
→ valor separado

S × O × D
→ NPR calculado
```

Para P-101 se conserva la escala usada en los prototipos:

```text
S 1..5
O 1..5
D 1..5
S=4, O=3, D=3
S×O=12
NPR=36
```

Los umbrales de color continúan siendo demostrativos y pendientes de decisión corporativa.

## 7. RCM — lógica versionada

La experiencia puede seguir mostrando preguntas sencillas, pero el contrato ya no presupone una secuencia rígida de campos.

```text
DecisionLogic
→ DecisionLogicRevision
→ DecisionQuestion
→ DecisionTransition
→ RcmAssessment
→ RcmAssessmentAnswer
```

El árbol concreto y su correspondencia corporativa siguen dentro de los asuntos pendientes de validar.

## 8. Tarea y ejecutabilidad

La pantalla de tarea debe poder distinguir:

```text
ProposedMaintenanceTask     biblioteca
TaskProfileVariant          ajuste por aplicación
MaintenanceTask             tarea ejecutable
MaintenanceProcedure        procedimiento/checklist opcional
ResourceRequirement         mano de obra/material/herramienta/servicio
IntervalJustification       intervalo confirmado
MaintenanceCostEstimate     coste derivado de tarea + frecuencia + recursos
```

Condiciones como parada, aislamiento o permiso pertenecen a la tarea y después se agregan al paquete.

## 9. Planes y agrupación

La agrupación nunca elimina identidad por tag.

```text
PlanScopeItem
→ RouteGroupingRule
→ ObjectList
→ JobPlan / Route
→ PreventiveMaintenancePlan
→ WorkOrder
→ ExecutionResult por TechnicalObject
→ ActualMaintenanceCost
```

Esto permite optimizar número de rutas/planes sin perder trazabilidad individual.

## 10. Runtime de demostración

El bootstrap ejecutable canónico está actualmente integrado en `scr_FL_Home.OnVisible` mediante `varFLAlignedInitialized`.

Carga:

- criticidad independiente para P-101/P-102/P-103;
- biblioteca AMEF de familias de equipo;
- revisiones;
- funciones/fallos/modos/causas/efectos;
- tareas propuestas y cobertura N:M;
- aplicaciones multi-activo;
- variantes por perfil;
- `AnalysisCase` contextual;
- 28 etapas y datos de demostración posteriores.

El archivo `power-apps/runtime/functional-lab-v2-bootstrap.powerfx` se conserva temporalmente como referencia histórica y **no debe utilizarse para reinstalar la versión alineada** hasta su sincronización final; la autoridad actual es `scr_FL_Home.OnVisible`.

## 11. Validación pendiente

La corrección funcional de las 14 observaciones está cerrada a nivel de modelo. El siguiente gate es técnico/visual:

```text
1 Foundation de 9 componentes
2 Home y bootstrap alineado
3 Activos: FLH / Taxonomía / ADR / Criticidad / 360
4 Biblioteca AMEF + Revisión
5 Aplicación multi-activo
6 AnalysisCase + Process Rail
7 Failure Modes + causas + decisión
8 AMEF + riesgo S/O/D + criticidad externa
9 RCM versionable
10 Task + procedimiento + recursos + H-H
11 Plan Package + alcance + agrupación
12 Maintenance Plans + Job Plan/PM/WO + trazabilidad por tag
13 Traceability / Review / Effectiveness
```

Hasta completar Studio:

```text
DEFINITION_ACCEPTED          pending para nuevas piezas
INSTANCE_SAFE                pending para nuevas piezas
PUBLIC_CONTRACT_VALIDATED    pending
VISUAL_QA_VALIDATED          pending
READY_FOR_INTEGRATION        no
```

## 12. Asuntos deliberadamente pendientes de decisión

No se han cerrado por inferencia:

- escalas AMEF corporativas definitivas;
- umbrales/bandas/colores de riesgo;
- árbol RCM corporativo definitivo;
- reglas P-F e intervalo;
- autoridades/permisos finales;
- evidencias mínimas y niveles de confianza;
- reglas de sobreclasificación;
- criterios de aprobación;
- KPIs y umbrales de efectividad;
- tecnología/sistema destino de integración;
- arquitectura física de base de datos.

Estos asuntos se decidirán después de validar la corrección de las 14 desviaciones.