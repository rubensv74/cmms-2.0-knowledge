# Modelo conceptual — FMEA / RCM Engineering Library

**Estado:** canónico para Functional Lab  
**Fecha:** 2026-08-11  
**Nivel:** conceptual; no define modelo físico de base de datos.

## 1. Propósito

Definir el núcleo reusable de Ingeniería de Fiabilidad sobre el que se construyen las aplicaciones a activos concretos.

Principio:

> El AMEF es conocimiento de ingeniería versionado. El activo consume una revisión publicada de ese conocimiento; no es su propietario.

## 2. Agregados

### A. Engineering Library

- `FmeaDefinition`
- `FmeaRevision`
- `FmeaFunction`
- `FunctionalFailure`
- `FailureMode`
- `FailureCause`
- `FailureEffect`
- `ConsequenceAssessment`
- `RcmAssessment`
- `RcmAssessmentAnswer`
- `MaintenanceTask`
- `MaintenanceTaskFailureMode`
- `MaintenanceProcedure`
- `InspectionFormat`
- `NoScheduledTaskDecision`
- `EconomicAssessment`
- `MaintenanceCostEstimate`

### B. Asset Application

- `FmeaAssetApplication`
- `TaskApplicabilityDecision`
- `OperationalContextSnapshot`
- `AssetCriticalitySnapshot`
- `AssetCriticalityOverride`

### C. Execution Plan

- `ExecutionPlan`
- `ExecutionPlanTask`

### D. Results & Learning

- `MaintenanceResult`
- `MaintenanceMeasurement`
- `MaintenanceFinding`
- `ActualMaintenanceCost`
- `EffectivenessReview`
- `EngineeringChangeRequest`

## 3. Entidades del núcleo

### 3.1 `FmeaDefinition`

Identidad estable de una biblioteca AMEF reutilizable.

Campos conceptuales mínimos:

| Campo | Propósito |
|---|---|
| `fmeaDefinitionId` | Identidad inmutable. |
| `code` | Código funcional visible. |
| `name` | Nombre de la biblioteca. |
| `description` | Propósito y alcance. |
| `equipmentTypeRef` | Tipo/clase de equipo cuando aplique. |
| `functionalScopeRef` | Alcance funcional cuando aplique. |
| `ownerRole` | Responsabilidad funcional del contenido. |
| `lifecycleStatus` | Estado de la definición, no de una revisión concreta. |
| `createdAt` | Trazabilidad. |
| `createdBy` | Trazabilidad. |

Reglas:

- no contiene activo concreto;
- no contiene una versión mutable de funciones/modos;
- no se duplica para representar criticidad alta/media/baja;
- puede tener muchas revisiones.

### 3.2 `FmeaRevision`

Versión gobernada del contenido de una `FmeaDefinition`.

| Campo | Propósito |
|---|---|
| `fmeaRevisionId` | Identidad de revisión. |
| `fmeaDefinitionId` | Padre estable. |
| `revisionNumber` | Número/etiqueta de revisión. |
| `status` | Draft, review, approved, published, superseded, retired u otro catálogo validado. |
| `validFrom` | Vigencia cuando aplique. |
| `validTo` | Fin de vigencia cuando aplique. |
| `changeReason` | Por qué existe esta revisión. |
| `sourceRevisionId` | Revisión desde la que se deriva, cuando aplique. |
| `riskMatrixVersionRef` | Matriz utilizada para las evaluaciones AMEF. |
| `rcmLogicVersionRef` | Lógica RCM utilizada. |
| `publishedSnapshotId` | Snapshot inmutable si está publicada. |
| `rowVersion` | Concepto de control de concurrencia; implementación pendiente. |

Reglas:

1. una revisión publicada no se sobrescribe;
2. cambiar funciones, fallos, modos, tratamiento o reglas publicadas genera nueva revisión;
3. una aplicación a activo conserva siempre el `fmeaRevisionId` exacto usado;
4. un cambio posterior de criticidad del activo no modifica esta revisión.

### 3.3 `FmeaFunction`

| Campo | Propósito |
|---|---|
| `fmeaFunctionId` | Identidad. |
| `fmeaRevisionId` | Revisión propietaria. |
| `sequence` | Orden dentro de la revisión. |
| `functionType` | Principal, secundaria, protección, contención u otro catálogo. |
| `statement` | Qué debe hacer. |
| `performanceStandard` | Criterio medible. |
| `unitRef` | Unidad cuando aplique. |

