# ANL-005 — Revisión funcional posterior a reunión 2026-09-25

**Fecha:** 2026-09-25
**Estado:** análisis funcional aplicado
**Fuente:** [reunión 2026-09-25](../2026/2026-09-25_revision-cmms-work-management-execution-feedback.md)

## 1. Hallazgo principal

La reunión convierte Work Management de un handoff abstracto en un **ciclo funcional reconocible** y corrige dos hipótesis anteriores:

1. la generación preventiva no debe materializar órdenes para toda la vida útil ni depender de un lote anual como única mecánica;
2. Work Candidate no debe ser una etapa universal para el preventivo ya aprobado.

Nuevo baseline conceptual:

~~~text
Published Project Maintenance Plan
→ rolling next due
→ Preventive Work Order
→ readiness / permits
→ execution
→ execution feedback
→ planner close
→ KPI / reporting
→ continuous improvement
~~~

## 2. Corrección de la hipótesis de generación anual

La documentación anterior utilizaba:

~~~text
PlanningYear + BudgetContext
→ PrepareAnnualPreventiveOrders
~~~

La reunión 2026-09-25 aporta una definición más precisa para la **materialización operacional**:

~~~text
plan frequency
→ next due
→ WO when due
→ execution
→ next due
~~~

Por tanto:

- el año/presupuesto puede seguir existiendo como **forecast / budget context**;
- no debe implicar que el sistema cree físicamente todas las WO del año o de la vida útil;
- el modelo runtime/productivo debe separar ForecastOccurrence de MaterializedWorkOrder.

## 3. Work Candidate deja de ser universal

La hipótesis previa era:

~~~text
ScheduledMaintenanceActivity
→ WorkCandidate
→ WorkOrderProposal
→ WorkOrder
~~~

Para preventivo recurrente aprobado, la reunión la corrige a:

~~~text
ScheduledMaintenanceActivity
→ due event
→ PreventiveWorkOrder
~~~

La obligación de cumplir el plan ya fue aprobada aguas arriba.

WorkCandidate puede conservarse para correctivos, backlog no rutinario, recomendaciones, solicitudes de trabajo o trabajos todavía no comprometidos. Esos usos siguen to_validate.

## 4. Separar forecast de ejecución

El modelo debe distinguir:

~~~text
ForecastOccurrence
MaterializedWorkOrder
~~~

El forecast puede proyectar carga/coste futuro sin generar miles de órdenes.

La ejecución solo materializa el trabajo necesario según la política de recurrencia/horizonte configurada.

## 5. Execution Package

La reunión mejora WM-G02.

Una WO debe resolver:

~~~text
Maintenance Activity
+ JobPlan
+ ProcedureChecklist
+ Asset Technical Documents
+ task-specific attachments
+ permit requirements
+ shutdown / operations constraints
= ExecutionPackage
~~~

### Provenance documental

- manuales/planos/documentación técnica viven preferentemente asociados al activo;
- Job Plan/procedure aporta instrucciones de ejecución;
- una WO correctiva puede añadir recomendaciones/documentos específicos de Ingeniería.

No se deben copiar físicamente todos los documentos del activo dentro de cada WO si pueden resolverse por referencia.

## 6. Operations permissive

Nueva relación funcional suficientemente clara:

~~~text
requiresShutdown = true
→ Operations permissive required
→ execution can start
~~~

El contrato exacto con un futuro Permit to Work sigue abierto.

## 7. Lifecycle funcional descubierto

Sin cerrar todavía los nombres de estados, el comportamiento es:

~~~text
prepared / released
→ executor receives
→ work starts
→ execution result + findings
→ execution complete
→ planner validation
→ technical close
~~~

### Preventive finding branch

~~~text
Preventive WO
→ finding requiring repair
→ Corrective Work Order / corrective process
~~~

No debe inflarse el scope de la preventiva para ocultar una reparación nueva.

## 8. Planner como cierre del loop

La reunión atribuye a Planning una responsabilidad importante: preparar, controlar que el dato de ejecución vuelva, comprobar cierre y utilizar feedback para mejorar las estimaciones.

