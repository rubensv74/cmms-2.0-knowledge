# CMMS 2.0 — Especificación de contexto para Codex

## Módulo de Ingeniería de Fiabilidad: AMEF, RCM y Estrategias de Mantenimiento

| Campo | Valor |
|---|---|
| Documento | Especificación funcional y técnica de arranque |
| Código | `CMMS2-PAS-REL-001` |
| Versión | `0.1.0` |
| Estado | Borrador consolidado para revisión |
| Fecha | 2026-07-28 |
| Destinatario | Codex dentro de Visual Studio Code |
| Alcance inmediato | Definición y prototipo 04 del módulo AMEF/RCM |
| Idioma | Español |

---

## 1. Propósito del documento

Este documento proporciona a Codex el contexto necesario para continuar el diseño y, cuando se autorice, desarrollar un prototipo del módulo de Ingeniería de Fiabilidad de CMMS 2.0.

No es un prompt para generar una aplicación completa de una sola vez. Es la fuente de contexto inicial para:

1. reconstruir el estado aprobado;
2. convertir el dominio en una especificación técnica trazable;
3. cerrar las decisiones arquitectónicas pendientes;
4. diseñar contratos y modelo de datos;
5. implementar el prototipo por incrementos verificables.

Codex debe tratar las decisiones marcadas como **cerradas** como restricciones vigentes. Las propuestas y puntos abiertos no deben convertirse silenciosamente en requisitos.

---

## 2. Contexto del proyecto

CMMS 2.0 es una evolución conceptual del sistema corporativo de mantenimiento. Debe cubrir el ciclo completo de ingeniería, planificación, ejecución, costes y mejora continua.

La conversación de origen analiza una presentación basada en experiencia real de definición y carga de planes de mantenimiento. La presentación es una fuente de requisitos y aprendizaje operativo, pero **no es una especificación funcional cerrada** ni debe reproducirse literalmente como arquitectura.

El problema que se quiere resolver es doble:

- definir tareas de mantenimiento justificadas por funciones, fallos, consecuencias y riesgo;
- evitar que esa calidad técnica produzca una cantidad inmanejable de hojas de ruta, planes y órdenes.

El nuevo modelo debe conservar simultáneamente:

- rigor de ingeniería;
- reutilización corporativa;
- aplicabilidad por contexto;
- identidad individual de los activos;
- eficiencia administrativa;
- trazabilidad técnica y económica;
- versionado y gobierno;
- retroalimentación desde la ejecución.

---

## 3. Glosario mínimo

### 3.1 AMEF/FMEA

**AMEF** significa *Análisis de Modos y Efectos de Fallo*. Identifica qué funciones debe cumplir un equipo o sistema, cómo puede fallar, cuáles son las causas, qué efectos y consecuencias se producen y qué tratamientos pueden prevenir, detectar o reducir el impacto.

### 3.2 RCM/MCC

**RCM** significa *Reliability-Centered Maintenance* o **Mantenimiento Centrado en la Fiabilidad (MCC)**. Analiza fallos, consecuencias y riesgo para decidir la estrategia adecuada: mantenimiento preventivo, basado en condición, búsqueda de fallos, operar hasta el fallo o rediseñar.

Resumen conceptual:

> AMEF identifica y analiza los fallos; RCM decide qué hacer ante ellos.

### 3.3 FLH

Jerarquía de localización funcional. Representa dónde está instalado un elemento y su contexto dentro de la planta.

### 3.4 Taxonomía

Clasificación corporativa del tipo o clase de equipo. Puede apoyarse en ISO 14224, sin convertirse en la jerarquía funcional.

### 3.5 ADR de activos

Estructura física y relaciones padre-hijo entre activos. En este documento, `ADR` se refiere al árbol o modelo físico de activos, no a los *Architecture Decision Records*, que se citarán como «registro de decisión arquitectónica».

### 3.6 Tarea propuesta, Job Plan, estrategia y PM

- **Tarea propuesta:** recomendación técnica procedente del análisis AMEF/RCM.
- **Job Plan / Maintenance Procedure:** definición ejecutable y reutilizable de una intervención.
- **Estrategia de mantenimiento:** reglas de alcance, frecuencia o disparador, aplicabilidad y agrupación.
- **PM:** plan preventivo publicado que genera candidatos u órdenes.
- **WO:** orden de trabajo ejecutable.

Estas entidades no son intercambiables.

---

## 4. Visión y principio arquitectónico

La cadena funcional objetivo es:

```text
Información técnica
→ criticidad
→ AMEF
→ decisión RCM
→ tareas propuestas o decisión sin tarea
→ validación y publicación
→ Job Plan / Maintenance Procedure
→ estrategia de mantenimiento
→ PM y candidatos
→ planificación
→ orden de trabajo
→ ejecución y resultados
→ evaluación de efectividad
→ revisión de la estrategia
```

