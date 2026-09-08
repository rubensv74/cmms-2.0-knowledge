/*
CMMS 2.0 — Namespace / SQL Capability Verification
Target database: db-omm-dev
Run after 001_CMMS_NAMESPACE_BOOTSTRAP.sql.

This script creates no persistent CMMS business objects.
It uses only a local temporary object to prove rowversion, constraints and transaction rollback.

Runtime decision:
- Power Automate will execute CMMS stored procedures using the existing database user already available for development.
- No CMMS-specific database role is created in this phase.
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
        SELECT 1
        FROM sys.schemas AS s
        WHERE s.name = required.name
    )
);

IF @MissingSchemas > 0
    THROW 51021, 'One or more required CMMS schemas are missing.', 1;

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

DECLARE @BeforeRv binary(8) =
(
    SELECT Rv
    FROM #CmmsCapabilityProbe
    WHERE ProbeCode = N'BASELINE'
);

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

DECLARE @AfterRv binary(8) =
(
    SELECT Rv
    FROM #CmmsCapabilityProbe
    WHERE ProbeCode = N'BASELINE'
);

IF @BeforeRv = @AfterRv
    THROW 51024, 'rowversion capability probe failed.', 1;

/* Environment / execution identity evidence. */
SELECT
    CAST(@@SERVERNAME AS nvarchar(256)) AS ServerName,
    DB_NAME() AS DatabaseName,
    SUSER_SNAME() AS LoginName,
    USER_NAME() AS DatabaseUser,
    ORIGINAL_LOGIN() AS OriginalLogin,
    CAST(SERVERPROPERTY('ProductVersion') AS nvarchar(128)) AS ProductVersion,
    CAST(SERVERPROPERTY('Edition') AS nvarchar(128)) AS Edition,
    CAST(DATABASEPROPERTYEX(DB_NAME(), 'Collation') AS nvarchar(128)) AS DatabaseCollation,
    CASE WHEN OBJECT_ID(N'sys.sp_getapplock') IS NOT NULL THEN 1 ELSE 0 END AS HasSpGetAppLock;

/* Namespace evidence. */
SELECT
    s.name AS SchemaName,
    USER_NAME(s.principal_id) AS SchemaOwner
FROM sys.schemas AS s
WHERE s.name IN (N'cmms', N'cmms_api', N'cmms_cfg', N'cmms_audit', N'cmms_stage')
ORDER BY s.name;

/* Current execution capability evidence. This does not create or require any additional role. */
SELECT
    HAS_PERMS_BY_NAME(DB_NAME(), 'DATABASE', 'CREATE TABLE') AS CanCreateTable,
    HAS_PERMS_BY_NAME(DB_NAME(), 'DATABASE', 'CREATE PROCEDURE') AS CanCreateProcedure,
    HAS_PERMS_BY_NAME(DB_NAME(), 'DATABASE', 'CREATE VIEW') AS CanCreateView,
    HAS_PERMS_BY_NAME(N'cmms', 'SCHEMA', 'ALTER') AS CanAlterCmmsSchema,
    HAS_PERMS_BY_NAME(N'cmms_api', 'SCHEMA', 'ALTER') AS CanAlterCmmsApiSchema;

DROP TABLE #CmmsCapabilityProbe;

PRINT 'PASS_003_CMMS_NAMESPACE_VERIFY';
