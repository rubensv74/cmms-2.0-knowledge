# CMMS 2.0 — Triggering & Condition Monitoring Domain Contract v0.1

**Gate:** TRG-G01  
**Date:** 2026-10-08  
**Status:** PASS_CONTRACT

## 1. Purpose

Define the logical contract that converts a governed maintenance plan item into forecast, release/due state and traceable work demand without putting recurrence logic inside JobPlan or WorkOrder.

## 2. Evidence

Real TouatGaz `06-Job Plan & PM` sources contain explicit asset/tag + Job Plan + frequency/unit/interval associations. Structured extraction confirms examples including `1 AN`, `3 AN`, `6 MO` and sequential Job Plan intervals. Maintenance manuals also distinguish predetermined intervals, condition-based maintenance and monitoring performed scheduled, on-demand or continuously.

## 3. Missing binding resolved — ProjectMaintenancePlanItem

A reusable MaintenanceActivity must not be duplicated merely because it applies to several assets. V1 therefore introduces a concrete project-plan binding:

`ProjectMaintenancePlanItem`

It represents: **this maintenance activity, for this asset/context, under this published project plan version**.

Minimum relations:

- ProjectMaintenancePlanVersion 1:N ProjectMaintenancePlanItem;
- ProjectMaintenancePlanItem N:1 Asset;
- ProjectMaintenancePlanItem N:1 MaintenanceActivity;
- ProjectMaintenancePlanItem 0..1 JobPlanRevision override; otherwise activity default applies;
- ProjectMaintenancePlanItem 1:N MaintenanceTriggerPolicy revisions.

## 4. Core Triggering entities

### MaintenanceTriggerPolicy
Versioned rule set defining when a ProjectMaintenancePlanItem becomes actionable.

### TriggerRule
Atomic rule inside a policy.

V1 rule types:

- `TIME`;
- `METER`;
- `CONDITION`.

`COMPOSITE` is represented by a policy containing multiple TriggerRules plus a combination operator, not as a fourth atomic rule type.

### MaintenanceTriggerState
Runtime state required to evaluate recurrence idempotently without rewriting the published policy.

Typical state:

- lastEvaluationAt;
- lastCompletionAt;
- lastDueAt;
- nextDueAt cache/derived value;
- meter baseline reading/value when relevant;
- current condition state;
- open occurrence reference.

### MeasurementPoint
Defines an observable counter/characteristic for an Asset.

V1 kinds:

- `COUNTER` — cumulative usage, e.g. operating hours;
- `GAUGE` — instantaneous numeric value, e.g. vibration or temperature;
- `CHARACTERISTIC` — discrete/qualitative value, reserved for later controlled use.

### MeasurementReading
Timestamped value/evidence for a MeasurementPoint. Source authority may be CMMS or external.

### ForecastOccurrence
Projected future occurrence. It is **derived/non-authoritative in V1** and may be cached for performance, but can always be regenerated from published policy + state.

### MaintenanceOccurrence
Persistent runtime maintenance call created when the release condition/horizon is reached. It is the bridge between Triggering and Work Management.

### MaintenanceDueEvent
Append-only audit event recording that an occurrence crossed its due/action boundary. It explains *why/when it became due* but is not the primary Work Management object.

## 5. Why MaintenanceOccurrence is needed

A Work Order can be released **before** its DueAt. Therefore WorkOrder cannot depend only on an event that occurs at DueAt.

Canonical runtime flow:

`ForecastOccurrence → Release boundary → MaintenanceOccurrence → WorkOrder`

and at the due boundary:

`MaintenanceOccurrence → MaintenanceDueEvent`

This corrects the earlier oversimplification `DueEvent → WorkOrder` while preserving DueEvent as audit evidence.

## 6. TIME rule

Logical fields:

- intervalValue;
- intervalUnitCode (`DAY`, `WEEK`, `MONTH`, `YEAR`, etc.);
- anchor/reference date;
- recurrenceBasisCode.

Real-source mapping includes `MO` → MONTH and `AN` → YEAR where the source frequency unit explicitly provides those values.

### Recurrence basis V1

`FIXED_SCHEDULE` — next due derives from the governed anchor/schedule and is not shifted simply because execution was late.

`LAST_COMPLETION` — next due derives from the accepted completion timestamp of the previous occurrence.

## 7. METER rule

Logical fields:

- MeasurementPointId of kind COUNTER;
- intervalValue;
- baseline value/reading;
- comparison semantics based on accumulated delta.

V1 rule:

`current counter - accepted baseline >= interval`

