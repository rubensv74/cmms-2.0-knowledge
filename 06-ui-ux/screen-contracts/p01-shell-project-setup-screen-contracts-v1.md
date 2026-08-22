# CMMS 2.0 — P01 Screen Contracts v1

**Fecha:** 2026-08-22  
**Estado:** active design contract  
**Scope:** Premium Shell + SCR-001/002 + SCR-010/011/012/013.

## 1. Contrato global del shell

### PRIMARY_USER_TASK

Orientarse dentro de CMMS 2.0, mantener visible el contexto Corporate/Project y llegar a cualquier función permitida sin perder contexto.

### SUCCESS_CRITERION

El usuario siempre sabe:

- en qué proyecto/ámbito trabaja;
- qué módulo/pantalla está abierta;
- qué acciones principales están disponibles;
- si existen cambios sin guardar;
- qué funciones requieren atención;
- dónde continuar.

### Estructura canónica

```text
App Root
├── Sidebar / grouped navigation
├── Top Context Layer
│   ├── Corporate / Project selector
│   ├── Global Search
│   ├── Needs Attention
│   └── User / Role
├── Page Host
│   ├── Page Header
│   ├── Command Bar
│   └── Content Host
├── Contextual Drawer / Inspector Host
└── Overlay / Modal Layer
```

### Estados globales

```text
Booting
Ready
ContextChanging
Loading
Dirty
Blocked
Error
NoPermission
```

### Reglas

1. El cambio de proyecto no debe dejar datos del proyecto anterior visibles.
2. Si existen cambios dirty, cambiar de contexto requiere guardado local, descarte o cancelación.
3. La visibilidad de navegación depende de rol y contexto.
4. Un destino aún no implementado se muestra solo si aporta orientación; debe estar marcado `Coming later`/disabled y nunca simular disponibilidad.
5. El shell no contiene reglas específicas de AMEF, RCM, activos o riesgo.

---

# SCR-001 — Portfolio Overview

## Trabajo principal

Ver proyectos accesibles, su madurez general y dónde existe trabajo pendiente.

## Arquetipo

`Operational Control Tower`

## P01 depth

Mínima. En P01 sirve como selector visual de proyecto y prueba del shell. Las métricas de mantenimiento se enriquecerán cuando existan módulos posteriores.

## Inputs

- proyectos accesibles;
- status de configuración;
- Risk Profile status;
- setup completeness;
- Needs Attention summary.

## Outputs

- `SelectedProjectId`;
- navegación a Project Home o Project Setup.

## Acciones

- abrir proyecto;
- crear proyecto si el rol lo permite;
- filtrar/buscar;
- abrir Needs Attention.

## Estados

- loading;
- no projects;
- active projects;
- incomplete setup;
- access denied.

---

# SCR-002 — Project Home / Needs Attention

## Trabajo principal

Entender el estado de configuración del proyecto y abrir la siguiente acción útil.

## Arquetipo

`Operational Control Tower`

## P01 depth

Mostrar únicamente señales derivadas de funciones ya existentes en P01.

### Ejemplos válidos

- Project Profile incomplete;
- Risk Profile draft;
- missing required project role;
- Maintenance Configuration incomplete.

### Ejemplos NO válidos todavía

- overdue Work Orders;
- failed inspections;
- spare shortages;
- schedule conflicts.

## Outputs

- navegación contextual hacia Project Setup.

---

# SCR-010 — Project Profile

## PRIMARY_USER_TASK

Crear y mantener la identidad y el ámbito base de un proyecto CMMS.

## SUCCESS_CRITERION

Existe un `Project` válido, identificable y utilizable como contexto para el resto de CMMS 2.0.

## PRIMARY_ARCHETYPE

`Configuration Studio`

## Roles candidatos

- CMMS Administrator;
- Project CMMS Lead;
- autorizado de configuración de proyecto.

