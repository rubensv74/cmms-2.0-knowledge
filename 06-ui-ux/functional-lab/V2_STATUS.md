# CMMS 2.0 Functional Lab — Estado canónico alineado

**Fecha:** 2026-08-11  
**Rama:** `feature/f01-premium-foundation`  
**Estado global:** D-01…D-14 corregido / Home + Activos + Biblioteca AMEF + Aplicación multi-activo validados / AMEF premium stage-focused publicado como candidato Studio

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

## 4. Foundation visual

La inspección de `scr_FL_AMEF` reveló dos problemas que obligaron a pausar la propagación a las 25 pantallas:

```text
FL-SC-004    materialización visual incorrecta de defaults Color en varias instancias
UX           escala tipográfica 7–10 demasiado pequeña para uso real y demostración
```

Además se incorporó la regla de identidad de Canvas Components:

> una definición corregida no debe agregarse como nueva copia si el componente ya tiene instancias; debe actualizarse in situ o migrarse de forma controlada.

Baseline Comfortable:

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

## 5. RiskMatrixPro premium 5×5

`cmp_FL_RiskMatrixPro` tiene como fuente de verdad visual la referencia premium aprobada durante la revisión del 11 de agosto.

La RC3 canónica conserva:

```text
900×650
5×5 como caso principal AMEF
Severidad 5→1
Ocurrencia 1→5
selección S=4 / O=3
Detección=3
S×O=12
NPR=36
KPI strip inferior
nota de escala discreta
```

La matriz no debe volver a convertirse en una tabla compacta para hacerla caber.

Estado RC3:

```text
SOURCE candidate          publicado
Studio render             evidencia disponible
VISUAL_QA final           pendiente
```

## 6. scr_FL_AMEF — workspace por etapa

Se retira la composición que intentaba mostrar simultáneamente efectos, matriz, decisión y gate.

Nuevo patrón:

```text
FL-07          Efectos + contexto + criticidad
FL-09          Matriz de riesgo AMEF premium 5×5
FL-08/10/11    Resultado AMEF + decisión humana + control de avance
```

El Process Rail permanece visible y actúa como navegación interna entre las etapas AMEF sin recrear la pantalla.

Para liberar superficie útil en este workspace denso:

```text
Sidebar        colapsado a 76
ProcessRail    250
Header         100
Work area      resto del ancho
RiskMatrix     900×650 centrada en FL-09
```

Esto permite mantener la matriz premium sin reducir tipografía ni deformar las celdas.

Archivo canónico:

`power-apps/screens/scr_FL_AMEF.pa.yaml`

## 7. Semántica AMEF preservada

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

La decisión final de consecuencia sigue siendo autoridad humana, separada del cálculo y de la recomendación del sistema.

## 8. Próximo gate Studio

Actualizar in situ únicamente las definiciones que hayan cambiado y validar:

```text
Home
→ Registro de análisis
→ P101-AMEF-RCM-001
→ AMEF
```

Comprobación discriminante:

```text
FL-07  muestra efectos/contexto sin clipping
FL-09  muestra RiskMatrixPro 900×650 completa
FL-08/10/11 muestran decisión + gate
Process Rail conmuta entre estas vistas sin error
P-101 se mantiene cargado
S=4 / O=3 / D=3 / NPR=36
texto legible a 100%
sin bloques negros
sin duplicación de componentes
```

Hasta esta validación:

```text
PASS_STATIC / source candidate    SÍ
DEFINITION_ACCEPTED               pendiente Studio para esta revisión
VISUAL_QA_VALIDATED               NO
READY_FOR_INTEGRATION             NO
```

## 9. Estado del plan integrado

```text
1 Home / bootstrap                       PASS
2 Activos + criticidad                   PASS
3 Biblioteca AMEF                        PASS
4 Aplicación multi-activo                PASS
5 AnalysisCase                           PAUSADO — gate visual AMEF
6 Failure Modes / causas                 pendiente
7 AMEF                                   candidato premium publicado / Studio QA pendiente
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
