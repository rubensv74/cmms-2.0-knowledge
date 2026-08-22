# CMMS 2.0 Functional Lab — Mock Data Provider Contract v1

**Estado:** active contract  
**Fecha:** 2026-08-22  
**Rama:** `baseline/premium-powerapps-v1`  
**Objetivo inmediato:** soportar P3 Mock Data Provider y el vertical slice WS-01 sin dependencia de SQL.

## 1. Principio

El proveedor mock no es un conjunto de `ClearCollect()` repartidos por pantallas.

Es una implementación temporal del contrato lógico de datos:

```text
Workspace / Component
→ Functional State / View Model
→ Data Contract
→ Mock Provider
```

La futura sustitución por SQL, Power Automate o API debe conservar el significado del contrato aunque cambie la forma física de persistencia.

## 2. Reglas obligatorias

1. Las pantallas no crean datos fuente.
2. La inicialización se centraliza.
3. Los IDs son estables y opacos para la UI.
4. Una colección representa una responsabilidad clara.
5. Los datos fuente se separan del estado mutable.
6. Los cálculos y recomendaciones del sistema se separan de las decisiones humanas.
7. Las proyecciones `colView_*` nunca son fuente de verdad.
8. Los campos relevantes deben ser escalares cuando sea razonable para facilitar Power Fx, SQL y futuras APIs.
9. Las relaciones se expresan mediante claves estables, no mediante posiciones de galería.
10. El contrato debe poder versionarse si cambia su significado.

## 3. Convención de claves

La app consumirá claves lógicas de texto, por ejemplo:

```text
caseKey
assetKey
functionKey
functionalFailureKey
failureModeKey
riskProfileKey
planKey
planVersionKey
taskKey
```

La UI no debe asumir si detrás existe un `bigint`, `uniqueidentifier`, clave compuesta o identificador externo.

Ejemplos iniciales:

```text
caseKey  = "CASE-P101-001"
assetKey = "ASSET-P101"
```

Estas claves serán estables dentro del Functional Lab.

## 4. Familias de colecciones

### `colCfg_*`

Configuración funcional.

### `colData_*`

Datos fuente del escenario.

### `colState_*`

Estado mutable de la sesión.

### `colView_*`

Proyecciones preparadas para la UI.

## 5. Catálogo canónico inicial

### 5.1. Datos de caso y activo

#### `colData_Cases`

| Campo | Tipo lógico | Uso |
|---|---|---|
| `caseKey` | text | ID estable del caso |
| `fixtureVersion` | text | versión del fixture |
| `caseName` | text | nombre visible |
| `assetKey` | text | relación con activo principal |
| `disclaimer` | text | aviso de uso conceptual |
| `validationStatus` | text | estado funcional del caso |

#### `colData_Assets`

| Campo | Tipo lógico | Uso |
|---|---|---|
| `assetKey` | text | ID lógico estable |
| `assetCode` | text | tag/código visible |
| `assetName` | text | descripción |
| `plant` | text | planta/unidad principal |
| `unit` | text | subunidad si aplica |
| `service` | text | servicio funcional |
| `boundary` | text | frontera física del análisis |
| `dutyFlowM3h` | decimal | demanda de caudal |
| `dutyPressureBar` | decimal | presión de servicio |
| `redundancy` | text | redundancia disponible |
| `constraints` | text | restricciones operacionales |

#### `colData_OperatingModes`

| Campo | Tipo lógico | Uso |
|---|---|---|
| `operatingModeKey` | text | ID estable |
| `assetKey` | text | activo relacionado |
| `modeName` | text | modo operacional |
| `sortOrder` | integer | orden visual |

#### `colData_EvidenceSources`

| Campo | Tipo lógico | Uso |
|---|---|---|
| `evidenceKey` | text | ID estable |
| `caseKey` | text | caso relacionado |
| `sourceName` | text | fuente disponible |
| `sourceType` | text | tipo/categoría cuando se conozca |
| `availabilityStatus` | text | `available`, `missing`, `to_confirm` |
| `isCritical` | boolean | si bloquea el gate de preparación |
| `notes` | text | observación |

### 5.2. Ingeniería funcional

#### `colData_Functions`

Campos mínimos:

```text
functionKey
caseKey
assetKey
functionType
functionText
performanceStandard
sortOrder
validationStatus
```

#### `colData_FunctionalFailures`

```text
functionalFailureKey
functionKey
failureType
failureText
sortOrder
validationStatus
```

#### `colData_FailureModes`

```text
failureModeKey
functionalFailureKey
modeCode
modeName
modeDescription
isFocusMode
isExcluded
exclusionReason
validationStatus
```

#### `colData_FailureEffects`

```text
failureEffectKey
failureModeKey
localEffect
systemEffect
operationalEffect
```

### 5.3. Configuración de riesgo

#### `colCfg_RiskProfiles`

```text
riskProfileKey
profileCode
profileName
version
status
scope
severityLevelCount
likelihoodLevelCount
calculationNote
```

#### `colCfg_RiskLevels`

```text
riskLevelKey
riskProfileKey
dimension
levelValue
levelName
levelDescription
sortOrder
```

No se interpreta `severityLevelCount = 5` como regla global del producto.

### 5.4. Decisiones RCM

#### `colCfg_RcmQuestions`

