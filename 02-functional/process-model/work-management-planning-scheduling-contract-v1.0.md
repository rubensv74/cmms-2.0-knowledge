# CMMS 2.0 — Planning & Scheduling Contract v1.0

**Gate:** WM-G03  
**Date:** 2026-10-08  
**Status:** PASS_BENCHMARKED_CONTRACT

## 1. Contract basis

This contract is based on:

- confirmed CMMS meeting principles;
- real TouatGaz Job Plan/resource evidence;
- commercial benchmark of SAP, IBM Maximo and HxGN EAM.

It is a CMMS 2.0 target-product contract, not a reconstruction of one project's legacy workflow.

## 2. End-to-end boundary

`MaintenanceOccurrence → WorkOrder → PlanningPackage → Readiness → ScheduleAssignment → Dispatch/Release to Execution → Execution`.

Triggering owns `ReleaseAt` and `DueAt`.

Planning/Scheduling must never silently rewrite those values.

## 3. PlanningPackage

One active PlanningPackage exists per WorkOrder planning revision.

It resolves:

- effective ExecutionPackage;
- planned duration;
- labor/craft requirements;
- tools/material requirements;
- operational/shutdown requirements;
- constraints;
- readiness state;
- planner notes/assumptions.

## 4. WorkConstraint

A WorkConstraint represents a condition that blocks or restricts execution.

V1 categories:

- `MATERIAL`;
- `TOOL`;
- `LABOR`;
- `DOCUMENT`;
- `OPERATIONS`;
- `PERMIT`;
- `ACCESS`;
- `OTHER`.

Minimum fields:

- WorkConstraintId;
- WorkOrderId / PlanningPackageId;
- CategoryCode;
- StatusCode (`OPEN`, `RESOLVED`, `WAIVED`);
- OwnerReference;
- RequiredBy;
- ResolvedAt;
- ResolutionNote;
- WaiverReason when applicable.

## 5. ReadinessAssessment

Readiness answers: **is the work sufficiently prepared to be scheduled/released?**

V1 result:

- `NOT_READY`;
- `READY_WITH_WARNINGS`;
- `READY`.

Readiness is a planning fact, not a maintenance-need approval.

## 6. OperationalCalendar and ShiftCalendar

Scheduling availability is derived from calendars.

`OperationalCalendar` defines working/non-working periods for a scheduling scope.

`ShiftCalendar` defines shift windows where required.

CMMS does not need to reproduce an HR system; it needs enough availability data to schedule maintenance.

## 7. ResourcePool / Crew

V1 distinguishes:

- `ResourcePool` — schedulable pool such as discipline/work center/team;
- `Crew` — concrete team when crew scheduling is used;
- `Person` reference — optional direct assignment.

Planned craft/discipline requirement from JobPlan remains separate from the assigned resource.

## 8. CapacityBucket

Capacity is represented as time-phased availability.

Logical grain:

`ResourcePool/Crew + Date/Shift → AvailableHours / CommittedHours`.

Minimum fields:

- CapacityBucketId;
- ResourceScopeType;
- ResourceScopeId;
- CalendarDate;
- ShiftCode when applicable;
- AvailableHours;
- CommittedHours;
- RemainingHours derived;
- CapacitySourceCode.

V1 does not implement optimization; it exposes over-allocation and remaining capacity.

## 9. ScheduleAssignment

`ScheduleAssignment` is the commitment of a WorkOrder to a scheduled execution window.

Minimum fields:

- ScheduleAssignmentId;
- WorkOrderId;
- ScheduledStart;
- ScheduledFinish;
- AssignmentTargetType (`RESOURCE_POOL`, `CREW`, `PERSON`);
- AssignmentTargetId;
- ShiftCode optional;
- StatusCode;
- ScheduledBy / ScheduledAt;
- ScheduleRevisionNo.

V1 default scheduling grain is **WorkOrder**.

Activity/operation-level scheduling is deferred unless later evidence requires it.

## 10. Schedule status

V1 schedule states:

- `UNSCHEDULED`;
- `TENTATIVE`;
- `COMMITTED`;
- `DISPATCHED`;
- `CANCELLED`.

`DISPATCHED` means the scheduled work has been formally released/assigned for execution.

WorkOrder lifecycle remains separate from schedule status.

## 11. Rescheduling

Every committed schedule change creates a `ScheduleRevision` audit record.

Required:

- previous start/finish;
- new start/finish;
- previous/new assignment target when changed;
- reason code;
- requestedBy / changedBy;
- changedAt;
- impact classification (`BEFORE_DUE`, `AFTER_DUE`, `OVERDUE_ALREADY`).

Changing schedule dates does not alter Triggering `DueAt`.

## 12. Dispatch

Dispatch is a short-term operational action after scheduling.

V1 supports:

- dispatch to Crew;
- dispatch to Person;
- dispatch at WorkOrder level.

Emergency/unplanned dispatch may bypass normal medium-term scheduling but must preserve who/when/why.

## 13. Grouping — V1 decision

CMMS V1 will **not automatically merge multiple MaintenanceOccurrences into one WorkOrder**.

Reason:

- grouping rules are organization-specific;
- automatic grouping can destroy source traceability and recurrence identity;
- commercial products commonly schedule/assign work records rather than requiring upstream occurrence merging.

V1 may provide a manual `WorkBundle`/grouping view later, but each MaintenanceOccurrence retains its own traceable WorkOrder unless a future governed grouping contract is approved.

## 14. Capacity conflict behavior

The system must detect at least:

- assignment outside available calendar/shift;
- over-allocation of capacity;
- assigned resource not matching required discipline/qualification when qualification data exists;
- schedule outside allowed operational window;
- schedule after DueAt.

V1 behavior is warning/block according to configured rule severity; optimization is not required.

## 15. Organizational routing

No fixed Supervisor step is mandatory.

Roles are responsibilities:

- Planner prepares;
- Scheduler schedules/capacity-balances;
- Dispatcher/Supervisor may dispatch depending on project configuration;
- Executor executes.

A project may combine these roles in the same person.

## 16. Invariants

1. `DueAt` comes from Triggering and is immutable by scheduling.
2. One WorkOrder can have multiple ScheduleRevisions but at most one current committed ScheduleAssignment.
3. A schedule assignment never changes the JobPlanRevision used by the WorkOrder.
4. Rescheduling after DueAt remains visible as a deviation.
5. Planned requirement and actual assignment are distinct.
6. Capacity is calendar/time dependent.
7. Resource assignment may target pool, crew or person.
8. Historical assignments remain auditable.

## 17. WM-G03 result

`WM-G03 = PASS_BENCHMARKED_CONTRACT`.

The contract is sufficiently stable for the logical data model. Organization-specific policies remain configuration, not schema blockers.

### Next gate

`WM-G05 — Execution Feedback & Data Integrity`.