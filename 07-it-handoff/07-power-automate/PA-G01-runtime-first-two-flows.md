# CMMS 2.0 — PA-G01 Runtime Build — First Two Flows

## Flow 1 — CMMS_CORE_WorkQueue_List

### Trigger
Power Apps (V2)

Inputs:
- statusCode — Text
- assetKey — Text
- top — Number

### Compose — RequestObject
Use an object with:
```json
{
  "statusCode": "<statusCode>",
  "assetKey": "<assetKey>",
  "top": 100
}
```

### Compose — RequestJson
Expression:
```text
string(outputs('RequestObject'))
```

### SQL
Action:
Execute stored procedure (V2)

Procedure:
`cmms.usp_WorkQueue_ListJson`

Parameter:
`RequestJson = outputs('RequestJson')`

### Normalize
Read first SQL result row into a single Compose named `SQL_Row`.

Expected columns:
- ReadState
- ResultJson
- ErrorCode
- ErrorMessage

### Respond to Power Apps
Outputs:
- readState = SQL_Row.ReadState
- resultJson = SQL_Row.ResultJson
- errorCode = SQL_Row.ErrorCode
- errorMessage = SQL_Row.ErrorMessage

### Test
With no WorkOrders, expected:
- readState = READY
- resultJson = []

---

## Flow 2 — CMMS_CORE_WorkOrder_Materialize

### Trigger
Power Apps (V2)

Inputs:
- requestId — Text
- actor — Text
- maintenanceOccurrenceId — Number
- workOrderNo — Text

### RequestObject
```json
{
  "requestId": "<requestId>",
  "actor": "<actor>",
  "maintenanceOccurrenceId": 123,
  "workOrderNo": "WO-000123"
}
```

### SQL
Execute:
`cmms.usp_WorkOrder_MaterializeFromOccurrence`

Parameter:
`RequestJson = outputs('RequestJson')`

### Response
Return the same four lower-camel fields:
- readState
- resultJson
- errorCode
- errorMessage

### Mandatory runtime tests

T01 — Valid materialization
- existing RELEASED MaintenanceOccurrence
- new requestId
- new workOrderNo
Expected READY.

T02 — Idempotent retry
- identical requestId
Expected same WorkOrder result; WorkOrder count unchanged.

T03 — Same occurrence / new requestId
Expected existing WorkOrder returned or controlled conflict according to SQL contract; never a second WorkOrder.

T04 — Unknown occurrence
Expected ERROR + CMMS-404.

T05 — Non-materializable occurrence
Use CANCELLED/SUPERSEDED/FULFILLED occurrence.
Expected ERROR + CMMS-409.

T06 — Connector failure
Temporarily point/test invalid connection only in a safe dev copy if practical.
Expected CMMS-500 from Catch path.

## Important

Do not build the other six flows until these two establish the final connector result-path expression used to extract the first row. That raw SQL connector response shape is the only remaining implementation-specific uncertainty in PA-G01.
