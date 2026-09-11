# CMMS 2.0 Functional Lab — Arquitectura

**Estado:** Foundation revisada 2026-09-11  
**Alcance:** arquitectura del laboratorio conceptual, no arquitectura productiva de CMMS 2.0.  
**Fuentes principales:**  
- [`../../05-meetings/2026/2026-08-14_revision-modelo-conceptual-amef-rcm.md`](../../05-meetings/2026/2026-08-14_revision-modelo-conceptual-amef-rcm.md)  
- [`../../05-meetings/2026/2026-09-11_revision-cmms-estandares-job-plans.md`](../../05-meetings/2026/2026-09-11_revision-cmms-estandares-job-plans.md)

## 1. Objetivo arquitectónico

Construir una aplicación Canvas Power Apps que permita ejecutar casos funcionales de CMMS 2.0 sin acoplar el razonamiento de negocio a una base de datos, integración o tecnología productiva definitiva.

La foundation debe soportar:

- configuración funcional;
- decisiones humanas y recomendaciones;
- RCM específico;
- estándares corporativos de mantenimiento;
- applicability/overrides;
- trazabilidad de origen y versiones;
- handoff hacia Gestión del Trabajo.

## 2. Capas

```text
┌───────────────────────────────────────────────┐
│ Maintenance Engineering Sources               │
│ RCM | Corporate Standard | OEM | Expert       │
└───────────────────────────────────────────────┘
                     ↓
┌───────────────────────────────────────────────┐
│ Functional Journey + Configuration            │
│ etapas, reglas, risk profiles, gates          │
└───────────────────────────────────────────────┘
                     ↓
┌───────────────────────────────────────────────┐
│ Maintenance Standards Library                 │
│ equipment type, versions, tasks, job plans    │
└───────────────────────────────────────────────┘
                     ↓
┌───────────────────────────────────────────────┐
│ Canonical Fixtures                            │
│ P-101 RCM + futuros casos normalizados        │
└───────────────────────────────────────────────┘
                     ↓
┌───────────────────────────────────────────────┐
│ Runtime Adapter                               │
│ fixture/config/standard → Power Fx state      │
└───────────────────────────────────────────────┘
                     ↓
┌───────────────────────────────────────────────┐
│ Functional State                              │
│ case + source + decisions + overrides         │
└───────────────────────────────────────────────┘
                     ↓
┌───────────────────────────────────────────────┐
│ Power Apps Workspaces / Surfaces              │
│ interacción y validación en reunión           │
└───────────────────────────────────────────────┘
                     ↓
┌───────────────────────────────────────────────┐
│ Functional Documentation                     │
│ requisitos, reglas, datos, roles, IT          │
└───────────────────────────────────────────────┘
```

## 3. Decisión sobre JSON

Los fixtures JSON siguen siendo la fuente canónica de los casos de demo. Esto no implica persistencia JSON productiva.

El Runtime Adapter debe poder transformar:

```text
CaseFixture
ConfigurationProfile
MaintenanceStandardFixture
```

en colecciones/estado Power Fx.

No se introducirá SQL, Dataverse o API solo para resolver datasets de laboratorio.

## 4. Configuration Profiles

La UI no debe hardcodear reglas como matriz 5×5.

```text
ConfigurationProfile
├── RiskProfile
└── Future configurable rule sets
```

La estructura definitiva de `RiskProfile` continúa gobernada por su gate funcional.

## 5. Maintenance Standards Library

La revisión 2026-09-11 añade una fuente funcional explícita:

```text
MaintenanceStandardLibrary
├── EquipmentTypeStandard
├── StandardPlanVersion
├── StandardMaintenanceActivity
├── JobPlan
├── ProcedureChecklist
├── ResourceRequirements
└── SourceReference
```

El laboratorio debe poder demostrar más adelante:

```text
Corporate Standard
→ Project Adoption Snapshot
→ Project Overrides
→ Published Project Plan
```

No debe inventarse un fixture de biblioteca antes de `MSL-G01 Source normalization`.

## 6. Estado funcional

Conceptualmente:

```text
CaseFixture
+ ConfigurationProfile
+ MaintenanceSource
+ CorporateStandardVersion
+ UserChanges
+ SystemCalculations
+ SystemRecommendations
+ HumanDecisions
+ ApplicabilityDecisions
+ ProjectOverrides
+ GateResults
= ActiveCaseState
```

### 6.1. Supuestos prohibidos en Foundation

No introducir:

- matriz 5×5 hardcodeada;
- scoring RCM;
- relación plan 1:1 rígida con activo;
- aplicación automática de estándares a todos los activos;
- mutación del master al editar un proyecto;
- supuesto de que toda tarea procede de RCM;
- cada checklist step como actividad CMMS;
- publicación como final absoluto del ciclo.

## 7. Workspaces RCM v1.2

El caso P-101 mantiene nueve workspaces:

```text
scr_FunctionalLab
└── conLab_Root
    ├── conLab_Navigation
    └── conLab_Content
        ├── conLab_Header
        ├── conLab_ContextStrip
        ├── conLab_WorkspaceHost
        │   ├── WS-01 Caso y contexto
        │   ├── WS-02 Funciones y fallos
        │   ├── WS-03 Efectos y riesgo configurable
        │   ├── WS-04 Árbol de decisión RCM
        │   ├── WS-05 Economía y actividad
        │   ├── WS-06 Recursos, Job Plan, aplicabilidad y variantes
        │   ├── WS-07 Trazabilidad y calidad
        │   ├── WS-08 Revisión, publicación y handoff
        │   └── WS-09 Efectividad y mejora
        └── conLab_OverlayLayer
```

