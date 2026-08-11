# CMMS 2.0 Functional Lab — Arquitectura

**Estado:** Foundation v2 — library-first  
**Alcance:** arquitectura del laboratorio conceptual, no arquitectura productiva de CMMS 2.0.

## 1. Objetivo arquitectónico

Construir una aplicación Canvas Power Apps que permita ejecutar y discutir el modelo funcional de CMMS 2.0 sin acoplar el razonamiento de negocio a una base de datos, integración o tecnología productiva definitiva.

La arquitectura debe preservar explícitamente cuatro capas de dominio:

```text
Engineering Library
→ Asset Application
→ Execution Plan
→ Results & Learning
```

## 2. Capas del laboratorio

```text
┌────────────────────────────────────────────────┐
│ Functional Journey                             │
│ Etapas, decisiones, reglas, gates, outputs     │
└────────────────────────────────────────────────┘
                      ↓
┌────────────────────────────────────────────────┐
│ Canonical Fixtures v2                          │
│ Library + Application + Plan + Results         │
└────────────────────────────────────────────────┘
                      ↓
┌────────────────────────────────────────────────┐
│ Runtime Adapter                                │
│ Convierte contratos JSON en estado Power Fx    │
└────────────────────────────────────────────────┘
                      ↓
┌────────────────────────────────────────────────┐
│ Layered Functional State                       │
│ LibraryState                                   │
│ AssetApplicationState                          │
│ ExecutionPlanState                             │
│ ResultsState                                   │
│ + Decisions / Gates / Trace                    │
└────────────────────────────────────────────────┘
                      ↓
┌────────────────────────────────────────────────┐
│ Workspaces Power Apps                          │
│ Interacción y validación en reunión            │
└────────────────────────────────────────────────┘
                      ↓
┌────────────────────────────────────────────────┐
│ Functional Documentation                       │
│ Requisitos, reglas, datos, UI, roles, IT       │
└────────────────────────────────────────────────┘
```

## 3. Contratos canónicos

El fixture compuesto v2 utiliza contratos separados:

```text
case-fixture.schema.json
├─ fmea-library.schema.json
├─ fmea-asset-application.schema.json
├─ execution-plan.schema.json
└─ maintenance-results.schema.json
```

Esta separación es funcional, no técnica: obliga al laboratorio a saber qué capa es propietaria de cada dato y evita reconstruir el antiguo agregado asset-centric.

## 4. Decisión sobre JSON

Los archivos JSON son la fuente canónica de los casos de ejemplo del laboratorio.

Esto no implica que la aplicación productiva utilice JSON como persistencia.

El Runtime Adapter transformará el fixture compuesto en colecciones/estado Power Fx. El mecanismo concreto para introducir el texto JSON en la Canvas app debe ser sustituible.

Posibles adaptadores de laboratorio siguen siendo:

- cadena JSON controlada + `ParseJSON`;
- Power Fx generado desde el fixture;
- flow auxiliar de lectura;
- otra fuente temporal compatible con el entorno.

No se introducirá SQL, Dataverse o una API únicamente para cargar datos demostrativos.

## 5. Estado funcional runtime

El runtime no tendrá un único `ActiveCaseState` indiferenciado.

Conceptualmente:

```text
CaseFixtureV2
├─ LibraryState
├─ AssetApplicationState
├─ ExecutionPlanState
└─ ResultsState

+ UserChanges
+ SystemCalculations
+ SystemRecommendations
+ HumanDecisions
+ GateResults
+ TraceEvents
= FunctionalLabState
```

Cada cambio debe saber:

- capa;
- tipo de objeto;
- identificador;
- revisión/version cuando aplique;
- origen del dato;
- estado de validación.

## 6. Identidad de contexto

El contexto visible de la app no puede reducirse a “Activo P-101”.

El shell debe poder mostrar, según el workspace:

```text
Layer
Object type
Object ID / code
Revision
Status
Source revision / parent when applicable
Active asset only in Asset Application / Plan / Results
```

Ejemplo:

```text
ENGINEERING LIBRARY
FMEA-CWPUMP-001 · Rev 1 · Published
```