Principio rector:

> El AMEF no es una hoja ni una colección de tareas. Es un grafo versionado de funciones, fallos, causas, consecuencias, decisiones y tratamientos, aplicado posteriormente a activos físicos concretos.

El sistema debe separar la ingeniería corporativa reutilizable de su aplicación concreta a proyectos, contextos operacionales y activos.

---

## 5. Comparación con soluciones del mercado

La propuesta está alineada conceptualmente con:

| Concepto CMMS 2.0 | SAP | IBM Maximo | Hexagon |
|---|---|---|---|
| AMEF | FMEA Assessment | FMEA Study | RCM Information Worksheet / Failure Analysis |
| Revisión | Assessment / Reassessment | Strategy revision / study lifecycle | RCM Template / Equipment RCM |
| Árbol RCM | RCM Assessment | RCM/FMEA decision workflow | Failure Mode Control Strategy |
| Tarea propuesta | Recommendation / Mitigation | Mitigation Activity | Failure Mitigation |
| Aplicación | Technical objects / asset classes | Assets, locations, classifications | Equipment classes / templates |
| Plan ejecutable | Maintenance item / task list | Job Plan / PM | Standard WO / PM Schedule |

La solución no debe presentarse como una metodología nueva. Su valor diferencial es hacer nativos:

- la trazabilidad extremo a extremo;
- la aplicabilidad contextual;
- el versionado inmutable;
- las variantes sin duplicar el análisis;
- la relación muchos-a-muchos entre tareas y modos;
- las decisiones explícitas sin tarea;
- la separación entre ingeniería corporativa y aplicación física.

No se debe copiar literalmente el modelo de SAP, Maximo o Hexagon.

---

## 6. Decisiones funcionales cerradas

| ID | Decisión |
|---|---|
| `DEC-REL-001` | FLH, taxonomía y ADR físico son estructuras distintas. |
| `DEC-REL-002` | ISO 14224 es referencia taxonómica, no jerarquía funcional rígida. |
| `DEC-REL-003` | El equipo principal puede actuar como Nodo Raíz ADR, pero no absorbe la identidad de sus hijos. |
| `DEC-REL-004` | Cada activo hijo conserva código, tipo, relación, estado, historial, tareas, resultados y costes propios. |
| `DEC-REL-005` | AMEF, evaluación RCM, tarea propuesta, Job Plan, estrategia, PM y WO son entidades separadas. |
| `DEC-REL-006` | Una tarea puede tratar varios modos y un modo puede requerir varias tareas. |
| `DEC-REL-007` | Un resultado RCM puede no generar tarea, pero exige una decisión explícita y justificada. |
| `DEC-REL-008` | Una revisión publicada es inmutable. Toda modificación genera una nueva revisión. |
| `DEC-REL-009` | La aplicabilidad automática sugiere; la publicación requiere validación humana. |
| `DEC-REL-010` | La criticidad no se resuelve duplicando un AMEF completo por nivel. |
| `DEC-REL-011` | Frecuencias y tratamiento pueden variar mediante perfiles aplicables. |
| `DEC-REL-012` | Los nombres visibles no son el modelo de datos; sus dimensiones se almacenan en campos separados. |
| `DEC-REL-013` | Las agrupaciones reducen carga administrativa sin perder ejecución, historial y costes por activo. |
| `DEC-REL-014` | Actividad, tipo de mantenimiento, disciplina, puesto, grupo de planificación y organización ejecutora son catálogos separados. |
| `DEC-REL-015` | El flujo no termina con la carga del plan; los resultados reales deben retroalimentar la ingeniería. |

---

## 7. Objetivos funcionales

### 7.1 Objetivo general

Crear un espacio de trabajo guiado de Ingeniería de Fiabilidad que permita construir, revisar, aprobar, publicar y aplicar análisis AMEF/RCM reutilizables.

### 7.2 Objetivos específicos

- Definir el alcance y contexto del AMEF.
- Registrar funciones y estándares de funcionamiento.
- Descomponer fallos funcionales, modos, causas y efectos.
- Evaluar consecuencias y riesgo con justificación.
- Ejecutar un árbol RCM versionado y conservar cada respuesta.
- Proponer tareas técnicas o decisiones explícitas sin tarea.
- Relacionar tareas y modos con cardinalidad muchos-a-muchos.
- Evaluar aplicabilidad sobre activos y contexto operacional.
- Gestionar variantes por criticidad o perfil sin duplicar el AMEF.
- Someter revisiones a aprobación por etapas.
- Publicar snapshots inmutables.
- Mantener trazabilidad hacia Job Plans, estrategias, PM, WO y resultados.

---

## 8. Alcance del prototipo 04

El prototipo debe mostrar un flujo guiado, no un conjunto de tablas CRUD independientes:

1. Cabecera y alcance del AMEF.
2. Funciones.
3. Fallos funcionales.
4. Modos, causas y efectos.
5. Consecuencias y riesgo.
6. Árbol de decisión RCM.
7. Tareas propuestas o decisiones sin tarea.
8. Aplicabilidad y perfiles.
9. Revisión y aprobación.

### 8.1 Incluido

- navegación guiada por pasos;
- creación y edición de una revisión en borrador;
- validaciones entre etapas;
- estado de completitud;
- relación entre entidades del núcleo;
- simulación de la decisión RCM;
- evaluación de aplicabilidad;
- vista de revisión y aprobación;
- datos de ejemplo coherentes;
- persistencia mediante contratos desacoplados de la interfaz.

### 8.2 Excluido de la primera implementación

- generación real de órdenes de trabajo;
- optimizador avanzado de campañas;
- motor genérico completo de expresiones;
- integración productiva con SAP, Maximo o Hexagon;
- migración masiva desde Excel;
- analítica predictiva;
- cálculo avanzado de costes;
- sincronización bidireccional con el CMMS existente;
- despliegue productivo y modelo definitivo de identidad corporativa.

Estas exclusiones no eliminan los requisitos de trazabilidad necesarios para integrarlos posteriormente.

---

## 9. Actores y responsabilidades preliminares

| Actor | Responsabilidad |
|---|---|
| Ingeniero de fiabilidad | Crea y mantiene AMEF, evaluaciones RCM y tareas propuestas. |
| Especialista de mantenimiento | Revisa viabilidad técnica, recursos, duración y frecuencias. |
| Operaciones | Valida contexto, efectos operativos, estados y ventanas. |
| HSE | Revisa consecuencias de seguridad y medioambiente. |
| Aprobador técnico | Aprueba o rechaza etapas asignadas. |
| Administrador funcional | Mantiene catálogos, reglas, árboles y matrices versionadas. |
| Lector / auditor | Consulta revisiones publicadas, trazabilidad y evidencias. |

La matriz definitiva de permisos está pendiente. Codex no debe asociar estos actores a roles técnicos concretos sin una decisión aprobada.

---

## 10. Modelo de dominio mínimo

### 10.1 Agregado de AMEF

| Entidad | Propósito |
|---|---|
| `FmeaDefinition` | Identidad estable del AMEF corporativo. |
| `FmeaRevision` | Revisión versionada, con estado y vigencia. |
| `FmeaFunction` | Función requerida y estándar de funcionamiento. |
| `FunctionalFailure` | Incumplimiento total o parcial de una función. |
| `FailureMode` | Evento o condición que provoca el fallo funcional. |
| `FailureCause` | Causa o mecanismo asociado al modo. |
| `FailureEffect` | Efecto inicial, local, de equipo, sistema o final. |

### 10.2 Evaluación RCM

| Entidad | Propósito |
|---|---|
| `ConsequenceAssessment` | Evaluación contextual de consecuencias, severidad, probabilidad y riesgo. |
| `RcmAssessment` | Instancia del recorrido y decisión final. |
| `RcmAssessmentAnswer` | Respuestas, orden, justificación y evidencia del árbol versionado. |
| `DecisionLogic` | Versión del árbol RCM. |
| `DecisionQuestion` | Pregunta versionada. |
| `DecisionTransition` | Transición entre preguntas o resultados. |

### 10.3 Tratamiento

| Entidad | Propósito |
|---|---|
| `ProposedMaintenanceTask` | Recomendación de ingeniería anterior al Job Plan. |
| `ProposedTaskFailureMode` | Relación N:M entre tareas y modos. |
| `NoScheduledTaskDecision` | Run-to-failure, rediseño u otra salida sin tarea periódica. |

### 10.4 Aplicabilidad

| Entidad | Propósito |
|---|---|
| `FmeaApplicabilityRule` | Condiciones generales de inclusión o exclusión. |
| `FmeaAssetApplication` | Resultado sugerido y validado para un activo. |
| `MaintenanceApplicabilityProfile` | Perfil de aplicación, por ejemplo alta/media/baja criticidad. |
| `TaskProfileVariant` | Variación de aplicabilidad, frecuencia o estado sin clonar la tarea. |

### 10.5 Gobierno

| Entidad | Propósito |
|---|---|
| `RevisionApproval` | Etapas, responsables y decisiones de aprobación. |
| `RevisionChangeLog` | Cambios funcionalmente relevantes con motivo explícito. |
| `PublishedRevisionSnapshot` | Snapshot inmutable de la revisión publicada. |

### 10.6 Entidades externas referenciadas

- `EquipmentType`
- `Asset`
- `AssetRelationship`
- `OperationalContext`
- `CriticalityLevel`
- catálogos de severidad, probabilidad, riesgo, disciplina, actividad, técnica, rol ejecutor, estado operacional, intervalo y estrategia.

---

## 11. Relaciones y cardinalidades clave

