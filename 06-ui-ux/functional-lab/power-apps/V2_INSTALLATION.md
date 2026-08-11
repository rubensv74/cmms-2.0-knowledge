# CMMS 2.0 Functional Lab — Instalación del modelo alineado

**Estado:** candidato para validación integrada en Power Apps Studio  
**Rama:** `feature/f01-premium-foundation`  
**Fecha:** 2026-08-11

## 1. Objetivo

Instalar y validar la versión corregida tras la auditoría de las últimas reuniones.

La experiencia completa utiliza:

```text
Biblioteca AMEF
→ Aplicación multi-activo
→ Criticidad contextual
→ AnalysisCase / 28 etapas
→ AMEF / RCM
→ tarea ejecutable
→ plan / handoff
→ ejecución / efectividad
```

## 2. Componentes requeridos

Crear o sustituir primero los 9 componentes canónicos:

1. `cmp_FL_SidebarPro`
2. `cmp_FL_PageHeaderPro`
3. `cmp_FL_TreePro`
4. `cmp_FL_ProcessRailPro`
5. `cmp_FL_DecisionPanelPro`
6. `cmp_FL_GatePanelPro`
7. `cmp_FL_RiskMatrixPro`
8. `cmp_FL_LineagePanelPro`
9. `cmp_FL_ApplicabilityMatrixPro`

No instalar pantallas consumidoras hasta guardar primero las nueve definiciones.

## 3. Crear las 25 pantallas vacías

```text
scr_FL_Home
scr_FL_FLH
scr_FL_Taxonomy
scr_FL_ADR
scr_FL_AssetCriticality
scr_FL_Asset360
scr_FL_FmeaLibrary
scr_FL_FmeaRevision
scr_FL_AssetApplication
scr_FL_AnalysisRegister
scr_FL_CaseOverview
scr_FL_Context
scr_FL_Functions
scr_FL_FailureModes
scr_FL_AMEF
scr_FL_RCM
scr_FL_Economics
scr_FL_Task
scr_FL_PlanPackage
scr_FL_Traceability
scr_FL_ReviewApproval
scr_FL_Effectiveness
scr_FL_MaintenancePlans
scr_FL_Governance
scr_FL_Settings
```

Esto permite resolver referencias `Navigate(...)` antes de pegar el Source Code completo.

## 4. Bootstrap

La autoridad ejecutable de la versión alineada es `scr_FL_Home.OnVisible`, protegido por `varFLAlignedInitialized`.

Existe además una copia conceptual en:

`runtime/functional-lab-aligned-bootstrap.powerfx`

Abrir Home una vez para cargar:

- navegación;
- criticidad independiente de P-101/P-102/P-103;
- biblioteca AMEF;
- revisiones;
- funciones/fallos/modos/causas/efectos;
- tareas propuestas;
- cobertura N:M tarea-modo;
- aplicaciones multi-activo;
- perfiles y variantes;
- AnalysisCase;
- 28 etapas;
- datos de AMEF/RCM/tarea/plan/ejecución.

No utilizar el antiguo `functional-lab-v2-bootstrap.powerfx` para reinstalar esta versión.

## 5. Orden recomendado de pantallas

### Lote A — Shell y contexto

```text
scr_FL_Home
scr_FL_FLH
scr_FL_Taxonomy
scr_FL_ADR
scr_FL_AssetCriticality
scr_FL_Asset360
```

### Lote B — Ingeniería reusable

```text
scr_FL_FmeaLibrary
scr_FL_FmeaRevision
scr_FL_AssetApplication
```

### Lote C — AnalysisCase

```text
scr_FL_AnalysisRegister
scr_FL_CaseOverview
scr_FL_Context
scr_FL_Functions
scr_FL_FailureModes
scr_FL_AMEF
scr_FL_RCM
scr_FL_Economics
scr_FL_Task
scr_FL_PlanPackage
scr_FL_Traceability
scr_FL_ReviewApproval
scr_FL_Effectiveness
```

### Lote D — Handoff y gobierno

```text
scr_FL_MaintenancePlans
scr_FL_Governance
scr_FL_Settings
```

## 6. Fixture P-101

