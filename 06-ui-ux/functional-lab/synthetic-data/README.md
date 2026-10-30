# CMMS Functional Lab — Synthetic Data Pack

**Status:** V1 scope established; fixture contract candidate  
**Purpose:** provide coherent, repeatable data for DVP screen generation, full-cycle walkthroughs, contract alignment and later volume checks.

## Rules

- Every record is synthetic or explicitly references the existing conceptual P-101 fixture.
- No real personal data, company email, production IDs, or unapproved inventory values.
- Stable IDs and deterministic generation make screenshots and defect reports reproducible.
- Preserve relationships across assets, plans, triggers, orders, visits, executions, findings and KPIs.
- Mark illustrative thresholds, costs, authority, calendars and statuses as demo-only.
- Do not turn synthetic master/standard values into corporate standards or approved maintenance instructions.
- Open business choices appear as explicit alternatives or OPEN_DECISION fields; the default dataset must not choose one.
- DVP scenarios use the same fixture version across screen renders and acceptance evidence.
- A dataset shown in a screen is not evidence that its behavior is runtime-connected.

## Lifecycle coverage

1. Asset identity, location, hierarchy and operating context.
2. Engineering source/provenance: RCM, corporate standard reference, OEM and engineering experience.
3. FMEA/RCM case and governed Project Maintenance Plan with version history.
4. Time-based plan with an annual WorkOrder and multiple visits.
5. Condition measurements → specialist recommendation → planning-created intervention order; no automatic repair from alarm.
6. Operational observation/logbook → event/request triage → corrective WorkOrder.
7. Readiness, constraints, calendar/capacity, scheduling and crew assignment.
8. Visit-level execution dates, results, labor/material actuals, checklist evidence and findings.
9. Demonstration of major repair resetting selected time-based cadence from repair finish while condition-monitoring cadence stays unchanged.
10. Corrective follow-up and plan/reliability feedback.
11. Open decisions: annual-cycle boundaries, year-end visits, major-repair scope, PTW/inventory source, roles and authority, cost/KPI policy.

## Profiles

| Profile | Intended use | Volume status |
|---|---|---|
| walkthrough | User-led DVP and full-cycle demonstration | Fixed curated records, including an annual parent with end-of-cycle pending disposition left OPEN |
| functional | 250 synthetic assets, 62 annual PM orders / 248 visits, 50 condition cases / 400 readings, 35 observation-event cases, 17 corrective orders, 141 execution records and 14 major-repair cadence-reset examples; also findings, follow-ups, permit references, crews and material requirements | Generated deterministically; demonstration only |
| load | 2,000 assets and proportionally expanded linked lifecycle records | Generator profile only; no performance acceptance target until real read paths and limits are known |

Curated walkthrough fixture: `cases/cmms-full-cycle-v1.json`. Functional volume fixture: `cmms-lab-synthetic-functional-v1.json.gz` (decompress to JSON before loading). Reproducible generator: `generate_cmms_lab_volume.py` (`--profile functional` or `--profile load`); output is compact UTF-8 JSON. Later expansions must retain the curated scenario IDs and stable keys.

For each DVP screen, identify the fixture scenario, selected record, synthetic persona, state, viewport, expected action/result and relevant contract. Use the current DVP/D2P method and CMMS premium design/component catalog; a generated mockup is not a runtime screenshot.
