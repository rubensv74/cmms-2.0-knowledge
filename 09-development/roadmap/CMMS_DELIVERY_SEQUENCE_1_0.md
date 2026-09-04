# CMMS 2.0 — Incremental Delivery Sequence 1.0

**Estado:** CANDIDATE  
**Fecha:** 2026-09-04  
**Primary delivery lane:** Reliability Engineering  
**Architecture:** Power Apps → Power Automate → SQL Server

---

## 1. Objetivo

Convertir el conocimiento ya consolidado en una secuencia de construcción ejecutable, evitando dos extremos:

- seguir acumulando concepto sin producto tangible;
- intentar construir de una vez toda la aplicación y todo el modelo SQL.

La unidad de delivery es una capability funcional observable.

---

## 2. Reglas de ejecución

Cada capability sigue, cuando aplique:

```text
Functional truth
→ UX contract
→ normalized mock
→ premium Power Apps candidate
→ Studio validation
→ backend/read-command contract
→ SQL implementation
→ SQL validation
→ thin Power Automate adapter
→ integrated runtime validation
→ consolidation
```

Reglas:

1. no avanzar sobre errores abiertos;
2. no diseñar todo SQL antes de tener consumers reales;
3. no introducir business logic crítica en Power Automate;
4. no duplicar invariantes SQL en Power Fx;
5. no introducir pantallas/tabs decorativos sin capability;
6. cada pantalla es premium desde el skeleton;
7. cada command mutable aplica la policy de concurrency/API readiness;
8. los datos iniciales pueden ser sintéticos, pero vivirán bajo contratos reales y podrán sustituirse sin rediseñar la UI;
9. un componente validado en AssetPlan/PULSE/TMS sigue requiriendo host validation en CMMS;
10. Work Management productivo no entra hasta cerrar sus gates funcionales pendientes.

---

## 3. Critical path

| Orden | Capability | Resultado observable | Gate dominante |
|---:|---|---|---|
| 0 | D00 Development Baseline | Arquitectura y reglas de desarrollo congeladas | Repository/Architecture |
| 1 | C01 Premium App Shell | Canvas app con shell premium real y estados base | Studio |
| 2 | I01-A Backend Pilot Contracts | Frontera SQL, outcomes, identity, audit y conventions cerrados | SQL Contract |
| 3 | I01-B Project / Asset / Study Read Slice | P-101 y Reliability Study se leen por contrato estable | SQL + Integration |
| 4 | I01-C Safe Study Scope Command | Primer command demuestra concurrency, audit y error contract | SQL C |
| 5 | C02 P-101 Reliability Backbone | Journey Power Apps → Flow → SQL integrado y visible | Runtime |
| 6 | C03 Reliability Studies | Usuario localiza/crea/continúa estudios | UX + Integration |
| 7 | C04 Study Scope | Boundary/context/evidence operables | Functional + SQL |
| 8 | C05 Functions & Failures | Funciones, fallos y modos navegables/editables | Functional + SQL |
| 9 | C06 FMEA Workspace | Effects + risk configurable + readiness | Risk Contract |
| 10 | C07 RCM Decision Workspace | Decision path explicable, sin scoring | RCM Contract |
| 11 | C08 Maintenance Strategy | Política → acciones → residual risk | Strategy Contract |
| 12 | C09 Review & Approval | Trazabilidad, overrides, submit/approve/freeze | Workflow + SQL C |
| 13 | C10 Implementation Handoff | Approved revision produce output hacia Maintenance | Contract |
| 14 | C11 Effectiveness Review | Datos simulados/reales abren nueva revisión sin sobrescribir historia | Versioning |

---

# 4. D00 — Development Baseline

**Objetivo:** convertir CMMS 2.0 de Functional Lab/documentación a producto construible.

Entregables:

- `CMMS_DEVELOPMENT_BASELINE_1_0.md`;
- mandatory SQL concurrency/API readiness policy;
- delivery sequence;
- runtime foundation gate.

**Gate:** repository review + no contradiction material conocida con Functional Journey.

---

# 5. C01 — Premium Application Shell

## Objetivo

Construir infraestructura visual final, no un mock desechable.

Incluye:

```text
Sidebar
Project Context
User / Environment Context
Page Identity
Workspace Host
Drawer / Overlay Host
Notification / State Layer
```

### C01-A Theme + layout foundation

- tokens;
- spacing;
- typography;
- semantic states;
- responsive desktop/laptop;
- canonical geometry.

### C01-B Shared shell components

