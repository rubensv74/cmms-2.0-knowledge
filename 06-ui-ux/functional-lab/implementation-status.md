# Functional Lab — Implementation Status

**Fecha:** 2026-08-14  
**Estado general:** F01 — Power Apps Foundation, con revisión funcional v1.1 incorporada  
**Último gate superado:** revisión funcional posterior a reunión 2026-08-14 + auditoría estática F01-00  
**Validación Power Apps:** pendiente de app baseline real

## 1. Estado de incrementos

| Incremento | Estado | Resultado |
|---|---|---|
| F00-01 Auditoría de transición | completed | Riesgos, fuentes y orden de trabajo identificados. |
| F00-02 Protocolo incremental CMMS | completed | Adaptación del protocolo de Pulse con gate funcional previo. |
| F00-03 Visión del Functional Lab | completed | Propósito y frontera definidos. |
| F00-04 Functional Journey | completed-revised | 28 etapas y 9 workspaces formalizados; v1.1 incorpora revisión 2026-08-14. |
| F00-05 Persona vs sistema | completed-revised | Responsabilidades revisadas para riesgo configurable, RCM y aplicabilidad. |
| F00-06 Contratos JSON | completed | Schemas base de journey y fixture creados. |
| F00-07 Fixture P-101 | completed-revised | Fixture v1.1 alineado con la revisión funcional. |
| F00-08 Arquitectura del Lab | completed-revised | Foundation preparada para configuración, aplicabilidad, overrides y handoff. |
| F00-09 Paquete documental IT | completed | Estructura modular de handoff definida. |
| F00-10 Revisión reunión 2026-08-14 | completed | Impacto sobre modelo y demo documentado en ANL-002. |
| F01-00 Auditoría Power Apps Foundation | partial | Auditoría estática y compatibilidad completadas; falta app real y Studio. |
| F01-01 Shell de pantalla | blocked-by-runtime-baseline | Primer bloque técnico. |
| F01-02 Runtime state mínimo | planned | Estado local del laboratorio; no debe hardcodear riesgo, RCM ni plan 1:1 por activo. |
| F01-03 Adaptador P-101 | planned | JSON v1.1 → colecciones Power Fx. |
| F01-04 Navegación base | planned | Navegación entre workspaces sin lógica funcional avanzada. |
| F01-05 WS-01 Contexto visual | planned | Mostrar caso y datos existentes. |
| F01-06 WS-01 Edición | planned | Inputs humanos del contexto. |
| F01-07 WS-01 Gate evidencia | planned | Preparación de datos y explicación del bloqueo. |
| F01-08 WS-01 Output | planned | Salida estructurada hacia WS-02. |
| F01-09 Hardening WS-01 | planned | Empty/error/dirty/accessibility y documentación. |

## 2. Cambios funcionales incorporados el 2026-08-14

Antes de avanzar con los workspaces posteriores a WS-01, la foundation debe respetar estos principios:

- **riesgo configurable:** una matriz 5×5 es solo una configuración posible;
- **RCM sin scoring:** el sistema recorre ramas del árbol desde respuestas y criterios;
- **criterios visibles:** factibilidad técnica y efectividad deben formar parte de la explicación de la decisión;
- **tareas completas:** frecuencia, ejecutor/especialidad, cantidad, horas-hombre, parada y fuentes de justificación;
- **agrupación:** actividades compatibles pueden consolidarse, pero la regla exacta de duración/HH sigue `to_validate`;
- **aplicabilidad:** taxonomía/equivalencia produce candidatos, el especialista decide;
- **overrides por activo:** modificar un activo no cambia el plan genérico;
- **handoff post-publicación:** plan vigente → ejercicio/contexto presupuestario → acción explícita para preparar/generar preventivas anuales;
- **frontera abierta:** planning/scheduling, ejecución, costes y facturación no se implementan todavía como flujo validado.

Documento de análisis:

- [`../../05-meetings/01_Analysis/ANL-002_revision-funcional-post-reunion-2026-08-14.md`](../../05-meetings/01_Analysis/ANL-002_revision-funcional-post-reunion-2026-08-14.md)

## 3. F01-00 — Resultado actual

Completado:

- inspección del protocolo activo de Pulse;
- inspección del protocolo modular de pantallas;
- inspección del registro de compatibilidad Source Code;
- inspección de un shell real utilizado en Pulse;
- registro de compatibilidad propio del Functional Lab;
- árbol técnico mínimo de `scr_FunctionalLab`;
- secuencia de bloques F01;
- decisión de no depender de componentes premium en Bloque 01;
- revisión del modelo funcional para evitar hardcodes que generen retrabajo posterior.

Pendiente de la herramienta real:

- crear/identificar la Canvas app del Functional Lab;
- confirmar schema Source Code aceptado;
- confirmar versiones reales de controles;
- obtener baseline de App Checker;
- integrar y validar Bloque 01.

## 4. Condición para generar Bloque 01

Debe existir una Canvas app vacía o baseline destinada al laboratorio.

Nombre recomendado:

```text
CMMS 2.0 Functional Lab
```

El primer bloque será autocontenido y no asumirá que componentes premium de Pulse estén instalados.

La revisión funcional del 2026-08-14 **no bloquea WS-01**, porque afecta principalmente a riesgo, RCM, plan y publicación. Sí condiciona el diseño del runtime state para no introducir estructuras rígidas que después deban romperse.

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

Debe existir un contrato mínimo de `RiskProfile` que permita renderizar configuración y no hardcodear 5×5.

### Antes de WS-04 — Decisión RCM

Debe existir un contrato de árbol/preguntas que represente rama, respuesta, evidencia, criterios y política resultante sin scoring.

### Antes de WS-06 — Recursos y alcance

Debe existir un contrato mínimo para:

- `BasePlan`;
- `CandidateAssets`;
- `ApplicabilityDecision`;
- `AssetPlanOverride`;
- agrupación de actividades.

### Antes de cerrar WS-08 — Revisión y publicación

Debe existir un output de publicación preparado para mostrar el handoff conceptual hacia órdenes preventivas anuales, sin generar órdenes reales.

## 7. Documentos técnicos F01

- `development/f01-00-power-apps-foundation-audit.md`
- `development/compatibility.md`

## 8. Regla de continuidad

Una vez iniciado F01:

> No se prepara el siguiente bloque técnico hasta que el anterior quede integrado y validado en Power Apps Studio o exista una corrección explícita en curso.

Y, adicionalmente:

> No se implementa un workspace cuya regla funcional necesaria siga sin contrato mínimo cuando ello obligaría a hardcodear una hipótesis.
