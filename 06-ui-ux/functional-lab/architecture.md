# CMMS 2.0 Functional Lab — Arquitectura

**Estado:** Foundation revisada 2026-08-14  
**Alcance:** arquitectura del laboratorio conceptual, no arquitectura productiva de CMMS 2.0.  
**Fuente de revisión:** [`../../05-meetings/2026/2026-08-14_revision-modelo-conceptual-amef-rcm.md`](../../05-meetings/2026/2026-08-14_revision-modelo-conceptual-amef-rcm.md)

## 1. Objetivo arquitectónico

Construir una aplicación Canvas Power Apps que permita ejecutar casos funcionales de CMMS 2.0 sin acoplar el razonamiento de negocio a una base de datos, integración o tecnología productiva definitiva.

La foundation debe soportar desde el principio reglas configurables, recomendaciones del sistema, decisiones humanas, aplicabilidad a varios activos y excepciones por activo, aunque esas capacidades se implementen de forma incremental.

## 2. Capas

```text
┌───────────────────────────────────────────────┐
│  Functional Journey                          │
│  Etapas, decisiones, reglas, gates, outputs  │
└───────────────────────────────────────────────┘
                     ↓
┌───────────────────────────────────────────────┐
│  Configuration Profiles                      │
│  Riesgo, escalas, reglas y criterios          │
└───────────────────────────────────────────────┘
                     ↓
┌───────────────────────────────────────────────┐
│  Canonical Case Fixtures                     │
│  JSON versionado: P-101 y casos futuros      │
└───────────────────────────────────────────────┘
                     ↓
┌───────────────────────────────────────────────┐
│  Runtime Adapter                             │
│  Convierte fixture/config en Power Fx        │
└───────────────────────────────────────────────┘
                     ↓
┌───────────────────────────────────────────────┐
│  Functional State                            │
│  Caso + decisiones + aplicabilidad + outputs │
└───────────────────────────────────────────────┘
                     ↓
┌───────────────────────────────────────────────┐
│  Workspaces Power Apps                       │
│  Interacción y validación en reunión         │
└───────────────────────────────────────────────┘
                     ↓
┌───────────────────────────────────────────────┐
│  Functional Documentation                    │
│  Requisitos, reglas, datos, UI, roles, IT    │
└───────────────────────────────────────────────┘
```

## 3. Decisión sobre JSON

Los archivos JSON son la fuente canónica de los casos de ejemplo.

Esto no implica que la aplicación productiva vaya a utilizar JSON como persistencia.

Power Fx dispone de `ParseJSON` para convertir texto JSON en valores dinámicos o tipados. En el Functional Lab se utilizará un **Runtime Adapter** para transformar el fixture canónico a las colecciones que necesite la app.

El mecanismo concreto de entrada del texto JSON al runtime se decidirá durante los primeros incrementos y deberá ser sustituible. Posibles adaptadores de laboratorio:

- cadena JSON controlada + `ParseJSON`;
- Power Fx generado desde el fixture;
- flow auxiliar de lectura;
- otra fuente temporal compatible con el entorno.

No se introducirá SQL, Dataverse o una API solo para resolver el dataset de demostración.

## 4. Configuración funcional

La reunión del 2026-08-14 obliga a separar **configuración** y **caso**.

Ejemplo principal: la matriz de riesgo no puede estar codificada en la UI como 5×5.

Conceptualmente:

```text
ConfigurationProfile
├── RiskProfile
│   ├── dimensions
│   ├── levels
│   ├── ranges
│   ├── thresholds
│   └── overrideRules
└── Future configurable rule sets
```

P-101 puede utilizar una matriz 5×5 como fixture de demostración, pero la pantalla debe renderizarla desde el perfil activo.

La estructura definitiva del `RiskProfile` sigue `to_validate`; lo validado es la obligación de que sea configurable y versionable.

## 5. Estado funcional

El estado runtime se separará del dato canónico.

Conceptualmente:

```text
CaseFixture
+ ConfigurationProfile
+ UserChanges
+ SystemCalculations
+ SystemRecommendations
+ HumanDecisions
+ ApplicabilityDecisions
+ AssetPlanOverrides
+ GateResults
= ActiveCaseState
```

La app deberá distinguir qué parte procede de cada origen.

### 5.1. Consecuencias para Foundation

Desde F01 no deben introducirse supuestos que después resulten difíciles de desmontar:

- matriz 5×5 hardcodeada;
- scoring RCM;
- plan asociado exclusivamente a un único activo;
- aplicación automática de planes a activos similares;
- modificación del plan genérico al editar una excepción de activo;
- publicación tratada como final absoluto del ciclo funcional.

## 6. Workspaces v1.1

La arquitectura mantiene nueve workspaces funcionales:

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
        │   ├── WS-05 Economía y tarea
        │   ├── WS-06 Recursos, aplicabilidad y variantes
        │   ├── WS-07 Trazabilidad y calidad
        │   ├── WS-08 Revisión, publicación y handoff
        │   └── WS-09 Efectividad y mejora
        └── conLab_OverlayLayer
