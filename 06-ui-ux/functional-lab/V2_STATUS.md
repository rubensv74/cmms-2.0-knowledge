# CMMS 2.0 Functional Lab — Estado canónico alineado

**Fecha:** 2026-08-11  
**Rama:** `feature/f01-premium-foundation`  
**Estado global:** corrección funcional D-01…D-14 implementada / Home + Activos validados en Studio / Biblioteca AMEF pendiente

## 1. Modelo canónico

```text
BIBLIOTECA DE INGENIERÍA
FmeaDefinition → FmeaRevision
        ↓
CONTEXTO DE PLANTA
TechnicalObject + FLH + Taxonomía + ADR + AssetCriticalityAssessment
        ↓
APLICACIÓN
FmeaAssetApplication + perfil + variantes + overrides
        ↓
ANÁLISIS CONTEXTUAL
AnalysisCase + 28 etapas + AMEF + RCM
        ↓
EJECUTABILIDAD
MaintenanceTask + intervalo + recursos + procedimiento opcional
        ↓
HANDOFF
PlanScopeItem → JobPlan/Route → PM → WorkOrder → ExecutionResult
        ↓
MEJORA
coste real + efectividad + cambio de aplicación o biblioteca
```

P-101 es una aplicación de `AMEF-BOMBA-CENTRIFUGA / R01`, no propietario de la ingeniería AMEF.

## 2. Auditoría D-01…D-14

| ID | Corrección | Estado funcional |
|---|---|---|
| D-01 | Biblioteca `FmeaDefinition/FmeaRevision` | CORREGIDO |
| D-02 | Criticidad de activo separada de riesgo AMEF | CORREGIDO |
| D-03 | Aplicación multi-activo | CORREGIDO |
| D-04 | Perfiles/variantes por contexto | CORREGIDO |
| D-05 | `FailureCause` / mecanismo | CORREGIDO |
| D-06 | N:M tarea propuesta ↔ modo | CORREGIDO |
| D-07 | Procedimiento/checklist opcional | CORREGIDO |
| D-08 | Estado operativo/parada/aislamiento/permiso en tarea | CORREGIDO |
| D-09 | duración, crew, H-H, disciplina/work center | CORREGIDO |
| D-10 | economía preliminar / estimado / real separados | CORREGIDO |
| D-11 | lógica RCM versionable | CORREGIDO |
| D-12 | alcance físico por `TechnicalObject` | CORREGIDO |
| D-13 | Job Plan / PM / WO / resultado separados | CORREGIDO |
| D-14 | ciclos, reglas de agrupación y ObjectList | CORREGIDO |

`CORREGIDO` no significa automáticamente `INSTANCE_SAFE`: cada pieza debe comprobarse en Power Apps Studio.

## 3. Pantallas canónicas — 25

### Inicio
- `scr_FL_Home`

### Activos
- `scr_FL_FLH`
- `scr_FL_Taxonomy`
- `scr_FL_ADR`
- `scr_FL_AssetCriticality`
- `scr_FL_Asset360`

### Ingeniería reutilizable
- `scr_FL_FmeaLibrary`
- `scr_FL_FmeaRevision`
- `scr_FL_AssetApplication`

### AnalysisCase
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

`WorkspaceShell` queda únicamente como evidencia histórica.

## 4. Componentes canónicos — 9

```text
cmp_FL_SidebarPro
cmp_FL_PageHeaderPro
cmp_FL_TreePro
cmp_FL_ProcessRailPro
cmp_FL_DecisionPanelPro
cmp_FL_GatePanelPro
cmp_FL_RiskMatrixPro
cmp_FL_LineagePanelPro
cmp_FL_ApplicabilityMatrixPro
```

Estados:

```text
SidebarPro / PageHeaderPro        INSTANCE_SAFE PASS previo
TreePro                            runtime funcional dentro del smoke Activos PASS
ProcessRailPro                     import corregido / smoke de AnalysisCase pendiente
resto de componentes nuevos       PASS_STATIC / Studio pending
```

## 5. Fixture P-101

```text
FmeaDefinition        AMEF-BOMBA-CENTRIFUGA
FmeaRevision          R01
Application           APP-P101-R01
TechnicalObject       P-101
AssetCriticality      Alta · CRIT-P101-R03
Profile               HIGH
AnalysisCase          P101-AMEF-RCM-001
```

