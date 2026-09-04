# CMMS 2.0 — Combined G0 SQL + C01 Studio Gate

**Estado:** `SQL_PASS / WAITING_POWER_APPS_STUDIO_EVIDENCE`  
**Fecha:** 2026-09-04

## 1. Estado

The SQL portion of G0 is complete.

Confirmed real target:

```text
Server   = dbs-hointegration-dev
Database = db-omm-dev
Identity = tradminomm
Edition  = SQL Azure
```

Confirmed CMMS schemas:

```text
cmms
cmms_api
cmms_cfg
cmms_audit
cmms_stage
```

Confirmed development capabilities:

```text
rowversion              = PASS
transactions/rollback   = PASS
UNIQUE/CHECK             = PASS
sp_getapplock            = available
CREATE TABLE             = yes
CREATE PROCEDURE         = yes
CREATE VIEW              = yes
ALTER cmms               = yes
ALTER cmms_api           = yes
```

Evidence record:

`09-development/gates/evidence/2026-09-04_G0_SQL_NAMESPACE_PASS.md`

No additional CMMS database role is to be created. Power Automate will use the existing development database user.

## 2. Remaining gate — Canvas app `CMMS`

The only remaining manual foundation evidence is Power Apps Studio reality.

Open the current `CMMS` Canvas app and capture:

### A — Current app / environment

A screenshot showing the current screen tree and environment/app context.

### B — App Checker

Capture the summary for the current empty app:

```text
Errors
Formula/warnings if shown
Accessibility
Performance
```

This becomes the C01 baseline.

### C — Components

Capture the Components tree.

The current declaration is that the app is empty. Historical components from August are not considered installed until current Studio evidence confirms them.

### D — Display / responsive settings

If not already obvious from the app screenshot, capture Settings > Display sufficiently to confirm the current responsive/layout reality.

One or two screenshots are enough if they show all of the above clearly.

## 3. What happens immediately after PASS

No further conceptual planning round is required.

```text
C01-A Theme/Layout Foundation
→ C01-B CMMS Sidebar + Project Context + Page Header
→ C01-C Canonical Screen Template
→ I01-A Backend Common Contracts
→ I01-B Project/Asset/Study Read Slice
→ I01-C Safe Study Scope Command
→ C02 P-101 Reliability Backbone
```

## 4. Guardrails already frozen

```text
Power Apps
→ Power Automate
→ cmms_api Stored Procedures / read contracts
→ CMMS domain schemas
```

- no API is built now;
- contracts remain suitable for a future API boundary;
- SQL owns integrity, transactions and concurrency;
- Power Automate does not own business invariants;
- no direct Power Apps table DML;
- `ActorEmail`/functional actor is preserved separately from the technical SQL connection;
- no additional CMMS database role is created in development.

## 5. Stop condition

Do not create the productive ReliabilityStudy aggregate before the current Studio baseline is captured. The SQL platform itself no longer blocks development.
