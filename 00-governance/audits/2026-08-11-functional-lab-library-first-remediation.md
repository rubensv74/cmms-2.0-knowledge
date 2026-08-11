# Auditoría de remediación — Functional Lab library-first

**Fecha:** 2026-08-11  
**Estado:** COMPLETADA — 14/14 desviaciones corregidas  
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
- `03-data-model/core/fmea-library-model.md`
- `03-data-model/core/traceability-layers.md`
- `06-ui-ux/functional-lab/architecture.md`
- `06-ui-ux/functional-lab/cases/P101/p101-case.v1.json`
- `06-ui-ux/functional-lab/cases/P101/p101-case.v2.json`
- `06-ui-ux/functional-lab/contracts/`
- AMEF–RCM Experience Center como material histórico de explicación.

## 3. Las 14 desviaciones y su corrección

| ID | Desviación | Corrección adoptada | Estado |
|---|---|---|---|
| DEV-01 | El caso P-101 actúa como raíz del análisis. | La raíz pasa a ser `FmeaDefinition`; el activo aparece únicamente en `FmeaAssetApplication`. | closed |
| DEV-02 | No existe identidad estable de biblioteca AMEF en el Functional Lab. | Introducir `FmeaDefinition` como objeto reutilizable independiente de activos concretos. | closed |
| DEV-03 | El contenido AMEF no está gobernado por revisiones explícitas. | Introducir `FmeaRevision`, estado, número de revisión, vigencia y snapshot publicado inmutable. | closed |
| DEV-04 | No existe una capa explícita de aplicación del AMEF a un activo. | Introducir `FmeaAssetApplication` con activo, contexto operacional, evaluación de aplicabilidad y overrides trazados. | closed |
| DEV-05 | La criticidad del activo se mezcla con la matriz de riesgo AMEF mediante conceptos como `criticalOverride` y “matriz de criticidad”. | Separar `AssetCriticalitySnapshot/Override` de `ConsequenceAssessment` y de la matriz de riesgo AMEF. Ningún cambio de criticidad reescribe el AMEF publicado. | closed |
| DEV-06 | Funciones, fallos y modos viven como textos anidados del caso, dificultando identidad y reutilización. | Convertirlos en objetos con identificadores estables: `FmeaFunction`, `FunctionalFailure` y `FailureMode`. | closed |
| DEV-07 | El mecanismo causal está implícito dentro del texto del modo. | Introducir `FailureCause`/mecanismo como entidad explícita y relacionable. | closed |
| DEV-08 | Los efectos están embebidos como tres textos fijos y no como evidencia estructurada. | Introducir `FailureEffect` con tipo, orden, descripción y referencia al modo. | closed |
| DEV-09 | El recorrido RCM está reducido a un grupo de campos sin versión de lógica ni respuestas trazables. | Introducir `RcmAssessment`, `RcmAssessmentAnswer` y referencias a lógica versionada; conservar recomendación, decisión humana y override. | closed |
| DEV-10 | El modelo solo contempla el camino que termina en una tarea. | Incorporar `NoScheduledTaskDecision` como salida explícita y justificable cuando no exista tarea programada válida. | closed |
| DEV-11 | Una tarea queda ligada al modo principal del caso y no soporta cardinalidad N:M. | Introducir `MaintenanceTaskFailureMode` para permitir varias tareas por modo y varios modos por tarea. | closed |
| DEV-12 | La tarea contiene simultáneamente definición, técnica/procedimiento y formato de inspección. | Separar `MaintenanceTask`, `MaintenanceProcedure` e `InspectionFormat`; los dos últimos son adjuntos opcionales y versionables. | closed |
| DEV-13 | Economía de decisión, coste previsto de mantenimiento y coste real aparecen mezclados entre `treatment` y `effectiveness`. | Separar `EconomicAssessment`, `MaintenanceCostEstimate` y `ActualMaintenanceCost`. | closed |
| DEV-14 | Biblioteca, aplicación, planificación y resultados comparten un único agregado y la trazabilidad depende de textos. | Separar las cuatro capas y exigir lineage por identificadores desde `FmeaRevision` hasta `FmeaAssetApplication`, `ExecutionPlan`, `ExecutionPlanTask` y resultados. | closed |

## 4. Evidencia de cierre

