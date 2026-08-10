# ADR-001 — Functional Lab con shell completo CMMS 2.0

**Estado:** Aprobado  
**Fecha:** 2026-08-10

## Contexto

El laboratorio había evolucionado hacia una navegación dominada por workspaces AMEF/RCM. Eso hacía visible la metodología, pero podía percibirse como navegador de prototipos y no como una aplicación CMMS auténtica.

## Decisión

La identidad visible seguirá siendo **CMMS 2.0 Functional Lab**.

El App Shell mostrará desde ahora la arquitectura completa del producto:

- Inicio;
- Activos;
- Estrategia de mantenimiento;
- Planes de mantenimiento;
- Gobernanza;
- Configuración.

Solo algunos módulos estarán operativos inicialmente. Los no implementados se representarán como `planned/preview` sin fingir funcionalidad.

## Consecuencias

- Sidebar deja de ser menú de etapas AMEF/RCM.
- El journey metodológico pasa a navegación secundaria dentro de `AnalysisCase`.
- Las pantallas deben parecer producto, no material didáctico.
- `Functional Lab` permanece como etiqueta de entorno conceptual y gobernanza.
