# CMMS 2.0 — I01-A Power Automate Runtime Probe

**State:** `READY_FOR_REAL_FLOW_GATE`  
**Date:** 2026-09-05  
**Flow name:** `CMMS_I01A_RuntimeProbe`  
**Architecture:** Power Apps → Power Automate → SQL Server  
**Database:** `db-omm-dev`  
**Procedure:** `cmms.usp_Runtime_Probe`

---

## 1. Purpose

Prove the real transport path before CMMS business tables exist.

```text
Power Apps
→ Power Apps (V2) trigger
→ existing SQL connection
→ db-omm-dev
→ cmms.usp_Runtime_Probe
→ normalized result
→ Respond to Power Apps
```

No business rule belongs in this Flow.

---

## 2. Connection rule

Use the existing SQL connection backed by the current development user (`tradminomm`).

Do not:

- create a new SQL user;
- create a database role;
- grant a CMMS-specific role;
- switch to direct table access.

---

## 3. Trigger

Create an **Instant cloud flow** using **Power Apps (V2)**.

Add two Text inputs:

```text
ActorEmail
RequestId
```

Power Apps owns/generates these values for this probe.

---

## 4. SQL action

Add SQL Server action:

```text
Execute stored procedure (V2)
```

Connection:

```text
existing development SQL connection
```

Target:

```text
Database = db-omm-dev
Schema   = cmms
Procedure = usp_Runtime_Probe
```

Parameter mapping:

```text
@ActorEmail ← ActorEmail
@RequestId  ← RequestId
```

Do not add conditions around SQL outcome codes.

The SQL procedure owns validation/outcome semantics.

---

## 5. Capture the first result row

The procedure returns exactly one result row.

Use the designer's first SQL result row. In environments where the SQL connector exposes the result as `ResultSets / Table1`, the conceptual expression is:

```text
first(ResultSets.Table1)
```

If the designer generates a different result-set token/name, select the first returned row rather than hardcoding a different business interpretation.

Expected fields:

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

---

## 6. Response to Power Apps

Add:

```text
Respond to a PowerApp or flow
```

Return Text outputs with these exact names:

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

Map each output directly from the SQL result row.

Do not rename `outcomeCode` to a UI-specific term.

---

## 7. Transport failure rule

Do not convert SQL connector/connection failures into a fake business `SUCCESS` response.

Distinguish:

```text
SQL returned VALIDATION/CONFLICT/etc. = valid application outcome
SQL action could not execute          = transport/runtime failure
```

This distinction becomes important once real write commands exist.

---

## 8. Save and test from Power Automate

Save the Flow.

A direct designer test may be used to prove the SQL call, but **I01-A is not complete until Power Apps calls the Flow**.

Expected successful SQL outcome:

```text
outcomeCode = SUCCESS
ok          = true
requestId   = same GUID sent by caller
dataJson.DatabaseName = db-omm-dev
dataJson.ProcedureSchema = cmms
dataJson.ProcedureName = usp_Runtime_Probe
```

---

## 9. Add Flow to the CMMS Canvas app

Add `CMMS_I01A_RuntimeProbe` to the app through the Power Automate pane.

Do not replace the current app's SQL architecture with a direct SQL datasource.

---

## 10. Power Apps test contract

Use the formula stored in:

```text
09-development/power-apps/I01_A_RUNTIME_PROBE_POWERFX.txt
```

For the gate, a temporary development button is acceptable. Delete it after PASS; it is not a product control.

The test must prove:

```text
Power Apps generated RequestId
= Flow RequestId
= SQL returned requestId
```

and:

```text
outcomeCode = SUCCESS
```

---

## 11. PASS evidence

Capture:

```text
Flow successful run
SQL stored procedure action = succeeded
response outcomeCode = SUCCESS
requestId round-trip preserved
Power Apps success notification / variable result
```

PASS marker:

```text
PASS_I01A_RUNTIME_CONTRACT
```

---

## 12. After PASS

The probe remains useful as a development diagnostic but is not part of Reliability business logic.

Next backend increment:

```text
I01-B
Project Context
→ P-101 Asset Context
→ Reliability Study read slice
```
