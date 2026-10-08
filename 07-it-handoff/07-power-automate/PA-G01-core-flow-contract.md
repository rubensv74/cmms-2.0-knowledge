# CMMS 2.0 — PA-G01 Power Automate Core Flow Contract

**Date:** 2026-10-08  
**Status:** DESIGN_READY_FOR_FLOW_BUILD

## 1. Architecture

```text
Power Apps
   ↓
Power Automate flow
   ↓
Execute stored procedure (V2)
   ↓
cmms.usp_*
   ↓
SQL Server db-omm-dev
```

Power Apps must not write CMMS core tables directly.

## 2. Standard flow shape

Every core flow uses the same logical stages:

1. **Power Apps (V2)** trigger.
2. **Initialize_RequestId**
   - use incoming requestId if supplied;
   - otherwise generate a new GUID.
3. **Compose_RequestJson**
   - serialize only contract fields.
4. **SQL_Execute_Stored_Procedure**
   - call one validated `cmms.usp_*`;
   - pass `RequestJson`.
5. **Normalize_SQL_Result**
   - extract first row;
   - read `ReadState`, `ResultJson`, `ErrorCode`, `ErrorMessage`.
6. **Respond_to_PowerApps**
   - always return the same four fields.
7. **Catch scope**
   - convert connector/runtime failures to `ReadState=ERROR`, `ErrorCode=CMMS-500`.

## 3. Power Apps response contract

Every flow returns:

- `readState`
- `resultJson`
- `errorCode`
- `errorMessage`

Power Apps branches on `readState` and `errorCode`.

## 4. Idempotency

For command flows:

- Power Apps should generate and persist a requestId before invoking the flow;
- retry must reuse the same requestId;
- a new business command must use a new requestId.

If the flow itself generates the GUID, connector retry inside the same run is safe, but a full new flow invocation would be a new command. Therefore app-generated requestId is preferred for commands.

Query flows do not require requestId.

## 5. Error mapping

### Functional/business errors
Returned by SQL:
- CMMS-400
- CMMS-404
- CMMS-409
- CMMS-412
- CMMS-422

The flow does not convert these to failed flow runs. It returns them normally to Power Apps.

### Technical errors
Examples:
- SQL connector unavailable;
- timeout;
- malformed connector response;
- procedure missing;
- gateway/network issue.

Return:
- readState = ERROR
- errorCode = CMMS-500
- errorMessage = sanitized connector/runtime message

## 6. Naming convention

Prefix: `CMMS_CORE_`

Flows:

- `CMMS_CORE_WorkOrder_Get`
- `CMMS_CORE_WorkQueue_List`
- `CMMS_CORE_WorkOrder_Materialize`
- `CMMS_CORE_Planning_SetReadiness`
- `CMMS_CORE_Schedule_Commit`
- `CMMS_CORE_Execution_Start`
- `CMMS_CORE_Execution_Complete`
- `CMMS_CORE_WorkOrder_TechnicalClose`

## 7. Connection

- SQL Server connector.
- Database: `db-omm-dev`.
- Stored procedures in schema `cmms`.
- Existing SQL identity.
- No new SQL role/user.

## 8. Flow ownership

Power Automate owns:
- connector invocation;
- payload serialization;
- response normalization;
- transport/runtime error handling.

SQL owns:
- business validation;
- transaction;
- concurrency;
- idempotency;
- authoritative state transition.

Power Apps owns:
- UX;
- command intent;
- client-side requestId lifecycle;
- displaying functional errors.

## 9. Do not duplicate business logic

The flow must not:
- decide whether a WO can start;
- decide readiness;
- recompute DueAt;
- decide technical-close eligibility;
- update SQL tables directly.

Those rules remain in stored procedures.

## 10. PA-G01 gate

PA-G01 becomes PASS only after one query flow and one command flow have been built and validated end-to-end from Power Apps or Power Automate test mode against the validated SQL procedures.