Aplicar decisión:

```text
REUSE_CMMS
→ ADAPT_VERIFIED_BASE
→ EXTEND_SHARED
→ CREATE_SHARED
```

Candidatos a auditar primero desde AssetPlan/TMS/PULSE:

- Sidebar;
- Project Context;
- Page Header;
- Action Button;
- State Panel;
- Skeleton Loader;
- Icon resolver.

### C01-C Canonical screen template

Debe poder alojar cualquier workspace sin modificar el shell.

**Exit Gate:** save/close/reopen + App Checker baseline + navegación + responsive mínimo + visual PASS.

---

# 6. I01 — Backend Pilot Foundation

No se diseña todo el modelo CMMS.

Se implementa solamente lo necesario para demostrar el patrón productivo.

## I01-A — Common Contracts

Cerrar antes del primer DDL mutable:

- schema/application boundary;
- identifiers / keys;
- result/error envelope;
- identity and authorization boundary;
- audit convention;
- UTC date convention;
- `ProjectId` scope;
- concurrency/idempotency classification;
- least privilege;
- naming/versioning rules;
- test and rollback convention.

**Acceptance:** Power Apps puede distinguir `SUCCESS / VALIDATION / PERMISSION_DENIED / CONFLICT / DUPLICATE_REPLAY / ERROR` sin analizar texto libre.

## I01-B — First Read Slice

Consumers:

```text
Project context
P-101 Asset context
Reliability Study list/header
Study Scope read
```

Synthetic records are allowed, but the contract is real.

Acceptance:

- deterministic ordering;
- Project scope applied;
- null/unavailable semantics preserved;
- data read through `cmms_api` boundary;
- runtime account has no direct DML on domain tables.

## I01-C — Safe Study Scope Command

Primer command recomendado:

`Update Reliability Study Scope Draft`

¿Por qué este command?

- impacto acotado;
- editable/reversible;
- permite demostrar lost-update protection;
- no requiere aún workflow complejo;
- encaja en el primer screen backbone.

Debe demostrar:

```text
ProjectId
ActorEmail
RequestId
ExpectedConcurrencyToken
transaction
rowversion conflict
result contract
audit
```

IdempotencyKey se añadirá si el diseño final del submit/transport implica riesgo real de replay del mismo effect; si se omite deberá quedar justificado por clasificación del command.

Negative tests:

- stale token → `CONFLICT`;
- invalid Study → `NOT_FOUND`;
- wrong Project scope → no cross-project mutation;
- invalid boundary state → `VALIDATION`;
- runtime principal direct write → denied.

---

# 7. C02 — P-101 Reliability Backbone

Este es el **primer vertical slice tangible**.

Journey:

```text
Open CMMS
→ Project Context
→ P-101 Asset Context
→ Reliability Engineering
→ Study RCM-000127
→ Study Scope
→ edit draft
→ Save
→ Flow
→ SQL command
→ new ConcurrencyToken
→ refresh/reopen
→ continue to Functions & Failures
```

UI debe demostrar:

- premium shell;
- English product language;
- study header/status/revision;
- stage stepper;
- Evidence affordance;
- Save Draft;
- loading;
- error;
- conflict;
- successful read-back.

No se completa todavía FMEA/RCM/Strategy.

**Exit Gate:** un usuario puede recorrer el journey completo en runtime sin depender de datos hardcoded en la pantalla.

---

# 8. C03 — Reliability Studies

Pantalla: `RE-01 Reliability Studies`.

Arquetipo: `Data Explorer / Operational Queue`.

Capabilities:

- search;
- filters;
- status;
- progress/completeness cuando exista contrato real;
- continue/open;
- create study;
- no Project / loading / empty / error.

Create Study debe crear el aggregate mediante un command transaccional cuando se conecte a SQL.

No se crearán KPIs sin dato/acción real.

---

# 9. C04 — Study Scope

Pantalla: `RE-02 Study Scope`.

Arquetipo: `Object 360 / Governed Form`.

Capabilities:

- Analysis Object;
- scope type: System / Asset / Asset Group cuando esté validado;
- included/excluded members;
- Operating Context;
- Evidence drawer;
- readiness/gate;
- draft save;
- concurrency conflict.

Salida estructurada:

`StudyScopeReadyForFunctions`.

---

# 10. C05 — Functions & Failures

Pantalla: `RE-03 Functions & Failures`.

Arquetipo: `Master–Detail / Analysis Tree`.

Capabilities:

```text
Function
→ Functional Failure
→ Failure Mode
```

