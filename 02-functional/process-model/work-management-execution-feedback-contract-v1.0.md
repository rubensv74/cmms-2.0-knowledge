# CMMS 2.0 — Execution Feedback & Data Integrity Contract v1.0

**Gate:** WM-G05  
**Date:** 2026-10-08  
**Status:** PASS_BENCHMARKED_CONTRACT

## 1. Purpose

Define the minimum authoritative execution data required for trustworthy maintenance history, trigger feedback, reliability analysis and KPI calculation.

## 2. WorkOrder lifecycle V1

WorkOrder business lifecycle is independent from ScheduleAssignment state.

V1 states:

- `PLANNING` — materialized work exists and is being prepared;
- `READY` — planning/readiness requirements satisfied;
- `RELEASED_TO_EXECUTION` — formally available to executor;
- `IN_PROGRESS` — physical work has started;
- `EXECUTION_COMPLETE` — executor reports physical work finished;
- `TECHNICALLY_CLOSED` — required feedback validated and accepted;
- `CANCELLED` — governed cancellation with reason.

Financial/cost completion is **not** a WorkOrder technical state in V1.

## 3. State rules

### PLANNING → READY
Requires configured readiness checks to pass or be explicitly waived.

### READY → RELEASED_TO_EXECUTION
Requires current ScheduleAssignment/dispatch when scheduling is required and operational permissive where applicable.

### RELEASED_TO_EXECUTION → IN_PROGRESS
First accepted execution start creates/updates authoritative actual start.

### IN_PROGRESS → EXECUTION_COMPLETE
Physical work has ended and executor has submitted required execution result.

### EXECUTION_COMPLETE → TECHNICALLY_CLOSED
Planner/supervisor validates required actuals, findings/follow-up and execution completeness.

## 4. ExecutionRecord

`ExecutionRecord` is the execution header for a WorkOrder.

Minimum fields:

- ExecutionRecordId;
- WorkOrderId;
- ActualStartAt;
- ActualFinishAt;
- ExecutionResultCode;
- PerformedBy / Crew reference;
- ExecutionSubmittedAt;
- SubmittedBy;
- ValidationStatusCode;
- ValidatedAt / ValidatedBy.

One WorkOrder has one current execution record in V1, with corrections handled through audit/revision records rather than destructive overwrite.

## 5. ActualStartAt / ActualFinishAt authority

`ActualStartAt` represents when physical maintenance work actually began.

`ActualFinishAt` represents when physical maintenance work actually ended.

They are not:

- ScheduledStart/ScheduledFinish;
- feedback entry time;
- technical close time;
- financial close time.

If entered after the fact, source entry timestamp and user are retained separately.

## 6. LaborActual

Structured record of labor actually consumed.

Minimum fields:

- LaborActualId;
- WorkOrderId / ExecutionRecordId;
- Person/Crew reference;
- Craft/Discipline reference;
- WorkDate;
- StartAt / FinishAt where captured;
- ActualHours;
- EntryAt / EnteredBy;
- SourceCode.

`sum(LaborActual.ActualHours)` is labor effort; it is not automatically the same as elapsed execution duration.

## 7. MaterialActual / ToolActual / ServiceActual

Separate structured actuals preserve plan-vs-actual comparison.

Minimum concepts:

- item/tool/service reference or governed free-form fallback;
- quantity/hours;
- unit;
- transaction timestamp;
- enteredBy/source;
- planned-requirement reference when applicable.

## 8. ExecutionResult

V1 result codes should distinguish at least:

- `COMPLETED_AS_PLANNED`;
- `COMPLETED_WITH_DEVIATION`;
- `PARTIALLY_COMPLETED`;
- `NOT_COMPLETED`.

Reason/notes are required for deviation, partial or not-completed results.

## 9. Checklist / operation feedback

JobPlanOperations may expose required execution responses without becoming independent WorkOrders.

Structured response types may include:

