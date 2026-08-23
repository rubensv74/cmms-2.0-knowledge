# CMMS 2.0 — Premium Screen Standard V1

**Estado:** `ACTIVE / PRODUCT-WIDE / PRE-STUDIO-GEOMETRY`  
**Ámbito:** pantallas y workspaces CMMS 2.0 / Functional Lab.

## Propósito

Definir qué hace que cualquier superficie nueva pertenezca inequívocamente a CMMS 2.0 sin obligar a todos los workspaces a usar el mismo layout.

Fuentes canónicas:
- `functional-lab/design-system.md`;
- `functional-lab/architecture.md`;
- este estándar;
- `CMMS_PAGE_HEADER_HIERARCHY_V1.md`;
- `CMMS_COMPONENT_CATALOG_V1.md`.

## Regla de diseño

Antes del primer bloque de una pantalla declarar:
`PRIMARY_USER_TASK`, `SUCCESS_CRITERION`, `PRIMARY_ARCHETYPE`, `SECONDARY_PATTERNS`, `PREMIUM_COMPONENTS`.

Arquetipos permitidos según necesidad: Object 360, Operational Review Workspace, Data Explorer, Workflow Builder, Configuration Studio, Audit Timeline, Exception Resolution Queue y Operational Control Tower.

## Anatomía común

```text
ROOT
├── Navigation
└── Content
    ├── Page Identity
    ├── Context Strip
    ├── Summary / Gate (optional)
    ├── Functional Workspace
    └── Overlay Layer
```

La geometría exacta se congela después del primer Premium App Shell validado en Studio. Hasta entonces no inventar píxeles como contrato.

## Principios premium

- shell común, arquetipos distintos;
- jerarquía antes que decoración;
- densidad operacional controlada;
- color semántico, no ornamental;
- estados READY/LOADING/EMPTY/ERROR/BLOCKED/WARNING explícitos cuando apliquen;
- sistema y decisión humana visualmente distinguibles;
- gate siempre explica por qué bloquea y qué falta;
- accesibilidad, foco, hover/selected/disabled coherentes;
- responsive strategy explícita;
- no reglas de negocio enterradas solo en fórmulas de pantalla.

## Componentes

Orden obligatorio:
`REUSE_CMMS → ADAPT_VERIFIED_BASE → EXTEND_SHARED → CREATE_SHARED → LOCAL_ONLY`.

Todo gap reusable se convierte en componente compartido. Antes de adoptarlo como canónico debe tener contrato, origen/provenance y estado de validación real.

## Visual Gate

Una pantalla no pasa por sintaxis/App Checker únicamente. Revisar además jerarquía, clipping/scroll accidental, contenido realista, estados, foco, geometría, densidad, componente compartido correcto y captura completa en Studio.

No declarar `VISUAL_APPROVED` mientras la pantalla no exista y sea revisada en la herramienta real.
