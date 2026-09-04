# CMMS 2.0 — G0 Runtime Foundation Gate

**Estado:** `IN_PROGRESS / SQL_PASS / WAITING_POWER_APPS_STUDIO_EVIDENCE`  
**Fecha:** 2026-09-04  
**Bloquea:** C01 Premium App Shell + I01 Backend Pilot implementation

---

## 0. Estado real confirmado

```text
Canvas app target = CMMS
Canvas current state = exists / empty
SQL server = dbs-hointegration-dev
SQL database = db-omm-dev
SQL edition = SQL Azure
SQL connection/deployment identity = tradminomm
Database nature = shared O&M development database
Shared with = TMS + future Operations & Maintenance developments
Power Automate SQL runtime identity = existing administrative-capable database user
Additional CMMS database role = DO NOT CREATE
```

CMMS namespace installed:

```text
cmms        -- domain data
cmms_api    -- stable application boundary
cmms_cfg    -- governed/versioned configuration
cmms_audit  -- audit/history
cmms_stage  -- controlled imports/staging when needed
```

No new CMMS object is created in `dbo`.

### Gate status

```text
G0-PA-01 Canvas app target          = PASS
G0-PA-02 Current source reality     = WAITING_STUDIO_EVIDENCE
G0-PA-03 Current App Checker        = WAITING_STUDIO_EVIDENCE
G0-PA-04 Current components         = WAITING_STUDIO_EVIDENCE

G0-SQL-01 Database target           = PASS
G0-SQL-02 Runtime identity strategy = PASS / existing user, no extra role
G0-SQL-03 DDL identity              = PASS / tradminomm
G0-SQL-04 Feature availability      = PASS

G0-FLOW-01 SQL identity/path        = PASS_FOR_FOUNDATION / existing SQL connection identity
G0-FLOW-02 Contract transport       = NOT_STARTED / first contract in I01
```

SQL evidence:

`09-development/gates/evidence/2026-09-04_G0_SQL_NAMESPACE_PASS.md`

---

## 1. SQL PASS evidence

Real execution returned:

```text
ServerName        = dbs-hointegration-dev
DatabaseName      = db-omm-dev
LoginName         = tradminomm
DatabaseUser      = tradminomm
OriginalLogin     = tradminomm
ProductVersion    = 12.0.2000.8
Edition           = SQL Azure
DatabaseCollation = SQL_Latin1_General_CP1_CI_AS
HasSpGetAppLock   = 1
```

Schemas confirmed, owner `dbo`:

```text
cmms
cmms_api
cmms_audit
cmms_cfg
cmms_stage
```

Current development identity capability:

```text
CanCreateTable          = 1
CanCreateProcedure      = 1
CanCreateView           = 1
CanAlterCmmsSchema      = 1
CanAlterCmmsApiSchema   = 1
```

The verification script completed after exercising its temporary capability probe. Therefore G0 records PASS for:

```text
rowversion
transaction rollback
UNIQUE/CHECK constraints
sp_getapplock availability
schema creation/use
procedure/view/table deployment capability
```

No persistent CMMS business table was created by the probe.

---

## 2. Runtime SQL decision

Power Automate will execute CMMS Stored Procedures with the existing development database user.

No `cmms_runtime` or other CMMS-specific database role will be created in this phase.

The broad technical permission of the development connection does not change the application architecture:

```text
Power Apps
→ Power Automate
→ cmms_api read/command contracts
→ cmms / cmms_cfg / cmms_audit
```

Rules that remain mandatory:

- Power Apps does not perform direct table DML;
- business mutations are Stored Procedures oriented to intent;
- Power Automate transports/orchestrates, it does not own critical invariants;
- SQL owns integrity, transactionality and concurrency;
- the technical SQL identity is not the functional actor;
- Power Apps commands transport `ActorEmail` / actor identity when applicable.

---

## 3. Remaining Power Apps evidence

The previous August Power Apps evidence is historical only. The current app is declared empty, therefore G0 needs a fresh baseline before multiplying C01 components.

### G0-PA-02 — Current authoring/source reality

Confirm in the current `CMMS` app:

```text
Environment
Responsive/display configuration
Source Code / copy-paste mechanism available when used
Power Fx authoring syntax
```

Historical syntax was:

```text
function arguments = comma
instruction separator = semicolon
```

It must not be assumed if the app was recreated.

### G0-PA-03 — App Checker baseline

Capture the current summary:

```text
Errors
Formula/warnings when visible
Accessibility
Performance
```

### G0-PA-04 — Component inventory

Capture the current Components tree.

Because the app is currently declared empty, no historical CMMS component is considered installed until shown in Studio.

Candidate shared capabilities after the inventory:

```text
Sidebar
Project Context
Page Header
Action Button
State Panel
Skeleton Loader
Icon resolver
```

Lifecycle decision per candidate:

```text
REUSE_CMMS
ADAPT_VERIFIED_BASE
EXTEND_SHARED
CREATE_SHARED
DO_NOT_USE
```

No component becomes `VALIDATED_CMMS` without a real Studio/host gate.

---

## 4. G0 PASS criteria

```text
[x] Canvas app target identified
[ ] current Studio/source reality confirmed
[ ] current App Checker baseline captured
[ ] current component inventory captured
[x] SQL server/database target confirmed
[x] CMMS namespace bootstrap PASS
[x] runtime SQL identity strategy confirmed / no additional role
[x] DDL identity captured
[x] rowversion/transactions/constraints supported
[x] sp_getapplock available
[ ] first Power Apps → Power Automate → cmms_api contract proven
```

The last connector-path item will be proven by I01. It does not require creating a fake Flow merely to close the visual foundation.

---

## 5. Actions after Studio evidence

If the current empty app baseline is compatible, there is no additional conceptual phase:

```text
C01-A Theme/Layout Foundation
→ C01-B Shared Shell Components
→ C01-C Canonical Screen Template
→ I01-A Common Backend Contracts
→ I01-B First Read Slice
→ I01-C Safe Study Scope Command
→ C02 P-101 Reliability Backbone
```

---

## 6. Next real gate

Open the real `CMMS` Canvas app and provide evidence of:

```text
1. Environment + current screen tree
2. App Checker summary
3. Components tree
4. Display/responsive settings if not obvious from the first capture
```

One or two screenshots are sufficient if they show those items clearly.

No more SQL bootstrap work is required before C01/I01.