| Origen | Cardinalidad | Destino |
|---|---:|---|
| `FmeaDefinition` | 1:N | `FmeaRevision` |
| `FmeaRevision` | 1:N | `FmeaFunction` |
| `FmeaFunction` | 1:N | `FunctionalFailure` |
| `FunctionalFailure` | 1:N | `FailureMode` |
| `FailureMode` | 1:N | `FailureCause` |
| `FailureMode` | 1:N | `FailureEffect` |
| `FailureMode` | 1:N | `ConsequenceAssessment` |
| `FailureMode` | 1:N | `RcmAssessment` |
| `RcmAssessment` | 1:N | `RcmAssessmentAnswer` |
| `ProposedMaintenanceTask` | N:M | `FailureMode` |
| `FmeaRevision` | 1:N | `MaintenanceApplicabilityProfile` |
| `MaintenanceApplicabilityProfile` | N:M | `ProposedMaintenanceTask` |
| `FmeaRevision` | N:M | `Asset`, mediante `FmeaAssetApplication` |
| `FmeaRevision` | 1:N | `RevisionApproval` |

---

## 12. Requisitos funcionales

### 12.1 Definición y revisión

- `FR-REL-001`: el sistema permitirá crear una definición AMEF con identidad estable.
- `FR-REL-002`: cada modificación publicada se realizará mediante una nueva revisión.
- `FR-REL-003`: la revisión tendrá estados como borrador, en revisión, aprobada, publicada, sustituida o retirada, sujetos a definición final.
- `FR-REL-004`: la revisión deberá declarar alcance taxonómico, funcional y contexto de aplicación.
- `FR-REL-005`: el sistema mostrará completitud y errores antes de cambiar de etapa.

### 12.2 Funciones y fallos

- `FR-REL-010`: una revisión contendrá una o más funciones.
- `FR-REL-011`: cada función podrá declarar estándar de funcionamiento y unidad.
- `FR-REL-012`: cada fallo funcional pertenecerá a una función concreta.
- `FR-REL-013`: cada modo pertenecerá a un fallo funcional.
- `FR-REL-014`: un modo admitirá múltiples causas y efectos ordenados.

### 12.3 Consecuencias y RCM

- `FR-REL-020`: las consecuencias se evaluarán dentro de un contexto operacional.
- `FR-REL-021`: se conservarán seguridad, medioambiente, operación, no operación y consecuencia oculta con justificación.
- `FR-REL-022`: cada evaluación utilizará una versión identificada de matriz de riesgo y lógica RCM.
- `FR-REL-023`: cada respuesta del árbol conservará pregunta, respuesta, secuencia, autor, fecha, justificación y evidencia.
- `FR-REL-024`: el sistema calculará una estrategia recomendada y permitirá seleccionar otra solo con motivo de override.

### 12.4 Tratamientos

- `FR-REL-030`: una tarea propuesta podrá detectar, prevenir, mitigar o verificar uno o más modos.
- `FR-REL-031`: un modo podrá relacionarse con varias tareas complementarias.
- `FR-REL-032`: la tarea distinguirá tipo de mantenimiento, actividad, técnica, disciplina, ejecutor, esfuerzo, duración, estado operacional, frecuencia, criterio de aceptación y evidencia.
- `FR-REL-033`: si no existe tarea programada válida, se registrará una decisión explícita.
- `FR-REL-034`: las tareas aprobadas podrán transformarse posteriormente en Job Plans mediante un proceso gobernado, no automático.

### 12.5 Aplicabilidad

- `FR-REL-040`: una revisión podrá definir reglas de inclusión y exclusión.
- `FR-REL-041`: la aplicabilidad se evaluará para un activo y un contexto determinados.
- `FR-REL-042`: el resultado automático podrá ser aplicable, parcial, no aplicable o requiere revisión.
- `FR-REL-043`: un usuario autorizado validará o corregirá el resultado sugerido con motivo.
- `FR-REL-044`: los perfiles modificarán tareas o intervalos sin duplicar funciones, fallos y modos.

### 12.6 Aprobación y publicación

- `FR-REL-050`: la revisión soportará etapas ordenadas de aprobación.
- `FR-REL-051`: cada etapa registrará rol, asignado, decisión, comentario y fecha.
- `FR-REL-052`: la publicación generará un snapshot inmutable.
- `FR-REL-053`: los cambios funcionalmente relevantes registrarán valores anterior y nuevo, motivo, autor y fecha.

### 12.7 Agrupación y ejecución futura

- `FR-REL-060`: las políticas podrán agrupar trabajo por tipo de equipo, planta, actividad, ejecutor, ciclo u otras dimensiones configurables.
- `FR-REL-061`: una campaña u orden agrupada conservará líneas de ejecución por activo.
- `FR-REL-062`: resultado, estado, tiempo, materiales, anomalías y costes se conservarán por activo.
- `FR-REL-063`: una excepción individual podrá generar trabajo correctivo independiente.

