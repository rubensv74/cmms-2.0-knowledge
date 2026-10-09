# Roadmap CMMS 2.0

**Última revisión:** 2026-10-09

> **Estado operativo vigente.** Los apartados de aprendizaje funcional posteriores a este resumen mantienen valor como alcance e historia, pero cualquier orden de gates antiguo queda sustituido por la siguiente secuencia. Los PASS de contrato/benchmark no equivalen a runtime ni a aceptación de un proceso local.

## 0. Gates alcanzados y siguiente paso

| Secuencia | Gate | Resultado documentado |
|---:|---|---|
| 1 | MSL-G01 — Source Normalization | PASS_WITH_RECORDED_AMBIGUITIES |
| 2 | MSL-G02 — Core Contracts | PASS_WITH_DEFERRED_TRIGGER_VALUES |
| 3 | TRG-G01 — Triggering Domain Contract | PASS_CONTRACT |
| 4 | WM-G02 — Execution Package | PASS_CONTRACT_WITH_EXTERNAL_PERMIT_BOUNDARY |
| 5 | WM-G03 — Planning & Scheduling | PASS_BENCHMARKED_CONTRACT |
| 6 | WM-G05 — Execution Feedback | PASS_BENCHMARKED_CONTRACT |
| 7 | DM-G01 — Conceptual Reconciliation | PASS_WITH_OPEN_CONTRACTS; gate intermedio |
| 8 | DM-G02 — Core Logical Freeze | PASS_CORE_LOGICAL_MODEL |
| 9 | DB-G01 — Physical Design | Diseño y static review completados |
| 10 | DB-G01-RUNTIME — Core SQL | PASS_RUNTIME (37 tablas en `db-omm-dev`) |
| 11 | SP-G01 — Core Stored Procedures | PASS_RUNTIME |
| 12 | PA-G01 — Flow Contracts | DESIGN_READY_FOR_RUNTIME_VALIDATION |
| **13** | **PA-G01-RUNTIME-MIN — 2 flows mínimos** | **NEXT / PENDING_RUNTIME** |

**Prioridad actual:** construir y ejecutar `CMMS_CORE_WorkQueue_List` y `CMMS_CORE_WorkOrder_Materialize`. Gate PASS únicamente con evidencia real de READY/JSON, idempotencia por `requestId`, manejo de errores CMMS-404/409 y fallos técnicos CMMS-500. En caso de PASS, extender el patrón a los otros seis flows **por incrementos verificados**; después conectar la primera vertical Power Apps y validar en Studio.

**Paralelo / diferido:** `MSL-G03/G04` (adopción y feedback corporativo), contraste operacional real del benchmark WM-G03/WM-G05, AE/Functional Lab, permisos PTW/LOTO integrales y dominios fuera del freeze técnico (costes, inventario, compras, facturación, RCA, KPI definitivo). Ninguno queda considerado implementado por la validación SQL del núcleo.

**Referencias:** [Estado](PROJECT_STATUS.md), [DM-G02](00-governance/audits/2026-10-08-data-model-g02.md), [DB-G01 runtime](00-governance/audits/2026-10-08-db-g01-runtime.md), [SP-G01](00-governance/audits/2026-10-08-sp-g01.md), [PA-G01](00-governance/audits/2026-10-08-pa-g01.md).

---

## Registro anterior de descubrimiento (conservado)

## Revisión 2026-09-25 — Work Management

El preventivo publicado se materializa mediante recurrencia rolling y siguiente intervención. Forecast anual/presupuesto se separa de las órdenes realmente creadas. Work Candidate no es obligatorio para preventivo aprobado. Execution feedback, cierre por Planning, planned-vs-actual y calidad del dato pasan a formar parte del discovery. Se añade WM-G05 — Execution Feedback & Data Integrity.

## 1. Cómo leer este roadmap

Se separan dos dimensiones:

1. **mapa funcional del producto** — capacidades objetivo;
2. **roadmap de validación** — orden en el que se observa, modela, contrata, prueba y consolida.

Que un dominio se estudie antes no implica necesariamente que se implemente antes en producción.

---

# 2. Mapa funcional del producto

## A. Fundamentos de activos

- FLH / taxonomía / ADR;
- modelo y registro de activos;
- Equipment Type;
- contexto operacional;
- criticidad configurable;
- Technical Profile;
- provenance / authority;
- Engineering Context;
- Visual Context;
- Maintenance Summary read model.

