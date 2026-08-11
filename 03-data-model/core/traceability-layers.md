# Modelo conceptual — Trazabilidad por capas

**Estado:** canónico para Functional Lab  
**Fecha:** 2026-08-11

## 1. Objetivo

Definir qué identificadores y relaciones debe conservar CMMS 2.0 para explicar una decisión de mantenimiento desde la ingeniería reutilizable hasta los resultados reales.

## 2. Cadena mínima

```text
FmeaDefinition
→ FmeaRevision
→ FailureMode
→ RcmAssessment
→ MaintenanceTask | NoScheduledTaskDecision
→ FmeaAssetApplication
→ ExecutionPlan
→ ExecutionPlanTask
→ MaintenanceResult
→ EffectivenessReview
```

La cadena no exige que todos los objetos vivan en la misma base de datos. Exige que puedan relacionarse de forma estable.

## 3. Cuatro capas y su responsabilidad

### 3.1 Engineering Library

Responde:

> ¿Qué conocimiento de ingeniería está aprobado y por qué?

Conserva:

- identidad del AMEF;
- revisión exacta;
- funciones/fallos/modos/causas/efectos;
- evaluación de consecuencias;
- lógica y respuestas RCM;
- tareas reusable o decisiones sin tarea;
- evaluación económica y estimaciones;
- evidencia, aprobaciones y snapshot.

### 3.2 Asset Application

Responde:

> ¿Por qué esta revisión aplica —o no aplica— a este activo y contexto?

Conserva:

- revisión de biblioteca consumida;
- activo;
- contexto operacional congelado;
- criticidad del activo y su fuente;
- resultado automático de aplicabilidad;
- validación humana;
- overrides y motivos;
- selección/variación de tareas.

### 3.3 Execution Plan

Responde:

> ¿Qué trabajo concreto quedó configurado para ejecutarse?

Conserva:

- aplicación origen;
- tareas origen;
- intervalos/disparadores efectivos;
- procedimiento y formato aplicados;
- alcance físico;
- recursos y condiciones;
- revisión/snapshot del plan.

### 3.4 Results & Learning

Responde:

> ¿Qué ocurrió realmente y qué aprendimos?

Conserva:

- plan y tarea ejecutados;
- resultados y mediciones;
- hallazgos;
- tiempo/materiales;
- coste real;
- desviación respecto a hipótesis;
- decisión de mantener, ajustar o reabrir ingeniería.

## 4. Trace envelope mínimo

Todo objeto de decisión relevante deberá poder exponer, cuando aplique:

```text
objectId
objectType
sourceObjectId
sourceObjectType
revisionOrVersion
validationStatus
actorRole
actorId/demoActor
timestamp
evidenceRefs
reason
correlationId
```

En el Functional Lab `actorId` puede ser un usuario de demostración. El modelo final de identidad sigue pendiente.

## 5. Trazabilidad de la tarea

Una tarea visible en un plan debe poder reconstruirse como:

```text
ExecutionPlanTask
→ MaintenanceTask
→ MaintenanceTaskFailureMode
→ FailureMode
→ FunctionalFailure
→ FmeaFunction
→ FmeaRevision
→ FmeaDefinition
```

Si la tarea utiliza un procedimiento o formato:

```text
ExecutionPlanTask
→ MaintenanceProcedureRevision
→ MaintenanceProcedure

ExecutionPlanTask
→ InspectionFormatRevision
→ InspectionFormat
```

La versión exacta utilizada debe conservarse en el snapshot del plan o ejecución.

## 6. Trazabilidad de la criticidad

La criticidad usada para una aplicación debe poder explicarse sin consultar la matriz AMEF:

```text
FmeaAssetApplication
→ AssetCriticalitySnapshot
→ CriticalitySchemeVersion
→ sourceValue
→ override? + reason + authority
```

Esto evita inferir criticidad desde `S×O`, NPR u otro indicador AMEF.

## 7. Trazabilidad económica

### Antes de publicar ingeniería

```text
EconomicAssessment
→ scenario assumptions
→ FailureMode / RcmAssessment
→ candidate MaintenanceTask(s)
```

### Antes de publicar el plan

```text
MaintenanceCostEstimate
→ MaintenanceTask | ExecutionPlanTask
→ rates / effort / materials / frequency assumptions
```

### Después de ejecutar

```text
ActualMaintenanceCost
→ MaintenanceResult
→ ExecutionPlanTask
```

La comparación entre las tres capas debe ser analítica; nunca se sobrescribe una con otra.

## 8. Trazabilidad de cambios

### Cambio en biblioteca

Si la evidencia real cuestiona una hipótesis de ingeniería:

```text
MaintenanceResult
→ EffectivenessReview
→ EngineeringChangeRequest
→ new FmeaRevision
```

La revisión anterior sigue siendo consultable.

### Cambio solo en aplicación/plan

Si la biblioteca sigue siendo válida pero cambia el contexto del activo:

```text
FmeaAssetApplication
→ new application revision / decision
→ new ExecutionPlan revision
```

No se debe crear una nueva revisión AMEF por una variación que solo pertenece al activo.

## 9. Traceability View del Functional Lab

La UI deberá permitir una vista transversal con cuatro segmentos:

```text
[LIBRARY]
FMEA-PUMP-CW-001 / Rev 1
        ↓
[ASSET APPLICATION]
P-101 / APP-001
        ↓
[EXECUTION PLAN]
PLAN-P101-001 / Rev 1
        ↓
[RESULTS]
RESULT-... / Effectiveness Review
```

Cada salto debe mostrar:

- identificador;
- estado/revisión;
- qué decisión creó el vínculo;
- si hubo override;
- evidencia disponible.

## 10. Regla de UI

Los breadcrumbs visuales no sustituyen las referencias de datos.

Una pantalla puede ocultar complejidad, pero ningún output estructurado del laboratorio debe depender de reconstruir relaciones desde textos visibles, nombres de tarea o código de activo.
