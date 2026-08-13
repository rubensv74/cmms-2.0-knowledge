# Auditoría de alineación — CMMS 2.0 Functional Lab vs últimas reuniones

**Fecha:** 2026-08-10  
**Estado:** auditoría funcional / requiere correcciones de modelo  
**Ámbito:** reuniones y documentación revisadas en julio-agosto de 2026, con especial peso de la revisión CMMS del 31/07 y la presentación de Planes de Mantenimiento O&M del 22/07.

## 1. Conclusión ejecutiva

CMMS 2.0 Functional Lab **está alineado con la filosofía y el recorrido general**, pero **todavía no cumple rigurosamente todos los acuerdos y conclusiones funcionales de las últimas reuniones**.

La desviación principal es estructural: la v2 está construida alrededor de un `AnalysisCase` contextual por activo, mientras que en las reuniones se confirmó que el AMEF debe existir como **ingeniería reutilizable por tipo de equipo**, mantenida en una biblioteca y aplicada después a activos/proyectos concretos con ajustes por criticidad, configuración, servicio y particularidades.

El Functional Lab actual es válido como demostración del razonamiento de P-101, pero no debe considerarse todavía un modelo funcional cerrado para IT.

## 2. Aspectos correctamente alineados

Se consideran bien trasladados:

- empezar por funciones y no por tareas;
- separar función, fallo funcional y modo de fallo;
- considerar fallos ocultos y lógica de detección;
- utilizar AMEF + RCM/MCC de forma complementaria;
- mantener la decisión humana separada del cálculo o recomendación del sistema;
- conservar trazabilidad desde el razonamiento hasta la tarea/plan;
- incorporar revisión, aprobación, versiones y mejora continua;
- mantener FLH, Taxonomía y ADR como estructuras distintas;
- conservar la identidad individual del activo;
- incorporar recursos, seguridad, permisos, intervalo y economía como parte del proceso;
- tratar el sistema destino como una integración futura, no como el modelo funcional;
- usar P-101 como caso de demostración y no como estructura fija del producto.

## 3. Desviaciones que deben corregirse

### D-01 — Falta una biblioteca AMEF reutilizable por tipo de equipo

**Severidad:** CRÍTICA

En la reunión se confirmó que no se pretende desarrollar un AMEF desde cero para cada activo/proyecto. Debe existir un catálogo o biblioteca corporativa por tipo de equipo —por ejemplo bomba centrífuga, compresor centrífugo, compresor reciprocante— que después se reutiliza y ajusta.

**Situación actual**

Las entidades `Function`, `FunctionalFailure`, `FailureModeSelection`, `FailureEffect` y parte de `RiskAssessment` dependen directamente de `AnalysisCase`.

**Problema**

Esto convierte P-101 en propietario del análisis, cuando debería ser principalmente una aplicación contextual de una revisión AMEF reutilizable.

**Corrección propuesta**

Introducir al menos:

```text
FmeaDefinition
FmeaRevision
FmeaFunction
FunctionalFailure
FailureMode
FailureCause
FailureEffect
ProposedMaintenanceTask
```

El `AnalysisCase` debe referenciar una revisión de biblioteca y conservar únicamente contexto, aplicación, decisiones y overrides específicos.

---

### D-02 — Se está mezclando riesgo AMEF con criticidad del equipo en planta

**Severidad:** CRÍTICA

La reunión corrigió expresamente este punto: la **criticidad del equipo es un análisis de riesgo a nivel de equipo/planta y es independiente del AMEF genérico**. La criticidad depende de la posición en planta, redundancia, producción, servicio y consecuencias para el proceso.

**Situación actual**

`scr_FL_AMEF` denomina al control `Matriz de criticidad` y calcula una matriz S×O por modo de fallo.

**Problema**

Puede hacer pensar que la matriz S×O del AMEF es la criticidad del activo en planta.

**Corrección propuesta**