Los nombres finales de rol quedan sujetos al modelo de seguridad productivo.

## Inputs

Contrato mínimo candidato:

```text
Project
- ProjectId
- ProjectCode
- ProjectName
- Description
- BusinessUnit
- Site / Plant context
- Country / Region
- TimeZone
- DefaultLanguage
- Status
- StartDate
- TargetOperationalDate
- MaintenanceScopeDescription
- ConfigurationStatus
- Version
```

No todos los campos son obligatorios en la primera UI. El contrato se estabilizará antes de SQL.

## Acciones

- Create Project;
- Edit Project;
- Save Draft;
- Activate configuration;
- Archive/deactivate where allowed;
- Reset local changes.

## Validaciones

- ProjectCode requerido y único dentro del ámbito acordado;
- ProjectName requerido;
- TimeZone válido;
- no activar un proyecto sin los campos mínimos de configuración.

## Estados

```text
Draft
ActiveConfiguration
Ready
Archived
```

Estos son estados candidatos de configuración, no lifecycle contractual definitivo del proyecto empresarial.

## Outputs

- Project context;
- readiness status;
- input para Maintenance Configuration / Risk Profile / Teams.

---

# SCR-011 — Maintenance Configuration

## PRIMARY_USER_TASK

Definir cómo se comportará CMMS 2.0 para ese proyecto en aspectos configurables de mantenimiento.

## SUCCESS_CRITERION

El proyecto dispone de una configuración explícita y versionada, separada de los datos maestros corporativos.

## PRIMARY_ARCHETYPE

`Configuration Studio`

## Principio

No crear una colección arbitraria de switches. Cada opción debe corresponder a una decisión funcional documentada y debe mostrar su procedencia:

```text
Corporate Default
Project Override
Project Specific
```

## Secciones candidatas P01

### General

- configuration name/version;
- inheritance policy;
- language/unit preferences where applicable.

### Engineering

- allow project-specific taxonomy classes;
- allow asset overrides;
- require AMEF before RCM when applicable;
- approval requirements for publishing engineering outputs.

### Governance

- promotion requests enabled;
- required review roles;
- version/change policy hooks.

No incluir aquí planning/scheduling, Work Order o execution options aún no validadas.

## Inputs

```text
ProjectMaintenanceConfiguration
- ConfigurationId
- ProjectId
- Version
- Status
- SettingKey
- SettingValue
- SourceScope
- SourceReferenceId
- OverrideAllowed
- EffectiveFrom
```

La forma final podrá normalizarse de otra manera en SQL; el contrato lógico debe mantener significado y procedencia.

## Acciones

- inherit defaults;
- override allowed setting;
- reset to corporate default;
- validate;
- publish/activate configuration version.

## Estados

- inherited;
- overridden;
- project-specific;
- invalid;
- draft;
- active.

---

# SCR-012 — Risk Profile / Matrix Configuration

## PRIMARY_USER_TASK

Crear, derivar, revisar y versionar el modelo de riesgo utilizado por Criticality, AMEF y otros consumidores del proyecto.

## SUCCESS_CRITERION

Existe un `RiskProfileVersion` válido que puede ser consumido por otras pantallas sin hardcodear una matriz concreta.

## PRIMARY_ARCHETYPE

`Configuration Studio`

## SECONDARY_PATTERNS

- matrix editor;
- version compare;
- impact analysis;
- contextual inspector.

## Principio obligatorio

No existe una matriz 5×5 fija como regla de CMMS 2.0.

## Contrato lógico candidato

