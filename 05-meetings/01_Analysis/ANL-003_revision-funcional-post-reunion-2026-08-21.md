# ANL-003 — Revisión funcional posterior a reunión 2026-08-21

**Fecha:** 2026-08-21  
**Estado:** completed  
**Fuente:** [`../2026/2026-08-21_revision-cmms-gestion-ordenes-trabajo.md`](../2026/2026-08-21_revision-cmms-gestion-ordenes-trabajo.md)

## 1. Objetivo

Convertir los comentarios de la reunión en cambios trazables del modelo funcional y del CMMS 2.0 Functional Lab, diferenciando:

- confirmaciones de decisiones ya existentes;
- nuevo conocimiento funcional;
- hipótesis todavía no validadas;
- consecuencias para la demo;
- trabajo que debe quedar deliberadamente fuera hasta disponer de evidencia suficiente.

## 2. Resultado ejecutivo

La reunión **no obliga a rehacer el modelo AMEF + RCM**. Confirma tres decisiones ya incorporadas en v1.1:

1. riesgo/criticidad configurable;
2. RCM con autoridad humana y lógica explicable;
3. plan genérico con variantes por activo.

El avance real está en otro punto: por primera vez aparece un flujo suficientemente concreto para abrir un **discovery formal de Gestión del Trabajo**.

No debe confundirse ese descubrimiento con un modelo objetivo validado, porque el flujo descrito procede del sistema actual y la propia reunión acuerda contrastarlo mediante una demo y documentación real.

## 3. Comentario → impacto

| Comentario / evidencia | Impacto en modelo | Impacto en Functional Lab | Estado |
|---|---|---|---|
| La matriz debe aceptar la configuración del cliente/proyecto | Reafirma `RiskProfile` configurable | WS-03 debe renderizar configuración | confirmado previamente |
| El cuestionario RCM permite incorporar criterio del responsable | Reafirma separación sistema/persona | WS-04 debe hacer visible pregunta, respuesta, evidencia y decisión | confirmado previamente |
| Un activo de una familia puede necesitar tareas distintas | Refuerza `BasePlan + AssetPlanOverride` | WS-06 debe mostrar variante específica sin mutar plan base | confirmado y reforzado |
| Ejemplo de lubricación por neblina frente a convencional | Añade evidencia práctica para overrides | Buen caso pedagógico futuro para demo | evidencia nueva |
| Planner toma inspecciones próximas a vencimiento | Aparece `WorkCandidate` como concepto candidato | No implementar todavía; mostrar en handoff/discovery | `to_validate` |
| Planner propone una o varias WO | Aparece necesidad de agrupación entre candidatos y WO | Demo futura de Gestión del Trabajo | `to_validate` |
| Responsable valida o cambia fecha | Aparece decisión de scheduling trazada | Requiere futuro patrón de decisión/reprogramación | `to_validate` |
| Supervisor distribuye trabajo si existe | El routing depende de estructura organizativa | La arquitectura futura no debe hardcodear Supervisor | principio confirmado |
| Sin supervisor, llega directamente al técnico | Confirma rutas organizativas alternativas | Futuro runtime debe resolver ruta desde contexto/configuración | principio confirmado |
| Deben considerarse ventanas y tiempos | Aparece `ExecutionWindow` como concepto candidato | No inventar todavía reglas de calendario | `to_validate` |
| Próxima reunión con demo de Los Barrios | Define gate de discovery | No avanzar a simulación operacional antes de observarla | acción acordada |
| Se aportarán hojas/check sheets | Fuente para contenido de WO/procedimiento | Preparará diseño de futuros workspaces | acción acordada |
| Costes/contratos se verán con Eduardo | Mantiene frontera económica abierta | No incorporar facturación/costes como reglas validadas | pendiente deliberado |

## 4. Cambio en el modelo funcional

### 4.1. Lo que no cambia

Se mantienen las 28 etapas AMEF + RCM actuales y sus nueve workspaces.

No hay evidencia suficiente para insertar planificación, scheduling o ejecución dentro de ese journey: son un **dominio posterior**.

### 4.2. Lo que sí cambia

La extensión operacional deja de ser una lista genérica y pasa a tener un discovery propio:

- [`../../02-functional/process-model/work-management-discovery.md`](../../02-functional/process-model/work-management-discovery.md)

