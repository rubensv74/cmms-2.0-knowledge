# CMMS 2.0 — Maintenance Standards Core Contract v0.1

**Gate:** MSL-G02  
**Date:** 2026-10-08  
**Status:** CONTRACT BASELINE / PASS_WITH_DEFERRED_TRIGGER_VALUES

## 1. Purpose

Define the minimum canonical Maintenance Engineering contract supported by real TouatGaz maintenance sources.

## 2. Canonical chain

`SourceReference → EquipmentTypeStandard → StandardPlanVersion → StandardMaintenanceActivity → JobPlanRevision`

Project adoption:

`StandardPlanVersion → ProjectStandardAdoption → ProjectMaintenancePlanVersion → MaintenanceActivity → MaintenanceTriggerPolicy`

## 3. Core entities

### MaintenanceStandardLibrary
Corporate root for governed reusable maintenance standards.

### EquipmentTypeStandard
Associates a governed standard family with an Equipment Type/scope. Equipment Type proposes applicability; project/asset applicability remains governed.

### StandardPlanVersion
Immutable published version of a corporate standard plan.

Minimum logical fields:
- StandardPlanVersionId;
- StandardId / EquipmentType scope;
- RevisionCode;
- StatusCode;
- ValidFrom / ValidTo;
- SourceReferenceId;
- PublishedAt / PublishedBy.

### StandardMaintenanceActivity
A schedulable maintenance definition inside a StandardPlanVersion.

It defines **what maintenance exists**, not the detailed step sequence and not the runtime due state.

Minimum logical fields:
- StandardMaintenanceActivityId;
- StandardPlanVersionId;
- ActivityCode;
- Title / Description;
- MaintenanceStrategyCode;
- DisciplineCode when applicable;
- DefaultJobPlanRevisionId;
- source/provenance references;
- applicability metadata.

### JobPlan
Stable identity of reusable execution knowledge.

### JobPlanRevision
Immutable published revision of a JobPlan.

Observed source fields support:
- code / revision identity;
- title / description;
- planned total duration;
- asset/equipment scope metadata when present;
- status/provenance.

### JobPlanOperation
Ordered executable/instruction step belonging to JobPlanRevision.

Minimum logical fields:
- JobPlanOperationId;
- JobPlanRevisionId;
- Sequence;
- Title/short description;
- Instruction/detail;
- planned step duration when provided;
- measurement point/reference when provided;
- craft/discipline when provided.

### ResourceRequirement / ToolRequirement / MaterialRequirement
Structured requirements associated with JobPlanRevision and optionally a specific JobPlanOperation.

## 4. ProcedureChecklist boundary — resolved for V1

Real source evidence places detailed ordered operations directly inside the Job Plan.

Therefore V1 adopts:

`JobPlanRevision 1:N JobPlanOperation`

`ProcedureChecklist` is **optional**, not mandatory. It is used when a separate controlled procedure/checksheet exists and must be referenced as an independent governed artifact.

This prevents creating a second mandatory hierarchy duplicating Job Plan operations.

## 5. Activity vs JobPlan

`MaintenanceActivity` is the schedulable/closable maintenance unit.

`JobPlanRevision` is reusable execution knowledge.

A MaintenanceActivity may reference one published JobPlanRevision. Future multi-JobPlan composition remains out of V1 unless evidence requires it.

V1 cardinality:

`MaintenanceActivity 0..1 → JobPlanRevision`

A JobPlanRevision may be reused by many MaintenanceActivities.

## 6. Frequency / trigger boundary

Source evidence confirms frequency/interval is held in the PM association layer, separate from the detailed Job Plan workbook.

Therefore:

`MaintenanceActivity → MaintenanceTriggerPolicy → TriggerRule`

and not:

`JobPlan.Frequency`

nor a primitive `MaintenanceActivity.Frequency` field.

Legacy source frequency is preserved as provenance/raw source during ingestion until TRG-G01 normalizes trigger semantics.

## 7. Corporate → project adoption

Project adoption creates a governed snapshot/reference of a published StandardPlanVersion.

Project may:
- disable an inherited activity;
- change trigger/frequency;
- replace/override Job Plan reference;
- add a project-specific activity;
- add justification/provenance.

It may not mutate the corporate StandardPlanVersion.

## 8. Provenance

Every imported standard/activity/job plan must preserve at minimum:

- source document number;
- source revision/date when available;
- source unit/project;
- appendix/file name;
- source equipment/tag or equipment class;
- source Job Plan / PM identifier;
- extraction/normalization date;
- unresolved ambiguity flag/notes.

## 9. Deferred items

- exact trigger values from legacy binary `.xls` remain source-level until a reliable ingestion path extracts them;
- project override physical storage design;
- MaterialRequirement population rules where legacy source is blank;
- dedicated external Procedure/Checklist document contract beyond optional reference.

## 10. MSL-G02 gate

PASS conditions met at logical-contract level:

- standard/version/activity boundaries defined;
- JobPlan and JobPlanRevision responsibilities defined;
- JobPlanOperation introduced from real source;
- resources/tools/material structure defined;
- JobPlan ↔ Procedure boundary resolved for V1;
- Activity ↔ JobPlan reuse cardinality defined for V1;
- frequency explicitly handed to Triggering;
- corporate/project immutability preserved.

`MSL-G02 = PASS_WITH_DEFERRED_TRIGGER_VALUES`.

### Next real gate

`TRG-G01 — Triggering Domain Contract`.

Triggering can now be designed against a stable MaintenanceActivity/JobPlan boundary.