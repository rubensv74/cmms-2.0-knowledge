# CMMS 2.0 Functional Lab — Contratos funcionales de componentes

**Estado:** foundation v2  
**Fecha:** 2026-08-11  
**Alcance:** contratos conceptuales; no son todavía componentes Power Apps implementados.

## 1. Propósito

Definir patrones reutilizables que mantengan visible la arquitectura `Library → Asset Application → Execution Plan → Results` y eviten que la UI vuelva a mezclar responsabilidades de dominio.

Los nombres son candidatos canónicos. La implementación real y el formato YAML se prepararán únicamente cuando exista una Canvas app baseline validada y se confirme el contrato Source Code disponible.

## 2. Regla general

Un componente premium puede simplificar la interfaz, pero no puede borrar:

- capa activa;
- identidad/revisión del objeto;
- origen del dato;
- diferencia entre cálculo, recomendación y decisión;
- override y motivo;
- lineage.

## 3. `cmp_LayerContextHeader`

### Propósito

Mostrar qué objeto y capa está trabajando el usuario.

### Inputs conceptuales

```text
Layer
ObjectType
ObjectId
ObjectCode
ObjectName
Revision
Status
SourceObjectId
SourceLabel
IsReadOnly
```

### Estados

- library;
- asset_application;
- execution_plan;
- results;
- loading;
- error.

### Regla

En WS-01 a WS-06 el activo no debe presentarse como objeto primario. En WS-07 a WS-09 puede mostrarse el activo junto con la revisión de biblioteca de origen.

## 4. `cmp_RevisionStatusBadge`

### Propósito

Representar de forma coherente revisión, estado de gobernanza e inmutabilidad.

### Inputs

```text
Revision
Status
ValidationStatus
IsPublishedSnapshot
```

### Salidas/eventos

Ninguno de negocio. Es visual.

### Regla

Una revisión publicada debe visualizarse inequívocamente como solo lectura.

## 5. `cmp_TraceabilityBreadcrumb`

### Propósito

Permitir seguir el lineage sin depender del texto de las pantallas.

### Data shape

```text
[
  {
    Layer,
    ObjectType,
    ObjectId,
    Label,
    Revision,
    Status
  }
]
```

### Comportamiento esperado

Puede navegar a detalles o abrir una vista de trazabilidad, pero nunca reconstruye relaciones desde nombres visibles; consume IDs ya resueltos por el estado funcional.

## 6. `cmp_DecisionCard`

### Propósito

Diferenciar recomendación del sistema y decisión humana.

### Inputs

```text
DecisionId
QuestionOrDecisionType
SystemRecommendation
HumanDecision
OverrideReason
AuthorityRole
ValidationStatus
RuleId
RuleVersion
EvidenceCount
IsReadOnly
```

### Estados visuales

- recommendation_pending;
- accepted;
- overridden;
- blocked;
- to_validate;
- read_only.

### Regla

Nunca sustituye `SystemRecommendation` por `HumanDecision`. Si existe override, ambos valores permanecen visibles.

## 7. `cmp_GatePanel`

### Propósito

Explicar por qué un objeto puede o no avanzar/publicarse.

### Inputs

```text
GateId
Layer
ObjectType
ObjectId
Status
Reasons[]
MissingItems[]
RequiredRole
RuleId
RuleVersion
ValidationStatus
SuggestedAction
```

### Estados

- passed;
- warning;
- blocked;
- evaluating.

### Regla

No basta con desactivar el botón de avance. El panel debe explicar el bloqueo y distinguir una regla aprobada de una simulación del laboratorio.

## 8. `cmp_TaskModeRelationMatrix`

### Propósito

Hacer visible y editable, cuando corresponda, la relación N:M entre `MaintenanceTask` y `FailureMode`.

### Data shape

```text
Tasks[]
FailureModes[]
Links[] = {
  MaintenanceTaskFailureModeId,
  MaintenanceTaskId,
  FailureModeId,
  TreatmentPurpose,
  Rationale
}
```

### Comportamientos

- seleccionar tarea → resaltar todos los modos tratados;
- seleccionar modo → mostrar todas las tareas relacionadas;
- detectar vínculos huérfanos;
- permitir justificar finalidad del vínculo;
- no duplicar la tarea para representar varios modos.

### Gate funcional

Una tarea aprobable debe tratar al menos un modo o estar explícitamente fuera del flujo AMEF/RCM.

## 9. `cmp_AttachmentRefs`

### Propósito

Representar asociaciones opcionales desde una tarea/plan a `MaintenanceProcedure` e `InspectionFormat`.

### Inputs

```text
MaintenanceTaskId
ProcedureRef?
ProcedureRevision?
InspectionFormatRef?
InspectionFormatRevision?
IsReadOnly
```

### Regla

No debe obligar visualmente a que toda tarea tenga procedimiento o formato. La necesidad debe venir de una regla funcional identificada.

