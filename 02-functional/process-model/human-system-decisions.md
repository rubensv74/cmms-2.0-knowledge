# Matriz preliminar — Persona vs sistema

**Versión conceptual:** v2 — library-first  
**Estado general:** `to_validate`

## 1. Propósito

Hacer explícito, antes de construir pantallas, qué aporta una persona, qué calcula el sistema, qué puede recomendar y qué debe quedar bloqueado o trazado en cada capa del recorrido.

Esta matriz es una hipótesis funcional para las reuniones. No autoriza automatismos productivos.

## 2. Leyenda

- **H** — decisión o input humano.
- **C** — cálculo determinista del sistema.
- **R** — recomendación del sistema que necesita confirmación.
- **G** — gate automático o semiautomático.
- **O** — output estructurado.

## 3. Matriz v2

| Etapa | Capa | H | C | R | G | O | Resultado esperado |
|---|---|:---:|:---:|:---:|:---:|:---:|---|
| FL-01 Definición AMEF | Library | ✓ |  | ✓ |  | ✓ | `FmeaDefinition` seleccionada o creada con alcance reusable. |
| FL-02 Revisión | Library | ✓ | ✓ |  | ✓ | ✓ | `FmeaRevision` identificada; una publicada queda en solo lectura. |
| FL-03 Alcance/evidencia | Library | ✓ | ✓ |  | ✓ | ✓ | Evidencia y supuestos suficientes para continuar. |
| FL-04 Funciones | Library | ✓ |  |  |  | ✓ | `FmeaFunction` con estándar explícito. |
| FL-05 Fallos funcionales | Library | ✓ |  |  | ✓ | ✓ | `FunctionalFailure` ligados por ID a su función. |
| FL-06 Modos de fallo | Library | ✓ |  | ✓ | ✓ | ✓ | `FailureMode` incluidos/excluidos con justificación. |
| FL-07 Causas/mecanismos | Library | ✓ |  | ✓ |  | ✓ | `FailureCause` explícitas, no escondidas en el texto del modo. |
| FL-08 Efectos | Library | ✓ |  |  | ✓ | ✓ | `FailureEffect` ordenados y trazados al modo. |
| FL-09 Contexto/matriz de riesgo | Library | ✓ | ✓ |  | ✓ | ✓ | Versión de matriz y perfil/contexto de evaluación identificados. |
| FL-10 Consecuencia/riesgo AMEF | Library | ✓ | ✓ | ✓ |  | ✓ | `ConsequenceAssessment` explicable. |
| FL-11 Controles/excepciones | Library | ✓ | ✓ |  | ✓ | ✓ | Evaluación preparada o bloqueada antes de RCM. |
| FL-12 Fallo evidente | Library | ✓ |  |  |  | ✓ | Respuesta RCM trazada a lógica versionada. |
| FL-13 Degradación detectable | Library | ✓ |  | ✓ |  | ✓ | Evidencia de fallo potencial documentada. |
| FL-14 Ventana P–F | Library | ✓ | ✓ | ✓ | ✓ | ✓ | Viabilidad temporal explicada; umbrales siguen `to_validate`. |
| FL-15 Políticas válidas | Library | ✓ | ✓ | ✓ |  | ✓ | Alternativas técnicamente válidas antes de economía. |
| FL-16 Decisión RCM | Library | ✓ |  | ✓ | ✓ | ✓ | Recomendación + decisión + override o salida explícita sin tarea. |
| FL-17 Diseñar tarea | Library | ✓ |  |  | ✓ | ✓ | `MaintenanceTask` reusable, sin mezclar procedimiento/formato. |
| FL-18 Relación tarea–modo | Library | ✓ | ✓ | ✓ | ✓ | ✓ | N:M válida mediante `MaintenanceTaskFailureMode`. |
| FL-19 Procedimiento/formato | Library | ✓ | ✓ | ✓ |  | ✓ | Adjuntos opcionales/versionados seleccionados cuando aportan valor. |
| FL-20 Coste estimado | Library | ✓ | ✓ |  |  | ✓ | `MaintenanceCostEstimate` separado de economía de decisión y coste real. |
| FL-21 Comparación económica | Library | ✓ | ✓ | ✓ |  | ✓ | `EconomicAssessment` entre alternativas ya técnicamente válidas. |
| FL-22 Publicación de biblioteca | Library | ✓ | ✓ |  | ✓ | ✓ | Snapshot inmutable de `FmeaRevision`. |
| FL-23 Aplicación al activo | Asset Application | ✓ | ✓ |  | ✓ | ✓ | `FmeaAssetApplication` con contexto y criticidad congelados. |
| FL-24 Aplicabilidad/overrides | Asset Application | ✓ | ✓ | ✓ | ✓ | ✓ | Recomendación de aplicabilidad y validación humana trazadas. |
| FL-25 Plan de ejecución | Execution Plan | ✓ | ✓ | ✓ |  | ✓ | `ExecutionPlanTask` conserva `maintenanceTaskId` de origen. |
| FL-26 Gate/publicación del plan | Execution Plan | ✓ | ✓ |  | ✓ | ✓ | Plan contextual congelado y trazable. |
| FL-27 Resultados/coste real | Results | ✓ | ✓ |  |  | ✓ | `MaintenanceResult` y `ActualMaintenanceCost` ligados a ejecución. |
| FL-28 Efectividad/mejora | Results | ✓ | ✓ | ✓ |  | ✓ | Mantener, ajustar aplicación/plan o abrir cambio de ingeniería. |

