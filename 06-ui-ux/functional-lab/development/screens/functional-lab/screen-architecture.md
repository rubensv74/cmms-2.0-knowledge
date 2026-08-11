# `scr_FunctionalLab` — Arquitectura de pantalla v2

**Estado:** arquitectura de interacción preparada; implementación bloqueada por TG-001  
**Arquetipo base:** SaaS workspace shell  
**Objetivo inicial:** alojar WS-01 sin acoplar el shell a P-101

## 1. Principio

La pantalla debe hacer visible en todo momento:

```text
ACTIVE LAYER
PRIMARY DOMAIN OBJECT
REVISION / STATUS
SOURCE / LINEAGE
ACTIVE WORKSPACE
```

El shell no puede usar `Asset` como contexto global porque seis de los nueve workspaces trabajan exclusivamente con Engineering Library.

## 2. Árbol objetivo conceptual

```text
scr_FunctionalLab
└─ conFL_Root
   ├─ conFL_Navigation
   │  ├─ cmp/zone Brand
   │  ├─ grp Library workspaces
   │  ├─ grp Asset Application workspaces
   │  ├─ grp Execution Plan workspaces
   │  └─ grp Results workspaces
   └─ conFL_Content
      ├─ conFL_Header
      │  ├─ page title
      │  ├─ fixture/demo badge
      │  └─ global actions
      ├─ conFL_LayerContext
      │  └─ cmp_LayerContextHeader candidate
      ├─ conFL_WorkspaceHost
      │  ├─ host WS-01
      │  ├─ ...
      │  └─ host WS-09
      ├─ conFL_StatusBar
      │  ├─ dirty/read-only status
      │  └─ adapter diagnostics summary
      └─ conFL_OverlayLayer
         ├─ dialogs
         ├─ traceability detail
         └─ confirmation/override panels
```

Los nombres son candidatos hasta confirmar convenciones de la Canvas app real.

## 3. Navegación por capas

La navegación agrupa los workspaces en cuatro zonas semánticas, no en una lista plana de “pasos”.

### Engineering Library

```text
WS-01 Library & Revision
WS-02 Functions & Failure Structure
WS-03 Consequence & Risk
WS-04 RCM Decision
WS-05 Treatment Engineering
WS-06 Library Publication
```

### Asset Application

```text
WS-07 Asset Application
```

### Execution Plan

```text
WS-08 Execution Plan
```

### Results & Learning

```text
WS-09 Results & Improvement
```

La transición WS-06→WS-07 debe sentirse como cambio de capa, no solo siguiente menú.

## 4. Context strip

### En WS-01..WS-06

Ejemplo:

```text
ENGINEERING LIBRARY
FMEA-CWPUMP-001
Bomba centrífuga de servicio de agua de refrigeración
Rev 1 · Published · To validate
```

No mostrar P-101 como título global.

### En WS-07

```text
ASSET APPLICATION
P-101 · APP-P101-FMEAR1-001
Source: FMEA-CWPUMP-001 / Rev 1
```

### En WS-08

```text
EXECUTION PLAN
PLAN-P101-001 · Rev 1
Application: APP-P101-FMEAR1-001
Library source: FMEA-CWPUMP-001 / Rev 1
```

### En WS-09

```text
RESULTS & LEARNING
Result / Review context
Execution Plan: PLAN-P101-001
Library source: FMEA-CWPUMP-001 / Rev 1
```

## 5. WS-01 layout objetivo

`Configuration Studio` con tres responsabilidades.

```text
┌──────────────────────────────────────────────────────────────┐
│ Layer Context · FMEA-CWPUMP-001 · Rev 1 · Published         │
├───────────────────────────────┬──────────────────────────────┤
│ Definition                    │ Revision                     │
│                               │                              │
│ code/name                     │ revision/status              │
│ reusable scope                │ source/change reason         │
│ owner/lifecycle               │ rule versions                │
│                               │ snapshot/read-only           │
├───────────────────────────────┴──────────────────────────────┤
│ Evidence & assumptions                                       │
│ sources / gaps / validation state                            │
├──────────────────────────────────────────────────────────────┤
│ Gate / diagnostics                        [Continue to WS-02] │
└──────────────────────────────────────────────────────────────┘
```

En anchuras reducidas Definition y Revision se apilan; no se pierde el orden semántico.

## 6. Responsabilidad de cada zona

### Navigation

Solo navegación/estado. No ejecuta reglas de negocio.

### Header

Identidad de aplicación y acciones globales. No se usa para mostrar el activo como raíz.

### Layer Context

Explica ownership y lineage del objeto activo.

### Workspace Host

Única zona donde se editan objetos de dominio.

### Status Bar

Muestra estado del runtime/adaptador, dirty state y warnings no intrusivos.

