# CMMS 2.0 — Combined G0 SQL + C01 Studio Gate

**Estado:** `CLOSED / G0_PASS`  
**Fecha:** 2026-09-04

## Resultado

La foundation runtime ha sido validada con evidencia real de SQL y Power Apps.

### SQL

```text
Database     = db-omm-dev
Server       = dbs-hointegration-dev
Identity     = tradminomm
Platform     = SQL Azure
CMMS schemas = installed
rowversion   = PASS
transactions = PASS
constraints  = PASS
DDL capability = PASS
```

### Power Apps

```text
App          = CMMS
Environment  = ENV PRE TR 162
Current tree = Screen1 / ScreenContainer1
Components   = empty
Layout       = Responsive
Aspect lock  = Off
Orientation lock = Off
App Checker  = Accessibility (1), no other visible counters
```

Evidence:

- `09-development/gates/evidence/2026-09-04_G0_SQL_NAMESPACE_PASS.md`
- `09-development/gates/evidence/2026-09-04_G0_POWER_APPS_PASS.md`

## Runtime identity decision

Power Automate uses the existing development database user. No additional CMMS database role is created.

Functional actor identity remains explicit through `ActorEmail`/actor data when applicable.

## Gate marker

```text
G0_RUNTIME_FOUNDATION_PASS
```

## Next real gate

The next blocking uncertainty is Source Code/control compatibility for the current Power Apps Studio.

Use:

`09-development/power-apps/C01_A_STUDIO_GATE.md`

Sequence:

```text
App.Formulas
→ App.OnStart
→ scr_CMMS_Foundation_C01 native screen
→ responsive/App Checker evidence
→ C01_A_FOUNDATION_STUDIO_PASS
```
