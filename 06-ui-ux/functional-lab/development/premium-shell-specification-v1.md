# CMMS 2.0 Functional Lab — Premium Shell Specification v1

**Estado:** design candidate ready for Studio validation  
**Fecha:** 2026-08-22  
**Rama:** `baseline/premium-powerapps-v1`

## 1. Propósito

Definir el shell visual y operativo común de la Canvas App antes de construir lógica AMEF/RCM.

Esta especificación no sustituye la validación en Power Apps Studio. Los tamaños concretos son candidatos iniciales y podrán ajustarse en P1/P2 al comprobar resolución, controles y comportamiento real.

## 2. Tarea principal del shell

```text
PRIMARY_USER_TASK
Orientar al usuario dentro del caso, mostrar dónde está en el journey y ofrecer una superficie estable para ejecutar cada workspace.

SUCCESS_CRITERION
Una persona que vea la aplicación por primera vez debe entender qué caso está analizando, en qué etapa se encuentra, qué necesita hacer y cuál es el siguiente paso sin recibir una explicación previa de la interfaz.

PRIMARY_ARCHETYPE
Operational Review Workspace

SECONDARY_PATTERNS
Object 360 + Guided Workflow + Audit/Decision context
```

## 3. Estructura canónica

```text
scr_FunctionalLab
└── conFL_Root
    ├── conFL_Sidebar
    └── conFL_Main
        ├── conFL_PageHeader
        ├── conFL_ContextStrip
        ├── conFL_WorkspaceHost
        └── conFL_ActionArea
    └── conFL_OverlayLayer
```

La geometría debe permanecer estable entre workspaces.

## 4. Geometría candidata

Valores iniciales a validar en Studio:

```text
Desktop target reference: 1440 × 900
Sidebar expanded:        248 px
Sidebar collapsed:        72 px
Page header:              72 px
Context strip:            56 px
Action area:              64 px
Content outer padding:    24 px
Primary grid gap:         16 px
Card internal padding:    20 px
Card radius:              12 px
Modal radius:             16 px
```

Estos valores son design tokens candidatos, no restricciones productivas definitivas.

## 5. Sidebar

### Responsabilidad

- identificar el producto;
- navegar entre workspaces;
- mostrar estado de cada workspace;
- ofrecer acceso a resumen/demo mode/configuración conceptual cuando proceda;
- conservar orientación durante una reunión.

### Ítems iniciales

```text
Overview / Case
WS-01 Case & Context
WS-02 Functions & Failures
WS-03 Effects & Risk
WS-04 RCM Decision
WS-05 Economics & Task
WS-06 Resources & Scope
WS-07 Traceability & Quality
WS-08 Review & Publish
WS-09 Effectiveness & Improvement
```

No todos deben estar activos desde el primer incremento.

### Estados visuales

```text
not_started
current
completed
warning
blocked
simulated
```

`simulated` debe distinguirse de `completed`.

## 6. Page Header

Debe mostrar como máximo la información que ayude a orientarse:

- nombre del workspace;
- propósito breve;
- breadcrumb/journey position cuando sea útil;
- estado del caso;
- acciones globales de demo/reset/help.

No debe convertirse en una segunda barra de navegación.

## 7. Context Strip

Superficie persistente y compacta para recordar el objeto analizado.

Campos candidatos:

```text
Asset Code
Asset Name
Plant / Unit
Current Case
Current Stage
Data Confidence
Active Configuration/Profile cuando afecte a la decisión
```

Debe responder a la pregunta: **“¿sobre qué estamos tomando esta decisión?”**

## 8. Workspace Host

Es la superficie principal de trabajo.

Cada workspace podrá adoptar un arquetipo específico, pero deberá respetar:

- márgenes comunes;
- jerarquía de títulos;
- superficies y estados;
- posición consistente de acciones primarias;
- comportamiento de loading/empty/error;
- patrón común para gates y recomendaciones.

## 9. Action Area

Área estable para acciones de avance.

Patrón candidato:

```text
Back                         Secondary actions     Primary action / Continue
```

Reglas:

- la acción primaria no debe moverse arbitrariamente entre pantallas;
- estado Disabled debe explicar el gate cuando sea relevante;
- acciones asíncronas futuras deberán aplicar Async Action Guard;
- en demo local, reset/reload debe ser explícito y seguro.

## 10. Overlay Layer

Reservado para:

- modales;
- paneles de ayuda contextual;
- confirmaciones;
- explicación detallada de gates;
- evidence preview cuando proceda.

