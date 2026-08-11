# Runtime Adapter v2 — Contrato funcional

**Estado:** preparado para F01 después de auditar Power Apps  
**Entrada canónica:** `case-fixture.schema.json` v2  
**Salida:** estado runtime local por capas

## 1. Propósito

Definir cómo debe transformarse un fixture JSON v2 en estado utilizable por el Functional Lab sin convertir el formato del fixture en el modelo de persistencia productivo.

Este documento define responsabilidades y mapeos conceptuales. No prescribe todavía Power Fx concreto ni el mecanismo físico de lectura del archivo.

## 2. Regla principal

El adaptador conserva las cuatro capas como agregados distintos:

```text
CaseFixtureV2
├─ EngineeringLibrary
├─ AssetApplication
├─ ExecutionPlan
└─ Results
```

No produce un único registro `ActiveCase` donde todas las propiedades puedan editarse indistintamente.

## 3. Pipeline conceptual

```text
Receive fixture text/object
→ Detect fixtureVersion
→ Validate required top-level sections
→ Parse Engineering Library
→ Validate library internal references
→ Parse Asset Application
→ Validate revision reference
→ Parse Execution Plan
→ Validate application/task references
→ Parse Results
→ Validate plan/result references
→ Load traceability
→ Build Layered Functional State
→ Expose adapter diagnostics
```

## 4. Rechazo de legacy silencioso

Si:

```text
fixtureVersion starts with 1
```

el adaptador v2 no intenta adivinar la migración.

Resultado esperado:

```text
status = UnsupportedLegacyFixture
message = Fixture v1 requires explicit LegacyV1Adapter or migration to v2
```

La razón es semántica, no solo técnica: campos como `criticalOverride`, `focusMode` o `treatment.task` no tienen una equivalencia uno-a-uno segura.

## 5. Estado resultante

### 5.1 `LibraryState`

Fuente:

```text
engineeringLibrary.fmeaDefinition
engineeringLibrary.fmeaRevision
engineeringLibrary.functions[]
engineeringLibrary.functionalFailures[]
engineeringLibrary.failureModes[]
engineeringLibrary.failureCauses[]
engineeringLibrary.failureEffects[]
engineeringLibrary.consequenceAssessments[]
engineeringLibrary.rcmAssessments[]
engineeringLibrary.maintenanceTasks[]
engineeringLibrary.taskFailureModeLinks[]
engineeringLibrary.maintenanceProcedures[]
engineeringLibrary.inspectionFormats[]
engineeringLibrary.noScheduledTaskDecisions[]
engineeringLibrary.economicAssessments[]
engineeringLibrary.maintenanceCostEstimates[]
engineeringLibrary.governance
```

### 5.2 `AssetApplicationState`

Fuente:

```text
assetApplication
```

Incluye por separado:

```text
Application identity
Asset identity
OperationalContextSnapshot
AssetCriticalitySnapshot
AssetCriticalityOverride?
Applicability decisions
Validation metadata
```

### 5.3 `ExecutionPlanState`

Fuente:

```text
executionPlan
```

Mantiene `maintenanceTaskId` de origen para cada `ExecutionPlanTask`.

### 5.4 `ResultsState`

Fuente:

```text
results.maintenanceResults[]
results.actualMaintenanceCosts[]
results.effectivenessReviews[]
```

Un coste real nunca se carga sobre la colección de estimaciones.

### 5.5 `TraceState`

Fuente:

```text
traceability.lineage[]
```

Puede complementarse con eventos runtime locales, pero no sustituirse por breadcrumbs de texto.

## 6. Colecciones conceptuales candidatas

Los nombres definitivos se confirmarán durante F01-00, pero la separación semántica debe mantenerse.

```text
colFmeaFunctions
colFunctionalFailures
colFailureModes
colFailureCauses
colFailureEffects
colConsequenceAssessments
colRcmAssessments
colRcmAnswers
colMaintenanceTasks
colTaskFailureModeLinks
colMaintenanceProcedures
colInspectionFormats
colNoScheduledTaskDecisions
colEconomicAssessments
colMaintenanceCostEstimates
colApplicabilityDecisions
colExecutionPlanTasks
colMaintenanceResults
colActualMaintenanceCosts
colEffectivenessReviews
colTraceLineage
```

