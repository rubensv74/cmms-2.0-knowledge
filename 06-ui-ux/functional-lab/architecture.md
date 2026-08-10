# CMMS 2.0 Functional Lab — Arquitectura funcional alineada

**Estado:** arquitectura objetivo corregida tras auditoría  
**Fecha:** 2026-08-10  
**Ámbito:** laboratorio funcional ejecutable para validar el modelo CMMS 2.0.  
**Implementación actual:** Power Apps Canvas.  
**Backend objetivo de referencia:** contratos preparados para Azure SQL mediante adaptadores sustituibles.

## 1. Identidad y propósito

La aplicación mantiene la identidad **CMMS 2.0 Functional Lab**.

No es un mockup ni un navegador de prototipos. Su misión es demostrar y validar cómo debería funcionar el futuro CMMS desde la ingeniería de mantenimiento hasta la ejecución y la mejora continua.

La etiqueta `Functional Lab` deja claro que las escalas, umbrales, autoridades y reglas todavía pendientes de aprobación corporativa son hipótesis configurables, no configuración productiva definitiva.

## 2. Principio rector

> El CMMS no empieza creando tareas. Empieza reutilizando ingeniería de mantenimiento, la aplica a un activo concreto con su contexto de planta, convierte las decisiones en trabajo ejecutable y utiliza los resultados reales para mejorar la ingeniería.

La arquitectura queda organizada en cinco capas:

```text
BIBLIOTECA DE INGENIERÍA
        ↓
CONTEXTO DEL ACTIVO
        ↓
APLICACIÓN / ANALYSIS CASE
        ↓
PLANIFICACIÓN Y EJECUCIÓN
        ↓
RESULTADOS Y MEJORA
```

## 3. Biblioteca de ingeniería reutilizable

La ingeniería AMEF/RCM no pertenece inicialmente a P-101.

Se mantiene por tipo/familia de equipo:

```text
FmeaDefinition
  └─ FmeaRevision
      ├─ Function
      ├─ FunctionalFailure
      ├─ FailureMode
      ├─ FailureCause
      ├─ FailureEffect
      ├─ ProposedMaintenanceTask
      ├─ ProposedTaskFailureMode
      └─ DecisionLogic / RCM reference
```

Ejemplo del laboratorio:

```text
AMEF-BOMBA-CENTRIFUGA
Revision R01
```

P-101 y P-102 pueden reutilizar esta misma revisión sin duplicar su ingeniería base.

Una nueva revisión de biblioteca no modifica silenciosamente aplicaciones ya aprobadas. La adopción de la nueva revisión requiere revisión controlada.

## 4. Contexto del activo

El activo mantiene su identidad individual y sus datos maestros:

```text
TechnicalObject
AssetHierarchyNode / FLH
AssetClassification / Taxonomía
ADRRelation
AssetCriticalityAssessment
```

FLH responde principalmente **dónde está** el activo.

Taxonomía responde **qué clase de activo es**.

ADR describe **con qué otros objetos se relaciona o depende**.

La criticidad de activo responde **qué importancia tiene ese activo en su posición y servicio concretos**.

### 4.1 Criticidad del activo ≠ riesgo AMEF

Se mantienen separados:

```text
AssetCriticalityAssessment
→ riesgo/criticidad del activo dentro de la planta

RiskAssessment
→ riesgo de un modo de fallo dentro del AMEF aplicado
```

La matriz S×O de AMEF nunca se denomina `criticidad del activo`.

La criticidad de planta puede modificar aplicabilidad, prioridad, frecuencia o estrategia, pero no sustituye al análisis AMEF.

## 5. Aplicación de biblioteca a activos

La unión entre ingeniería reutilizable y activo concreto se representa mediante:

```text
FmeaAssetApplication
```

Una aplicación referencia:

```text
TechnicalObjectId
FmeaRevisionId
AssetCriticalityAssessmentId
ApplicabilityProfile
ContextStatus
```

Puede contener:

```text
FmeaApplicabilityRule
TaskProfileVariant
ContextOverride
Evidence
HumanDecision
```

El objetivo es poder expresar:

```text
Bomba centrífuga / R01
     ├─ P-101 · criticidad alta · servicio continuo
     ├─ P-102 · criticidad media · reserva automática
     └─ P-103 · criticidad baja · contexto distinto
```

sin clonar la biblioteca AMEF completa para cada tag.

## 6. AnalysisCase

`AnalysisCase` deja de ser propietario de la ingeniería base.

Su función es organizar una **revisión contextual y gobernada** de una aplicación concreta.

```text
AnalysisCase
├── TechnicalObject reference
├── FmeaRevision reference
├── FmeaAssetApplication reference
├── AssetCriticalityAssessment reference
├── Context snapshot
├── Stage executions
├── Evidence local
├── Risk assessments contextuales
├── RCM answers / decisions
├── Task variants
├── Economic assessments
├── Reviews / approvals
├── Version snapshots
└── Effectiveness / change requests
```