- renombrar visualmente a `Matriz de riesgo AMEF` o `Matriz S×O`;
- introducir `AssetCriticalityAssessment` o referencia equivalente;
- mostrar la criticidad del activo como **input contextual externo** al AMEF;
- mantener el riesgo S/O/D del modo separado de la criticidad de P-101 en planta.

---

### D-03 — Falta el modelo de aplicabilidad AMEF → múltiples activos

**Severidad:** CRÍTICA

La reunión confirmó que un AMEF genérico se aplica a múltiples activos y que el contexto puede cambiar frecuencias, selección de tareas o incluso conducir a operar hasta fallo.

**Situación actual**

El flujo está centrado en un único `AnalysisCase` / `TechnicalObject`.

**Corrección propuesta**

Introducir:

```text
FmeaApplicabilityRule
FmeaAssetApplication
MaintenanceApplicabilityProfile
TaskProfileVariant
```

Debe ser posible visualizar una matriz de activos aplicables y registrar excepciones sin clonar funciones, fallos y modos.

---

### D-04 — Los perfiles de criticidad Alta / Media / Baja / Despreciable no están representados

**Severidad:** ALTA

En la documentación revisada y en el AMEF de referencia, la criticidad del activo cambia principalmente frecuencias y, en algunos casos, la selección del tratamiento.

**Situación actual**

No existe un objeto de perfil que derive variantes de frecuencia o tratamiento a partir de la criticidad contextual del activo.

**Corrección propuesta**

Modelar perfiles versionados separados del AMEF base. No duplicar el AMEF completo por nivel.

---

### D-05 — Falta `FailureCause` / mecanismo de fallo como entidad explícita

**Severidad:** ALTA

Las reuniones y especificaciones previas distinguen modo, causa/mecanismo y efecto.

**Situación actual**

El dominio v2 contiene `FailureModeSelection` y `FailureEffect`, pero no una entidad explícita `FailureCause`.

**Corrección propuesta**

Añadir `FailureCause` y permitir cardinalidad suficiente para relacionar causas/mecanismos con modos y evidencias.

---

### D-06 — La relación tarea ↔ modo de fallo no está modelada como muchos-a-muchos

**Severidad:** ALTA

Una tarea puede tratar varios modos y un modo puede requerir varias tareas. Esta separación ya estaba recogida en la especificación funcional anterior.

**Situación actual**

`MaintenanceTask` depende del caso/estrategia, pero no existe una relación explícita N:M con los modos tratados.

**Corrección propuesta**

Añadir una relación como:

```text
ProposedTaskFailureMode
```

---

### D-07 — Falta el vínculo opcional entre tarea y procedimiento/checklist

**Severidad:** ALTA

Durante la reunión se confirmó que algunas tareas necesitan procedimiento y otras no. Esta condición debe quedar explícita y no forzar un procedimiento inexistente.

**Situación actual**

`MaintenanceTask` no contiene `ProcedureRequired`, `ProcedureId` ni relación equivalente.

**Corrección propuesta**

Separar:

```text
MaintenanceTask
MaintenanceProcedure / InspectionFormat
TaskProcedureLink
```

permitiendo tareas sin procedimiento asociado.

---

### D-08 — Estado operativo requerido está a nivel de paquete y debería existir a nivel de tarea

**Severidad:** MEDIA-ALTA

En la documentación de mantenimiento aparece explícitamente si el equipo debe estar fuera de servicio para ejecutar una actividad.

**Situación actual**

`MaintenancePlanPackage` dispone de `ShutdownRequirement`, pero la tarea no conserva necesariamente esta condición.

**Corrección propuesta**

Añadir a la tarea o a su variante ejecutable:

```text
RequiredOperatingState
RequiresShutdown
IsolationRequirement
PermitRequirement
```

El paquete podrá derivar sus restricciones de las tareas que contiene.

---

### D-09 — Horas-hombre, duración y carga de trabajo están insuficientemente modeladas

