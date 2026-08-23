# CMMS 2.0 — Shared Component Library

**Estado:** `BOOTSTRAP / C01`
**Fecha:** 2026-08-23

Esta carpeta es la entrada canónica de componentes compartidos de CMMS 2.0.

## Lifecycle

`EXPERIMENTAL → RC0 → STUDIO_VALIDATED → CANONICAL`

Un componente no se considera canónico hasta superar importación y validación visual en Power Apps Studio.

## Regla obligatoria

Antes de crear UI local:

`REUSE → EXTEND_SHARED → CREATE_SHARED → LOCAL_ONLY`

## C01

Primer primitive en validación:

- `experimental/cmp_CMMS_PageHeaderPro_RC0.pa.yaml`

Objetivo: validar el dialecto `ComponentDefinitions` dentro de la app CMMS antes de extraer el resto de primitives identificados en `scr_Home S01`.

Siguientes candidatos, solo después del gate de Page Header:

- `cmp_CMMS_ProjectContextPro_RC0`
- `cmp_CMMS_StatePanelPro_RC0`
- `cmp_CMMS_SidebarPro_RC0`

## Referencias

El patrón de lifecycle y contratos se inspira en la biblioteca de componentes de AssetPlan, pero los componentes CMMS mantienen nombres, contratos y responsabilidades propios.
