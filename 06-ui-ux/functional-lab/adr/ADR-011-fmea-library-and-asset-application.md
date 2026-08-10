# ADR-011 — Biblioteca AMEF reutilizable y aplicación a activos

**Estado:** accepted  
**Fecha:** 2026-08-10  
**Origen:** auditoría de alineación con las últimas reuniones.

## Contexto

La arquitectura anterior hacía que `AnalysisCase` fuese propietario directo de funciones, fallos funcionales, modos, efectos y parte del AMEF. Las reuniones confirmaron un modelo diferente: la ingeniería AMEF debe existir como contenido reutilizable por tipo/familia de equipo y después aplicarse a activos concretos.

## Decisión

Separar cuatro capas:

```text
1. BIBLIOTECA DE INGENIERÍA
   FmeaDefinition → FmeaRevision

2. CONTEXTO DE PLANTA
   TechnicalObject + AssetCriticalityAssessment + FLH/Taxonomy/ADR

3. APLICACIÓN
   FmeaAssetApplication + AnalysisCase + overrides/decisiones

4. EJECUTABILIDAD
   MaintenanceTask + Procedure/JobPlan + PM/WO handoff
```

`Function`, `FunctionalFailure`, `FailureMode`, `FailureCause`, `FailureEffect` y `ProposedMaintenanceTask` pertenecen a una `FmeaRevision` reutilizable.

`AnalysisCase` deja de ser el propietario de esa ingeniería. Referencia:

```text
TechnicalObjectId
FmeaRevisionId
FmeaAssetApplicationId
AssetCriticalityAssessmentId
```

y conserva contexto, evidencias locales, overrides, decisiones humanas, evaluación contextual, aprobación y mejora.

## Consecuencias

- P-101 pasa a ser una aplicación de la revisión `BOMBA-CENTRIFUGA / R01`.
- P-102 puede reutilizar la misma revisión con criticidad, contexto y frecuencias diferentes.
- actualizar la biblioteca no modifica silenciosamente una aplicación ya aprobada; la adopción de una nueva revisión es explícita.
- no se duplican funciones/modos por activo salvo override contextual gobernado.
- la UI debe mostrar siempre qué revisión de biblioteca se está aplicando.

## Relación con ADR-004

Este ADR **supersede la parte de ADR-004 que situaba Functions/Failures/Modes como contenido propiedad de `AnalysisCase`**. Se mantiene de ADR-004 la separación entre datos maestros read-only y datos propios del análisis.
