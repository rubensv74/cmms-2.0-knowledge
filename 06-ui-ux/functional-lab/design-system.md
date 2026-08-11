# CMMS 2.0 Functional Lab — Estrategia de diseño SaaS Premium

**Estado:** activo  
**Fecha:** 2026-08-11  
**Ámbito:** diseño de interfaz y componentes del Functional Lab.

## 1. Decisión

CMMS 2.0 Functional Lab utilizará como referencia obligatoria el conocimiento curado en `rubensv74/functional-engineering-knowledge-base`, especialmente patrones de arquetipos SaaS, calidad visual Power Apps, contratos de componentes y construcción modular de pantallas.

Como fuente de implementación probada podrán consultarse los documentos y componentes activos de `rubensv74/app_pulse` cuando su contrato encaje.

Esta estrategia debe respetar el modelo funcional canónico:

```text
Engineering Library
→ Asset Application
→ Execution Plan
→ Results & Learning
```

## 2. Regla de diseño

Antes del Bloque 01 de cada workspace se deben declarar:

```text
ACTIVE_LAYER
PRIMARY_DOMAIN_OBJECT
PRIMARY_USER_TASK
SUCCESS_CRITERION
PRIMARY_ARCHETYPE
SECONDARY_PATTERNS
PREMIUM_COMPONENTS
TRACEABILITY_REQUIREMENT
```

No se empieza por controles. Primero se define el trabajo del usuario, la capa de dominio y el objeto que puede modificar.

## 3. Arquetipos por responsabilidad

No se impone un único arquetipo a toda la aplicación.

| Workspace | Arquetipo dominante candidato | Motivo |
|---|---|---|
| WS-01 Library & Revision | `Configuration Studio` | Seleccionar/crear definición, revisión y metadatos gobernados. |
| WS-02 Functions & Failure Structure | `Data Explorer` + estructura jerárquica | Navegar relaciones función→fallo→modo→causa/efecto sin exponer CRUD plano. |
| WS-03 Consequence & Risk | `Operational Review Workspace` | Revisar evidencia, cálculo y juicio de riesgo AMEF. |
| WS-04 RCM Decision | `Workflow Builder` / `Operational Review Workspace` | Seguir lógica versionada y conservar decisiones. |
| WS-05 Treatment Engineering | `Data Explorer` + relation workspace | Gestionar N:M tareas–modos, adjuntos y economía. |
| WS-06 Library Publication | `Exception Resolution Queue` + review | Resolver calidad, discrepancias y publicación. |
| WS-07 Asset Application | `Object 360` | Mostrar activo/contexto/criticidad separados de la biblioteca de origen. |
| WS-08 Execution Plan | `Operational Review Workspace` | Contextualizar tareas, recursos, intervalos y alcance. |
| WS-09 Results & Improvement | `Audit Timeline` + review | Contrastar hipótesis, resultados, costes y change requests. |

La selección se validará por workspace. Una etapa funcional no equivale automáticamente a una pantalla.

## 4. Reglas visuales de arquitectura

### 4.1 Capa visible

Toda pantalla debe mostrar inequívocamente si el usuario está en:

- `ENGINEERING LIBRARY`;
- `ASSET APPLICATION`;
- `EXECUTION PLAN`;
- `RESULTS & LEARNING`.

### 4.2 Biblioteca antes que activo

WS-01 a WS-06 no utilizarán P-101 como título/objeto principal. El encabezado mostrará `FmeaDefinition` / `FmeaRevision`.

### 4.3 Riesgo separado de criticidad

- WS-03 utilizará lenguaje `Consequence / Risk Assessment`.
- WS-07 utilizará lenguaje `Asset Criticality`.
- No se reutilizará una misma tarjeta semántica para ambos si induce a pensar que son el mismo indicador.

### 4.4 Identidad y revisión

Objetos gobernados mostrarán código/ID, revisión y estado cuando aporten contexto. Una revisión publicada debe reconocerse como solo lectura sin depender únicamente del color.

### 4.5 Lineage persistente

Cuando se cambie de capa debe permanecer visible el objeto origen.

Ejemplo:

```text
P-101 / APP-001
Source: FMEA-CWPUMP-001 / Rev 1
```

## 5. Componentes premium

