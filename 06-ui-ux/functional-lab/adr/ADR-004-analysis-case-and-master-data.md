# ADR-004 — AnalysisCase como raíz y datos maestros read-only

**Estado:** Aprobado  
**Fecha:** 2026-08-10

## Decisión

`AnalysisCase` es el objeto raíz del análisis. P-101 es únicamente el primer caso de demostración.

Los datos maestros de activo —código, nombre, jerarquía, taxonomía y relaciones técnicas— se consumen como referencia de solo lectura dentro del análisis.

El caso puede conservar snapshot/contexto necesario para justificar una decisión, pero no corrige directamente el maestro.

## Consecuencias

- FLH, Taxonomía y ADR pertenecen al módulo Activos.
- El caso referencia `TechnicalObject` y otros objetos maestros.
- Una discrepancia de maestro debe generar un proceso o solicitud de corrección independiente.
- La UI debe diferenciar dato maestro, snapshot del caso y dato creado por el análisis.