```text
questionKey
questionCode
questionText
parentQuestionKey
answerValue
nextQuestionKey
resultPolicyKey
sortOrder
validationStatus
```

El contrato representa ramas; no scoring acumulado.

#### `colState_RcmDecisionTrace`

```text
traceKey
caseKey
failureModeKey
questionKey
answer
explanation
branch
technicalFeasibility
technicalEffectiveness
systemRecommendation
humanDecision
reason
actorRole
validationStatus
sequence
```

### 5.5. Plan y aplicabilidad

#### `colData_BasePlans`

```text
planKey
caseKey
planName
discipline
workCenter
crew
laborHours
tools
spares
shutdownRequirement
permitRequirement
groupingLabel
validationStatus
```

#### `colData_PlanTasks`

```text
taskKey
planKey
taskName
technique
acceptanceCriterion
actionIfFailed
intervalValue
intervalUnit
planningWindowDays
sortOrder
```

#### `colData_CandidateAssets`

```text
candidateKey
planKey
assetKey
selectionReason
systemConfidence
recommendationStatus
```

#### `colState_ApplicabilityDecisions`

```text
applicabilityDecisionKey
candidateKey
decision
reason
actorRole
validationStatus
```

#### `colState_AssetPlanOverrides`

```text
overrideKey
planKey
assetKey
overrideType
baseTaskKey
fieldName
baseValue
overrideValue
reason
actorRole
validationStatus
```

Un override nunca modifica silenciosamente el plan base.

### 5.6. Gobernanza y trazabilidad

#### `colState_DecisionTrace`

```text
traceKey
caseKey
stageId
ruleId
configurationKey
inputSnapshot
systemResult
systemRecommendation
humanDecision
reason
actorRole
validationStatus
timestampLocal
```

#### `colState_Gates`

```text
gateKey
caseKey
stageId
gateStatus
reasonCode
reasonText
missingData
checkedAtLocal
```

Estados permitidos inicialmente:

```text
passed
blocked
warning
not_evaluated
```

### 5.7. Publicación

#### `colState_PublishedPlanVersions`

```text
publishedPlanVersionKey
planKey
version
publicationStatus
approvedByMaintenance
approvedByOperations
approvedByReliability
approvedByAssetOwner
publicationNote
publishedAtLocal
```

No incluye todavía órdenes de trabajo.

## 6. Contrato mínimo de WS-01

WS-01 no debe cargar o editar todo el modelo anterior.

Su Data Contract v1 queda limitado a:

```text
CaseContext
├── caseKey
├── caseName
├── fixtureVersion
├── assetKey
├── assetCode
├── assetName
├── plant
├── unit
├── service
├── boundary
├── dutyFlowM3h
├── dutyPressureBar
├── redundancy
├── constraints
├── operatingModes[]
├── evidenceSources[]
└── dataConfidence
```

### Estado mutable de WS-01

`colState_CaseContextEdits`

```text
caseKey
fieldName
originalValue
currentValue
changedByRole
changeReason
isDirty
```

`colState_EvidenceConfirmation`

```text
caseKey
evidenceKey
confirmed
comment
actorRole
```

`colState_Gates` registrará el resultado de FL-03.

## 7. View Model de WS-01

La pantalla podrá consumir una proyección como:

```text
colView_CaseContext
```

con una única fila para el caso activo y campos ya resueltos para presentación.

Debe construirse a partir de:

```text
colData_Cases
+ colData_Assets
+ colState_CaseContextEdits
+ colState_EvidenceConfirmation
+ colState_Gates
```

No se editará directamente `colView_CaseContext`.

## 8. Operaciones funcionales iniciales

Las acciones de UI se expresarán conceptualmente como:

```text
LoadDemoCase
ResetDemoCase
UpdateCaseContext
ConfirmEvidence
EvaluateContextGate
ConfirmCaseContext
BuildWorkspaceOutput
```

En v1 son operaciones locales.

En una fase SQL/Flow/API podrán cambiar de implementación sin cambiar su intención funcional.

## 9. Inicialización

Secuencia conceptual:

```text
LoadDemoConfiguration
→ LoadDemoReferenceData
→ LoadDemoCase("CASE-P101-001")
→ InitializeRuntimeState
→ EvaluateContextGate
→ BuildViewModels
```

No se fijará todavía la fórmula Power Fx definitiva hasta validar la Canvas App real y su dialecto Source Code.

## 10. Reset de demo

`ResetDemoCase` debe:

1. limpiar únicamente estado mutable y vistas derivadas;
2. recargar los datos fuente del fixture;
3. reconstruir estado inicial;
4. recalcular gates;
5. reconstruir vistas;
6. volver a un estado conocido de presentación.

No debe depender de reiniciar manualmente la aplicación.

## 11. Definition of Done — P3

P3 Mock Data Provider estará completado cuando:

- exista un loader central;
- P-101 se materialice con IDs estables;
- WS-01 consuma el contrato mínimo anterior;
- no haya `ClearCollect` de datos fuente dentro de controles o pantallas;
- reset/reload sea determinista;
- datos fuente, estado y vistas estén separados;
- pueda trazarse cada campo importante al fixture o a una decisión runtime;
- el contrato tenga un mapeo candidato a SQL sin exigir cambiar la UI.
