# CMMS 2.0 Functional Journey

**Versión conceptual:** v2 — library-first  
**Estado:** canónico para Functional Lab

## 1. Propósito

Definir el recorrido funcional independiente de la interfaz. Este documento establece qué procesos existen, qué responsabilidad tiene cada etapa y cómo se agrupan posteriormente en workspaces del Functional Lab.

Regla:

> Una etapa funcional no equivale necesariamente a una pantalla.

## 2. Principio de recorrido

El journey sigue cuatro capas explícitas:

```text
Engineering Library
→ Asset Application
→ Execution Plan
→ Results & Learning
```

La biblioteca de ingeniería es anterior al activo concreto. Una revisión AMEF/RCM se crea, gobierna y publica como conocimiento reusable; después se evalúa su aplicación a un activo y contexto determinados.

El caso P-101 se utiliza para demostrar este recorrido, pero no es el padre del AMEF.

## 3. Modelo de etapa

Cada etapa debe describirse mediante:

- `stageId`;
- capa y fase funcional;
- pregunta de negocio;
- objeto de dominio activo;
- información disponible;
- inputs humanos;
- cálculos automáticos;
- recomendación del sistema;
- decisión humana;
- gate;
- outputs estructurados;
- actor responsable;
- evidencia / trazabilidad;
- estado de validación de reglas.

## 4. Fases y etapas canónicas v2

### Fase 1 — Construir la Engineering Library

| ID | Etapa | Objeto principal | Propósito |
|---|---|---|---|
| FL-01 | Seleccionar o crear la definición AMEF | `FmeaDefinition` | Establecer la identidad reusable, alcance taxonómico/funcional y responsabilidad del conocimiento de ingeniería. |
| FL-02 | Crear o seleccionar una revisión | `FmeaRevision` | Trabajar sobre una revisión identificada sin modificar contenido publicado. |
| FL-03 | Confirmar alcance, evidencia y supuestos | `FmeaRevision` | Declarar evidencia de biblioteca, contexto de referencia y supuestos de aplicabilidad antes del análisis. |
| FL-04 | Definir funciones con estándar | `FmeaFunction` | Expresar qué debe hacer el tipo/sistema analizado y qué estándar debe satisfacer. |
| FL-05 | Identificar fallos funcionales | `FunctionalFailure` | Definir las formas de incumplir total o parcialmente cada función. |
| FL-06 | Identificar modos de fallo | `FailureMode` | Registrar eventos o condiciones plausibles que producen los fallos funcionales y justificar inclusión/exclusión. |
| FL-07 | Descomponer causas y mecanismos | `FailureCause` | Separar el modo de sus causas o mecanismos causales y conservar evidencia. |
| FL-08 | Describir efectos ordenados | `FailureEffect` | Registrar cómo se manifiesta y propaga el modo desde el nivel local hasta la consecuencia observable. |

### Fase 2 — Evaluar consecuencias y tomar la decisión RCM

| ID | Etapa | Objeto principal | Propósito |
|---|---|---|---|
| FL-09 | Seleccionar contexto de evaluación y matriz de riesgo | `ConsequenceAssessment` | Identificar el perfil/contexto y la versión de matriz AMEF utilizada. |
| FL-10 | Evaluar consecuencias y riesgo AMEF | `ConsequenceAssessment` | Valorar consecuencias con evidencia y obtener indicadores de riesgo según la metodología vigente. |
| FL-11 | Revisar controles, evidencia y excepciones | `ConsequenceAssessment` | Confirmar si el análisis dispone de calidad suficiente para entrar en RCM. |
| FL-12 | Confirmar si el fallo es evidente | `RcmAssessment` | Elegir la rama adecuada de la lógica RCM versionada. |
| FL-13 | Demostrar degradación detectable | `RcmAssessmentAnswer` | Confirmar si existe un estado potencial observable antes del fallo funcional. |
| FL-14 | Evaluar la ventana P–F | `RcmAssessmentAnswer` | Verificar que existe tiempo suficiente para detectar, planificar e intervenir cuando la política depende de condición. |
| FL-15 | Comparar políticas técnicamente válidas | `RcmAssessment` | Descartar alternativas no aplicables o ineficaces antes de incorporar economía. |
| FL-16 | Emitir la decisión RCM explicable | `RcmAssessment` | Conservar recomendación del sistema, decisión humana, override si existe y salida con tarea o sin tarea programada. |