### Overlay Layer

Diálogos/trace/override. No debe quedar recortado por containers del workspace.

## 7. Estado conceptual de navegación

Candidatos:

```text
varActiveWorkspaceId
varActiveLayer
varActiveObjectType
varActiveObjectId
varActiveSourceObjectId
```

No son todavía nombres técnicos definitivos.

El estado activo debe derivarse de IDs, no de títulos visibles.

## 8. Estado de dominio

La pantalla consume:

```text
LibraryState
AssetApplicationState
ExecutionPlanState
ResultsState
TraceState
AdapterDiagnostics
```

No mantiene una segunda copia del fixture como variables de UI.

## 9. Reglas de edición visual

### Published library

- inputs gobernados disabled/read-only;
- badge explícito;
- explicación de por qué;
- acción separada “crear nueva revisión” cuando se implemente esa capacidad.

### Contextual objects

Pueden ser editables aunque la biblioteca origen esté publicada.

Por tanto el read-only se resuelve por agregado/objeto, no por pantalla global.

## 10. Gates y acciones

El CTA principal se habilita según el gate del workspace.

Incorrecto:

```text
DisplayMode.Disabled sin explicación
```

Correcto:

```text
GatePanel = blocked
Reasons = [...] 
CTA disabled
accessible explanation available
```

En modo presentación se puede navegar a un workspace posterior con estado `simulated/not validated`, sin falsificar que los gates anteriores están aprobados.

## 11. Patrones de decisión

### System recommendation

Visualmente secundaria respecto a la decisión humana pero siempre visible.

### Human decision

Estado confirmado explícito.

### Override

Debe mostrar simultáneamente:

```text
Original value/recommendation
Human value/decision
Reason
Authority
```

## 12. Riesgo vs criticidad

### WS-03

Panel/card titulado por ejemplo:

```text
Consequence & FMEA Risk
```

### WS-07

Panel/card separado:

```text
Asset Criticality
```

No compartir un componente genérico denominado `CriticalityCard` si oculta la diferencia semántica.

## 13. N:M en WS-05

El workspace debe soportar una vista relacional, no un dropdown `Failure Mode` dentro de la tarea.

Interacción candidata:

```text
Task selected
→ related modes highlighted
→ relationship purpose/rationale visible

Failure mode selected
→ all treating tasks shown
```

## 14. Economía

La misma pantalla puede mostrar comparativamente datasets distintos, pero cada bloque debe indicar su naturaleza:

```text
Decision economics
Estimated maintenance cost
Actual maintenance cost (WS-09 only)
```

## 15. Loading / empty / error

### Loading

Skeleton/placeholder, sin datos falsos.

### NoFixture

Explica que no hay caso cargado.

### UnsupportedLegacyFixture

Explica que v1 necesita migración/adaptador explícito.

### BlockedInvalidFixture

Muestra diagnostics por objeto/capa.

### Empty domain object

Distinguir:

```text
valid empty collection
```

de:

```text
failed to load collection
```

## 16. Responsive

Principios:

- desktop: navegación persistente + workspace ancho;
- tablet: navegación colapsable, Definition/Revision pueden apilarse;
- móvil: no es el objetivo principal de trabajo industrial, pero no debe romperse el contenido crítico;
- overlays deben permanecer utilizables sin clipping.

El breakpoint y medidas exactas se comprobarán en Studio, no se congelan aquí.

## 17. Accesibilidad

- foco visible;
- labels accesibles;
- orden lógico;
- no depender solo del color;
- estado read-only explicado;
- gate asociado al CTA;
- warnings no bloqueantes distinguibles de errores;
- targets suficientes para navegación;
- contraste conforme al design system que se valide.

## 18. Componentes candidatos

### Shell

- `cmp_PageHeaderPro` de Pulse si está instalado/compatible;
- `cmp_SidebarNav` si está instalado/compatible;
- otherwise containers/controls validados sin crear dependencia ficticia.

### Dominio

- `cmp_LayerContextHeader`;
- `cmp_RevisionStatusBadge`;
- `cmp_GatePanel`;
- posteriores según `component-contracts.md`.

Los componentes de dominio siguen siendo contratos hasta implementarse.

## 19. Out of scope del shell

- persistencia productiva;
- integración con activos reales;
- autenticación final;
- workflow real;
- matrices corporativas finales;
- ejecución real de mantenimiento;
- SQL/Dataverse/API.

## 20. Gate para materialización

```text
[ ] Canvas app baseline exists
[ ] Source Code dialect confirmed
[ ] screen baseline known
[ ] components installed inventoried
[ ] App Checker baseline captured
[ ] theme variables inventoried
[ ] first shell block small enough to validate independently
```

Hasta entonces esta arquitectura está cerrada a nivel de interacción, no de YAML.
