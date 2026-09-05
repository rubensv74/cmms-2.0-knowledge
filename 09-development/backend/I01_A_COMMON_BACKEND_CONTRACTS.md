# CMMS 2.0 — I01-A Common Backend Contracts

**State:** `BASELINE / READY_FOR_RUNTIME_GATE`  
**Date:** 2026-09-05  
**Architecture:** Power Apps → Power Automate → SQL Server  
**Database:** `db-omm-dev`  
**CMMS implementation schema:** `cmms`

---

## 1. Purpose

Freeze the minimum backend contract rules before the first CMMS business table or mutable business command is introduced.

This increment does **not** build a HTTP API. It makes the current Power Automate → SQL boundary stable enough that a future API can be inserted without rewriting Power Apps business semantics or SQL invariants.

---

## 2. Runtime architecture

```text
Power Apps
   ↓ intent + functional actor
Power Automate
   ↓ thin transport/orchestration
SQL Server / Azure SQL
   ↓
db-omm-dev
   ↓
cmms schema
```

Current SQL connection decision:

```text
Power Automate SQL connection
→ existing development database user: tradminomm
→ no additional CMMS database roles
```

No new database role is created by CMMS development.

The SQL connection identity is technical. It does not replace the functional actor who initiated an action in Power Apps.

---

## 3. Schema decision for implementation

Per current development instruction, all **new CMMS business tables, read procedures and command procedures** introduced by I01 are created under:

```text
cmms
```

Schemas created during the earlier namespace bootstrap (`cmms_api`, `cmms_cfg`, `cmms_audit`, `cmms_stage`) remain reserved and may stay empty. I01 does not require them and does not create new objects in them.

Future separation into additional schemas is a deployment/refactoring choice only if it preserves the published procedure contracts.

---

## 4. SQL remains the authority

SQL owns:

- relational integrity;
- transaction boundaries;
- business invariants that must survive concurrency;
- lost-update protection;
- idempotency where replay is possible;
- audit persistence;
- deterministic result/outcome semantics.

Power Apps expresses intent. Power Automate transports that intent. Neither layer replaces backend guarantees.

---

## 5. Identifier conventions

Default identifier for CMMS domain aggregates/entities:

```text
uniqueidentifier
```

Preferred table default when SQL creates the identifier:

```sql
NEWSEQUENTIALID()
```

Consumer-facing identifiers are transported as canonical GUID text:

```text
xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
```

Business codes such as `RCM-000127` are not primary keys.

---

## 6. Project scope

Every project-owned CMMS aggregate carries an explicit `ProjectId`.

Commands affecting a project-owned object receive or derive an unambiguous `ProjectId` and SQL validates that the target object belongs to that project.

No cross-project mutation is permitted because a client-side filter happened to select the right records.

---

## 7. Functional actor and technical identity

For actions originating in Power Apps:

```text
Technical SQL identity = tradminomm via Power Automate connection
Functional actor       = ActorEmail / future ActorId transported by the request
```

Initial functional actor field:

```text
ActorEmail nvarchar(320)
```

Normalization rule when persisted/compared:

```text
LOWER(LTRIM(RTRIM(ActorEmail)))
```

`ActorEmail` is audit/context data. It is not trusted as the sole authorization mechanism for a future production deployment.

---

## 8. UTC convention

Persist system timestamps in UTC using:

```sql
SYSUTCDATETIME()
```

Default precision:

```text
datetime2(3)
```

Published textual timestamps use ISO-8601 UTC representation.

No CMMS business table stores local Madrid time as system-of-record time.

---

## 9. Request and correlation identity

Every remote read/command used by Power Apps carries:

```text
RequestId uniqueidentifier
```

Recommended ownership:

```text
Power Apps user action
→ creates RequestId
→ Power Automate preserves it
→ SQL returns it unchanged
```

For the same transport retry of the same logical request, the same RequestId should be preserved whenever possible.

Later commands may add a separate `IdempotencyKey` when the same logical effect can be replayed.

---

## 10. Result contract

Power Apps must never infer success/failure by parsing free text.

The baseline one-row SQL envelope is:

```text
contractVersion
requestId
ok
outcomeCode
message
entityId
concurrencyToken
dataJson
isReplay
generatedAtUtc
```

For list/read procedures, optional additional fields may be added:

```text
count
hasMore
continuationToken
```

For Power Platform transport stability, the baseline envelope is published as text unless a specific contract intentionally documents a stronger type.

### Outcome vocabulary

```text
SUCCESS
VALIDATION
NOT_FOUND
PERMISSION_DENIED
CONFLICT
DUPLICATE_REPLAY
ERROR
```