## 10. `cmp_AssetApplicationContextCard`

### Propósito

Mostrar la aplicación de una revisión a un activo sin mezclar datos de biblioteca y activo.

### Inputs

```text
FmeaAssetApplicationId
FmeaDefinitionCode
FmeaRevision
AssetId
AssetCode
AssetName
OperationalContextSnapshot
AssetCriticalitySnapshot
AssetCriticalityOverride?
ApplicabilityResult
ValidatedApplicabilityResult
```

### Regla crítica

La tarjeta debe separar visualmente:

```text
Library source
Asset/context
Asset criticality
Applicability decision
```

Nunca debe presentar la criticidad del activo como resultado de la matriz AMEF.

## 11. `cmp_RiskAssessmentCard`

### Propósito

Representar `ConsequenceAssessment` en WS-03.

### Inputs

```text
FailureModeId
RiskMatrixVersionRef
ConsequenceCategory
RiskDimensions[]
CalculatedRiskResult
HumanAssessment
Rationale
EvidenceRefs[]
ValidationStatus
```

### Regla

El título y terminología deben referirse a consecuencia/riesgo AMEF, no a “criticidad del activo”.

## 12. `cmp_EconomicComparison`

### Propósito

Comparar información económica sin fusionar sus capas.

### Secciones

```text
EconomicAssessment        // decisión de ingeniería
MaintenanceCostEstimate   // previsión
ActualMaintenanceCost     // observado, solo cuando existe resultado
```

### Inputs conceptuales

```text
EconomicAssessment?
MaintenanceCostEstimate?
ActualMaintenanceCost?
Currency
ValidationStatus
```

### Regla

El coste observado nunca se edita como si fuera la actualización de una estimación previa.

## 13. `cmp_NoScheduledTaskDecision`

### Propósito

Representar una salida RCM sin tarea programada.

### Inputs

```text
FailureModeId
DecisionType
Rationale
ResidualRiskAcceptanceRef?
AuthorityRole
Status
```

### Regla

El componente evita que “sin tarea” sea simplemente una tabla vacía o un botón no seleccionado.

## 14. `cmp_ResultVsHypothesis`

### Propósito

Comparar resultados reales con las hipótesis que originaron una aplicación/plan.

### Inputs

```text
SourceHypotheses[]
MaintenanceResults[]
MaintenanceCostEstimate?
ActualMaintenanceCosts[]
EffectivenessDecision
EngineeringChangeRequestId?
```

### Regla

La comparación puede generar una recomendación de cambio, pero no modifica automáticamente `FmeaRevision`.

## 15. Composición recomendada por workspace

| Workspace | Componentes prioritarios |
|---|---|
| WS-01 Library & Revision | `cmp_LayerContextHeader`, `cmp_RevisionStatusBadge`, `cmp_GatePanel` |
| WS-02 Functions & Failure Structure | `cmp_LayerContextHeader`, estructura Data Explorer, `cmp_TraceabilityBreadcrumb` |
| WS-03 Consequence & Risk | `cmp_RiskAssessmentCard`, `cmp_DecisionCard`, `cmp_GatePanel` |
| WS-04 RCM Decision | `cmp_DecisionCard`, `cmp_NoScheduledTaskDecision`, `cmp_TraceabilityBreadcrumb` |
| WS-05 Treatment Engineering | `cmp_TaskModeRelationMatrix`, `cmp_AttachmentRefs`, `cmp_EconomicComparison` |
| WS-06 Library Publication | `cmp_RevisionStatusBadge`, `cmp_GatePanel`, `cmp_TraceabilityBreadcrumb` |
| WS-07 Asset Application | `cmp_AssetApplicationContextCard`, `cmp_DecisionCard`, `cmp_GatePanel` |
| WS-08 Execution Plan | `cmp_LayerContextHeader`, `cmp_AttachmentRefs`, `cmp_EconomicComparison` |
| WS-09 Results & Improvement | `cmp_ResultVsHypothesis`, `cmp_EconomicComparison`, `cmp_TraceabilityBreadcrumb` |

## 16. Reutilización desde Pulse

Los componentes de Pulse pueden reutilizarse cuando su contrato visual encaje (`PageHeader`, `DataTable`, `EmptyState`, etc.), pero los componentes de dominio anteriores necesitan contratos específicos del Functional Lab.

No se debe reutilizar un componente de Pulse para resolver una necesidad semántica distinta solo porque tenga un aspecto similar.

## 17. Gate para implementación

Antes de crear YAML de cualquiera de estos componentes se debe disponer de:

```text
[ ] Canvas app baseline real
[ ] Source Code schema confirmado
[ ] versiones reales de controles confirmadas
[ ] componentes ya instalados identificados
[ ] contrato de inputs/outputs validado para el workspace
[ ] primera instancia pequeña preparada para validación Studio
```

Hasta entonces, estos documentos son contratos funcionales y de interacción, no código pendiente de copiar.
