# Notas de reunión — Revisión CMMS 2.0: ciclo preventivo, ejecución y calidad del dato

**Fecha:** 2026-09-25
**Participantes:** Rubén Seijo Vilaboy, Hernando Alberto Gómez de la Vega
**Fuente:** transcripción de la reunión de Teams
**Ámbito principal:** estrategia de mantenimiento, generación de preventivas, paquete de ejecución, permisos, ejecución/cierre de órdenes, calidad del dato, KPIs y mejora continua.

## 1. Estrategia de mantenimiento y criticidad

- Se revisó el encaje entre estrategia de mantenimiento, plan preventivo y órdenes de trabajo.
- La estrategia debe considerar como mínimo el activo, su diagnóstico/contexto, criticidad, plan, frecuencia y generación posterior de trabajo.
- Se mantuvieron como estrategias principales:
  - mantenimiento basado en condición;
  - mantenimiento basado en tiempo;
  - run-to-failure.
- La criticidad condiciona el rigor/frecuencia del mantenimiento.
- Se confirmó que la **criticidad es un atributo del activo/equipo**, procedente de la lista o modelo maestro de activos; no debe definirse de nuevo dentro del Job Plan.
- Las frecuencias del plan pueden ajustarse en función de la criticidad y del contexto aplicable.

## 2. Corrección del modelo de generación preventiva

Se revisó expresamente cómo debe pasar un plan preventivo aprobado al trabajo real.

La sesión corrige una hipótesis anterior: **no conviene materializar todas las intervenciones futuras de la vida útil ni llenar el calendario con órdenes a largo plazo**.

El comportamiento funcional propuesto y aceptado es:

~~~text
Published Project Maintenance Plan
→ calcular la siguiente intervención
→ generar la orden preventiva cuando corresponda
→ ejecutar
→ cerrar
→ calcular la siguiente intervención
~~~

Una vez que el plan está aprobado, con alcance, recursos y frecuencias definidos, su cumplimiento deja de ser discrecional. Si una intervención no se ejecuta cuando corresponde, debe quedar **justificada la desviación**.

### Consecuencia sobre Work Candidate

Para mantenimiento preventivo recurrente ya aprobado, el concepto de Work Candidate **no debe ser un paso obligatorio entre calendario y orden de trabajo**.

La conversación llevó a corregir el flujo:

~~~text
Plan preventivo aprobado
→ siguiente vencimiento
→ Work Order
→ ejecución
~~~

El concepto de candidato puede seguir siendo útil en trabajos no rutinarios/correctivos o para otros procesos todavía por validar, pero no debe imponerse como etapa universal del preventivo.

## 3. Job Plan, procedimientos y documentación técnica

- Los procedimientos/checklists ya contemplados en el Job Plan forman parte del paquete normal de ejecución.
- Además del procedimiento pueden ser necesarios manuales, dibujos, planos, documentación técnica del activo y recomendaciones de ingeniería.
- La documentación técnica del equipo debería quedar asociada al activo desde las fases tempranas de registro/desarrollo del plan y ser accesible posteriormente desde la orden de trabajo.
- En preventivo, el paquete documental es normalmente estable porque deriva del plan aprobado, manuales y análisis previos.
- En correctivo puede aparecer documentación adicional generada durante el diagnóstico, especialmente recomendaciones o estudios de Ingeniería.

Principio derivado:

~~~text
Asset
└── Technical Documentation
       ↓
Job Plan / Procedure
       ↓
Work Order Execution Package
~~~

La orden puede añadir documentación específica cuando el caso lo requiera, sin duplicar innecesariamente la documentación maestra del activo.

## 4. Permisos y relación con Operaciones

- La orden debe considerar los permisos necesarios para ejecutar el trabajo.
- Si la actividad requiere sacar el equipo de servicio, **Operaciones debe conceder el permisivo/autorización operacional** antes de la ejecución.
- La condición requiresShutdown / equipmentInService debe derivarse de la actividad/plan y formar parte de la preparación de la orden.

La ventana de mantenimiento y el modelo completo de coordinación con Operaciones todavía requieren mayor detalle.

## 5. Ejecución y cierre de la orden

La sesión permite definir un ciclo más claro:

~~~text
Planner + programación
→ Work Order preparada/liberada
→ Executor
→ ejecución + hallazgos
→ ejecución completada
→ Planner
→ validación/cierre
~~~

### Preventivo

- El ejecutor realiza el trabajo y registra lo ejecutado y los hallazgos.
- Si aparece una anomalía que requiere reparación, debe originarse un **trabajo/orden correctiva independiente**.
- El planificador es quien finalmente debe asegurar la calidad de la información y cerrar la orden preventiva.

### Correctivo

El alcance real puede variar considerablemente y, por tanto, resulta especialmente importante registrar horas-hombre reales, recursos utilizados, materiales/repuestos, trabajo realmente realizado, hallazgos y recomendaciones técnicas.