P-101 continúa siendo el caso de demostración, pero ya no es la fuente de verdad de funciones, modos y efectos genéricos.

## 7. Journey de 28 etapas

Las 28 etapas siguen siendo el recorrido metodológico del `AnalysisCase`.

```text
Fase 1 · Comprender aplicación y contexto      FL-01 … FL-06
Fase 2 · Evaluar efectos y riesgo AMEF         FL-07 … FL-11
Fase 3 · Tomar la decisión RCM                 FL-12 … FL-16
Fase 4 · Convertir en trabajo ejecutable       FL-17 … FL-22
Fase 5 · Gobernar, medir y mejorar             FL-23 … FL-28
```

Las primeras etapas no crean de nuevo la biblioteca: verifican su aplicabilidad, contexto y posibles overrides para el activo seleccionado.

## 8. Navegación de producto

Sidebar global:

```text
Inicio
Activos
Estrategia de mantenimiento
Planes de mantenimiento
Gobernanza
Configuración
```

Dentro de **Estrategia de mantenimiento** aparecen tres conceptos distintos:

```text
Biblioteca AMEF
Aplicaciones a activos
Casos de análisis
```

## 9. Mapa de pantallas

```text
CMMS 2.0 Functional Lab
│
├── Inicio
│   └── scr_FL_Home
│
├── Activos
│   ├── scr_FL_FLH
│   ├── scr_FL_Taxonomy
│   ├── scr_FL_ADR
│   ├── scr_FL_AssetCriticality
│   └── scr_FL_Asset360
│
├── Estrategia de mantenimiento
│   ├── scr_FL_FmeaLibrary
│   ├── scr_FL_FmeaRevision
│   ├── scr_FL_AssetApplication
│   ├── scr_FL_AnalysisRegister
│   ├── scr_FL_CaseOverview
│   ├── scr_FL_Context
│   ├── scr_FL_Functions
│   ├── scr_FL_FailureModes
│   ├── scr_FL_AMEF
│   ├── scr_FL_RCM
│   ├── scr_FL_Economics
│   ├── scr_FL_Task
│   ├── scr_FL_PlanPackage
│   ├── scr_FL_Traceability
│   ├── scr_FL_ReviewApproval
│   └── scr_FL_Effectiveness
│
├── Planes de mantenimiento
│   └── scr_FL_MaintenancePlans
│
├── Gobernanza
│   └── scr_FL_Governance
│
└── Configuración
    └── scr_FL_Settings
```

**Total objetivo tras la corrección: 25 pantallas canónicas.**

## 10. Funciones, fallos, modos, causas y efectos

Cadena de ingeniería:

```text
Function
   ↓
FunctionalFailure
   ↓
FailureMode
   ↓
FailureCause
   ↓
FailureEffect
```

La UI debe mantener visibles las diferencias:

- función: qué debe hacer el activo y con qué estándar;
- fallo funcional: de qué forma deja de cumplir esa función;
- modo de fallo: qué fenómeno/fallo observable explica la pérdida;
- causa/mecanismo: por qué o mediante qué mecanismo se produce;
- efecto: qué ocurre localmente, en el sistema y en operación.

## 11. AMEF y riesgo

Para P-101 el laboratorio utiliza actualmente:

```text
Severidad   1..5
Ocurrencia  1..5
Detección   1..5
Matriz S×O  5×5
NPR         S×O×D
```

La pantalla se denomina **Matriz de riesgo AMEF**.

La criticidad del activo aparece separada como input contextual.

Las escalas y bandas permanecen configurables y pendientes de validación corporativa.

## 12. RCM como lógica versionable

La experiencia RCM se apoya en un contrato configurable:

```text
DecisionLogic
DecisionLogicRevision
DecisionQuestion
DecisionTransition
RcmAssessment
RcmAssessmentAnswer
```

La pantalla puede seguir mostrando preguntas como fallo evidente, degradación detectable y ventana P–F, pero esas preguntas no quedan codificadas como arquitectura irreversible.

La lógica corporativa concreta sigue pendiente de validación.

## 13. Tareas y cobertura de modos

La ingeniería genera tareas propuestas:

```text
ProposedMaintenanceTask
```

La cobertura es muchos-a-muchos:

```text
ProposedMaintenanceTask
        ↕
ProposedTaskFailureMode
        ↕
FailureMode
```

Un modo puede necesitar varias tareas y una tarea puede cubrir varios modos.

Al aplicar la biblioteca a un activo puede crearse un `TaskProfileVariant` que modifique frecuencia, aplicabilidad o condiciones sin alterar la definición base.

## 14. Tarea ejecutable

`MaintenanceTask` debe conservar como mínimo:

```text
Name
TaskType
Technique
AcceptanceCriterion
ActionIfFailed
RequiredOperatingState
RequiresShutdown
IsolationRequirement
PermitRequirement
EstimatedDuration
CrewSize
EstimatedManHours
Discipline / WorkCenter
```

## 15. Procedimiento opcional

Tarea y procedimiento son conceptos distintos.

```text
MaintenanceTask
      ↓ opcional
TaskProcedureLink
      ↓
MaintenanceProcedure / InspectionFormat
```

Una inspección sencilla puede ejecutarse sin un procedimiento formal. Otra tarea puede requerir checklist o procedimiento detallado.

## 16. Economía y costes

Se separan tres niveles:

```text
EconomicAssessment
→ comparación previa de alternativas RCM

MaintenanceCostEstimate
→ coste planificado derivado de tarea + frecuencia + recursos + H-H

ActualMaintenanceCost
→ coste real procedente de ejecución
```

La opción económicamente más barata nunca reactiva una estrategia descartada por inviabilidad técnica o seguridad.

## 17. Alcance y agrupación de planes

Un paquete puede abarcar equipo principal y objetos de soporte manteniendo identidad individual:

```text
MaintenancePlanPackage
  └─ PlanScopeItem
       ├─ TechnicalObjectId
       ├─ RoleInScope
       └─ Task / variant reference
```

La optimización se apoya en:

```text
MaintenanceCycle
RouteGroupingRule
ObjectList
JobPlan / Route
```

Agrupar no significa perder trazabilidad por tag.

## 18. Handoff hacia ejecución

Modelo conceptual:

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
```

El Functional Lab demuestra estas fronteras sin decidir todavía SAP, Maximo, Hexagon u otro destino.

## 19. Resultados y mejora continua

Los datos reales regresan a ingeniería mediante:

```text
ExecutionResult
EffectivenessMeasurement
ChangeRequest
```

El sistema puede identificar desviaciones entre hipótesis y realidad. La decisión de mantener, ajustar o reabrir una revisión con impacto técnico sigue siendo humana mientras no exista una automatización aprobada.

## 20. Datos maestros vs datos de ingeniería y aplicación

```text
DATOS MAESTROS
TechnicalObject / FLH / Taxonomy / ADR

INGENIERÍA REUTILIZABLE
FmeaDefinition / FmeaRevision / DecisionLogic

CONTEXTO DE PLANTA
AssetCriticalityAssessment

APLICACIÓN
FmeaAssetApplication / AnalysisCase / TaskProfileVariant

EJECUCIÓN
JobPlan / PM / WO / ExecutionResult
```

Un análisis contextual no modifica silenciosamente ninguna de las capas anteriores.

## 21. Persona, sistema y autoridad

Toda pantalla sigue diferenciando:

```text
existing_input
user_input
system_calculation
system_recommendation
human_decision
gate
output
```

Una recomendación del sistema nunca se convierte silenciosamente en decisión humana.

## 22. Persistencia y borradores

```text
cambio ordinario → borrador

decisión con autoridad → Confirmar / Aprobar
```

Una versión aprobada de biblioteca o aplicación debe poder congelarse como snapshot y conservar trazabilidad de la revisión utilizada.

## 23. Componentes premium

Foundation:

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

`LineagePanelPro` hace visible la cadena Biblioteca → Aplicación → Plan → Ejecución.

`ApplicabilityMatrixPro` representa la aplicación de una revisión AMEF a múltiples activos/perfiles.

Las reglas de negocio permanecen en host/runtime, no dentro de los componentes visuales.

## 24. Backend y adaptadores

```text
Power Apps UI
    ↓
Application / Adapter boundary
    ↓
Conceptual contracts
    ↓
Azure SQL / API / otra implementación futura
```

El laboratorio usa colecciones y variables como adapter temporal.

## 25. Elementos todavía pendientes de validación corporativa

No se fijan como arquitectura irreversible:

- escala AMEF corporativa definitiva;
- umbrales/colores de riesgo;
- árbol RCM corporativo y correspondencia exacta con SAE JA1011/JA1012;
- reglas definitivas P–F;
- autoridades finales;
- mínimo de evidencias/confianza;
- reglas de sobreclasificación;
- criterios de aprobación;
- KPIs y umbrales de efectividad;
- sistema CMMS destino;
- arquitectura física de base de datos.

## 26. Criterio de autenticidad

Una pantalla es válida si deja claro:

1. qué objeto está viendo el usuario;
2. si pertenece a biblioteca, contexto, aplicación o ejecución;
3. qué información se hereda;
4. qué puede modificarse localmente;
5. qué calcula/recomienda el sistema;
6. qué decide una persona;
7. qué condición controla el avance;
8. qué objeto queda preparado para el siguiente paso;
9. cómo se conserva la trazabilidad hasta ejecución y retorno de resultados.
