# CMMS 2.0 — AE6-S01-00 App Reality Audit

**Fecha:** 2026-08-24  
**Incremento:** `AE6-S01-00`  
**Fuente de evidencia:** Power Apps Studio real — capturas aportadas durante el gate  
**Estado:** `PASS / S01-00_REALITY_PASS`

## 1. Objetivo

Confirmar la realidad de la Canvas app antes de crear `AS-02 Asset Detail`, evitando generar YAML, componentes o fórmulas contra una app supuesta.

## 2. Evidencia confirmada

### Canvas app real

```text
App: CMMS
Mode: Editing
Environment visible: ENV PRE TR 162
```

La app existe y está abierta en Power Apps Studio real.

### Screens observadas

```text
Screen1
  └─ ScreenContainer1

scr_CMMS_ComponentLab_C04
scr_Home_I01
scr_ProjectProfile_S01
scr_MaintenanceConfiguration_S01
scr_RiskProfile_S01
```

Conclusión:

- no se parte de una app vacía;
- existe ya una foundation funcional/premium incremental;
- `Asset Detail` debe añadirse como nueva screen gobernada, no como sustitución de `Screen1` ni como modificación de una pantalla existente sin contrato.

### Components observados

```text
Component1
cmp_CMMS_PageHeaderPro_RC0
cmp_CMMS_ProjectContextPro_RC0
cmp_CMMS_StatePanelPro_RC0
cmp_CMMS_SidebarPro_RC0
```

Conclusión:

- `PageHeader`, `ProjectContext`, `StatePanel` y `Sidebar` ya existen físicamente dentro de la app;
- esos componentes no deben recrearse desde cero para AE6-S01;
- deben auditarse/adaptarse solamente si el contrato de Asset Detail exige un delta real;
- `Component1` parece un componente vacío/default y no debe convertirse en dependencia de S01.

### Display / layout observado

Power Apps Studio > Settings > Display confirma:

```text
App layout        = Responsive
Orientation       = managed by responsive layout
Size preset       = 16:9 Default (disabled by responsive mode)
Lock aspect ratio = Off
Lock orientation  = Off
```

Conclusión:

- `Asset Detail` no debe diseñarse contra una resolución fija como contrato principal;
- deben evitarse coordenadas rígidas como baseline de arquitectura;
- los contenedores y componentes deberán responder al ancho disponible;
- el gate visual sí podrá usar una resolución desktop representativa para evidencia, pero no como única geometría soportada.

### App Checker baseline observado

Power Apps Studio > App checker muestra el siguiente baseline previo a AE6-S01:

```text
Accessibility = 208 findings
Performance   = 3 findings
Formulas      = no counter visible in summary
Runtime       = no counter visible in summary
Data source   = no counter visible in summary
```

Regla de interpretación:

- `208` y `3` se registran como deuda preexistente de la app;
- ausencia de contador visible en la captura **no se interpreta como cero confirmado**;
- AE6-S01 no debe asumir como propia esta deuda baseline;
- durante AE-G6 se comparará el App Checker posterior contra este punto de partida y se revisarán específicamente los hallazgos nuevos atribuibles a `scr_AssetDetail_S01` y sus componentes.

### Power Fx authoring syntax / locale behavior

La captura de `App.OnStart` confirma la sintaxis real usada por esta app:

```text
Function arguments / record fields: comma
Instruction separator: semicolon
Decimal separator in literals observed: period-compatible numeric syntax
```

Ejemplos reales observados:

```powerfx
Set(gblTheme, { Canvas: ColorValue("#F6F8FB"), ... });
Set(gblLayout, { SidebarExpanded: 248, SidebarCollapsed: 72, ... });
Set(gblSidebarCollapsed, false);
Set(gblSelectedNavKey, "home");
Set(gblShellReady, true);
```

Para los incrementos AE6 se usará este mismo estilo de Power Fx. No convertir las fórmulas a la variante local que usa `;` como separador de argumentos o `;;` como encadenado.

### Foundation global ya existente

`App.OnStart` confirma globals físicos que deben reutilizarse:

```text
gblTheme
  Canvas
  Sidebar
  SidebarHover
  SidebarSelected
  Surface
  Border
  TextPrimary
  TextSecondary
  TextMuted
  Primary
  PrimaryHover
  Success
  Warning
  Danger
  Info

gblLayout
  SidebarExpanded = 248
  SidebarCollapsed = 72
  TopBarHeight = 64
  PagePaddingDesktop = 24
  PagePaddingCompact = 16
  RadiusCard = 12
  GapMajor = 16

gblSidebarCollapsed
gblSelectedNavKey
gblShellReady
```

Regla:

- `scr_AssetDetail_S01` reutiliza esta foundation;
- no crear `gblAE6Theme`, `gblAssetLayout` o equivalentes paralelos salvo gap contractual real;
- los nuevos componentes Asset Experience deben consumir tokens existentes donde encajen y proponer extensiones gobernadas solo cuando falte un token real.

## 3. Impacto sobre el plan AE6-S01

El bloque S01-02 puede reutilizar directamente la foundation física instalada:

```text
cmp_CMMS_SidebarPro_RC0
cmp_CMMS_ProjectContextPro_RC0
cmp_CMMS_PageHeaderPro_RC0
```

`cmp_CMMS_StatePanelPro_RC0` queda disponible para estados localizados.

Por tanto, la primera implementación no debe importar/copiar los componentes AssetPlan equivalentes. AssetPlan sigue siendo referencia de diseño/adaptación, no source físico de esta app.

La composición de `scr_AssetDetail_S01` deberá construirse sobre containers responsive y no sobre una maqueta 1366x768 hard-coded.

## 4. Checks S01-00

### P1 — App Checker baseline

**PASS / BASELINE_CAPTURED**.

Baseline:

```text
Accessibility = 208
Performance   = 3
```

Los demás grupos no muestran contador visible en el resumen capturado.

### P2 — Authoring locale / syntax

**PASS / CONFIRMED FROM REAL APP.ONSTART**.

```text
arguments = comma
instructions = semicolon
```

### P3 — Source-code reality

Layout responsive confirmado.

La disponibilidad de edición Source Code/YAML queda `OPTIONAL / NOT REQUIRED_FOR_S01-01`.

No bloquea el siguiente incremento porque S01-01 se ejecutará mediante Power Fx pegado directamente en Studio.

## 5. Gate final

```text
CANVAS APP EXISTS              = PASS
EXISTING SCREEN INVENTORY      = PASS
CORE COMPONENT INVENTORY       = PASS
RESPONSIVE LAYOUT              = PASS
LOCK ASPECT RATIO              = OFF / CONFIRMED
LOCK ORIENTATION               = OFF / CONFIRMED
APP CHECKER BASELINE           = PASS / CAPTURED
AUTHORING SYNTAX                = PASS / CONFIRMED
GLOBAL FOUNDATION              = PASS / INVENTORIED
SOURCE-CODE MECHANISM          = OPTIONAL / PENDING

S01-00_REALITY_PASS            = PASS
```

## 6. Siguiente acción

Crear una nueva screen responsive gobernada:

```text
scr_AssetDetail_S01
```

Después iniciar `S01-01 — Fixture state only` pegando el bloque Power Fx preparado en la propiedad `OnVisible` de esa nueva screen, no en `App.OnStart`.

Razón:

- aislar el incremento;
- no contaminar el startup global;
- facilitar repetición del fixture al navegar a la pantalla;
- permitir retirar el fixture en S02 sin tocar la foundation global.
