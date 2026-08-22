# Roadmap CMMS 2.0

**Última revisión:** 2026-08-22  
**Rama activa:** `baseline/premium-powerapps-v1`

## 1. Alcance

Este roadmap guía la construcción de la **interfaz funcional futura de CMMS 2.0** hasta publicación del plan de mantenimiento.

Los datos sintéticos son un provider temporal. No reducen el alcance funcional de las pantallas ni justifican una arquitectura de demo.

El antiguo `Functional Lab WS-01…WS-09` permanece como conocimiento histórico reutilizable para AMEF/RCM, no como secuencia de construcción.

## 2. Frontera de producto v1

```text
Corporate Libraries
→ Project Setup
→ FLH / Project Taxonomy / ADR
→ Asset Register / Asset 360
→ Criticality
→ AMEF / FMEA
→ RCM
→ Maintenance Tasks
→ Job Plans / Strategies
→ Applicability / Overrides
→ Maintenance Plan
→ Review / Approval / Version
→ Published Maintenance Plan
```

Fuera de v1 hasta completar discovery:

- Work Candidates;
- Work Orders;
- Planning/Scheduling;
- Field Execution;
- Actual Cost;
- Inventory/Storerooms;
- Contracts/Billing;
- advanced condition/predictive capabilities.

La cobertura conceptual completa se controla en:

- `01-vision/cmms-2.0-capability-coverage-v1.md`.

---

# 3. Roadmap de construcción

## P0 — Product Baseline Consolidation

**Estado:** completed.

Entregables:

- decisión producto vs Functional Lab;
- Product Map v1;
- Screen Catalog v1;
- separación Corporate/Project;
- FLH vs Taxonomy vs ADR;
- Risk Profile configurable;
- Equipment Visual Library 3D;
- estrategia Data Provider.

## P1 — Master Data & Taxonomy Foundation

**Estado:** in progress in parallel.

### P1.1 Research baseline

**Estado:** completed v1.

Fuentes base:

- ISO 14224;
- IEC 81346;
- CFIHOS;
- ETIM;
- ECLASS;
- MIMOSA CCOM;
- ISO 55000;
- estándares específicos por familia cuando proceda.

Resultado:

- `02-functional/master-data/equipment-taxonomy-library-foundation-v1.md`.

### P1.2 Family studies

Orden inicial:

1. Rotating Equipment;
2. Static / Pressure Equipment;
3. Heat Transfer Equipment;
4. Piping / Valves / specialty mechanical;
5. Electrical;
6. Instrumentation & Control;
7. Utility / Packages;
8. remaining domains.

Patrón:

```text
source review
→ class tree candidate
→ technical field profile
→ failure knowledge links
→ maintenance knowledge links
→ external mappings
→ 3D visual requirements
→ review
```

P1 no bloquea Foundation + Project Setup.

## P2 — Screen Contracts Foundation

**Estado:** in progress.

### P2.1 P01 Foundation + Project Setup

**Estado:** completed at contract level.

Documentos:

- `06-ui-ux/product-development/p01-foundation-project-setup-plan-v1.md`;
- `06-ui-ux/product-development/p01-synthetic-provider-contract-v1.md`;
- `06-ui-ux/screen-contracts/p01-shell-project-setup-screen-contracts-v1.md`.

Contratos cerrados para iniciar implementación:

- Premium Shell / Navigation;
- Portfolio minimum;
- Project Home minimum;
- Project Profile;
- Maintenance Configuration;
- Risk Profile / Matrix Configuration;
- Project Teams & Roles.

### P2.2 Siguiente paquete de contratos

Después de validar P01 en Studio:

1. Equipment Taxonomy Library;
2. Technical Fields Library;
3. Equipment Visual Library;
4. Project Taxonomy Builder;
5. FLH Builder;
6. ADR Builder;
7. Asset Register;
8. Asset 360.

## P3 — Power Apps Technical Baseline

**Estado:** next runtime gate.

Crear/identificar Canvas App:

```text
CMMS 2.0
```

Registrar:

- Source Code schema/dialect;
- responsive strategy;
- resolution;
- Modern/Classic controls disponibles;
- reusable components instalados;
- theme/tokens;
- App Checker baseline;
- visual baseline.

**Gate:** no construir superficies densas antes de confirmar el comportamiento real de Studio.

## P4 — P01 Premium Shell + Navigation

Construir:

- grouped sidebar;
- Corporate/Project context selector;
- global search shell;
- Needs Attention entry point;
- page header;
- command bar;
- content host;
- contextual drawer/inspector host;
- overlay/modal host;
- loading/empty/error;
- dirty guard;
- focus/accessibility baseline;
- responsive behavior acordado.

## P5 — P01 Synthetic Provider

Implementar centralmente:

```text
Projects
Maintenance Configuration
Risk Profiles / Dimensions / Levels / Bands / Rules
Project Roles / Assignments
Runtime State
View Models
```

Acceptance clave:

> dos proyectos con Risk Profiles estructuralmente distintos deben renderizarse con las mismas superficies y contratos.

## P6 — P01 Project Setup

Implementar:

- `SCR-010 Project Profile`;
- `SCR-011 Maintenance Configuration`;
- `SCR-012 Risk Profile / Matrix Configuration`;
- `SCR-013 Project Teams & Roles`;
- minimal `SCR-001 Portfolio` y `SCR-002 Project Home` para navegación/contexto.

### Gate P01

```text
[ ] shell final-quality
[ ] project switching
[ ] isolated state per project
[ ] configurable Risk Profiles
[ ] role coverage / Needs Attention
[ ] no master data hardcoded in controls
[ ] dirty guard
[ ] App Checker accepted
[ ] Visual QA in Studio
[ ] contracts documented for provider swap
```

## P7 — Corporate Libraries Foundation

Orden:

1. Equipment Taxonomy Library;
2. Technical Fields Library;
3. Equipment Visual Library;
4. Failure Knowledge Library;
5. Maintenance Task Library;
6. Job Plan Library;
7. RCM Model Library.

## P8 — Project Structure & Asset Master

### P8.1 FLH Builder

Jerarquía funcional/localización configurable.

### P8.2 Project Taxonomy Builder

Selección/exclusión/extensión de Corporate Taxonomy.

### P8.3 ADR Builder

Registro físico maestro y composición parent/child.

### P8.4 Asset Register

Exploración/edición de activos.

### P8.5 Asset 360

Vista integral del activo.

Gate:

```text
Asset
→ Functional Location
→ Taxonomy Class
→ physical parent/children
→ technical data
→ visual/document context
```

debe ser coherente antes de AMEF a escala.

## P9 — Criticality

Criticality Assessment consumiendo configuración.

Separar:

- criteria/configuration;
- system calculation;
- human review/override cuando se permita;
- traceability.

## P10 — AMEF / FMEA

Soportar:

- functions;
- functional failures;
- failure modes;
- causes/mechanisms;
- effects;
- existing controls;
- configured Risk Profile;
- evidence;
- reusable Failure Knowledge;
- human decisions;
- readiness hacia RCM.

## P11 — RCM

Árbol lógico explicable y versionado.

No scoring acumulado salvo metodología explícita/configurable.

## P12 — Maintenance Task Engineering

- task definition;
- frequency justification;
- acceptance criteria;
- reaction on failure;
- resources/skills/tools/materials;
- technical basis/evidence.

## P13 — Applicability & Overrides

- base strategy/plan;
- candidate assets;
- human applicability decision;
- asset-specific override;
- no mutation of base definition;
- traceability/impact.

## P14 — Job Plans & Strategies

- reusable Job Plans;
- sequences/resources/conditions;
- Maintenance Strategies;
- relationships to tasks/assets/classes.

## P15 — Maintenance Plan

Consolidar:

- strategies;
- tasks;
- Job Plans;
- frequencies;
- assets/scope;
- applicability;
- overrides;
- resources;
- completeness/readiness.

## P16 — Governance, Review & Publication

- Reviews & Approvals;
- blockers/warnings;
- Audit & Traceability;
- version comparison;
- publication status;
- immutable published version;
- Library Promotion Requests.

Output:

```text
Published Maintenance Plan Version
```

## P17 — SQL Readiness & Provider Swap

Solo con contratos estabilizados:

```text
synthetic collection
↔ logical contract
↔ relational model / API contract
```

Orden recomendado:

1. master/reference reads;
2. project configuration;
3. asset master;
4. engineering reads;
5. controlled writes;
6. decisions/traceability;
7. publication/version transactions.

---

# 4. Parallel Discovery — EAM Coverage

Las reuniones amplían cobertura conceptual sin bloquear el desarrollo actual.

## Work Management

- work candidates;
- WO lifecycle;
- task/procedure/checksheet separation;
- planning;
- scheduling;
- capacity/assignment;
- execution feedback.

## Economics / Materials / Enterprise

- actual cost;
- inventory/spares/storerooms;
- contracts/subcontracts;
- billing/integration;
- mobile/offline;
- condition/predictive;
- reliability performance.

Cuando una capacidad pase a `CONCEPTUAL_COVERED`, se incorporará al Product Map futuro mediante el mismo proceso de contratos.

---

# 5. Regla de continuidad

```text
functional decision
→ screen contract
→ data contract
→ synthetic provider
→ Power Apps implementation
→ Studio validation
→ Visual QA
→ documentation
```

No se implementa como regla definitiva ningún comportamiento en `DISCOVERY` o `to_validate`.
