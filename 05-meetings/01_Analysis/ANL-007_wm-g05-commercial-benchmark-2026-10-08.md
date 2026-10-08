# CMMS 2.0 — WM-G05 Commercial Benchmark

**Date:** 2026-10-08  
**Scope:** execution feedback, actuals, findings and technical closure.

## SAP pattern

SAP maintenance confirmations record who performed work, work center, start/finish, progress, materials, internal services and measurement/counter readings. Technical completion data can retain damage, cause, findings, activities performed, breakdown and availability information.

## IBM Maximo pattern

Maximo Work Orders separately record actual labor, materials, services and tools. Work assignment states distinguish assigned/started/interrupted/completed. Work Order `COMP` means physical work is finished; `CLOSE` finalizes the record/history. Supervisory close can review reported time/resources and create follow-up work.

## HxGN EAM pattern

HxGN work-order checklists can capture qualitative findings, quantitative values, meter readings, inspection results and repair-needed states. Checklist results can create follow-up Work Orders/deferred work. Required/regulatory checklist items can block completion/close until resolved or linked to governed follow-up work.

## Common product pattern

1. Physical execution and administrative/technical close are not the same event.
2. Planned resources and actual consumption are separate.
3. Execution records need authoritative start/finish and performer information.
4. Measurements/findings are execution evidence, not free-text only.
5. Findings can generate traceable follow-up/corrective work.
6. Closure should validate required execution data.
7. Historical Work Orders retain the versions/context used when executed.

## CMMS 2.0 implication

CMMS should model execution actuals as structured child records and treat technical closure as a validation gate. Financial completion may occur later and is not allowed to corrupt maintenance timestamps.