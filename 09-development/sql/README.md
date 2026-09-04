# CMMS 2.0 — SQL Development Bootstrap

**Target:** `db-omm-dev`  
**Database role:** shared O&M development database used by CMMS, TMS and future Operations & Maintenance products.  
**Rule:** CMMS objects are namespaced; no new CMMS object is created in `dbo`.

## Namespace

```text
cmms        = physical/domain data owned by CMMS
cmms_api    = stable application boundary exposed to Power Automate / future API
cmms_cfg    = governed/versioned configuration
cmms_audit  = command/decision/audit data
cmms_stage  = controlled staging/import area when needed
```

`cmms_api` does **not** mean that an HTTP API exists today. It is the SQL application boundary deliberately prepared so a future API can consume stable contracts without making the Power Apps UI depend on physical tables.

## Runtime architecture now

```text
Power Apps
   ↓
Power Automate
   ↓
cmms_api (views / query SPs / command SPs)
   ↓
cmms / cmms_cfg / cmms_audit
```

Future evolution may become:

```text
Power Apps / Web / Mobile / Integrations
   ↓
Corporate API
   ↓
cmms_api-compatible backend contracts
   ↓
CMMS domain data
```

No API is built in the current development phase.

## Initial scripts

Run in this order against `db-omm-dev`:

1. `001_CMMS_NAMESPACE_BOOTSTRAP.sql`
   - creates the five CMMS schemas if missing;
   - creates no business tables;
   - aborts if executed in a different database.

2. `002_CMMS_RUNTIME_ROLE.sql`
   - creates database role `cmms_runtime`;
   - grants only `SELECT`/`EXECUTE` on `cmms_api`;
   - explicitly denies direct CRUD access to physical CMMS schemas;
   - does **not** bind a real user/login yet.

3. `003_CMMS_NAMESPACE_VERIFY.sql`
   - confirms target server/database/current execution identity;
   - confirms schemas and role permissions;
   - proves `rowversion`, `UNIQUE`, `CHECK` and transaction rollback using a temporary object;
   - reports whether `sp_getapplock` is available;
   - creates no persistent business object.

Expected final markers:

```text
PASS_001_CMMS_NAMESPACE_BOOTSTRAP
PASS_002_CMMS_RUNTIME_ROLE
PASS_003_CMMS_NAMESPACE_VERIFY
```

## Why there are several schemas instead of only `cmms`

The database is shared. A single `cmms` schema would isolate names from TMS but would still mix:

- physical tables;
- stable consumer contracts;
- mutable configuration;
- audit/history;
- transient staging.

Separating those responsibilities now is inexpensive and prevents Power Apps/Power Automate from becoming coupled to the physical model.

## Mandatory SQL rules from first business table

Every mutable capability must classify:

```text
Project scope
Atomic transaction boundary
Lost-update risk
rowversion / ConcurrencyToken need
Retry / duplicate execution risk
IdempotencyKey need
RequestId / CorrelationId
UNIQUE / FK / CHECK invariants
Locking / serialization need
Actor / audit
Result / validation / conflict contract
Future API compatibility
```

No table or command is considered ready merely because it executes successfully.

## Next SQL increment after bootstrap PASS

Do **not** design the whole CMMS relational model next.

The first productive vertical slice is:

```text
Project / Asset context read
→ Reliability Study read
→ Study Scope draft read
→ safe Study Scope command
```

That slice will introduce only the minimum entities and contracts required to prove:

```text
Power Apps
→ Power Automate
→ cmms_api contract
→ transaction / validation / audit / concurrency
→ normalized result
→ Power Apps refresh/conflict UX
```

This is the first backend gate for the P-101 Reliability Engineering backbone.