Principios:

- árbol persistente;
- master-detail, no spreadsheet gigante;
- library suggestion separate from human decision;
- add/edit/archive under governed states;
- dirty state;
- no silent cascade delete.

Gate a C06:

- required function/failure/mode data complete;
- relevant exclusion decisions traceable where applicable.

---

# 11. C06 — FMEA Workspace

Pantalla: `RE-04 FMEA Workspace`.

Arquetipo: `Operational Analysis Workbench`.

Debe separar:

- failure mechanism / cause;
- local effect;
- functional/system effect;
- end consequence;
- risk dimensions;
- initial risk;
- evidence;
- readiness.

Risk matrix/profile:

- configurable/versioned;
- never hardcoded as universal 5×5;
- UI renders the active profile.

**Gate previo:** minimum `RiskProfile` contract materialized.

---

# 12. C07 — RCM Decision Workspace

Pantalla: `RE-05 RCM Decision Workspace`.

Arquetipo: `Guided Decision Workspace`.

Interaction:

```text
one question
→ answer
→ explanation/evidence
→ branch
→ next decision
→ resulting policy
→ human confirmation
```

Must show:

- current question;
- decision path;
- why this question matters;
- supporting evidence;
- recommended policy;
- Accept Recommendation;
- Override + mandatory justification.

RCM has no accumulated score in the current methodology.

**Gate previo:** minimum RCM tree contract versioned and testable.

---

# 13. C08 — Maintenance Strategy

Pantalla: `RE-06 Maintenance Strategy`.

Arquetipo: `Operational Workbench`.

Conceptual relationship:

```text
FailureMode
→ RCM Policy
→ 1..N Maintenance Actions
```

No modelar `FailureMode 1 → 1 Action`.

Capabilities:

- policy context;
- one or more maintenance actions;
- technique;
- interval/frequency;
- execution condition;
- discipline/resource basics;
- acceptance criteria;
- residual risk;
- engineering action / redesign / run-to-failure outcomes when applicable.

Task, Job Plan and Maintenance Plan remain separate concepts.

---

# 14. C09 — Review & Approval

Pantalla: `RE-07 Review & Approval`.

Arquetipo: `Governed Review Workspace`.

Capabilities:

- completeness;
- open items;
- high residual risk;
- overrides;
- traceability;
- reviewer comments/disagreements;
- Submit for Review;
- Approve / Reject / Return;
- immutable approved revision.

Critical commands:

- submit;
- approve/freeze;
- publish when defined.

Estos commands requieren análisis explícito de transaction, idempotency y serialization.

Approved content is never edited in place. A new revision is opened.

---

# 15. C10 — Implementation Handoff

Objetivo: producir un output estructurado, no Work Orders ficticias.

Conceptual output:

```text
Approved Reliability Study Revision
+ Approved Maintenance Strategies
+ Maintenance Actions
→ Maintenance Development / Plan Handoff
```

Mientras Work Management siga `to_validate`, el producto mostrará la frontera sin inventar routing/planning/scheduling.

---

# 16. C11 — Effectiveness Review

Cerrar el ciclo:

```text
approved hypothesis
→ execution/failure/condition evidence
→ comparison
→ maintain / adjust / reopen
→ new revision
```

Never overwrite historical approved versions.

---

## 17. Supporting Asset track

Asset Experience sigue siendo foundation transversal, pero no debe competir con el PRIMARY.

Durante Reliability Engineering solo se construirá lo mínimo necesario:

- Asset identity/context;
- hierarchy path;
- criticality/context available by contract;
- technical/evidence links required by the study.

El Object 360 completo puede evolucionar como supporting capability si no bloquea el primary slice.

---

## 18. Work Management hold

No iniciar implementación productiva detallada de:

- Planner;
- Scheduling;
- routing;
- assignment;
- execution/check sheets;
- cost/contract/facturation

hasta cerrar los gates de discovery correspondientes.

El producto puede mostrar handoff conceptual y contratos de frontera, no comportamiento inventado.

---

## 19. Próximo gate real

Después de esta baseline, el siguiente gate requiere herramienta real:

```text
G0 Runtime Foundation
```

Debe identificar:

- Canvas app/environment real;
- Power Apps Source Code reality;
- SQL database target;
- runtime SQL/Flow connection identity;
- permissions baseline;
- App Checker baseline;
- first component import/adaptation reality.

No se debe generar DDL productivo ni declarar componentes CMMS `VALIDATED` antes de este gate.
