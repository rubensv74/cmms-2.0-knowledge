# Functional Lab — Power Apps Source Code Compatibility

**Estado:** activo antes de cualquier YAML  
**Origen inicial:** lecciones transferibles confirmadas en `rubensv74/app_pulse`.  
**Modelo funcional vigente:** library-first v2.

## Gate obligatorio pre-YAML

Antes de redactar, corregir o publicar cualquier `.pa.yaml` del Functional Lab:

1. leer la versión vigente de este documento;
2. leer `00-governance/cmms-functional-lab-incremental-protocol.md`;
3. confirmar capa y objeto primario del bloque;
4. confirmar control y versión exactos;
5. comparar con ejemplos ya validados;
6. no asumir que un componente existe en la app porque exista en GitHub;
7. registrar cualquier error nuevo y convertirlo en regla preventiva.

Un YAML técnicamente válido que viola el modelo `Library → Asset Application → Execution Plan → Results` se considera inválido para el Functional Lab.

## Reglas heredadas de Pulse

Estas reglas se aplican cuando el Functional Lab utilice las mismas versiones de control que Pulse. Deben confirmarse de nuevo en Studio.

| Patrón | Riesgo confirmado en Pulse | Regla preventiva |
|---|---|---|
| `Label@2.5.1` + `Radius*` | `PA2108` | Aplicar radios al contenedor, no a la etiqueta. |
| `Classic/Button@2.2.0` + `AccessibleLabel` | `PA2108` | No declarar esa propiedad sin validación específica. |
| `TabList@2.2.30` + `Reset()` | error de fórmula | Controlar selección mediante variable. |
| variable numérica inicializada solo con `Blank()` | tipo/nombre no establecido | Primera asignación numérica inequívoca, por ejemplo `0`. |
| `CanvasComponent` solo existente en GitHub | `PA2301` | Confirmar que el componente está añadido a la app activa. |
| SVG inline como sustituto visual | renderizado poco fiable | No usar como fallback automático; preferir componente validado. |

## Decisiones para Functional Lab

### FL-COMP-001 — Bloque 01 sin dependencias asumidas

El primer shell utilizará únicamente controles/componentes cuyo tipo, versión e instalación hayan sido confirmados en la app base.

El acabado puede ser premium desde Foundation, pero no se declarará un componente inexistente para lograrlo.

### FL-COMP-002 — Componentes Pulse son candidatos

`cmp_PageHeaderPro`, `cmp_SidebarNav`, `cmp_EmptyState`, `cmp_SkeletonLoader` y otros componentes de Pulse pueden evaluarse y reutilizarse.

Para utilizar cualquiera debe existir un paso explícito de incorporación/validación en la Canvas app del Functional Lab.

### FL-COMP-003 — No copiar propiedades por apariencia

Una propiedad válida en un control o componente no se trasladará a otro por similitud visual.

### FL-COMP-004 — Contrato de dominio antes del componente

Los componentes definidos en `component-contracts.md` son contratos funcionales, no componentes garantizados de Canvas.

Antes de materializar cualquiera:

```text
active layer confirmed
primary object confirmed
input/output contract confirmed
component installed or implementation approved
control versions confirmed
```

### FL-COMP-005 — No degradar cardinalidad para simplificar Power Fx

Prohibido convertir:

```text
MaintenanceTask N:M FailureMode
```

en:

```text
MaintenanceTask.FailureModeId
```

para facilitar galleries, forms o collections.

La colección puente debe conservarse.

### FL-COMP-006 — Read-only por agregado

Una `FmeaRevision` publicada puede ser read-only mientras `FmeaAssetApplication` o `ExecutionPlan` siguen siendo editables según su propio estado.

No usar un único flag `CaseReadOnly` si congela indebidamente todas las capas.

### FL-COMP-007 — Datos económicos separados

Power Fx/collections no deben normalizar `EconomicAssessment`, `MaintenanceCostEstimate` y `ActualMaintenanceCost` en una sola colección editable.

### FL-COMP-008 — Legacy v1 no es fallback

`p101-case.v1.json` no debe cargarse silenciosamente si falla v2. El runtime v2 debe devolver `UnsupportedLegacyFixture` o utilizar un adaptador legacy explícito.

## Incidentes Functional Lab

Todavía no existen incidentes confirmados en Power Apps Studio del Functional Lab v2.

Cuando aparezca el primero debe registrarse con:

```text
ID
Fecha
Bloque
Active layer
Primary domain object
Control / versión
Mensaje completo
Session ID
Causa
Corrección
Regla preventiva
Archivos afectados
Estado
```

## Checklist pre-bloque

```text
[ ] Domain ownership gate passed
[ ] Functional unit documented
[ ] Active layer visible
[ ] Primary object known
[ ] Compatibility document reviewed
[ ] Control/component confirmed in active app
[ ] No legacy v1 dependency
[ ] N:M/cardinality preserved
[ ] Published revision edit rules preserved
[ ] Risk vs asset criticality separation preserved
[ ] Expected lineage documented
```

## Estado de validación

```text
Static inheritance from Pulse: COMPLETE
Library-first compatibility rules: COMPLETE
Functional Lab Studio validation: PENDING
```