```text
FmeaDefinition        AMEF-BOMBA-CENTRIFUGA
FmeaRevision          R01
Application           APP-P101-R01
TechnicalObject       P-101
AssetCriticality      Alta
Profile               HIGH
AnalysisCase          P101-AMEF-RCM-001
```

AMEF inicial:

```text
S=4/5
O=3/5
D=3/5
S×O=12
NPR=36
```

## 7. Validación integrada

### Smoke 1 — Foundation

Insertar una instancia aislada de los componentes nuevos/no validados: ProcessRail, DecisionPanel, GatePanel, RiskMatrix, LineagePanel y ApplicabilityMatrix. Studio debe permanecer estable.

### Smoke 2 — Activos y criticidad

Verificar FLH, Taxonomía, ADR, Criticidad y Ficha 360. Confirmar que la criticidad de P-101 se presenta como dato contextual externo al AMEF.

### Smoke 3 — Biblioteca AMEF

Abrir Biblioteca y Revisión. Verificar:

- AMEF por familia de equipo;
- revisión R01;
- funciones/fallos/modos;
- causas/mecanismos;
- efectos;
- tareas propuestas;
- relación N:M tarea-modo;
- ausencia de dependencia propietaria de P-101.

### Smoke 4 — Aplicación multi-activo

Abrir Aplicación y verificar P-101/P-102/P-103 sobre la misma revisión R01, con criticidad/perfil/intervalo diferentes sin duplicar la ingeniería.

### Smoke 5 — AnalysisCase

Abrir Case Overview y confirmar:

- referencia a FmeaRevision;
- aplicación activa;
- criticidad utilizada;
- 28 etapas;
- lineage visible;
- FL-01..06 como revisión/aplicabilidad, no creación desde cero.

### Smoke 6 — Failure Modes / AMEF

Verificar:

- modo heredado de biblioteca;
- causas visibles;
- recomendación separada de decisión humana;
- `Matriz de riesgo AMEF` 5×5;
- criticidad de activo mostrada por separado;
- S=4, O=3, D=3, NPR=36;
- control de avance explicable.

### Smoke 7 — RCM

Verificar que la pantalla representa respuestas y resultado de una lógica versionable, sin presentar la secuencia concreta como regla corporativa cerrada.

### Smoke 8 — Task

Verificar las tres capas:

```text
ProposedMaintenanceTask
TaskProfileVariant
MaintenanceTask
```

Comprobar intervalo, estado operativo, parada/aislamiento/permiso, duración, crew, H-H y procedimiento opcional.

### Smoke 9 — Plan Package

Verificar `PlanScopeItem`, tags incluidos, restricciones derivadas, H-H y regla de agrupación candidata.

### Smoke 10 — Maintenance Plans

Distinguir visualmente:

```text
MaintenanceTask
MaintenanceProcedure
JobPlan / Route
PreventiveMaintenancePlan
WorkOrder
ExecutionResult
```

Confirmar que la agrupación conserva trazabilidad por `TechnicalObject`.

### Smoke 11 — Trazabilidad / revisión / efectividad

Reconstruir Biblioteca → Aplicación → Decisión → Tarea → Plan → Ejecución y comprobar que un resultado real puede desencadenar cambio de aplicación o nueva revisión AMEF.

## 8. Qué NO validamos todavía

Los smokes anteriores validan estructura y experiencia, no cierran:

- escalas AMEF corporativas;
- umbrales y colores;
- reglas oficiales de criticidad;
- árbol RCM definitivo;
- P–F/intervalo;
- roles y autoridades finales;
- evidencia mínima;
- sobreclasificación;
- criterios de aprobación;
- KPIs de efectividad;
- reglas definitivas de agrupación;
- sistema destino/integración;
- arquitectura física de datos.

## 9. Niveles de aceptación

```text
PASS_STATIC
DEFINITION_ACCEPTED
INSTANCE_SAFE
PUBLIC_CONTRACT_VALIDATED
VISUAL_QA_VALIDATED
READY_FOR_INTEGRATION
```

`PASS_STATIC` no implica `INSTANCE_SAFE`. Power Apps Studio sigue siendo la autoridad de runtime.