### 3.4 `FunctionalFailure`

| Campo | Propósito |
|---|---|
| `functionalFailureId` | Identidad. |
| `fmeaFunctionId` | Función incumplida. |
| `sequence` | Orden. |
| `failureType` | Total, parcial, intermitente, no deseado u otro catálogo. |
| `statement` | Descripción del incumplimiento. |

### 3.5 `FailureMode`

Describe el evento/condición que produce un fallo funcional. No debe utilizarse como contenedor de causas detalladas.

| Campo | Propósito |
|---|---|
| `failureModeId` | Identidad. |
| `functionalFailureId` | Fallo funcional afectado. |
| `code` | Código dentro de la revisión. |
| `statement` | Modo de fallo. |
| `status` | Incluido, excluido, pendiente, etc. |
| `inclusionRationale` | Justificación de inclusión. |
| `exclusionRationale` | Justificación de exclusión si aplica. |

### 3.6 `FailureCause`

Representa causa o mecanismo causal explícito.

| Campo | Propósito |
|---|---|
| `failureCauseId` | Identidad. |
| `failureModeId` | Modo relacionado. |
| `causeType` | Mecanismo, condición iniciadora, degradación, humano, externo, etc. |
| `statement` | Descripción. |
| `evidenceRef` | Fuente que soporta la causa, cuando aplique. |

Un modo puede tener varias causas.

### 3.7 `FailureEffect`

| Campo | Propósito |
|---|---|
| `failureEffectId` | Identidad. |
| `failureModeId` | Modo relacionado. |
| `effectLevel` | Inicial/local/equipo/sistema/operacional/final u otro catálogo. |
| `sequence` | Orden. |
| `statement` | Descripción observable o propagada. |
| `evidenceRef` | Evidencia cuando aplique. |

Un modo puede tener múltiples efectos ordenados.

## 4. Riesgo y consecuencias

### 4.1 `ConsequenceAssessment`

Evalúa un modo dentro de un contexto y con una matriz de riesgo identificada.

Campos mínimos:

- `consequenceAssessmentId`;
- `failureModeId`;
- `operationalContextProfileRef` o snapshot contextual;
- `riskMatrixVersionRef`;
- `consequenceCategory`;
- `severityValue`;
- `occurrenceValue` o probabilidad según metodología;
- `detectionValue` si la metodología lo utiliza;
- `calculatedRiskResult`;
- `humanAssessment`;
- `rationale`;
- `evidenceRefs`;
- `validationStatus`.

### 4.2 Lo que NO pertenece aquí

No se almacenan como sinónimos de riesgo AMEF:

- criticidad corporativa del activo;
- prioridad de negocio general;
- ranking de cartera;
- clasificación de equipo crítico/no crítico.

Esos conceptos pertenecen a `FmeaAssetApplication` mediante un `AssetCriticalitySnapshot` identificado.

## 5. RCM

### 5.1 `RcmAssessment`

Instancia gobernada de la lógica RCM para un modo.

Campos mínimos:

- `rcmAssessmentId`;
- `failureModeId`;
- `decisionLogicVersionRef`;
- `consequenceAssessmentId`;
- `systemRecommendation`;
- `humanDecision`;
- `overrideReason`;
- `authorityRole`;
- `status`.

### 5.2 `RcmAssessmentAnswer`

Cada respuesta del árbol debe conservar:

- `rcmAssessmentAnswerId`;
- `rcmAssessmentId`;
- `questionRef`;
- `sequence`;
- `answer`;
- `rationale`;
- `evidenceRefs`;
- `answeredBy`;
- `answeredAt`.

La UI puede parecer un wizard, pero los datos no deben reducirse al resultado final.

## 6. Tratamientos

### 6.1 `MaintenanceTask`

Recomendación de ingeniería reusable. Corresponde funcionalmente al concepto previamente denominado `ProposedMaintenanceTask`.

Campos conceptuales:

- `maintenanceTaskId`;
- `fmeaRevisionId`;
- `code`;
- `name`;
- `objective`;
- `maintenanceTypeRef`;
- `activityRef`;
- `techniqueRef`;
- `triggerBasis`;
- `defaultIntervalValue`;
- `defaultIntervalUnit`;
- `intervalBasisRef`;
- `executionStateRequirementRef`;
- `disciplineRef`;
- `executorRoleRef`;
- `status`.

No debe contener los pasos detallados de trabajo ni el formulario completo de captura.

### 6.2 `MaintenanceTaskFailureMode`

Entidad puente N:M.

Campos mínimos:

- `maintenanceTaskFailureModeId`;
- `maintenanceTaskId`;
- `failureModeId`;
- `treatmentPurpose` — detectar, prevenir, mitigar, verificar;
- `rationale`.

Reglas:

- una tarea aprobada trata al menos un modo;
- un modo puede tener tareas complementarias;
- una tarea puede tratar varios modos sin duplicarse.

### 6.3 `MaintenanceProcedure`

Contenido procedural opcional y versionable.

Conceptualmente contiene:

- objetivo procedural;
- prerrequisitos;
- pasos;
- advertencias técnicas;
- herramientas o medios específicos;
- criterios de finalización;
- revisión/versión.

La existencia de una tarea no obliga a que haya un procedimiento detallado.

### 6.4 `InspectionFormat`

Formato opcional y versionable para capturar mediciones, observaciones o checks de una tarea.

Puede definir:

- campos;
- unidades;
- obligatoriedad;
- rangos o criterios;
- evidencias requeridas;
- estructura de resultado.

No es la `MaintenanceTask`.

### 6.5 `NoScheduledTaskDecision`

Salida explícita para una decisión RCM que no genera tarea programada.

Campos mínimos:

- `noScheduledTaskDecisionId`;
- `fmeaRevisionId`;
- `failureModeId`;
- `decisionType`;
- `rationale`;
- `residualRiskAcceptanceRef` cuando aplique;
- `authorityRole`;
- `status`.

Nunca debe representarse simplemente por ausencia de tarea.

## 7. Economía — tres capas separadas

### 7.1 `EconomicAssessment`

Propósito: apoyar una decisión comparando escenarios técnicamente válidos.

Ejemplos de inputs:

- frecuencia esperada de fallo;
- coste de consecuencia;
- pérdida operativa;
- reducción esperada de probabilidad/consecuencia;
- horizonte temporal.

Resultado: comparación y sensibilidad; no es el coste contable real.

### 7.2 `MaintenanceCostEstimate`

Propósito: estimar cuánto costará ejecutar una tarea o plan.

Puede contener:

- horas previstas;
- tarifa prevista;
- materiales previstos;
- herramientas/servicios;
- coste por ejecución;
- ejecuciones previstas;
- coste anual previsto;
- moneda y fecha/base de coste.

### 7.3 `ActualMaintenanceCost`

Propósito: registrar el coste observado desde la ejecución real.

Debe relacionarse con `MaintenanceResult` o su ejecución fuente, no con la revisión AMEF como si fuera una estimación.

## 8. Aplicación a activos

### 8.1 `FmeaAssetApplication`

Materializa la relación entre una revisión publicada y un activo/contexto concreto.

Campos mínimos:

- `fmeaAssetApplicationId`;
- `fmeaRevisionId`;
- `assetId`;
- `operationalContextSnapshotId`;
- `assetCriticalitySnapshotId`;
- `applicabilityResult`;
- `validatedApplicabilityResult`;
- `overrideReason`;
- `validatedBy`;
- `validatedAt`;
- `status`.

No duplica el contenido de la revisión.

### 8.2 `OperationalContextSnapshot`

Conserva las condiciones relevantes usadas para decidir aplicabilidad.

El snapshot evita que una actualización posterior del maestro de activos cambie silenciosamente una decisión histórica.

### 8.3 `AssetCriticalitySnapshot`

Conserva:

- esquema/version de criticidad;
- nivel recibido;
- fuente;
- fecha de evaluación;
- dimensiones relevantes si las hubiera.

### 8.4 `AssetCriticalityOverride`

Solo aparece cuando una persona autorizada corrige la criticidad contextual usada por la aplicación.

Debe conservar:

```text
sourceValue
suggestedValue (si existe)
humanValue
reason
authority
actor
timestamp
```

