# CMMS 2.0 — Consolidated Baseline Premium Power Apps v1

**Estado:** active baseline  
**Fecha:** 2026-08-22  
**Rama de trabajo:** `baseline/premium-powerapps-v1`  
**Ámbito:** baseline funcional y técnico del prototipo CMMS 2.0 Functional Lab en Power Apps.

## 1. Propósito

Esta baseline consolida las decisiones suficientemente maduras del proyecto para iniciar una versión premium del CMMS 2.0 Functional Lab en Power Apps sin esperar a la arquitectura productiva definitiva.

El objetivo inmediato no es construir el CMMS productivo ni cerrar SQL, API, seguridad o integraciones. El objetivo es disponer de una aplicación ejecutable y visualmente convincente para reuniones, capaz de validar el modelo funcional mediante escenarios realistas y de evolucionar después hacia SQL + Power Automate + API sin rehacer la experiencia de usuario.

## 2. Principio rector

La aplicación debe separar desde el primer incremento:

```text
UI / Workspaces
↓
Functional State
↓
Data Contract
↓
Data Provider
```

En la primera fase:

```text
Data Provider = Mock Collections
```

En fases posteriores:

```text
Data Provider = SQL / Power Automate / API
```

La UI no debe conocer el origen físico de los datos.

## 3. Decisiones congeladas

### 3.1. Power Apps como laboratorio funcional ejecutable

Se construirá una Canvas App premium destinada a demostrar y validar el journey funcional.

No se esperará a disponer de SQL, Power Automate o API para empezar.

### 3.2. Datos sintéticos en colecciones

Los escenarios de demostración se cargarán en colecciones Power Fx estructuradas.

Las colecciones no serán datos improvisados dentro de cada pantalla. Serán la implementación temporal de contratos de datos documentados.

Cada colección debe:

- representar una entidad o proyección funcional clara;
- tener esquema estable y documentado;
- usar IDs estables;
- mantener relaciones explícitas;
- distinguir dato fuente, cálculo del sistema y decisión humana;
- ser sustituible por otro proveedor sin cambiar el contrato consumido por la UI.

### 3.3. Fixtures JSON como fuente documental canónica

Los fixtures JSON versionados continúan siendo una fuente canónica útil para documentar casos, intercambiar escenarios y comprobar que el prototipo mantiene coherencia funcional.

No se obliga a que Power Apps lea JSON en tiempo de ejecución para cada demo.

El adaptador puede materializar el fixture en colecciones Power Fx preparadas para una demo rápida y estable.

### 3.4. SQL no bloquea el prototipo

No se conectará inicialmente la aplicación a SQL.

La ausencia de SQL no autoriza a ignorar el futuro modelo de persistencia.

El modelo conceptual y los contratos de datos se diseñarán desde el principio de forma compatible con una futura implementación relacional.

### 3.5. DDL contract-first

El DDL se desarrollará de forma incremental y paralela, pero únicamente para áreas funcionalmente suficientemente maduras.

Regla:

```text
función validada
→ contrato de datos
→ modelo conceptual
→ DDL candidato
→ validación técnica
```

No se crearán tablas definitivas para comportamientos que permanezcan `discovery` o `to_validate`.

El DDL candidato no convierte automáticamente una decisión funcional en arquitectura productiva aprobada.

### 3.6. Preparación para API futura

Ni las pantallas ni las reglas funcionales dependerán directamente de consultas SQL específicas.

Los límites se diseñarán para permitir en el futuro:

```text
Power Apps
→ Power Automate / API
→ servicios de dominio
→ SQL
```

sin destruir la app existente.

### 3.7. Premium desde Foundation

No se construirá primero una versión visual pobre para rediseñarla después.

Desde el shell inicial deben existir:

- geometría y navegación coherentes;
- tokens visuales;
- jerarquía tipográfica;
- componentes reutilizables;
- estados loading / empty / error / disabled;
- accesibilidad;
- densidad apropiada;
- responsive behavior donde aplique;
- feedback claro de gates y decisiones.

### 3.8. Separación estricta entre UI y reglas

Una fórmula de pantalla no puede ser la única definición de una regla funcional.

Toda regla relevante debe tener un contrato identificable con:

- ID;
- descripción;
- inputs;
- resultado;
- estado de validación;
- fuente;
- excepciones;
- configuración aplicable.

### 3.9. Autoridad humana y explicabilidad

Se mantiene como criterio consolidado:

- riesgo configurable por cliente/proyecto;
- RCM explicable y sin scoring inventado;
- recomendación del sistema separada de decisión humana;
- plan genérico separado de overrides por activo;
- trazabilidad de decisiones;
- rutas organizativas configurables cuando el proceso dependa del proyecto.

