# CMMS 2.0 Functional Lab — Arquitectura

**Estado:** Foundation  
**Alcance:** arquitectura del laboratorio conceptual, no arquitectura productiva de CMMS 2.0.

## 1. Objetivo arquitectónico

Construir una aplicación Canvas Power Apps que permita ejecutar casos funcionales de CMMS 2.0 sin acoplar el razonamiento de negocio a una base de datos, integración o tecnología productiva definitiva.

## 2. Capas

```text
┌───────────────────────────────────────────────┐
│  Functional Journey                          │
│  Etapas, decisiones, reglas, gates, outputs  │
└───────────────────────────────────────────────┘
                     ↓
┌───────────────────────────────────────────────┐
│  Canonical Case Fixtures                     │
│  JSON versionado: P-101 y casos futuros      │
└───────────────────────────────────────────────┘
                     ↓
┌───────────────────────────────────────────────┐
│  Runtime Adapter                             │
│  Convierte fixture en colecciones Power Fx   │
└───────────────────────────────────────────────┘
                     ↓
┌───────────────────────────────────────────────┐
│  Functional State                            │
│  Caso activo + decisiones + gates + outputs  │
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

## 4. Estado funcional

El estado runtime se separará del dato canónico.

Conceptualmente:

```text
CaseFixture
+ UserChanges
+ SystemCalculations
+ SystemRecommendations
+ HumanDecisions
+ GateResults
= ActiveCaseState
```

La app deberá distinguir qué parte procede de cada origen.

## 5. Workspaces v1

La primera arquitectura contempla nueve workspaces funcionales:

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
        │   ├── WS-03 Efectos y riesgo
        │   ├── WS-04 Decisión RCM
        │   ├── WS-05 Economía y tarea
        │   ├── WS-06 Recursos y alcance
        │   ├── WS-07 Trazabilidad y calidad
        │   ├── WS-08 Revisión y publicación
        │   └── WS-09 Efectividad y mejora
        └── conLab_OverlayLayer
```

Esta estructura es una hipótesis inicial. La validación funcional puede demostrar que un workspace debe dividirse o fusionarse.

## 6. Paneles comunes

Cada workspace debe poder reutilizar los siguientes patrones conceptuales:

### 6.1. Contexto

Muestra:

- activo;
- servicio;
- fase;
- etapa actual;
- estado de completitud;
- nivel de confianza cuando aplique.

### 6.2. Información disponible

Distingue los datos que deberían venir ya informados desde otros módulos o fuentes.

### 6.3. Trabajo del usuario

Contiene los inputs y decisiones de la persona.

### 6.4. Sistema

Muestra por separado:

- cálculo;
- recomendación;
- explicación.

### 6.5. Gate

Indica:

- estado `passed`, `blocked` o `warning`;
- razones;
- datos faltantes;
- acción necesaria para desbloquear.

### 6.6. Output

Muestra qué objeto o decisión estructurada queda disponible para el siguiente paso.

## 7. Modelo de navegación

La navegación debe permitir:

- avanzar cuando el gate lo permita;
- retroceder siempre;
- saltar en modo presentación sin fingir que los gates previos están aprobados;
- volver al resumen del caso;
- identificar visualmente etapas pendientes, bloqueadas, validadas y simuladas.

## 8. Estados obligatorios

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

## 9. Trazabilidad runtime

Cada decisión registrada debe conservar, cuando aplique:

```text
caseId
stageId
ruleId
inputSnapshot
systemResult
systemRecommendation
humanDecision
reason
actorRole
validationStatus
timestamp
```

En la fase conceptual el actor puede representarse por rol o usuario de demostración; no se considera todavía un modelo definitivo de identidad.

## 10. Separación de reglas

Las fórmulas de UI no deben convertirse en la única definición de una regla funcional.

Cada regla relevante deberá existir también en un catálogo o contrato documental con:

- identificador;
- descripción;
- inputs;
- resultado;
- estado de validación;
- fuente;
- excepciones.

## 11. Estrategia incremental

### Foundation

- auditoría;
- contratos;
- fixture P-101;
- shell;
- navegación;
- runtime state.

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

## 12. Decisiones explícitamente pendientes

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
- generación real de Job Plans, PM o WO.

Cualquier necesidad de cerrar uno de estos puntos constituye un gate de arquitectura.
