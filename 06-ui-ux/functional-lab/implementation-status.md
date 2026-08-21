# Functional Lab — Implementation Status

**Fecha:** 2026-08-21  
**Estado general:** F01 — Power Apps Foundation, con revisión funcional v1.1 y discovery de Gestión del Trabajo incorporado  
**Último gate documental superado:** revisión funcional posterior a reunión 2026-08-21  
**Validación Power Apps:** pendiente de app baseline real

## 1. Estado de incrementos

| Incremento | Estado | Resultado |
|---|---|---|
| F00-01 Auditoría de transición | completed | Riesgos, fuentes y orden de trabajo identificados. |
| F00-02 Protocolo incremental CMMS | completed | Adaptación del protocolo de Pulse con gate funcional previo. |
| F00-03 Visión del Functional Lab | completed | Propósito y frontera definidos. |
| F00-04 Functional Journey | completed-revised | 28 etapas y 9 workspaces AMEF + RCM formalizados. |
| F00-05 Persona vs sistema | completed-revised | Responsabilidades revisadas para riesgo configurable, RCM y aplicabilidad. |
| F00-06 Contratos JSON | completed | Schemas base de journey y fixture creados. |
| F00-07 Fixture P-101 | completed-revised | Fixture v1.1 alineado con la revisión AMEF + RCM. |
| F00-08 Arquitectura del Lab | completed-revised | Foundation preparada para configuración, aplicabilidad, overrides y handoff. |
| F00-09 Paquete documental IT | completed | Estructura modular de handoff definida. |
| F00-10 Revisión reunión 2026-08-14 | completed | Riesgo configurable, RCM, overrides y handoff anual consolidados. |
| F00-11 Revisión reunión 2026-08-21 | completed | Discovery formal de Gestión del Trabajo y revisión del handoff de la demo. |
| F01-00 Auditoría Power Apps Foundation | partial | Auditoría estática y compatibilidad completadas; falta app real y Studio. |
| F01-01 Shell de pantalla | blocked-by-runtime-baseline | Primer bloque técnico. |
| F01-02 Runtime state mínimo | planned | Estado local; no debe hardcodear riesgo, RCM, plan 1:1 por activo ni rutas organizativas futuras. |
| F01-03 Adaptador P-101 | planned | JSON v1.1 → colecciones Power Fx. |
| F01-04 Navegación base | planned | Navegación entre workspaces sin lógica funcional avanzada. |
| F01-05 WS-01 Contexto visual | planned | Mostrar caso y datos existentes. |
| F01-06 WS-01 Edición | planned | Inputs humanos del contexto. |
| F01-07 WS-01 Gate evidencia | planned | Preparación de datos y explicación del bloqueo. |
| F01-08 WS-01 Output | planned | Salida estructurada hacia WS-02. |
| F01-09 Hardening WS-01 | planned | Empty/error/dirty/accessibility y documentación. |

## 2. Resultado de la revisión 2026-08-21

La reunión no cambia el scope inmediato de F01 ni las 28 etapas AMEF + RCM.

Confirma de nuevo:

- **riesgo configurable** por cliente/proyecto;
- **RCM explicable y con autoridad humana**;
- **plan genérico + overrides por activo**;
- necesidad de evitar estructuras rígidas cuando el comportamiento depende del proyecto.

El avance real es la apertura de un nuevo documento de modelo:

- [`../../02-functional/process-model/work-management-discovery.md`](../../02-functional/process-model/work-management-discovery.md)

Y una revisión específica de la demo:

- [`work-management-extension.md`](work-management-extension.md)

## 3. Nuevo discovery — Gestión del Trabajo

El flujo explicado durante la reunión se registra como referencia AS-IS:

```text
Plan / calendario preventivo
→ inspecciones próximas
→ selección/propuesta del Maintenance Planner
→ validación o reprogramación por Maintenance Responsible
→ Supervisor opcional según organización
→ Technician / Executor
→ ejecución
```