Y posteriormente:

```text
ASSET APPLICATION
P-101 · APP-P101-FMEAR1-001
Source: FMEA-CWPUMP-001 / Rev 1
```

## 7. Workspaces v2

```text
scr_FunctionalLab
└── conLab_Root
    ├── conLab_Navigation
    └── conLab_Content
        ├── conLab_Header
        ├── conLab_LayerContextStrip
        ├── conLab_WorkspaceHost
        │   ├── WS-01 Library & Revision
        │   ├── WS-02 Functions & Failure Structure
        │   ├── WS-03 Consequence & Risk
        │   ├── WS-04 RCM Decision
        │   ├── WS-05 Treatment Engineering
        │   ├── WS-06 Library Publication
        │   ├── WS-07 Asset Application
        │   ├── WS-08 Execution Plan
        │   └── WS-09 Results & Improvement
        └── conLab_OverlayLayer
```

Una etapa funcional no equivale automáticamente a una pantalla. La validación puede dividir o fusionar workspaces sin alterar el journey.

## 8. Responsabilidad por workspace

| Workspace | Puede editar | No debe editar |
|---|---|---|
| WS-01 | `FmeaDefinition`, revisión borrador, metadatos y evidencia de biblioteca | datos de P-101 o criticidad de activos |
| WS-02 | funciones, fallos, modos, causas, efectos de la revisión | contexto específico de un activo |
| WS-03 | consecuencias y riesgo AMEF | criticidad corporativa del activo |
| WS-04 | respuestas y decisión RCM | plan de ejecución específico de P-101 |
| WS-05 | tareas reusable, N:M, procedimiento/formato, economía/estimación | costes reales de ejecución |
| WS-06 | gobernanza y snapshot de biblioteca | modificar contenido de revisión ya publicada |
| WS-07 | aplicación a activo, contexto, criticidad, aplicabilidad y overrides | reescribir la revisión de biblioteca |
| WS-08 | intervalo efectivo, recursos, alcance, procedimiento/formato aplicados y plan | modificar la definición reusable de la tarea |
| WS-09 | resultados, coste real, efectividad y change request | sobrescribir hipótesis históricas |

## 9. Patrones funcionales comunes

### 9.1 Layer Context

Muestra:

- capa activa;
- objeto activo;
- código/ID;
- revisión;
- estado;
- objeto origen cuando aplique.

### 9.2 Information Available

Distingue información heredada de:

- biblioteca;
- activo/contexto;
- plan;
- resultados;
- fuentes externas.

### 9.3 User Work

Contiene inputs y decisiones humanas de la capa activa.

### 9.4 System

Muestra por separado:

- cálculo;
- versión de regla;
- recomendación;
- explicación.

### 9.5 Decision / Override

Cuando una persona modifica una recomendación o valor contextual debe conservarse:

```text
sourceValue / systemRecommendation
humanDecision
overrideReason
authorityRole
actor
timestamp
```

### 9.6 Gate

Indica:

- `passed`, `blocked` o `warning`;
- capa y objeto bloqueado;
- razones;
- datos o relaciones faltantes;
- regla/version;
- estado de validación de la regla;
- acción necesaria para desbloquear.

### 9.7 Output

Muestra el objeto estructurado disponible para el siguiente paso, incluyendo sus IDs de lineage.

## 10. Riesgo y criticidad en UI

La interfaz debe impedir una asociación visual incorrecta entre ambos conceptos.

### WS-03 — riesgo AMEF

Puede mostrar:

- modo de fallo;
- matriz/version de riesgo;
- S/O/D o dimensiones vigentes;
- indicador calculado;
- valoración humana;
- evidencia.

No mostrará esos valores bajo una etiqueta “criticidad del activo”.

### WS-07 — criticidad del activo

Puede mostrar:

- esquema/version;
- valor maestro recibido;
- fuente;
- snapshot;
- override autorizado.

Debe incluir una indicación explícita de que este valor no altera la revisión AMEF publicada.

## 11. Tarea, procedimiento y formato

WS-05 debe permitir comprender que:

```text
MaintenanceTask
├─ puede tratar N FailureModes
├─ puede tener MaintenanceProcedure? 
└─ puede tener InspectionFormat?
```

Un procedimiento describe cómo ejecutar; un formato describe qué registrar; la tarea describe qué mantenimiento se pretende realizar y para qué.

En WS-08 se selecciona la versión aplicable de esos objetos para el plan concreto sin modificar la tarea de biblioteca.

## 12. Economía por capas

Los workspaces deben mantener:

```text
WS-05
EconomicAssessment
MaintenanceCostEstimate

WS-09
ActualMaintenanceCost
```

Las comparaciones posteriores pueden mostrarlas juntas, pero nunca editarlas como un único registro.

## 13. Modelo de navegación

La navegación debe permitir:

- avanzar cuando el gate lo permita;
- retroceder sin perder estado local;
- saltar en modo presentación sin fingir que los gates previos están aprobados;
- volver al resumen de la capa/objeto activo;
- identificar visualmente etapas pendientes, bloqueadas, validadas y simuladas;
- reconocer el cambio de capa entre WS-06→WS-07 y WS-08→WS-09.

## 14. Estados obligatorios

Como mínimo:

```text
NoFixture
LoadingFixture
Loaded
Dirty
Calculating
Blocked
Warning
SaveLocalSuccess
ReadOnlyPublished
Error
```

Adicionalmente el runtime debe conocer el estado de cada agregado activo, no solo un estado global.

## 15. Trazabilidad runtime

Cada decisión o evento relevante debe conservar, cuando aplique:

```text
caseId
stageId
layer
objectType
objectId
sourceObjectId
fmeaDefinitionId
fmeaRevisionId
failureModeId
rcmAssessmentId
maintenanceTaskId
fmeaAssetApplicationId
executionPlanId
executionPlanTaskId
maintenanceResultId
ruleId
ruleVersion
inputSnapshot
systemResult
systemRecommendation
humanDecision
reason
actorRole
validationStatus
timestamp
```

No todos los campos aparecen en todos los eventos, pero los IDs necesarios deben permitir reconstruir la cadena completa.

## 16. Separación de reglas

Las fórmulas UI no deben ser la única definición de una regla funcional.

Cada regla relevante tendrá catálogo/contrato documental con:

- identificador;
- versión;
- descripción;
- inputs;
- resultado;
- estado de validación;
- fuente;
- excepciones.

Reglas demostrativas deben mostrarse como `to_validate` y no como política corporativa.

## 17. Estrategia incremental revisada

### Foundation v2

- remediación de las 14 desviaciones;
- modelo conceptual canónico;
- contratos v2 por capas;
- fixture P-101 v2;
- journey y matriz persona/sistema v2;
- arquitectura de workspaces y contratos de componentes.

### Vertical Slice 1 — WS-01 Library & Revision

Debe demostrar:

- carga del fixture v2;
- identificación de `FmeaDefinition`;
- selección/visualización de `FmeaRevision`;
- estado y condición de solo lectura de una publicada;
- evidencia y supuestos de biblioteca;
- gate de preparación;
- output estructurado hacia WS-02.

P-101 no es requisito visual de WS-01.

### Vertical slices posteriores

Un workspace funcional cada vez:

```text
responsabilidad funcional
→ contrato de datos
→ arquitectura de interacción
→ bloque pequeño
→ validación Studio
→ corrección
→ documentación
→ siguiente bloque
```

## 18. Decisiones explícitamente pendientes

No se decide todavía:

- backend productivo;
- base de datos;
- estrategia de ALM productiva;
- autenticación final;
- autorización final;
- integración con SAP/Maximo/Hexagon;
- mecanismo definitivo de persistencia;
- motor genérico de reglas;
- API final;
- generación real de Job Plans, PM o WO;
- matriz corporativa final de riesgo;
- esquema corporativo final de criticidad;
- árbol RCM corporativo final;
- fórmula económica corporativa final;
- workflow definitivo de aprobaciones.

Cualquier necesidad real de cerrar uno de estos puntos constituye un gate de arquitectura o validación y debe documentarse antes de implementar la capa afectada.
