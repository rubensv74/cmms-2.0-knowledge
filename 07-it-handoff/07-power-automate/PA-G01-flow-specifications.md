# CMMS 2.0 — PA-G01 Flow Specifications

## CMMS_CORE_WorkOrder_Get

Stored procedure:
`cmms.usp_WorkOrder_GetJson`

Trigger inputs:
- workOrderId: number

RequestJson:
```json
{"workOrderId":123}
```

Expected ResultJson:
single WorkOrder detail JSON object.

---

## CMMS_CORE_WorkQueue_List

Stored procedure:
`cmms.usp_WorkQueue_ListJson`

Trigger inputs:
- statusCode: text optional
- assetKey: text optional
- top: number optional

RequestJson example:
```json
{"statusCode":"READY","assetKey":"103-PA-004A","top":100}
```

Expected ResultJson:
JSON array.

---

## CMMS_CORE_WorkOrder_Materialize

Stored procedure:
`cmms.usp_WorkOrder_MaterializeFromOccurrence`

Trigger inputs:
- requestId: text
- actor: text
- maintenanceOccurrenceId: number
- workOrderNo: text

RequestJson:
```json
{
  "requestId":"<guid>",
  "actor":"user@company.com",
  "maintenanceOccurrenceId":123,
  "workOrderNo":"WO-000123"
}
```

---

## CMMS_CORE_Planning_SetReadiness

Stored procedure:
`cmms.usp_Planning_SetReadiness`

Trigger inputs:
- requestId
- actor
- workOrderId
- readinessStatusCode
- plannerNotes optional

Allowed readiness:
- NOT_READY
- READY_WITH_WARNINGS
- READY

---

## CMMS_CORE_Schedule_Commit

Stored procedure:
`cmms.usp_Schedule_Commit`

Trigger inputs:
- requestId
- actor
- workOrderId
- scheduledStart
- scheduledFinish
- assignmentTargetType
- resourcePoolId optional
- crewId optional
- personReference optional
- shiftCode optional
- reasonCode optional

Assignment target:
- RESOURCE_POOL
- CREW
- PERSON

Dates must be ISO 8601 strings.

---

## CMMS_CORE_Execution_Start

Stored procedure:
`cmms.usp_Execution_Start`

Trigger inputs:
- requestId
- actor
- workOrderId
- actualStartAt optional

Business requirement:
WorkOrder must already be `RELEASED_TO_EXECUTION`.

---

## CMMS_CORE_Execution_Complete

Stored procedure:
`cmms.usp_Execution_Complete`

Trigger inputs:
- requestId
- actor
- workOrderId
- actualFinishAt optional
- executionResultCode

Allowed result:
- COMPLETED_AS_PLANNED
- COMPLETED_WITH_DEVIATION
- PARTIALLY_COMPLETED
- NOT_COMPLETED

---

## CMMS_CORE_WorkOrder_TechnicalClose

Stored procedure:
`cmms.usp_WorkOrder_TechnicalClose`

Trigger inputs:
- requestId
- actor
- workOrderId
- validationNotes optional
- dataQualityStatusCode optional

Allowed quality:
- COMPLETE
- COMPLETE_WITH_WARNINGS
- CORRECTED

The SQL procedure validates unresolved follow-up findings and updates TriggerState when applicable.
