# CMMS 2.0 Functional Lab — Estado canónico alineado

**Fecha:** 2026-08-11  
**Rama:** `feature/f01-premium-foundation`  
**Estado global:** D-01…D-14 corregido / Home + Activos + Biblioteca AMEF + Aplicación multi-activo validados / F03 AMEF readability reference `PASS_STATIC`

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

Las 14 desviaciones identificadas están corregidas funcionalmente.

`CORREGIDO` no significa automáticamente `INSTANCE_SAFE` ni `VISUAL_QA_VALIDATED`.

## 3. Evidencia Studio acumulada

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
ApplicabilityMatrixPro en runtime                  PASS previo
```

Confirmaciones de usuario:

```text
HOME OK
ACTIVOS OK
BIBLIOTECA AMEF OK
APLICACIÓN MULTI-ACTIVO OK
```

## 4. Foundation visual — F03

La inspección de `scr_FL_AMEF` reveló dos problemas que obligaron a pausar la propagación a las 25 pantallas:

```text
FL-SC-004    materialización visual incorrecta de defaults Color en varias instancias
UX           escala tipográfica 7–10 demasiado pequeña para uso real y demostración
```

Además se incorporó la regla de identidad de Canvas Components:

> una definición corregida no debe agregarse como nueva copia si el componente ya tiene instancias; debe actualizarse in situ o migrarse de forma controlada.

### Baseline Comfortable

`TYPOGRAPHY_AND_DENSITY_STANDARD.md` establece:

```text
texto visible mínimo     11
supporting               12
label                    12–13
body                     13–14
card title               15–17
section title            16–18
page title               24–28
button                    12–13
```

No se reducirá tipografía para evitar scroll.

## 5. F03 — AMEF Readability Reference

La referencia canónica está implementada en:

`power-apps/blocks/F03-AMEF-READABILITY-REFERENCE/`

Target:

```text
1366×768
browser zoom 100%
Comfortable density
```

Definiciones actualizadas como candidatos **con el mismo nombre/identidad canónica**:

```text
cmp_FL_SidebarPro
cmp_FL_PageHeaderPro
cmp_FL_ProcessRailPro
cmp_FL_LineagePanelPro
cmp_FL_RiskMatrixPro
cmp_FL_DecisionPanelPro
cmp_FL_GatePanelPro
scr_FL_AMEF
```

No se modifican en F03:

```text
cmp_FL_TreePro
cmp_FL_ApplicabilityMatrixPro
resto de pantallas
```

### Geometría de referencia

```text
Sidebar                 220
Header host              100
ProcessRail              300 + scroll
Lineage/context          108
Effects                  304
RiskMatrix               304
Decision                 216
Gate                     216
```

El layout elimina los bloques verticales redundantes anteriores y gana espacio reorganizando información, no miniaturizándola.

## 6. Semántica AMEF preservada

Fixture P-101:

```text
S=4/5
O=3/5
D=3/5
S×O=12
NPR=36
```

La matriz sigue siendo `Matriz de riesgo AMEF` S×O.

La criticidad del activo permanece como contexto externo al AMEF.

## 7. Estado de validación F03

```text
SOURCE / YAML REVIEW            PASS
KNOWN COMPATIBILITY SCAN        PASS
TYPOGRAPHY BASELINE             PASS_STATIC
REFERENCE GEOMETRY              PASS_STATIC
COMPONENT IDENTITY STRATEGY     DOCUMENTED

DEFINITION_ACCEPTED             pendiente de Studio
INSTANCE_SAFE                   pendiente para esta revisión
VISUAL_QA_VALIDATED             pendiente
READY_FOR_INTEGRATION           NO
```

Documentos:

```text
F03.../README.md
F03.../STUDIO_IN_PLACE_UPDATE.md
F03.../STATIC_VALIDATION.md
```

## 8. Próximo gate — una única actualización y smoke

No se deben volver a copiar las 25 pantallas.

Actualizar **in situ** en Studio, en este orden:

```text
1 cmp_FL_SidebarPro
2 cmp_FL_PageHeaderPro
3 cmp_FL_ProcessRailPro
4 cmp_FL_LineagePanelPro
5 cmp_FL_RiskMatrixPro
6 cmp_FL_DecisionPanelPro
7 cmp_FL_GatePanelPro
8 scr_FL_AMEF
```

Después ejecutar una única validación:

```text
Home
→ Registro de análisis
→ P101-AMEF-RCM-001
→ AMEF
```

Criterios principales:

```text
no duplicación de componentes
instancias siguen asociadas
paleta correcta
texto legible a 100%
ProcessRail con scroll
matriz 5×5 legible
D=3
NPR=36
sistema vs decisión humana diferenciados
gate legible
sin bloques negros
uso cómodo a 1366×768
```

Solo si este gate pasa se propagará el patrón al resto del Functional Lab.

## 9. Estado del plan integrado

```text
1 Home / bootstrap                       PASS
2 Activos + criticidad                   PASS
3 Biblioteca AMEF                        PASS
4 Aplicación multi-activo                PASS
5 AnalysisCase                           PAUSADO — F03 visual gate
6 Failure Modes / causas                 pendiente
7 AMEF                                   F03 PASS_STATIC / Studio QA pendiente
8 RCM                                    pendiente
9 Task                                   pendiente
10 Plan Package / Maintenance Plans      pendiente
11 Trazabilidad / revisión / efectividad pendiente
```

## 10. Asuntos deliberadamente abiertos

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
