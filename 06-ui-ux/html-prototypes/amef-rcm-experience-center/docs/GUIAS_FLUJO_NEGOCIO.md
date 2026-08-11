# Guías prácticas del flujo de negocio AMEF–RCM

**Estado:** alineado con Functional Lab v2  
**Fecha de revisión:** 2026-08-11

## Objetivo

Las guías prácticas deben explicar el proceso de negocio, no los botones de los prototipos.

A partir de la revisión library-first deben enseñar una idea central:

```text
Engineering Library
→ Asset Application
→ Execution Plan
→ Results & Learning
```

P-101 sigue siendo el ejemplo que conecta las etapas, pero funciones, fallos, modos y tratamientos reutilizables pertenecen a una revisión de biblioteca, no al activo.

## Cobertura revisada

1. **Construir y revisar la biblioteca de ingeniería:** definición/revisión AMEF, funciones, fallos, modos, causas, efectos y evidencia reusable.
2. **Evaluar consecuencias y decidir con RCM:** riesgo AMEF, controles, lógica RCM versionada, P–F, políticas y salida con tarea o decisión explícita sin tarea.
3. **Diseñar el tratamiento reusable:** `MaintenanceTask`, relación N:M con modos, procedimiento/formato opcionales, coste estimado, comparación económica y publicación de revisión.
4. **Aplicar a un activo y construir su plan:** `FmeaAssetApplication`, contexto operacional, criticidad del activo independiente del riesgo, aplicabilidad, variantes, overrides y `ExecutionPlan`.
5. **Registrar resultados y mejorar:** ejecución, mediciones, hallazgos, coste real, efectividad, ajuste contextual o nueva revisión de ingeniería.

## Conceptos que las guías deben mantener separados

### Riesgo AMEF vs criticidad del activo

```text
ConsequenceAssessment
≠
AssetCriticalitySnapshot
```

El primero pertenece a la biblioteca/análisis del modo. El segundo pertenece a la aplicación contextual sobre un activo.

### Tarea vs procedimiento vs formato

```text
MaintenanceTask
├─ MaintenanceProcedure? 
└─ InspectionFormat?
```

La tarea define qué mantenimiento y para qué. El procedimiento explica cómo. El formato define qué se registra.

### Economía

```text
EconomicAssessment        = decisión
MaintenanceCostEstimate   = previsión
ActualMaintenanceCost     = observado
```

### Publicado vs contextual

Una aplicación o un plan puede variar sin alterar una `FmeaRevision` publicada. Si cambia el conocimiento de ingeniería, se crea una nueva revisión.

## Uso recomendado en las reuniones

Antes de entrar en una pantalla, abrir la guía y validar:

1. ¿En qué capa estamos?
2. ¿Qué objeto estamos decidiendo o editando?
3. ¿Este dato debe ser reusable o específico de un activo?
4. ¿La decisión humana y la recomendación del sistema están separadas?
5. ¿El output tiene IDs suficientes para la siguiente capa?
6. ¿Un cambio aquí exige nueva revisión de biblioteca o solo ajustar aplicación/plan?

## Límite

Las guías describen el modelo funcional propuesto. Roles, gates, evidencias mínimas, autoridades, matrices, esquemas de criticidad, umbrales y fórmulas deberán validarse corporativamente antes de convertirse en especificación productiva para IT.
