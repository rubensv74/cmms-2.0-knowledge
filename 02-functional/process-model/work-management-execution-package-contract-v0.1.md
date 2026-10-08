# CMMS 2.0 — Execution Package Contract v0.1

**Gate:** WM-G02  
**Date:** 2026-10-08  
**Status:** PASS_CONTRACT_WITH_EXTERNAL_PERMIT_BOUNDARY

## 1. Purpose

Define what a maintenance executor must be able to resolve from a WorkOrder without duplicating governed master data.

## 2. Evidence

Real TouatGaz source packages provide:

- detailed Job Plan revisions with ordered operations;
- planned labor/craft requirements;
- tools and material sections;
- Maintenance Manuals as real technical-document sources;
- asset/tag identity and PM/Job Plan associations.

This is sufficient to contract the execution package composition. The detailed Permit-to-Work / isolation / LOTO process remains a separate domain/integration boundary.

## 3. Execution Package is a resolved package, not a second master

`ExecutionPackage` is the resolved view/snapshot of information required to execute a specific WorkOrder.

It must not clone all Job Plan, Asset or document masters into a new uncontrolled hierarchy.

## 4. Package composition V1

A WorkOrder execution package resolves:

1. **Work context**
   - WorkOrder identity/type;
   - Asset;
   - MaintenanceOccurrence / origin when preventive;
   - MaintenanceActivity;
   - ReleaseAt / DueAt / priority context.

2. **Execution knowledge**
   - effective JobPlanRevision;
   - ordered JobPlanOperations;
   - optional governed ProcedureChecklist references.

3. **Planned requirements**
   - ResourceRequirements;
   - ToolRequirements;
   - MaterialRequirements where present.

4. **Technical documentation**
   - Asset EngineeringDocumentLinks / manuals / drawings;
   - task-specific technical references;
   - source/revision identity when required for reproducibility.

5. **WO-specific information**
   - attachments;
   - planner notes;
   - corrective recommendation/evidence when applicable.

6. **Operational constraints**
   - shutdown requirement;
   - Operations permissive status/reference when applicable;
   - Permit/Isolation/LOTO requirement references, without implementing their external lifecycle here.

## 5. Version/snapshot rule

Historical reproducibility requires the WorkOrder to retain the effective version references used for execution.

At minimum:

- ProjectMaintenancePlanVersionId;
- ProjectMaintenancePlanItemId;
- MaintenanceActivityId/version reference;
- JobPlanRevisionId;
- TriggerPolicyVersion / MaintenanceOccurrenceId when preventive.

Master content can be resolved by reference, but those effective revision IDs must not silently switch after execution starts.

## 6. Lock point

V1 functional rule:

- while the WO is still in planning/preparation, allowed governed references may be updated;
- when execution is formally started/released to execution according to the future WO lifecycle, the effective execution references are frozen for that execution instance;
- later master revisions do not rewrite historical WOs.

The exact WorkOrder status name that constitutes the lock point is deferred to the WorkOrder lifecycle contract.

## 7. Job Plan behavior

Real source evidence supports:

`JobPlan → JobPlanRevision → ordered JobPlanOperations`.

Operations are instructions/steps and do not become independent WorkOrders or MaintenanceActivities by default.

## 8. Resources, tools and materials

Requirements are planned values. Execution actuals are separate records.

`planned requirement != actual consumption/use`

This separation is mandatory for plan-vs-actual analysis.

## 9. Technical documents

Asset technical documents should be resolved from Asset/Engineering Context by reference when possible.

A WO-specific copy is only justified when:

- the artifact is unique to that work;
- a controlled immutable snapshot is legally/operationally required;
- the external source cannot guarantee historical retrieval.

## 10. Permissive / permit boundary

V1 distinguishes:

`requiresShutdown / operational release`

from:

`Permit to Work / isolation / LOTO`.

Work Management must be able to reference readiness/permissive requirements and their current outcome, but the full Permit-to-Work lifecycle is not invented inside WM-G02.

## 11. Readiness concept

ExecutionPackage may expose readiness facts such as:

- Job Plan available;
- required technical documents available;
- planned resources identified;
- tools/material requirements identified;
- operations permissive required/received;
- external permit requirement unresolved/resolved.

The final readiness algorithm and authorization policy belong to later Planning/Control-of-Work gates.

## 12. WM-G02 result

`WM-G02 = PASS_CONTRACT_WITH_EXTERNAL_PERMIT_BOUNDARY`.

### Remaining Work Management blockers

- WM-G03: planning/scheduling, grouping, capacity, shifts, assignment and replanning;
- WM-G05: execution timestamps, actuals, findings/corrective linkage, validation and closure lifecycle;
- WM-G04: costs/contracts remains separate and does not block the core Execution Package contract.