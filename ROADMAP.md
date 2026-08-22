# Roadmap CMMS 2.0

**Última revisión:** 2026-08-22  
**Rama activa:** `baseline/premium-powerapps-v1`

## 1. Alcance de este roadmap

El roadmap activo guía la construcción de la **interfaz funcional futura de CMMS 2.0** hasta publicación del plan de mantenimiento.

Los datos sintéticos son un proveedor temporal y no reducen el alcance funcional de la aplicación.

El antiguo recorrido `Functional Lab WS-01…WS-09` permanece como conocimiento histórico y fuente funcional para AMEF/RCM, pero ya no es la secuencia de construcción del producto.

## 2. Frontera de producto v1

Incluido:

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

Fuera de esta primera gran versión:

- Work Candidates;
- Work Orders;
- Planning/Scheduling;
- ejecución;
- field feedback;
- actual cost allocation;
- contratos/facturación.

Estos dominios siguen discovery separado.

---

# 3. Roadmap de construcción

## P0 — Product Baseline Consolidation

**Estado:** completed.

Entregables:

- decisión producto vs Functional Lab;
- Product Map v1;
- Screen Catalog v1;
- estrategia Data Provider;
- separación Corporate/Project;
- FLH vs Taxonomy vs ADR;
- Risk Profile como configuración canónica;
- Equipment Visual Library 3D como parte del producto.

Fuentes:

- `00-governance/decisions/2026-08-22-product-interface-scope.md`
- `01-vision/cmms-2.0-product-map-v1.md`
- `06-ui-ux/product-screen-catalog-v1.md`

## P1 — Master Data & Taxonomy Foundation

**Estado:** in progress.

### P1.1 Equipment Taxonomy research baseline

**Estado:** completed v1.

Fuentes contrastadas:

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

Construir por familias, no rellenar una lista masiva sin evidencia.

Orden inicial:

1. Rotating Equipment;
2. Static / Pressure Equipment;
3. Heat Transfer Equipment;
4. Piping / Valves / specialty mechanical;
5. Electrical;
6. Instrumentation & Control;
7. Utility / Packages;
8. remaining domains.

Para cada familia:

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

### Gate P1

Antes de congelar la primera versión corporativa de taxonomía deben estar validadas al menos las familias necesarias para los proyectos piloto.

## P2 — Screen Contracts Foundation

**Estado:** next.

Objetivo: definir contratos funcionales antes de implementar pantallas complejas.

Prioridad:

1. Premium App Shell / Navigation;
2. Project Profile;
3. Maintenance Configuration;
4. Risk Profile / Matrix Configuration;
5. Equipment Taxonomy Library;
6. Project Taxonomy Builder;
7. FLH Builder;
8. ADR Builder;
9. Asset Register;
10. Asset 360.

Cada contrato debe incluir:

- primary task;
- SaaS archetype;
- personas/roles;
- inputs;
- outputs;
- actions;
- states;
- validations;
- governance;
- data contract;
- synthetic dataset requirements;
- future persistence mapping.

## P3 — Power Apps Technical Baseline

Crear/identificar Canvas App real:

```text
CMMS 2.0
```

Validar:

- Source Code schema/dialect;
- responsive strategy;
- resolution;
- Modern/Classic controls actually available;
- reusable components installed;
- theme/tokens;
- App Checker baseline;
- visual baseline.

Gate: no construir superficies densas hasta validar el shell real en Studio.

## P4 — Premium App Shell + Navigation

Construir la foundation visual definitiva:

- grouped sidebar;
- Corporate/Project context;
- global search shell;
- page header;
- command bars;
- content host;
- contextual inspector/drawer;
- overlays/modals;
- Needs Attention entry point;
- loading/empty/error states;
- accessibility/focus states;
- dirty guard;
- responsive behavior acordado.

## P5 — Project Setup

Implementar:

- Project Profile;
- Maintenance Configuration;
- Risk Profile / Matrix Configuration;
- Project Teams & Roles.

### Gate Risk Profile

Debe poder demostrar con datos sintéticos que el mismo componente puede renderizar perfiles diferentes sin cambiar fórmulas de pantalla.

## P6 — Corporate Libraries Foundation

