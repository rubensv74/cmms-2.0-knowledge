# CMMS 2.0 — Development

Entrada canónica para el arranque de construcción ejecutable de CMMS 2.0.

## Baseline

- [`CMMS_DEVELOPMENT_BASELINE_1_0.md`](CMMS_DEVELOPMENT_BASELINE_1_0.md)

## Roadmap ejecutable

- [`roadmap/CMMS_DELIVERY_SEQUENCE_1_0.md`](roadmap/CMMS_DELIVERY_SEQUENCE_1_0.md)

## Gates

- [`gates/CMMS_G0_RUNTIME_FOUNDATION_GATE.md`](gates/CMMS_G0_RUNTIME_FOUNDATION_GATE.md)

## Gobierno SQL

- [`../00-governance/CMMS_SQL_CONCURRENCY_API_READINESS_POLICY.md`](../00-governance/CMMS_SQL_CONCURRENCY_API_READINESS_POLICY.md)

## Arquitectura operativa actual

```text
Power Apps
    ↓
Power Automate
    ↓
SQL Server
```

No se implementa una API ahora. El backend se diseña desde el primer día para admitir una futura capa API sin reconstruir la UX ni las reglas de negocio.

## Primary lane

```text
Premium App Foundation
→ Backend Pilot
→ P-101 Reliability Backbone
→ Reliability Studies
→ Study Scope
→ Functions & Failures
→ FMEA
→ RCM Decision
→ Maintenance Strategy
→ Review & Approval
→ Implementation Handoff
```

El Functional Lab y la documentación histórica permanecen como fuentes de conocimiento y evidencia; no son la arquitectura runtime productiva.
