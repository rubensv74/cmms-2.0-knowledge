# cmp_FL_PageHeaderPro — Component Specification

**Status:** PENDING_STUDIO_VALIDATION  
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

El `cmp_PageHeaderPro` de PULSE tiene todavía un incidente histórico de instancia y no se usa como autoridad contractual.

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

No se simplifica el contrato por intuición.

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

Todos los Inputs se declaran siguiendo el patrón completo RC2/HeatMap.

No hay Outputs ni Events en esta primera versión porque el Header es informativo. Las acciones host se incorporarán únicamente cuando exista una necesidad funcional real.

## 4. Default Functional Lab context

```text
Workspace        WS-01
Archetype        Object 360
Title            Case & Context
Case             P-101 · Centrifugal pump
Journey          01 / 28
Review state     Ready for review
Progress         1 / 28
```

## 5. Compatibility constraints

- `GroupContainer@1.5.0` para superficies y radios.
- `ModernText@1.0.0` con `AutoHeight=true`.
- `Rectangle@2.3.0` para progreso.
- sin `Label Radius*`.
- sin `Classic/Button AccessibleLabel`.
- sin SVG, globals ni assets externos.
- `CustomProperties` permitido con contrato completo basado en referencia `INSTANCE_SAFE`.
- `DEFINITION_ACCEPTED` y `INSTANCE_SAFE` siguen siendo gates distintos.

## 6. Validation gate

Un único smoke test completo:

```text
[ ] DEFINITION_ACCEPTED
[ ] CustomProperties visibles y con defaults correctos
[ ] INSTANCE_SAFE en pantalla aislada
[ ] Save estable
[ ] Reopen estable
[ ] sin clipping ni mini-scrollbars
[ ] jerarquía título/subtítulo/contextos clara
[ ] context cards legibles
[ ] estado de revisión semántico
[ ] progreso visible y proporcional
[ ] App Checker sin errores nuevos atribuibles
[ ] VISUAL_QA_VALIDATED
```

Si pasa este gate se avanza directamente a `F01-01 Premium App Shell Foundation` combinando `cmp_FL_SidebarPro` RC2 + `cmp_FL_PageHeaderPro`.
