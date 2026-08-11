# Auditoría de remediación — Functional Lab library-first

**Fecha:** 2026-08-11  
**Estado:** remediación arquitectónica en curso  
**Rama:** `agent/functional-lab-foundation`

## 1. Objetivo

Corregir las desviaciones detectadas entre el modelo funcional de Ingeniería de Fiabilidad ya definido para CMMS 2.0 y la primera foundation del CMMS Functional Lab.

La corrección no cambia el propósito del laboratorio: sigue siendo una aplicación de validación funcional. Lo que cambia es el objeto sobre el que razona.

Principio rector:

> El Functional Lab no debe construir un AMEF dentro de un activo. Debe construir y gobernar una biblioteca de ingeniería reutilizable, aplicarla después a activos concretos, convertir esa aplicación en un plan de ejecución y, finalmente, comparar los resultados reales con las hipótesis de ingeniería.

Flujo canónico:

```text
Engineering Library
→ Asset Application
→ Execution Plan
→ Results & Learning
```

## 2. Fuentes de verdad usadas

- `05-meetings/02-Specifications/SPC-001_ESPECIFICACION_CODEX_AMEF_RCM.md`
- `01-vision/cmms-functional-lab-vision.md`
- `02-functional/process-model/functional-journey.md`
- `02-functional/process-model/human-system-decisions.md`
- `06-ui-ux/functional-lab/architecture.md`
- `06-ui-ux/functional-lab/cases/P101/p101-case.v1.json`
- `06-ui-ux/functional-lab/contracts/case-fixture.schema.json`
- AMEF–RCM Experience Center y sus guías como material histórico de explicación.

## 3. Las 14 desviaciones y su corrección

| ID | Desviación | Corrección adoptada | Estado |
|---|---|---|---|
| DEV-01 | El caso P-101 actúa como raíz del análisis. | La raíz pasa a ser `FmeaDefinition`; el activo aparece únicamente en `FmeaAssetApplication`. | corrected |
| DEV-02 | No existe identidad estable de biblioteca AMEF en el Functional Lab. | Introducir `FmeaDefinition` como objeto reutilizable independiente de activos concretos. | corrected |
| DEV-03 | El contenido AMEF no está gobernado por revisiones explícitas. | Introducir `FmeaRevision`, estado, número de revisión, vigencia y snapshot publicado inmutable. | corrected |
| DEV-04 | No existe una capa explícita de aplicación del AMEF a un activo. | Introducir `FmeaAssetApplication` con activo, contexto operacional, evaluación de aplicabilidad y overrides trazados. | corrected |
| DEV-05 | La criticidad del activo se mezcla con la matriz de riesgo AMEF mediante conceptos como `criticalOverride` y “matriz de criticidad”. | Separar `AssetCriticalitySnapshot/Override` de `ConsequenceAssessment` y de la matriz de riesgo AMEF. Ningún cambio de criticidad reescribe el AMEF publicado. | corrected |
| DEV-06 | Funciones, fallos y modos viven como textos anidados del caso, dificultando identidad y reutilización. | Convertirlos en objetos con identificadores estables: `FmeaFunction`, `FunctionalFailure` y `FailureMode`. | corrected |
| DEV-07 | El mecanismo causal está implícito dentro del texto del modo. | Introducir `FailureCause`/mecanismo como entidad explícita y relacionable. | corrected |
| DEV-08 | Los efectos están embebidos como tres textos fijos y no como evidencia estructurada. | Introducir `FailureEffect` con tipo, orden, descripción y referencia al modo. | corrected |
| DEV-09 | El recorrido RCM está reducido a un grupo de campos sin versión de lógica ni respuestas trazables. | Introducir `RcmAssessment`, `RcmAssessmentAnswer` y referencias a `DecisionLogic`; conservar recomendación, decisión humana y override. | corrected |
| DEV-10 | El modelo solo contempla el camino que termina en una tarea. | Incorporar `NoScheduledTaskDecision` como salida explícita y justificable cuando no exista tarea programada válida. | corrected |
| DEV-11 | Una tarea queda ligada al modo principal del caso y no soporta cardinalidad N:M. | Introducir `MaintenanceTaskFailureMode` para permitir varias tareas por modo y varios modos por tarea. | corrected |
| DEV-12 | La tarea contiene simultáneamente definición, técnica/procedimiento y formato de inspección. | Separar `MaintenanceTask`, `MaintenanceProcedure` e `InspectionFormat`; los dos últimos son adjuntos opcionales y versionables. | corrected |
| DEV-13 | Economía de decisión, coste previsto de mantenimiento y coste real aparecen mezclados entre `treatment` y `effectiveness`. | Separar `EconomicAssessment`, `MaintenanceCostEstimate` y `ActualMaintenanceCost`. | corrected |
| DEV-14 | Biblioteca, aplicación, planificación y resultados comparten un único agregado y la trazabilidad depende de textos. | Separar las cuatro capas y exigir lineage por identificadores desde `FmeaRevision` hasta `FmeaAssetApplication`, `ExecutionPlan` y `MaintenanceResult`. | corrected |

