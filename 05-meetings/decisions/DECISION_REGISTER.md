# CMMS 2.0 — Decision Register

**Última consolidación:** 2026-10-02  
**Fuente canónica:** [Product Truth Baseline v1.0](../../00-governance/CMMS_PRODUCT_TRUTH_BASELINE_V1.md)

## Estados

- CONFIRMED: puede gobernar contratos e implementación.
- SUPERSEDED: sustituida por evidencia posterior.
- OPEN: requiere discovery/contrato.
- HOLD: válida pero aplazada.
- REJECTED: no debe recuperarse como diseño objetivo.

## Registro

| ID | Estado | Decisión | Evidencia principal |
|---|---|---|---|
| DEC-001 | CONFIRMED | El mantenimiento se justifica desde función, fallo, consecuencia y riesgo. | 2026-07-31 |
| DEC-002 | CONFIRMED | AMEF forma parte del razonamiento RCM. | 2026-09-11 / ANL-004 |
| DEC-003 | CONFIRMED | RCM es árbol lógico, no scoring; riesgo configurable. | 2026-08-14 |
| DEC-004 | CONFIRMED | Las decisiones técnicas relevantes conservan autoridad humana trazable. | 2026-07-31 / 2026-08-14 |
| DEC-005 | CONFIRMED | RCM no es la única fuente de mantenimiento gobernado. | 2026-09-11 / ANL-004 |
| DEC-006 | CONFIRMED | Standard master → project snapshot → tailoring; cambios locales no mutan master. | 2026-09-11 |
| DEC-007 | CONFIRMED | Equipment Type/taxonomía sugiere aplicabilidad; especialista confirma. | 2026-08-14 / 2026-09-11 |
| DEC-008 | CONFIRMED | Maintenance Activity, Job Plan, Procedure/Checklist y WO son conceptos distintos. | 2026-09-11 |
| DEC-009 | CONFIRMED | Revisiones publicadas son inmutables; cambios generan nueva versión. | especificación AMEF/RCM |
| DEC-010 | SUPERSEDED | Generar preventivas por ejercicio/año como mecánica runtime principal. | sustituida 2026-09-25 |
| DEC-011 | CONFIRMED | Preventivo runtime usa rolling next due; forecast se separa de WO materializada. | 2026-09-25 / ANL-005 |
| DEC-012 | SUPERSEDED | WorkCandidate como etapa universal de toda WO preventiva. | sustituida 2026-09-25 |
| DEC-013 | CONFIRMED | Hallazgo preventivo que exige reparación abre rama correctiva. | 2026-09-25 |
| DEC-014 | CONFIRMED | Execution feedback alimenta KPI, efectividad y revisión de planes. | 2026-09-25 |
| DEC-015 | CONFIRMED | FLH, taxonomía y ADR físico son estructuras distintas. | especificación AMEF/RCM |
| DEC-016 | HOLD | Wizard AMEF como experiencia futura; no es el master ni bloquea el modelo. | revisión funcional posterior |
| DEC-017 | OPEN | Frontera exacta JobPlan ↔ ProcedureChecklist. | MSL-G02 |
| DEC-018 | OPEN | Lifecycle WO, scheduling, capacity, turnos, assignment. | WM-G03 |
| DEC-019 | OPEN | Costes, contratos, subcontratos y facturación. | WM-G04 |
| DEC-020 | OPEN | Integración productiva y arquitectura final. | decisión IT |

## Regla de precedencia

Cuando dos artefactos discrepen: reunión más reciente → análisis post-reunión → Product Truth Baseline → contrato funcional vigente → prototipo/fixture/UI.

Un prototipo nunca prevalece sobre una decisión posterior confirmada.