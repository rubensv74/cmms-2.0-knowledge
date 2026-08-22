# CMMS 2.0 — P01 Foundation + Project Setup Plan v1

**Fecha:** 2026-08-22  
**Estado:** active implementation plan  
**Rama:** `baseline/premium-powerapps-v1`

## 1. Objetivo

Construir el primer incremento real de CMMS 2.0 en Power Apps con calidad premium y datos sintéticos, sin reducir el alcance funcional futuro ni acoplar la interfaz a SQL.

El incremento termina cuando el usuario puede:

1. entrar en CMMS 2.0;
2. seleccionar o crear contexto de proyecto;
3. configurar parámetros básicos de mantenimiento;
4. definir/seleccionar el Risk Profile del proyecto;
5. asignar roles y autoridades de proyecto;
6. navegar con un shell definitivo hacia las siguientes áreas del producto.

## 2. Alcance del incremento

### Foundation

- Premium App Shell;
- grouped sidebar;
- Corporate / Project context selector;
- global search placeholder contract;
- page header;
- command/action area;
- content host;
- contextual inspector/drawer host;
- modal/overlay host;
- Needs Attention entry point;
- loading / empty / error / disabled states;
- dirty guard;
- accessibility/focus baseline;
- responsive baseline.

### Project Setup

- `SCR-010 Project Profile`;
- `SCR-011 Maintenance Configuration`;
- `SCR-012 Risk Profile / Matrix Configuration`;
- `SCR-013 Project Teams & Roles`.

### Entry points

- `SCR-001 Portfolio Overview` — shell-level placeholder / minimal synthetic surface;
- `SCR-002 Project Home / Needs Attention` — minimal synthetic project landing surface.

El objetivo de SCR-001/SCR-002 en P01 es demostrar navegación, contexto y estados. Su analítica definitiva se ampliará cuando existan más dominios implementados.

## 3. Fuera de alcance

P01 no implementa todavía:

- Corporate Libraries completas;
- FLH;
- Project Taxonomy;
- ADR;
- Asset Register;
- AMEF/RCM;
- Maintenance Plan;
- SQL;
- Power Automate productivo;
- API;
- Work Management.

Puede mostrar destinos futuros en navegación si están claramente marcados como no disponibles o pendientes, pero no debe simular funcionalidad inexistente.

## 4. Arquitectura de datos temporal

```text
Premium UI
→ screen/view state
→ product contract
→ synthetic provider
```

Colecciones candidatas:

```text
colCfg_Projects
colCfg_ProjectMaintenance
colCfg_RiskProfiles
colCfg_RiskDimensions
colCfg_RiskLevels
colCfg_RiskBands
colCfg_RiskOverrideRules
colCfg_ProjectRoles
colCfg_ProjectRoleAssignments

colState_AppContext
colState_ProjectSetup
colState_RiskEditor
colState_DirtyObjects

colView_Portfolio
colView_ProjectHome
colView_RiskMatrix
colView_ProjectReadiness
```

Las colecciones `colView_*` son proyecciones y nunca fuente de verdad.

## 5. Dataset sintético mínimo

Debe demostrar variabilidad real de configuración.

### Proyectos

Al menos:

- `PRJ-DEMO-01` — Process Plant Demo;
- `PRJ-DEMO-02` — Energy Facility Demo.

Deben diferir en al menos:

- Maintenance Configuration;
- Risk Profile;
- equipos/roles previstos;
- estado de configuración.

### Risk Profiles

Al menos dos perfiles:

- un perfil 5×5 de demostración;
- un perfil alternativo con escala o bandas distintas.

Objetivo: demostrar que la UI no depende de una matriz 5×5 fija.

## 6. Secuencia de implementación

### P01-B01 — Canvas baseline

- crear/identificar app `CMMS 2.0`;
- registrar dialecto Source Code;
- resolución/layout;
- controles disponibles;
- componentes instalados;
- theme baseline;
- App Checker baseline.

**Gate:** obligatorio antes de generar bloques densos.

### P01-B02 — Premium Shell

- root layout;
- sidebar;
- header;
- context selector;
- content host;
- command bar;
- overlay layer.

**Gate:** visual QA en Studio.

### P01-B03 — Navigation model

- grupos de menú;
- selected state;
- role/context visibility hooks;
- pending/disabled destinations;
- navigation state.

### P01-B04 — Synthetic Provider Foundation

- centralized load;
- reset/reload;
- stable IDs;
- no screen-local master data.

### P01-B05 — Portfolio / Project Home minimum

- project cards/list;
- project status;
- Needs Attention placeholder driven by synthetic state;
- project selection.

### P01-B06 — Project Profile

- create/edit/select project;
- identity/scope/status;
- validation;
- dirty/reset/save-local pattern.

### P01-B07 — Maintenance Configuration

- project-level maintenance options;
- inheritance/default indication;
- impact hints;
- version/config status.

### P01-B08 — Risk Profile / Matrix Configuration

- select/create/derive profile;
- dimensions;
- levels;
- labels/ranges;
- risk bands;
- semantic colors;
- thresholds;
- override rules;
- matrix preview;
- version/status;
- consumer/impact panel.

### P01-B09 — Project Teams & Roles

- roles;
- authority/responsibility assignment;
- review/approval authority preview;
- validation of missing required authorities.

### P01-B10 — Hardening

- loading/empty/error;
- keyboard/focus baseline;
- long text;
- null values;
- dirty guard;
- visual QA;
- App Checker;
- documentation.

## 7. Definition of Done

P01 queda completado cuando:

- el shell parece parte de la aplicación final y no un prototipo temporal;
- se puede cambiar entre dos proyectos sintéticos;
- Project Setup conserva estado por proyecto;
- Risk Profile cambia visualmente/funcionalmente según configuración;
- las pantallas no contienen datos fuente hardcodeados;
- no existen reglas de negocio cuyo único contrato sea una fórmula de UI;
- navegación y permisos están preparados para crecer;
- App Checker no introduce errores abiertos no aceptados;
- Visual QA ha sido realizada en Power Apps Studio;
- los contratos de datos quedan documentados para futura sustitución por SQL/Flow/API.

## 8. Siguiente incremento después de P01

```text
Corporate Libraries Foundation
→ Equipment Taxonomy
→ Technical Fields
→ Equipment Visuals 3D
```

seguido por:

```text
FLH
→ Project Taxonomy
→ ADR
→ Asset Register / Asset 360
```
