# DEC-025 — Agrupación anual de ejecuciones preventivas

**Estado:** CONFIRMED — comportamiento funcional; contrato técnico pendiente  
**Fecha:** 2026-10-30  
**Dominio:** Triggering / Work Management / Execution  
**Fuente:** CMMS Propuesta de solución, versión 2026-10-30, pp. 3–6; confirmación de Rubén en esta sesión.

## Decisión funcional

Para determinadas actividades preventivas por tiempo, el CMMS gestiona una única Work Order anual que agrupa varias ejecuciones periódicas dentro del ciclo. Cada ejecución conserva su fecha y resultado. No se crea una Work Order independiente por actuación programada para este patrón.

La regla es selectiva. No se asume que toda actividad preventiva debe agruparse anualmente ni que todas las frecuencias usan año natural. Las mediciones de condición mantienen su cadencia propia y una medición o alarma no genera una reparación automática.

## Invariantes

1. La orden anual identifica el trabajo preventivo y conserva el vínculo con el Plan de Mantenimiento Aprobado y su versión.
2. Cada actuación programada conserva identidad, fecha prevista y estado; su ExecutionRecord asociado conserva fecha real, resultado y feedback de lo ejecutado.
3. Una intervención distinta detectada durante una actuación preventiva programada abre una rama correctiva trazable; no se oculta ampliando la actuación programada.
4. El calendario de la orden no sobrescribe el vencimiento que determina Triggering.
5. La orden anual no autoriza materializar preventivas para toda la vida del activo.
6. Un reintento no debe duplicar la orden anual ni una actuación programada, incluso si llega con un RequestId distinto.
7. Al cierre del ciclo, las actuaciones programadas pendientes siguen pendientes de decisión: no se trasladan, cierran ni reemplazan automáticamente.

## Diseño técnico recomendado — candidate

El modelo SQL actual no representa la decisión: WorkOrder contiene una sola MaintenanceOccurrence y ExecutionRecord tiene una fila única por WorkOrder.

Se propone:

- WorkOrder: cabecera anual del trabajo.
- WorkOrderPlannedAction: una fila por actuación preventiva programada dentro del ciclo.
- MaintenanceOccurrence: evidencia de liberación/vencimiento de Triggering asociada, cuando aplique, a una actuación programada; cada occurrence se relaciona como máximo con una WorkOrderPlannedAction.
- ExecutionRecord: fechas reales, resultado y feedback de una actuación programada efectivamente ejecutada.
- PlanningPackage: preparación común de la WorkOrder, si la política de trabajo confirma que aplica a todas sus actuaciones programadas.
- ScheduleAssignment: asignación por actuación programada cuando las fechas/cuadrillas puedan diferir.

Las cardinalidades exactas y el momento de crear cada entidad deben cerrarse en el contrato DB/SP antes de modificar el runtime.

## Contratos que deben cambiar

- Logical model: occurrence → planned action → annual WorkOrder.
- SQL: relación múltiple WorkOrder–actuaciones programadas; ejecución/actuals por actuación programada; restricciones naturales para ciclo, actuación programada e idempotencia.
- Stored procedures: materialización/agrupación, consulta de detalle, cola, programación, ejecución y cierre.
- Power Automate: payloads y respuestas compatibles con la orden anual y sus actuaciones programadas.
- Power Apps/DVP: lista de órdenes con resumen de actuaciones programadas y detalle de cada actuación programada, usando datos sintéticos trazables.
- Migration: preservar WorkOrders/actuals existentes, asociar cada WO histórica a una actuación programada, y permitir rollback antes de retirar columnas antiguas.

## Decisiones aún OPEN

- Criterio de elegibilidad de una actividad para agrupación anual.
- Definición del ciclo: año natural, fiscal o vigencia del plan.
- Momento de crear la WorkOrder y de liberar/materializar las actuaciones programadas.
- Si la preparación es compartida por el ciclo, por actuación programada o por ambas.
- Programación y asignación de recursos por actuación programada.
- Estados agregados de WorkOrder y estados de WorkOrderPlannedAction.
- Tratamiento de actuaciones programadas pendientes al cierre anual y su efecto en cumplimiento.
- Regla exacta para reiniciar frecuencias después de una reparación mayor.
- Forma de integrar las actuaciones programadas anuales con MaintenanceTriggerState.OpenMaintenanceOccurrenceId.

Ninguna de estas cuestiones permite alterar el comportamiento confirmado de la orden anual; delimitan el contrato físico y sus excepciones.

## Gate

**PM-GROUP-G01 — Annual Order Logical/Physical Contract**  
Riesgo C. Requiere contrato lógico revisado, migración aditiva, rollback revisado, validación de integridad/idempotencia/concurrencia y nuevo runtime gate para SQL y Power Automate. El antiguo test PA-G01-RUNTIME-MIN con materialización occurrence→WO individual queda bloqueado hasta alinear su contrato.


## Terminología funcional

La interfaz llamará **actuación preventiva programada** a cada elemento previsto dentro de la orden del ciclo; no se denominará «visita». El `ExecutionRecord` registrará lo realmente ejecutado, con sus fechas, resultado y feedback. `MaintenanceOccurrence` seguirá siendo la evidencia de vencimiento/liberación de Triggering, no el nombre de la actuación. `WorkOrderPlannedAction` es el identificador técnico candidato para el elemento planificado; la entidad física aún no está aprobada.
