# Gestión del Trabajo — Discovery funcional preliminar

**Versión:** discovery v0.1  
**Fecha:** 2026-08-21  
**Estado:** `to_validate`  
**Fuente principal:** [`../../05-meetings/2026/2026-08-21_revision-cmms-gestion-ordenes-trabajo.md`](../../05-meetings/2026/2026-08-21_revision-cmms-gestion-ordenes-trabajo.md)

## 1. Propósito

Registrar el primer modelo funcional descubierto para el dominio de **Gestión del Trabajo** sin confundir el funcionamiento observado en el sistema actual con el diseño objetivo de CMMS 2.0.

Este documento distingue explícitamente:

- **AS-IS de referencia:** comportamiento descrito durante la reunión a partir de la aplicación/proceso actual;
- **hipótesis TO-BE:** capacidades que parecen necesarias para el nuevo CMMS;
- **pendientes de validación:** reglas que todavía no deben convertirse en requisitos definitivos ni automatismos.

## 2. Frontera de entrada

El dominio comienza después de disponer de un plan de mantenimiento publicado y de su calendario preventivo.

La revisión anterior ya había identificado:

```text
Plan publicado vigente
→ seleccionar ejercicio / contexto presupuestario
→ generar/preparar preventivas del año
```

La reunión del 2026-08-21 aporta por primera vez detalle sobre el proceso posterior.

## 3. AS-IS de referencia observado

```text
Plan / calendario preventivo
→ inspecciones próximas a vencimiento
→ selección por Maintenance Planner
→ propuesta de una o varias órdenes de trabajo
→ validación / posible cambio de fecha por Maintenance Responsible
→ [si existe Supervisor] distribución por técnico y turno
→ [si no existe Supervisor] asignación directa a técnico/ejecutor
→ ejecución dentro de ventanas y restricciones
```

### 3.1. Maintenance Planner

Responsabilidad observada:

- consultar el calendario;
- identificar inspecciones próximas a vencimiento;
- seleccionar trabajo candidato;
- proponer su conversión/agrupación en una o varias órdenes de trabajo.

Reglas pendientes:

- qué significa exactamente `próximo a vencimiento`;
- si existe prioridad, criticidad o backlog adicional;
- reglas de agrupación;
- tratamiento de trabajo ya propuesto o comprometido.

### 3.2. Responsable de mantenimiento

Responsabilidad observada:

- revisar la propuesta;
- validar la fecha prevista;
- o proponer una fecha alternativa.

Reglas pendientes:

- autoridad exacta;
- motivos obligatorios para reprogramación;
- límites de cambio de fecha;
- impacto sobre SLA, criticidad, permisos o ventanas operativas.

### 3.3. Supervisor / mando intermedio

Este nivel es **condicional** y depende de la estructura organizativa del proyecto.

Cuando existe:

- recibe el trabajo aprobado;
- distribuye carga entre técnicos;
- considera turno/capacidad/organización local.

Cuando no existe:

- el trabajo puede pasar directamente al técnico/ejecutor.

**Principio derivado:** el workflow de asignación no debe asumir una jerarquía organizativa fija.

### 3.4. Técnico / ejecutor

La reunión solo confirma que recibe la orden asignada para ejecución.

Todavía no está validado:

- aceptación/rechazo;
- inicio/pausa/finalización;
- captura de mediciones;
- checklist/procedimiento;
- evidencias/fotos;
- materiales;
- horas reales;
- desviaciones;
- cierre técnico.

## 4. Hipótesis TO-BE derivadas

Las siguientes capacidades parecen necesarias, pero permanecen `to_validate`:

### WM-H01 — Work Candidate

Debe existir una representación intermedia entre calendario preventivo y orden de trabajo que permita seleccionar trabajo próximo y decidir si se agrupa o programa.

### WM-H02 — Regla de selección temporal

El sistema debería poder identificar trabajo próximo a vencimiento utilizando una ventana configurable, pero la regla exacta todavía no está definida.

### WM-H03 — Propuesta de agrupación

El sistema puede ayudar a agrupar candidatos compatibles, pero la autoridad final y las reglas exactas deben validarse.

### WM-H04 — Validación / reprogramación

Una propuesta debería admitir confirmación de fecha o reprogramación trazada, conservando quién decidió, cuándo y por qué.

