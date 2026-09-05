# CMMS 2.0 — SQL Development Runbook

**Target:** `db-omm-dev`  
**Shared database:** CMMS, TMS and future Operations & Maintenance developments  
**Current CMMS implementation schema:** `cmms`

---

## Runtime architecture

```text
Power Apps
   ↓
Power Automate
   ↓ existing SQL connection / tradminomm
cmms Stored Procedures
   ↓
cmms business tables
```

No HTTP API is built in the current phase.

No CMMS-specific database role or SQL principal is created.

The SQL connection identity is technical. User-originated commands transport the functional actor (`ActorEmail` initially) so audit/business traceability does not collapse into the shared SQL connection account.

---

## Schema rule

All new CMMS business tables and published Stored Procedures introduced by the current implementation baseline are created under:

```text
cmms
```

The earlier namespace bootstrap also created `cmms_api`, `cmms_cfg`, `cmms_audit` and `cmms_stage`. They may remain present and empty; the current I01 implementation does not require them and creates no new objects there.

Future API readiness is achieved through stable procedure contracts and separation of Power Apps from physical tables, not by requiring a particular SQL schema name.

---

## Completed bootstrap

Already executed against `db-omm-dev`:

```text
001_CMMS_NAMESPACE_BOOTSTRAP.sql
003_CMMS_NAMESPACE_VERIFY.sql
```

Confirmed:

- target database `db-omm-dev`;
- Azure SQL;
- current development identity `tradminomm`;
- `cmms` schema available;
- `rowversion` supported;
- transactions/rollback supported;
- `UNIQUE` / `CHECK` constraints supported;
- `sp_getapplock` available;
- current identity can create tables/procedures/views and alter CMMS schemas.

Evidence is stored under `09-development/gates/evidence/`.

---

## I01-A — first executable backend contract

I01-A deliberately introduces **no business table**.

Run in this order:

```text
010_I01A_RUNTIME_PROBE.sql
011_I01A_RUNTIME_PROBE_VERIFY.sql
```

Expected markers:

```text
PASS_010_I01A_RUNTIME_PROBE_DEPLOYED
PASS_011_I01A_RUNTIME_PROBE_VERIFY
```

The procedure created is:

```text
cmms.usp_Runtime_Probe
```

It proves the normalized Power Platform contract shape before Reliability data is introduced.

Rollback if needed:

```text
010_I01A_RUNTIME_PROBE_ROLLBACK.sql
```

The rollback removes only the probe procedure.

---

## Power Automate rule

Power Automate remains thin:

```text
Power Apps request
→ pass fields unchanged
→ execute cmms Stored Procedure
→ return normalized outcome
```

Do not move CMMS business rules into Flow conditions merely because the Flow can express them.

---

## Mandatory SQL rules from first business table

Every mutable capability must classify and test:

```text
ProjectId scope
aggregate boundary
transaction boundary
lost-update risk
rowversion / ConcurrencyToken
retry / replay risk
IdempotencyKey where applicable
RequestId
PK / FK / UNIQUE / CHECK / nullability
locking / serialization when truly required
ActorEmail / audit
result / validation / conflict contract
future API compatibility
```

A successful execution alone is not PASS.

---

## Future API readiness

Current:

```text
Power Apps → Power Automate → cmms Stored Procedures → SQL
```

Future option:

```text
Power Apps / Web / Mobile
          ↓
      Corporate API
          ↓
 same business intentions / stable backend contracts
          ↓
          SQL
```

The future API must not require a rewrite because screens know table names or Flow owns critical invariants.

---

## Next productive slice after I01-A PASS

Only after the runtime contract is proven:

```text
I01-B
Project Context read
→ P-101 Asset Context read
→ Reliability Study list/header read
→ Study Scope read
```

Then:

```text
I01-C
safe Study Scope draft command
→ transaction
→ rowversion conflict protection
→ functional actor/audit
→ normalized outcome
```

This keeps SQL development driven by real UI consumers instead of designing the entire CMMS database upfront.
