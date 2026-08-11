# CMMS 2.0 Functional Lab — Estado canónico alineado

**Fecha:** 2026-08-11  
**Rama:** `feature/f01-premium-foundation`  
**Estado global:** corrección funcional D-01…D-14 implementada / Home + Activos + Biblioteca AMEF + Aplicación multi-activo validados / implementación visual pausada para corregir foundation

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

## 4. Incidencias foundation abiertas

### FL-SC-004 — colores de componentes

Se observó que varias instancias materializan como negro colores que en Source Code tienen defaults claros.

El patrón correctivo safe-palette está publicado, pero **no debe introducirse agregando nuevas copias de componentes existentes**, porque Studio crea una identidad nueva y las pantallas continúan asociadas a la original.

La corrección definitiva deberá preservar identidad de componente o realizar migración controlada de instancias.

### Legibilidad tipográfica — nueva corrección obligatoria

La inspección visual confirmó que la escala anterior era demasiado pequeña para una aplicación que debe utilizarse en escritorio y demostrarse en reuniones.

Se retira como baseline la escala basada en tamaños 7–10.

Nuevo estándar canónico:

`TYPOGRAPHY_AND_DENSITY_STANDARD.md`

Reglas principales:

```text
texto visible mínimo     11
supporting               12
label                    12–13
body                     13–14
section title            16–18
page title               24–28
button                    12–13
```

No se reducirá tipografía para evitar scroll.

## 5. Decisión de implementación

**No volver a implementar todavía las 25 pantallas ni los componentes.**

La secuencia correcta es:

```text
1. cerrar estrategia de preservación de identidad de componentes
2. corregir foundation visual de componentes
3. aplicar paleta segura
4. aplicar escala tipográfica Comfortable
5. reajustar alturas, padding y gaps
6. validar scr_FL_AMEF como pantalla de alta densidad
7. solo si AMEF supera QA, propagar el patrón al resto
8. reanudar los smokes funcionales desde AnalysisCase
```

## 6. Gate de referencia — scr_FL_AMEF

AMEF se utilizará como pantalla discriminante porque contiene simultáneamente:

```text
Sidebar
PageHeader
ProcessRail
LineagePanel
TextInputs
RiskMatrix
DecisionPanel
GatePanel
```

Debe pasar:

```text
[ ] paleta correcta
[ ] ningún texto visible < 11
[ ] body >= 13
[ ] títulos >= 16
[ ] botones/inputs con altura suficiente
[ ] ningún clipping
[ ] scroll antes que reducción tipográfica
[ ] P-101 y contexto correctamente cargados
[ ] lectura cómoda a 100% zoom
```

Hasta superar este gate:

```text
PASS_STATIC              parcial
INSTANCE_SAFE            evidencia previa por bloques
VISUAL_QA_VALIDATED      NO
READY_FOR_INTEGRATION    NO
```

## 7. Estado del plan integrado

```text
1 Home / bootstrap                       PASS
2 Activos + criticidad                   PASS
3 Biblioteca AMEF                        PASS
4 Aplicación multi-activo                PASS
5 AnalysisCase                           PAUSADO — foundation visual
6 Failure Modes / causas                 pendiente
7 AMEF                                   pendiente QA visual
8 RCM                                    pendiente
9 Task                                   pendiente
10 Plan Package / Maintenance Plans      pendiente
11 Trazabilidad / revisión / efectividad pendiente
```

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
