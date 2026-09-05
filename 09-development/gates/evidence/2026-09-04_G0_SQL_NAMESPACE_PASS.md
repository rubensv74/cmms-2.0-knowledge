# CMMS 2.0 — G0 SQL Namespace Evidence

**Date:** 2026-09-04  
**Gate:** G0 Runtime Foundation — SQL portion  
**Status:** `PASS`

## Evidence source

Manual execution of the CMMS namespace bootstrap and verification against the real development database.

## Target confirmed

```text
ServerName        = dbs-hointegration-dev
DatabaseName      = db-omm-dev
LoginName         = tradminomm
DatabaseUser      = tradminomm
OriginalLogin     = tradminomm
ProductVersion    = 12.0.2000.8
Edition           = SQL Azure
DatabaseCollation = SQL_Latin1_General_CP1_CI_AS
HasSpGetAppLock   = 1
```

## CMMS namespace confirmed

All schemas exist and are owned by `dbo`:

```text
cmms
cmms_api
cmms_audit
cmms_cfg
cmms_stage
```

No additional CMMS database role is required or authorized for this development phase.

## Deployment capability confirmed

The current development identity returned:

```text
CanCreateTable          = 1
CanCreateProcedure      = 1
CanCreateView           = 1
CanAlterCmmsSchema      = 1
CanAlterCmmsApiSchema   = 1
```

## Concurrency / SQL capability probe

`003_CMMS_NAMESPACE_VERIFY.sql` completed through the final result sets after exercising its temporary capability probe.

Therefore the gate records PASS for:

```text
schemas                 = PASS
rowversion              = PASS
transaction rollback    = PASS
UNIQUE/CHECK capability = PASS
sp_getapplock available = PASS
DDL authority           = PASS
```

The temporary probe created no persistent CMMS business objects.

## Runtime decision

Power Automate will execute CMMS Stored Procedures using the existing `tradminomm` development database connection/identity. No `cmms_runtime` or other additional CMMS database role will be created.

This broad technical permission does not change the application boundary:

```text
Power Apps
→ Power Automate
→ cmms_api Stored Procedures / read contracts
→ cmms / cmms_cfg / cmms_audit
```

Power Apps must not perform direct table DML as part of the CMMS architecture.

Functional user identity remains explicit through `ActorEmail` / actor fields in commands when an action originates from Power Apps.

## Gate consequence

```text
G0 SQL portion = PASS
```

Remaining G0 evidence is Power Apps Studio reality only:

- current Canvas environment/app baseline;
- App Checker baseline;
- component inventory;
- current authoring/source-code reality.