---

## 13. Reglas de negocio

- `BR-REL-001`: un AMEF publicado no puede modificarse.
- `BR-REL-002`: solo puede existir una revisión vigente por AMEF y fecha.
- `BR-REL-003`: una función pertenece a una revisión concreta.
- `BR-REL-004`: no existe fallo funcional sin función.
- `BR-REL-005`: no existe modo sin fallo funcional.
- `BR-REL-006`: un modo no puede aprobarse sin efecto y consecuencia documentados.
- `BR-REL-007`: una evaluación RCM usa una versión identificada del árbol.
- `BR-REL-008`: un override exige justificación.
- `BR-REL-009`: una tarea aprobada trata al menos un modo.
- `BR-REL-010`: un modo sin tarea exige una decisión explícita.
- `BR-REL-011`: una frecuencia basada en condición identifica P–F, histórico, norma, fabricante u otra fuente gobernada.
- `BR-REL-012`: una frecuencia no supera el límite técnico aprobado sin excepción autorizada.
- `BR-REL-013`: aplicabilidad automática no significa publicación automática.
- `BR-REL-014`: un activo excluido conserva el motivo.
- `BR-REL-015`: un cambio de criticidad no modifica retroactivamente una aplicación publicada.
- `BR-REL-016`: el padre ADR no determina por sí solo qué tareas se agrupan.
- `BR-REL-017`: publicar crea un snapshot inmutable.
- `BR-REL-018`: un nombre visible se genera desde atributos estructurados y no se analiza como fuente de datos.
- `BR-REL-019`: agrupar activos no elimina su identidad ni su historial individual.

---

## 14. Requisitos no funcionales

- `NFR-REL-001` — **Trazabilidad:** debe poder recorrerse desde requisito y revisión AMEF hasta modo, decisión, tarea, aplicación, Job Plan, PM, WO y resultado.
- `NFR-REL-002` — **Auditabilidad:** toda aprobación, override, exclusión y cambio relevante identifica autor, fecha y motivo.
- `NFR-REL-003` — **Inmutabilidad:** el contenido publicado no se sobrescribe.
- `NFR-REL-004` — **Configurabilidad:** catálogos, matrices y lógica RCM se versionan; no se codifican valores corporativos en la interfaz.
- `NFR-REL-005` — **Desacoplamiento:** la interfaz no accede directamente a tablas; consume contratos estables.
- `NFR-REL-006` — **Usabilidad:** la experiencia debe guiar primero el porqué y después el cómo.
- `NFR-REL-007` — **Accesibilidad:** navegación por teclado, contraste suficiente, mensajes comprensibles y etiquetas semánticas.
- `NFR-REL-008` — **Rendimiento:** listas potencialmente grandes usan paginación y filtros en servidor.
- `NFR-REL-009` — **Concurrencia:** las actualizaciones detectan versiones obsoletas y evitan sobrescritura silenciosa.
- `NFR-REL-010` — **Seguridad:** permisos por acción y etapa; mínimo privilegio.
- `NFR-REL-011` — **Localización:** textos visibles desacoplados de códigos y preparados para traducción.
- `NFR-REL-012` — **Observabilidad:** errores técnicos usan un identificador de correlación sin exponer información sensible.

---

## 15. Estados y flujo de revisión preliminar

```text
DRAFT
→ IN_TECHNICAL_REVIEW
→ IN_OPERATIONS_REVIEW
→ IN_HSE_REVIEW
→ APPROVED
→ PUBLISHED
→ SUPERSEDED | RETIRED
```

Este flujo es una propuesta inicial, no una decisión cerrada. La solución debe permitir configurar etapas sin perder el historial de revisiones existentes.

Transiciones mínimas:

- guardar borrador;
- enviar a revisión;
- devolver con comentarios;
- aprobar etapa;
- rechazar;
- publicar;
- crear nueva revisión desde una publicada;
- sustituir o retirar.

---

## 16. Experiencia de usuario del prototipo

### 16.1 Estructura

- cabecera persistente con código, revisión, estado, alcance y acciones;
- navegación lateral o stepper con nueve etapas;
- área principal de edición;
- panel de contexto con reglas, completitud y trazabilidad;
- resumen final antes de aprobación.

### 16.2 Estados obligatorios

Cada etapa debe contemplar:

- loading;
- contenido;
- vacío;
- validación;
- error recuperable;
- error de permisos;
- conflicto de concurrencia;
- guardado correcto;
- solo lectura por estado publicado.

### 16.3 Principios de interacción

- No exponer el modelo relacional como formularios independientes sin narrativa.
- Explicar por qué se solicita un dato antes de pedirlo.
- Permitir navegación atrás sin perder información.
- No permitir avanzar cuando falten datos críticos, mostrando exactamente cuáles.
- Mantener visibles las relaciones entre función, fallo, modo, consecuencia y tratamiento.
- Mostrar claramente recomendación calculada, decisión adoptada y cualquier override.

