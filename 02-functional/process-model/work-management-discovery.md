# Gestión del Trabajo — Discovery funcional preliminar

**Versión:** discovery v0.2  
**Última revisión:** 2026-09-11  
**Estado:** `to_validate`  
**Fuentes principales:**  
- [`../../05-meetings/2026/2026-08-21_revision-cmms-gestion-ordenes-trabajo.md`](../../05-meetings/2026/2026-08-21_revision-cmms-gestion-ordenes-trabajo.md)  
- [`../../05-meetings/2026/2026-09-11_revision-cmms-estandares-job-plans.md`](../../05-meetings/2026/2026-09-11_revision-cmms-estandares-job-plans.md)

## 1. Propósito

Registrar el modelo funcional descubierto para **Gestión del Trabajo** sin confundir referencias AS-IS con diseño objetivo de CMMS 2.0.

Distingue:

- **AS-IS de referencia**;
- **principios confirmados**;
- **hipótesis TO-BE**;
- **pendientes de validación**.

## 2. Frontera de entrada

El dominio comienza después de disponer de un plan de mantenimiento de proyecto publicado y su calendario preventivo.

```text
Published Project Maintenance Plan
→ Scheduled Maintenance Activity
→ Work Candidate
→ Work Order Proposal
→ Work Order
```

La revisión 2026-09-11 añade una regla importante: la unidad que llega a Work Management es una **Maintenance Activity gestionable**, no cada paso del procedure/checklist.

## 3. Contrato conceptual upstream descubierto

```text
Maintenance Activity
├── frequency / schedule basis
├── asset / scope
├── estimated resources
├── Job Plan reference
└── Procedure / Checklist reference
```

La orden puede utilizar el Job Plan/checklist durante la ejecución, pero no debe multiplicar automáticamente cada subpaso en tareas planificables independientes.

## 4. AS-IS de referencia observado 2026-08-21

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

### 4.1. Maintenance Planner

Responsabilidad observada:

- consultar calendario;
- identificar trabajo próximo;
- seleccionar candidatos;
- proponer conversión/agrupación en WO.

Pendiente:

- definición de `próximo`;
- prioridad/backlog;
- reglas de agrupación;
- duplicados/compromisos existentes.

### 4.2. Responsable de mantenimiento

Responsabilidad observada:

- revisar propuesta;
- validar fecha;
- o proponer fecha alternativa.

Pendiente:

- autoridad exacta;
- motivos de reprogramación;
- límites temporales;
- impacto de criticidad/ventanas/permisos.

### 4.3. Supervisor / mando intermedio

Nivel condicional según organización del proyecto.

Principio confirmado:

> El workflow de asignación no debe asumir una jerarquía fija.

### 4.4. Técnico / ejecutor

La reunión 2026-08-21 solo confirmó recepción/ejecución.

La reunión 2026-09-11 aporta una pieza adicional: durante la ejecución debe estar disponible un Job Plan/procedure/checklist detallado, pero su granularidad no debe trasladarse automáticamente al calendario o a la WO como decenas de actividades independientes.

Todavía no está validado:

- aceptación/rechazo;
- inicio/pausa/finalización;
- mediciones;
- evidencias/fotos;
- uso/consumo de materiales;
- horas reales;
- desviaciones;
- cierre técnico.

## 5. Hipótesis TO-BE

### WM-H01 — Work Candidate

Representación intermedia entre calendario y WO.

### WM-H02 — Regla de selección temporal

Ventana configurable para identificar trabajo próximo; regla exacta pendiente.

### WM-H03 — Propuesta de agrupación

Sistema puede sugerir; autoridad final y reglas pendientes.

### WM-H04 — Validación / reprogramación

Confirmación o reprogramación trazada.

### WM-H05 — Routing organizativo configurable

Debe admitir distintas estructuras sin hardcodear Supervisor.

### WM-H06 — Ventana de ejecución

Separar ventana/restricciones de una única fecha nominal.

