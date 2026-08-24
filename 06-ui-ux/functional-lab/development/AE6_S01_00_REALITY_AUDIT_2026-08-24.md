# CMMS 2.0 — AE6-S01-00 App Reality Audit

**Fecha:** 2026-08-24  
**Incremento:** `AE6-S01-00`  
**Fuente de evidencia:** Power Apps Studio real — capturas aportadas durante el gate  
**Estado:** `PARTIAL_PASS / APP_REALITY_CONFIRMED / APP_CHECKER_AND_LOCALE_PENDING`

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

## 4. Checks todavía pendientes para cerrar S01-00

### P1 — App Checker baseline

Pendiente capturar el estado actual de App Checker antes de introducir AE6-S01.

Necesitamos registrar:

```text
Errors
Warnings
Accessibility findings cuando se muestren
```

### P2 — Authoring locale

Pendiente confirmar el locale real usado por la app para fórmulas.

No inferirlo únicamente por el idioma de Studio o por una fórmula aislada.

### P3 — Source-code reality

Layout responsive ya confirmado.

Pendiente únicamente confirmar la disponibilidad real del mecanismo Source Code/YAML que vaya a usarse si se decide editar source en incrementos posteriores.

Esto no bloquea S01-01, que puede empezar con Power Fx pegado directamente en Studio después de cerrar App Checker baseline y locale.

## 5. Gate actual

```text
CANVAS APP EXISTS              = PASS
EXISTING SCREEN INVENTORY      = PASS
CORE COMPONENT INVENTORY       = PASS
RESPONSIVE LAYOUT              = PASS
LOCK ASPECT RATIO              = OFF / CONFIRMED
LOCK ORIENTATION               = OFF / CONFIRMED
APP CHECKER BASELINE           = PENDING
AUTHORING LOCALE               = PENDING
SOURCE-CODE MECHANISM          = OPTIONAL / PENDING

S01-00_REALITY_PASS            = NOT YET CLOSED
```

## 6. Siguiente acción manual

Abrir **App Checker** en la Canvas app sin modificar nada y capturar su estado actual.

Después se confirmará authoring locale y se cerrará `S01-00_REALITY_PASS`.

No crear todavía `scr_AssetDetail_S01` hasta registrar el App Checker baseline; así cualquier error posterior podrá atribuirse correctamente al nuevo incremento.
