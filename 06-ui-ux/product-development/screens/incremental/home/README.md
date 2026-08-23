# CMMS 2.0 — scr_Home / S01 Studio Gate

**Fecha:** 2026-08-23  
**Estado:** `S01 PASS / STUDIO VALIDATED`  
**Método:** `CREATE_NEW_SCREEN`

## Declaración

### PRIMARY_USER_TASK

Entrar en CMMS 2.0, identificar el contexto de proyecto y orientarse hacia las áreas principales del producto sin asumir capacidades todavía no implementadas.

### SUCCESS_CRITERION

Al abrir `scr_Home`, el usuario puede identificar CMMS 2.0, comprobar si existe contexto de proyecto, reconocer las grandes áreas del producto y entender que `Project Setup` es el siguiente bloque funcional.

### PRIMARY_ARCHETYPE

`Operational Control Tower`

### SECONDARY_PATTERNS

- Product Navigation Shell;
- Project Context;
- State / Readiness Surface;
- Progressive Disclosure.

## PREMIUM_COMPONENTS

CMMS 2.0 todavía no dispone de una biblioteca de componentes compartidos validada en Studio equivalente a AssetPlan.

### REUSE

- tokens `gblTheme` y `gblLayout` validados en `SHELL-C01`.

### EXTEND_SHARED

- ninguno en S01.

### CREATE_SHARED — identificado, pendiente de gate

- `cmp_CMMS_SidebarPro`;
- `cmp_CMMS_ProjectContextPro`;
- `cmp_CMMS_PageHeaderPro`;
- `cmp_CMMS_StatePanelPro`.

**Gate real:** el ciclo de creación/importación de Canvas Components por Source Code todavía no está validado dentro de la app CMMS. S01 usa primitives locales deliberadamente y no los declara canónicos.

### LOCAL_ONLY

- `conHomeWorkspace`;
- boundary visual de S01;
- cards informativas de Project Context y Next Capability.

## Jerarquía

```text
L0 Context
Top bar → PROJECT / No project selected

L1 Page Identity
HOME
CMMS 2.0
Select a project and continue the maintenance configuration journey.

L2 Summary
S01 structural boundary + Project Context + Next Capability

L3 Workspace
Se añadirá cuando existan contratos reales de Home/Portfolio.
```

## Candidate

`06-ui-ux/product-development/screens/incremental/home/scr_Home_S01_Candidate.pa.yaml`

## Dependencia

La app debe conservar el `App.OnStart` de:

`06-ui-ux/product-development/shell/code/SHELL-C01-App-OnStart.powerfx`

S01 depende únicamente de `gblTheme`, `gblLayout`, `gblSidebarCollapsed` y `gblSelectedNavKey`.

## Qué incluye S01

- shell premium;
- sidebar expandible/colapsable;
- mapa de áreas del producto como navegación orientativa;
- top bar;
- project-context placeholder;
- page header;
- boundary de candidato;
- dos cards de orientación sin datos inventados.

## Qué NO incluye S01

- selector de proyecto real;
- Portfolio KPIs;
- Needs Attention real;
- búsqueda global;
- permisos;
- navegación productiva a otras pantallas;
- Project Setup;
- backend;
- métricas inventadas.

## Resultado Studio — 2026-08-23

`S01 PASS / STUDIO VALIDATED`

Validado mediante captura completa de Power Apps Studio:

1. Source Code importado sin errores de schema ni Power Fx visibles;
2. shell completo renderizado;
3. sidebar expandido estable;
4. top bar sin solapes;
5. jerarquía `L0 Context → L1 Page Identity → L2 Summary` legible;
6. banner de límite `S01 · STRUCTURAL CANDIDATE · NO PRODUCTION DATA CONNECTED` visible;
7. cards `Project Context` y `Next Capability` sin clipping;
8. módulos futuros visibles solo como orientación y deshabilitados;
9. ausencia de métricas, datos o acciones productivas ficticias;
10. composición desktop sin overlap accidental.

Evidencia formal:

`06-ui-ux/product-development/screens/incremental/home/S01_VALIDATION_EVIDENCE_2026-08-23.md`

## Secuencia

```text
S01 STRUCTURAL CANDIDATE
→ S01 PASS / STUDIO VALIDATED
→ C01 Shared Component extraction / validation
→ C02 Home content primitives
→ I01 Project Context integration
```

S01 no se declara todavía `VISUAL_APPROVED`. El siguiente bloque debe centrarse en extraer y validar primitives reutilizables sin alterar la geometría ya validada.