## 6. Calidad del dato como requisito funcional

Uno de los puntos centrales de la reunión fue que un CMMS solo puede soportar decisiones fiables si los datos de ejecución son fiables.

Se identificaron problemas habituales:

- ejecución registrada días después;
- información anotada en papel y perdida;
- órdenes que permanecen abiertas mucho después de terminar el trabajo;
- horas o recursos reales no registrados;
- fechas de fallo/reparación inconsistentes.

Esto altera directamente indicadores como MTBF, MTTR, desviaciones de planificación y costes.

### Responsabilidad

Hernando propuso situar la responsabilidad sobre la calidad/cierre de la información bajo Planning, incluso mediante una función específica de captura de datos cuando sea necesario.

Esto se registra como **principio organizativo a validar**, no como rol corporativo obligatorio.

## 7. Métricas y mejora continua

La reunión confirmó la utilidad de comparar sistemáticamente lo planificado con lo realmente ejecutado.

Indicador destacado:

~~~text
Planning Deviation %
= diferencia entre duración/recursos planificados y reales
~~~

Ejemplo:

~~~text
Planned duration = 2 h
Actual duration  = 3 h
Deviation        = +50 %
~~~

La métrica debe poder aplicarse tanto a preventivos como a correctivos.

La repetición de desviaciones permite revisar estimaciones del Job Plan, recursos, ventanas, coordinación con Operaciones, tiempos improductivos y estrategia/plan cuando corresponda.

También se comentaron como relevantes MTBF, MTTR, aging/retraso de recomendaciones pendientes, relación entre evolución de fiabilidad y coste de mantenimiento, e informes de ejecución y auditoría.

El sistema puede en el futuro detectar patrones de desviación y recomendar revisión, pero el automatismo exacto queda to_validate.

## 8. Feedback hacia el plan

Se confirmó la necesidad de cerrar el ciclo:

~~~text
Plan / Job Plan
→ Work Order
→ ejecución real
→ datos reales
→ análisis de desviaciones
→ ajuste de estimaciones / plan
→ siguiente ejecución
~~~

La mejora continua depende de mantener una relación trazable entre baseline planificado y resultados reales.

## 9. Cierre técnico, costes y reporting

- Una orden puede quedar técnicamente ejecutada/cerrada mientras determinados costes llegan posteriormente.
- Tras la ejecución, el sistema debe disponer de datos suficientes para reporting periódico.
- Los informes pueden materializarse posteriormente mediante Power BI, reporting dentro del CMMS u otros canales; la reunión **no decide la tecnología final**.
- La decisión funcional confirmada es la necesidad de persistir datos fiables y suficientes para que informes, auditorías y KPIs sean reproducibles.

## 10. Decisiones confirmadas

1. La criticidad vive en el Asset Master y condiciona estrategia/frecuencia.
2. No deben materializarse todas las futuras preventivas de la vida útil.
3. El preventivo aprobado debe trabajar con **siguiente intervención / recurrencia**, generando la orden cuando corresponda.
4. Work Candidate deja de ser obligatorio para el mantenimiento preventivo recurrente aprobado.
5. La no ejecución de una preventiva debe quedar justificada.
6. El paquete de ejecución debe resolver Job Plan/procedimiento, documentación técnica y permisos.
7. Cuando se requiere parada, Operaciones debe conceder el permisivo correspondiente.
8. Un hallazgo preventivo que requiere reparación debe poder originar una orden correctiva.
9. El ejecutor registra ejecución/hallazgos y Planning asegura feedback fiable y cierre.
10. La comparación real vs planificado es necesaria para mejora continua.
11. Los datos de ejecución deben permitir KPIs y reporting fiables.

## 11. Aspectos abiertos

- Trigger exacto para generar/liberar la siguiente WO preventiva.
- Estados definitivos del lifecycle de WO.
- Reglas completas de programación, capacidad, turnos y assignment.
- Modelo definitivo de ventana de mantenimiento.
- Interfaz contractual con permisos de trabajo y Operaciones.
- Responsabilidad corporativa exacta del rol de captura/validación de feedback.
- Reglas de cierre administrativo/financiero posteriores al cierre técnico.
- Catálogo definitivo de KPIs y fórmulas.
- Umbrales para detección automática de desviaciones recurrentes.

## 12. Próximas acciones

- Revisar el modelo de Work Management eliminando Work Candidate como paso universal del preventivo.
- Sustituir la hipótesis de generación anual/materialización masiva por un modelo **rolling next-due**; el año/presupuesto puede mantenerse como contexto de forecast, no necesariamente como lote de WO.
- Definir contratos funcionales para PreventiveRecurrence, WorkOrderLifecycle, ExecutionPackage, ExecutionFeedback y PlanVsActualMetric.
- Revisar Functional Lab para representar el loop de ejecución y mejora sin convertir todavía el discovery en implementación productiva.
- Mantener costes/contratos/facturación como dominio pendiente de validación específica.
