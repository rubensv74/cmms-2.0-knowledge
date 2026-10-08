# CMMS 2.0 — PA-G01 Build Pattern

## Recommended Power Automate action pattern

### Scope — TRY

1. Power Apps (V2)
2. Compose — RequestJson
3. Execute stored procedure (V2)
4. Compose — FirstRow
5. Respond to Power Apps (V2)

### Scope — CATCH

Configure run-after:
- has failed
- has timed out
- is skipped where appropriate

Respond:
- readState = ERROR
- resultJson = blank
- errorCode = CMMS-500
- errorMessage = transport/runtime failure message

## RequestJson expression pattern

Prefer an object composed in Power Automate, then stringify it using `string(...)`.

Do not hand-concatenate JSON when avoidable.

Example conceptual object for Materialize:

```json
{
  "requestId": "<Power Apps input>",
  "actor": "<Power Apps input>",
  "maintenanceOccurrenceId": 123,
  "workOrderNo": "WO-000123"
}
```

## SQL result normalization

The connector may wrap the first result set under provider-specific properties.

Normalize it once into a Compose action called `SQL_Row`.

The only values downstream should be:

- SQL_Row.ReadState
- SQL_Row.ResultJson
- SQL_Row.ErrorCode
- SQL_Row.ErrorMessage

Do not couple Power Apps directly to raw SQL connector metadata.

## Response naming

Return exactly:

- readState
- resultJson
- errorCode
- errorMessage

Use lower camelCase at the Power Automate → Power Apps boundary.

## Command flow retry rule

For every command:
- requestId is mandatory from Power Apps;
- Power Apps reuses requestId on retry of the same user intent;
- flow must not generate a replacement requestId after SQL timeout unless caller deliberately issues a new command.

## Minimum PA-G01 runtime gate

Build and test first:

1. `CMMS_CORE_WorkQueue_List` — query path.
2. `CMMS_CORE_WorkOrder_Materialize` — command/idempotency path.

PASS criteria:
- query returns READY + valid JSON array;
- command returns READY + WorkOrder result;
- second call with same requestId returns same WorkOrder without duplicate row;
- invalid occurrence returns controlled CMMS-404/409, not a failed flow;
- SQL connector failure maps to CMMS-500.
