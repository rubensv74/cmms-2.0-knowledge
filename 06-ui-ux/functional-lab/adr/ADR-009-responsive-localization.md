# ADR-009 — Desktop+tablet y localización ES/EN future-ready

**Estado:** Aprobado  
**Fecha:** 2026-08-10

## Decisión

La experiencia funcional completa se diseña para desktop y tablet. Móvil completo queda fuera del alcance actual.

La interfaz visible actual se implementa en español, pero los textos nuevos deben poder migrarse a un catálogo de traducciones ES/EN mediante claves semánticas sin duplicar pantallas.

## Consecuencias

- Sidebar colapsable y layouts con anchos relativos.
- Paneles laterales deben poder apilarse o compactarse en tablet.
- Los controles no deben dimensionarse exclusivamente para textos españoles cortos.
- No se implementa todavía un selector de idioma obligatorio, pero no se incrusta lógica dependiente del idioma.
