# CMMS 2.0 — Incremental Delivery Sequence 1.0

**Estado:** ACTIVE DEVELOPMENT BASELINE  
**Actualizado:** 2026-09-05  
**Primary delivery lane:** Reliability Engineering  
**Architecture:** Power Apps → Power Automate → SQL Server  
**Database / schema:** `db-omm-dev` / `cmms`

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
8. los datos iniciales pueden ser sintéticos, pero viven bajo contratos reales y pueden sustituirse sin rediseñar la UI;
9. un componente validado en AssetPlan/PULSE/TMS sigue requiriendo host validation en CMMS;
10. Work Management productivo no entra hasta cerrar sus gates funcionales pendientes;
11. Power Automate usa la conexión SQL de desarrollo existente (`tradminomm`); no se crean roles CMMS adicionales;
12. la aplicación no usa DML directo sobre tablas aunque la cuenta técnica de desarrollo disponga de permisos amplios.

---

## 3. Estado del critical path

| Orden | Capability | Estado actual | Resultado observable | Gate dominante |
|---:|---|---|---|---|
| 0 | D00 Development Baseline | PASS | Arquitectura y reglas congeladas | Repository/Architecture |
| 1 | C01 Premium App Shell | IN_PROGRESS | Canvas app con shell premium real y estados base | Studio |
| 2 | I01-A Backend Pilot Contracts | READY_FOR_RUNTIME_GATE | Contrato SQL/Flow mínimo probado | Runtime |
| 3 | I01-B Project / Asset / Study Read Slice | NOT_STARTED | P-101 y Reliability Study se leen por contrato estable | SQL + Integration |
| 4 | I01-C Safe Study Scope Command | NOT_STARTED | Primer command demuestra concurrency, audit y error contract | SQL Concurrency |
| 5 | C02 P-101 Reliability Backbone | NOT_STARTED | Journey Power Apps → Flow → SQL integrado y visible | Runtime |
| 6 | C03 Reliability Studies | NOT_STARTED | Usuario localiza/crea/continúa estudios | UX + Integration |
| 7 | C04 Study Scope | NOT_STARTED | Boundary/context/evidence operables | Functional + SQL |
| 8 | C05 Functions & Failures | NOT_STARTED | Funciones, fallos y modos navegables/editables | Functional + SQL |
| 9 | C06 FMEA Workspace | NOT_STARTED | Effects + risk configurable + readiness | Risk Contract |
| 10 | C07 RCM Decision Workspace | NOT_STARTED | Decision path explicable, sin scoring | RCM Contract |
| 11 | C08 Maintenance Strategy | NOT_STARTED | Política → acciones → residual risk | Strategy Contract |
| 12 | C09 Review & Approval | NOT_STARTED | Trazabilidad, overrides, submit/approve/freeze | Workflow + SQL C |
| 13 | C10 Implementation Handoff | NOT_STARTED | Approved revision produce output hacia Maintenance | Contract |
| 14 | C11 Effectiveness Review | NOT_STARTED | Evidencia real/simulada abre nueva revisión sin sobrescribir historia | Versioning |

---

# 4. D00 — Development Baseline

**Estado:** PASS.

Resultado:

- arquitectura actual: Power Apps → Power Automate → SQL Server;
- futura API preparada mediante contratos estables, no implementada ahora;
- concurrencia obligatoria desde el primer modelo mutable;
- `db-omm-dev` confirmado;
- schema `cmms` confirmado;
- conexión SQL de desarrollo existente, sin roles adicionales.

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

**Estado:** PASS en Studio real.

Confirmado:

- named formulas/theme;
- responsive app;
- Source Code screen compatible;
- visual language CMMS;
- Reliability Engineering landing concept renderizado.

### C01-B Shared shell components

**Estado:** READY_FOR_STUDIO_GATE.

Componentes candidatos canónicos:

```text
cmp_CMMS_SidebarPro
cmp_CMMS_ProjectContextPro
cmp_CMMS_PageHeaderPro
```

Decisiones:

- host owns navigation/project state;
- componentes no ejecutan navegación física;
- solo Reliability Engineering está habilitado hasta existir pantallas reales para otros módulos;
- componentes son visualmente autosuficientes y no dependen de App Scope para tokens.

### C01-C Canonical screen template

Se congela **después de C01-B PASS**, no antes.

Exit Gate C01:

```text
save/close/reopen
+ App Checker
+ sidebar collapse/expand
+ responsive representative desktop widths
+ retained Reliability Engineering screen
```

---

# 6. I01 — Backend Pilot Foundation

No se diseña todo el modelo CMMS.

Se implementa solamente lo necesario para demostrar el patrón productivo.

## I01-A — Common Contracts

**Estado:** CONTRACT BASELINE + RUNTIME PROBE PREPARED.

Baseline congelada en:

```text
09-development/backend/I01_A_COMMON_BACKEND_CONTRACTS.md
```

Decisiones:

- database `db-omm-dev`;
- current implementation schema `cmms`;
- Power Automate usa conexión existente `tradminomm`;
- no roles/principals nuevos;
- `uniqueidentifier` para IDs;
- UTC `datetime2(3)`;
- `RequestId` round-trip;
- functional actor via `ActorEmail`;
- normalized result envelope;
- `rowversion` → textual `ConcurrencyToken` for mutable consumers;
- SQL remains transactional/concurrency authority.

Primer procedimiento:

```text
cmms.usp_Runtime_Probe
```

No crea tablas de negocio.

Acceptance:

```text
Power Apps → Power Automate → cmms.usp_Runtime_Probe → normalized response → Power Apps
```

## I01-B — First Read Slice

Consumers:

```text
Project Context
P-101 Asset Context
Reliability Study list/header
Study Scope read
```

Synthetic records are allowed, but the contract is real.

Acceptance:

- deterministic ordering;
- Project scope applied;
- null/unavailable semantics preserved;
- data read through published `cmms` Stored Procedures;
- Power Apps/Power Automate do not issue direct table DML;
- physical tables remain replaceable behind the published contracts.

## I01-C — Safe Study Scope Command

Primer mutable command recomendado:

```text
Update Reliability Study Scope Draft
```

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

Idempotency se clasificará expresamente. Power Automate retry se considera un replay source real.

Negative tests:

- stale token → `CONFLICT`;
- invalid Study → `NOT_FOUND`;
- wrong Project scope → no cross-project mutation;
- invalid boundary state → `VALIDATION`;
- application path performs no direct table DML.

---

# 7. C02 — P-101 Reliability Backbone

Primer vertical slice tangible:

```text
Open CMMS
→ Project Context
→ P-101 Asset Context
→ Reliability Engineering
→ Study RCM-000127
→ Study Scope
→ edit draft
→ Save
→ Power Automate
→ cmms command procedure
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

**Exit Gate:** journey completo en runtime sin datos hardcoded en la pantalla.

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

Create Study crea el aggregate mediante command transaccional cuando se conecte a SQL.

---

# 9. C04 — Study Scope

Pantalla: `RE-02 Study Scope`.

Arquetipo: `Object 360 / Governed Form`.

Capabilities:

- Analysis Object;
- scope type System / Asset / Asset Group cuando esté validado;
- included/excluded members;
- Operating Context;
- Evidence drawer;
- readiness/gate;
- draft save;
- concurrency conflict.

Salida estructurada:

```text
StudyScopeReadyForFunctions
```

---

# 10. C05 — Functions & Failures

Pantalla: `RE-03 Functions & Failures`.

Arquetipo: `Master–Detail / Analysis Tree`.

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
- UI renders active profile.

---

# 12. C07 — RCM Decision Workspace

Pantalla: `RE-05 RCM Decision Workspace`.

Arquetipo: `Guided Decision Workspace`.

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

---

# 13. C08 — Maintenance Strategy

Pantalla: `RE-06 Maintenance Strategy`.

Relationship:

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

---

# 14. C09 — Review & Approval

Pantalla: `RE-07 Review & Approval`.

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

Critical commands require explicit transaction, idempotency and serialization review.

Approved content is never edited in place. A new revision is opened.

---

# 15. C10 — Implementation Handoff

```text
Approved Reliability Study Revision
+ Approved Maintenance Strategies
+ Maintenance Actions
→ Maintenance Development / Plan Handoff
```

Mientras Work Management siga `to_validate`, el producto muestra la frontera sin inventar routing/planning/scheduling.

---

# 16. C11 — Effectiveness Review

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

Asset Experience sigue siendo foundation transversal, pero no compite con el PRIMARY.

Durante Reliability Engineering se construye lo mínimo necesario:

- Asset identity/context;
- hierarchy path;
- criticality/context available by contract;
- technical/evidence links required by the study.

---

## 18. Work Management hold

No iniciar implementación productiva detallada de Planner, Scheduling, routing, assignment, execution/check sheets o costes hasta cerrar discovery/gates correspondientes.

---

## 19. Próximo gate real — Combined C01-B + I01-A

No hay otro bloqueo conceptual antes de este punto.

La siguiente intervención manual debe probar dos cosas en una misma ronda:

```text
A. Power Apps
C01-B shared components + retained Reliability Engineering screen

B. Backend runtime
cmms.usp_Runtime_Probe
→ Power Automate
→ Power Apps round-trip
```

PASS combinado cuando:

```text
C01_B_SHARED_SHELL_STUDIO_PASS
PASS_I01A_RUNTIME_CONTRACT
```

Después del PASS:

```text
freeze C01-C canonical template
→ I01-B minimum Project / Asset / Reliability Study model
→ real Reliability Studies read slice
```