Estado: `to_validate`.

No se interpreta como diseño objetivo porque todavía debe contrastarse mediante la demo y documentación real de Los Barrios.

### Principio confirmado para arquitectura futura

La ruta de asignación depende de la estructura organizativa del proyecto.

Por tanto, no debe hardcodearse:

```text
Planner → Responsible → Supervisor → Technician
```

como flujo universal.

Debe poder existir también, por ejemplo:

```text
Planner → Responsible → Technician
```

## 4. Impacto sobre la demo actual

WS-08 debe seguir terminando en un handoff conceptual.

La explicación futura puede ampliarse a:

```text
PublishedPlanVersion
→ Annual Preventive Preparation
→ Work Management (discovery / to_validate)
```

La demo puede mostrar los actores y el flujo descubierto, pero no debe simular como aprobadas reglas de:

- vencimiento;
- agrupación;
- scheduling;
- capacidad/turnos;
- estados de WO;
- ejecución;
- costes.

### P-101

El fixture P-101 **no se amplía todavía con órdenes de trabajo simuladas**.

Motivo: el flujo operativo procede de una referencia AS-IS y aún no ha superado los gates de discovery necesarios para convertirse en modelo objetivo.

## 5. Gate funcional de WS-01

### Inputs existentes

- código y nombre de activo;
- planta/unidad;
- servicio;
- frontera;
- demanda y presión;
- modos operativos;
- redundancia;
- restricciones;
- fuentes de evidencia.

### Inputs humanos

- correcciones del contexto;
- confirmación de evidencia;
- nivel de confianza.

### Cálculos / validaciones

- número de fuentes disponibles;
- consistencia mínima del contexto;
- estado del gate de preparación.

### Decisión humana

- confirmar que el contexto representa el caso que debe analizarse.

### Gate

- bloquear el avance cuando falte información crítica;
- explicar qué falta;
- distinguir reglas validadas de reglas de demostración.

### Output

Objeto de contexto funcional listo para alimentar funciones y fallos.

## 6. Gates antes de workspaces posteriores

### Antes de WS-03 — Efectos y riesgo

Debe existir un contrato mínimo de `RiskProfile`.

### Antes de WS-04 — Decisión RCM

Debe existir un contrato de árbol/preguntas RCM sin scoring.

### Antes de WS-06 — Recursos y alcance

Debe existir un contrato mínimo para:

- `BasePlan`;
- `CandidateAssets`;
- `ApplicabilityDecision`;
- `AssetPlanOverride`;
- agrupación de actividades.

El ejemplo de bomba con lubricación convencional frente a lubricación por neblina queda reservado como caso pedagógico útil para este workspace.

### Antes de cerrar WS-08 — Revisión y publicación

Debe existir un output de publicación preparado para mostrar el handoff conceptual hacia preparación anual y el siguiente dominio.

## 7. Gates antes de una futura extensión Work Management

### WM-G01 — Observar flujo real

Revisar la aplicación actual de Los Barrios y registrar actores, estados, decisiones y excepciones.

### WM-G02 — Analizar check sheets

Revisar ejemplos reales para separar tarea, procedimiento/checklist, orden y feedback de ejecución.

### WM-G03 — Validar planning/scheduling

Definir selección de candidatos, agrupación, ventanas, reprogramación, capacidad, turnos y asignación.

### WM-G04 — Costes y contratos

No definir imputación económica/facturación hasta trabajar con Eduardo y/o Contratos/Subcontratos.

## 8. Próxima acción técnica

La revisión del 2026-08-21 **no bloquea WS-01**.

La siguiente acción técnica sigue siendo disponer de una Canvas app baseline real para completar F01-00 y continuar con F01-01.

Una vez iniciado F01:

> No se prepara el siguiente bloque técnico hasta que el anterior quede integrado y validado en Power Apps Studio o exista una corrección explícita en curso.

Y:

> No se implementa como regla productiva un comportamiento que en documentación siga marcado como discovery o `to_validate`.
