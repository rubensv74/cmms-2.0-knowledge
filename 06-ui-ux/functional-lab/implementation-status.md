# Functional Lab — Implementation Status

**Fecha:** 2026-08-10  
**Estado general:** F01 — Power Apps Premium Foundation  
**Último gate superado:** `cmp_FL_SidebarPro` definition accepted  
**Gate actual:** `INSTANCE_SAFE` — FAILED / diagnostic reduction in progress

## 1. Estado de incrementos

| Incremento | Estado | Resultado |
|---|---|---|
| F00-01 Auditoría de transición | completed | Riesgos, fuentes y orden de trabajo identificados. |
| F00-02 Protocolo incremental CMMS | completed | Adaptación del protocolo de Pulse con gate funcional previo. |
| F00-03 Visión del Functional Lab | completed | Propósito y frontera definidos. |
| F00-04 Functional Journey | completed | 28 etapas y 9 workspaces iniciales formalizados. |
| F00-05 Persona vs sistema | completed | Matriz preliminar de responsabilidades creada. |
| F00-06 Contratos JSON | completed | Schemas base de journey y fixture creados. |
| F00-07 Fixture P-101 | completed | Caso existente convertido a JSON canónico. |
| F00-08 Arquitectura del Lab | completed | Capas, estado, workspaces y límites definidos. |
| F00-09 Paquete documental IT | completed | Estructura modular de handoff definida. |
| F01-00 Auditoría Power Apps Foundation | partial | App creada y definición de primer componente aceptada; gate de instancia ha detectado incidente bloqueante. |
| F01-00A cmp_FL_SidebarPro | failed-instance / correcting | Source Code aceptado; Studio se cierra al insertar instancia. FL-SC-001 abierto. |
| F01-00A-R1 root-only diagnostic | pending-user-validation | Reducir el componente al mínimo para delimitar la causa. |
| F01-00B cmp_FL_PageHeaderPro | blocked-by-FL-SC-001 | No se prepara hasta resolver seguridad de instancia del Sidebar. |
| F01-01 Premium App Shell Foundation | blocked-by-components | Depende de componentes fundacionales `INSTANCE_SAFE`. |
| F01-02 Runtime state mínimo | planned | Estado local del laboratorio. |
| F01-03 Adaptador P-101 | planned | JSON → colecciones Power Fx. |
| F01-04 Navegación base | planned | Navegación entre workspaces sin lógica funcional avanzada. |
| F01-05 WS-01 Contexto visual premium | planned | Mostrar caso y datos existentes. |
| F01-06 WS-01 Edición | planned | Inputs humanos del contexto. |
| F01-07 WS-01 Gate evidencia | planned | Preparación de datos y explicación del bloqueo. |
| F01-08 WS-01 Output | planned | Salida estructurada hacia WS-02. |
| F01-09 Hardening / Visual QA WS-01 | planned | Empty/error/dirty/accessibility/calidad visual y documentación. |

## 2. Incidente actual — FL-SC-001

Observación confirmada en `CMMS 2.0 Functional Lab`:

```text
F01-00A source pasted / definition created: PASS
Save / no immediate Source Code error: PASS
Insert component instance: Studio closes
INSTANCE_SAFE: FAIL
READY_FOR_INTEGRATION: NO
```

Registro:

```text
development/incidents/FL-SC-001-component-instance-crash.md
```

La causa técnica se mantiene como `UNKNOWN` hasta obtener un reproducer reducido.

## 3. Estrategia de corrección

No se modifica varias veces el componente completo por intuición.

La reconstrucción seguirá:

```text
R1 root only
→ R2 identidad/texto
→ R3 contenedores estáticos
→ R4 navegación visual sin eventos
→ R5 custom inputs simples
→ R6 Gallery + Table
→ R7 Output/Event
→ R8 geometría completa
```

Solo el primer estadio que reproduce el cierre se considera evidencia útil para aislar la causa.

## 4. Arquitectura de interfaz de WS-01

Declaración inicial:

```text
PRIMARY_USER_TASK: comprender y confirmar el caso y su contexto operacional
SUCCESS_CRITERION: el contexto queda suficientemente completo y confirmado para formular funciones y fallos
PRIMARY_ARCHETYPE: Object 360
SECONDARY_PATTERNS: contextual inspector, status/gate panel, help modal, dirty guard
```

Esta selección se considera hipótesis de interfaz validable durante el vertical slice.

## 5. Componentes premium fundacionales

Secuencia obligatoria, actualmente detenida:

```text
F01-00A  cmp_FL_SidebarPro        ← FL-SC-001 / correcting
F01-00B  cmp_FL_PageHeaderPro     ← BLOCKED
F01-01   Premium App Shell        ← BLOCKED
```

## 6. Gate funcional de WS-01

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

## 7. Archivos F01 actuales

- `development/f01-00-power-apps-foundation-audit.md`
- `development/compatibility.md`
- `development/incidents/FL-SC-001-component-instance-crash.md`
- `power-apps/components/cmp_FL_SidebarPro.md`
- `power-apps/components/cmp_FL_SidebarPro.pa.yaml`

## 8. Regla de continuidad

> No se prepara F01-00B ni ningún bloque dependiente hasta que `cmp_FL_SidebarPro` alcance `INSTANCE_SAFE` o se tome una decisión explícita de arquitectura que cambie la estrategia de componentes.
