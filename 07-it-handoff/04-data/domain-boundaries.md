# CMMS 2.0 — Domain Boundaries v0.1

**Date:** 2026-10-08  
**Status:** BASELINE / TO VALIDATE BY DOMAIN GATES

## Purpose

Define which CMMS domain owns each business concept before physical SQL design, APIs, Power Automate flows or Power Apps screens are created.

## Domain map

| Domain | Owns | Does not own |
|---|---|---|
| Asset & Context | Asset identity in CMMS, Equipment Type reference, asset relationships, operational context, technical profile, criticality reference | RCM decisions, maintenance plans, work orders |
| Reliability Engineering | FMEA/RCM definitions, revisions, functions, failures, failure modes, consequence/risk assessments, RCM decisions, maintenance recommendations | Executable work orders, scheduling |
| Maintenance Engineering | Corporate standards, project-adopted maintenance definitions, maintenance activities, Job Plans, procedures/checklists, resource/tool/material requirements, published project maintenance plan versions | Runtime due evaluation and WO execution |
| Triggering & Condition Monitoring | Trigger policies/rules, measurement points/readings used by CMMS, forecast occurrences, due evaluation, due events | Definition of why an activity exists; execution of the WO |
| Work Management | Work Orders, execution package resolution, assignment/planning state, operations permissive reference, closure | Reliability analysis and corporate standard governance |
| Execution & Feedback | Execution actuals, results, findings, actual resources/duration, technical feedback, plan-vs-actual source data | Maintenance master definitions |
| Governance & Provenance | Source references, approvals, revision lineage, change reason, immutable publication evidence | Domain-specific business meaning |

## Ownership decisions

### Asset
Canonical owner: **Asset & Context**. Other domains reference Asset identity; they do not clone it.

### FailureMode
Canonical owner: **Reliability Engineering**. Execution may report a suspected/observed failure mode, but cannot mutate the governed FMEA definition automatically.

### MaintenanceRecommendation
Canonical owner: **Reliability Engineering**. It represents an engineering decision before an executable MaintenanceActivity exists.

### MaintenanceActivity
Canonical owner: **Maintenance Engineering**. It is the maintained unit of work that can be planned, scheduled and closed. It may originate from RCM, a corporate standard, OEM/vendor guidance or governed engineering experience.

### JobPlan / ProcedureChecklist
Canonical owner: **Maintenance Engineering**. Their exact physical boundary remains OPEN until MSL-G02.

### MaintenanceTriggerPolicy
Canonical owner: **Triggering & Condition Monitoring**. Frequency is not a primitive attribute owned by MaintenanceActivity; time/meter/condition logic belongs to trigger policy/rules.

### MeasurementPoint / MeasurementReading
Canonical owner inside CMMS scope: **Triggering & Condition Monitoring**. The physical source may be external and must retain authority/provenance.

### MaintenanceDueEvent
Canonical owner: **Triggering & Condition Monitoring**. It records why maintenance became due. It is not the Work Order.

### WorkOrder
Canonical owner: **Work Management**. Preventive WOs may reference the Due Event that originated them. Corrective work may have other origins.

### ExecutionFinding
Canonical owner: **Execution & Feedback**. A finding may initiate corrective work or reliability review, but never silently modifies a published strategy.

## Cross-domain rule

No domain may persist a second authoritative copy of another domain's master entity merely for UI convenience. Read models may denormalize data, but the source domain remains explicit.

## Open boundaries

1. JobPlan ↔ ProcedureChecklist.
2. Whether ForecastOccurrence is persisted or derived.
3. Whether TriggerEvaluation is persisted for every evaluation or only material outcomes/audit.
4. Detailed Work Order lifecycle.
5. Permit-to-Work / LOTO ownership and integration boundary.
6. Costs, contracts, inventory and procurement domains remain uncontracted.

## Consequence

All future data contracts must declare owning domain, entity type, upstream references, downstream consumers, provenance/authority, lifecycle and open questions.