/*
CMMS 2.0 — Runtime Role Foundation
Target database: db-omm-dev
Purpose: create the database role that Power Automate runtime will use once the concrete database user is known.

This script DOES NOT add any user/login to the role.
Binding the real Power Automate SQL identity is a separate gate because the identity is not yet confirmed.

Security model:
- runtime may SELECT read contracts in cmms_api
- runtime may EXECUTE command/query procedures in cmms_api
- runtime has no direct access to CMMS physical domain/config/audit/staging schemas
*/

SET NOCOUNT ON;
SET XACT_ABORT ON;

IF DB_NAME() <> N'db-omm-dev'
BEGIN
    THROW 51010, 'CMMS runtime-role bootstrap aborted: expected database db-omm-dev.', 1;
END;

IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = N'cmms_api')
    THROW 51011, 'Schema cmms_api does not exist. Run 001_CMMS_NAMESPACE_BOOTSTRAP.sql first.', 1;

IF DATABASE_PRINCIPAL_ID(N'cmms_runtime') IS NULL
    CREATE ROLE [cmms_runtime] AUTHORIZATION [dbo];

GRANT SELECT ON SCHEMA::[cmms_api] TO [cmms_runtime];
GRANT EXECUTE ON SCHEMA::[cmms_api] TO [cmms_runtime];

/* Explicitly prevent the runtime role from becoming a direct CRUD client of physical CMMS schemas. */
DENY SELECT, INSERT, UPDATE, DELETE ON SCHEMA::[cmms] TO [cmms_runtime];
DENY SELECT, INSERT, UPDATE, DELETE ON SCHEMA::[cmms_cfg] TO [cmms_runtime];
DENY SELECT, INSERT, UPDATE, DELETE ON SCHEMA::[cmms_audit] TO [cmms_runtime];
DENY SELECT, INSERT, UPDATE, DELETE ON SCHEMA::[cmms_stage] TO [cmms_runtime];

SELECT
    dp.name AS RoleName,
    dp.type_desc AS PrincipalType
FROM sys.database_principals AS dp
WHERE dp.name = N'cmms_runtime';

PRINT 'PASS_002_CMMS_RUNTIME_ROLE';
