# CMMS 2.0 — P01 Synthetic Provider Contract v1

**Fecha:** 2026-08-22  
**Estado:** active development contract

## 1. Propósito

Proporcionar datos locales suficientes para construir y validar `Foundation + Project Setup` sin SQL, manteniendo formas de datos reemplazables por un provider real.

## 2. Regla

Los datos sintéticos se cargan de forma centralizada.

No se permite:

```text
Screen.OnVisible → ClearCollect(master data...)
Control.Items → [records hardcoded only for that control]
```

Patrón:

```text
App startup / provider initialization
→ LoadSyntheticProjects
→ LoadSyntheticMaintenanceConfiguration
→ LoadSyntheticRiskProfiles
→ LoadSyntheticProjectRoles
→ BuildProjectViews
```

## 3. Colecciones fuente

### `colCfg_Projects`

Campos mínimos:

```text
ProjectId
ProjectCode
ProjectName
Description
BusinessUnit
SiteName
CountryCode
TimeZone
DefaultLanguage
Status
ConfigurationStatus
StartDate
TargetOperationalDate
```

### `colCfg_ProjectMaintenance`

```text
ConfigurationRecordId
ProjectId
ConfigurationVersion
SettingKey
SettingValueText
SettingValueBoolean
SettingValueNumber
SourceScope
SourceReferenceId
OverrideAllowed
Status
```

Solo uno de los campos Value se usa según tipo; la implementación Power Fx final puede ajustar la forma para evitar un diseño incómodo.

### `colCfg_RiskProfiles`

```text
RiskProfileId
ProjectId?
Scope
Name
Description
SourceRiskProfileId?
ActiveVersionId
Status
```

### `colCfg_RiskProfileVersions`

```text
RiskProfileVersionId
RiskProfileId
Version
Status
EffectiveFrom
```

### `colCfg_RiskDimensions`

```text
DimensionId
RiskProfileVersionId
Code
Name
Description
DataType
DisplayOrder
```

### `colCfg_RiskLevels`

```text
LevelId
DimensionId
Code
Label
NumericValue
MinValue
MaxValue
Description
DisplayOrder
```

### `colCfg_RiskBands`

```text
BandId
RiskProfileVersionId
Code
Label
SemanticLevel
ColorToken
Priority
```

### `colCfg_RiskRules`

```text
RuleId
RiskProfileVersionId
RuleType
InputKey
ResultBandId
ResultValue
Description
ValidationStatus
```

Durante P01 puede utilizarse una representación tabular explícita de combinaciones para demostrar el motor configurable sin inventar todavía un motor de expresiones genérico.

### `colCfg_RiskOverrideRules`

```text
OverrideRuleId
RiskProfileVersionId
Code
Description
ConditionKey
ResultBandId
Priority
Status
```

### `colCfg_ProjectRoles`

```text
ProjectRoleId
ProjectId
RoleCode
RoleName
Purpose
Required
AuthorityScope
Status
```

### `colCfg_ProjectRoleAssignments`

```text
AssignmentId
ProjectRoleId
PrincipalId
PrincipalDisplayName
PrincipalType
EffectiveFrom
EffectiveTo
Status
```

## 4. Estado de runtime

### `colState_AppContext`

Debe conservar al menos:

```text
SelectedProjectId
SelectedScope
SelectedNavigationId
IsContextChanging
```

### `colState_DirtyObjects`

```text
ObjectType
ObjectId
ScreenId
IsDirty
ChangedAt
```

### `colState_RiskEditor`

Estado temporal de la versión en edición; no sustituye a la colección fuente.

## 5. View models

### `colView_Portfolio`

Derivada de Project + configuración.

Debe poder mostrar:

- ProjectCode;
- ProjectName;
- SetupStatus;
- RiskProfileStatus;
- RequiredRolesCoverage;
- NeedsAttentionCount.

### `colView_ProjectReadiness`

Indicadores P01:

```text
ProjectProfileComplete
MaintenanceConfigurationComplete
RiskProfileReady
RequiredRolesCovered
OverallSetupStatus
```

### `colView_RiskMatrix`

Proyección visual para las dos dimensiones seleccionadas.

Campos candidatos:

```text
XDimensionId
XLevelId
YDimensionId
YLevelId
ResultBandId
ResultLabel
SemanticLevel
ColorToken
```

No es fuente de verdad; se reconstruye desde configuración/rules.

## 6. Dataset de demostración obligatorio

### Project A — `PRJ-DEMO-01`

Estado esperado:

- perfil de proyecto completo;
- configuración de mantenimiento activa;
- Risk Profile 5×5 activo;
- todos los roles mínimos cubiertos.

Sirve para demostrar un proyecto `Ready`.

### Project B — `PRJ-DEMO-02`

Estado esperado:

- Project Profile válido;
- Maintenance Configuration parcialmente heredada;
- Risk Profile alternativo en draft;
- al menos un rol requerido sin asignación.

Sirve para demostrar `Needs Attention`.

## 7. Risk Profile A

Perfil sintético 5×5.

Uso: demostrar una matriz convencional sin convertirla en regla universal.

Dimensiones candidatas:

```text
Severity: 1..5
Likelihood: 1..5
```

Bandas candidatas:

```text
Low
Medium
High
Critical
```

Los límites exactos son datos de demostración y deben quedar identificados como tales.

## 8. Risk Profile B

Debe diferir estructuralmente.

Opción recomendada para P01:

```text
Consequence: 1..4
Probability: 1..4
```

con bandas/mapping diferentes.

Objetivo de aceptación:

> Cambiar de Project A a Project B reconstruye la matriz y sus niveles a partir del provider, sin cambiar la fórmula/layout base de la pantalla.

## 9. Operaciones funcionales mock

La UI debe pensar en acciones, no en `Patch` a colecciones concretas.

Operaciones conceptuales:

```text
SelectProject
CreateProjectDraft
UpdateProjectProfile
UpdateMaintenanceSetting
ResetMaintenanceSettingToCorporate
CreateRiskProfileDraft
DeriveRiskProfile
UpdateRiskDimension
UpdateRiskLevel
UpdateRiskBand
UpdateRiskRule
ValidateRiskProfile
ActivateRiskProfileVersion
AssignProjectRole
RemoveProjectRoleAssignment
ValidateProjectSetup
ResetLocalChanges
```

En P01 estas operaciones pueden implementarse con Power Fx local. Posteriormente podrán mapearse a SQL/Flow/API.

## 10. Acceptance tests

```text
[ ] no master data embedded in individual controls
[ ] project switch clears/rebuilds dependent views
[ ] Project A and B preserve isolated state
[ ] two structurally different Risk Profiles render correctly
[ ] dirty guard works before project switch
[ ] reset restores provider source state
[ ] missing role generates Needs Attention
[ ] draft Risk Profile cannot appear as active accidentally
[ ] colView_* can be cleared/rebuilt without losing source data
```
