# Migración conceptual — Fixture P-101 v1 → v2

**Fecha:** 2026-08-11  
**Objetivo:** impedir que el Runtime Adapter o futuros componentes reconstruyan accidentalmente el modelo asset-centric de la v1.

## 1. Regla

`p101-case.v1.json` es evidencia histórica.

`p101-case.v2.json` es la fuente canónica para nuevos desarrollos.

No se debe escribir un adaptador que cargue v1 y la trate como equivalente semántico de v2 sin una transformación explícita.

## 2. Cambio de raíz

### v1

```text
Case P-101
├─ asset
├─ functions
├─ failureAnalysis
├─ risk
├─ rcm
├─ treatment
├─ plan
└─ effectiveness
```

### v2

```text
CaseFixture
├─ engineeringLibrary
├─ assetApplication
├─ executionPlan
├─ results
└─ traceability
```

P-101 se desplaza desde la raíz conceptual a `assetApplication.asset`.

## 3. Mapeo de contenidos

| v1 | v2 | Regla de migración |
|---|---|---|
| `asset` | `assetApplication.asset` | Solo identidad/contexto del activo. No arrastra contenido AMEF. |
| `operationalContext` | `assetApplication.operationalContextSnapshot` | Congelar contexto usado para la aplicación. |
| `evidence.sources` | `engineeringLibrary.governance.evidenceSources` y referencias específicas | Separar evidencia reusable de evidencias de aplicación/ejecución cuando existan. |
| `functions.mainFunction/secondaryFunction` | `engineeringLibrary.functions[]` | Crear entidades `FmeaFunction` con IDs. |
| `functions.functionalFailures` | `engineeringLibrary.functionalFailures[]` | Crear entidades ligadas por `fmeaFunctionId`. |
| `failureAnalysis.failureModes` | `engineeringLibrary.failureModes[]` | Crear IDs estables y ligar a `functionalFailureId`. |
| modo redactado con mecanismo implícito | `failureCauses[]` | Extraer causas/mecanismos cuando sean realmente causas; no duplicar texto sin criterio. |
| `failureAnalysis.effects` | `failureEffects[]` | Crear efectos tipados/ordenados por `failureModeId`. |
| `risk` | `consequenceAssessments[]` | Convertir evaluación AMEF con referencia a matriz/version. |
| `risk.criticalOverride` | **sin mapeo automático** | Campo deprecado. No convertirlo en criticidad del activo ni en riesgo sin revisión semántica. |
| `rcm` | `rcmAssessments[]` + `answers[]` | Conservar lógica versionada, respuestas, recomendación y decisión. |
| `treatment.task` | `maintenanceTasks[]` | Extraer definición reusable de tarea. |
| vínculo implícito a `focusMode` | `taskFailureModeLinks[]` | Crear N:M explícita; no asumir un único modo. |
| `taskTechnique`/detalles de cómo ejecutar | `maintenanceProcedures[]` cuando corresponda | No todo texto técnico es procedimiento; validar granularidad. |
| campos de captura/criterios | `inspectionFormats[]` cuando corresponda | Separar estructura de registro de la tarea. |
| ausencia de tarea | `noScheduledTaskDecisions[]` | Debe convertirse en decisión explícita, nunca en array vacío por omisión semántica. |
| `treatment.economics` — consecuencias/escenarios | `economicAssessments[]` | Comparación económica para decisión. |
| `treatment.economics` — horas/material/frecuencia | `maintenanceCostEstimates[]` | Coste previsto de ejecutar. |
| `plan` | `executionPlan` | Solo después de `FmeaAssetApplication` validada. |
| `governance.version` | `fmeaRevision.revisionNumber` o revisión del plan según significado | No existe una única “versión del caso”. |
| `effectiveness.actualCost` | `results.actualMaintenanceCosts[]` | Coste observado ligado a resultado real. |
| `effectiveness.actualDetection/failures` | `maintenanceResults` / `effectivenessReviews` | Resultado observado y comparación posterior. |
| `effectiveness.reviewDecision` | `effectivenessReviews[]` | Puede abrir `EngineeringChangeRequest`; no sobrescribe biblioteca. |

## 4. Campos v1 deprecados

Los siguientes nombres no deben reaparecer como conceptos canónicos:

```text
criticalOverride       // ambiguo: mezclaba criticidad y risk override
focusMode              // útil para UI narrativa, no relación de datos
case version           // sustituido por revisiones por agregado
plan as treatment      // ahora capa independiente
actualCost in effectiveness // ahora ActualMaintenanceCost
```

`focusMode` puede seguir existiendo únicamente como estado de navegación/presentación, nunca como cardinalidad del modelo.

## 5. Regla especial de criticidad

No existe migración válida:

```text
v1.risk.criticalOverride
→ v2.assetApplication.assetCriticalitySnapshot
```

porque representan conceptos diferentes.

La criticidad de P-101 en v2 debe venir de una fuente/esquema de criticidad identificado; el fixture utiliza un valor demostrativo explícitamente marcado como no corporativo.

## 6. Regla especial de tarea

La transformación v1:

```text
focusMode = FM-03
treatment.task = X
```

no puede producir automáticamente:

```text
Task X → only FM-03
```

La relación debe revisarse como N:M. El fixture v2 demuestra que una tarea de monitorización puede aportar tratamiento a FM-03 y FM-09, y que FM-03 puede tener más de una tarea relacionada.

## 7. Estrategia del Runtime Adapter

El primer adaptador Power Apps debe implementar v2 directamente.

Estructura conceptual mínima:

```text
LoadCaseFixtureV2
→ Validate fixtureVersion
→ Parse EngineeringLibrary
→ Parse AssetApplication
→ Parse ExecutionPlan
→ Parse Results
→ Validate lineage
→ Initialize Layered Functional State
```

Si por razones de demostración se necesitase abrir v1, se debe implementar un adaptador separado `LegacyV1Adapter` y mostrar un aviso de que el contenido no cumple el modelo actual. No debe ser fallback silencioso.

## 8. Pruebas mínimas de migración

```text
[ ] P-101 no aparece como padre de FmeaRevision
[ ] todas las funciones tienen ID y fmeaRevisionId
[ ] todos los fallos funcionales tienen fmeaFunctionId
[ ] todos los modos tienen functionalFailureId
[ ] causas/efectos referencian failureModeId
[ ] RCM conserva decisionLogicVersionRef
[ ] tarea-modo se expresa mediante links N:M
[ ] procedimiento/formato no son campos inseparables de MaintenanceTask
[ ] risk AMEF no contiene AssetCriticality
[ ] AssetCriticality tiene esquema/fuente propios
[ ] economía/estimación/actual están separadas
[ ] ExecutionPlan referencia FmeaAssetApplication
[ ] MaintenanceResult referencia ExecutionPlanTask
[ ] lineage puede reconstruirse por IDs
```
