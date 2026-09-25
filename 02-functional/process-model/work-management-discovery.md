# Gestión del Trabajo — Discovery funcional preliminar

**Versión:** discovery v0.3
**Última revisión:** 2026-09-25
**Estado:** principios clave confirmados; lifecycle y contratos todavía parciales
**Fuentes principales:**
- [2026-08-21 — Gestión de órdenes de trabajo](../../05-meetings/2026/2026-08-21_revision-cmms-gestion-ordenes-trabajo.md)
- [2026-09-11 — Estándares y Job Plans](../../05-meetings/2026/2026-09-11_revision-cmms-estandares-job-plans.md)
- [2026-09-25 — Ejecución, feedback y calidad del dato](../../05-meetings/2026/2026-09-25_revision-cmms-work-management-execution-feedback.md)

## 1. Propósito

Registrar el modelo funcional descubierto para **Gestión del Trabajo** sin convertir referencias parciales en arquitectura productiva prematura.

El documento distingue principios confirmados, comportamiento suficientemente explicado, hipótesis TO-BE y decisiones todavía to_validate.

## 2. Frontera de entrada

Gestión del Trabajo comienza después de disponer de un plan de mantenimiento de proyecto publicado.

La reunión del 2026-09-25 corrige el modelo anterior para el mantenimiento preventivo recurrente.

~~~text
Published Project Maintenance Plan
→ Rolling Preventive Schedule
→ Next Due Maintenance Activity
→ Preventive Work Order
→ Execution
→ Planner Closure
→ Next Due
~~~

No deben materializarse todas las órdenes de la vida útil.

El forecast puede proyectar carga o presupuesto futuro, pero debe diferenciarse de las órdenes realmente creadas.

## 3. Work Candidate — alcance corregido

El modelo previo trataba Work Candidate como paso intermedio universal:

~~~text
ScheduledMaintenanceActivity
→ WorkCandidate
→ WorkOrderProposal
→ WorkOrder
~~~

La reunión 2026-09-25 corrige esta hipótesis para preventivo aprobado.

Una vez que el plan está aprobado con alcance, frecuencia y recursos, la actividad es obligatoria salvo desviación justificada.

Por tanto:

~~~text
ScheduledMaintenanceActivity
→ due event
→ PreventiveWorkOrder
~~~

WorkCandidate puede seguir existiendo para trabajo todavía no comprometido, correctivos, recomendaciones, backlog o solicitudes de trabajo, pero esos usos siguen to_validate.

## 4. Contrato upstream

La unidad recibida desde Maintenance Engineering es una **Maintenance Activity**, no cada paso del checklist.

~~~text
Maintenance Activity
├── asset / scope
├── strategy
├── frequency / recurrence
├── criticality context
├── estimated duration/resources
├── Job Plan reference
├── Procedure / Checklist reference
├── shutdown / permit requirements
└── source / provenance
~~~

La criticidad procede del Asset Master y puede haber influido en estrategia/frecuencia antes de publicar el plan.

## 5. Rolling preventive recurrence

Principios confirmados:

1. no generar preventivas para toda la vida útil;
2. calcular/materializar la siguiente intervención;
3. después de ejecución/cierre se calcula la siguiente según el plan vigente;
4. una no ejecución o retraso debe quedar justificado;
5. forecast presupuestario y WO materializada son conceptos diferentes.

Objetos conceptuales candidatos:

~~~text
PreventiveRecurrence
ForecastOccurrence
NextDueOccurrence
MaterializedWorkOrder
~~~

El trigger exacto de materialización sigue to_validate.

## 6. Execution Package

Una WO debe resolver el paquete necesario para ejecutar:

~~~text
WorkOrder
+ MaintenanceActivity
+ JobPlan
+ ProcedureChecklist
+ AssetTechnicalDocuments
+ WorkOrderAttachments
+ PermitRequirements
+ Shutdown / Operations constraints
= ExecutionPackage
~~~

### Documentos

- manuales, planos y documentación técnica deben resolverse preferentemente desde el activo;
- Job Plan/procedure aporta el detalle operativo estable;
- una correctiva puede añadir recomendaciones técnicas/documentos específicos;
- no debe duplicarse físicamente toda la documentación maestra en cada WO cuando pueda resolverse por referencia.

## 7. Permisos y Operaciones

Si la actividad exige sacar el equipo de servicio:

~~~text
requiresShutdown = true
→ Operations permissive required
→ execution enabled
~~~

El modelo exacto de Permit to Work / isolation / LOTO permanece fuera de contrato por ahora.

## 8. Lifecycle funcional descubierto

Sin cerrar todavía los nombres de estado:

~~~text
WO prepared/released
→ executor receives
→ work starts
→ execution
→ execution result + findings
→ execution complete
→ planner validation
→ technical close
~~~

### Preventive finding

~~~text
Preventive Work Order
→ finding requiring repair
→ Corrective Work Order / corrective process
~~~

Una reparación nueva no debe ocultarse ampliando silenciosamente el scope de la preventiva.

## 9. Responsabilidades

### Planner / Planning

Planning debe preparar/coordinar la orden, asegurar que el feedback vuelve al sistema, comprobar que la ejecución queda correctamente registrada, cerrar la orden preventiva y utilizar la información real para mejorar estimaciones.

### Programmer / Scheduler

