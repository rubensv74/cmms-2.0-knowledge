/*
CMMS 2.0 — Namespace Bootstrap
Target database: db-omm-dev
Purpose: create the isolated CMMS namespace inside the shared O&M development database.

IMPORTANT
- Run in db-omm-dev only.
- This script is idempotent for schema creation.
- It creates NO business tables.
- It binds NO runtime user/login.
- All schemas are owned by dbo to preserve predictable ownership chaining for governed views/SPs.
*/

SET NOCOUNT ON;
SET XACT_ABORT ON;

IF DB_NAME() <> N'db-omm-dev'
BEGIN
    THROW 51000, 'CMMS bootstrap aborted: expected database db-omm-dev.', 1;
END;

BEGIN TRY
    BEGIN TRANSACTION;

    IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = N'cmms')
        EXEC(N'CREATE SCHEMA [cmms] AUTHORIZATION [dbo];');

    IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = N'cmms_api')
        EXEC(N'CREATE SCHEMA [cmms_api] AUTHORIZATION [dbo];');

    IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = N'cmms_cfg')
        EXEC(N'CREATE SCHEMA [cmms_cfg] AUTHORIZATION [dbo];');

    IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = N'cmms_audit')
        EXEC(N'CREATE SCHEMA [cmms_audit] AUTHORIZATION [dbo];');

    IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = N'cmms_stage')
        EXEC(N'CREATE SCHEMA [cmms_stage] AUTHORIZATION [dbo];');

    COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0
        ROLLBACK TRANSACTION;
    THROW;
END CATCH;

SELECT
    DB_NAME() AS DatabaseName,
    s.name AS SchemaName,
    USER_NAME(s.principal_id) AS SchemaOwner
FROM sys.schemas AS s
WHERE s.name IN (N'cmms', N'cmms_api', N'cmms_cfg', N'cmms_audit', N'cmms_stage')
ORDER BY s.name;

PRINT 'PASS_001_CMMS_NAMESPACE_BOOTSTRAP';
