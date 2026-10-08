# CMMS 2.0 — SP-G01 Static Review

**Date:** 2026-10-08  
**Result:** PASS_STATIC / RUNTIME_PENDING

## Inventory

SP-G01 defines 8 stored procedures:

1. `cmms.usp_WorkOrder_GetJson`
2. `cmms.usp_WorkQueue_ListJson`
3. `cmms.usp_WorkOrder_MaterializeFromOccurrence`
4. `cmms.usp_Planning_SetReadiness`
5. `cmms.usp_Schedule_Commit`
6. `cmms.usp_Execution_Start`
7. `cmms.usp_Execution_Complete`
8. `cmms.usp_WorkOrder_TechnicalClose`

Infrastructure:
- `cmms.CommandReceipt` for command idempotency.

## Static checks

- common four-column output contract present on success and error branches;
- no `CREATE ROLE`;
- no `CREATE USER`;
- no destructive DROP;
- command writes wrapped in transactions;
- state-changing reads use UPDLOCK/HOLDLOCK;
- requestId idempotency implemented;
- natural unique constraints remain database safety net;
- execution start requires RELEASED_TO_EXECUTION;
- technical close feeds LAST_COMPLETION from accepted ActualFinishAt;
- scheduling does not mutate Triggering DueAt.

## Runtime pending

The package still requires execution in `db-omm-dev`:

1. run `SP-G01-create-procedures.sql`;
2. run `SP-G01-validate-procedures.sql`;
3. capture full Messages output.

No Power Automate flow should be built against SP-G01 until runtime validation passes.
