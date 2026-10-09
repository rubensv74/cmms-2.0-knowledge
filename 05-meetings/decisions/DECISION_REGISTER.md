# CMMS 2.0 — Decision Register

**Última consolidación:** 2026-10-09

> Este registro gobierna **decisiones funcionales**. Un gate contractual, un benchmark y un PASS de pruebas SQL tienen alcances distintos. La sección de gates de abajo es evidencia técnica documentada, **no** aprobación de todos los procesos operativos locales. El Product Truth del 2026-10-02 conserva su valor de principios; las etapas posteriores se consultan en [PROJECT_STATUS](../../PROJECT_STATUS.md).  
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
| DEC-017 | CONFIRMED | En V1 JobPlanRevision contiene JobPlanOperation (1:N); ProcedureChecklist es opcional y separado solo cuando existe artefacto gobernado independiente. | MSL-G02 2026-10-08 / evidencia TouatGaz |
| DEC-018 | CONFIRMED | Contrato núcleo V1 de WO, planificación, calendario/capacidad, asignación y reprogramación; el benchmark no valida calendarios, roles, turnos o decisiones concretas de cada proyecto. | WM-G03 y WM-G05 2026-10-08 / DM-G02 |
| DEC-019 | OPEN | Costes, contratos, subcontratos y facturación. | WM-G04 |
| DEC-020 | OPEN | Integración productiva y arquitectura final. | decisión IT |
| DEC-021 | CONFIRMED | Separar MaintenanceTriggerPolicy/TriggerRule, MaintenanceTriggerState, ForecastOccurrence derivada, MaintenanceOccurrence persistente y MaintenanceDueEvent de auditoría. | TRG-G01 / DM-G02 2026-10-08 |
| DEC-022 | CONFIRMED | ReleaseAt y DueAt son conceptos distintos; la materialización de la WO no debe sobrescribir el vencimiento. | TRG-G01 / DM-G02 2026-10-08 |
| DEC-023 | CONFIRMED | PM/frecuencia pertenece a policy/plan y no se incrusta en JobPlan; las operaciones y recursos planificados pertenecen a su revisión. | MSL-G01/G02 2026-10-08 |
| DEC-024 | CONFIRMED | Permisivos operativos son dependencia externa del paquete de ejecución; no equivale a haber implementado el dominio PTW/LOTO completo. | WM-G02 2026-10-08 |

## Evidencia de gates — referencia, no decisiones nuevas

| Gate | Resultado documentado | Límite |
|---|---|---|
| MSL-G01 / MSL-G02 | PASS_WITH_RECORDED_AMBIGUITIES / PASS_WITH_DEFERRED_TRIGGER_VALUES | Valores originales de frecuencia no inventados; adopción G03/G04 pendiente |
| TRG-G01 / WM-G02 | PASS_CONTRACT / PASS_CONTRACT_WITH_EXTERNAL_PERMIT_BOUNDARY | Sin validación integral PTW/LOTO |
| WM-G03 / WM-G05 | PASS_BENCHMARKED_CONTRACT | Basado en referentes externos, no aceptación del AS-IS local |
| DM-G02 | PASS_CORE_LOGICAL_MODEL | Solo núcleo técnico; no costes, inventario o RCA detallada |
| DB-G01-RUNTIME / SP-G01 | PASS_RUNTIME / PASS_RUNTIME | Según evidencias y smoke tests de `db-omm-dev` del 08/10 |
| PA-G01 | DESIGN_READY_FOR_RUNTIME_VALIDATION | Los flows no constan como probados |
| PA-G01-RUNTIME-MIN | PENDING_RUNTIME | Próxima comprobación real |

Fuentes: [índice maestro](../../MASTER_INDEX.md), [DM-G02](../../00-governance/audits/2026-10-08-data-model-g02.md), [DB-G01 runtime](../../00-governance/audits/2026-10-08-db-g01-runtime.md), [SP-G01](../../00-governance/audits/2026-10-08-sp-g01.md) y [PA-G01](../../00-governance/audits/2026-10-08-pa-g01.md).

## Regla de precedencia

Cuando dos artefactos discrepen: reunión más reciente → análisis post-reunión → Product Truth Baseline → contrato funcional vigente → prototipo/fixture/UI.

Un prototipo nunca prevalece sobre una decisión posterior confirmada.