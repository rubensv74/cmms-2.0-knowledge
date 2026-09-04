/*
CMMS 2.0 — Namespace / SQL Capability Verification
Target database: db-omm-dev
Run after 001 and 002.

This script is read-only except for local temporary objects used to prove rowversion,
constraints and transaction behavior. No persistent business objects are created.
*/

SET NOCOUNT ON;
SET XACT_ABORT ON;

IF DB_NAME() <> N'db-omm-dev'
BEGIN
    THROW 51020, 'CMMS verification aborted: expected database db-omm-dev.', 1;
END;

DECLARE @MissingSchemas int = (
    SELECT COUNT(*)
    FROM (VALUES
        (N'cmms'),
        (N'cmms_api'),
        (N'cmms_cfg'),
        (N'cmms_audit'),
        (N'cmms_stage')
    ) AS required(name)
    WHERE NOT EXISTS (
        SELECT 1 FROM sys.schemas s WHERE s.name = required.name
    )
);

IF @MissingSchemas > 0
    THROW 51021, 'One or more required CMMS schemas are missing.', 1;

IF DATABASE_PRINCIPAL_ID(N'cmms_runtime') IS NULL
    THROW 51022, 'Database role cmms_runtime is missing.', 1;

/* Capability probe: rowversion + UNIQUE/CHECK + transaction rollback. */
CREATE TABLE #CmmsCapabilityProbe
(
    ProbeId int IDENTITY(1,1) NOT NULL PRIMARY KEY,
    ProbeCode nvarchar(40) NOT NULL UNIQUE,
    ProbeValue int NOT NULL CONSTRAINT CK_CmmsCapabilityProbe_Value CHECK (ProbeValue >= 0),
    Rv rowversion NOT NULL
);

INSERT INTO #CmmsCapabilityProbe (ProbeCode, ProbeValue)
VALUES (N'BASELINE', 1);

DECLARE @BeforeRv binary(8) = (SELECT Rv FROM #CmmsCapabilityProbe WHERE ProbeCode = N'BASELINE');

BEGIN TRANSACTION;
    UPDATE #CmmsCapabilityProbe
    SET ProbeValue = 2
    WHERE ProbeCode = N'BASELINE';
ROLLBACK TRANSACTION;

IF (SELECT ProbeValue FROM #CmmsCapabilityProbe WHERE ProbeCode = N'BASELINE') <> 1
    THROW 51023, 'Transaction rollback capability probe failed.', 1;

UPDATE #CmmsCapabilityProbe
SET ProbeValue = 2
WHERE ProbeCode = N'BASELINE';

DECLARE @AfterRv binary(8) = (SELECT Rv FROM #CmmsCapabilityProbe WHERE ProbeCode = N'BASELINE');

IF @BeforeRv = @AfterRv
    THROW 51024, 'rowversion capability probe failed.', 1;

SELECT
    DB_NAME() AS DatabaseName,
    CAST(SERVERPROPERTY('ProductVersion') AS nvarchar(128)) AS ProductVersion,
    CAST(SERVERPROPERTY('Edition') AS nvarchar(128)) AS Edition,
    CAST(DATABASEPROPERTYEX(DB_NAME(), 'Collation') AS nvarchar(128)) AS DatabaseCollation,
    CASE WHEN OBJECT_ID(N'sys.sp_getapplock') IS NOT NULL THEN 1 ELSE 0 END AS HasSpGetAppLock;

SELECT
    s.name AS SchemaName,
    USER_NAME(s.principal_id) AS SchemaOwner
FROM sys.schemas AS s
WHERE s.name IN (N'cmms', N'cmms_api', N'cmms_cfg', N'cmms_audit', N'cmms_stage')
ORDER BY s.name;

SELECT
    role_principal.name AS RoleName,
    permission.state_desc,
    permission.permission_name,
    schema_target.name AS SchemaName
FROM sys.database_permissions AS permission
JOIN sys.database_principals AS role_principal
    ON role_principal.principal_id = permission.grantee_principal_id
LEFT JOIN sys.schemas AS schema_target
    ON permission.class = 3
   AND schema_target.schema_id = permission.major_id
WHERE role_principal.name = N'cmms_runtime'
ORDER BY schema_target.name, permission.permission_name;

DROP TABLE #CmmsCapabilityProbe;

PRINT 'PASS_003_CMMS_NAMESPACE_VERIFY';