### WM-H05 — Routing organizativo configurable

El flujo debe adaptarse a estructuras como:

```text
Planner → Maintenance Responsible → Supervisor → Technician
```

o:

```text
Planner → Maintenance Responsible → Technician
```

sin codificar una única estructura obligatoria.

### WM-H06 — Ventana de ejecución

La orden debe poder conservar una ventana o restricciones de ejecución separadas de una única fecha nominal.

### WM-H07 — Asignación por capacidad/turno

La asignación futura probablemente necesitará considerar turno, disponibilidad y carga, pero todavía no existe regla validada.

## 5. Objetos conceptuales candidatos

No constituyen todavía modelo de datos aprobado.

```text
PreventiveScheduleItem
WorkCandidate
WorkOrderProposal
WorkOrder
ExecutionWindow
ScheduleDecision
AssignmentRoute
WorkAssignment
OrganizationContext
```

Relaciones preliminares:

```text
PreventiveScheduleItem
→ WorkCandidate
→ WorkOrderProposal
→ WorkOrder

WorkOrder
+ OrganizationContext
→ AssignmentRoute
→ WorkAssignment
```

## 6. Decisiones persona vs sistema — preliminar

| Paso | Sistema | Persona | Estado |
|---|---|---|---|
| Detectar trabajo próximo | Puede calcular candidatos | Planner revisa/selecciona | `to_validate` |
| Proponer agrupación | Puede sugerir | Planner / responsable confirma | `to_validate` |
| Validar fecha | Muestra restricciones | Responsable decide | evidenciado, reglas abiertas |
| Reprogramar | Valida consistencia | Responsable decide y justifica | `to_validate` |
| Elegir ruta organizativa | Puede resolver desde configuración | Organización/proyecto define | principio confirmado |
| Asignar técnico/turno | Puede asistir | Supervisor o rol equivalente decide | `to_validate` |
| Ejecutar | Registra estado/datos | Técnico ejecuta | `to_validate` |

## 7. Material necesario para siguiente validación

La reunión acuerda utilizar dos tipos de evidencia:

1. **demo de la aplicación actual de Los Barrios**, para observar el flujo real de planificación, validación, asignación y ejecución;
2. **hojas/check sheets de mantenimiento**, para estudiar el contenido operativo de las tareas y su relación con procedimientos/órdenes.

Estas fuentes deben utilizarse para descubrir necesidades, no para copiar automáticamente el diseño existente.

## 8. Gates antes de convertir este discovery en modelo canónico

### Gate WM-G01 — Flujo AS-IS observado

Validar mediante demo real:

- actores;
- secuencia;
- estados;
- decisiones;
- excepciones;
- datos que se muestran o capturan.

### Gate WM-G02 — Contenido de la orden

Revisar check sheets y ejemplos reales para definir:

- cabecera;
- tareas;
- procedimiento/checklist;
- criterios de aceptación;
- recursos;
- ventanas;
- evidencias;
- feedback/cierre.

### Gate WM-G03 — Reglas de planning/scheduling

Definir con perfiles adecuados:

- horizonte de selección;
- prioridades;
- agrupación;
- capacidad;
- turnos;
- reprogramación;
- restricciones operativas.

### Gate WM-G04 — Costes y contratos

No avanzar en imputación económica/facturación hasta revisar el dominio con Eduardo y/o Contratos/Subcontratos.

## 9. Impacto sobre CMMS Functional Lab

Este discovery **no crea todavía nuevos workspaces productivos ni amplía el scope inmediato de F01**.

Sí cambia la forma en la que debe mostrarse el handoff después de `WS-08 Revisión y publicación`:

```text
PublishedPlanVersion
→ Annual Preventive Preparation
→ Work Management (discovery / to_validate)
```

La demo puede mostrar una tarjeta o vista conceptual del siguiente proceso y sus actores, claramente marcada como `to_validate`, pero no debe simular reglas de planning/scheduling como si estuvieran aprobadas.

## 10. Relación con el modelo AMEF + RCM

El discovery no altera las 28 etapas canónicas actuales.

Su función es preparar el **siguiente dominio funcional** y definir qué outputs de Ingeniería de Mantenimiento deben llegar a Gestión del Trabajo de forma estructurada.
