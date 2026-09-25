# CMMS 2.0 Functional Lab — Extensión futura de Gestión del Trabajo

**Fecha de revisión:** 2026-09-25
**Estado:** advanced discovery / no implementation
**Fuentes:**
- [reunión 2026-08-21](../../05-meetings/2026/2026-08-21_revision-cmms-gestion-ordenes-trabajo.md)
- [reunión 2026-09-25](../../05-meetings/2026/2026-09-25_revision-cmms-work-management-execution-feedback.md)
- [Work Management discovery v0.3](../../02-functional/process-model/work-management-discovery.md)

## 1. Cambio de alcance

La reunión 2026-09-25 aporta suficiente detalle para definir **qué debería demostrar** una futura extensión de Work Management, aunque todavía no autoriza una implementación productiva.

Se mantienen P-101 como caso RCM, los nueve workspaces RCM y Work Management como extensión posterior al plan publicado.

Se corrigen la generación anual como única mecánica y Work Candidate como paso universal del preventivo.

## 2. Handoff corregido

La demo debe explicar:

~~~text
Published Project Maintenance Plan
→ Rolling Recurrence
→ Next Due Maintenance
→ Preventive Work Order
~~~

Forecast/año/presupuesto puede existir como vista futura de carga, pero no equivale a materializar todas las WO.

## 3. Experience WM-A — preventiva normal

~~~text
Published Maintenance Activity
→ Next Due
→ Preventive WO generated
→ Execution Package
→ permits / Operations permissive when required
→ Executor starts
→ work completed
→ execution result
→ Planner validates
→ technical close
→ next due calculated
~~~

Objetivo pedagógico: demostrar el ciclo sin ruido de correctivos.

## 4. Experience WM-B — preventiva con hallazgo

~~~text
Preventive WO
→ execution
→ finding
→ preventive completion
→ Corrective Work created/linked
→ preventive closed by Planner
~~~

La demo debe dejar claro que el hallazgo genera un nuevo trabajo y no altera silenciosamente el scope de la preventiva.

## 5. Execution Package visible

La UI futura debe poder mostrar, por referencia:

~~~text
Maintenance Activity
Job Plan
Procedure / Checklist
Asset manuals / drawings / technical documents
Work-order-specific attachments
Permit / shutdown requirement
~~~

Los documentos maestros del activo no se duplican necesariamente dentro de la WO.

## 6. Operations gate

Cuando la actividad requiere parada:

~~~text
Operations Permissive = pending
→ Start Work blocked

Operations Permissive = granted
→ execution may continue
~~~

El control visual exacto y la integración con Permit to Work quedan to_validate.

## 7. Execution feedback

La futura demo debe capturar al menos conceptualmente actual start, actual finish, actual duration, execution outcome, findings, executor, feedback timestamp, close timestamp y planner close.

Para correctivo, además: actual labor, actual materials/resources y engineering recommendation/attachments cuando aplique.

## 8. Plan vs Actual

Después del cierre, la demo debería poder mostrar:

~~~text
Planned duration
Actual duration
Deviation %
~~~

y explicar que la desviación alimenta mejora continua.

No debe inventarse un threshold automático de alerta antes de validar la regla.

## 9. Enlace con WS-09

~~~text
Work Order Actuals
→ WS-09 Effectiveness / Improvement
→ review plan / Job Plan / interval / resources
~~~

Así se cierra el loop entre diseño del mantenimiento y realidad operacional.

## 10. Qué no debe simular todavía

No presentar como aprobado:

- estado definitivo del lifecycle;
- reglas exactas de generation trigger;
- capacity/shift scheduling;
- algoritmo de assignment;
- Permit to Work completo;
- financial closure;
- cost allocation;
- invoicing;
- thresholds automáticos de KPI.

## 11. Fixture futuro

No modificar todavía P-101 con WO ficticias.

Después de contratos mínimos puede construirse un fixture derivado y explícitamente sintético/controlado para demostrar:

1. preventiva sin hallazgo;
2. preventiva con hallazgo y correctiva enlazada.

El fixture deberá mantener trazabilidad a la Published Activity de P-101 o a otra fuente seleccionada.

## 12. Gates antes de implementación

~~~text
WM-G02 Execution Package contract
+ WM-G03 recurrence / lifecycle minimum contract
+ WM-G05 feedback/data contract
+ UX surface decision
+ versioned fixture
+ Studio gate
~~~

Solo después debe comenzar una implementación Power Apps de Work Management.