---

## 17. Contratos de aplicación preliminares

Codex debe diseñar contratos antes de implementar la interfaz. Nombres orientativos:

| Operación | Propósito |
|---|---|
| `GetFmeaRevision` | Recuperar una revisión completa o una proyección por etapa. |
| `SaveFmeaHeader` | Guardar cabecera y alcance. |
| `SaveFunctionTree` | Guardar funciones, fallos y modos con control de versión. |
| `SaveFailureAnalysis` | Guardar causas y efectos. |
| `SaveConsequenceAssessment` | Guardar consecuencias y riesgo. |
| `EvaluateRcmDecision` | Ejecutar o continuar el árbol RCM versionado. |
| `SaveProposedTreatments` | Guardar tareas y decisiones sin tarea. |
| `EvaluateApplicability` | Calcular aplicabilidad para activos y contexto. |
| `SubmitRevisionForApproval` | Iniciar revisión gobernada. |
| `DecideApprovalStage` | Aprobar, rechazar o devolver una etapa. |
| `PublishFmeaRevision` | Validar y publicar un snapshot atómicamente. |

Todos los contratos deben incluir:

- `correlationId`;
- identidad del usuario resuelta en servidor;
- versión esperada para concurrencia;
- código de resultado;
- mensajes funcionales separados de detalles técnicos;
- validaciones de autorización;
- idempotencia en operaciones de publicación y aprobación.

No debe definirse todavía si estos contratos se implementan con API, procedimientos almacenados y flows, o una combinación, hasta cerrar la arquitectura.

---

## 18. Integración futura con mantenimiento

La revisión publicada debe poder producir recomendaciones trazables, pero no planes ejecutables automáticamente.

La transformación futura debe conservar:

```text
FmeaRevisionId
→ FailureModeId
→ RcmAssessmentId
→ ProposedTaskId
→ JobPlanRevisionId
→ MaintenanceStrategyRevisionId
→ PreventiveMaintenanceId
→ WorkOrderId
→ ExecutionResultId
```

La retroalimentación debe incluir:

- frecuencia real y cumplimiento;
- duración y horas;
- materiales y costes;
- hallazgos;
- fallos observados;
- anomalías;
- efectividad;
- recomendación de conservar, modificar o retirar.

---

## 19. Lecciones de los modelos históricos

La presentación de origen muestra:

| Modelo | Hojas de ruta | Planes |
|---|---:|---:|
| Modelo 1 | 115.000 | 11.169 |
| Modelo 2 | 53.711 | 8.893 |
| Modelo 3 | 6.386 | 6.386 |

Conclusión:

> Un modelo técnicamente correcto puede ser administrativamente inviable.

El Modelo 3 reduce volumen agrupando por tipo de equipo, planta, actividad, ejecutor y ciclo. CMMS 2.0 debe aprovechar esa idea como **política configurable**, no convertir esa combinación en una clave o estructura fija.

Una estrategia futura debe poder combinar:

```text
alcance taxonómico
+ alcance funcional
+ actividad
+ frecuencia o disparador
+ estado operacional requerido
+ ejecutor
+ política de agrupación
= candidatos de mantenimiento
```

---

## 20. Antiobjetivos

Codex no debe:

- crear una única tabla `FMEA` con decenas de columnas que replique Excel;
- guardar funciones, causas, efectos o tareas como textos multilínea no normalizados;
- duplicar el AMEF completo por criticidad;
- convertir automáticamente toda tarea propuesta en un PM;
- confundir FLH, taxonomía y ADR;
- hacer desaparecer activos auxiliares bajo el equipo principal;
- codificar múltiples dimensiones en un texto o nombre;
- conectar componentes visuales directamente a SQL o flows;
- inventar roles, estados, tecnologías o integraciones no aprobadas;
- generar código productivo antes de cerrar las decisiones que afectan a varias capas.

---

## 21. Decisiones arquitectónicas pendientes

| ID | Decisión pendiente | Impacto |
|---|---|---|
| `OPEN-ARCH-001` | Tecnología del prototipo: HTML/TypeScript, Power Apps u otra. | Estructura del repositorio, componentes y pruebas. |
| `OPEN-ARCH-002` | Sistema de registro del módulo: SQL Server/Azure SQL u otro. | Modelo físico, transacciones y seguridad. |
| `OPEN-ARCH-003` | Patrón de acceso: API, Power Automate, SP o híbrido. | Contratos, rendimiento y operación. |
| `OPEN-ARCH-004` | Integración y claves con activos, FLH, taxonomía y ADR existentes. | Integridad referencial y despliegue. |
| `OPEN-ARCH-005` | Proveedor de identidad y matriz de autorización. | Roles, auditoría y publicación. |
| `OPEN-ARCH-006` | Motor y versión inicial del árbol RCM. | Entidades de decisión, UI y pruebas. |
| `OPEN-ARCH-007` | Matriz de riesgo y catálogos corporativos iniciales. | Evaluación de consecuencias. |
| `OPEN-ARCH-008` | Alcance exacto de los perfiles de aplicabilidad en prototipo 04. | UI, reglas y datos semilla. |
| `OPEN-ARCH-009` | Estados y etapas de aprobación definitivos. | Workflow y permisos. |
| `OPEN-ARCH-010` | Convenciones del repositorio donde se integrará. | Rutas, CI, versionado y entregables. |