## 4. Consecuencias directas para el Functional Lab

La remediación obliga a cambiar:

1. el contrato canónico de fixtures;
2. el fixture P-101;
3. el Functional Journey;
4. la matriz persona/sistema;
5. la arquitectura de workspaces;
6. los componentes funcionales comunes;
7. las guías de negocio;
8. el estado de implementación y la secuencia F01.

No es válida una solución que conserve el journey asset-centric y solo cambie nombres de campos.

## 5. Modelo mínimo resultante

### 5.1 Engineering Library

```text
FmeaDefinition
└─ FmeaRevision
   ├─ FmeaFunction
   │  └─ FunctionalFailure
   │     └─ FailureMode
   │        ├─ FailureCause
   │        ├─ FailureEffect
   │        ├─ ConsequenceAssessment
   │        └─ RcmAssessment
   ├─ MaintenanceTask
   │  ├─ MaintenanceTaskFailureMode
   │  ├─ MaintenanceProcedure? 
   │  └─ InspectionFormat?
   ├─ NoScheduledTaskDecision
   ├─ EconomicAssessment
   └─ MaintenanceCostEstimate
```

### 5.2 Asset Application

```text
FmeaAssetApplication
├─ FmeaRevisionId
├─ AssetId
├─ OperationalContextSnapshot
├─ AssetCriticalitySnapshot
├─ ApplicabilityDecision
├─ TaskApplicability
└─ Override + reason + authority
```

### 5.3 Execution Plan

```text
ExecutionPlan
├─ FmeaAssetApplicationId
├─ TaskInstance(s)
├─ interval / trigger
├─ resources
├─ execution scope
├─ procedure / inspection format refs
└─ publication status
```

### 5.4 Results & Learning

```text
MaintenanceResult
├─ ExecutionPlanId
├─ TaskInstanceId
├─ measurements / findings
├─ execution outcome
├─ ActualMaintenanceCost
└─ effectiveness review / change request
```

## 6. Regla de criticidad y riesgo

A partir de esta remediación se prohíbe utilizar “criticidad” como sinónimo de puntuación AMEF.

- **Criticidad del activo:** característica contextual del activo dentro de la organización. Puede influir en aplicabilidad, frecuencia, autoridad o prioridad, pero tiene su propio esquema y fuente.
- **Riesgo AMEF:** evaluación de un modo de fallo y sus consecuencias utilizando una matriz/versionado de riesgo identificados.
- **Override de criticidad:** corrección autorizada de la criticidad contextual de la aplicación; no modifica S/O/D ni la revisión AMEF publicada.
- **Override de decisión RCM:** decisión humana distinta de la recomendación del sistema; debe conservar recomendación original y motivo.

Son conceptos distintos y deben mostrarse como tales en datos y UI.

## 7. Regla de economía

```text
EconomicAssessment
= comparación de escenarios y apoyo a una decisión

MaintenanceCostEstimate
= coste previsto de ejecutar una tarea o plan

ActualMaintenanceCost
= coste observado procedente de ejecuciones reales
```

El coste no puede transformar una política técnicamente inválida en una política válida.

## 8. Asuntos que NO se consideran desviaciones

Los siguientes puntos permanecen abiertos porque requieren validación funcional o decisión arquitectónica específica. No deben cerrarse durante esta remediación:

- matriz corporativa de riesgo y sus escalas exactas;
- fórmula corporativa final de priorización AMEF;
- esquema corporativo definitivo de criticidad de activos;
- versión y contenido definitivo del árbol RCM;
- roles y etapas finales de aprobación;
- umbrales corporativos P–F;
- fórmulas económicas definitivas y tasas corporativas;
- granularidad exacta de `MaintenanceProcedure` e `InspectionFormat`;
- backend productivo, SQL/Dataverse/API/flows;
- integración final con activos, FLH, taxonomía y ADR;
- generación productiva de Job Plans, PM y WO;
- autenticación y autorización finales.

Estos puntos se registrarán como `to_validate` o gate de arquitectura según corresponda.

## 9. Criterio de cierre

La remediación se considera cerrada cuando:

- P-101 deja de ser el contenedor raíz del AMEF;
- el fixture canónico representa las cuatro capas;
- el journey sigue explícitamente `Library → Asset Application → Execution Plan → Results`;
- la UI propuesta puede mostrar la capa activa y la trazabilidad entre capas;
- las guías ya no enseñan que AMEF y plan nacen dentro de un activo concreto;
- no quedan referencias funcionales que usen criticidad del activo como matriz AMEF;
- la economía queda dividida en las tres capas acordadas.