`message` is human-readable context only. Branching logic uses `outcomeCode`.

---

## 11. Concurrency token

Mutable entities exposed to concurrent editing use SQL `rowversion` unless a specific aggregate proves it is unnecessary.

Published token format:

```text
0x + 16 hexadecimal characters
```

Example:

```text
0x00000000000007D3
```

Contract type:

```text
varchar(18)
```

Read pattern:

```text
rowversion
→ CONVERT(varchar(18), RowVersionColumn, 1)
→ ConcurrencyToken
```

Command pattern:

```text
ExpectedConcurrencyToken
→ convert to varbinary(8)
→ conditional UPDATE
→ 0 affected rows because token changed = CONFLICT
```

A stale editor never silently overwrites a newer database version.

---

## 12. Transactions

Any business intention requiring multiple dependent writes is one SQL transaction.

Pattern:

```sql
SET XACT_ABORT ON;
BEGIN TRY
    BEGIN TRANSACTION;
    -- validate
    -- write aggregate
    -- dependent writes
    -- audit
    COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    IF XACT_STATE() <> 0 ROLLBACK TRANSACTION;
    -- application error contract or rethrow technical failure as designed
END CATCH;
```

Power Automate never simulates a domain transaction by chaining independent SQL writes.

---

## 13. Idempotency classification

Each mutable procedure must explicitly classify replay risk:

```text
NOT_REQUIRED
REQUIRED
DEFERRED_WITH_JUSTIFICATION
```

Typical commands likely to require idempotency:

- create Reliability Study;
- submit for review;
- approve/freeze revision;
- publish/instantiate maintenance outputs;
- import commit.

The first Scope draft update will be evaluated separately in I01-C. Power Automate retry behavior is treated as a real replay source.

---

## 14. Stored procedure naming

Published CMMS procedures use business intent, not generic CRUD.

Examples:

```text
cmms.usp_Runtime_Probe
cmms.usp_Project_List
cmms.usp_Asset_GetContext
cmms.usp_ReliabilityStudy_ListByProject
cmms.usp_ReliabilityStudy_Get
cmms.usp_ReliabilityStudyScope_UpdateDraft
cmms.usp_RcmDecision_Confirm
cmms.usp_ReliabilityStudy_SubmitReview
```

Avoid contracts such as:

```text
usp_InsertTableX
usp_UpdateRowY
```

The consumer should not need to know the physical table layout.

---

## 15. Contract versioning

Initial contract version:

```text
1.0
```

Compatible additions may preserve the procedure and version where consumer behavior is unchanged.

Breaking semantic changes create an explicit new procedure/version contract rather than silently changing meaning for existing Power Automate flows.

A future HTTP API may wrap the same business intentions and result semantics.

---

## 16. Read contracts

Read procedures return shapes designed for the screen/use case rather than dumping normalized tables.

First intended consumers:

```text
Project Context
P-101 Asset Context
Reliability Studies list
Reliability Study header
Study Scope
```

Ordering is deterministic. Null/unavailable remains semantically distinct from false/zero/empty whenever that difference matters.

---

## 17. Error boundary

Expected application outcomes return a valid result envelope.

Examples:

```text
invalid field/value      → VALIDATION
missing aggregate        → NOT_FOUND
stale rowversion         → CONFLICT
known duplicate replay   → DUPLICATE_REPLAY
functional denial        → PERMISSION_DENIED
```

Infrastructure failures such as unavailable SQL connection remain transport failures and must not be disguised as business `SUCCESS`.

---

## 18. No additional database roles

Mandatory development rule:

```text
DO NOT CREATE cmms_runtime
DO NOT CREATE new CMMS database roles
DO NOT require a new SQL principal for this development increment
```

All I01 SQL scripts must be reviewable for this condition before execution.

---

## 19. I01-A runtime proof

The first executable backend artifact is intentionally small:

```text
cmms.usp_Runtime_Probe
```

It proves:

```text
Power Apps actor/request
→ Power Automate
→ existing SQL connection
→ db-omm-dev
→ cmms stored procedure
→ normalized result envelope
→ Power Apps
```

It creates no CMMS business table and mutates no business data.

---

## 20. Exit condition

I01-A is `PASS` when:

```text
[ ] procedure installed in db-omm-dev / cmms
[ ] direct SQL verification returns SUCCESS
[ ] Power Automate invokes it using the existing connection
[ ] RequestId round-trips unchanged
[ ] ActorEmail round-trips in DataJson/context
[ ] Power Apps receives outcomeCode without parsing message
[ ] no database role/principal was created
```

PASS marker:

```text
PASS_I01A_RUNTIME_CONTRACT
```
