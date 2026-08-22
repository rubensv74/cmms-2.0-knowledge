# CMMS 2.0 — Capability Coverage Baseline v1

**Fecha:** 2026-08-22  
**Estado:** active baseline  
**Propósito:** separar cobertura conceptual, desarrollo actual, discovery y capacidades futuras del producto.

## 1. Regla de lectura

Esta matriz no mide software ya implementado. Mide la madurez funcional/conceptual alcanzada por CMMS 2.0.

Estados:

- `CONCEPTUAL_COVERED`: funcionalidad suficientemente comprendida para pasar a contrato/diseño/desarrollo.
- `IN_DEVELOPMENT_SCOPE`: incluida en el alcance activo hasta `Published Maintenance Plan`.
- `PARTIAL`: existe una definición útil pero todavía faltan decisiones relevantes.
- `DISCOVERY`: existen referencias o reuniones, pero no debe implementarse como comportamiento canónico.
- `FUTURE`: capacidad conocida del benchmark EAM/CMMS que todavía no se ha trabajado de forma suficiente.

## 2. Cobertura actual

| Dominio | Capacidad | Estado conceptual | Scope activo v1 |
|---|---|---|---|
| Project Foundation | Project Profile | CONCEPTUAL_COVERED | Sí |
| Project Foundation | Maintenance Configuration | CONCEPTUAL_COVERED | Sí |
| Project Foundation | Teams / Roles / authorities | CONCEPTUAL_COVERED | Sí |
| Asset Foundation | FLH | CONCEPTUAL_COVERED | Sí |
| Asset Foundation | Corporate Equipment Taxonomy | CONCEPTUAL_COVERED | Sí |
| Asset Foundation | Project Taxonomy | CONCEPTUAL_COVERED | Sí |
| Asset Foundation | Technical Fields | CONCEPTUAL_COVERED | Sí |
| Asset Foundation | ADR physical hierarchy | CONCEPTUAL_COVERED | Sí |
| Asset Foundation | Asset Register | CONCEPTUAL_COVERED | Sí |
| Asset Foundation | Asset 360 | CONCEPTUAL_COVERED | Sí |
| Asset Foundation | Equipment 3D Visual Library | CONCEPTUAL_COVERED | Sí |
| Risk | Project Risk Profile | CONCEPTUAL_COVERED | Sí |
| Risk | Configurable matrix dimensions/levels/bands | CONCEPTUAL_COVERED | Sí |
| Risk | Criticality Assessment | CONCEPTUAL_COVERED | Sí |
| Reliability Engineering | Functions | CONCEPTUAL_COVERED | Sí |
| Reliability Engineering | Functional Failures | CONCEPTUAL_COVERED | Sí |
| Reliability Engineering | Failure Modes | CONCEPTUAL_COVERED | Sí |
| Reliability Engineering | Failure causes/mechanisms | CONCEPTUAL_COVERED | Sí |
| Reliability Engineering | Failure effects/consequences | CONCEPTUAL_COVERED | Sí |
| Reliability Engineering | AMEF / FMEA | CONCEPTUAL_COVERED | Sí |
| Reliability Engineering | RCM decision logic | CONCEPTUAL_COVERED | Sí |
| Reliability Engineering | Technical feasibility/effectiveness | CONCEPTUAL_COVERED | Sí |
| Maintenance Engineering | Maintenance policy/strategy | CONCEPTUAL_COVERED | Sí |
| Maintenance Engineering | Task definition | CONCEPTUAL_COVERED | Sí |
| Maintenance Engineering | Frequency justification | CONCEPTUAL_COVERED | Sí |
| Maintenance Engineering | Maintenance Task Library | CONCEPTUAL_COVERED | Sí |
| Maintenance Engineering | Failure Knowledge Library | CONCEPTUAL_COVERED | Sí |
| Maintenance Engineering | RCM Model Library | CONCEPTUAL_COVERED | Sí |
| Planning Foundation | Job Plan | CONCEPTUAL_COVERED | Sí |
| Planning Foundation | Job Plan Library | CONCEPTUAL_COVERED | Sí |
| Planning Foundation | Resources/tools/material requirements | PARTIAL | Sí, solo ingeniería del plan |
| Planning Foundation | Applicability to equivalent assets | CONCEPTUAL_COVERED | Sí |
| Planning Foundation | Asset-specific overrides | CONCEPTUAL_COVERED | Sí |
| Planning Foundation | Maintenance Strategies | CONCEPTUAL_COVERED | Sí |
| Planning Foundation | Maintenance Plan | CONCEPTUAL_COVERED | Sí |
| Governance | Review / approval | CONCEPTUAL_COVERED | Sí |
| Governance | Versioning / frozen published version | CONCEPTUAL_COVERED | Sí |
| Governance | Audit / traceability | CONCEPTUAL_COVERED | Sí |
| Governance | Corporate promotion requests | CONCEPTUAL_COVERED | Sí |
| Work Management | Annual preventive preparation | PARTIAL | No |
| Work Management | Maintenance request / notification | FUTURE | No |
| Work Management | Work Candidate / backlog | DISCOVERY | No |
| Work Management | Work Order lifecycle | DISCOVERY | No |
| Work Management | Planning | DISCOVERY | No |
| Work Management | Scheduling | DISCOVERY | No |
| Work Management | Capacity / crews / shifts | DISCOVERY | No |
| Work Management | Assignment / dispatch | DISCOVERY | No |
| Field Execution | Technician workspace | FUTURE | No |
| Field Execution | Check sheets / procedures | DISCOVERY | No |
| Field Execution | Measurements / findings / photos | FUTURE | No |
| Field Execution | Failure reporting | FUTURE | No |
| Field Execution | Technical completion / closure | FUTURE | No |
| Mobile | Mobile / offline execution | FUTURE | No |
| Condition | Meter readings / counters | FUTURE | No |
| Condition | Inspection rounds | FUTURE | No |
| Condition | Condition monitoring | PARTIAL | No |
| Condition | IoT / sensors | FUTURE | No |
| Condition | Predictive maintenance | FUTURE | No |
| Materials | Spare parts master | PARTIAL | No |
| Materials | Inventory / storerooms | FUTURE | No |
| Materials | Reservation / issue / return | FUTURE | No |
| Procurement | Purchasing / external services | FUTURE | No |
| Economics | Actual maintenance cost | DISCOVERY | No |
| Economics | Budget / cost center context | PARTIAL | No |
| Economics | Contract/subcontract allocation | DISCOVERY | No |
| Economics | Billing / corporate financial integration | DISCOVERY | No |
| Reliability Performance | MTBF / MTTR / Availability | FUTURE | No |
| Reliability Performance | Asset Health | FUTURE | No |
| Reliability Performance | Strategy effectiveness | PARTIAL | No |
| Reliability Performance | Root Cause Analysis | FUTURE | No |
| Enterprise Extensions | GIS / linear assets | FUTURE | No |
| Enterprise Extensions | BIM / digital twin context | FUTURE | No |
| Enterprise Extensions | Fleet | FUTURE | No |
| Integration | SQL persistence | PARTIAL | Preparación, no conexión inicial |
| Integration | Power Automate orchestration | PARTIAL | Posterior al mock provider |
| Integration | API / modular backend | PARTIAL | Futuro cuando se justifique |