**Severidad:** ALTA

Las fuentes revisadas utilizan duración, H-H y especialidad tanto para costes como para gestionar la construcción de rutas y carga de mantenimiento.

**Situación actual**

`ResourceRequirement` permite cantidad/unidad, pero no existe un contrato claro para duración estimada, personas, H-H por disciplina ni reglas de balanceo.

**Corrección propuesta**

Incorporar:

```text
EstimatedDuration
CrewSize
EstimatedManHours
Discipline / WorkCenter
```

y mantener la posibilidad de coste estimado y real.

---

### D-10 — La economía está adelantada respecto al detalle de recursos

**Severidad:** MEDIA

La pantalla económica actual aparece antes de completar tarea, intervalo y recursos. Esto puede ser válido para una comparación preliminar de alternativas, pero no para representar el coste real o el coste defendible del mantenimiento.

**Corrección propuesta**

Separar dos conceptos:

```text
EconomicAssessment          decisión RCM / comparación preliminar
MaintenanceCostEstimate     derivado de tarea + recursos + frecuencia
ActualMaintenanceCost       procedente de ejecución
```

No utilizar una única cifra de coste para los tres propósitos.

---

### D-11 — El árbol RCM no está modelado todavía como lógica versionada

**Severidad:** ALTA

La reunión identifica el diagrama SAE JA1012 como lógica genérica. La especificación anterior ya preveía árbol, preguntas, transiciones y respuestas versionadas.

**Situación actual**

`RCMAnalysis` contiene campos directos (`IsEvident`, `IsDetectable`, etc.), pero no objetos `DecisionLogic`, `DecisionQuestion`, `DecisionTransition` y `RcmAssessmentAnswer`.

**Corrección propuesta**

Mantener la pantalla actual como experiencia, pero cambiar el contrato de dominio para que el árbol sea configurable/versionable. El árbol corporativo concreto seguirá pendiente de validación.

---

### D-12 — Falta representar de forma completa el equipo principal y sus equipos de soporte en el plan

**Severidad:** ALTA

La presentación de O&M utiliza el equipo principal como volumen de control que puede incluir instrumentación, bombas auxiliares, intercambiadores, etc. La identidad individual no debe perderse.

**Situación actual**

ADR puede representar relaciones, y `MaintenancePlanPackage` dispone de `Grouping`, pero no existe un contrato explícito para el alcance físico de múltiples objetos con trazabilidad individual.

**Corrección propuesta**

Añadir un objeto de alcance, por ejemplo:

```text
PlanScopeItem
TechnicalObjectId
RoleInScope
IncludedTaskId
```

La agrupación administrativa no debe eliminar historial, resultados ni costes por tag.

---

### D-13 — El modelo no llega todavía con precisión a Job Plan / Ruta / PM / WO

**Severidad:** ALTA para el modelo global; MEDIA para el alcance actual del laboratorio

Las conclusiones previas separan expresamente AMEF, RCM, tarea propuesta, procedimiento/Job Plan, estrategia, plan preventivo y orden de trabajo.

**Situación actual**

El dominio contiene `MaintenanceTask`, `MaintenanceStrategy` y `MaintenancePlanPackage`, pero no define todavía de forma explícita `JobPlan`/`MaintenanceProcedure`, `PreventiveMaintenancePlan` y `WorkOrder`.

**Corrección propuesta**

Mantener el Functional Lab centrado en ingeniería, pero extender el mapa conceptual y contratos para mostrar el handoff sin convertir esos objetos en sinónimos.

---

### D-14 — Falta representar las reglas de optimización del modelo de planes

**Severidad:** MEDIA-ALTA

La presentación de O&M identifica como problema real la proliferación de hojas de ruta y planes, y plantea agrupación por frecuencia/ciclo, actividad, planta, ejecutor y listas de objetos, conservando registro por tag.

**Situación actual**