Counter reset/replacement must create a governed baseline adjustment; negative deltas must not silently create due work.

## 8. CONDITION rule

Logical fields:

- MeasurementPointId;
- comparison operator;
- warning threshold when applicable;
- action threshold;
- unit;
- reset/clear semantics.

V1 states:

`NORMAL → WARNING → ACTION`

Warning alone does not create a MaintenanceOccurrence unless policy explicitly says so.

Action may create/release an occurrence immediately or according to a configured release rule.

Repeated readings above the same action threshold must not create duplicate occurrences. A new occurrence requires the previous condition episode to be cleared/reset or explicitly rearmed.

## 9. Composite policy

A policy can contain multiple rules.

V1 combination operators:

- `ANY` — equivalent to OR; first satisfied rule can make the plan item actionable;
- `ALL` — supported in the logical model but requires explicit business validation before production use.

Example supported pattern:

`6 MONTHS OR 2000 OPERATING_HOURS, whichever occurs first` → two rules + `ANY`.

## 10. Release, Due and Overdue

Each forecast/occurrence may expose:

- `ForecastAt` — projected due;
- `ReleaseAt` — earliest point at which operational work may be materialized;
- `DueAt` — required execution boundary;
- `OverdueAt` — normally equal to DueAt for status transition, unless grace policy is explicitly configured later.

Triggering owns these temporal facts. Work Management owns planning, scheduling, assignment and execution statuses after a WorkOrder exists.

## 11. Occurrence lifecycle

V1 Triggering lifecycle:

`FORECAST` (derived only) → `RELEASED` → `DUE` → `OVERDUE`

Terminal/linked outcomes:

- `MATERIALIZED` — a WorkOrder has been created/referenced;
- `FULFILLED` — accepted completion satisfies the occurrence;
- `CANCELLED` — governed cancellation with reason;
- `SUPERSEDED` — plan/policy revision invalidates future occurrence before execution.

`MATERIALIZED` is not a replacement for RELEASED/DUE chronology; timestamps are preserved separately.

## 12. Idempotency

Triggering must never create duplicate operational demand for the same recurrence episode.

V1 invariant:

At most one open MaintenanceOccurrence exists for a given ProjectMaintenancePlanItem + TriggerPolicyVersion + recurrence episode unless an explicit reissue rule is invoked.

Idempotency evidence/key must derive from stable plan item, policy version and episode boundary rather than UI/session state.

## 13. WorkOrder handoff

Work Management receives:

- MaintenanceOccurrenceId;
- ProjectMaintenancePlanItemId;
- AssetId;
- MaintenanceActivityId;
- effective JobPlanRevisionId;
- ReleaseAt / DueAt;
- origin trigger type/reason summary;
- source policy/version;
- required execution-package references.

WorkOrder stores/reference snapshots needed for historical reproducibility but does not recalculate trigger rules.

## 14. Completion feedback

Accepted WorkOrder closure feeds TriggerState.

For `LAST_COMPLETION`, accepted completion becomes the next recurrence reference.

For meter rules, policy determines whether completion resets baseline to the current accepted meter reading.

For fixed schedule, late completion does not automatically shift future schedule.

## 15. Versioning

Published MaintenanceTriggerPolicy revisions are immutable.

Changing interval, threshold, recurrence basis, release lead or rule composition creates a new revision. Activation rules must define how already-released occurrences are treated; V1 default is that an existing WorkOrder/occurrence retains the policy revision under which it was created.

## 16. Human/system responsibility

System:

- calculates forecast;
- evaluates rules;
- creates release/due facts according to approved policy;
- prevents duplicates;
- records audit evidence.

Human/governed configuration:

- approves policy and thresholds;
- accepts baseline corrections/resets;
- authorizes exceptional cancellation/suppression;
- approves overrides and policy revisions.

## 17. Deferred to later gates

- complex AND semantics in production;
- hysteresis/persistence windows for noisy condition signals;
- predictive degradation models;
- streaming/IoT architecture;
- detailed scheduling/capacity;
- Permit-to-Work;
- final WorkOrder lifecycle.

## 18. TRG-G01 result

`TRG-G01 = PASS_CONTRACT`.

TIME is directly evidenced by structured project sources. METER and CONDITION are supported by the maintenance manuals and Product Truth but require runtime/source integration contracts before implementation.

### Next gate

`DM-G02 — Logical Model Freeze` must now verify that cross-domain cardinalities and ownership are sufficiently closed for physical SQL design. It cannot PASS if Work Management core contracts still leave blocking relationships unresolved.