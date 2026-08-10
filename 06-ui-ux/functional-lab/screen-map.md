# CMMS 2.0 Functional Lab — Mapa real de pantallas alineado

**Estado:** canónico tras auditoría de reuniones  
**Fecha:** 2026-08-10

## 1. Regla

Las pantallas representan objetos o trabajos reconocibles. El usuario debe distinguir si está trabajando sobre:

```text
biblioteca de ingeniería
contexto del activo
aplicación a activo
planificación / ejecución
gobernanza / mejora
```

## 2. Mapa

| Orden | Pantalla | Módulo | Trabajo principal |
|---:|---|---|---|
| 01 | `scr_FL_Home` | Inicio | Ver trabajo, revisiones, aplicaciones y casos activos |
| 02 | `scr_FL_FLH` | Activos | Navegar jerarquía FLH y situar P-101 |
| 03 | `scr_FL_Taxonomy` | Activos | Navegar clasificación del activo |
| 04 | `scr_FL_ADR` | Activos | Navegar relaciones/dependencias ADR |
| 05 | `scr_FL_AssetCriticality` | Activos | Ver criticidad contextual del activo y su fuente |
| 06 | `scr_FL_Asset360` | Activos | Ver ficha 360, revisión AMEF aplicada y planes asociados |
| 07 | `scr_FL_FmeaLibrary` | Estrategia | Buscar AMEF reutilizables por familia/tipo de equipo |
| 08 | `scr_FL_FmeaRevision` | Estrategia | Revisar ingeniería base: funciones, fallos, modos, causas, efectos y tareas propuestas |
| 09 | `scr_FL_AssetApplication` | Estrategia | Aplicar una revisión AMEF a uno o varios activos y gestionar perfiles/overrides |
| 10 | `scr_FL_AnalysisRegister` | Estrategia | Buscar y abrir casos contextuales de análisis |
| 11 | `scr_FL_CaseOverview` | Estrategia | Ver revisión heredada, activo, criticidad, aplicación y journey de 28 etapas |
| 12 | `scr_FL_Context` | Estrategia | FL-01..03: alcance, contexto, aplicabilidad y preparación |
| 13 | `scr_FL_Functions` | Estrategia | FL-04..05: revisar funciones/fallos heredados y registrar override contextual si procede |
| 14 | `scr_FL_FailureModes` | Estrategia | FL-06: seleccionar modos aplicables de biblioteca y causas/mecanismos asociados |
| 15 | `scr_FL_AMEF` | Estrategia | FL-07..11: efectos heredados/contextuales, consecuencias, S/O/D, riesgo AMEF y control de avance |
| 16 | `scr_FL_RCM` | Estrategia | FL-12..16: ejecutar lógica RCM versionada y emitir decisión explicable |
| 17 | `scr_FL_Economics` | Estrategia | FL-17: comparar económicamente alternativas técnicamente válidas |
| 18 | `scr_FL_Task` | Estrategia | FL-18..19: convertir tarea propuesta en tarea ejecutable, intervalo, recursos y procedimiento opcional |
| 19 | `scr_FL_PlanPackage` | Estrategia | FL-20..22: alcance físico, H-H, restricciones y agrupación candidata |
| 20 | `scr_FL_Traceability` | Estrategia | FL-23..24: trazabilidad Biblioteca → Aplicación → Plan → Ejecución y control de calidad |
| 21 | `scr_FL_ReviewApproval` | Estrategia | FL-25..26: revisión multidisciplinar, aprobación y snapshot |
| 22 | `scr_FL_Effectiveness` | Estrategia | FL-27..28: comparar hipótesis con ejecución real y abrir cambio |
| 23 | `scr_FL_MaintenancePlans` | Planes | Ver Job Plan/Route, PM, objetos y trazabilidad por tag |
| 24 | `scr_FL_Governance` | Gobernanza | Versiones, aprobaciones, findings y cambios de biblioteca/aplicación |
| 25 | `scr_FL_Settings` | Configuración | Preferencias, catálogos y reglas conceptuales configurables |

**Total: 25 pantallas canónicas.**

## 3. Navegación principal

```text
Inicio
Activos
Estrategia de mantenimiento
Planes de mantenimiento
Gobernanza
Configuración
```

## 4. Navegación dentro de Activos

```text
FLH | Taxonomía | ADR | Criticidad | Ficha 360
```

La criticidad se muestra como análisis de contexto de planta independiente del AMEF.

## 5. Navegación dentro de Estrategia