### WM-H07 — Asignación por capacidad/turno

Probable necesidad; regla pendiente.

### WM-H08 — Execution Package

Una WO debe poder resolver el paquete de ejecución:

```text
WorkOrder
+ JobPlan
+ ProcedureChecklist
+ ResourceRequirements
+ safety / permits
= Execution Package
```

Estado: `to_validate`.

## 6. Objetos conceptuales candidatos

```text
PreventiveScheduleItem
ScheduledMaintenanceActivity
WorkCandidate
WorkOrderProposal
WorkOrder
ExecutionWindow
ScheduleDecision
AssignmentRoute
WorkAssignment
OrganizationContext
ExecutionPackage
JobPlanReference
ProcedureChecklistReference
```

No constituyen esquema aprobado.

## 7. Decisiones persona vs sistema — preliminar

| Paso | Sistema | Persona | Estado |
|---|---|---|---|
| Detectar trabajo próximo | Puede calcular candidatos | Planner revisa/selecciona | `to_validate` |
| Proponer agrupación | Puede sugerir | Planner/responsable confirma | `to_validate` |
| Validar fecha | Muestra restricciones | Responsable decide | evidenciado; reglas abiertas |
| Reprogramar | Valida consistencia | Responsable decide/justifica | `to_validate` |
| Elegir ruta organizativa | Resuelve configuración | Proyecto/organización define | principio confirmado |
| Asignar técnico/turno | Puede asistir | Supervisor/rol decide | `to_validate` |
| Resolver Execution Package | Puede ensamblar referencias | Responsable valida cuando aplique | `to_validate` |
| Ejecutar checklist | Registra datos/estado | Técnico ejecuta | `to_validate` |

## 8. Evidencia 2026-09-11 y WM-G02

Durante la reunión se revisaron ejemplos de documentación histórica con:

- frecuencia;
- Job Plan;
- operations/checklist;
- recursos/disciplinas;
- herramientas;
- referencia a reporte en CMMS.

Esto **avanza WM-G02**, porque confirma la necesidad de separar:

```text
actividad CMMS
≠
lista detallada de pasos
```

Pero WM-G02 no se considera `PASS` todavía.

Falta:

1. incorporar/registrar las fuentes documentales concretas;
2. normalizar al menos un ejemplo real;
3. cerrar el contrato `Activity ↔ JobPlan ↔ ProcedureChecklist ↔ Execution Result`.

## 9. Gates

### WM-G01 — Flujo AS-IS observado

Validar mediante demo real actores, secuencia, estados, decisiones y excepciones.

### WM-G02 — Contenido de la orden / execution package

Revisar y normalizar fuentes para definir:

- cabecera;
- actividad;
- Job Plan;
- procedure/checklist;
- recursos;
- criterios;
- ventanas;
- evidencias;
- feedback/cierre.

### WM-G03 — Planning/Scheduling

Definir:

- horizonte;
- prioridades;
- agrupación;
- capacidad;
- turnos;
- reprogramación;
- restricciones.

### WM-G04 — Costes y contratos

No avanzar en imputación/facturación sin perfiles responsables.

## 10. Relación con Maintenance Standards Library

Gestión del Trabajo consume planes de proyecto publicados, independientemente de si su origen fue RCM o estándar corporativo.

```text
RCM / Corporate Standard / OEM / Expert
→ Published Project Maintenance Plan
→ Scheduled Maintenance Activity
→ Work Management
```

Work Management no necesita volver a ejecutar el razonamiento de ingeniería; necesita conservar trazabilidad y acceso al paquete de ejecución.

## 11. Impacto sobre Functional Lab

La demo actual sigue terminando con handoff conceptual después de WS-08.

No deben simularse todavía como aprobadas reglas de:

- vencimiento;
- agrupación;
- scheduling;
- capacidad/turnos;
- estados de WO;
- ejecución;
- costes.

Sí puede representarse conceptualmente que una futura WO referencia una actividad resumida y su Job Plan/checklist asociado.
