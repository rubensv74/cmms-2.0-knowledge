# CMMS 2.0 — G0 Runtime Foundation Gate

**Estado:** `PASS`  
**Fecha:** 2026-09-04  
**Desbloquea:** C01 Premium App Foundation + I01 Backend Pilot

---

## 1. Runtime baseline confirmed

```text
Power Apps app        = CMMS
Power Apps environment= ENV PRE TR 162
Canvas state          = clean / Screen1 + ScreenContainer1
Layout                = Responsive
Components            = none installed
SQL database          = db-omm-dev
SQL server            = dbs-hointegration-dev
SQL platform          = SQL Azure
SQL identity          = tradminomm
```

Current runtime architecture:

```text
Power Apps
   ↓
Power Automate
   ↓
existing SQL development user
   ↓
cmms_api contracts
   ↓
cmms / cmms_cfg / cmms_audit
```

No HTTP API is built now. No additional CMMS database role is created in this development phase.

---

## 2. SQL namespace — PASS

Installed in `db-omm-dev`:

```text
cmms
cmms_api
cmms_cfg
cmms_audit
cmms_stage
```

All are owned by `dbo`.

Verified capabilities:

```text
rowversion                    = PASS
transactions / rollback       = PASS
UNIQUE / CHECK constraints    = PASS
sp_getapplock                 = available
CREATE TABLE                  = available
CREATE PROCEDURE              = available
CREATE VIEW                   = available
ALTER cmms                    = available
ALTER cmms_api                = available
```

Evidence:

`09-development/gates/evidence/2026-09-04_G0_SQL_NAMESPACE_PASS.md`

---

## 3. Power Apps reality — PASS

Observed in the current real Canvas app:

```text
Environment = ENV PRE TR 162
Tree        = App / Screen1 / ScreenContainer1
Components  = empty
```

Display:

```text
App layout        = Responsive
Lock aspect ratio = Off
Lock orientation  = Off
```

App Checker baseline:

```text
Formulas      = no visible count
Runtime       = no visible count
Accessibility = 1
Performance   = no visible count
Data source   = no visible count
```

Formula bar confirms comma-separated function arguments.

Evidence:

`09-development/gates/evidence/2026-09-04_G0_POWER_APPS_PASS.md`

---

## 4. Runtime identity decision — PASS

Power Automate will execute Stored Procedures using the existing development database user with sufficient permissions in `db-omm-dev`.

No `cmms_runtime` or any other additional CMMS role is created.

This does not change application contracts:

- Power Apps does not perform direct CMMS table DML;
- Power Automate remains a thin transport/orchestration layer;
- mutations use business-oriented Stored Procedures;
- SQL owns integrity, transactions and concurrency;
- the functional actor is transported separately as `ActorEmail`/actor fields when applicable.

---

## 5. Future API readiness — PASS as development policy

CMMS uses `cmms_api` as a stable SQL application boundary.

This is not an HTTP API.

The current design must preserve the option to later insert a corporate API without rewriting Power Apps business semantics or moving SQL invariants into the client.

---

## 6. G0 checklist

```text
[x] Real Canvas app identified
[x] Current Power Apps environment identified
[x] Current tree captured
[x] Responsive settings confirmed
[x] App Checker baseline captured
[x] Current component inventory captured
[x] SQL target identified
[x] CMMS schemas installed
[x] SQL capabilities verified
[x] SQL execution identity captured
[x] Runtime identity strategy defined
[x] No additional DB role required
[x] Concurrency/API-readiness policy active
```

`G0_RUNTIME_FOUNDATION_PASS = PASS`

---

## 7. Immediate execution sequence

No additional conceptual phase is required.

```text
G0 PASS
→ C01-A Theme/Layout Foundation
→ C01 Source-Code Native Screen Reality Gate
→ C01-B Shared Shell Components
→ C01-C Canonical Screen Template
→ I01-A Common Backend Contracts
→ I01-B Project / Asset / Reliability Study read slice
→ I01-C Safe Study Scope command
→ C02 P-101 Reliability Backbone
```

The Source-Code reality check is deliberately limited to one complete native-control screen before extracting shared components. This prevents multiplying compatibility defects.