## 3. Frontera de construcción actual

El trabajo activo se limita a capacidades `CONCEPTUAL_COVERED` o a elementos `PARTIAL` cuyo alcance pueda delimitarse sin inventar reglas.

```text
Corporate Foundation
→ Project Setup
→ FLH / Taxonomy / ADR
→ Asset Master
→ Criticality
→ AMEF
→ RCM
→ Tasks / Job Plans / Strategies
→ Applicability / Overrides
→ Maintenance Plan
→ Governance
→ Published Maintenance Plan
```

## 4. Regla para incorporar nuevas capacidades

Las reuniones y demos ampliarán la cobertura conceptual.

Una capacidad avanza así:

```text
FUTURE
→ DISCOVERY
→ PARTIAL
→ CONCEPTUAL_COVERED
→ screen/data contract
→ implementation scope
```

No debe saltarse de `DISCOVERY` a implementación solo porque exista un comportamiento parecido en SAP, Maximo, Hexagon u otro sistema.

## 5. Uso de benchmark comercial

SAP, IBM Maximo y Hexagon EAM se utilizan como benchmark de cobertura y vocabulario, no como especificación a copiar.

El objetivo de CMMS 2.0 es alcanzar una cobertura de mantenimiento completa de forma incremental, preservando las decisiones propias ya consolidadas sobre:

- Corporate vs Project;
- FLH vs Taxonomy vs ADR;
- Risk Profile configurable;
- AMEF/RCM trazable;
- autoridad humana;
- aplicabilidad y overrides;
- planes versionados/publicados;
- futura separación entre interfaz y provider/backend.
