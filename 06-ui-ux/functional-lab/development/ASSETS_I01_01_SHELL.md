# CMMS 2.0 — ASSETS I01-01 Shell

**Fecha:** 2026-08-24  
**Screen:** `scr_Assets_I01`  
**Incremento:** `I01-01`  
**Estado:** `READY_FOR_STUDIO`

## 1. Objetivo

Crear únicamente la superficie estructural premium de `Assets` dentro de la Canvas app real.

Al terminar debe existir:

```text
scr_Assets_I01
└─ conAssets_Root
   ├─ Sidebar existing component
   └─ conAssets_Content
      ├─ Project Context existing component
      ├─ Page Header existing component
      └─ conAssets_WorkspaceHost
```

No datos, filtros, grid, fixture, SQL, Flow ni escritura.

## 2. Archivos afectados

Repositorio documental:

```text
06-ui-ux/functional-lab/development/ASSETS_I01_01_SHELL.md
```

Canvas app real:

```text
new screen: scr_Assets_I01
```

No modificar componentes existentes en este incremento.

## 3. Componentes

### Reutilizar

```text
cmp_CMMS_SidebarPro_RC0
cmp_CMMS_ProjectContextPro_RC0
cmp_CMMS_PageHeaderPro_RC0
```

### No usar todavía

```text
cmp_CMMS_StatePanelPro_RC0
```

Se incorpora en I01-02 al modelar estados.

### No crear todavía

```text
FilterBar
DataGrid
IconPro
KPI
```

## 4. Integración en Power Apps Studio

### Paso 1 — nueva screen

Crear una screen nueva y renombrar:

```text
scr_Assets_I01
```

Propiedad:

```powerfx
Fill = gblTheme.Canvas
```

No añadir lógica `OnVisible` de datos.

### Paso 2 — root responsive

Insertar **Horizontal container** y renombrar:

```text
conAssets_Root
```

Objetivo de propiedades:

```powerfx
Width  = Parent.Width
Height = Parent.Height
```

Sin padding ni gap estructural entre Navigation y Content.

El container debe crecer con la screen; no fijar 1366×768.

### Paso 3 — Sidebar existente

Insertar una instancia de:

```text
cmp_CMMS_SidebarPro_RC0
```

dentro de `conAssets_Root`.

No editar la definición del componente.

No añadir todavía una ruta `assets` si el componente no expone una interfaz ya gobernada para ello. La activación/navegación se valida en I01-06.

La anchura debe continuar gobernada por la foundation existente (`gblSidebarCollapsed` / `gblLayout`) si el componente ya lo hace.

### Paso 4 — Content container

Insertar **Vertical container** dentro de `conAssets_Root` y renombrar:

```text
conAssets_Content
```

Debe ocupar el espacio restante.

Usar padding gobernado por los tokens existentes cuando el layout actual lo permita:

```text
gblLayout.PagePaddingDesktop
gblLayout.PagePaddingCompact
```

No crear números paralelos como contrato local.

### Paso 5 — Project Context

Insertar instancia de:

```text
cmp_CMMS_ProjectContextPro_RC0
```

como primer bloque de `conAssets_Content`.

En este incremento se conserva su contrato actual. No modificar el componente para añadir Asset Model version o freshness.

### Paso 6 — Page Header

Insertar instancia de:

```text
cmp_CMMS_PageHeaderPro_RC0
```

Configurar, si las propiedades existen con ese contrato físico:

```text
Title    = Assets
Subtitle = Explore and manage maintainable assets
```

Si los nombres físicos de las custom properties difieren, detener **solo este ajuste** y capturar el panel de propiedades del componente. No modificar su definición para forzar compatibilidad.

### Paso 7 — Workspace host

Insertar **Vertical container** y renombrar:

```text
conAssets_WorkspaceHost
```

Debe ocupar el espacio funcional restante.

En I01-01 permanece vacío salvo, opcionalmente, un label temporal de desarrollo:

```text
ASSETS — workspace host
```

Ese label no es parte del producto y se elimina al entrar I01-02/I01-03.

## 5. Qué conservar

No tocar:

```text
App.OnStart
gblTheme
gblLayout
gblSidebarCollapsed
gblSelectedNavKey
gblShellReady
existing screens
existing component definitions
```

No modificar `Screen1` ni reutilizarla como Assets.

## 6. Validación en Studio

Comprobar:

```text
[ ] scr_Assets_I01 existe
[ ] screen resize no rompe Root
[ ] Sidebar visible y no duplicada
[ ] Project Context renderiza
[ ] Page Header renderiza
[ ] Workspace ocupa el área restante
[ ] no hay horizontal scroll accidental
[ ] no se han creado variables de theme/layout nuevas
[ ] no hay data source ni collections nuevas
[ ] App Checker no introduce error estructural atribuible a Assets
```

Probar al menos:

- ancho desktop normal;
- reducir el ancho del editor y comprobar que el root sigue respondiendo.

## 7. Criterio PASS

```text
ASSETS_I01_01_SHELL_PASS
```

se alcanza cuando:

1. la screen está integrada en la app real;
2. reutiliza la foundation existente;
3. responde al resize;
4. no modifica componentes compartidos;
5. no introduce errores estructurales nuevos;
6. Content/Workspace están preparados para el siguiente incremento.

## 8. Stop conditions

No avanzar a I01-02 si:

- PageHeader/ProjectContext no pueden instanciarse;
- aparece clipping estructural;
- Sidebar requiere modificar su definición para coexistir con la screen;
- App Checker muestra un error nuevo causado por el Shell.

En esos casos se corrige únicamente I01-01.
