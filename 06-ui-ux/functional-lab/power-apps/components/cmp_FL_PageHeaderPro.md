# cmp_FL_PageHeaderPro — Component Specification

**Status:** INSTANCE_SAFE PASS / COMFORTABLE_SCALE_QA_PENDING  
**Increment:** F01-00B  
**Purpose:** cabecera premium común para contextualizar cada workspace del CMMS 2.0 Functional Lab.

## 1. Responsibility

El PageHeader debe comunicar de un vistazo:

- workspace actual;
- arquetipo funcional;
- caso activo;
- posición dentro del journey;
- estado de revisión;
- progreso relativo.

No ejecuta lógica de negocio, no carga datos, no decide gates y no navega por sí mismo.

## 2. Referencias utilizadas

### Referencia visual

`rubensv74/app_pulse/power-apps/components/cmp_PageHeaderPro.pa.yaml`

Se reutiliza su gramática de cabecera SaaS: identidad de página + bloques contextuales + superficie limpia.

### Referencia contractual instance-safe

Para las `CustomProperties` se utilizan como referencia probada:

- `cmp_HeatMapPro` de PULSE;
- `cmp_FL_SidebarPro` RC2.

Patrón Input adoptado:

```text
PropertyKind
DisplayName
Description
DataType
Default
```

## 3. Public contract F01-00B

### Contexto

```text
WorkspaceCode       Text
Archetype           Text
Title               Text
Subtitle            Text
CaseCode            Text
CaseType            Text
JourneyPosition     Text
JourneyHint         Text
ReviewState         Text
ReviewHint          Text
ProgressCurrent     Number
ProgressTotal       Number
```

### Visual tokens

```text
SurfaceColor
SurfaceAltColor
BorderColor
TextColor
MutedTextColor
AccentColor
SuccessColor
SuccessTextColor
SuccessMutedTextColor
SuccessSoftColor
SuccessBorderColor
```

## 4. Runtime validation

Resultado observado en Power Apps Studio el 2026-08-10:

```text
DEFINITION_ACCEPTED  PASS
INSTANCE_SAFE        PASS
```

## 5. Visual QA

La primera composición con tres niveles por tarjeta produjo solapamiento. Se corrigió a dos niveles visibles:

```text
CURRENT CASE
P-101 · Centrifugal pump

JOURNEY
01 / 28 · Context

REVIEW STATE
Ready for review
```

La corrección fue validada visualmente por el usuario.

## 6. Comfortable base scale

Tras la validación visual se detectó que la escala tipográfica seguía siendo demasiado pequeña para una aplicación desktop con gran superficie disponible.

Se adopta como baseline del Functional Lab una densidad **Comfortable**, con aumento coordinado de tipografía y geometría:

```text
Eyebrow / labels       9–10
Primary title          22
Subtitle               11
Context values         11
Header height          132
Context card height     74
Progress track           3
```

La regla es aumentar texto y espacio conjuntamente; no ampliar únicamente `Size`.

El futuro control global `Aa` para `Normal / Comfortable / Large` pertenece al Premium App Shell y no se implementa como lógica local del Header.

## 7. Compatibility constraints

- `GroupContainer@1.5.0` para superficies y radios.
- `ModernText@1.0.0` con `AutoHeight=true`.
- `Rectangle@2.3.0` para progreso.
- sin `Label Radius*`.
- sin `Classic/Button AccessibleLabel`.
- sin SVG, globals ni assets externos.
- `CustomProperties` permitido con contrato completo basado en referencia `INSTANCE_SAFE`.
- `DEFINITION_ACCEPTED`, `INSTANCE_SAFE` y `VISUAL_QA_VALIDATED` son gates distintos.

## 8. Gate restante

```text
[x] DEFINITION_ACCEPTED
[x] INSTANCE_SAFE
[x] composición compacta sin solapamiento
[ ] Comfortable scale legible y sin clipping
[ ] Save/reopen estable
[ ] App Checker sin errores nuevos atribuibles
[ ] VISUAL_QA_VALIDATED
[ ] READY_FOR_INTEGRATION
```

Si la escala Comfortable pasa, se avanza a `F01-01 Premium App Shell Foundation` combinando `cmp_FL_SidebarPro` RC2 + `cmp_FL_PageHeaderPro`.
