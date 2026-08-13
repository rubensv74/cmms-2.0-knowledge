# CMMS 2.0 Functional Journey — modelo alineado

## 1. Propósito

Definir el recorrido funcional independiente de la interfaz y de la implementación técnica.

El journey de 28 etapas describe **cómo se aplica y valida una ingeniería AMEF/RCM reutilizable sobre un activo concreto**, cómo se convierte en trabajo ejecutable y cómo los resultados reales regresan a ingeniería.

> Una etapa funcional no equivale necesariamente a una pantalla.

## 2. Precondición del journey

Antes de FL-01 deben existir, o poder seleccionarse:

```text
TechnicalObject
FmeaDefinition / FmeaRevision
AssetCriticalityAssessment
FmeaAssetApplication (propuesta o existente)
```

El journey no pretende volver a crear desde cero funciones, fallos y modos para cada tag.

## 3. Modelo de etapa

Cada etapa debe describirse mediante:

- `stageId`;
- fase funcional;
- pregunta de negocio;
- información heredada de biblioteca;
- información contextual del activo;
- inputs humanos;
- cálculos automáticos;
- recomendación del sistema;
- decisión humana;
- control de avance;
- outputs;
- actor responsable;
- evidencia / trazabilidad;
- estado de validación de reglas.

## 4. Fases y etapas canónicas

### Fase 1 — Comprender la aplicación y el contexto

| ID | Etapa | Propósito alineado |
|---|---|---|
| FL-01 | Confirmar activo, revisión y límites | Verificar qué objeto se analiza, qué revisión AMEF se aplica y cuál es la frontera física/contextual. |
| FL-02 | Describir el contexto operacional | Confirmar demanda, modos de operación, servicio, redundancia y restricciones. |
| FL-03 | Comprobar preparación y criticidad | Confirmar evidencias disponibles y criticidad contextual vigente del activo. |
| FL-04 | Revisar funciones heredadas | Verificar que las funciones de la revisión AMEF son aplicables al activo; registrar override solo cuando sea necesario. |
| FL-05 | Revisar fallos funcionales heredados | Confirmar aplicabilidad de los fallos funcionales y excepciones contextuales. |
| FL-06 | Seleccionar modos y causas aplicables | Confirmar qué modos/causas de biblioteca son relevantes para el activo y justificar exclusiones. |

### Fase 2 — Evaluar efectos y riesgo AMEF

| ID | Etapa | Propósito alineado |
|---|---|---|
| FL-07 | Revisar efectos del modo de fallo | Partir del efecto de biblioteca y confirmar/ajustar efecto local, de sistema y operacional para el contexto. |
| FL-08 | Clasificar consecuencias | Determinar la naturaleza principal del impacto; el sistema puede recomendar y la persona confirma. |
| FL-09 | Valorar severidad, ocurrencia y detección | Aplicar escalas AMEF configuradas y calcular matriz S×O/NPR sin confundirlos con criticidad del activo. |
| FL-10 | Aplicar reglas de sobreclasificación | Elevar prioridad cuando existan reglas/condiciones críticas configuradas. |
| FL-11 | Revisar controles y excepciones | Confirmar si existe información suficiente para ejecutar la lógica RCM. |

### Fase 3 — Tomar la decisión RCM

| ID | Etapa | Propósito alineado |
|---|---|---|
| FL-12 | Responder la primera rama aplicable | Ejecutar la pregunta correspondiente de una `DecisionLogicRevision`, por ejemplo fallo evidente/oculto. |
| FL-13 | Demostrar degradación detectable | Confirmar si existe un fallo potencial observable y su evidencia. |
| FL-14 | Evaluar la ventana P–F | Verificar si existe tiempo suficiente para detectar, planificar e intervenir. |
| FL-15 | Comparar políticas técnicamente válidas | Descartar alternativas no aplicables y comparar las restantes. |
| FL-16 | Emitir decisión RCM explicable | Consolidar estrategia, fallback, evidencia, respuesta del árbol y autoridad humana. |

La secuencia exacta de preguntas RCM es configurable mediante `DecisionLogicRevision`; FL-12…FL-16 expresan responsabilidades, no un árbol corporativo cerrado.

