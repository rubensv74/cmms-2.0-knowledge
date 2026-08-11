# FL-SC-004 — Defaults Color de componentes renderizan negro en Studio

**Fecha:** 2026-08-11  
**Estado:** patrón correctivo publicado / validación visual Studio pendiente

## Efecto observado

Durante la validación integrada del Functional Lab, varias superficies reutilizables aparecen con fondo negro y textos con contraste incorrecto aunque sus definiciones Source Code contienen `ColorValue(...)` claros como defaults de `CustomProperties` de tipo `Color`.

Captura afectada: `scr_FL_AMEF`.

Bloques observados:

- `cmp_FL_PageHeaderPro`;
- `cmp_FL_ProcessRailPro`;
- `cmp_FL_LineagePanelPro`;
- `cmp_FL_RiskMatrixPro`;
- `cmp_FL_DecisionPanelPro`;
- textos del `cmp_FL_SidebarPro` potencialmente afectados por el mismo patrón.

Los controles definidos directamente en la pantalla conservan sus colores correctos. `cmp_FL_GatePanelPro`, que calcula estados con colores explícitos, no presenta el mismo efecto visual.

## Interpretación permitida

```text
Color CustomProperty default esperado    #FFFFFF / #0F172A / etc.
valor visual materializado en instancia   negro en varios bloques
```

Esto demuestra el **efecto de render observado**, pero no demuestra la causa interna de Power Apps.

No se declara que `CustomProperties` Color sean incompatibles en general: PULSE contiene contraejemplos positivos.

## Patrón correctivo candidato

Mantener el contrato público de colores, pero introducir un booleano:

```text
UseHostTheme = false por defecto
```

La UI interna utiliza entonces una paleta explícita y determinista del Functional Lab:

```text
If(UseHostTheme, HostColorProperty, ColorValue("#..."))
```

La tematización externa sigue disponible cuando el host activa explícitamente `UseHostTheme=true`.

## Componentes corregidos

```text
cmp_FL_SidebarPro
cmp_FL_PageHeaderPro
cmp_FL_ProcessRailPro
cmp_FL_LineagePanelPro
cmp_FL_DecisionPanelPro
cmp_FL_RiskMatrixPro
cmp_FL_ApplicabilityMatrixPro
```

No modificados:

```text
cmp_FL_TreePro       comportamiento previo utilizable en smoke Activos
cmp_FL_GatePanelPro  colores de estado explícitos y visibles en captura
```

## Validación estática

Los candidatos se comprobaron antes de publicación:

- parse YAML local: PASS;
- sin `Label@2.5.1` con `Radius*`;
- sin `Classic/Button@2.2.0` con `AccessibleLabel`;
- sin `GroupContainer` dentro de plantillas Gallery;
- sin fórmulas inline con literal `: `;
- contratos públicos funcionales preservados;
- pantallas consumidoras no requieren cambios.

## Gate de validación

Estado actual:

```text
PASS_STATIC          PASS
DEFINITION_ACCEPTED  pendiente de repaste/reemplazo en Studio
INSTANCE_SAFE        pendiente para las nuevas revisiones
VISUAL_QA_VALIDATED  pendiente
```

Prueba única requerida:

1. sustituir los 7 componentes por las revisiones safe-palette;
2. guardar la app;
3. abrir Home y entrar en el caso P-101 por el flujo normal;
4. navegar hasta AMEF;
5. confirmar que cabecera, Process Rail, lineage, matriz y decisión recuperan la paleta clara y legible.

No volver a copiar las 25 pantallas para esta incidencia.