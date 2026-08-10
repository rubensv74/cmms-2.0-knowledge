# Functional Lab — Implementation Status

**Fecha:** 2026-08-10  
**Estado general:** F01 — Power Apps Premium Foundation  
**Último gate superado:** `F01-00A-R5-TB hybrid Text binding` — INSTANCE_SAFE PASS  
**Gate actual:** `F01-00A-RC1 premium sidebar recovery` — PENDING ONE FINAL STUDIO SMOKE TEST

## 1. Estado de incrementos

| Incremento | Estado | Resultado |
|---|---|---|
| F00-01..F00-09 | completed | Base funcional, journey, fixture, arquitectura y handoff definidos. |
| F01-00 Auditoría Power Apps Foundation | partial | Compatibilidad real identificada y recuperación final del Sidebar en curso. |
| F01-00A cmp_FL_SidebarPro | review-required | FL-SC-001 suficientemente delimitado; reconstrucción completa en curso. |
| F01-00A-R1 | validated-pass | Baseline mínimo instance-safe. |
| F01-00A-R2 | validated-pass | ModernText estático instance-safe. |
| F01-00A-R3 | validated-pass | AutoLayout + contenedores anidados instance-safe. |
| F01-00A-R4 | validated-pass | Controles de navegación estáticos instance-safe. |
| F01-00A-R5 | failed-instance | `CustomProperties:` inyectado por YAML reproduce cierre de Studio. |
| F01-00A-R5-TM | validated-pass | Input/Text creado manualmente en Studio es instance-safe. |
| F01-00A-R5-TB | validated-pass | YAML puede consumir una propiedad creada por Studio. |
| F01-00A-R5-BM | stopped | Se detiene la validación microscópica por tipo; no aporta valor suficiente al objetivo actual. |
| F01-00A-RC1 full premium recovery | pending-user-validation | Sidebar visual completo, 10 destinos, Gallery interna y caso P-101; sin `CustomProperties:` ni dependencias externas. |
| F01-00B cmp_FL_PageHeaderPro | blocked-by-FL-SC-001 | Se desbloquea en cuanto RC1 sea instance-safe y estable al guardar/reabrir. |
| F01-01 Premium App Shell Foundation | blocked-by-components | Depende del Sidebar y PageHeader validados. |

## 2. Estrategia de autoría vigente

```text
PUBLIC CONTRACT     → Studio, solo cuando realmente se necesite
VISUAL BODY         → Source Code incremental
CustomProperties:   → NO se inyecta en el YAML pegable probado
```

La fase R5 de laboratorio queda cerrada. No se validarán Boolean, Color, Table, Output o Event de forma aislada salvo que un fallo real del producto obligue a hacerlo.

## 3. RC1 — objetivo

Recuperar el Sidebar premium como producto usable con un único smoke test final:

- identidad CMMS 2.0 / Functional Lab;
- 10 destinos del Functional Journey;
- `Gallery@2.15.0` con selección local y estados active/hover/pressed;
- caso activo P-101;
- sin `CustomProperties:`;
- sin globals;
- sin assets externos;
- sin navegación host todavía.

## 4. Gate RC1

```text
[ ] Source Code aceptado
[ ] una instancia nueva se inserta sin cerrar Studio
[ ] la selección visual cambia al pulsar filas
[ ] Save estable
[ ] Reopen estable
[ ] sin nuevos errores de App Checker atribuibles al componente
[ ] Visual QA suficiente para avanzar
```

## 5. Continuidad

> Si RC1 pasa, se considera recuperado `cmp_FL_SidebarPro` a nivel visual/instance-safe y se avanza inmediatamente a `F01-00B cmp_FL_PageHeaderPro`. El contrato público del Sidebar se añadirá solo cuando la navegación real del App Shell lo requiera.