No debe usarse para esconder contenido esencial del workflow.

## 11. Componentes fundacionales

Candidatos a reutilizar o crear tras inventario real en Studio:

```text
cmp_SidebarNav
cmp_PageHeaderPro
cmp_ContextStrip
cmp_StatusBadge
cmp_GatePanel
cmp_RecommendationPanel
cmp_EmptyState
cmp_SkeletonLoader
cmp_ActionBar
cmp_InfoModal
```

Los nombres son contratos lógicos; no se asume que ya existan instalados.

## 12. Tokens semánticos

No se fijan todavía colores hex definitivos antes del baseline visual real.

Sí se congelan los roles semánticos:

```text
surface.canvas
surface.navigation
surface.card
surface.elevated
border.subtle
text.primary
text.secondary
text.muted
action.primary
action.secondary
state.info
state.success
state.warning
state.error
state.blocked
state.simulated
focus.visible
```

La paleta final debe mantener contraste suficiente y utilizar color por significado, no por decoración.

## 13. Tipografía candidata

Jerarquía mínima:

```text
Display / workspace title
Section title
Card title
Body
Supporting text
Caption / metadata
Numeric KPI when required
```

La app debe evitar mezclar tamaños sin una escala consistente.

## 14. Patrones de superficie

### Primary Work Card

Para trabajo principal del usuario.

### Context / Existing Information Card

Para información que ya debería venir informada.

### System Recommendation Card

Debe ser visualmente distinta de la decisión humana y explicar:

- resultado;
- regla/criterio;
- evidencia principal;
- nivel de confianza cuando aplique.

### Human Decision Card

Debe mostrar claramente qué decisión pertenece a una persona y exigir motivo cuando el modelo lo requiera.

### Gate Panel

Estados:

```text
passed
warning
blocked
not_evaluated
```

Debe indicar la causa y la acción necesaria.

## 15. Estados de pantalla obligatorios

Cada workspace deberá poder representar:

```text
loading
loaded
empty
partial
blocked
warning
dirty
success
error
simulated
```

No debe existir una única vista de “happy path”.

## 16. Responsive behavior

La primera milestone se optimiza para escritorio/reunión.

Aun así, el layout deberá:

- usar contenedores antes que posiciones absolutas cuando sea razonable;
- evitar dimensiones rígidas internas innecesarias;
- permitir sidebar colapsable;
- preservar legibilidad a resoluciones inferiores;
- evitar scroll horizontal accidental.

La política responsive definitiva se valida en P1.

## 17. Demo Mode

El shell deberá soportar una bandera lógica de presentación.

Objetivos:

- permitir saltar a un workspace para explicar una idea;
- mantener visible que se está en modo demo;
- no convertir gates no superados en aprobados;
- poder volver al caso inicial mediante Reset Demo.

Estado candidato:

```text
varAppMode = "normal" | "demo"
```

El nombre técnico definitivo se validará en Studio.

## 18. WS-01 — composición candidata

Sin congelar aún el detalle final, WS-01 debería organizarse en tres zonas:

```text
┌──────────────────────────────────────────────────────────────┐
│ Context & Asset Identity                                    │
├──────────────────────────────┬───────────────────────────────┤
│ Existing Information         │ Evidence & Data Readiness     │
│                              │                               │
├──────────────────────────────┴───────────────────────────────┤
│ Human Confirmation / Corrections + Gate                     │
└──────────────────────────────────────────────────────────────┘
```

Objetivo: evitar una pantalla-formulario larga y plana.

## 19. Gate visual P2

P2 solo se considera aprobado cuando en Studio se compruebe:

```text
[ ] shell estable a resolución objetivo
[ ] sidebar usable expandido/colapsado
[ ] header y context strip no compiten visualmente
[ ] workspace host conserva espacio útil suficiente
[ ] action area consistente
[ ] loading/empty/error/blocking visibles
[ ] foco visible
[ ] selected/hover/disabled coherentes
[ ] contraste suficiente
[ ] sin clipping
[ ] sin scroll horizontal accidental
[ ] aspecto premium con contenido realista
[ ] App Checker sin nuevos errores no aceptados
```

## 20. Lo que NO se implementa en P2

- lógica AMEF;
- árbol RCM;
- matriz de riesgo;
- SQL;
- Power Automate;
- persistencia;
- routing organizativo;
- órdenes de trabajo;
- reglas de scheduling.

P2 debe dejar una arquitectura visual definitiva y vacía de reglas de negocio complejas.
