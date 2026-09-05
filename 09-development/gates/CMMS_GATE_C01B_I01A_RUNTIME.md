# CMMS 2.0 — Combined Gate C01-B + I01-A

**State:** `WAITING_REAL_RUNTIME_EVIDENCE`  
**Date:** 2026-09-05  
**Purpose:** close the shared Power Apps shell and prove the first real Power Apps → Power Automate → SQL contract in one manual session.

---

## 1. Why this is a real gate

Everything before this point can be prepared in repository artifacts.

These facts cannot be proven without the real Microsoft environment:

- Canvas component Source Code compatibility;
- component event behavior;
- responsive behavior after component extraction;
- current App Checker delta;
- Power Automate SQL connector discovery/execution of `cmms.usp_Runtime_Probe`;
- actual Power Apps → Flow → SQL → Power Apps round-trip.

No further conceptual decision is required before this gate.

---

# PART A — C01-B Shared Shell

## A1. Replace App.Formulas

Use:

```text
09-development/power-apps/C01_B_APP_FORMULAS.powerfx.txt
```

Do not replace App.OnStart.

## A2. Install canonical components

Install in this order:

```text
1. cmp_CMMS_SidebarPro
2. cmp_CMMS_ProjectContextPro
3. cmp_CMMS_PageHeaderPro
```

Sources:

```text
08-resources/power-apps/components/foundation/cmp_CMMS_SidebarPro_C01B.pa.yaml
08-resources/power-apps/components/foundation/cmp_CMMS_ProjectContextPro_C01B.pa.yaml
08-resources/power-apps/components/foundation/cmp_CMMS_PageHeaderPro_C01B.pa.yaml
```

Canonical names inside Power Apps must contain no version suffix.

## A3. Install retained Reliability screen

Source:

```text
08-resources/power-apps/screens/reliability/scr_ReliabilityEngineering_C01B.pa.yaml
```

Expected screen:

```text
scr_ReliabilityEngineering
```

Keep the previous foundation screen until this gate passes.

## A4. Functional checks

```text
[ ] Reliability Engineering is active
[ ] unreleased sidebar modules are disabled
[ ] disabled routes do not change active navigation state
[ ] sidebar collapse works
[ ] sidebar expand works
[ ] width changes 280 ↔ 72 without overlap
[ ] Project Context renders No project selected
[ ] Page Header renders without clipping
[ ] normal desktop width is structurally clean
[ ] reduced Studio width is structurally usable
[ ] no new Formula/Runtime error in App Checker
```

If Source Code fails, STOP this part and return the complete Power Apps error text. Do not locally redesign the artifact.

PASS marker:

```text
C01_B_SHARED_SHELL_STUDIO_PASS
```

---

# PART B — I01-A SQL Runtime Contract

Proceed only if Part A has no blocking Power Apps error, or execute independently if desired while preserving the evidence separately.

## B1. SQL deployment

Execute against **db-omm-dev**:

```text
09-development/sql/010_I01A_RUNTIME_PROBE.sql
09-development/sql/011_I01A_RUNTIME_PROBE_VERIFY.sql
```

Expected markers:

```text
PASS_010_I01A_RUNTIME_PROBE_DEPLOYED
PASS_011_I01A_RUNTIME_PROBE_VERIFY
```

Expected success row:

```text
outcomeCode = SUCCESS
ok = true
requestId = generated RequestId
dataJson.DatabaseName = db-omm-dev
dataJson.ProcedureSchema = cmms
dataJson.ProcedureName = usp_Runtime_Probe
```

The verification script also proves the `VALIDATION` outcome for blank ActorEmail.

No business table, role or principal is created.

## B2. Power Automate Flow

Create:

```text
CMMS_I01A_RuntimeProbe
```

Follow:

```text
09-development/power-automate/I01_A_RUNTIME_PROBE_FLOW.md
```

Architecture must remain:

```text
Power Apps (V2)
→ existing SQL connection / current user
→ db-omm-dev
→ cmms.usp_Runtime_Probe
→ Respond to Power Apps
```

Do not add SQL business logic in Flow.

## B3. Power Apps round-trip

Add the Flow to the CMMS app.

Use a temporary development button with:

```text
09-development/power-apps/I01_A_RUNTIME_PROBE_POWERFX.txt
```

The button is test-only and is removed after PASS.

Success requires:

```text
Power Apps RequestId
= SQL returned requestId
= Flow returned requestId
```

and:

```text
outcomeCode = SUCCESS
```

PASS marker:

```text
PASS_I01A_RUNTIME_CONTRACT
```

---

## 2. Evidence to return

Minimum evidence:

```text
Power Apps
1. scr_ReliabilityEngineering normal width
2. sidebar collapsed
3. App Checker summary

SQL
4. output from 011_I01A_RUNTIME_PROBE_VERIFY.sql

Power Automate / integration
5. successful Flow run showing SQL action succeeded
6. Power Apps SUCCESS notification or probe result variables
```

A single screenshot can satisfy more than one item if the evidence is readable.

---

## 3. Combined PASS

The gate closes only when both markers are obtained:

```text
C01_B_SHARED_SHELL_STUDIO_PASS
PASS_I01A_RUNTIME_CONTRACT
```

At that point:

```text
C01 shared shell = frozen enough for product screens
I01 backend envelope = proven in real runtime
```

---

## 4. Work immediately after PASS

No new planning workshop.

Autonomous sequence:

```text
C01-C canonical screen template
→ I01-B minimum Project / Asset / Reliability Study model
→ synthetic P-101 + RCM-000127 seed
→ cmms read procedures
→ thin Power Automate read flows
→ Reliability Studies real screen
```

The next mutable gate after that is I01-C Study Scope concurrency.