```text
RiskProfile
- RiskProfileId
- Name
- Scope [Corporate | Project]
- SourceRiskProfileId?
- ProjectId?
- Status

RiskProfileVersion
- RiskProfileVersionId
- RiskProfileId
- Version
- EffectiveFrom
- Status

RiskDimension
- DimensionId
- RiskProfileVersionId
- Code
- Name
- Description
- DisplayOrder
- DataType

RiskLevel
- LevelId
- DimensionId
- Code
- Label
- NumericValue?
- MinValue?
- MaxValue?
- Description
- DisplayOrder

RiskBand
- BandId
- RiskProfileVersionId
- Code
- Label
- SemanticLevel
- ColorToken
- Priority

RiskRule
- RuleId
- RiskProfileVersionId
- RuleType
- Inputs
- ResultBandId / ResultValue
- Description
- ValidationStatus

RiskOverrideRule
- OverrideRuleId
- RiskProfileVersionId
- Condition
- Result
- Explanation
- Priority
```

## UI anatomy

```text
Profile/version rail
│
├── Matrix / risk map preview
├── Dimensions
├── Levels & ranges
├── Bands
├── Calculation / mapping rules
├── Critical override rules
├── Consumers / impact
└── Version / approval
```

## Dimensiones

La UI debe permitir configurar las dimensiones utilizadas por la metodología del proyecto.

Una visualización matricial 2D puede seleccionar dos dimensiones para representación, pero la arquitectura no debe asumir que toda lógica futura solo contiene dos inputs.

## Acciones

- use corporate profile;
- derive project profile;
- create draft version;
- add/edit dimension;
- add/edit levels;
- define bands;
- define calculation/mapping rules;
- define override rules;
- preview matrix;
- validate;
- compare versions;
- activate/publish version when governance allows.

## Validaciones mínimas

- toda dimensión activa tiene niveles válidos cuando aplica;
- no existen rangos contradictorios/solapados salvo regla explícita;
- toda combinación evaluable produce un resultado válido;
- las bandas utilizadas existen;
- los colores son semánticos pero el significado no depende solo del color;
- una versión activa no se edita silenciosamente: se crea nueva versión.

## Synthetic acceptance

P01 debe incluir al menos dos perfiles distintos y demostrar que la misma UI los renderiza sin modificar fórmulas de pantalla.

---

# SCR-013 — Project Teams & Roles

## PRIMARY_USER_TASK

Asignar las responsabilidades y autoridades necesarias para configurar, revisar y aprobar mantenimiento dentro del proyecto.

## SUCCESS_CRITERION

El proyecto conoce quién puede realizar o aprobar las decisiones relevantes incluidas en el scope actual.

## PRIMARY_ARCHETYPE

`Configuration Studio`

## Entidades lógicas candidatas

```text
ProjectRole
- ProjectRoleId
- ProjectId
- RoleCode
- RoleName
- Purpose
- Required
- AuthorityScope

ProjectRoleAssignment
- AssignmentId
- ProjectRoleId
- PrincipalId
- PrincipalType
- EffectiveFrom
- EffectiveTo?
- Status
```

En la fase sintética `PrincipalId` puede representar usuarios de demostración. El identity model final no se congela todavía.

## Roles funcionales candidatos a representar

- Project CMMS Lead;
- Reliability / Maintenance Engineering;
- Maintenance Responsible;
- Operations Representative;
- Asset Owner / Approver;
- Corporate Library Governance;
- CMMS Administrator.

No se hardcodea una secuencia universal de aprobación; el routing debe poder depender del proyecto.

## Acciones

- assign principal;
- remove/replace assignment;
- mark required role;
- inspect authority;
- validate coverage;
- preview review/approval responsibilities.

## Validaciones

- roles requeridos cubiertos antes de determinados gates;
- evitar asignaciones duplicadas incompatibles;
- mostrar explícitamente vacantes de autoridad.

---

# Gate conjunto P01

Las superficies anteriores pueden pasar a implementación cuando:

```text
[ ] task and success criterion defined
[ ] archetype defined
[ ] logical data contracts defined
[ ] synthetic data prepared
[ ] states defined
[ ] actions defined
[ ] validations defined
[ ] no discovery behavior embedded
[ ] future persistence responsibility identifiable
```