| Desviación | Evidencia principal |
|---|---|
| DEV-01 / DEV-02 / DEV-03 | `03-data-model/core/fmea-library-model.md`; `cases/P101/p101-case.v2.json` |
| DEV-04 | `contracts/fmea-asset-application.schema.json`; `development/workspaces/workspace-catalog-v2.md` |
| DEV-05 | `03-data-model/core/fmea-library-model.md`; WS-03/WS-07 en `workspace-catalog-v2.md`; fixture v2 |
| DEV-06 / DEV-07 / DEV-08 | `contracts/fmea-library.schema.json`; fixture v2 |
| DEV-09 | `contracts/fmea-library.schema.json`; `functional-journey.md`; fixture v2 |
| DEV-10 | `NoScheduledTaskDecision` en schema, component contract y fixture v2 |
| DEV-11 | `MaintenanceTaskFailureMode` en modelo/schema; fixture v2 demuestra N:M en ambos sentidos |
| DEV-12 | Modelo/schema/component contracts separan task/procedure/inspection format |
| DEV-13 | Schemas de Library/Results y fixture v2 mantienen las tres capas económicas separadas |
| DEV-14 | `traceability-layers.md`; Runtime Adapter v2; lineage del fixture v2 |

Además:

- `01-vision/cmms-functional-lab-vision.md` está alineado con el modelo por capas.
- `02-functional/process-model/functional-journey.md` mantiene 28 etapas pero ya no usa el activo como raíz.
- `02-functional/process-model/human-system-decisions.md` separa decisiones por capa.
- `06-ui-ux/functional-lab/architecture.md` define estado runtime separado por agregado.
- `06-ui-ux/functional-lab/component-contracts.md` evita que la UI degrade cardinalidades u ownership.
- `06-ui-ux/functional-lab/development/adapters/runtime-adapter-v2.md` prohíbe volver a un `ActiveCase` monolítico.
- `06-ui-ux/functional-lab/development/fixture-v1-to-v2-migration.md` prohíbe migrar `criticalOverride` automáticamente.
- `06-ui-ux/functional-lab/development/validation/validate-fixture-v2.py` comprueba localmente relaciones y separaciones críticas cuando se ejecute en un checkout.
- las guías del Experience Center han sido actualizadas; su runtime HTML v3 queda clasificado como evidencia histórica asset-centric y no como modelo canónico.

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
├─ ExecutionPlanTask(s)
├─ MaintenanceTaskId de origen
├─ interval / trigger
├─ resources
├─ execution scope
├─ procedure / inspection format refs
└─ publication status
```

### 5.4 Results & Learning

```text
MaintenanceResult
├─ ExecutionPlanTaskId
├─ measurements / findings
├─ execution outcome
├─ ActualMaintenanceCost
└─ EffectivenessReview / EngineeringChangeRequest
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

Los siguientes puntos permanecen abiertos porque requieren validación funcional o decisión arquitectónica específica. No deben cerrarse como consecuencia de esta remediación:

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

Estos puntos están clasificados en `00-governance/architecture-gates.md` como validaciones funcionales o gates futuros y no bloquean la foundation v2.

## 9. Criterio de cierre

La remediación queda cerrada porque:

- [x] P-101 deja de ser el contenedor raíz del AMEF.
- [x] El fixture canónico representa las cuatro capas.
- [x] El journey sigue explícitamente `Library → Asset Application → Execution Plan → Results`.
- [x] La UI propuesta puede mostrar capa activa, revisión y trazabilidad entre capas.
- [x] Las guías vigentes ya no enseñan que AMEF y plan nacen dentro de un activo concreto.
- [x] Riesgo AMEF y criticidad del activo tienen objetos, workspaces y fuentes distintos.
- [x] La economía queda dividida en las tres capas acordadas.
- [x] La N:M tarea–modo está modelada y demostrada en el fixture.
- [x] La salida sin tarea está representada explícitamente.
- [x] Tarea, procedimiento y formato están separados.
- [x] Published revision es inmutable y las capas posteriores tienen lifecycle independiente.

## 10. Frontera alcanzada

No ha surgido una nueva decisión de arquitectura que requiera intervención.

La siguiente frontera es técnica:

`TG-001 — Canvas app baseline`.

La rama no contiene actualmente una Canvas app / Source Code real sobre la que confirmar dialecto, versiones de controles, componentes instalados, theme y App Checker. Por tanto, generar YAML ahora sería inventar el entorno y violar el protocolo incremental.

Toda la preparación previa a ese punto está documentada en:

- `development/f01-00-power-apps-foundation-audit.md`;
- `development/screens/functional-lab/screen-architecture.md`;
- `development/screens/functional-lab/blocks/block-plan.md`;
- `development/adapters/runtime-adapter-v2.md`;
- `development/workspaces/ws-01-library-revision.md`;
- `development/workspaces/workspace-catalog-v2.md`.
