# Functional Lab v2 — Catálogo de workspaces y límites de dominio

**Estado:** canónico para diseño funcional  
**Fecha:** 2026-08-11

## 1. Propósito

Definir, para cada workspace, qué objeto puede consultar/modificar, qué outputs genera y qué cruces de capa están prohibidos.

Este catálogo complementa `functional-journey.md` y evita que una implementación futura vuelva a mezclar agregados por comodidad de UI.

## 2. Resumen

| WS | Nombre | Capa | Objeto(s) primarios |
|---|---|---|---|
| WS-01 | Library & Revision | Library | `FmeaDefinition`, `FmeaRevision` |
| WS-02 | Functions & Failure Structure | Library | `FmeaFunction`, `FunctionalFailure`, `FailureMode`, `FailureCause`, `FailureEffect` |
| WS-03 | Consequence & Risk | Library | `ConsequenceAssessment` |
| WS-04 | RCM Decision | Library | `RcmAssessment`, `RcmAssessmentAnswer`, `NoScheduledTaskDecision?` |
| WS-05 | Treatment Engineering | Library | `MaintenanceTask`, `MaintenanceTaskFailureMode`, `MaintenanceProcedure?`, `InspectionFormat?`, economy/estimate |
| WS-06 | Library Publication | Library | `FmeaRevision` governance/snapshot |
| WS-07 | Asset Application | Asset Application | `FmeaAssetApplication`, context/criticality/applicability |
| WS-08 | Execution Plan | Execution Plan | `ExecutionPlan`, `ExecutionPlanTask` |
| WS-09 | Results & Improvement | Results | `MaintenanceResult`, `ActualMaintenanceCost`, `EffectivenessReview` |

---

# WS-01 — Library & Revision

Especificación detallada: `ws-01-library-revision.md`.

### Input

`FmeaDefinition`, `FmeaRevision`, governance/evidence.

### Output

Referencia activa de definición/revisión preparada para WS-02.

### Prohibido

P-101, criticidad, plan o resultados como contexto primario.

---

# WS-02 — Functions & Failure Structure

## Pregunta de negocio

> ¿Cómo puede incumplirse la función reusable y qué modos, causas y efectos debemos conservar en esta revisión?

## Puede modificar

Solo dentro de una `FmeaRevision` editable:

- `FmeaFunction`;
- `FunctionalFailure`;
- `FailureMode`;
- `FailureCause`;
- `FailureEffect`.

## Existing input

- definición/revisión activa;
- evidencia de biblioteca;
- taxonomía/tipo de equipo cuando exista;
- elementos ya existentes de la revisión.

## Sistema

Puede:

- validar referencias padre-hijo;
- detectar funciones sin estándar;
- detectar fallos sin función;
- detectar modos huérfanos;
- detectar causas/efectos huérfanos;
- sugerir duplicados semánticos si existe capacidad futura, siempre como recomendación.

## Decisión humana

- funciones y estándares válidos;
- fallos funcionales incluidos;
- modos incluidos/excluidos;
- causas/mecanismos aceptados;
- efectos relevantes.

## Gate

`GATE-FMEA-STRUCTURE-001` — `to_validate`.

Bloquea si existe una referencia rota o un modo incluido sin fallo funcional padre.

## Output

IDs estructurados para WS-03, especialmente `failureModeId` y sus efectos/evidencias.

## Prohibido

- insertar `assetId` en funciones/modos;
- escribir P-101 dentro de IDs reusable salvo evidencia/contexto narrativo explícitamente específico;
- guardar causa dentro de `FailureMode.statement` como sustituto de `FailureCause`;
- reemplazar relaciones con texto concatenado.

---

# WS-03 — Consequence & Risk

## Pregunta de negocio

> ¿Qué consecuencias y riesgo AMEF tiene cada modo bajo una matriz/version identificada?

## Puede modificar

- `ConsequenceAssessment` de modos pertenecientes a la revisión activa.

## Existing input

- `FailureMode`;
- `FailureEffect`;
- evidencia;
- `riskMatrixVersionRef`;
- perfil/contexto de evaluación de biblioteca cuando corresponda.

## Sistema

Puede:

- calcular el resultado conforme a una matriz/version;
- validar rangos;
- mostrar sensibilidad/completitud;
- recomendar revisión ante datos insuficientes.

## Decisión humana

- valores/valoración que requieran juicio;
- categoría de consecuencia;
- justificación/evidencia;
- aceptación de que el expediente puede entrar en RCM.

## Gate

`GATE-FMEA-RISK-READY-001` — `to_validate`.

## Output

`ConsequenceAssessmentId` + `FailureModeId` + versión de matriz + resultado/valoración + evidencia.

## Prohibido

- llamar a este resultado `AssetCriticality`;
- escribir la criticidad de P-101;
- crear/editar `AssetCriticalitySnapshot`;
- modificar una revisión publicada.