### 3.10. No convertir discovery en producto

Gestión del Trabajo, planning/scheduling, costes, contratos y facturación evolucionarán mediante discovery y validación.

No se hardcodearán como modelo objetivo los flujos AS-IS observados en sistemas existentes.

## 4. Arquitectura del prototipo

```text
CMMS 2.0 Functional Lab
│
├── Presentation Layer
│   ├── Premium App Shell
│   ├── Navigation
│   ├── Workspaces
│   ├── Components
│   └── Feedback / gates / states
│
├── Functional State Layer
│   ├── Current case
│   ├── User changes
│   ├── Calculations
│   ├── Recommendations
│   ├── Human decisions
│   ├── Gate results
│   └── Outputs
│
├── Contract Layer
│   ├── CaseContext
│   ├── Functions
│   ├── FailureModes
│   ├── RiskProfile
│   ├── RCMDecisionTrace
│   ├── BasePlan
│   ├── CandidateAssets
│   ├── ApplicabilityDecision
│   ├── AssetPlanOverride
│   └── PublishedPlanVersion
│
└── Provider Layer
    ├── v1: Mock Collections
    ├── v2: SQL + Power Automate
    └── v3: API / backend modular where required
```

## 5. Regla de colecciones

Las colecciones se clasificarán en cuatro familias.

### 5.1. `colCfg_*`

Configuración funcional.

Ejemplos:

- `colCfg_RiskProfiles`
- `colCfg_RiskLevels`
- `colCfg_RcmQuestions`

### 5.2. `colData_*`

Datos fuente del escenario.

Ejemplos:

- `colData_Assets`
- `colData_Functions`
- `colData_FailureModes`

### 5.3. `colState_*`

Estado mutable de la sesión.

Ejemplos:

- `colState_HumanDecisions`
- `colState_Applicability`
- `colState_Overrides`

### 5.4. `colView_*`

Proyecciones preparadas para presentación.

Ejemplos:

- `colView_RiskMatrix`
- `colView_PlanSummary`
- `colView_TraceabilityTimeline`

Una `colView_*` no debe convertirse en fuente de verdad.

## 6. Regla de inicialización

La carga inicial debe estar centralizada en un proveedor/adaptador de demo.

No se permiten bloques `ClearCollect(...)` dispersos por las pantallas para construir el modelo funcional.

Patrón conceptual:

```text
App.OnStart / startup orchestration
→ LoadDemoConfiguration()
→ LoadDemoCase()
→ InitializeRuntimeState()
→ BuildViewModels()
```

La implementación exacta en Power Fx se ajustará a las capacidades reales de la Canvas App.

## 7. Estrategia de sustitución futura

El cambio de proveedor debe seguir este patrón:

```text
Mock provider
    ↓ replace
SQL / Flow provider
    ↓ replace or wrap
API provider
```

Las pantallas deben seguir consumiendo la misma forma lógica de datos.

Cuando el contrato necesite cambiar, el cambio debe ser explícito y versionado.

## 8. Límites de esta baseline

Esta baseline NO decide todavía:

- backend productivo definitivo;
- API final;
- Azure SQL definitivo;
- esquema físico completo;
- autenticación/autorización productiva;
- integraciones SAP / Maximo / Hexagon;
- ALM productivo;
- reglas definitivas de planning/scheduling;
- modelo final de costes y facturación.

## 9. Gates para avanzar

### Gate PB-01 — Power Apps baseline

Debe existir una Canvas App real y quedar registrado:

- Source Code schema aceptado;
- controles/versiones;
- componentes disponibles;
- App Checker baseline;
- resolución objetivo;
- comportamiento responsive;
- baseline visual.

### Gate PB-02 — Data contract baseline

Antes de construir datos de demo extensos debe existir un catálogo inicial de colecciones y campos.

### Gate PB-03 — Premium shell

El shell debe quedar validado en Studio antes de añadir lógica funcional.

### Gate PB-04 — Vertical slice WS-01

WS-01 debe demostrar el patrón completo:

```text
mock data
→ functional state
→ UI
→ human edit
→ gate
→ structured output
```

### Gate PB-05 — Persistence readiness

Antes de SQL debe existir una matriz:

```text
collection field
↔ contract field
↔ SQL candidate field
↔ read/write responsibility
```

## 10. Criterio de éxito de la baseline

La baseline será satisfactoria cuando permita construir una demo premium que pueda evolucionar hacia persistencia real sustituyendo adaptadores y contratos concretos, sin rediseñar las pantallas ni trasladar reglas de negocio desde la UI a posteriori.