Esto no implica todavía un rol RBAC definitivo.

La propuesta de un Data Capture/capturista bajo Planning se registra como opción organizativa, no como requerimiento universal.

## 9. Datos reales mínimos

El futuro contrato de ejecución debería contemplar, cuando aplique:

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

La obligatoriedad exacta por preventivo/correctivo queda por contratar.

## 10. Preventivo vs correctivo

### Preventivo

- baseline de tiempo/recursos conocido;
- execution package estable;
- se registran ejecución y hallazgos;
- el planner cierra;
- desviaciones reales deben poder medirse.

### Correctivo

- alcance más variable;
- actual hours/resources/materials especialmente relevantes;
- puede incorporar recomendación técnica/documentos específicos;
- necesita modelado adicional de diagnosis/work request.

## 11. KPI / data quality

La reunión valida la necesidad de datos temporales consistentes para evitar indicadores falsos.

Candidatos explícitos:

- MTBF;
- MTTR;
- planned vs actual deviation;
- overdue recommendation aging;
- maintenance cost trend;
- reliability trend.

Especialmente confirmado:

~~~text
Planning Accuracy / Deviation
= planned duration/resources vs actual
~~~

Un patrón persistente puede originar una recomendación de revisión del plan/Job Plan. El automatismo sigue to_validate.

## 12. Convergencia con Reliability Engineering

La ejecución real alimenta directamente FL-27/FL-28:

~~~text
Execution actuals
→ effectiveness analysis
→ plan / interval / resource review
→ new plan version when approved
~~~

Esto convierte el loop de mejora continua en una interfaz de datos concreta, no solo conceptual.

## 13. Impacto sobre Functional Lab

### P-101

P-101 sigue siendo el caso RCM.

Después de WS-08 podrá, en una extensión futura, demostrar que una actividad publicada:

~~~text
Published Activity
→ Next Due
→ Preventive WO
→ Execution Package
→ Execution Feedback
→ Planner Close
→ Plan-vs-Actual
→ WS-09 effectiveness
~~~

No se crea todavía una WO ficticia en el fixture actual.

### Work Management extension

La futura demo debe incorporar al menos dos situaciones:

1. preventiva ejecutada sin hallazgo;
2. preventiva con hallazgo que abre rama correctiva.

Y debe mostrar que los documentos maestros del activo se resuelven por referencia.

## 14. Gates revisados

### WM-G01 — Process evidence

**Estado:** partial.

El expert walkthrough es consistente, pero sigue pendiente contrastar proceso real/herramienta cuando sea posible.

### WM-G02 — Execution Package

**Estado:** partial-advanced.

Ya están identificadas fuentes, procedimientos, documentos, permisos y diferencias preventivo/correctivo.

### WM-G03 — Planning/Scheduling

**Estado:** partial.

Confirmado:

- rolling next due;
- no lifetime materialization;
- preventivo aprobado no requiere Work Candidate universal;
- desviación requiere justificación.

Pendiente:

- horizon/trigger exacto;
- capacity;
- shifts;
- grouping;
- assignment;
- replanning rules.

### WM-G04 — Costs / contracts

**Estado:** open.

### WM-G05 — Execution feedback & data integrity

**Estado:** new / partial.

Debe cerrar timestamps, actuals, findings, planner validation, close timing, data quality, plan-vs-actual y KPI source contract.

## 15. Conclusión

La nueva cadena funcional es:

~~~text
Asset + Criticality
→ Maintenance Strategy
→ Published Maintenance Plan
→ Rolling Next Due
→ Preventive Work Order
→ Execution Package + Operations permissive
→ Execution + Findings
→ Planner Closure
→ Reliable Actual Data
→ KPIs / Reports
→ Continuous Improvement
→ Plan / Job Plan Revision
~~~

El modelo ya no debe separar diseño del mantenimiento y ejecución como dos mundos desconectados. La calidad del feedback de Work Management es parte de la capacidad de Reliability Engineering para aprender.