**Madurez:** alta a nivel contractual; implementación física sujeta a gates Asset Experience.

## B. Reliability Engineering / Maintenance Engineering

### B1. RCM specific engineering

- funciones;
- fallos funcionales;
- modos y efectos de fallo;
- riesgo configurable;
- P–F;
- árbol RCM;
- políticas/estrategias;
- tareas/frecuencias;
- recursos;
- applicability;
- publicación/versionado;
- effectiveness loop.

**Madurez:** alta respecto del resto del programa; journey v1.2.

### B2. Maintenance Standards Library

- corporate standards por Equipment Type;
- Standard Plan versions;
- Standard Maintenance Activities;
- Job Plans;
- procedures/checklists;
- default frequencies;
- resources/tools/materials;
- source/provenance;
- project adoption snapshots;
- project overrides;
- corporate change proposals;
- feedback loop master ↔ project.

**Madurez vigente:** MSL-G01/G02 con PASS documentado el 2026-10-08; MSL-G03/G04 y validación de valores de trigger históricos pendientes.

Regla central:

```text
RCM / Corporate Standard / OEM / Expert
→ Governed Project Maintenance Plan
```

RCM no es la única vía para crear un plan.

## C. Gestión del trabajo

- calendar/scheduled maintenance;
- work candidates;
- planning;
- reprogramación;
- scheduling;
- routing organizativo;
- assignment;
- work orders;
- execution package;
- ejecución/feedback;
- cierre técnico.

**Madurez:** discovery.

Regla confirmada 2026-09-11:

```text
WO / Work Candidate
→ Maintenance Activity
   └── JobPlan / ProcedureChecklist
```

No se convierten por defecto los pasos del checklist en actividades independientes.

## D. Gestión económica y empresarial

- centros de coste;
- contexto presupuestario;
- costes reales;
- materiales/servicios;
- contratos/subcontratos;
- facturación;
- reporting/KPIs;
- integraciones;
- roles/seguridad.

**Madurez:** temprana/parcial.

---

# 3. Roadmap de validación funcional

## FL-0 — Foundation

**Estado:** completada documentalmente y revisada hasta 2026-09-11.

Incluye:

- protocolo incremental;
- RCM Functional Journey;
- persona vs sistema;
- arquitectura Functional Lab;
- contracts/fixtures iniciales;
- riesgo configurable;
- RCM sin scoring;
- applicability/overrides;
- Work Management discovery;
- Maintenance Standards discovery.

## FL-1 — Power Apps Foundation + WS-01

- shell/runtime;
- adapter de caso;
- navegación;
- WS-01;
- Studio validation;
- hardening.

Gate: WS-01 real validado.

## FL-2 — Funciones y fallos

- WS-02;
- funciones/fallos/modos como parte del RCM;
- ownership y evidencia.

## FL-3 — Riesgo configurable

Gate previo: `RiskProfile`.

- WS-03;
- escalas/rangos/reglas desde configuración;
- no matriz fija.

## FL-4 — Árbol RCM

Gate previo: contrato de árbol.

- WS-04;
- branches sin scoring;
- P–F;
- factibilidad/efectividad;
- human authority.

## FL-5 — Actividad, Job Plan y plan

- WS-05;
- WS-06;
- `sourceBasis`;
- actividad gestionable;
- frecuencia;
- recursos;
- Job Plan / Procedure reference;
- applicability;
- overrides.

Gate previo a WS-06:

```text
BasePlan / StandardVersion
CandidateAssets
ApplicabilityDecision
Project/AssetOverride
JobPlan / Procedure reference
```

## FL-6 — Gobernanza y publicación

- WS-07 / WS-08;
- provenance;
- version lineage;
- approvals;
- `PublishedProjectMaintenancePlanVersion`;
- handoff a Annual Preventive Preparation / Work Management.

## FL-7 — Efectividad

- WS-09;
- comparar hipótesis/baseline con ejecución;
- abrir revisión;
- identificar posibles aprendizajes corporativos.

## FL-8 — Consolidación Reliability Engineering para IT

- requisitos;
- reglas;
- conceptual data model;
- roles;
- screen map;
- contratos de salida;
- preguntas de arquitectura.

---

# 4. Track MSL — Maintenance Standards Library

**Estado:** iniciado 2026-09-11; MSL-G01/G02 superados el 2026-10-08. Este apartado conserva objetivos, no la lista de gates actuales.

