# ADR-002 — Navegación dual: producto + Process Rail

**Estado:** Aprobado  
**Fecha:** 2026-08-10

## Contexto

Las 28 etapas deben seguir siendo visibles y secuenciales, pero no deben convertirse en el menú global de la aplicación.

## Decisión

Se separan dos navegaciones:

1. **Navegación de producto** mediante Sidebar global por módulos CMMS.
2. **Navegación metodológica** mediante `cmp_FL_ProcessRailPro` dentro de un `AnalysisCase`.

El Process Rail mostrará las 28 etapas, fase, estado y responsabilidad. La secuencia es guiada por defecto, pero un usuario experto puede consultar otras etapas. Los gates impiden confirmación o aprobación formal cuando las dependencias no están satisfechas.

## Consecuencias

- El rail puede navegar a distintas pantallas y secciones.
- `FL-xx` continúa siendo un identificador funcional, no un nombre de pantalla.
- El estado del rail procede de `AnalysisStageExecution`, no del control visual.
