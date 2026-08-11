# F01-00 — Auditoría Power Apps Foundation

**Fecha original:** 2026-08-10  
**Revisión:** 2026-08-11 — library-first v2  
**Estado:** auditoría estática completada; validación en app real pendiente antes de YAML

## 1. Objetivo

Cumplir el gate técnico previo al primer bloque Source Code del CMMS 2.0 Functional Lab sin degradar el modelo funcional para acomodar Power Apps.

El modelo rector ya está cerrado conceptualmente:

```text
Engineering Library
→ Asset Application
→ Execution Plan
→ Results & Learning
```

## 2. Fuentes técnicas revisadas

Referencias transferibles del método Power Apps/Pulse:

- protocolo incremental de `rubensv74/app_pulse`;
- protocolo de construcción modular de pantallas;
- registro de compatibilidad Source Code de Pulse;
- bloques de pantalla ya validados de Pulse.

Referencias internas obligatorias:

- `00-governance/cmms-functional-lab-incremental-protocol.md`;
- `00-governance/architecture-gates.md`;
- `03-data-model/core/fmea-library-model.md`;
- `03-data-model/core/traceability-layers.md`;
- `06-ui-ux/functional-lab/architecture.md`;
- `06-ui-ux/functional-lab/design-system.md`;
- `06-ui-ux/functional-lab/component-contracts.md`;
- `06-ui-ux/functional-lab/development/compatibility.md`;
- `06-ui-ux/functional-lab/development/adapters/runtime-adapter-v2.md`;
- `06-ui-ux/functional-lab/development/workspaces/ws-01-library-revision.md`.

## 3. Conclusiones transferibles confirmadas

### 3.1 Construcción por bloques

La pantalla debe construirse por piezas y cada pieza validarse en Studio antes de avanzar.

### 3.2 El repositorio no demuestra que un CanvasComponent esté instalado

Una definición disponible en GitHub no garantiza que la app activa conozca ese componente.

Consecuencia:

- arquitectura visual premium desde Foundation;
- componentes premium reutilizados/creados explícitamente;
- ningún YAML instancia un componente hasta confirmar su presencia;
- si falta un componente fundacional, su incorporación es un paso previo verificable.

### 3.3 No asumir propiedades por similitud

Las incompatibilidades registradas en Pulse obligan a confirmar control y versión antes de reutilizar propiedades.

### 3.4 El Runtime Adapter es una capa independiente

La carga del fixture no puede embutirse dentro del layout o de WS-01.

Secuencia:

```text
fixture v2
→ Runtime Adapter
→ Layered Functional State
→ workspace
```

### 3.5 Datos de prueba separados

El fixture v2 permanece en `cases/P101/p101-case.v2.json`.

Cualquier Power Fx generado para introducirlo en la app es un adaptador, no otra fuente de verdad.

### 3.6 Arquetipo y dominio antes que controles

Antes del Bloque 01 de cada workspace se declararán:

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

### 3.7 Published no significa entire-case read-only

La inmutabilidad se aplica al agregado publicado.

Ejemplo:

```text
FmeaRevision = published/read-only
FmeaAssetApplication = puede tener su propio lifecycle
ExecutionPlan = puede tener su propio lifecycle
```

La app no debe usar una simplificación de estado que bloquee todo el caso.

### 3.8 N:M no se simplifica en la UI

La implementación debe conservar `MaintenanceTaskFailureMode` como relación puente aunque Power Apps resulte más sencillo con un campo único.

### 3.9 Riesgo AMEF y criticidad del activo no comparten estado

No debe existir una variable/record ambiguo `Criticality` que mezcle:

```text
ConsequenceAssessment
AssetCriticalitySnapshot
```

## 4. Arquitectura técnica inicial

Nombre lógico candidato del host:

```text
scr_FunctionalLab
```

Árbol mínimo:

```text
scr_FunctionalLab
└─ conFL_Root
   ├─ conFL_Navigation
   └─ conFL_Content
      ├─ conFL_Header
      ├─ conFL_LayerContext
      ├─ conFL_WorkspaceHost
      └─ conFL_OverlayLayer
```

El número final de pantallas no queda congelado: los workspaces podrán separarse físicamente si la validación demuestra que mejora navegación, rendimiento o claridad sin alterar responsabilidades.

## 5. F01-01 — Premium App Shell Foundation

El Bloque 01 será pequeño pero pertenecerá a la arquitectura visual definitiva.

Debe establecer:

- geometría global;
- navegación base;
- jerarquía de superficies;
- tokens visuales mínimos;
- zonas de header/layer context/workspace;
- overlay layer;
- estados visuales fundamentales.

No incluirá todavía:

