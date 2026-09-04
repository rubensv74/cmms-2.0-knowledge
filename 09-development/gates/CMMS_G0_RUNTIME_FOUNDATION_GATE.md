# CMMS 2.0 — G0 Runtime Foundation Gate

**Estado:** `IN_PROGRESS / WAITING_SQL_BOOTSTRAP_EVIDENCE`  
**Fecha:** 2026-09-04  
**Bloquea:** C01 Premium App Shell + I01 Backend Pilot implementation

---

## 0. Estado real confirmado 2026-09-04

Evidencia confirmada por el responsable funcional:

```text
Canvas app target = CMMS
Canvas current state = exists / empty
SQL database target = db-omm-dev
Database nature = shared O&M development database
Shared with = TMS + future Operations & Maintenance developments
Power Automate SQL runtime identity = existing database user with administrative capability
Additional CMMS database role = DO NOT CREATE
```

Decisión de namespace aprobada:

```text
cmms        -- domain data
cmms_api    -- stable application boundary
cmms_cfg    -- governed/versioned configuration
cmms_audit  -- audit/history
cmms_stage  -- controlled imports/staging when needed
```

No se crearán objetos CMMS nuevos en `dbo`.

La evidencia Power Apps de 2026-08-24 se conserva como histórica. Como el estado actual declarado es `empty`, dicha evidencia conserva aprendizaje técnico pero no demuestra el inventario físico actual.

### Estado de checks

```text
G0-PA-01 Canvas app target          = PASS
G0-PA-02 Current source reality     = RECHECK_REQUIRED_ON_EMPTY_APP
G0-PA-03 Current App Checker        = REBASELINE_REQUIRED
G0-PA-04 Current components         = REAUDIT_REQUIRED

G0-SQL-01 Database target           = PARTIAL_PASS / db-omm-dev known
G0-SQL-02 Runtime identity strategy = PASS / existing admin-capable user, no extra role
G0-SQL-03 DDL identity              = PARTIAL / next SQL execution captures executor
G0-SQL-04 Feature availability      = WAITING_003_VERIFY

G0-FLOW-01 SQL connector reality    = PARTIAL_PASS / existing connection identity confirmed conceptually
G0-FLOW-02 Contract transport       = NOT_STARTED
```

The next real gate is execution of the SQL namespace bootstrap in `db-omm-dev` plus current Canvas baseline evidence.

---

## 1. Propósito

Confirmar la realidad técnica del entorno en el que se construirá CMMS 2.0 antes de generar una foundation Power Apps/SQL que luego haya que rehacer.

No reabre decisiones funcionales ya tomadas.

---

## 2. Evidencia Power Apps requerida

### G0-PA-01 — Canvas app target

Estado: `PASS`.

```text
App name: CMMS
Current state: empty
Desktop-first target: yes
```

Environment/App ID se capturarán durante la siguiente sesión real de Studio si fueran necesarios para trazabilidad.

### G0-PA-02 — Source Code reality

Confirmar en la app actual:

- Source Code schema aceptado cuando se use;
- authoring locale/syntax actual;
- versiones reales de `GroupContainer` y controles elegidos;
- posibilidad real de copiar/pegar Source Code/YAML conforme al patrón AssetPlan/TMS cuando proceda.

La evidencia histórica de 2026-08-24 registró:

```text
arguments = comma
instructions = semicolon
responsive layout = confirmed
```

Debe confirmarse la realidad actual antes de multiplicar artefactos.

### G0-PA-03 — App Checker baseline

Capturar baseline de la app vacía:

```text
Errors:
Warnings:
Accessibility:
Performance suggestions:
```

### G0-PA-04 — Component reality

Como la app actual se declara vacía, ningún componente histórico se considera instalado.

Auditar/adaptar primero candidatos reales de AssetPlan/TMS/PULSE para:

```text
Sidebar
Project Context
Page Header
Action Button
State Panel
Skeleton Loader
Icon resolver
```

Clasificación:

```text
REUSE_CMMS
ADAPT_VERIFIED_BASE
EXTEND_SHARED
CREATE_SHARED
DO_NOT_USE
```

