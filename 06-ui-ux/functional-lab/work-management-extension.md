# CMMS 2.0 Functional Lab — Extensión futura de Gestión del Trabajo

**Fecha de revisión:** 2026-08-21  
**Estado:** discovery / `to_validate`  
**Fuente:** [`../../05-meetings/2026/2026-08-21_revision-cmms-gestion-ordenes-trabajo.md`](../../05-meetings/2026/2026-08-21_revision-cmms-gestion-ordenes-trabajo.md)  
**Modelo de discovery:** [`../../02-functional/process-model/work-management-discovery.md`](../../02-functional/process-model/work-management-discovery.md)

## 1. Decisión de alcance

La reunión aporta suficiente conocimiento para **revisar la demo**, pero no para construir todavía un workspace operativo de órdenes de trabajo.

Por tanto:

- F01 y WS-01 no cambian;
- se mantienen los nueve workspaces AMEF + RCM actuales;
- no se añade una simulación WO al fixture P-101;
- se amplía conceptualmente el handoff posterior a WS-08;
- el futuro dominio de Gestión del Trabajo queda sujeto a gates específicos.

## 2. Handoff que debe poder explicar la demo

Después de publicar el plan, el Functional Lab debe poder mostrar conceptualmente:

```text
PublishedPlanVersion
→ Annual Preventive Preparation
→ Work Management
```

En la superficie de handoff puede mostrarse un resumen del discovery:

```text
Preventive schedule
→ Work Candidate
→ Planner proposal
→ Maintenance Responsible validation / replanning
→ optional Supervisor
→ Technician / Executor
```

Todo el tramo posterior a `Annual Preventive Preparation` debe llevar una indicación visible equivalente a:

> Discovery funcional — pendiente de validación con proceso real.

## 3. Qué no debe simular la demo todavía

No debe presentar como regla aprobada:

- número de días para considerar una inspección próxima;
- algoritmo de agrupación en órdenes;
- autorización exacta para reprogramar;
- Supervisor como paso obligatorio;
- asignación automática por capacidad o turno;
- estados completos de WO;
- checklists/procedimientos definitivos;
- captura de ejecución;
- costes/facturación.

## 4. Impacto futuro en arquitectura

Cuando Gestión del Trabajo entre realmente en el Functional Lab, el runtime deberá soportar una **ruta organizativa configurable**.

No debe asumirse:

```text
Planner → Responsible → Supervisor → Technician
```

como ruta universal.

Debe poder representar, al menos conceptualmente:

```text
OrganizationContext
+ RoleRoutingRules
→ AssignmentRoute
```

Ejemplos:

```text
Planner → Responsible → Supervisor → Technician
```

```text
Planner → Responsible → Technician
```

La organización concreta del proyecto decide la ruta; la UI no debe codificarla de manera rígida.

## 5. Ejemplo pedagógico que conviene conservar

Para el futuro WS-06, la reunión aporta un caso especialmente útil:

```text
Familia: bombas centrífugas
→ BasePlan común
→ activo A: lubricación convencional
→ activo B: lubricación por neblina
→ activo B necesita actividad adicional
→ AssetPlanOverride trazado
```

Este ejemplo debe guardarse para demostrar que una particularidad del activo no obliga a duplicar o modificar el plan común de toda la familia.

## 6. Gate antes de diseñar la extensión

No debe iniciarse diseño detallado de Work Management hasta completar:

1. demo del proceso actual de Los Barrios;
2. revisión de hojas/check sheets reales;
3. identificación de actores, estados, decisiones y excepciones;
4. separación clara entre comportamiento AS-IS y requisito TO-BE;
5. validación de planning/scheduling suficiente para crear contratos funcionales.

## 7. Resultado de la revisión

La demo actual debe **anticipar la existencia del siguiente proceso**, pero no fingir que ya conocemos su diseño.

Ese equilibrio permite que las reuniones sigan descubriendo el modelo sin cerrar prematuramente una arquitectura que todavía no está validada.
