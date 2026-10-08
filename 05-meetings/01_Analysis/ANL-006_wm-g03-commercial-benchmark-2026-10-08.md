# CMMS 2.0 — WM-G03 Commercial Benchmark

**Date:** 2026-10-08  
**Purpose:** replace unavailable project-specific operational walkthrough with defensible commercial-product evidence.

## Products reviewed

- SAP S/4HANA Maintenance Management / Resource Scheduling;
- IBM Maximo Manage / Scheduler / Graphical Assignment;
- HxGN EAM Work Management / WO Scheduling / Daily Scheduling.

## Common operational pattern

Across the three products, the recurring pattern is:

`Maintenance demand / Work Order → planning/resource requirements → scheduling against calendars/capacity → assignment/dispatch → execution`.

### SAP

- maintenance orders move through planning/preparation/scheduling/execution phases;
- capacity requirements are planned against work centers/persons;
- planners compare requested work with available work-center capacity;
- resource scheduling allows dispatching orders/operations to the right work center and time;
- work-center teams support assignment to suitable people;
- available capacity can be defined by shifts and calendar intervals.

### IBM Maximo

- graphical scheduling manages upcoming work and resource requirements;
- labor and crews are scheduled/assigned based on availability, skills and shifts;
- long-term resource leveling/capacity planning is distinct from short-term assignment/dispatch;
- work can be reassigned when labor/crews become unavailable;
- work lists may be rolling and can cover defined date windows.

### HxGN EAM

- WO Scheduling explicitly handles unscheduled/backlogged work, labor availability/utilization and rescheduling;
- scheduling may be by employee or trade/department;
- daily scheduling can filter qualified employees by department, trade, shift and qualification;
- labor can be scheduled by employee or crew with scheduled date/hours/start/end/shift;
- activity schedules can be frozen/unfrozen;
- constraint optimization can assign qualified crews within shift and operational constraints.

## Product-design conclusions for CMMS 2.0

1. Separate `Planning` from `Scheduling` and `Dispatch/Assignment`.
2. Treat capacity as time-phased availability, not a static headcount.
3. Support both individual and crew/team assignment.
4. Use calendars/shifts to derive availability.
5. Keep required craft/skill from JobPlan/WorkOrder requirements separate from the actual assigned person/crew.
6. Preserve rescheduling history; changing a schedule does not rewrite the original DueAt.
7. Support a short-term dispatch layer distinct from medium/long-term scheduling.
8. Avoid mandatory supervisor hierarchy: commercial systems expose role/team/resource concepts rather than one fixed approval chain.

## What CMMS 2.0 will not copy in V1

- GIS routing/spatial optimization;
- automatic optimization engine;
- detailed workforce HR model;
- enterprise production-order integration;
- complex activity-level scheduling unless the use case requires it;
- automatic grouping algorithms.

## Evidence status

The benchmark is considered sufficient for a **product design contract** because the objective is to define CMMS 2.0 behavior rather than reproduce a specific legacy application's workflow.

Project-specific organizational routing remains configurable.