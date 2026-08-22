# CMMS 2.0 — Product Map v1

**Fecha:** 2026-08-22  
**Estado:** active baseline  
**Scope:** desde configuración corporativa/proyecto hasta publicación del plan de mantenimiento.

## 1. Propósito

Definir el mapa canónico de producto que guiará la construcción de la futura interfaz CMMS 2.0 en Power Apps.

El producto se construye con datos sintéticos durante la primera fase, pero las pantallas, flujos y contratos son los de la futura aplicación.

## 2. Principios de arquitectura funcional

1. **Corporate y Project son ámbitos diferentes.**
2. **FLH, Taxonomy y ADR representan vistas distintas y relacionadas.**
3. **ADR es el registro físico maestro.**
4. **La matriz de riesgo es configurable y versionable por proyecto.**
5. **AMEF y RCM son procesos trazables; el sistema recomienda y la persona decide cuando corresponda.**
6. **Maintenance Plan se deriva del análisis; no es una lista aislada de tareas.**
7. **Las extensiones project-specific no mutan la biblioteca corporativa.**
8. **Las decisiones de publicación crean versiones inmutables.**
9. **La UI depende de contratos, no del proveedor físico de datos.**
10. **Work Management queda fuera de esta primera gran versión hasta completar discovery.**

## 3. Mapa de módulos

```text
CMMS 2.0
│
├── HOME / PORTFOLIO
│   ├── Portfolio Overview
│   └── Project Home / Needs Attention
│
├── PROJECT SETUP
│   ├── Project Profile
│   ├── Maintenance Configuration
│   ├── Risk Profile / Matrix Configuration
│   └── Project Teams & Roles
│
├── CORPORATE LIBRARIES
│   ├── Equipment Taxonomy Library
│   ├── Technical Fields Library
│   ├── Failure Knowledge Library
│   ├── Maintenance Task Library
│   ├── Job Plan Library
│   ├── RCM Model Library
│   └── Equipment Visual Library
│
├── ASSETS
│   ├── FLH Builder
│   ├── Project Taxonomy Builder
│   ├── ADR Builder
│   ├── Asset Register
│   ├── Asset 360
│   └── Criticality Assessment
│
├── MAINTENANCE ENGINEERING
│   ├── AMEF / FMEA Workspace
│   ├── RCM Analysis
│   ├── Maintenance Task Definition
│   └── Applicability & Asset Overrides
│
├── MAINTENANCE PLANNING
│   ├── Job Plans
│   ├── Maintenance Strategies
│   ├── Maintenance Plan
│   └── Plan Review & Publication
│
├── GOVERNANCE
│   ├── Reviews & Approvals
│   ├── Versions & Publication Status
│   ├── Audit & Traceability
│   └── Library Promotion Requests
│
└── ADMINISTRATION
    ├── Users & Global Roles
    └── Global Configuration
```

## 4. End-to-end product flow

```text
CORPORATE FOUNDATION
Equipment Taxonomy + Technical Fields + Failure Knowledge
+ Task / Job Plan / RCM Libraries + Visual Library
                 │
                 ▼
PROJECT SETUP
Project profile + roles + maintenance configuration + Risk Profile
                 │
                 ▼
PROJECT STRUCTURE
FLH + Project Taxonomy + ADR
                 │
                 ▼
ASSET MASTER
Asset Register + Asset 360 + Technical Data
                 │
                 ▼
MAINTENANCE ENGINEERING
Criticality → AMEF → RCM → Task Definition
                 │
                 ▼
APPLICABILITY
Base strategy / plan → candidate assets → human decision → overrides
                 │
                 ▼
PLAN ASSEMBLY
Job Plans + Strategies + Resources + Frequencies
                 │
                 ▼
GOVERNANCE
Traceability → Review → Approval → Version freeze
                 │
                 ▼
PUBLISHED MAINTENANCE PLAN
```

## 5. Relationship of FLH, Taxonomy and ADR

### 5.1 FLH

The FLH is the project functional/location structure.

Example:

```text
Plant
└── Unit
    └── System
        └── Subsystem
            └── Functional Location
```

The exact levels are configurable; the example is not a mandatory fixed depth.

### 5.2 Taxonomy

Taxonomy classifies the **type** of asset.

Example:

```text
Rotating Equipment
└── Pumps
    └── Centrifugal Pumps
        └── API 610 / project-relevant subtype when needed
```

Taxonomy must not encode physical location.

### 5.3 ADR

ADR contains physical serialized/project assets and physical composition.

Example:

```text
Pump Package P-101
├── Pump P-101A
├── Motor M-101A
├── Coupling CPL-101A
├── Baseplate BPL-101A
└── Instrumentation / auxiliaries when maintained as assets
```

Each ADR asset can point to one Taxonomy Class and one applicable Functional Location while maintaining parent/child physical relationships.

## 6. Corporate-to-project inheritance

### Corporate layer

Owns reusable governed definitions:

- equipment classes;
- technical field definitions;
- units/value lists;
- standard failure modes and mechanisms;
- reusable maintenance tasks;
- Job Plan templates;
- RCM models/questions;
- equipment visuals;
- mappings to external standards.

### Project layer

Owns project configuration and usage:

- selected taxonomy branches;
- excluded branches;
- project-specific classes;
- project technical-field overrides where allowed;
- selected Risk Profile;
- FLH;
- ADR physical assets;
- asset technical values;
- project AMEF/RCM;
- strategies and maintenance plans.

### Promotion path

```text
Project-specific definition
→ submit promotion request
→ corporate governance review
→ impact analysis
→ approve/reject
→ new corporate version if approved
```

## 7. Risk Profile as first-class configuration

`Risk Profile / Matrix Configuration` is a canonical Project Setup surface.

It must permit:

- creating from a corporate profile;
- project-specific derivation where allowed;
- configurable dimensions;
- configurable levels per dimension;
- labels and descriptions;
- value/range definitions;
- matrix/band calculation rules;
- semantic risk bands/colors;
- thresholds;
- critical override rules;
- versioning;
- approval/publication;
- impact analysis before changing a profile already in use.

Consumers include, as applicable:

- Criticality Assessment;
- AMEF / FMEA;
- risk summaries;
- Needs Attention prioritization;
- plan review.

No consumer should implement its own fixed 5×5 business rule.

## 8. Equipment visual system

A 3D visual is attached primarily to a Taxonomy Class or class variant.

Use cases:

- Equipment Taxonomy Library — hero/preview;
- Project Taxonomy Builder — class identification;
- ADR Builder — selected physical asset fallback visual;
- Asset Register — compact thumbnail;
- Asset 360 — hero fallback when no real photograph exists;
- AMEF / RCM — small contextual visual only.

A real asset photograph, if trusted and available, may take precedence in Asset 360 while the class 3D visual remains available as taxonomic context.

## 9. Published plan boundary

The v1 product boundary ends at:

```text
Reviewed + Approved + Frozen Plan Version
→ Published Maintenance Plan
```

The published output must be designed for a future handoff to annual preventive preparation and Work Management, but the current product map does not invent:

- work-order lifecycle;
- scheduling;
- crew capacity;
- execution feedback;
- actual cost allocation;
- contract billing.

## 10. Definition of success

This product map is successful if a user can configure a new project, establish its structural and equipment master data, perform maintenance engineering, create applicable maintenance strategies/plans, review them, and publish a version without leaving CMMS 2.0 for any core functional step in scope.
