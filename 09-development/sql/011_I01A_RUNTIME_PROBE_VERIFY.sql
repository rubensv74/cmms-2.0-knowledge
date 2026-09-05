/*
CMMS 2.0 — I01-A Runtime Probe Verification
Target: db-omm-dev
No business data is written.
*/
SET NOCOUNT ON;

IF OBJECT_ID(N'cmms.usp_Runtime_Probe', N'P') IS NULL
BEGIN
    THROW 51110, 'cmms.usp_Runtime_Probe is not installed.', 1;
END;

DECLARE @RequestId uniqueidentifier = NEWID();

DECLARE @Result TABLE
(
    contractVersion nvarchar(20),
    requestId nvarchar(36),
    ok nvarchar(10),
    outcomeCode nvarchar(40),
    message nvarchar(500),
    entityId nvarchar(36),
    concurrencyToken nvarchar(50),
    dataJson nvarchar(max),
    isReplay nvarchar(10),
    generatedAtUtc nvarchar(40)
);

INSERT INTO @Result
EXEC cmms.usp_Runtime_Probe
    @ActorEmail = N'cmms.runtime.probe@local.invalid',
    @RequestId = @RequestId;

IF NOT EXISTS
(
    SELECT 1
    FROM @Result
    WHERE outcomeCode = N'SUCCESS'
      AND ok = N'true'
      AND requestId = CONVERT(nvarchar(36), @RequestId)
      AND ISJSON(dataJson) = 1
      AND JSON_VALUE(dataJson, '$.DatabaseName') = DB_NAME()
      AND JSON_VALUE(dataJson, '$.ProcedureSchema') = N'cmms'
      AND JSON_VALUE(dataJson, '$.ProcedureName') = N'usp_Runtime_Probe'
)
BEGIN
    THROW 51111, 'I01-A runtime probe success contract verification failed.', 1;
END;

DECLARE @ValidationResult TABLE
(
    contractVersion nvarchar(20),
    requestId nvarchar(36),
    ok nvarchar(10),
    outcomeCode nvarchar(40),
    message nvarchar(500),
    entityId nvarchar(36),
    concurrencyToken nvarchar(50),
    dataJson nvarchar(max),
    isReplay nvarchar(10),
    generatedAtUtc nvarchar(40)
);

INSERT INTO @ValidationResult
EXEC cmms.usp_Runtime_Probe
    @ActorEmail = N'',
    @RequestId = @RequestId;

IF NOT EXISTS
(
    SELECT 1
    FROM @ValidationResult
    WHERE outcomeCode = N'VALIDATION'
      AND ok = N'false'
      AND requestId = CONVERT(nvarchar(36), @RequestId)
)
BEGIN
    THROW 51112, 'I01-A runtime probe validation contract verification failed.', 1;
END;

SELECT * FROM @Result;
SELECT * FROM @ValidationResult;

PRINT 'PASS_011_I01A_RUNTIME_PROBE_VERIFY';