No cambia la matriz AMEF ni la revisión publicada.

## 9. Execution Plan

### 9.1 `ExecutionPlan`

Transforma una aplicación validada en una configuración ejecutable para ese activo/contexto.

Campos mínimos:

- `executionPlanId`;
- `fmeaAssetApplicationId`;
- `revisionNumber`;
- `status`;
- `effectiveFrom`;
- `effectiveTo`;
- `planningPolicyRef`;
- `publishedSnapshotId`.

### 9.2 `ExecutionPlanTask`

Instancia/aplicación de una `MaintenanceTask` dentro del plan.

Puede adaptar sin modificar la biblioteca:

- intervalo;
- disparador;
- recurso ejecutor;
- alcance físico;
- ventana de ejecución;
- procedimiento seleccionado;
- formato de inspección seleccionado;
- política de agrupación.

Toda variación debe conservar el `maintenanceTaskId` de origen y, si es override, el motivo.

## 10. Results & Learning

### 10.1 `MaintenanceResult`

Resultado de una ejecución concreta o consolidación gobernada de ejecuciones.

Debe poder remontarse como mínimo a:

```text
maintenanceResultId
→ executionPlanTaskId
→ executionPlanId
→ fmeaAssetApplicationId
→ fmeaRevisionId
→ fmeaDefinitionId
```

### 10.2 Datos de resultado

Según el tipo de tarea pueden existir:

- `MaintenanceMeasurement`;
- `MaintenanceFinding`;
- estado de ejecución;
- tiempo real;
- materiales;
- evidencia;
- fallo detectado/confirmado;
- `ActualMaintenanceCost`.

### 10.3 `EffectivenessReview`

Compara hipótesis de ingeniería con resultados reales.

No modifica una revisión publicada. Puede terminar en:

- mantener;
- ajustar aplicación/plan;
- abrir `EngineeringChangeRequest`;
- crear una nueva `FmeaRevision`.

## 11. Cardinalidades canónicas

```text
FmeaDefinition 1 ── N FmeaRevision
FmeaRevision   1 ── N FmeaFunction
FmeaFunction   1 ── N FunctionalFailure
FunctionalFailure 1 ── N FailureMode
FailureMode    1 ── N FailureCause
FailureMode    1 ── N FailureEffect
FailureMode    1 ── N ConsequenceAssessment
FailureMode    1 ── N RcmAssessment
RcmAssessment  1 ── N RcmAssessmentAnswer
MaintenanceTask N ── M FailureMode   (MaintenanceTaskFailureMode)
FmeaRevision   1 ── N MaintenanceTask
FmeaRevision   N ── M Asset          (FmeaAssetApplication)
FmeaAssetApplication 1 ── N ExecutionPlan
ExecutionPlan  1 ── N ExecutionPlanTask
ExecutionPlanTask 1 ── N MaintenanceResult
MaintenanceResult 1 ── N ActualMaintenanceCost
```

## 12. Invariantes

1. El activo nunca es padre de `FmeaRevision`.
2. Una revisión publicada es inmutable.
3. Ningún `FailureMode` existe sin `FunctionalFailure`.
4. Toda causa y efecto referencia un `FailureMode` por ID.
5. Una decisión RCM usa una versión de lógica identificada.
6. Ausencia de tarea no equivale a una decisión sin tarea.
7. La relación tarea–modo es N:M.
8. `MaintenanceProcedure` e `InspectionFormat` no son subcampos inseparables de la tarea.
9. Criticidad del activo y riesgo AMEF son modelos independientes.
10. Coste económico de decisión, estimación de mantenimiento y coste real son objetos distintos.
11. Una aplicación a activo no altera el contenido de biblioteca.
12. Un Execution Plan no elimina la identidad de la tarea de origen.
13. Un resultado real no sobrescribe hipótesis; las contrasta.
14. Toda capa conserva identificadores suficientes para reconstruir lineage extremo a extremo.

## 13. Pendientes de validación

Este documento no decide:

- tablas físicas;
- tipos SQL;
- claves técnicas finales;
- motor RCM productivo;
- matrices/escalas corporativas;
- estados definitivos;
- política definitiva de aprobaciones;
- taxonomía final de procedimientos/formularios;
- cálculo corporativo de costes;
- contratos API.
