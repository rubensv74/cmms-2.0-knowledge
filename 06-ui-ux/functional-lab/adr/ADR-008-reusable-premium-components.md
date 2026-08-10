# ADR-008 — Componentes premium reutilizables

**Estado:** Aprobado  
**Fecha:** 2026-08-10

## Decisión

Los componentes genéricos se diseñan como activos reutilizables y, cuando alcancen estabilidad suficiente, candidatos a Component Library.

Foundation inicial:

- `cmp_FL_SidebarPro`;
- `cmp_FL_PageHeaderPro`;
- `cmp_FL_TreePro`;
- `cmp_FL_ProcessRailPro`;
- `cmp_FL_DecisionPanelPro`;
- `cmp_FL_GatePanelPro`.

Los componentes visuales no contienen reglas funcionales específicas del caso P-101.

## Consecuencias

- Contratos públicos completos y documentados.
- Estado por instancia siempre que sea posible.
- Componentes de PULSE pueden reutilizarse como referencias positivas, no como dependencias implícitas.
- Cada promoción requiere gates de definición, instancia, contrato y QA visual.