La aplicación debe construirse con componentes reutilizables de calidad enterprise.

Los contratos funcionales específicos están en:

- `component-contracts.md`

Candidatos de dominio:

```text
cmp_LayerContextHeader
cmp_RevisionStatusBadge
cmp_TraceabilityBreadcrumb
cmp_DecisionCard
cmp_GatePanel
cmp_TaskModeRelationMatrix
cmp_AttachmentRefs
cmp_AssetApplicationContextCard
cmp_RiskAssessmentCard
cmp_EconomicComparison
cmp_NoScheduledTaskDecision
cmp_ResultVsHypothesis
```

Estos nombres describen contratos conceptuales. No implican que los componentes ya estén instalados en Power Apps.

## 6. Reutilización desde Pulse

Componentes de Pulse que se evaluarán cuando exista app baseline:

```text
cmp_PageHeaderPro
cmp_SidebarNav
cmp_ActionToolbarPro
cmp_DataTableProV2
cmp_EmptyState
cmp_SkeletonLoader
cmp_KpiCardPro
cmp_DonutPro
cmp_HeatMapPro
cmp_PieChartPro
```

Principios:

1. reutilizar solo cuando el contrato encaje;
2. no reutilizar por mera similitud visual;
3. importar y validar cada componente en la app activa antes de instanciarlo desde YAML;
4. crear un componente de dominio cuando exista una necesidad repetible no cubierta;
5. documentar inputs, outputs, eventos, estados y forma de datos;
6. mantener estado por instancia;
7. separar componentes visuales de reglas de negocio y orquestación.

## 7. Patrones especiales que la UI debe soportar

### 7.1 N:M tarea–modo

La relación no puede presentarse como un simple campo `FailureMode` dentro de la tarea.

Debe ser posible:

- ver todos los modos tratados por una tarea;
- ver todas las tareas asociadas a un modo;
- explicar la finalidad de cada vínculo.

### 7.2 Tarea / procedimiento / formato

Deben aparecer como objetos relacionados, no como secciones inseparables de un formulario único.

### 7.3 Decisión sin tarea

La salida `NoScheduledTaskDecision` debe tener presencia visual explícita y auditable.

### 7.4 Economía

El componente de comparación puede mostrar:

- `EconomicAssessment`;
- `MaintenanceCostEstimate`;
- `ActualMaintenanceCost`.

Pero la UI debe comunicar que pertenecen a responsabilidades y momentos distintos.

## 8. Diseño premium desde Foundation

El enfoque incremental no significa construir una interfaz pobre para embellecerla después.

Desde Foundation deben quedar definidos:

- tokens visuales;
- shell y geometría;
- jerarquía tipográfica;
- navegación por capas/workspaces;
- superficies y bordes;
- estados de interacción;
- estrategia responsive;
- loading/empty/error;
- accesibilidad;
- contratos de componentes;
- trazabilidad visual.

Los primeros bloques pueden ser estructuralmente mínimos, pero deben pertenecer a la arquitectura visual definitiva.

## 9. Gate visual

Además del gate técnico se exigirá:

```text
[ ] capa y objeto activos comprensibles
[ ] jerarquía visual coherente
[ ] sin clipping ni scroll accidental
[ ] contenido realista probado
[ ] Selected/Hover/Focus/Disabled cuando apliquen
[ ] loading/empty/error visibles
[ ] color semántico, no decorativo
[ ] foco visible
[ ] geometría consistente
[ ] densidad adecuada
[ ] riesgo AMEF y criticidad no confundibles
[ ] lineage visible al cambiar de capa
[ ] revisión en Power Apps Studio
```

## 10. Consecuencia sobre F01

F01-01 será el **Premium App Shell Foundation** del Functional Lab.

El shell ya debe reservar espacio para:

- navegación de workspaces;
- `cmp_LayerContextHeader` o equivalente;
- estado/revisión del objeto;
- contenido principal;
- overlay/dialog layer.

Sin embargo, antes de redactar YAML deben confirmarse en la app real:

- formato Source Code;
- controles y versiones disponibles;
- componentes premium instalados;
- estrategia para incorporar los componentes fundacionales que falten;
- baseline visual y de App Checker.

No se avanzará a F01-02 hasta validar el shell en Studio.