Objetos singulares pueden mantenerse como records/variables equivalentes:

```text
varFmeaDefinition
varFmeaRevision
varFmeaAssetApplication
varExecutionPlan
```

Estos nombres son candidatos técnicos, no contratos para IT.

## 7. Validaciones de referencias — Library

El adaptador debe detectar como mínimo:

```text
FmeaRevision.fmeaDefinitionId exists in active FmeaDefinition
FmeaFunction.fmeaRevisionId exists
FunctionalFailure.fmeaFunctionId exists
FailureMode.functionalFailureId exists
FailureCause.failureModeId exists
FailureEffect.failureModeId exists
ConsequenceAssessment.failureModeId exists
RcmAssessment.failureModeId exists
RcmAssessment.consequenceAssessmentId exists when supplied
MaintenanceTask.fmeaRevisionId exists
TaskFailureModeLink.maintenanceTaskId exists
TaskFailureModeLink.failureModeId exists
NoScheduledTaskDecision.failureModeId exists
```

Un error de referencia no debe ocultarse con un `LookUp` que devuelva blank sin diagnóstico.

## 8. Validaciones — Asset Application

```text
assetApplication.fmeaRevisionId exists in LibraryState
asset exists
operationalContextSnapshot exists
assetCriticalitySnapshot exists
applicabilityDecisions[].maintenanceTaskId exists in LibraryState
```

Regla crítica:

```text
AssetCriticalitySnapshot
```

se carga como objeto contextual separado. No se deriva ni inicializa a partir de `ConsequenceAssessment`.

## 9. Validaciones — Execution Plan

```text
executionPlan.fmeaAssetApplicationId matches active application
executionPlan.tasks[].maintenanceTaskId exists in LibraryState
procedureRef exists when non-null
inspectionFormatRef exists when non-null
```

Un intervalo contextual del plan puede diferir del default de la tarea; ambas cifras deben seguir disponibles para explicar un override.

## 10. Validaciones — Results

```text
MaintenanceResult.executionPlanTaskId exists
ActualMaintenanceCost.maintenanceResultId exists
EffectivenessReview.fmeaAssetApplicationId exists
```

El adaptador no modifica la biblioteca ante un `EffectivenessReview` que proponga cambio. Solo carga/crea la referencia a `EngineeringChangeRequest` cuando exista.

## 11. Diagnósticos del adaptador

El runtime debe exponer una colección/estructura de diagnósticos con forma conceptual:

```text
DiagnosticId
Severity
Layer
ObjectType
ObjectId
Rule
Message
SuggestedAction
```

Severidades candidatas:

```text
info
warning
error
fatal
```

### Ejemplos

```text
fatal  | fixture | CaseFixture | P101... | unsupported fixture version
error  | library | FailureMode | FM-03 | missing FunctionalFailure
error  | plan | ExecutionPlanTask | EPT-01 | unknown MaintenanceTask
warning| library | FmeaRevision | ... | rule is to_validate
```

## 12. Estado de carga

El shell debe poder distinguir:

```text
NoFixture
LoadingFixture
Loaded
LoadedWithWarnings
BlockedInvalidFixture
UnsupportedLegacyFixture
Error
```

`LoadedWithWarnings` puede permitir navegar cuando el warning representa una regla todavía `to_validate`, pero no cuando existe una referencia rota.

## 13. Dirty state por capa

No usar un único booleano global si impide saber qué agregado cambió.

Conceptualmente:

```text
LibraryDirty
AssetApplicationDirty
ExecutionPlanDirty
ResultsDirty
```

Esto es especialmente importante para no interpretar un cambio en P-101 como una modificación de `FmeaRevision`.

## 14. Read-only por revisión

Cuando la revisión activa está publicada:

```text
LibraryState.IsReadOnly = true
```