Estas decisiones deben cerrarse mediante registros de decisión arquitectónica antes de implementar las capas afectadas.

---

## 22. Criterios de aceptación del prototipo

- `AC-REL-001`: se puede crear un AMEF en borrador y completar sus nueve etapas.
- `AC-REL-002`: una función contiene fallos funcionales y cada fallo contiene modos.
- `AC-REL-003`: un modo puede tener varias causas y efectos ordenados.
- `AC-REL-004`: no se completa un modo sin consecuencias justificadas.
- `AC-REL-005`: el recorrido RCM conserva preguntas, respuestas, orden y evidencias.
- `AC-REL-006`: un override exige motivo visible y auditable.
- `AC-REL-007`: una tarea se vincula a uno o más modos y un modo admite varias tareas.
- `AC-REL-008`: es posible registrar una decisión sin tarea periódica.
- `AC-REL-009`: la aplicabilidad sugerida puede validarse o corregirse con motivo.
- `AC-REL-010`: una revisión publicada queda en solo lectura.
- `AC-REL-011`: modificar una publicada crea una nueva revisión, no sobrescribe la anterior.
- `AC-REL-012`: la vista final permite recorrer la trazabilidad completa de la revisión.
- `AC-REL-013`: el prototipo demuestra agrupación sin perder resultados individuales por activo.
- `AC-REL-014`: loading, vacío, error, sin permisos y conflicto de concurrencia tienen representación verificable.
- `AC-REL-015`: no existen referencias a campos, endpoints, flows o componentes inexistentes.

---

## 23. Estrategia de pruebas

### 23.1 Pruebas funcionales

- camino completo hasta publicación;
- devolución y nueva presentación;
- decisión RCM con tarea;
- decisión sin tarea;
- tarea que cubre varios modos;
- modo cubierto por varias tareas;
- aplicabilidad total, parcial, excluida y revisada;
- creación de nueva revisión desde publicada.

### 23.2 Pruebas negativas

- publicar con datos incompletos;
- override sin motivo;
- tarea aprobada sin modo;
- modo sin efecto;
- acceso no autorizado;
- actualización con versión obsoleta;
- doble publicación de la misma revisión;
- intervalo fuera de límites;
- exclusión sin motivo.

### 23.3 Pruebas de integridad

- claves y cardinalidades;
- unicidad de revisión vigente;
- inmutabilidad de publicación;
- transacción de publicación;
- preservación de trazabilidad;
- aislamiento entre revisiones.

### 23.4 Pruebas de experiencia

- navegación completa con teclado;
- mensajes de error accionables;
- conservación de datos al navegar;
- legibilidad del árbol función-fallo-modo;
- visualización clara de recomendación frente a decisión.

---

## 24. Estructura de repositorio recomendada

Debe adaptarse a la estructura real existente. Si el repositorio aún no existe:

```text
docs/
  functional/
    CMMS_2.0_ESPECIFICACION_CODEX_AMEF_RCM.md
  architecture/
    ARCHITECTURE.md
    ADR/
  technical/
    RELIABILITY_APPLICATION_SPECIFICATION.md
  traceability/
    TRACEABILITY.md
  state/
    PROJECT_STATE.md
  risks/
    RISKS_AND_OPEN_POINTS.md
src/
  domain/
  application/
  infrastructure/
  ui/
contracts/
  reliability/
database/
  migrations/
  procedures/
  seeds/
  tests/
tests/
  unit/
  integration/
  acceptance/
```

No crear carpetas vacías ni una arquitectura ceremonial. Crear cada elemento cuando tenga contenido real.

---

## 25. Plan de trabajo para Codex

### Sprint 0 — Reconstrucción y decisiones

Entregables:

- inventario del repositorio;
- `PROJECT_STATE.md`;
- catálogo de requisitos y trazabilidad inicial;
- decisiones vigentes;
- puntos abiertos;
- registros de decisión para tecnología, persistencia, integración, identidad y workflow.

Puerta de salida: arquitectura transversal suficientemente cerrada.

### Sprint 1 — Especificación técnica consolidada

Entregables:

