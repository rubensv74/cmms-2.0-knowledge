/*
CMMS 2.0 — I01-A Runtime Probe Rollback
Drops only the I01-A probe procedure.
Creates/drops no roles or principals.
*/

IF OBJECT_ID(N'cmms.usp_Runtime_Probe', N'P') IS NOT NULL
    DROP PROCEDURE cmms.usp_Runtime_Probe;
GO

PRINT 'PASS_010_I01A_RUNTIME_PROBE_ROLLBACK';
