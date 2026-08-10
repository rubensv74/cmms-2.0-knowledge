# ADR-007 — Backend desacoplado con contratos Azure SQL-ready

**Estado:** Aprobado  
**Fecha:** 2026-08-10

## Decisión

El Functional Lab no fija todavía un backend productivo definitivo. Los contratos de datos se diseñan pensando especialmente en Azure SQL y en una implementación relacional empresarial.

La UI consume una frontera de aplicación/adaptador:

```text
Power Apps UI
  ↓
Application Adapter
  ↓
Conceptual Contracts
  ↓
Azure SQL / API / implementación futura
```

Durante el laboratorio, fixture JSON y colecciones Power Fx pueden implementar temporalmente el adaptador.

## Consecuencias

- Ninguna pantalla debe depender de la forma del fixture P-101.
- Los objetos runtime deben aproximarse al modelo persistente.
- Sustituir el adaptador no debe cambiar la semántica de pantallas, gates o decisiones.
- Las claves, relaciones y estados se diseñan desde ahora con persistencia futura en mente.