- especificación de aplicación;
- modelo de dominio;
- permisos;
- estados;
- contratos;
- navegación;
- árbol visual;
- criterios de aceptación refinados.

Puerta de salida: cada requisito en alcance tiene diseño y prueba asociada.

### Sprint 2 — Datos y contratos

Entregables:

- modelo lógico y físico;
- diccionario;
- scripts o migraciones;
- datos semilla;
- contratos de lectura y escritura;
- pruebas de integridad y concurrencia.

### Sprint 3 — Shell y etapas 1 a 4

Implementar:

- shell;
- cabecera;
- funciones;
- fallos;
- modos, causas y efectos.

### Sprint 4 — Consecuencias y RCM

Implementar:

- evaluación de consecuencias;
- matriz de riesgo;
- recorrido versionado;
- recomendación y override.

### Sprint 5 — Tratamientos y aplicabilidad

Implementar:

- tareas propuestas;
- decisiones sin tarea;
- relaciones N:M;
- reglas y evaluación de aplicabilidad.

### Sprint 6 — Aprobación y publicación

Implementar:

- etapas;
- permisos;
- devolución y rechazo;
- snapshot inmutable;
- nueva revisión;
- changelog funcional.

### Sprint 7 — Integración, QA y handoff

Entregables:

- trazabilidad final;
- pruebas;
- correcciones;
- instrucciones de ejecución;
- datos de demostración;
- limitaciones reales;
- siguiente fase hacia Job Plans y estrategias.

Cada sprint debe terminar con un entregable verificable. No declarar completado trabajo no implementado o no probado.

---

## 26. Protocolo de trabajo obligatorio para Codex

1. Leer este documento y las instrucciones del repositorio antes de modificar archivos.
2. Inspeccionar el repositorio y reconstruir el estado real.
3. No reabrir decisiones cerradas sin contradicción o limitación técnica comprobable.
4. Registrar hechos, decisiones, restricciones, supuestos y dudas por separado.
5. No generar implementación antes de resolver los puntos que la condicionan.
6. Trabajar por microincrementos completos y verificables.
7. Modificar únicamente archivos necesarios.
8. Entregar archivos completos cuando deban copiarse o sustituirse.
9. Ejecutar pruebas disponibles y reportar resultados literales.
10. No afirmar compatibilidad, compilación o funcionamiento sin evidencia.
11. Preservar cambios existentes del usuario.
12. Actualizar estado, trazabilidad y decisiones al cerrar cada sprint.

### Formato de cierre de cada sprint

```markdown
## Resultado

## Decisiones aplicadas

## Archivos creados

## Archivos modificados

## Validaciones ejecutadas

## Resultados

## Limitaciones o pendientes reales

## Próximo paso exacto
```

---

## 27. Prompt de arranque para Codex

```text
Actúa como Arquitecto Principal y desarrollador responsable del módulo de
Ingeniería de Fiabilidad de CMMS 2.0.

Lee primero:
- las instrucciones del repositorio;
- docs/functional/CMMS_2.0_ESPECIFICACION_CODEX_AMEF_RCM.md;
- PROJECT_STATE.md, si existe;
- los ADR y contratos vigentes.

No implementes todavía el prototipo.

Ejecuta el Sprint 0:
1. inspecciona el repositorio;
2. reconstruye el estado real;
3. compara el repositorio con la especificación;
4. clasifica hechos, decisiones, restricciones, supuestos y dudas;
5. identifica únicamente las decisiones que bloquean varias capas;
6. propone los ADR necesarios;
7. genera o actualiza PROJECT_STATE.md, TRACEABILITY.md y
   RISKS_AND_OPEN_POINTS.md;
8. define el siguiente entregable exacto.

No inventes tecnología, tablas, endpoints, roles ni estados definitivos.
No modifiques código de aplicación en este sprint.
No reabras las decisiones funcionales marcadas como cerradas.
Entrega archivos completos, coherentes y listos para incorporar al repositorio.
```

---

## 28. Estado de la especificación

### Cerrado

- separación conceptual AMEF → RCM → tarea → Job Plan → estrategia → PM → WO;
- separación FLH / taxonomía / ADR;
- versionado e inmutabilidad;
- aplicabilidad validada;
- cardinalidad N:M de tareas y modos;
- decisiones explícitas sin tarea;
- identidad individual en agrupaciones;
- flujo guiado del prototipo 04;
- núcleo mínimo de dominio.

### Pendiente

- arquitectura de ejecución;
- tecnología y repositorio objetivo;
- matriz de permisos;
- catálogo inicial y matrices;
- workflow definitivo;
- contratos físicos;
- alcance exacto de perfiles avanzados;
- integración con el CMMS existente.

### Siguiente paso

Incorporar este documento al repositorio y ejecutar el Sprint 0 con el prompt de arranque. No comenzar por generar pantallas: primero debe cerrarse la arquitectura que afecta a datos, contratos, seguridad y versionado.