- completed/not completed;
- yes/no;
- numeric value + UOM;
- measurement/meter reading;
- qualitative finding;
- text/date;
- repair needed/nonconformity.

Mandatory responses can block EXECUTION_COMPLETE or TECHNICALLY_CLOSED according to rule severity.

## 10. Measurement feedback

A measurement captured during execution may create/link a `MeasurementReading` in Triggering/Condition Monitoring when it maps to a governed MeasurementPoint.

Execution does not own a second measurement master.

## 11. ExecutionFinding

A finding is a structured observation discovered during work.

Minimum fields:

- ExecutionFindingId;
- WorkOrderId;
- JobPlanOperationId/checklist reference when relevant;
- AssetId;
- FindingTypeCode;
- Description;
- Severity/Priority where applicable;
- FoundAt;
- FoundBy;
- RequiresFollowUp;
- StatusCode.

## 12. Finding → corrective work

V1 default:

`ExecutionFinding 0..N → FollowUpWorkOrderLink → WorkOrder(type=CORRECTIVE)`.

A preventive WorkOrder must not silently expand scope to absorb a newly discovered repair.

Multiple findings may be deliberately grouped into one corrective WorkOrder only by an explicit planner action; all source finding links are preserved.

## 13. WorkOrderClosure

`WorkOrderClosure` records the technical-close decision.

Minimum fields:

- WorkOrderClosureId;
- WorkOrderId;
- TechnicalClosedAt;
- ClosedBy;
- ClosureResultCode;
- ValidationNotes;
- DataQualityStatusCode;
- OpenFollowUpCount at closure;
- Exception/Waiver reference where applicable.

## 14. Technical-close validations

Configurable validations should cover:

- ActualStartAt and ActualFinishAt valid and ordered;
- required checklist/operation responses complete;
- actual labor/resources present when required;
- mandatory measurements captured;
- unresolved repair-needed findings linked to follow-up work or explicitly waived;
- execution result present;
- required evidence/attachments present;
- no impossible timestamp sequence.

## 15. Correction policy

Execution history is auditable.

After TECHNICALLY_CLOSED:

- corrections require reason;
- original value/audit event is retained;
- correctedBy/correctedAt are stored;
- KPI recalculation can identify that source data was corrected.

No silent overwrite of authoritative execution timestamps is permitted.

## 16. FeedbackCapturedAt

`FeedbackCapturedAt` is distinct from ActualFinishAt.

This allows data-quality metrics such as:

`FeedbackLag = FeedbackCapturedAt - ActualFinishAt`.

Late data entry remains visible rather than falsifying execution time.

## 17. Trigger feedback

Only accepted/technically valid completion feeds `MaintenanceTriggerState`.

For LAST_COMPLETION recurrence:

`TriggerState.lastCompletionAt = accepted ActualFinishAt`

not TechnicalClosedAt and not data-entry time.

## 18. KPI source semantics

V1 source rules:

- planned duration → PlanningPackage / effective JobPlan baseline;
- actual elapsed duration → ActualStartAt to ActualFinishAt;
- actual labor effort → sum LaborActual.ActualHours;
- schedule deviation → ScheduledStart vs actual start/finish as defined by KPI;
- due deviation → DueAt vs ActualFinishAt or start depending KPI definition;
- feedback timeliness → FeedbackCapturedAt - ActualFinishAt.

**MTBF/MTTR are not derived universally from WorkOrder open/close timestamps.** They require valid failure-event semantics and will be contracted in Failure Reporting/RCA.

## 19. Data-quality statuses

V1:

- `COMPLETE`;
- `COMPLETE_WITH_WARNINGS`;
- `INCOMPLETE`;
- `CORRECTED`.

Technical close may be blocked for INCOMPLETE when mandatory rules apply.

## 20. WM-G05 result

`WM-G05 = PASS_BENCHMARKED_CONTRACT`.

The model now has sufficient execution semantics to re-evaluate DM-G02.

Costs/contracts remain a separate later domain and do not prevent the technical core from being modeled.