- contenido de P-101;
- `ParseJSON` dentro del layout;
- lógica de las 28 etapas;
- cálculos AMEF/RCM;
- gates de negocio;
- SQL;
- flows;
- persistencia productiva.

## 6. Secuencia técnica F01 revisada

| Bloque | Responsabilidad | Dependencia |
|---|---|---|
| 01 | Premium App Shell Foundation | app baseline + controles/componentes confirmados |
| 02 | Layered runtime state | bloque 01 validado |
| 03 | Runtime Adapter v2 | bloque 02 validado |
| 04 | Navegación base por workspaces/capas | bloque 03 validado |
| 05 | WS-01 Definition/Revision context | bloque 04 validado |
| 06 | WS-01 Evidence & revision work | bloque 05 validado |
| 07 | WS-01 Gate | bloque 06 validado |
| 08 | WS-01 Output/trace | bloque 07 validado |
| 09 | Hardening + documentación | bloque 08 validado |

## 7. Contrato de estado mínimo de F01-02

Conceptualmente debe existir separación equivalente a:

```text
LibraryState
AssetApplicationState
ExecutionPlanState
ResultsState
TraceState
AdapterDiagnostics
```

No se requiere que estos sean los nombres técnicos finales.

F01-02 será incorrecto si construye un único record editable `P101CaseState` que vuelve a mezclar las cuatro capas.

## 8. Contrato mínimo de F01-03

El Runtime Adapter debe:

- aceptar exclusivamente v2 como path canónico;
- rechazar v1 como legacy salvo adaptador explícito;
- resolver/validar relaciones internas;
- mantener N:M;
- mantener procedimientos/formatos separados;
- mantener risk/asset criticality separados;
- mantener tres datasets económicos;
- emitir diagnósticos por capa/objeto;
- conservar lineage.

La especificación detallada está en `development/adapters/runtime-adapter-v2.md`.

## 9. Contrato funcional de WS-01

WS-01 consume solamente como contexto de interacción:

```text
engineeringLibrary.fmeaDefinition
engineeringLibrary.fmeaRevision
engineeringLibrary.governance
```

P-101 no es objeto primario y `assetId` no forma parte del output necesario para WS-02.

Especificación detallada:

- `development/workspaces/ws-01-library-revision.md`.

## 10. Información que NO puede confirmarse todavía

Sin la app real abierta en Power Apps Studio no se puede confirmar honestamente:

- schema Source Code aceptado por esa app;
- versiones efectivas de los controles;
- variables de tema existentes;
- componentes premium instalados;
- App Checker baseline;
- comportamiento al pegar el primer bloque;
- calidad visual real del shell;
- disponibilidad/comportamiento exacto de `ParseJSON` y tipos en esa versión;
- mecanismo más limpio para incorporar el fixture durante el laboratorio.

## 11. Requisito mínimo para desbloquear F01-01

Debe existir una Canvas app vacía o baseline destinada al laboratorio.

Nombre candidato:

```text
CMMS 2.0 Functional Lab
```

Sobre esa app se debe inventariar:

```text
screen/control baseline
control versions
components installed
app/theme variables
known warnings/errors
App Checker state
Source Code copy/paste behavior
```

## 12. Componentes premium candidatos

Desde Pulse pueden evaluarse:

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

Desde el dominio Functional Lab se han definido contratos conceptuales como:

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

Estos últimos **no se consideran instalados** por el mero hecho de estar documentados.

## 13. Gate F01-00

```text
Static Power Apps audit: PASSED
Library-first domain architecture: PASSED
Runtime adapter contract: PASSED
WS-01 functional contract: PASSED
SaaS archetype strategy: PASSED
Compatibility register: RESTORED + UPDATED
Real Power Apps baseline: PENDING
Control/component inventory: PENDING
Studio/App Checker baseline: PENDING
Visual baseline: PENDING
F01-01 YAML: BLOCKED until real app baseline exists
```

## 14. Naturaleza del bloqueo

El bloqueo actual es **técnico**, no una nueva decisión de arquitectura.

No necesita decidir ahora:

- SQL vs Dataverse;
- API;
- backend;
- identidad productiva;
- motor de reglas;
- integración productiva.

Generar YAML sin baseline real sería asumir versiones, propiedades o componentes y violaría el protocolo.

## 15. Acción exacta cuando exista baseline

1. inventariar controles/componentes reales;
2. registrar compatibilidad inicial;
3. confirmar los componentes fundacionales del shell;
4. confirmar Source Code schema/dialecto;
5. redactar únicamente F01-01;
6. pegar/guardar en Studio;
7. ejecutar App Checker;
8. corregir/documentar cualquier incidencia;
9. continuar a F01-02 solo con F01-01 validado.