El modelo de frontera queda así:

```text
Engineering & Reliability
  PublishedPlanVersion
        ↓
Annual Preventive Preparation
        ↓
Work Management discovery
  WorkCandidate
  → WorkOrderProposal
  → date validation/replanning
  → organization-dependent assignment
  → execution
```

Los objetos y nombres son candidatos, no contratos de datos aprobados.

## 5. Revisión de responsabilidad persona vs sistema

La reunión aporta una corrección importante para el futuro dominio:

> La estructura de asignación depende del proyecto y no puede modelarse como una cadena fija de roles.

Por tanto, el modelo futuro debe admitir como mínimo rutas equivalentes a:

```text
Planner
→ Maintenance Responsible
→ Supervisor
→ Technician
```

Y:

```text
Planner
→ Maintenance Responsible
→ Technician
```

Esto implica separar:

- rol funcional;
- estructura organizativa del proyecto;
- ruta de aprobación/asignación;
- usuario concreto.

No se recomienda diseñar pantallas ni tablas definitivas hasta observar el proceso real y sus excepciones.

## 6. Revisión del CMMS Functional Lab

### 6.1. Scope inmediato

**No cambia.** F01 y WS-01 deben continuar según el plan actual.

La reunión tampoco justifica ampliar ahora el fixture P-101 con órdenes de trabajo simuladas. Hacerlo convertiría una referencia AS-IS en un supuesto TO-BE.

### 6.2. Cambio en el handoff de WS-08

La demo deberá poder explicar, después de publicar un plan:

```text
Published plan
→ annual preventive preparation
→ Work Management
```

Y mostrar como descubrimiento los actores identificados:

- Maintenance Planner;
- Maintenance Responsible;
- Supervisor opcional;
- Technician / Executor.

La superficie debe marcar claramente `to_validate` el workflow operacional.

### 6.3. Caso pedagógico futuro para WS-06

El ejemplo de **bomba con lubricación por neblina vs bomba con lubricación convencional** es especialmente útil para demostrar:

```text
familia común
→ plan base
→ particularidad técnica del activo
→ tarea adicional / tarea no aplicable
→ override trazado
```

Se recomienda incorporarlo cuando WS-06 llegue a diseño detallado, no ahora.

## 7. Gates nuevos

### WM-G01 — Observar el flujo real

Fuente prevista: demo de la aplicación de Los Barrios.

Debe permitir validar actores, secuencia, estados, decisiones y excepciones.

### WM-G02 — Analizar contenido operativo

Fuente prevista: hojas/check sheets de mantenimiento.

Debe permitir separar:

- definición de tarea;
- procedimiento/checklist;
- orden de trabajo;
- captura de ejecución.

### WM-G03 — Validar planning/scheduling

Solo después de WM-G01/02 se definirá:

- selección de candidatos;
- horizontes temporales;
- agrupación;
- reprogramación;
- ventanas;
- capacidad/turnos;
- asignación.

### WM-G04 — Abrir modelo económico

Requiere sesión específica con Eduardo y/o Contratos/Subcontratos antes de fijar costes, partidas o facturación.

## 8. Decisiones de no hacer

Para evitar retrabajo y falsas certezas:

- no añadir etapas WM al Functional Journey canónico todavía;
- no crear workspaces de órdenes de trabajo todavía;
- no modificar P-101 con un ciclo WO inventado;
- no hardcodear Supervisor como paso obligatorio;
- no definir un algoritmo de vencimiento/agrupación sin observar el sistema actual;
- no mezclar procedimiento/checklist con WO hasta revisar ejemplos reales;
- no avanzar en costes/facturación sin los perfiles adecuados.

## 9. Siguiente revisión recomendada

La siguiente sesión debería ser una sesión de **discovery guiado por evidencia**, no una presentación teórica:

1. abrir la aplicación actual de Los Barrios;
2. recorrer un caso real desde calendario/inspección hasta técnico;
3. registrar decisiones, estados y excepciones;
4. revisar una hoja/check sheet asociada;
5. comparar `AS-IS` con las necesidades del nuevo CMMS;
6. solo entonces actualizar el modelo objetivo y decidir si Gestión del Trabajo entra como siguiente dominio del Functional Lab.
