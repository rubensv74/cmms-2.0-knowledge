# CMMS 2.0 Functional Lab — Auditoría de recuperación

**Fecha:** 2026-08-11  
**Estado:** recuperación controlada  
**Objetivo:** recuperar un punto cero fiable antes de seguir integrando pantallas.

## 1. Conclusión

El problema actual no es una única pantalla defectuosa. Durante F03/F04 se mezclaron demasiadas variables a la vez:

- tipografía;
- paleta;
- geometría;
- componentes reutilizables;
- shell;
- navegación;
- lógica por etapas;
- integración de RiskMatrix;
- AMEF como pantalla compleja de referencia.

Esto eliminó la capacidad de atribuir un fallo a un cambio concreto.

La arquitectura funcional D-01…D-14 no se revierte. La recuperación afecta a la capa visual/Power Apps que se modificó después de los smoke tests ya superados.

## 2. Evidencia Studio que sigue siendo válida

Confirmaciones realizadas antes de la deriva visual:

```text
HOME OK
ACTIVOS OK
BIBLIOTECA AMEF OK
APLICACIÓN MULTI-ACTIVO OK
```

Estas pruebas demuestran que el bootstrap, el modelo funcional y los primeros recorridos funcionaron en Studio en ese momento.

No implican que las mismas pantallas sigan visualmente/runtime idénticas después de modificar componentes compartidos.

## 3. Hallazgo clave — Home no cambió; cambiaron sus dependencias

`scr_FL_Home.pa.yaml` tiene como última revisión funcional:

```text
34059bf4beaf7f74e2245ad45959114ae8357cfc
ui: align Home bootstrap and product entry with library application model
```

Ese archivo no volvió a cambiar durante F03/F04.

Home consume:

```text
cmp_FL_SidebarPro
cmp_FL_PageHeaderPro
cmp_FL_LineagePanelPro
```

Los tres sí se modificaron después del smoke `HOME OK`.

Por tanto:

> El último archivo Home y el último conjunto de componentes del repositorio NO representan el mismo estado que fue validado en Studio.

## 4. Punto cero recuperable — ensamblaje Home validado

Se define como **RECOVERY BASELINE R0** el ensamblaje existente antes de los experimentos de paleta/readability:

| Elemento | Commit de referencia | Motivo |
|---|---|---|
| `scr_FL_Home.pa.yaml` | `34059bf4beaf7f74e2245ad45959114ae8357cfc` | Home validado con bootstrap alineado |
| `cmp_FL_SidebarPro.pa.yaml` | `f322b7e07afa0975b7230a757c709989cbb04511` | RC2 basado en patrón HeatMap; después documentado como validado |
| `cmp_FL_PageHeaderPro.pa.yaml` | `f46f2f33f308d1ff0a3d02a7fa89fa027446e9b7` | baseline español anterior a safe-palette/readability experiments |
| `cmp_FL_LineagePanelPro.pa.yaml` | `408a57e7aaadd575d494a0bc8a21612f8c72b4b4` | versión que existía cuando se validó Home |

Este baseline es el punto de partida para recuperar **una primera pantalla real y estable**.

No se declara que su tipografía final sea suficiente; sí que es el conjunto correcto desde el que volver a aplicar mejoras de forma controlada.

## 5. Qué queda congelado

No modificar durante la recuperación R0:

```text
modelo de dominio D-01…D-14
bootstrap funcional de Home
colecciones/datos P-101
FLH / Taxonomía / ADR / Criticidad / Asset360
Biblioteca AMEF / FmeaRevision
AssetApplication / aplicación multi-activo
TreePro
ApplicabilityMatrixPro
```

Los smoke tests previos se conservan como evidencia histórica.

## 6. Qué queda fuera de baseline

Hasta que Home vuelva a estar cerrado visualmente, quedan **experimentales / no propagables**:

```text
F03 AMEF Readability Reference
F04 AMEF Final Integration
scr_FL_AMEF stage-focused RC2
cambios transversales de safe palette
cambios transversales de typography en componentes
ProcessRail readability experiments
DecisionPanel readability experiments
GatePanel readability experiments
Lineage readability experiments
```

No deben utilizarse como patrón para las otras 24 pantallas.

## 7. AMEF — referencia de recuperación, no pantalla base

Último estado pre-F03 del screen:

```text
scr_FL_AMEF.pa.yaml
81b50eb6ac61554695d922634ec62117d285ba4b
ui: separate asset criticality from FMEA risk assessment
```

Último RiskMatrix pre-F03:

```text
cmp_FL_RiskMatrixPro.pa.yaml
756bd41d5cf520c0f513772566af25e644af6f7f
hardening(risk-matrix): use validated labels for dynamic axes
```

Estos commits se conservan únicamente como **fallback técnico**. AMEF no volverá a ser el banco de pruebas del sistema visual.

La versión premium actual de RiskMatrix puede mantenerse como experimento aislado, pero no se integra en una pantalla hasta cerrar el shell.

## 8. Plan de recuperación — tres bloques

### R0-1 — Primera pantalla: Home

Restaurar el ensamblaje R0 y ejecutar un solo smoke:

```text
Home abre
→ sin errores rojos
→ navegación principal visible
→ P-101 cargado
→ bootstrap intacto
```

Resultado esperado:

```text
HOME BASELINE PASS
```

### R0-2 — Cerrar el sistema visual únicamente en Home

Sobre el baseline funcional, resolver solo:

```text
tipografía legible
sidebar
page header
lineage
spacing/paleta
```

No añadir lógica de negocio ni nuevos componentes.

Target:

```text
1366×768
100% zoom
texto visible mínimo 11
Comfortable
```

Una única validación visual integrada de Home.

Resultado esperado:

```text
HOME VISUAL FOUNDATION PASS
```

### R0-3 — Segunda pantalla simple antes de AMEF

Aplicar la foundation aprobada a `scr_FL_FmeaLibrary`, ya validada funcionalmente.

Si Home + FmeaLibrary pasan con el mismo shell, se considera que existe un patrón propagable.

AMEF solo se retoma después.

## 9. Regla de control a partir de ahora

No volver a cambiar simultáneamente:

```text
shell + componente + pantalla + lógica + navegación
```

Cada incremento debe declarar qué capa cambia.

Para Visual Foundation:

```text
funcionalidad = congelada
layout/typography/theme = variable
```

Para una pantalla funcional posterior:

```text
visual foundation = congelada
lógica específica de pantalla = variable
```

## 10. Regla de promoción

Nada se propaga por estar en GitHub.

```text
SOURCE_VALID
→ STUDIO_ACCEPTED
→ RUNTIME_PASS
→ VISUAL_QA_PASS
→ CANONICAL
```

Solo `CANONICAL` puede utilizarse como referencia para otra pantalla.

## 11. Decisión inmediata

El siguiente trabajo no es AMEF.

Es:

> **recuperar Home como primera pantalla canónica y cerrar allí la foundation visual.**