### Fase 4 — Convertir la decisión en trabajo ejecutable

| ID | Etapa | Propósito alineado |
|---|---|---|
| FL-17 | Comparar el coste esperado | Comparar alternativas técnicamente válidas desde el punto de vista económico preliminar. |
| FL-18 | Confirmar tarea ejecutable | Partir de una `ProposedMaintenanceTask`/`TaskProfileVariant` y definir tarea, criterio, reacción y condiciones de ejecución. |
| FL-19 | Justificar intervalo | Relacionar frecuencia con P–F, criticidad/contexto, evidencia y ventana de planificación. |
| FL-20 | Asignar recursos y carga | Definir disciplina, cuadrilla, duración, H-H, herramientas, materiales, permisos y estado operativo. |
| FL-21 | Definir alcance y agrupación | Identificar tags incluidos, equipo principal/soportes y regla candidata de ruta/Job Plan. |
| FL-22 | Superar control de preparación | Confirmar que la propuesta está preparada para revisión/gobernanza y handoff CMMS. |

### Fase 5 — Gobernar, ejecutar y mejorar

| ID | Etapa | Propósito alineado |
|---|---|---|
| FL-23 | Reconstruir trazabilidad integral | Verificar Biblioteca → Aplicación → Modo → RCM → Tarea → Job Plan/PM/WO. |
| FL-24 | Ejecutar control de calidad | Resolver advertencias y errores metodológicos o de datos. |
| FL-25 | Resolver revisión multidisciplinar | Conservar discrepancias y registrar su resolución. |
| FL-26 | Aprobar y congelar una versión | Registrar autoridades y crear snapshot inmutable de la aplicación/decisiones. |
| FL-27 | Comparar hipótesis con datos reales | Contrastar fallos, P–F, H-H, coste y resultados de ejecución. |
| FL-28 | Abrir mejora continua | Decidir si mantener, ajustar aplicación o iniciar revisión de biblioteca. |

## 5. Cadena de propiedad de los datos

```text
FmeaRevision
    ↓ se aplica
FmeaAssetApplication
    ↓ se revisa
AnalysisCase
    ↓ produce
MaintenanceTask / PlanScope
    ↓ se transforma
JobPlan / PM / WO
    ↓ devuelve
ExecutionResult
    ↓ alimenta
EffectivenessMeasurement / ChangeRequest
```

## 6. Responsabilidades

| Tipo | Significado |
|---|---|
| `existing_input` | Información existente de biblioteca, activo, criticidad, histórico u otra fuente. |
| `user_input` | Dato contextual que una persona introduce/corrige. |
| `system_calculation` | Resultado determinista de regla/fórmula. |
| `system_recommendation` | Propuesta automática revisable. |
| `human_decision` | Decisión con responsable humano y trazabilidad. |
| `gate` | Condición de negocio para continuar formalmente. |
| `output` | Resultado estructurado consumido por etapa/módulo posterior. |

## 7. Principios de avance

1. La biblioteca se hereda; no se duplica por activo salvo snapshot/revisión explícita.
2. Un override contextual no modifica silenciosamente la revisión AMEF.
3. Criticidad del activo y riesgo AMEF permanecen separados.
4. Un gate bloqueado explica qué falta y quién debe actuar.
5. Un cálculo muestra inputs/regla.
6. Una recomendación se diferencia de una decisión.
7. Un override conserva recomendación original, decisión final y motivo.
8. Una tarea puede cubrir varios modos y un modo varias tareas.
9. Un procedimiento es opcional.
10. La agrupación en rutas/planes conserva identidad y resultados por tag.
11. Los resultados reales pueden provocar un cambio de aplicación o una revisión de biblioteca, pero no sobrescriben una versión aprobada.

## 8. Lo que sigue pendiente de validación

El journey deja configurables:

- escala AMEF corporativa;
- umbrales de bandas;
- reglas de criticidad;
- árbol RCM definitivo;
- reglas P–F;
- autoridades finales;
- evidencias mínimas;
- reglas de sobreclasificación;
- criterios de aprobación;
- KPIs/umbrales de efectividad;
- integración con sistema CMMS destino.
