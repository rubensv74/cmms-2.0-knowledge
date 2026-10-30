## DVP v2 — estado actualizado (2026-10-30)

El primer recorrido se acotó a Work Queue PM anual → detalle de orden anual → retorno con contexto. Los targets v2 y el fixture anual están alineados con synthetic profile v1.1. La cola no incluye fila correctiva, Export ni Refresh; el detalle muestra actuaciones planificadas y ejecuciones reales inline. Los cuatro nombres del detalle coinciden con la actividad del registro seleccionado.

- Scope funcional v2: candidato, revisión pendiente; no se declara FE-COVERAGE PASS.
- Targets SVG: candidatos, revisión humana y pin exacto pendientes. Work Queue blob f15d2a5ea4654c91791ee6f0b1b4c7c5aa02010d; detalle blob 360ca111366f5f0e13caa051a762587715285bb2.
- Componentes IAP/host: inventario preliminar en 06-ui-ux/functional-lab/dvp/iap-component-inventory-v1.md; source registry pendiente.
- Region map y matriz de estados candidatos redactados en 06-ui-ux/functional-lab/dvp/work-queue-annual-order-region-map-v2-candidate.md; readiness findings v2 registra cierres de candidato y gates pendientes. Falta medición Canvas y confirmación de contratos source.
- Siguiente secuencia: (1) revisión baseline funcional y pin de target; (2) source registry y host; (3) region map, estados e interacción; (4) informes D2P v3.3; (5) preparar paquete Canvas solo con gates listos.
- La ratificación TR y los contratos de runtime siguen siendo gates para implementación real; no bloquean este DVP candidato de solo lectura y datos sintéticos.

Consulta el [plan de ejecución DVP v2](06-ui-ux/functional-lab/dvp/CMMS-LAB-DVP-NEXT-EXECUTION-PLAN-v2.md). El estado PM-GROUP-G01 y sus reglas de runtime se mantienen según la sección operativa/histórica de abajo.

---

# Roadmap CMMS 2.0

**Última revisión:** 2026-10-30

> **Estado operativo vigente.** DEC-025 confirma la orden preventiva anual con varias actuaciones programadas independientes para las actividades elegibles. El SQL/SP/PA validado en octubre representa el modelo previo y no valida esta semántica. Las secciones históricas permanecen para contexto.

## 0. Gates alcanzados y siguiente paso

| Secuencia | Gate | Resultado documentado |
|---:|---|---|
| 1–8 | MSL-G01/02, TRG-G01, WM-G02/03/05, DM-G01/02 | PASS de contrato/benchmark/lógico según el alcance registrado |
| 9 | DB-G01-RUNTIME / SP-G01 | PASS_RUNTIME para el modelo previo (37 tablas y procedimientos) |
| 10 | DEC-025 | CONFIRMED: una orden preventiva anual seleccionada, varias actuaciones programadas, fechas/resultados separados |
| **11** | **PM-GROUP-G01 — Contrato anual** | **NEXT / baseline candidato listo; ratificación TR pendiente; riesgo C** |
| 12 | DB/SP/PA incremental | Bloqueado hasta aprobar el contrato y la migración |
| 13 | PA runtime + primer slice Canvas/DVP | Después de la revisión SQL/flow; requiere evidencia en herramientas reales |

**En paralelo:** avanzar el DVP de Work Queue → Annual Work Order Detail usando el [screen contract candidato](06-ui-ux/functional-lab/dvp/work-queue-annual-order-screen-contract-v1.md) y escenarios sintéticos. El gate PM-GROUP-G01 ratifica reglas antes de runtime. Brief de decisión: [PM-GROUP-G01 functional decision brief](07-it-handoff/04-data/PM-GROUP-G01-functional-decision-brief-v1.md). Después cerrar cardinalidades, materialización/idempotencia, agenda/recursos, estados, hallazgos, cierres y migración/backfill. Revisar [contrato lógico](07-it-handoff/04-data/annual-preventive-work-order-aggregation-v1.md) y [contrato técnico candidato](07-it-handoff/04-data/annual-preventive-work-order-technical-contract-v1.md).

**No ejecutar todavía:** el Flow 2 del paquete histórico materializa una WO por `MaintenanceOccurrence`, lo que contradice el agrupamiento anual. También queda suspendido el Flow 1 como prueba de la nueva vertical hasta que el contrato de lectura incorpore actuaciones programadas y estados agregados. El paquete se actualizará tras la ratificación empresarial del baseline y la aprobación del contrato.

**CMMS Lab en paralelo:** fixture funcional sintético enlazado (250 activos; PM anual, CBM, correctivo, hallazgos, actuals y límites de permisos/inventario), bajo autoridad demostrativa. No representa valores ni estándares aprobados. El generador ofrece perfil de carga separado.

**DVP / Power Apps:** el brief, screen contract y dos targets SVG candidatos permiten revisar el flujo visual con datos sintéticos. La composición candidata avanza en paralelo; las imágenes aún no son targets aprobados. El paso a Studio y runtime exige los artefactos DVP de origen, contracts de lectura/write coherentes y ratificación de las reglas de negocio que afecten transiciones y autoridad; no se afirma implementación/validación Studio.

**Después del gate:** migración aditiva con backfill, procedures y flows idempotentes, runtime validation manual en el entorno de desarrollo, primer vertical slice Power Apps y handoff funcional-técnico para IT.

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