Se mantiene la separación conceptual entre planificación y programación, pero la terminología final de roles sigue abierta.

### Executor

Debe acceder al execution package, ejecutar, registrar resultado y hallazgos e indicar finalización.

### Operations

Cuando existe necesidad de indisponibilidad/parada, concede el permisivo operativo necesario.

### Data Capture

Se registra como **opción organizativa**, sugerida para garantizar feedback fiable cuando el ejecutor no pueda cargar información inmediatamente. No se convierte en rol obligatorio del producto.

## 10. Preventivo vs correctivo

### Preventivo

- baseline de alcance/tiempo/recursos conocido;
- documentos/instrucciones generalmente estables;
- resultado y hallazgos deben registrarse;
- el planner realiza validación/cierre;
- las desviaciones reales deben poder medirse.

### Correctivo

- alcance más variable;
- actual hours/resources/materials especialmente relevantes;
- puede incorporar recomendaciones técnicas de Ingeniería;
- necesita discovery adicional de diagnosis/work request;
- cierre y costes pueden requerir reglas distintas.

## 11. Datos de ejecución

Candidatos mínimos:

~~~text
plannedDue
plannedDuration
plannedResources
actualStart
actualFinish
actualDuration
actualResources
executionResult
findings
correctiveReference
executor
feedbackCapturedAt
technicalClosedAt
closedBy
~~~

La obligatoriedad exacta depende del tipo de WO y sigue pendiente de contrato.

## 12. Calidad del dato

Principio confirmado:

> La calidad del CMMS y de sus decisiones depende directamente de la calidad y puntualidad del feedback de ejecución.

Problemas a evitar:

- cierre días/semanas después del trabajo real;
- fechas de fallo/reparación falsas;
- feedback perdido en papel;
- actuals incompletos;
- órdenes abiertas artificialmente.

El sistema debe diferenciar, cuando aplique:

~~~text
execution completed
≠
technical closed
≠
financial/cost complete
~~~

## 13. KPIs y mejora continua

Métricas explícitamente comentadas:

- MTBF;
- MTTR;
- planned vs actual deviation;
- overdue recommendation aging;
- maintenance cost trend;
- reliability trend.

### Planning deviation

~~~text
Deviation %
= (Actual - Planned) / Planned
~~~

El significado exacto de signo/normalización debe estandarizarse antes de implementación.

La repetición de desviaciones debe poder alimentar una revisión de duración estándar, recursos, Job Plan, coordinación con Operaciones y estrategia/frecuencia cuando corresponda.

La detección automática de patrón es candidata a system recommendation, no decisión automática.

## 14. Feedback a Reliability Engineering

~~~text
Execution Actuals
→ KPI / Deviation Analysis
→ Effectiveness Review
→ Plan / Job Plan Change Proposal
→ governed new version
~~~

Esto alimenta directamente el loop de efectividad/mejora de Reliability Engineering.

## 15. Reporting

Tras el cierre técnico, el CMMS debe conservar datos suficientes y fiables para informes periódicos, auditoría, KPIs, análisis de rendimiento y comparación coste vs fiabilidad.

La tecnología de presentación —Power BI, reports nativos u otra— permanece abierta.

## 16. Gates actualizados

### WM-G01 — Process evidence

**Estado:** partial.

Existe expert walkthrough consistente. Sigue pendiente contrastar herramienta/proceso real cuando sea posible.

### WM-G02 — Execution Package

**Estado:** partial-advanced.

Ya están identificados Activity, Job Plan, Procedure, documentación del activo, attachments y permisos.

Pendiente cerrar contrato y fuente documental real.

### WM-G03 — Planning / Scheduling

**Estado:** partial.

Confirmado:

- rolling next due;
- no lifetime materialization;
- preventivo aprobado sin Work Candidate obligatorio;
- retraso/no ejecución debe justificarse.

Pendiente:

- trigger/horizon exacto;
- grouping;
- capacity;
- shifts;
- assignment;
- replanning.

### WM-G04 — Costs / contracts

**Estado:** open.

El cierre técnico puede preceder a la llegada completa de costes. La lógica económica detallada sigue pendiente.

### WM-G05 — Execution Feedback & Data Integrity

**Estado:** partial / new.

Debe cerrar timestamp contract, actual resource contract, finding/corrective linkage, planner validation, technical close, data-quality rules, plan-vs-actual y KPI source contract.

## 17. Objetos conceptuales candidatos

~~~text
PreventiveRecurrence
ForecastOccurrence
NextDueOccurrence
WorkOrder
CorrectiveWorkOrder
ExecutionPackage
ExecutionResult
ExecutionFinding
OperationsPermissive
WorkOrderAttachment
AssetDocumentReference
ExecutionActual
PlanVsActualMetric
WorkOrderClosure
~~~

No constituyen todavía esquema SQL/API.

## 18. Impacto sobre Functional Lab

La futura extensión de Work Management ya puede representar un loop funcional más concreto:

~~~text
Published Activity
→ Next Due
→ Preventive WO
→ Execution Package
→ Operations Permissive if required
→ Execution
→ Finding?
→ Planner Close
→ Plan vs Actual
→ Effectiveness / Improvement
~~~

No se implementa todavía como comportamiento productivo hasta disponer de contratos mínimos y fixture controlado.