La Maintenance Standards Library no se añade automáticamente como WS-10. Probablemente necesite una superficie tipo `Configuration Studio / Library Explorer`, pero queda `to_validate`.

## 8. Comportamientos funcionales

### 8.1. Riesgo configurable

WS-03 consume `RiskProfile` y renderiza configuración/version.

### 8.2. RCM sin scoring

WS-04 conserva:

```text
question
→ answer
→ evidence
→ branch
→ feasibility/effectiveness
→ resulting policy
→ human confirmation
```

AMEF/FMEA debe mostrarse como parte del análisis RCM.

### 8.3. P–F

Cuando aplique, la demo debe explicar:

```text
P = detectable potential failure
F = functional failure threshold
```

F no equivale necesariamente a rotura física.

### 8.4. Source Basis

WS-05/06 debe poder distinguir:

```text
RCM
CORPORATE_STANDARD
OEM
EXPERT
```

Cada actividad necesita provenance.

### 8.5. Activity vs Job Plan vs Checklist

La UI debe mantener tres niveles:

```text
Maintenance Activity        → unidad gestionable
Job Plan                    → template reusable
Procedure / Checklist       → pasos detallados
```

Los pasos del checklist no aparecen por defecto como filas/tareas planificables independientes.

### 8.6. Plan genérico y applicability

WS-06 debe separar:

```text
BasePlan / StandardVersion
CandidateAssets
ApplicabilityDecision
Project / Asset Override
```

### 8.7. Project tailoring

Cuando exista caso de estándar, la UX debe permitir comparar:

```text
Master baseline
↔
Project version
```

y mostrar actividades `unchanged / disabled / modified / added`.

### 8.8. Agrupación

Puede demostrarse conceptualmente, pero la regla de duración/HH multidisciplina sigue `to_validate`.

### 8.9. Handoff post-publicación

```text
PublishedProjectPlanVersion
+ PlanningYear
+ BudgetContext
+ CostCenterContext
→ PrepareAnnualPreventiveOrders
→ Work Management discovery
```

## 9. Paneles comunes

Cada workspace/superficie debe poder mostrar:

- contexto;
- información existente;
- source/provenance;
- trabajo del usuario;
- cálculo/recomendación del sistema;
- gate;
- output;
- version/configuración activa.

## 10. Navegación

Debe permitir:

- avanzar cuando gate lo permita;
- retroceder;
- modo presentación sin fingir aprobación;
- volver al resumen;
- identificar pending/blocked/validated/simulated;
- diferenciar RCM route y standard-adoption route;
- distinguir procesos validados de discovery.

## 11. Estados mínimos

```text
NoCase
LoadingCase
Loaded
Dirty
Calculating
Blocked
Warning
SaveLocalSuccess
Error
```

Una futura library surface necesitará además estados de version/adoption, pero no se incorporan a runtime hasta contrato.

## 12. Trazabilidad runtime

Cada decisión debe conservar cuando aplique:

```text
caseId
stageId
ruleId
configurationProfileId
sourceBasis
sourceReference
sourceVersion
corporateStandardVersion
projectAdoptionVersion
inputSnapshot
systemResult
systemRecommendation
humanDecision
reason
actorRole
validationStatus
timestamp
```

Para overrides:

```text
basePlanVersion
assetId / equipmentTypeCode
overrideType
baseTaskId
```

## 13. Separación de reglas

Las fórmulas de UI no son la definición única de una regla.

Cada regla relevante debe tener contrato documental con:

- identificador;
- descripción;
- inputs;
- resultado;
- estado de validación;
- fuente/provenance;
- excepciones;
- configuración aplicable.

## 14. Estrategia incremental

### RCM Foundation

Se mantiene la secuencia F01 actual para WS-01/P-101.

### Maintenance Standards Extension

No implementar antes de:

```text
MSL-G01 Source normalization
→ MSL-G02 Core contracts
→ UX surface decision
→ versioned real fixture
→ Studio gate
```

Documento específico:

- [`maintenance-standards-extension.md`](maintenance-standards-extension.md)

## 15. Extensión Work Management

Gestión del Trabajo consume una actividad resumida y referencias al paquete de ejecución.

```text
Scheduled Maintenance Activity
→ Work Candidate / WO
   └── JobPlan / ProcedureChecklist
```

Planning/scheduling, execution y costes continúan gobernados por `work-management-discovery.md`.

## 16. Decisiones todavía pendientes

No se decide todavía:

- backend productivo;
- persistencia productiva;
- API final;
- motor de reglas;
- contrato físico de Maintenance Standards Library;
- frontera definitiva JobPlan vs ProcedureChecklist;
- workflow corporativo de publicación de estándares;
- roles finales Planner/Scheduler/Programmer;
- reglas productivas de planning/scheduling;
- costes/facturación.

Cerrar cualquiera de estos puntos requiere su gate funcional/arquitectónico correspondiente.