`MaintenancePlanPackage.Grouping` es demasiado genérico para demostrar esta lógica.

**Corrección propuesta**

Incorporar conceptualmente:

```text
MaintenanceCycle
RouteGroupingRule
ObjectList
Route / JobPlan candidate
PerAssetExecutionTracking
```

Las reglas exactas seguirán pendientes de validación, pero el dominio debe permitirlas.

## 4. Elementos que NO deben tratarse como desviaciones todavía

Los siguientes puntos continúan abiertos corporativamente; el Functional Lab puede simularlos siempre que se etiqueten como propuesta:

- escalas AMEF oficiales;
- umbrales y colores de riesgo;
- árbol RCM definitivo y correspondencia exacta con SAE JA1011/JA1012;
- reglas definitivas de P-F e intervalo;
- autoridades y permisos finales;
- mínimo de evidencias y niveles de confianza;
- reglas de sobreclasificación;
- criterios de aprobación;
- KPIs y umbrales de revisión;
- integración técnica con SAP, IBM Maximo, Hexagon u otro sistema;
- arquitectura física de base de datos.

## 5. Prioridad de corrección

### Bloque A — corregir antes de continuar la validación funcional profunda

1. D-01 Biblioteca AMEF.
2. D-02 Separar criticidad de activo y riesgo AMEF.
3. D-03 Aplicabilidad multi-activo.
4. D-04 Perfiles de criticidad.
5. D-05 Causas/mecanismos de fallo.
6. D-06 Relación N:M tarea-modo.
7. D-11 Árbol RCM versionable.

### Bloque B — corregir antes de cerrar Task / Plan Package

8. D-07 Procedimientos opcionales.
9. D-08 Estado operativo por tarea.
10. D-09 H-H/duración/carga.
11. D-10 Capas de coste.
12. D-12 Alcance físico de equipo principal e hijos.
13. D-14 Reglas de agrupación/optimización.

### Bloque C — completar antes de especificación para IT

14. D-13 Separación explícita Job Plan / PM / WO y contratos de handoff.

## 6. Modelo objetivo resumido

```text
BIBLIOTECA DE INGENIERÍA
FmeaDefinition
  └─ FmeaRevision
      ├─ Functions
      ├─ FunctionalFailures
      ├─ FailureModes
      ├─ FailureCauses
      ├─ FailureEffects
      ├─ DecisionLogic / RCM
      └─ ProposedMaintenanceTasks

CONTEXTO DE PLANTA
TechnicalObject
AssetCriticalityAssessment
FLH / Taxonomy / ADR

APLICACIÓN
FmeaAssetApplication
  ├─ ApplicabilityProfile
  ├─ Context overrides
  ├─ TaskProfileVariants
  └─ Human decisions

EJECUTABILIDAD
MaintenanceTask
MaintenanceProcedure / InspectionFormat
ResourceRequirement
IntervalJustification
PlanScopeItem
MaintenancePlanPackage

HANDOFF CMMS
JobPlan / Route
MaintenanceStrategy
PreventiveMaintenancePlan
WorkOrder
ExecutionResult
ActualCost

GOBIERNO
TraceLink
Review / Approval
VersionSnapshot
EffectivenessMeasurement
ChangeRequest
AuditEvent
```

## 7. Conclusión

El Functional Lab actual **no debe descartarse**. La mayoría de sus pantallas, componentes y experiencia pueden conservarse. La corrección principal está en el **modelo de dominio y la narrativa de propiedad de los datos**:

> primero existe ingeniería AMEF/RCM reutilizable; después esa ingeniería se aplica a activos concretos utilizando criticidad y contexto; finalmente las decisiones aplicadas se convierten en trabajo ejecutable, se agrupan de forma gestionable y regresan a ingeniería mediante resultados reales.

Esta corrección debe realizarse antes de presentar la arquitectura v2 como fiel reflejo definitivo de las reuniones.