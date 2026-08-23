# CMMS 2.0 — Shared UI Foundation RC0

**Fecha:** 2026-08-23  
**Estado:** `FOUNDATION RC0 / INDIVIDUAL COMPONENTS STUDIO VALIDATED`  
**Siguiente gate:** integración conjunta en `scr_Home I01`

## Componentes validados

| Componente | Estado | Uso previsto |
|---|---|---|
| `cmp_CMMS_PageHeaderPro_RC0` | `PASS / STUDIO VALIDATED` | identidad de página y status |
| `cmp_CMMS_ProjectContextPro_RC0` | `PASS / STUDIO VALIDATED` | selección/contexto de proyecto |
| `cmp_CMMS_StatePanelPro_RC0` | `PASS / STUDIO VALIDATED` | READY / LOADING / EMPTY / ERROR / UNAVAILABLE / NO_CONTEXT |
| `cmp_CMMS_SidebarPro_RC0` | `PASS / STUDIO VALIDATED` | navegación transversal y contexto lateral |

## Principios de integración

1. El host conserva autoridad sobre navegación, proyecto aceptado, carga de datos y permisos.
2. Los componentes exponen intención y estado; no ejecutan lógica de negocio.
3. Ningún componente conoce SQL, Power Automate ni futura API.
4. Los datos sintéticos usados en gates son contratos controlados, no datos productivos.
5. `scr_Home S01` queda congelada como referencia/rollback.
6. La adopción conjunta se valida primero en `scr_Home I01` antes de declarar esta foundation canónica para nuevas pantallas.

## Próximo incremento

`I01 — Home Shared Foundation Integration`

Objetivo: demostrar coordinación real entre los cuatro primitives.

Flujo esperado:

```text
NO PROJECT
   ↓ user selects synthetic project
ProjectContext.OnProjectChange
   ↓ host accepts pending project
varHomeProjectCode / Name / Id
   ↓
Sidebar footer updates
PageHeader shows PROJECT READY
StatePanel changes NO_CONTEXT → READY
```

También debe validarse `Sidebar.OnToggleCollapse` sin alterar el estado de proyecto.

## Promoción

La foundation no pasa todavía a `CANONICAL` solo por validaciones aisladas. Requiere:

`I01 PASS / STUDIO VALIDATED`

Después podrá usarse como base obligatoria para Project Setup y siguientes pantallas.