## MSL-G01 — Source normalization

Objetivo:

- registrar una fuente real;
- extraer por tipo de equipo;
- normalizar actividades, frecuencias, Job Plans, procedures, resources y sources;
- conservar provenance.

No crear fixture de biblioteca antes de PASS.

## MSL-G02 — Core contracts

Cerrar:

```text
MaintenanceStandardLibrary
EquipmentTypeStandard
StandardPlanVersion
StandardMaintenanceActivity
MaintenanceStrategy
JobPlan
ProcedureChecklist
ResourceRequirement
Frequency
SourceReference
```

## MSL-G03 — Project adoption/versioning

Validar:

```text
Corporate Standard Version
→ Project Adoption Snapshot
→ disabled / modified / added
→ Published Project Plan Version
```

## MSL-G04 — Corporate feedback loop

Validar:

```text
Project Learning
→ Corporate Change Proposal
→ Review / Approval
→ New Master Version
```

## MSL-UX — superficie futura

Solo después de G01/G02 decidir si se necesita:

```text
Maintenance Standards Library
= Configuration Studio / Library Explorer
```

No se añade automáticamente al mapa de pantallas.

---

# 5. FL-9 — Work Management Discovery

**Estado del descubrimiento histórico:** v0.2 (posteriormente v0.3). WM-G02/G03/G05 tienen contratos documentados en octubre; no validación de un AS-IS local.

## WM-G01 — AS-IS

Observar actores, estados, decisiones y excepciones.

## WM-G02 — Execution package

Cerrar:

```text
Activity
↔ JobPlan
↔ ProcedureChecklist
↔ Execution Result
```

**Actualización 2026-10-08:** WM-G02 = PASS_CONTRACT_WITH_EXTERNAL_PERMIT_BOUNDARY; la integración total de PTW/LOTO queda fuera de ese gate.

## WM-G03 — Planning/Scheduling

- horizon;
- candidates;
- grouping;
- windows;
- reprogramming;
- capacity;
- shifts;
- assignment;
- configurable routing.

## WM-G04 — Costes/contratos

Abrir detalle con perfiles responsables.

---

# 6. FL-10 — Gestión económica

Objetivo futuro:

```text
WO executed
→ actual cost
→ cost center / budget
→ contract / subcontract
→ corporate integration / invoicing
```

No iniciar diseño detallado sin discovery específico.

---

# 7. Track transversal AE — Asset Experience

Se conserva el estado contractual vigente:

```text
AE-0 Baseline audit                 PASS
AE-1 Asset Experience Contract      PASS_WITH_DEFERRED_ITEMS
AE-2 Asset Visual System            PASS_CONTRACT
AE-3 Premium Components             CONTRACT PASS / physical validation pending
AE-4 Screen Architecture            PASS_CONTRACT
AE-5 AssetPlan 3D consumption       CONTRACT PASS / runtime hold
AE-6 Power Apps implementation      gate-driven
AE-7 Convergence                    future
```

Conexión nueva con MSL:

```text
Asset.EquipmentTypeCode
→ candidate EquipmentTypeStandard
```

La relación física no se incorpora a contratos Asset hasta MSL-G02.

---

# 8. Orden operativo vigente y continuidad de aprendizaje

1. Completar **PA-G01-RUNTIME-MIN** con evidencia de los dos flows prioritarios.
2. Replicar el patrón validado en los otros seis flows, evitando escrituras directas de Power Apps sobre SQL.
3. Integrar una vertical mínima en Power Apps y pasar un gate real de Studio; no asumir que los workspaces previos están desplegados.
4. Abordar MSL-G03 (snapshot/adopción) y MSL-G04 (feedback al master) con la evidencia fuente y los contratos ya existentes.
5. Revisar, con responsables funcionales, los aspectos WM-G03/WM-G05 basados en benchmark antes de convertirlos en reglas operativas específicas.

El caso P-101 y el UX de la biblioteca siguen disponibles como laboratorios independientes, pero no bloquean el gate actual de integración.

---

# 9. Regla de continuidad

No construir porque “parezca lógico”.

```text
Evidence
→ Model
→ Contract
→ Small Implementation
→ Real Validation
→ Promotion
```

Y específicamente:

> No asumir que toda actividad nace de RCM.

> No cargar cada paso del checklist como actividad CMMS.

> No permitir que un override de proyecto modifique el estándar corporativo sin governance.
