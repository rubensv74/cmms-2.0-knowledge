# CMMS 2.0 — Planning & Scheduling Contract v0.1

**Gate:** WM-G03  
**Date:** 2026-10-08  
**Status:** PARTIAL_CONTRACT / BLOCKED_EVIDENCE

## 1. Purpose

Define the boundary between planning, readiness and scheduling after a WorkOrder has been materialized from a MaintenanceOccurrence.

## 2. Evidence status

Two kinds of evidence exist:

1. **Confirmed meeting evidence**
   - planner identifies upcoming work;
   - maintenance responsible may validate or propose another date;
   - supervisor layer is optional;
   - assignment may go to technician/team/shift depending on project organization;
   - windows, available time and organizational structure matter;
   - preventive work already approved does not require WorkCandidate as a universal step;
   - delays/non-execution require justification.

2. **Historical conceptual model**
   - Planning Package, Constraint, Readiness Assessment;
   - Crew, Capacity, Operational Calendar, Operational Window;
   - Schedule Assignment, Shutdown Schedule;
   - Planner prepares, Scheduler allocates capacity/time, Supervisor executes.

The conceptual model is useful but cannot by itself promote AS-IS/TO-BE behavior to canonical Product Truth.

## 3. Boundary after Triggering

Triggering owns:

- ReleaseAt;
- DueAt;
- MaintenanceOccurrence;
- origin trigger evidence.

Work Management owns:

- preparation/readiness;
- scheduling;
- assignment;
- replanning;
- execution.

Therefore:

`ReleaseAt != ScheduledStart`

`DueAt != ScheduledStart`

`MaintenanceOccurrence != ScheduleAssignment`.

## 4. V1 planning objects — candidate contract

### PlanningPackage
Resolved preparation state for one WorkOrder. It references the ExecutionPackage and planning decisions without duplicating master content.

### WorkConstraint
A blocking or limiting condition affecting readiness or execution.

Candidate categories:

- MATERIAL;
- TOOL;
- LABOR;
- DOCUMENT;
- OPERATIONS;
- PERMIT;
- ACCESS;
- OTHER.

Categories are provisional until operational walkthrough validates them.

### ReadinessAssessment
Assessment that indicates whether a WorkOrder is ready to enter scheduling/execution.

Readiness is not equivalent to approval of the maintenance need; the need was already governed upstream.

## 5. V1 scheduling objects — candidate contract

### OperationalCalendar
Defines working/non-working periods relevant to scheduling.

### OperationalWindow
Represents a time window in which execution is operationally allowed or preferred.

### Crew
Schedulable team/unit of capacity when the organization uses crews.

### CrewCapacity
Available capacity for a Crew/time period.

### ScheduleAssignment
Temporal allocation of a WorkOrder to a date/time window and optional crew/team/person/shift.

### ScheduleRevision
Audit/history of a rescheduling decision.

## 6. Assignment model

The product must not hardcode a mandatory hierarchy:

`Manager → Supervisor → Technician`

or any other fixed chain.

V1 logical requirement:

`ScheduleAssignment` must support an assignment target abstraction capable of representing at least:

- PERSON;
- TEAM/CREW;
- SHIFT/ORGANIZATIONAL UNIT.

Exact physical modeling remains open until operational evidence confirms the minimum useful target model.

## 7. Planning horizon

Triggering already determines ReleaseAt. Therefore WM-G03 does not create a second PM horizon concept.

Planning may expose queues/windows such as:

- released work;
- due soon;
- overdue;
- unscheduled;
- ready/not ready.

The exact planning horizon configuration remains open because the current process demo has not yet been observed.

## 8. Grouping

Grouping multiple maintenance needs into one WorkOrder remains **OPEN**.

Potential grouping dimensions include:

- same Asset;
- same location/system;
- same operational window;
- same discipline/crew;
- same shutdown;
- compatible Job Plan/readiness requirements.

No grouping algorithm is approved in WM-G03 v0.1.

## 9. Replanning / rescheduling

Any change to committed schedule must preserve:

- previous ScheduledStart/ScheduledFinish;
- new values;
- reason code;
- changedBy / changedAt;
- impact on DueAt/overdue status;
- whether Operations or another actor requested the change.

Important:

Changing `ScheduledStart` does **not** rewrite the Triggering `DueAt` unless a governed maintenance-plan/trigger revision explicitly changes the maintenance requirement.

## 10. Capacity and shifts

Capacity is a Scheduling concern, not a Triggering concern.

Logical candidates:

- CrewCapacity;
- ShiftCalendar;
- individual availability if project needs person-level scheduling.

However, no capacity algorithm, units or shift model can be frozen before WM-G03 obtains real operational evidence.

## 11. Minimum scheduling timestamps

Candidate logical timestamps:

- PlanningStartedAt;
- ReadyAt;
- ScheduledStart;
- ScheduledFinish;
- ReleasedToExecutionAt;
- RescheduledAt.

Names are provisional until the operational lifecycle walkthrough is validated.

## 12. Human/system responsibilities

### Planner
- prepare work;
- resolve/coordinate constraints;
- establish readiness;
- maintain planning information.

### Scheduler
- allocate time/capacity;
- create and revise schedule assignments;
- coordinate operational windows.

### Supervisor / responsible layer
- may validate/release/dispatch according to project organization;
- is not mandatory as a universal workflow step.

### System
- surface due/release facts;
- show readiness/constraints;
- detect schedule conflicts when rules exist;
- preserve rescheduling history.

## 13. What is sufficiently closed

- Planning and Scheduling are distinct responsibilities.
- Triggering dates are inputs, not schedule dates.
- assignment hierarchy must be configurable.
- reprogramming requires reason/history.
- readiness/constraints are separate from the ExecutionPackage master references.

## 14. Blocking evidence still required

WM-G03 cannot PASS until the project obtains the real operational walkthrough already requested in earlier meetings:

1. open the current Los Barrios application/process;
2. follow one real preventive item from upcoming/due state to scheduling;
3. observe who changes dates and under what authority;
4. observe grouping behavior;
5. observe assignment to person/team/shift;
6. observe capacity/shift handling;
7. observe exceptions/replanning;
8. record actual states and timestamps.

## 15. Gate result

`WM-G03 = BLOCKED_EVIDENCE`.

The logical boundary is documented, but Planning/Scheduling cannot be promoted to final contract from conceptual documents alone.

### Next real gate

The next gate is not another modeling exercise. It is **WM-G03 Operational Evidence Walkthrough**.

Once that evidence exists, WM-G03 can be closed and WM-G05 should follow before DM-G02 is re-evaluated.