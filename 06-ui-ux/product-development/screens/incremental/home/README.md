# CMMS 2.0 — scr_Home / S01 Studio Gate

**Fecha:** 2026-08-23  
**Estado:** `S01 CANDIDATE / PENDING POWER APPS STUDIO GATE`  
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

## Gate Studio

1. Si ya existe `scr_Home`, renombrarla temporalmente a `scr_Home_Reference`.
2. Crear una nueva pantalla desde **Source Code**.
3. Pegar el YAML completo de `scr_Home_S01_Candidate.pa.yaml`.
4. Confirmar que no aparecen errores de Source Code Schema ni Power Fx.
5. Confirmar que el sidebar se expande y colapsa.
6. Confirmar que no existe overlap/clipping a ancho desktop normal.
7. Confirmar que el header y las cards son legibles.
8. Capturar una imagen completa de Studio.

## Secuencia

```text
S01 STRUCTURAL CANDIDATE
→ Studio Gate
→ S01 PASS
→ C01 Shared Component extraction / validation
→ C02 Home content primitives
→ I01 Project Context integration
```

No declarar `VISUAL_APPROVED` ni sustituir navegación productiva hasta superar los gates correspondientes.
