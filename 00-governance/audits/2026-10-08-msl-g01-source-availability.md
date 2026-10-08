# CMMS 2.0 — MSL-G01 Source Availability Audit

**Gate:** MSL-G01 — Source Normalization  
**Date:** 2026-10-08  
**Result:** BLOCKED_EVIDENCE

## Objective

Verify that a real maintenance source is available and can be normalized into Equipment Type, activities, frequency/trigger basis, Job Plan/procedure, resources, tools/materials and provenance without inventing content.

## Evidence found

Available project/library material confirms the intended concepts:

- historical CMMS functional documents describing Standard Task, Job Plan, revisions, PM/trigger concepts and ownership;
- AMEF/RCM transition material confirming Maintenance Recommendation → Maintenance Activity → Job Plan/Procedure → Maintenance Plan;
- mockups demonstrating Job Plan composition and the principle that reusable knowledge is separated from operational work;
- meeting notes stating that real historical plans were shown for equipment types such as gas detector, gas turbine and pressure safety valve.

## Evidence not found

The audit did not locate the original operational source artifact shown/referenced in the 2026-09-11 meeting containing the actual maintenance rows to normalize (equipment type, activity, frequency, operations/checklist, resources/tools and source identity).

## Why the gate cannot PASS

MSL-G01 explicitly requires normalization of a real source. A conceptual document, prototype or reconstructed example is not acceptable evidence because it would reintroduce assumptions into the corporate maintenance library.

## Allowed work while blocked

- keep the cross-domain entity catalog and logical model;
- define the normalization template/fields;
- preserve candidate entity names as PROPOSED;
- prepare extraction rules and validation checks.

## Prohibited work while blocked

- create a synthetic corporate maintenance standard and call it canonical;
- freeze StandardMaintenanceActivity / JobPlan / ProcedureChecklist SQL tables;
- assume frequency semantics from old mockups;
- build a production-looking Maintenance Standards Library screen with fictitious master data.

## Unblock condition

Provide or locate at least one real maintenance source used in practice or shown by the maintenance team, with enough evidence to extract:

1. source identity and version/date if available;
2. equipment type or applicable scope;
3. maintenance activity/operation;
4. frequency or trigger basis;
5. procedure/checklist or Job Plan reference/content;
6. labor/resources;
7. tools/materials where present;
8. notes/constraints;
9. provenance and unresolved ambiguities.

## Next action after evidence is available

Normalize one source end-to-end, record every mapping/ambiguity, then decide MSL-G01 PASS/FAIL. Only after PASS should MSL-G02 freeze the core Maintenance Engineering contracts.