Ningún componente se marca `VALIDATED_CMMS` por existir en otro repositorio.

---

## 3. Evidencia SQL requerida

### G0-SQL-01 — Database target

Estado: `PARTIAL_PASS`.

```text
Database: db-omm-dev
Environment intent: development
Database is shared with TMS and future O&M products
CMMS namespace strategy: approved
```

Pendiente de `003_CMMS_NAMESPACE_VERIFY.sql`:

```text
Server
Platform/edition
Collation
Execution identity
Feature availability
```

### G0-SQL-02 — Runtime identity

Estado: `PASS`.

Decisión vigente:

```text
Power Automate
→ existing development database user
→ execute CMMS stored procedures
```

No se crea un rol `cmms_runtime` ni ningún otro rol CMMS adicional.

La existencia de permisos administrativos en la cuenta técnica de desarrollo no cambia la arquitectura funcional:

- Power Apps no hará DML directo sobre tablas CMMS;
- las mutaciones se expresan como Stored Procedures orientados a intención de negocio;
- Power Automate transporta/orquesta y no redefine invariantes;
- SQL conserva integridad, concurrencia y transacciones.

La identidad técnica de conexión no sustituye la identidad funcional del usuario que inició la acción. Los commands transportarán `ActorEmail`/actor funcional cuando aplique.

### G0-SQL-03 — DDL authority

La ejecución de `003` captura la identidad utilizada durante desarrollo.

No se exige separar una identidad DDL de una identidad runtime durante esta fase de desarrollo.

### G0-SQL-04 — Feature availability

El script `003` verifica/recoge evidencia para:

- schemas;
- `rowversion`;
- transactions;
- `UNIQUE` / `CHECK` constraints;
- SQL platform/version;
- `sp_getapplock` availability;
- capacidad actual para crear tables/procedures/views en los schemas CMMS.

Stored Procedures/views de negocio se introducirán en I01-A/I01-B una vez que el namespace PASS.

### SQL bootstrap runbook

Ruta:

`09-development/sql/README.md`

Orden:

```text
001_CMMS_NAMESPACE_BOOTSTRAP.sql
→ 003_CMMS_NAMESPACE_VERIFY.sql
```

Expected markers:

```text
PASS_001_CMMS_NAMESPACE_BOOTSTRAP
PASS_003_CMMS_NAMESPACE_VERIFY
```

---

## 4. Evidencia Power Automate requerida

### G0-FLOW-01 — SQL connector reality

Usar la conexión SQL existente con el usuario ya disponible para desarrollo contra `db-omm-dev`.

No crear roles adicionales como parte de este gate.

### G0-FLOW-02 — Contract transport

El primer Flow será fino:

```text
Power Apps request
→ transport fields
→ execute cmms_api read/command contract
→ return normalized result
```

No introducir reglas de negocio del Reliability Study en el Flow.

---

## 5. Gate PASS

G0 se considera PASS cuando exista evidencia suficiente de:

```text
[x] Canvas app real identificada/creada
[ ] Source Code/current authoring reality confirmada
[ ] App Checker baseline de app actual capturado
[ ] foundation component strategy real confirmada
[x] SQL dev database target identificado
[ ] CMMS namespace bootstrap PASS
[x] runtime SQL identity strategy definida / no additional role
[ ] DDL execution identity captured
[ ] rowversion/transactions/constraints supported
[ ] Power Apps → Power Automate → SQL connector path proven with first contract
```

---

## 6. Acciones inmediatamente posteriores al PASS

```text
G0 PASS
→ C01-A Theme/Layout Foundation
→ C01-B Shell Components
→ C01-C Canonical Screen Template
→ I01-A Common Backend Contracts
→ I01-B First Read Slice
→ I01-C Safe Study Scope Command
→ C02 P-101 Reliability Backbone
```

---

## 7. Regla de parada

Si G0 detecta una incompatibilidad real de Source Code, permisos SQL o conectividad, se corrige la foundation antes de multiplicar artefactos.

Eso es un gate técnico real, no una razón para reabrir conceptos CMMS ya consolidados.
