# cmp_FL_PageHeaderPro — Component Specification

**Status:** INSTANCE_SAFE PASS / VISUAL_QA_CORRECTION_PENDING  
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

## 4. Runtime validation

Resultado observado en Power Apps Studio el 2026-08-10:

```text
DEFINITION_ACCEPTED  PASS
INSTANCE_SAFE        PASS
```

La instancia completa se insertó y renderizó sin cierre de Studio.

## 5. Visual QA finding

La primera instancia estable mostró solapamiento vertical en las tres tarjetas compactas al intentar representar tres niveles de texto dentro de 62 px.

Patrón observado:

```text
label
value
hint
```

con `ModernText@1.0.0` y `AutoHeight=true`.

El correctivo adoptado evita compensar el problema con alturas arbitrarias:

```text
compact context card
→ máximo dos niveles visibles
→ label
→ value + contexto compuesto
```

Render objetivo:

```text
CURRENT CASE
P-101 · Centrifugal pump

JOURNEY
01 / 28 · Context

REVIEW STATE
Ready for review
```

`ReviewHint` permanece disponible en el contrato para uso futuro, pero no se fuerza dentro de la tarjeta compacta.

## 6. Compatibility constraints

- `GroupContainer@1.5.0` para superficies y radios.
- `ModernText@1.0.0` con `AutoHeight=true`.
- `Rectangle@2.3.0` para progreso.
- sin `Label Radius*`.
- sin `Classic/Button AccessibleLabel`.
- sin SVG, globals ni assets externos.
- `CustomProperties` permitido con contrato completo basado en referencia `INSTANCE_SAFE`.
- `DEFINITION_ACCEPTED`, `INSTANCE_SAFE` y `VISUAL_QA_VALIDATED` son gates distintos.

## 7. Validation gate restante

```text
[x] DEFINITION_ACCEPTED
[x] CustomProperties visibles y con defaults correctos
[x] INSTANCE_SAFE en pantalla aislada
[ ] Save/reopen estable tras corrección visual
[ ] sin clipping ni solapamiento
[ ] jerarquía título/subtítulo/contextos clara
[ ] context cards legibles
[ ] estado de revisión semántico
[ ] progreso visible y proporcional
[ ] App Checker sin errores nuevos atribuibles
[ ] VISUAL_QA_VALIDATED
[ ] READY_FOR_INTEGRATION
```

Si la corrección visual pasa, se avanza directamente a `F01-01 Premium App Shell Foundation` combinando `cmp_FL_SidebarPro` RC2 + `cmp_FL_PageHeaderPro`.