Implementar primero las bibliotecas necesarias para alimentar los siguientes módulos:

1. Equipment Taxonomy Library;
2. Technical Fields Library;
3. Equipment Visual Library;
4. Failure Knowledge Library;
5. Maintenance Task Library;
6. Job Plan Library;
7. RCM Model Library.

No todas necesitan la misma profundidad en el primer incremento; cada una se construye por contrato.

## P7 — Project Structure & Asset Master

### P7.1 FLH Builder

Crear/validar jerarquía funcional/localización.

### P7.2 Project Taxonomy Builder

Seleccionar corporate classes, excluir ramas y gestionar project-specific extensions.

### P7.3 ADR Builder

Crear activos físicos y parent/child composition.

### P7.4 Asset Register

Exploración/edición masiva.

### P7.5 Asset 360

Vista integral de un activo.

Gate:

```text
Asset
→ Functional Location
→ Taxonomy Class
→ physical parent/children
→ technical data
→ visual/document context
```

debe ser consistente antes de iniciar ingeniería de mantenimiento a escala.

## P8 — Criticality

Implementar Criticality Assessment consumiendo configuración, no reglas hardcodeadas.

Debe separar:

- configured criteria;
- system calculation;
- human review/override when allowed;
- traceability;
- resulting asset criticality.

## P9 — AMEF / FMEA

Implementar análisis estructurado sobre activos/clases/funciones.

Debe soportar:

- functions;
- functional failures;
- failure modes;
- causes/mechanisms;
- effects;
- existing controls;
- configured risk profile;
- evidence;
- reusable failure knowledge;
- human decisions;
- readiness toward RCM.

No convertir knowledge-library suggestions en AMEF aprobado automáticamente.

## P10 — RCM

Implementar RCM como árbol lógico explicable.

Gate previo:

- RCM Model contract versioned;
- questions/branches defined;
- technical feasibility/effectiveness criteria;
- trace model.

No scoring RCM acumulado salvo metodología explícita y configurable.

## P11 — Maintenance Task Engineering

Implementar:

- Maintenance Task Definition;
- frequency justification;
- acceptance criteria;
- reaction on failure;
- resources/skills/tools/materials;
- evidence/technical basis.

## P12 — Applicability & Overrides

Implementar:

- base strategy/plan;
- candidate assets from taxonomy/technical equivalence;
- human applicability decision;
- asset-specific override;
- no mutation of base definition;
- traceability and impact.

## P13 — Job Plans & Strategies

Implementar:

- Job Plans;
- sequences/resources/conditions;
- reusable templates;
- Maintenance Strategies;
- relationships to tasks/assets/classes.

Las reglas de agrupación todavía no validadas deben permanecer configurables/explicitly pending, no enterradas en UI formulas.

## P14 — Maintenance Plan

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

## P15 — Governance, Review & Publication

Implementar:

- Reviews & Approvals;
- blockers/warnings;
- Audit & Traceability;
- version comparison;
- publication status;
- immutable published version;
- Library Promotion Requests.

Output final v1:

```text
Published Maintenance Plan Version
```

## P16 — SQL Readiness & Provider Swap

Solo cuando los contratos de una superficie estén estabilizados:

```text
synthetic collection
↔ contract
↔ relational model / API contract
```

Orden recomendado:

1. master/reference data reads;
2. project configuration;
3. asset master;
4. engineering reads;
5. controlled writes;
6. decisions/traceability;
7. publication/version transactions.

Aplicar idempotencia, concurrency control y backend protection según riesgo.

---

# 4. Parallel Discovery — Work Management

No bloquea la construcción de la primera versión hasta plan publicado.

Debe continuar en paralelo:

### WM-G01

Observar proceso real y excepciones.

### WM-G02

Separar task / procedure / checksheet / WO / execution feedback.

### WM-G03

Validar planning/scheduling/capacity/assignment.

### WM-G04

Validar costs/contracts/billing con roles responsables.

Solo después se añadirá un segundo Product Map posterior a `Published Maintenance Plan`.

---

# 5. Regla de continuidad

No se construye una pantalla solo porque aparezca en el mapa.

Secuencia:

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

Y no se diseña como regla definitiva ningún comportamiento que continúe marcado como `to_validate`.
