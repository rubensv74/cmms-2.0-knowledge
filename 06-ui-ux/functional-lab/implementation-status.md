# Functional Lab — Implementation Status

**Fecha:** 2026-08-10  
**Estado general:** F01 — Power Apps Premium Foundation  
**Último gate superado:** `F01-00A-R4 navegación visual sin eventos` — INSTANCE_SAFE PASS  
**Gate actual:** `F01-00A-R5-T Text custom input` — PENDING STUDIO VALIDATION

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
| F01-00 Auditoría Power Apps Foundation | partial | App creada y diagnóstico real de seguridad de instancia en curso. |
| F01-00A cmp_FL_SidebarPro | review-required | La versión completa inicial cerraba Studio al insertar instancia; FL-SC-001 abierto. |
| F01-00A-R1 root-only diagnostic | validated-pass | CanvasComponent + root GroupContainer ManualLayout instance-safe. |
| F01-00A-R2 identity/text diagnostic | validated-pass | ModernText estático instance-safe. |
| F01-00A-R3 static-containers diagnostic | validated-pass | AutoLayout + contenedores anidados estáticos instance-safe. |
| F01-00A-R4 static-navigation diagnostic | validated-pass | Rectangle + Icon + Label + Button estáticos, sin eventos, instance-safe. |
| F01-00A-R5 simple-custom-inputs diagnostic | failed-instance | Text + Boolean + Color custom inputs reproducen el cierre al insertar instancia. |
| F01-00A-R5-T Text-input diagnostic | pending-user-validation | Aísla una única CustomProperty Input/Text consumida por el título. |
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

```text
R1 root-only: PASS
R2 identity/text: PASS
R3 static containers: PASS
R4 static navigation controls: PASS
R5 Text+Boolean+Color custom inputs: FAIL — Studio closes
R5-T Text input only: PENDING
```

Interpretación vigente:

- la superficie problemática está dentro del delta introducido en R5;
- no está demostrado qué tipo de propiedad es responsable;
- tampoco está demostrado si el problema está en declarar la propiedad o en consumirla;
- `Table`, `Gallery`, `Output` y `Event` aún no forman parte de la reproducción reducida.

## 3. Estrategia de corrección

Se vuelve al baseline R4, último estado `INSTANCE_SAFE`, y R5 se subdivide por tipo:

```text
R5-T Text only          CURRENT
R5-B Boolean only       después, si es necesario
R5-C Color only         después, si es necesario
```

Si R5-T falla, la siguiente reducción separará **declaración** de la propiedad `Text` frente a **consumo** de esa propiedad.

No se avanza a R6 mientras esta superficie no quede delimitada.

## 4. Arquitectura de interfaz de WS-01

```text
PRIMARY_USER_TASK: comprender y confirmar el caso y su contexto operacional
SUCCESS_CRITERION: el contexto queda suficientemente completo y confirmado para formular funciones y fallos
PRIMARY_ARCHETYPE: Object 360
SECONDARY_PATTERNS: contextual inspector, status/gate panel, help modal, dirty guard
```

## 5. Componentes premium fundacionales

```text
F01-00A  cmp_FL_SidebarPro        ← FL-SC-001 / diagnostic reconstruction
F01-00B  cmp_FL_PageHeaderPro     ← BLOCKED
F01-01   Premium App Shell        ← BLOCKED
```

## 6. Regla de continuidad

> No se prepara F01-00B ni ningún bloque dependiente hasta que `cmp_FL_SidebarPro` completo alcance `INSTANCE_SAFE`.
