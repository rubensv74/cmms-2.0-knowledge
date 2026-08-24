# CMMS 2.0 — ASSETS Incremental Build Plan

**Fecha:** 2026-08-24  
**Screen ID:** `AS-01`  
**Physical screen candidate:** `scr_Assets_I01`  
**Estado:** `READY_TO_BUILD_INCREMENTALLY`

## 1. Baselines aplicables

- `02-functional/asset-master/CMMS_ASSETS_LIST_FUNCTIONAL_BASELINE_V1.md`
- `02-functional/asset-master/CMMS_ASSETS_LIST_READ_CONTRACT_V1.md`
- `06-ui-ux/CMMS_ASSETS_LIST_UX_CONTRACT_V1.md`
- `06-ui-ux/CMMS_PREMIUM_SCREEN_STANDARD_V1.md`
- `06-ui-ux/functional-lab/development/AE6_S01_00_REALITY_AUDIT_2026-08-24.md`

## 2. Foundation física confirmada

En la app CMMS real ya existen:

```text
cmp_CMMS_SidebarPro_RC0
cmp_CMMS_ProjectContextPro_RC0
cmp_CMMS_PageHeaderPro_RC0
cmp_CMMS_StatePanelPro_RC0

gblTheme
gblLayout
gblSidebarCollapsed
gblSelectedNavKey
gblShellReady
```

La app es `Responsive`.

Baseline App Checker previo:

```text
Accessibility = 208
Performance   = 3
```

## 3. Mapa completo de incrementos

### I01-01 — Shell

Responsabilidad:

- crear `scr_Assets_I01`;
- root responsive;
- Sidebar existente;
- Project Context existente;
- Page Header existente;
- workspace host vacío;
- ninguna lectura de datos.

Gate:

```text
ASSETS_I01_01_SHELL_PASS
```

### I01-02 — Screen state + state surfaces

Responsabilidad:

- modelar `INITIAL / LOADING / READY / EMPTY / ERROR / UNAVAILABLE_SOURCE`;
- incorporar StatePanel existente;
- colección fixture todavía no productiva.

No filtros/grid funcionales todavía.

Gate:

```text
ASSETS_I01_02_STATE_PASS
```

### I01-03 — Synthetic read adapter

Responsabilidad:

- cargar fixture pequeño según `CMMS_ASSETS_LIST_READ_CONTRACT_V1`;
- probar múltiples Equipment Types, ubicaciones, estados y campos opcionales ausentes;
- validar conteos y shape.

Gate:

```text
ASSETS_I01_03_FIXTURE_PASS
```

### I01-04 — Filter/Search component

Responsabilidad:

- evaluar si existe componente reusable adecuado;
- si no existe, crear candidato `cmp_CMMS_FilterBarPro_RC0`;
- Search AssetCode/Description;
- filtros Equipment Type, Location, Lifecycle Status, Criticality;
- reset filters.

No escritura.

Gate:

```text
ASSETS_I01_04_FILTER_PASS
```

### I01-05 — Data surface

Responsabilidad:

- evaluar/crear `cmp_CMMS_DataGridPro_RC0` o patrón equivalente Modern Control;
- renderizar columnas baseline;
- Equipment Type icon ligero;
- explícito `—` en campos opcionales;
- empty/error no confundibles.

Gate:

```text
ASSETS_I01_05_DATA_EXPLORER_PASS
```

### I01-06 — Selection + Asset Detail navigation

Responsabilidad:

- selección de fila;
- acción `Open Asset`;
- contrato explícito de identidad hacia Asset Detail;
- navegación accesible;
- no modificar datos.

La activación del nav key `assets` en Sidebar se integra aquí o antes solo si el contrato del componente lo demuestra seguro.

Gate:

```text
ASSETS_I01_06_NAVIGATION_PASS
```

### I01-07 — Real read adapter

Responsabilidad:

- elegir fuente física real;
- aplicar project scope y permisos;
- delegación/paging según volumen;
- mapear respuesta al read contract;
- estados de error/source unavailable.

Gate arquitectónico real:

```text
PHYSICAL_ASSET_SOURCE + AUTHORIZATION MODEL
```

No implementar esta fase hasta que esa frontera esté confirmada.

Gate:

```text
ASSETS_I01_07_REAL_READ_PASS
```

### I01-08 — Create Asset entry point

Solo si el contrato de escritura y permisos existe.

Responsabilidad:

- acción Create Asset;
- Async Action Guard donde exista operación asíncrona/no repetible;
- no hacer Patch directo improvisado.

Puede diferirse sin bloquear la calidad de Assets como explorer.

Gate:

```text
ASSETS_I01_08_CREATE_ENTRY_PASS
```

### I01-09 — Premium pass

Responsabilidad:

- jerarquía;
- densidad;
- iconografía;
- spacing;
- typography;
- hover/selected/focus/disabled;
- responsive desktop/compact;
- states.

Gate:

```text
ASSETS_I01_09_VISUAL_PASS
```

### I01-10 — Hardening

Responsabilidad:

- App Checker delta;
- accessibility;
- performance;
- delegation warnings;
- security boundary;
- duplicate patterns;
- save/close/reopen;
- maintainability;
- regression shell/navigation.

Gate:

```text
ASSETS_I01_10_HARDENING_PASS
```

## 4. Dependencias y orden

```text
01 Shell
→ 02 State
→ 03 Fixture
→ 04 Filters
→ 05 Data Explorer
→ 06 Navigation
→ 07 Real read
→ 08 Write entry optional
→ 09 Premium
→ 10 Hardening
```

No saltar de Shell a SQL.

## 5. Component strategy

```text
REUSE:
  SidebarPro
  ProjectContextPro
  PageHeaderPro
  StatePanelPro

VALIDATE/CREATE LATER:
  FilterBarPro
  DataGridPro
  IconPro if justified

LOCAL:
  screen root containers
  workspace host
```

## 6. Modern Controls rule

Usar Modern Controls siempre que sean estables para el contrato real.

Classic Controls solo con limitación comprobada y documentada en el incremento correspondiente.

## 7. Gate actual

No existe gate que bloquee `I01-01 Shell`.

El primer gate arquitectónico relevante previsto aparece en `I01-07`, al conectar la fuente física de Assets.