La misma revisión R01 se aplica también a P-102 y P-103 con perfiles/intervalos distintos sin duplicar la ingeniería.

## 6. AMEF

```text
AssetCriticalityAssessment  → contexto de planta
S × O                       → Matriz de riesgo AMEF
D                           → valor separado
S × O × D                   → NPR
```

Configuración demostrativa P-101:

```text
S=4/5
O=3/5
D=3/5
S×O=12
NPR=36
```

Los umbrales/bandas/colores siguen pendientes de decisión corporativa.

## 7. RCM

La experiencia consume un contrato versionable:

```text
DecisionLogic
→ DecisionLogicRevision
→ DecisionQuestion
→ DecisionTransition
→ RcmAssessment
→ RcmAssessmentAnswer
```

El árbol corporativo definitivo sigue abierto.

## 8. Tarea / coste / procedimiento

La experiencia distingue:

```text
ProposedMaintenanceTask
→ TaskProfileVariant
→ MaintenanceTask
→ MaintenanceProcedure? / Checklist?
→ ResourceRequirement
→ IntervalJustification
→ MaintenanceCostEstimate
```

`EconomicAssessment` es previo y `ActualMaintenanceCost` procede de ejecución.

## 9. Planes y ejecución

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

La agrupación nunca elimina trazabilidad por tag.

## 10. Bootstrap canónico

El bootstrap ejecutable está integrado en `scr_FL_Home.OnVisible` y protegido por `varFLAlignedInitialized`.

Referencia conceptual sincronizada:

`power-apps/runtime/functional-lab-aligned-bootstrap.powerfx`

El bootstrap pre-auditoría `functional-lab-v2-bootstrap.powerfx` ha sido **eliminado** para evitar reinstalar accidentalmente el modelo anterior.

### Evidencia Studio — 2026-08-11

```text
scr_FL_Home abre y ejecuta correctamente       PASS
bootstrap alineado carga sin bloqueo           PASS
navegación base visible                        PASS
FLH → Taxonomía → ADR                          PASS
Criticidad → Ficha 360                         PASS
P-101 estable durante recorrido                PASS
FLH como jerarquía padre-hijo                  PASS
ADR como relaciones no físicas                 PASS
criticidad separada del riesgo AMEF            PASS
```

Confirmaciones de usuario: `HOME OK` y `ACTIVOS OK`.

Esto valida el punto de entrada y el bloque de Activos, pero no implica todavía que todas las pantallas restantes sean `INSTANCE_SAFE`.

## 11. Próximo gate

Seguir `power-apps/V2_INSTALLATION.md`.

Estado del plan:

```text
1 Home / bootstrap                    PASS
2 Activos + criticidad                PASS
3 Biblioteca AMEF                     EN CURSO
4 Aplicación multi-activo             pendiente
5 AnalysisCase                        pendiente
6 Failure Modes / causas              pendiente
7 AMEF                                pendiente
8 RCM                                 pendiente
9 Task                                pendiente
10 Plan Package / Maintenance Plans   pendiente
11 Trazabilidad / revisión / efectividad pendiente
```

Próxima validación integrada:

```text
scr_FL_FmeaLibrary
→ scr_FL_FmeaRevision
```

Criterios de aceptación:

- la biblioteca muestra ingeniería AMEF por familia de equipo;
- la revisión R01 existe como fuente reutilizable;
- funciones y fallos funcionales aparecen en la revisión;
- modos, causas/mecanismos y efectos están visibles y diferenciados;
- las tareas propuestas pertenecen a la revisión, no a P-101;
- la cobertura N:M tarea ↔ modo se puede entender en pantalla;
- la revisión se presenta como ingeniería común que después se aplica a activos compatibles.

## 12. Asuntos deliberadamente abiertos

- escalas AMEF corporativas;
- umbrales/bandas/colores;
- reglas oficiales de criticidad;
- árbol RCM definitivo;
- reglas P–F / intervalo;
- autoridades/permisos finales;
- evidencia mínima/confianza;
- reglas de sobreclasificación;
- criterios de aprobación;
- KPIs/umbrales de efectividad;
- reglas definitivas de agrupación;
- sistema destino/integración;
- arquitectura física de datos.

No se cerrará ninguno por inferencia antes de la siguiente fase de decisiones.