### Fase 3 — Diseñar y publicar el tratamiento reusable

| ID | Etapa | Objeto principal | Propósito |
|---|---|---|---|
| FL-17 | Diseñar la tarea de mantenimiento | `MaintenanceTask` | Definir objetivo, actividad, técnica, base de disparo/intervalo y responsabilidades sin convertirla en un procedimiento detallado. |
| FL-18 | Relacionar tareas y modos | `MaintenanceTaskFailureMode` | Validar la cardinalidad N:M y explicar qué modos detecta, previene, mitiga o verifica cada tarea. |
| FL-19 | Asociar procedimiento y formato cuando proceda | `MaintenanceProcedure` / `InspectionFormat` | Adjuntar de forma opcional y versionada instrucciones detalladas y/o estructura de captura sin mezclarlas con la tarea. |
| FL-20 | Estimar el coste de mantenimiento | `MaintenanceCostEstimate` | Estimar esfuerzo y coste previsto de la tarea o tratamiento. |
| FL-21 | Comparar escenarios económicos | `EconomicAssessment` | Comparar únicamente alternativas técnicamente válidas y mantener separados coste esperado de decisión y coste de ejecución. |
| FL-22 | Revisar, aprobar y publicar la revisión | `FmeaRevision` | Superar calidad, revisión multidisciplinar y gobernanza; generar snapshot inmutable de biblioteca. |

Si FL-16 concluye que no existe tarea programada válida, FL-17 a FL-21 pueden ser sustituidas por el registro y gobernanza de un `NoScheduledTaskDecision`; la ausencia de tarea nunca es un valor implícito.

### Fase 4 — Aplicar la biblioteca y construir el Execution Plan

| ID | Etapa | Objeto principal | Propósito |
|---|---|---|---|
| FL-23 | Crear la aplicación sobre un activo | `FmeaAssetApplication` | Vincular una revisión publicada con un activo, congelando contexto operacional y criticidad del activo como datos independientes del riesgo AMEF. |
| FL-24 | Evaluar y validar aplicabilidad | `FmeaAssetApplication` | Sugerir qué contenido aplica, permitir perfiles/variantes y registrar validación humana u overrides con motivo. |
| FL-25 | Construir el plan de ejecución | `ExecutionPlan` / `ExecutionPlanTask` | Convertir tareas aplicables en trabajo contextualizado: intervalo efectivo, recursos, alcance, procedimiento, formato y agrupación. |
| FL-26 | Superar el gate y congelar el plan | `ExecutionPlan` | Confirmar integridad y trazabilidad antes de publicar o congelar la revisión del plan de aplicación. |

### Fase 5 — Registrar resultados y aprender

| ID | Etapa | Objeto principal | Propósito |
|---|---|---|---|
| FL-27 | Registrar y comparar resultados reales | `MaintenanceResult` / `ActualMaintenanceCost` | Capturar mediciones, hallazgos, ejecución y coste real y compararlos con las hipótesis y estimaciones relevantes. |
| FL-28 | Evaluar efectividad y abrir mejora | `EffectivenessReview` | Mantener, ajustar aplicación/plan o abrir una solicitud de cambio de ingeniería que pueda originar una nueva `FmeaRevision`. |

## 5. Agrupación inicial en workspaces

Las 28 etapas se agrupan inicialmente en nueve workspaces funcionales:

| Workspace | Etapas | Capa | Objetivo |
|---|---|---|---|
| WS-01 Library & Revision | FL-01 a FL-03 | Engineering Library | Identificar la biblioteca y la revisión sobre la que se trabaja. |
| WS-02 Functions & Failure Structure | FL-04 a FL-08 | Engineering Library | Construir funciones, fallos, modos, causas y efectos con identidad trazable. |
| WS-03 Consequence & Risk | FL-09 a FL-11 | Engineering Library | Evaluar consecuencias y riesgo AMEF sin confundirlo con criticidad del activo. |
| WS-04 RCM Decision | FL-12 a FL-16 | Engineering Library | Ejecutar lógica RCM versionada y emitir una decisión defendible. |
| WS-05 Treatment Engineering | FL-17 a FL-21 | Engineering Library | Diseñar tratamientos reutilizables, relaciones N:M, adjuntos técnicos y economía. |
| WS-06 Library Publication | FL-22 | Engineering Library | Revisar, aprobar y congelar una revisión reusable. |
| WS-07 Asset Application | FL-23 a FL-24 | Asset Application | Aplicar la revisión publicada a un activo/contexto y resolver variantes/overrides. |
| WS-08 Execution Plan | FL-25 a FL-26 | Execution Plan | Configurar el trabajo efectivo y congelar el plan aplicado. |
| WS-09 Results & Improvement | FL-27 a FL-28 | Results & Learning | Contrastar hipótesis con resultados y decidir el alcance de la mejora. |

Esta agrupación sigue siendo una hipótesis de diseño del Functional Lab, no un requisito de la aplicación productiva.

## 6. Separación obligatoria entre riesgo y criticidad

En el journey existen dos conceptos distintos:

### Riesgo AMEF

Se trabaja en FL-09 a FL-11 y pertenece a `ConsequenceAssessment`.

Debe identificar:

- modo de fallo;
- contexto/perfil de evaluación;
- matriz/version usada;
- valores y evidencias;
- resultado calculado y valoración humana.

### Criticidad del activo

Aparece en FL-23 como parte del contexto de `FmeaAssetApplication`.

Debe identificar:

- esquema/version de criticidad;
- valor recibido;
- fuente;
- snapshot;
- override contextual, si existe.

Un valor de criticidad nunca modifica retroactivamente S/O/D ni una revisión AMEF publicada.

## 7. Clasificación de responsabilidad

Cada elemento del journey utilizará una de estas categorías:

| Tipo | Significado |
|---|---|
| `existing_input` | Información disponible desde biblioteca, maestro de activos u otra fuente. |
| `user_input` | Dato que una persona introduce, corrige o completa. |
| `system_calculation` | Resultado determinista obtenido mediante fórmula o regla identificada. |
| `system_recommendation` | Propuesta automática que requiere validación humana cuando así se defina. |
| `human_decision` | Decisión con responsable y trazabilidad. |
| `gate` | Condición que debe cumplirse antes de continuar/publicar. |
| `output` | Objeto estructurado consumido por una etapa o capa posterior. |

## 8. Principios de avance

1. El usuario puede retroceder sin perder el estado de la revisión o aplicación activa.
2. Un gate bloqueado debe explicar exactamente qué falta.
3. Un cálculo automático debe mostrar inputs, versión de regla y resultado.
4. Una recomendación debe diferenciarse visualmente de una decisión humana confirmada.
5. Un override conserva valor/recomendación original, decisión final, motivo y autoridad.
6. La etapa siguiente consume identificadores y outputs estructurados, no textos de pantalla.
7. El laboratorio puede mostrar reglas `to_validate` sin presentarlas como política corporativa aprobada.
8. Una revisión publicada nunca se modifica desde una aplicación a activo.
9. Una tarea de biblioteca mantiene identidad cuando se instancia en un Execution Plan.
10. Los resultados reales pueden cuestionar la ingeniería, pero abren una revisión nueva en lugar de sobrescribirla.

## 9. Trazabilidad mínima entre capas

El recorrido debe poder reconstruir, cuando corresponda:

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

Cada salto conserva identificadores, revisión/estado, evidencia y cualquier override.

## 10. Relación con documentación funcional

Cada etapa validada debe poder trazarse, según aplique, a:

- requisito funcional;
- regla de negocio;
- entidad o atributo conceptual;
- capa (`library`, `asset_application`, `execution_plan`, `results`);
- rol / responsabilidad;
- especificación de workspace;
- decisión humano/sistema;
- integración o dato de entrada externo;
- pregunta abierta.

El Functional Lab es una fuente de descubrimiento y evidencia; no debe convertirse en un modelo paralelo al dominio canónico de `03-data-model/`.
