# CMMS 2.0 Functional Lab — Estado canónico alineado

**Fecha:** 2026-08-11  
**Rama:** `feature/f01-premium-foundation`  
**Estado global:** corrección funcional D-01…D-14 implementada / Home + Activos + Biblioteca AMEF + Aplicación multi-activo validados en Studio / AnalysisCase pendiente

## 1. Modelo canónico

```text
BIBLIOTECA DE INGENIERÍA
FmeaDefinition → FmeaRevision
        ↓
CONTEXTO DE PLANTA
TechnicalObject + FLH + Taxonomía + ADR + AssetCriticalityAssessment
        ↓
APLICACIÓN
FmeaAssetApplication + perfil + variantes + overrides
        ↓
ANÁLISIS CONTEXTUAL
AnalysisCase + 28 etapas + AMEF + RCM
        ↓
EJECUTABILIDAD
MaintenanceTask + intervalo + recursos + procedimiento opcional
        ↓
HANDOFF
PlanScopeItem → JobPlan/Route → PM → WorkOrder → ExecutionResult
        ↓
MEJORA
coste real + efectividad + cambio de aplicación o biblioteca
```

P-101 es una aplicación de `AMEF-BOMBA-CENTRIFUGA / R01`, no propietario de la ingeniería AMEF.

## 2. Auditoría D-01…D-14

Las 14 desviaciones identificadas están corregidas funcionalmente. `CORREGIDO` no significa automáticamente `INSTANCE_SAFE`: cada pieza debe comprobarse en Power Apps Studio.

| ID | Corrección | Estado funcional |
|---|---|---|
| D-01 | Biblioteca `FmeaDefinition/FmeaRevision` | CORREGIDO |
| D-02 | Criticidad separada de riesgo AMEF | CORREGIDO |
| D-03 | Aplicación multi-activo | CORREGIDO |
| D-04 | Perfiles/variantes por contexto | CORREGIDO |
| D-05 | `FailureCause` / mecanismo | CORREGIDO |
| D-06 | N:M tarea propuesta ↔ modo | CORREGIDO |
| D-07 | Procedimiento/checklist opcional | CORREGIDO |
| D-08 | Estado operativo/parada/aislamiento/permiso | CORREGIDO |
| D-09 | Duración, crew, H-H, disciplina/work center | CORREGIDO |
| D-10 | Economía preliminar / estimado / real | CORREGIDO |
| D-11 | Lógica RCM versionable | CORREGIDO |
| D-12 | Alcance físico por `TechnicalObject` | CORREGIDO |
| D-13 | Job Plan / PM / WO / resultado separados | CORREGIDO |
| D-14 | Ciclos, agrupación y ObjectList | CORREGIDO |

## 3. Pantallas y componentes canónicos

La versión alineada contiene **25 pantallas** y **9 componentes**.

Componentes:

```text
cmp_FL_SidebarPro
cmp_FL_PageHeaderPro
cmp_FL_TreePro
cmp_FL_ProcessRailPro
cmp_FL_DecisionPanelPro
cmp_FL_GatePanelPro
cmp_FL_RiskMatrixPro
cmp_FL_LineagePanelPro
cmp_FL_ApplicabilityMatrixPro
```

Evidencia acumulada:

```text
SidebarPro / PageHeaderPro        INSTANCE_SAFE PASS previo
TreePro                            runtime funcional en Activos PASS
ApplicabilityMatrixPro             runtime funcional en Aplicación multi-activo PASS
ProcessRailPro                     import corregido / próximo smoke AnalysisCase
resto de componentes nuevos       Studio validation pendiente
```

## 4. Fixture P-101

```text
FmeaDefinition        AMEF-BOMBA-CENTRIFUGA
FmeaRevision          R01
Application           APP-P101-R01
TechnicalObject       P-101
AssetCriticality      Alta · CRIT-P101-R03
Profile               HIGH
AnalysisCase          P101-AMEF-RCM-001
```

La misma revisión R01 se aplica también a P-102 y P-103 con perfiles/intervalos distintos sin duplicar la ingeniería.

## 5. Evidencia Studio — 2026-08-11

```text
scr_FL_Home / bootstrap                           PASS
FLH → Taxonomía → ADR → Criticidad → Ficha 360   PASS
Biblioteca AMEF → FmeaRevision R01                PASS
funciones/fallos/modos/causas/efectos             PASS
tareas propuestas + N:M tarea ↔ modo              PASS
ingeniería base separada de P-101                 PASS
R01 aplicada a P-101 / P-102 / P-103              PASS
criticidad/perfil/intervalo por aplicación         PASS
APP-P101-R01 + perfil HIGH                         PASS
ApplicabilityMatrixPro en runtime                  PASS
```

Confirmaciones de usuario:

```text
HOME OK
ACTIVOS OK
BIBLIOTECA AMEF OK
APLICACIÓN MULTI-ACTIVO OK
```

## 6. Estado del plan integrado

```text
1 Home / bootstrap                       PASS
2 Activos + criticidad                   PASS
3 Biblioteca AMEF                        PASS
4 Aplicación multi-activo                PASS
5 AnalysisCase                           EN CURSO
6 Failure Modes / causas                 pendiente
7 AMEF                                   pendiente
8 RCM                                    pendiente
9 Task                                   pendiente
10 Plan Package / Maintenance Plans      pendiente
11 Trazabilidad / revisión / efectividad pendiente
```

## 7. Próxima validación integrada — AnalysisCase

Recorrido:

```text
scr_FL_AnalysisRegister
→ scr_FL_CaseOverview
→ scr_FL_Context
→ scr_FL_Functions
```

Criterios de aceptación:

- `P101-AMEF-RCM-001` se abre desde el registro;
- Case Overview referencia `AMEF-BOMBA-CENTRIFUGA / R01` y `APP-P101-R01`;
- la criticidad `Alta` se muestra como contexto, no como resultado AMEF;
- Process Rail muestra las 28 etapas y permite seleccionar/navegar sin error;
- FL-01…FL-06 se presentan como revisión/aplicación contextual, no como creación desde cero;
- Contexto y Funciones conservan lineage biblioteca → aplicación → caso;
- la navegación no rompe P-101 ni la revisión R01 activa.

## 8. Asuntos deliberadamente abiertos

- escalas AMEF corporativas;
- umbrales/bandas/colores;
- reglas oficiales de criticidad;
- árbol RCM definitivo;
- reglas P–F / intervalo;
- autoridades/permisos finales;
- evidencia mínima/confianza;
- reglas de sobreclasificación;
- criterios de aprobación;
- KPIs/umbrales de efectividad;
- reglas definitivas de agrupación;
- sistema destino/integración;
- arquitectura física de datos.

No se cerrará ninguno por inferencia antes de la siguiente fase de decisiones.