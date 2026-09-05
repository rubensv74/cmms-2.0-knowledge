/*
CMMS 2.0 — I01-A Runtime Contract Probe
Target: db-omm-dev
Schema: cmms
Architecture: Power Apps -> Power Automate -> SQL Server

Creates NO business tables, roles or principals.
*/
SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
GO

IF SCHEMA_ID(N'cmms') IS NULL
    THROW 51100, 'Required schema cmms does not exist. Run CMMS namespace bootstrap first.', 1;
GO

CREATE OR ALTER PROCEDURE cmms.usp_Runtime_Probe
    @ActorEmail nvarchar(320) = NULL,
    @RequestId uniqueidentifier
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @NowUtc datetime2(3) = SYSUTCDATETIME();
    DECLARE @NormalizedActorEmail nvarchar(320) = LOWER(LTRIM(RTRIM(COALESCE(@ActorEmail, N''))));
    DECLARE @DataJson nvarchar(max);

    IF @RequestId IS NULL
    BEGIN
        SELECT
            N'1.0' AS contractVersion,
            N'' AS requestId,
            N'false' AS ok,
            N'VALIDATION' AS outcomeCode,
            N'RequestId is required.' AS message,
            N'' AS entityId,
            N'' AS concurrencyToken,
            N'{}' AS dataJson,
            N'false' AS isReplay,
            CONVERT(nvarchar(33), @NowUtc, 126) + N'Z' AS generatedAtUtc;
        RETURN;
    END;

    IF @NormalizedActorEmail = N''
    BEGIN
        SELECT
            N'1.0' AS contractVersion,
            CONVERT(nvarchar(36), @RequestId) AS requestId,
            N'false' AS ok,
            N'VALIDATION' AS outcomeCode,
            N'ActorEmail is required for CMMS functional traceability.' AS message,
            N'' AS entityId,
            N'' AS concurrencyToken,
            N'{}' AS dataJson,
            N'false' AS isReplay,
            CONVERT(nvarchar(33), @NowUtc, 126) + N'Z' AS generatedAtUtc;
        RETURN;
    END;

    SELECT @DataJson =
    (
        SELECT
            DB_NAME() AS DatabaseName,
            @@SERVERNAME AS ServerName,
            OBJECT_SCHEMA_NAME(@@PROCID) AS ProcedureSchema,
            OBJECT_NAME(@@PROCID) AS ProcedureName,
            @NormalizedActorEmail AS ActorEmail
        FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
    );

    SELECT
        N'1.0' AS contractVersion,
        CONVERT(nvarchar(36), @RequestId) AS requestId,
        N'true' AS ok,
        N'SUCCESS' AS outcomeCode,
        N'CMMS runtime contract is reachable.' AS message,
        N'' AS entityId,
        N'' AS concurrencyToken,
        COALESCE(@DataJson, N'{}') AS dataJson,
        N'false' AS isReplay,
        CONVERT(nvarchar(33), @NowUtc, 126) + N'Z' AS generatedAtUtc;
END;
GO

PRINT 'PASS_010_I01A_RUNTIME_PROBE_DEPLOYED';