Antes de abrir un `AnalysisCase`, el usuario debe poder distinguir:

```text
Biblioteca AMEF
      ↓
Revisión de biblioteca
      ↓
Aplicación a activos
      ↓
Caso de análisis contextual
```

## 6. Navegación dentro de AnalysisCase

Las pantallas 11–22 incluyen:

- activo y aplicación actuales;
- revisión AMEF de origen;
- criticidad contextual utilizada;
- estado Draft/Confirmed/Approved cuando aplique;
- `cmp_FL_ProcessRailPro`;
- responsabilidad actual;
- control de avance;
- lineage Biblioteca → Aplicación → Plan/ejecución.

## 7. Mapeo FL-01…FL-28

```text
FL-01 ─┐
FL-02  ├─ scr_FL_Context
FL-03 ─┘

FL-04 ─┐
FL-05 ─┴─ scr_FL_Functions

FL-06 ─── scr_FL_FailureModes

FL-07 ─┐
FL-08  │
FL-09  ├─ scr_FL_AMEF
FL-10  │
FL-11 ─┘

FL-12 ─┐
FL-13  │
FL-14  ├─ scr_FL_RCM
FL-15  │
FL-16 ─┘

FL-17 ─── scr_FL_Economics

FL-18 ─┐
FL-19 ─┴─ scr_FL_Task

FL-20 ─┐
FL-21  ├─ scr_FL_PlanPackage
FL-22 ─┘

FL-23 ─┐
FL-24 ─┴─ scr_FL_Traceability

FL-25 ─┐
FL-26 ─┴─ scr_FL_ReviewApproval

FL-27 ─┐
FL-28 ─┴─ scr_FL_Effectiveness
```

## 8. Interpretación corregida de FL-01…FL-06

Estas etapas **no vuelven a crear el AMEF desde cero**.

El usuario:

```text
confirma activo y alcance
→ revisa contexto de operación
→ confirma preparación/evidencia
→ revisa funciones y fallos heredados
→ registra override si existe una excepción real
→ confirma qué modos/cusas son aplicables al activo
```

La fuente sigue siendo `FmeaRevision`.

## 9. AMEF

`scr_FL_AMEF` debe mostrar simultáneamente:

```text
criticidad del activo        → contexto externo
modo/causa/efecto AMEF       → biblioteca + aplicación
S/O/D                         → valoración humana contextual
matriz S×O                    → cálculo de riesgo AMEF
NPR                           → cálculo automático
consecuencia                  → recomendación + decisión humana
```

Nunca llamar `Matriz de criticidad` a S×O.

## 10. Task / Plan Package

`scr_FL_Task` debe diferenciar:

```text
ProposedMaintenanceTask      ingeniería base
TaskProfileVariant           ajuste por aplicación/criticidad
MaintenanceTask              tarea ejecutable confirmada
MaintenanceProcedure         procedimiento/checklist opcional
```

`scr_FL_PlanPackage` debe mostrar:

```text
PlanScopeItem                tags incluidos
EstimatedDuration / H-H      carga
RequiredOperatingState       restricción
Grouping rule                criterio de agrupación
Job Plan / Route candidate   salida
```

## 11. Maintenance Plans

La pantalla de Planes no debe tratar como sinónimos:

```text
MaintenanceTask
MaintenanceProcedure
JobPlan / Route
PreventiveMaintenancePlan
WorkOrder
```

Debe conservar identidad y resultados por `TechnicalObject` aunque varios objetos compartan una ruta o plan.

## 12. Estados visuales

Toda pantalla productiva soportará conceptualmente:

```text
loading
ready
empty
error
draft
blocked
warning
confirmed
approved
read-only
superseded
```

## 13. Criterios de autenticidad

Una pantalla no se acepta si:

- convierte P-101 en propietario de la ingeniería AMEF genérica;
- confunde criticidad de activo con riesgo AMEF;
- duplica una revisión completa para cambiar solo frecuencia/aplicabilidad;
- oculta causas/mecanismos;
- fuerza relación 1:1 entre tarea y modo;
- obliga a disponer de procedimiento para toda tarea;
- coloca parada/permiso únicamente en el paquete de plan;
- omite duración, cuadrilla o H-H cuando la tarea se vuelve ejecutable;
- mezcla coste preliminar, estimado y real;
- codifica el árbol RCM como una secuencia irreversible de campos;
- agrupa equipos perdiendo trazabilidad por tag;
- usa Job Plan, PM y WO como sinónimos;
- no muestra cómo el resultado de ejecución vuelve a la ingeniería.