```

Esta estructura es una hipótesis inicial. La validación funcional puede demostrar que un workspace debe dividirse o fusionarse.

## 7. Comportamientos funcionales que la arquitectura debe permitir

### 7.1. Riesgo configurable

WS-03 debe poder recibir un `RiskProfile` y renderizar:

- dimensiones configuradas;
- niveles;
- rangos;
- posición de riesgo;
- reglas de sobreclasificación;
- versión del perfil utilizado.

La UI no define esas reglas.

### 7.2. RCM sin scoring

WS-04 debe almacenar y mostrar un recorrido reproducible:

```text
question
→ answer
→ explanation/evidence
→ branch
→ feasibility/effectiveness criteria
→ resulting policy
→ human confirmation
```

No existirá un score RCM acumulado salvo que un cliente disponga en el futuro de otra metodología explícitamente configurada y validada; no forma parte del modelo RCM actual.

### 7.3. Plan genérico y aplicabilidad

WS-06 debe separar:

```text
BasePlan
CandidateAssets
ApplicabilityDecision
AssetPlanOverride
```

- `CandidateAssets`: sugerencia del sistema a partir de taxonomía/equivalencia.
- `ApplicabilityDecision`: decisión humana.
- `AssetPlanOverride`: alta/baja/modificación específica que no muta `BasePlan`.

### 7.4. Agrupación de tareas

El laboratorio debe poder mostrar que actividades compatibles por activo/frecuencia pueden agruparse en un paquete de ejecución.

La regla exacta para calcular duración y horas-hombre entre distintas disciplinas permanece `to_validate`; por tanto la arquitectura debe permitir parametrizar esa lógica y no enterrarla en fórmulas de pantalla.

### 7.5. Handoff después de publicación

WS-08 debe terminar con un output conceptual:

```text
PublishedPlanVersion
+ PlanningYear
+ BudgetContext
+ CostCenterContext
→ explicit action: PrepareAnnualPreventiveOrders
```

El Functional Lab no generará órdenes reales en la primera versión. Debe mostrar la frontera y explicar que el proceso operacional posterior está pendiente de validación.

## 8. Paneles comunes

Cada workspace debe poder reutilizar los siguientes patrones conceptuales:

### 8.1. Contexto

Muestra:

- activo;
- servicio;
- fase;
- etapa actual;
- estado de completitud;
- nivel de confianza cuando aplique;
- perfil/configuración activa cuando afecte al resultado.

### 8.2. Información disponible

Distingue los datos que deberían venir ya informados desde otros módulos o fuentes.

### 8.3. Trabajo del usuario

Contiene los inputs y decisiones de la persona.

### 8.4. Sistema

Muestra por separado:

- cálculo;
- recomendación;
- explicación.

### 8.5. Gate

Indica:

- estado `passed`, `blocked` o `warning`;
- razones;
- datos faltantes;
- acción necesaria para desbloquear.

### 8.6. Output

Muestra qué objeto o decisión estructurada queda disponible para el siguiente paso o proceso.

## 9. Modelo de navegación

La navegación debe permitir:

- avanzar cuando el gate lo permita;
- retroceder siempre;
- saltar en modo presentación sin fingir que los gates previos están aprobados;
- volver al resumen del caso;
- identificar visualmente etapas pendientes, bloqueadas, validadas y simuladas;
- distinguir un proceso validado de un handoff hacia un dominio todavía `to_validate`.

## 10. Estados obligatorios

Como mínimo:

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

La primera versión puede no tener persistencia remota, pero debe diferenciar claramente estado local y cualquier futura persistencia.

## 11. Trazabilidad runtime

Cada decisión registrada debe conservar, cuando aplique:

```text
caseId
stageId
ruleId
configurationProfileId
inputSnapshot
systemResult
systemRecommendation
humanDecision
reason
actorRole
validationStatus
timestamp
```

Para aplicabilidad/overrides debe poder añadirse:

```text
basePlanVersion
assetId
overrideType
baseTaskId
```

En la fase conceptual el actor puede representarse por rol o usuario de demostración; no se considera todavía un modelo definitivo de identidad.

## 12. Separación de reglas

Las fórmulas de UI no deben convertirse en la única definición de una regla funcional.

Cada regla relevante deberá existir también en un catálogo o contrato documental con:

- identificador;
- descripción;
- inputs;
- resultado;
- estado de validación;
- fuente;
- excepciones;
- perfil/configuración aplicable cuando proceda.

## 13. Estrategia incremental

### Foundation

- auditoría;
- contratos;
- fixture P-101;
- shell;
- navegación;
- runtime state;
- soporte conceptual para configuración, aplicabilidad y overrides.

### Vertical slice 1

WS-01 completo con:

- carga del caso;
- edición de contexto;
- gate de preparación;
- output hacia WS-02.

### Vertical slices posteriores

Un workspace funcional cada vez, aplicando el protocolo:

```text
arquitectura
→ bloque pequeño
→ validación Studio
→ corrección
→ documentación
→ siguiente bloque
```

Antes de iniciar WS-03, WS-04 o WS-06 deberán estar materializados los contratos de configuración/riesgo, árbol RCM y aplicabilidad correspondientes.

## 14. Extensión operacional posterior

La reunión del 2026-08-14 identificó el siguiente recorrido objetivo:

```text
Plan publicado
→ generación anual de órdenes preventivas
→ planificación/programación
→ asignación
→ ejecución/feedback
→ coste real
→ centro de coste / presupuesto / partida contractual
→ integración corporativa / facturación
```

Estado:

- handoff hacia generación anual: suficientemente validado para representación conceptual;
- planning/scheduling: `to_validate`;
- ejecución/feedback: `to_validate`;
- costes: `to_validate`;
- contrato/facturación/integraciones: `to_validate`.

No se crearán workspaces adicionales hasta disponer de validación funcional suficiente.

## 15. Decisiones explícitamente pendientes

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
- reglas productivas de planificación/programación;
- modelo definitivo de costes y facturación.

Cualquier necesidad de cerrar uno de estos puntos constituye un gate de arquitectura o de validación funcional.