## 4. Reglas de diseño derivadas

### 4.1. La capa activa debe ser visible

La persona debe saber si está:

- editando conocimiento reusable de biblioteca;
- aplicándolo a un activo;
- construyendo un plan contextual;
- revisando resultados reales.

La UI no debe presentar estos objetos como secciones equivalentes de un único “caso”.

### 4.2. Un cálculo no sustituye a una decisión

El sistema puede calcular un indicador de riesgo conforme a una matriz versionada, comprobar consistencia o estimar costes. La valoración, aceptación y autoridad se mantienen explícitas cuando requieran juicio.

### 4.3. Riesgo AMEF no es criticidad del activo

En FL-09/10 el sistema trabaja con `ConsequenceAssessment`.

En FL-23 recibe la criticidad del activo desde un esquema contextual independiente.

Prohibido inferir automáticamente:

```text
AssetCriticality = S × O
AssetCriticality = NPR
```

salvo que una futura regla corporativa explícitamente aprobada lo definiera, lo que actualmente no existe.

### 4.4. Recomendación y decisión mantienen identidades distintas

Cuando exista recomendación automática:

```text
systemRecommendation
humanDecision
overrideReason
authorityRole
```

No se sobrescribe la recomendación con la decisión final.

### 4.5. Ausencia de tarea no es ausencia de decisión

Si RCM concluye que no debe existir una tarea programada, el sistema exige un `NoScheduledTaskDecision` con tipo, motivo y autoridad.

### 4.6. La N:M tarea–modo debe ser verificable

El sistema puede detectar relaciones huérfanas, duplicadas o inconsistentes. La persona confirma la finalidad técnica de cada vínculo.

### 4.7. Procedimiento y formato son opcionales

El sistema puede recomendar adjuntos existentes por técnica/tipo de tarea. La decisión sobre su aplicación corresponde al flujo funcional validado; su ausencia no debe invalidar automáticamente una tarea si no son necesarios.

### 4.8. Las tres economías no se fusionan

```text
EconomicAssessment       → apoya una decisión
MaintenanceCostEstimate  → predice coste de ejecución
ActualMaintenanceCost    → registra coste observado
```

La interfaz debe impedir que parezcan tres estados del mismo campo editable.

### 4.9. Un gate debe ser explicable

No basta con deshabilitar `Siguiente` o `Publicar`. Debe mostrarse:

- qué condición falla;
- qué dato/relación falta;
- qué capa y objeto está bloqueado;
- qué rol puede resolverlo;
- qué regla/version lo determina;
- si esa regla es `to_validate`, `validated` o `approved`.

### 4.10. Publicar congela, no copia silenciosamente

Al publicar una revisión o plan, el sistema genera/representa un snapshot inmutable. Cualquier cambio posterior crea una nueva revisión contextual apropiada.

## 5. Preguntas de validación para las reuniones

La matriz debe utilizarse para preguntar sistemáticamente:

1. ¿Este dato pertenece realmente a biblioteca, aplicación, plan o resultado?
2. ¿Ya existe en otro módulo o catálogo?
3. ¿Quién es responsable de su calidad?
4. ¿Puede calcularlo el sistema sin interpretación?
5. ¿Puede sugerirlo el sistema pero debe confirmarlo una persona?
6. ¿Qué rol tiene autoridad para aceptar o cambiar la recomendación?
7. ¿Qué evidencia debe quedar registrada?
8. ¿Qué condición debe bloquear realmente el avance o publicación?
9. ¿El cambio debe crear una nueva revisión de biblioteca o solo una revisión de aplicación/plan?

Las respuestas validadas actualizarán esta matriz y generarán requisitos funcionales asociados.
