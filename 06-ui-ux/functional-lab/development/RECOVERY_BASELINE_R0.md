# Functional Lab — Recovery Baseline R0

**Propósito:** disponer de un punto cero reproducible antes de continuar la Visual Foundation.

## Ensamblaje Home validado

### Pantalla

- `scr_FL_Home.pa.yaml`
- commit: `34059bf4beaf7f74e2245ad45959114ae8357cfc`
- fuente histórica:
  https://github.com/rubensv74/cmms-2.0-knowledge/blob/34059bf4beaf7f74e2245ad45959114ae8357cfc/06-ui-ux/functional-lab/power-apps/screens/scr_FL_Home.pa.yaml

### Sidebar

- `cmp_FL_SidebarPro.pa.yaml`
- commit: `f322b7e07afa0975b7230a757c709989cbb04511`
- fuente histórica:
  https://github.com/rubensv74/cmms-2.0-knowledge/blob/f322b7e07afa0975b7230a757c709989cbb04511/06-ui-ux/functional-lab/power-apps/components/cmp_FL_SidebarPro.pa.yaml

### Page Header

- `cmp_FL_PageHeaderPro.pa.yaml`
- commit: `f46f2f33f308d1ff0a3d02a7fa89fa027446e9b7`
- fuente histórica:
  https://github.com/rubensv74/cmms-2.0-knowledge/blob/f46f2f33f308d1ff0a3d02a7fa89fa027446e9b7/06-ui-ux/functional-lab/power-apps/components/cmp_FL_PageHeaderPro.pa.yaml

### Lineage

- `cmp_FL_LineagePanelPro.pa.yaml`
- commit: `408a57e7aaadd575d494a0bc8a21612f8c72b4b4`
- fuente histórica:
  https://github.com/rubensv74/cmms-2.0-knowledge/blob/408a57e7aaadd575d494a0bc8a21612f8c72b4b4/06-ui-ux/functional-lab/power-apps/components/cmp_FL_LineagePanelPro.pa.yaml

## Fallback AMEF pre-F03

Estos archivos NO forman parte de la primera recuperación. Se guardan para evitar perder el último estado anterior a los experimentos F03/F04.

### AMEF screen

- commit: `81b50eb6ac61554695d922634ec62117d285ba4b`
- fuente histórica:
  https://github.com/rubensv74/cmms-2.0-knowledge/blob/81b50eb6ac61554695d922634ec62117d285ba4b/06-ui-ux/functional-lab/power-apps/screens/scr_FL_AMEF.pa.yaml

### RiskMatrix pre-F03

- commit: `756bd41d5cf520c0f513772566af25e644af6f7f`
- fuente histórica:
  https://github.com/rubensv74/cmms-2.0-knowledge/blob/756bd41d5cf520c0f513772566af25e644af6f7f/06-ui-ux/functional-lab/power-apps/components/cmp_FL_RiskMatrixPro.pa.yaml

## Regla de uso

1. no agregar copias nuevas de componentes en Studio;
2. cualquier recuperación se hace in situ, preservando identidad;
3. no restaurar AMEF durante R0-1;
4. primero recuperar y validar Home;
5. después cerrar Visual Foundation solo en Home;
6. usar `scr_FL_FmeaLibrary` como segunda pantalla de propagación;
7. AMEF vuelve al flujo únicamente cuando las dos anteriores estén canónicas.

## Gate R0-1

```text
Home abre sin errores rojos
P-101 se carga
Sidebar/Header/Lineage renderizan
navegación principal responde
bootstrap permanece intacto
```

Si pasa:

```text
HOME BASELINE PASS
```