---

# WS-04 — RCM Decision

## Pregunta de negocio

> ¿Qué política técnicamente válida recomienda la lógica RCM y qué decisión confirma la persona responsable?

## Puede modificar

En revisión editable:

- `RcmAssessment`;
- `RcmAssessmentAnswer`;
- decisión/override;
- `NoScheduledTaskDecision` cuando la salida sea sin tarea programada.

## Existing input

- failure mode;
- consequence assessment;
- evidencia;
- `decisionLogicVersionRef`.

## Sistema

Puede:

- presentar preguntas según lógica versionada;
- calcular rama siguiente;
- comprobar respuestas faltantes;
- generar `systemRecommendation`.

## Decisión humana

- respuestas que requieran experiencia/evidencia;
- `humanDecision`;
- override y motivo;
- decisión explícita sin tarea cuando aplique.

## Gate

`GATE-RCM-DECISION-001` — `to_validate`.

Debe impedir una salida implícita ambigua.

## Output

Uno de estos caminos:

```text
RcmAssessment → treatment candidate
```

o:

```text
RcmAssessment → NoScheduledTaskDecision
```

## Prohibido

- reducir RCM a un algoritmo sin autoridad humana;
- borrar `systemRecommendation` al aceptar/modificar la decisión;
- interpretar lista vacía de tareas como decisión válida.

---

# WS-05 — Treatment Engineering

## Pregunta de negocio

> ¿Qué tratamiento reusable implementa la decisión RCM, qué modos trata y qué adjuntos/economía necesita?

## Puede modificar

- `MaintenanceTask`;
- `MaintenanceTaskFailureMode`;
- `MaintenanceProcedure` cuando corresponda;
- `InspectionFormat` cuando corresponda;
- `MaintenanceCostEstimate`;
- `EconomicAssessment`.

## Existing input

- RCM assessments;
- failure modes;
- evidencia;
- tareas/procedimientos/formatos existentes de la revisión/biblioteca cuando proceda.

## Sistema

Puede:

- validar que tareas tengan vínculos técnicos;
- mostrar matriz N:M;
- resolver refs de procedimientos/formatos;
- calcular estimaciones económicas con reglas identificadas;
- comparar escenarios técnicamente válidos.

## Decisión humana

- diseño de tarea;
- propósito técnico de cada vínculo tarea–modo;
- necesidad de procedimiento/formato;
- hipótesis de coste;
- interpretación económica.

## Gates

```text
GATE-TASK-COVERAGE-001
GATE-ECONOMIC-COMPLETENESS-001
```

ambos `to_validate`.

## Output

Tratamientos reusable preparados para gobernanza/publicación.

## Prohibido

- `MaintenanceTask.FailureModeId` como sustituto de N:M;
- procedimiento detallado inseparable dentro de la tarea;
- formato de captura inseparable dentro de la tarea;
- `ActualMaintenanceCost`;
- intervalo efectivo específico de P-101 salvo que se documente como ejemplo, no como propiedad de la biblioteca.

---

# WS-06 — Library Publication

## Pregunta de negocio

> ¿La revisión tiene suficiente calidad, evidencia y gobernanza para convertirse en conocimiento publicado e inmutable?

## Puede modificar

Antes de publicar:

- metadatos de revisión/gobernanza;
- resolución de discrepancias;
- aprobaciones simuladas según reglas vigentes.

Al publicar:

- cambio de estado gobernado;
- `publishedSnapshotId`.

## Sistema

Puede:

- ejecutar checks de integridad;
- listar warnings/errores;
- verificar referencias y outputs incompletos;
- generar resumen/snapshot conceptual.

## Decisión humana

- aprobar/rechazar/devolver;
- justificar discrepancias;
- publicar cuando exista autoridad.

## Gate

`GATE-FMEA-PUBLISH-001` — `to_validate`.

## Output

`FmeaRevision` publicada e inmutable.

## Prohibido

- editar el contenido del snapshot publicado;
- publicar automáticamente por completar campos;
- convertir criticidad de un activo en atributo de la revisión;
- clonar automáticamente por activo.

---

# WS-07 — Asset Application

## Pregunta de negocio

> ¿Esta revisión publicada aplica a este activo/contexto y qué decisiones contextuales necesitamos registrar?

## Puede modificar

- `FmeaAssetApplication`;
- `OperationalContextSnapshot`;
- `AssetCriticalitySnapshot` como dato recibido/capturado;
- `AssetCriticalityOverride` cuando esté autorizado;
- decisiones de aplicabilidad de tareas/perfiles.

## Existing input

- `FmeaRevision` publicada;
- asset identity;
- contexto operacional del activo;
- criticidad desde fuente/esquema identificados;
- tareas reusable de la revisión.

## Sistema

Puede:

- comprobar compatibilidad de tipo/contexto;
- sugerir aplicabilidad/perfil;
- señalar diferencias;
- comparar defaults de biblioteca con contexto;
- recomendar revisión humana.

## Decisión humana

- aplicabilidad final;
- perfil/variante;
- overrides contextuales;
- criticidad corregida cuando exista autoridad y evidencia.

## Gate

`GATE-ASSET-APPLICATION-001` — `to_validate`.

## Output

`FmeaAssetApplication` validada para alimentar WS-08.

## Prohibido

- modificar `FmeaRevision` publicada;
- copiar toda la biblioteca dentro del activo;
- calcular criticidad del activo desde S/O/D o NPR;
- convertir un override contextual en cambio global de biblioteca.

---

# WS-08 — Execution Plan

## Pregunta de negocio

> ¿Cómo se convierte la aplicación validada en trabajo ejecutable para este activo sin perder la identidad de la tarea reusable?

## Puede modificar

- `ExecutionPlan`;
- `ExecutionPlanTask`;
- intervalos/disparadores efectivos;
- recursos;
- alcance físico;
- grouping;
- procedimiento/formato seleccionado;
- estimación contextual cuando proceda.

## Existing input

- application validada;
- tareas aplicables;
- defaults de `MaintenanceTask`;
- procedimiento/formato reusable;
- datos de planificación/contexto disponibles.

## Sistema

Puede:

- proponer defaults;
- detectar diferencias con biblioteca;
- validar refs;
- explicar overrides de intervalo;
- comprobar integridad del plan.

## Decisión humana

- configuración efectiva del plan;
- intervalos/recursos/alcance;
- selección de procedimiento/formato;
- publicación/congelación del plan según autoridad.

## Gate

`GATE-EXECUTION-PLAN-001` — `to_validate`.

## Output

`ExecutionPlan` y `ExecutionPlanTask` congelados/publicables, trazables a `FmeaAssetApplication` y `MaintenanceTask`.

## Prohibido

- cambiar la definición reusable de la tarea para acomodar P-101;
- perder `maintenanceTaskId` de origen;
- mezclar resultados reales en el plan;
- asumir que un intervalo contextual crea una nueva `FmeaRevision`.

---

# WS-09 — Results & Improvement

## Pregunta de negocio

> ¿Qué ocurrió realmente, cuánto costó y el aprendizaje requiere ajustar el contexto/plan o cambiar la ingeniería reusable?

## Puede modificar

- `MaintenanceResult`;
- `MaintenanceMeasurement`/hallazgos cuando existan;
- `ActualMaintenanceCost`;
- `EffectivenessReview`;
- referencia a `EngineeringChangeRequest`.

## Existing input

- Execution Plan y task ejecutada;
- hipótesis de biblioteca;
- estimate de tarea/plan;
- resultados previos.

## Sistema

Puede:

- comparar estimate vs actual;
- comparar hipótesis P–F/eficacia con observaciones;
- detectar desviaciones/tendencias;
- recomendar revisión contextual o de ingeniería.

## Decisión humana

- interpretación del resultado;
- mantener;
- revisar aplicación/plan;
- abrir `EngineeringChangeRequest` para nueva `FmeaRevision`.

## Gate

No existe un gate único obligatorio para registrar un resultado. Puede existir gate de cierre/revisión según el workflow que se valide.

## Output

```text
MaintenanceResult
ActualMaintenanceCost
EffectivenessReview
EngineeringChangeRequest? 
```

## Prohibido

- sobrescribir `MaintenanceCostEstimate` con el real;
- modificar directamente la revisión publicada;
- crear nueva revisión AMEF ante cualquier variación local;
- perder `executionPlanTaskId`.

---

# 3. Transiciones de capa

## WS-06 → WS-07

Cambio explícito:

```text
ENGINEERING LIBRARY
published revision
        ↓
ASSET APPLICATION
specific asset/context
```

La UI debe hacerlo visible.

## WS-08 → WS-09

Cambio explícito:

```text
EXECUTION PLAN
expected work
        ↓
RESULTS & LEARNING
observed reality
```

También debe ser visible.

## 4. Regla de edición cruzada

Un workspace puede **leer** objetos de capas anteriores para explicar una decisión, pero solo puede **editar** objetos cuyo ownership le corresponda.

Ejemplo:

```text
WS-07 reads FmeaRevision
WS-07 edits FmeaAssetApplication
```

No:

```text
WS-07 edits FmeaRevision because P-101 differs
```

## 5. Criterio de aceptación del catálogo

Una futura pantalla debe poder responder antes de implementarse:

```text
Which workspace?
Which layer?
Which primary object?
What may be edited?
What is read-only context?
What is the gate?
What output is produced?
What lineage must survive?
What edits are explicitly forbidden?
```

Si no puede responderse, el diseño se detiene en el Domain Ownership Gate.