Las capas posteriores pueden seguir siendo editables según su propio estado.

Por tanto es incorrecto:

```text
Published FmeaRevision
→ entire CaseFixture read-only
```

La inmutabilidad pertenece al agregado publicado, no al caso completo.

## 15. Snapshots

El adaptador conserva IDs de snapshots:

```text
FmeaRevision.publishedSnapshotId
OperationalContextSnapshot.snapshotId
AssetCriticalitySnapshot.snapshotId
ExecutionPlan.publishedSnapshotId?
```

No reconstruye el pasado a partir del estado maestro actual.

## 16. Recomendación vs decisión

Cuando cargue objetos con automatización debe mantener campos separados:

```text
systemRecommendation
humanDecision
overrideReason
```

No normalizar en un único campo `decision` salvo que el objeto de dominio realmente defina solo una decisión humana final y la recomendación no aplique.

## 17. Mapeo N:M

`taskFailureModeLinks[]` se carga como colección puente independiente.

Nunca transformar automáticamente:

```text
MaintenanceTask.FailureModeId = first related FailureMode
```

porque destruiría cardinalidad y trazabilidad.

## 18. Procedimientos y formatos

Los refs se resuelven contra colecciones separadas.

```text
MaintenanceTask.procedureRef?
MaintenanceTask.inspectionFormatRef?
ExecutionPlanTask.procedureRef?
ExecutionPlanTask.inspectionFormatRef?
```

La ausencia de uno de estos objetos no debe crear un registro vacío ficticio.

## 19. Economía

El adaptador expone tres datasets separados:

```text
EconomicAssessment
MaintenanceCostEstimate
ActualMaintenanceCost
```

Una vista comparativa puede unirlos para lectura, pero no crea una colección maestra editable `Economics`.

## 20. Lineage mínimo en runtime

Debe poder resolverse:

```text
FmeaDefinition
→ FmeaRevision
→ FailureMode
→ RcmAssessment
→ MaintenanceTask / NoScheduledTaskDecision
→ FmeaAssetApplication
→ ExecutionPlan
→ ExecutionPlanTask
→ MaintenanceResult
→ EffectivenessReview
```

La resolución puede usar relaciones del propio modelo además de `traceability.lineage`, pero los IDs son obligatorios.

## 21. Persistencia local del laboratorio

Si se habilita guardado local durante una sesión, debe guardar el estado por agregado o un envelope que conserve explícitamente las cuatro secciones.

No se define aquí:

- SQL;
- Dataverse;
- SharePoint;
- API;
- Power Automate;
- almacenamiento productivo.

Elegir cualquiera de esas tecnologías sería una decisión posterior.

## 22. Pruebas mínimas del adaptador

### Happy path

```text
[ ] p101-case.v2 carga sin error estructural
[ ] FmeaDefinition y Revision quedan identificadas
[ ] P-101 solo está en AssetApplicationState
[ ] N:M tiene 4 vínculos del fixture
[ ] Procedure e InspectionFormat se resuelven independientemente
[ ] Plan conserva maintenanceTaskId
[ ] Result conserva executionPlanTaskId
[ ] ActualMaintenanceCost no modifica estimate
```

### Negative path

```text
[ ] fixture v1 devuelve UnsupportedLegacyFixture
[ ] fmeaRevision con definición inexistente bloquea
[ ] failureMode huérfano bloquea
[ ] taskFailureModeLink huérfano bloquea
[ ] application con revisión desconocida bloquea
[ ] plan con task desconocida bloquea
[ ] result con executionPlanTask desconocida bloquea
```

## 23. Gate técnico

La forma concreta del adaptador Power Fx no se escribirá hasta F01-00.

F01-00 debe confirmar:

- si `ParseJSON` es adecuado en el entorno disponible;
- mecanismo real para cargar el texto JSON;
- límites de tipos no tipados/typed parsing de la versión disponible;
- convención real de variables/colecciones;
- estrategia de errores compatible con el baseline de la app.

Nada de lo anterior cambia el contrato funcional descrito en este documento.
