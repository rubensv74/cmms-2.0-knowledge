# Estado del proyecto

**Última actualización:** 2026-08-14

## Estado general

CMMS 2.0 continúa en la fase **Functional Lab**. La foundation funcional sigue siendo válida, pero ha sido revisada a **v1.1** con las conclusiones de la reunión del 2026-08-14.

El laboratorio se utilizará para validar el modelo funcional mediante casos ejecutables y producir documentación funcional trazable para IT, sin convertir Power Apps en una decisión de arquitectura productiva.

La interfaz del Functional Lab se construirá desde Foundation con una **arquitectura SaaS premium**, utilizando los arquetipos, estándares visuales y contratos de componentes curados en `rubensv74/functional-engineering-knowledge-base`.

## Cambio principal del 2026-08-14

La reunión con Hernando confirmó cuatro correcciones que deben quedar incorporadas antes de implementar los workspaces afectados:

1. **riesgo configurable por cliente/proyecto**: una matriz 5×5 no puede convertirse en regla fija del producto;
2. **RCM como árbol lógico sin scoring**: respuestas, evidencia, factibilidad técnica y efectividad gobiernan la rama y la política;
3. **plan genérico + aplicabilidad + overrides por activo**: la taxonomía puede sugerir candidatos, pero el especialista decide y las excepciones no deben modificar el plan común;
4. **handoff post-publicación**: el plan vigente debe poder alimentar una generación anual y explícita de órdenes preventivas, mientras planning/scheduling, ejecución, costes y facturación continúan `to_validate`.

Análisis de impacto:

- `05-meetings/01_Analysis/ANL-002_revision-funcional-post-reunion-2026-08-14.md`

## Completado

### Fundamentos previos

- Estructura documental inicial.
- Prototipos HTML 01-03 de fundamentos del modelo de activos.
- Prototipo 04 AMEF + RCM por sprints P04.0-P04.6.
- AMEF–RCM Experience Center v3 con caso P-101 y recorrido guiado de 28 etapas.
- Dossier de contexto para NotebookLM.

### Foundation Functional Lab — F00

- Auditoría de transición desde prototipos hacia laboratorio funcional.
- Adaptación del Protocolo de Implementación Incremental Asistida por IA usado en Pulse.
- Gate funcional obligatorio antes del gate técnico.
- Visión y límites del Functional Lab.
- Functional Journey de 28 etapas independiente de la UI.
- Agrupación inicial en nueve workspaces.
- Matriz preliminar persona vs sistema.
- Arquitectura conceptual del laboratorio.
- Schemas JSON para journey y casos.
- Conversión del caso P-101 existente a fixture JSON canónico.
- Definición del paquete documental modular para IT.
- Notas de reunión del 2026-08-14 incorporadas al repositorio.
- Revisión funcional v1.1 aplicada a Functional Journey, Persona vs Sistema, visión, arquitectura y fixture P-101.

### Power Apps Foundation — F01-00 estático

- Revisión del protocolo modular Power Apps de Pulse.
- Revisión del registro de compatibilidad Source Code de Pulse.
- Revisión de un shell incremental real utilizado en Pulse.
- Creación del registro de compatibilidad propio del Functional Lab.
- Secuencia F01-01 a F01-09.
- Estrategia SaaS premium documentada en `06-ui-ux/functional-lab/design-system.md`.
- Adopción del patrón de selección de arquetipos de la base de conocimiento.
- Adopción del estándar de calidad visual Power Apps.
- Adopción del contrato de componentes reutilizables.
- Decisión: el diseño será premium desde Foundation; no se añadirá una dependencia CanvasComponent hasta confirmar su instalación en la app activa.
- Revisión del runtime conceptual para no introducir hardcodes de matriz 5×5, scoring RCM o relación rígida análisis-plan-activo.

## En curso

### F01-00 — cierre en herramienta real

La auditoría estática y la revisión funcional v1.1 están superadas. Falta disponer de la Canvas app real del Functional Lab para confirmar:

- schema Source Code aceptado;
- versiones reales de controles;
- baseline de App Checker;
- componentes premium instalados;
- componentes fundacionales que deben incorporarse;
- aceptación del primer bloque en Power Apps Studio;
- baseline de calidad visual.

## Siguiente acción

Crear o identificar una Canvas app destinada al laboratorio, nombre recomendado:

```text
CMMS 2.0 Functional Lab
```

Una vez exista:

1. inventariar componentes disponibles;
2. seleccionar los componentes premium fundacionales;
3. declarar tarea, criterio de éxito y arquetipo del primer workspace;
4. redactar `F01-01 Premium App Shell Foundation`;
5. validar el bloque en Power Apps Studio antes de preparar F01-02.

La revisión del 2026-08-14 **no bloquea WS-01**, pero sí condiciona el runtime state para que los workspaces posteriores puedan incorporar configuración, aplicabilidad y overrides sin rehacer la foundation.

## Próximos incrementos

1. F01-01 — Premium App Shell Foundation.
2. F01-02 — Runtime state mínimo compatible con configuración y decisiones trazadas.
3. F01-03 — Adaptador P-101 v1.1.
4. F01-04 — Navegación base.
5. F01-05 — WS-01 contexto visual premium.
6. F01-06 — WS-01 edición.
7. F01-07 — WS-01 gate de evidencia.
8. F01-08 — WS-01 output hacia funciones y fallos.
9. F01-09 — Hardening, Visual QA y documentación de WS-01.

No se iniciará WS-02 hasta validar WS-01 en Power Apps Studio.

Antes de WS-03, WS-04 y WS-06 deberán existir contratos mínimos de `RiskProfile`, árbol RCM y aplicabilidad/overrides respectivamente.

## Extensión operacional identificada

El modelo objetivo posterior a la publicación se perfila como:

```text
Plan publicado
→ generación anual de preventivas
→ planificación/programación
→ asignación
→ ejecución/feedback
→ coste real
→ imputación presupuestaria/contractual
→ integración corporativa / facturación
```

Solo el primer handoff está suficientemente validado para mostrarse en el Functional Lab actual. El resto requiere nuevas sesiones de análisis, incluyendo perfiles de Planning/Scheduling y Contratos/Subcontratos.

## Riesgos principales

- Confundir el Functional Lab con la arquitectura productiva futura.
- Convertir hipótesis conceptuales en automatismos sin validación.
- Hardcodear una matriz 5×5 o una única filosofía de criticidad.
- Representar RCM como scoring en lugar de árbol lógico.
- Aplicar automáticamente planes a activos sugeridos por taxonomía.
- Permitir que una excepción de activo modifique accidentalmente el plan genérico.
- Inventar reglas de planning, costes o facturación antes de validarlas.
- Identificar una etapa de negocio con una pantalla de forma automática.
- Forzar un único arquetipo de interfaz a workspaces con trabajos distintos.
- Introducir backend o integraciones antes de que el laboratorio las necesite.
- Asumir que un CanvasComponent disponible en GitHub está instalado en la app.
- Tratar `premium` como mera decoración en lugar de calidad de arquitectura, interacción y componente.
- Duplicar conocimiento entre prototipos, app y documentación funcional.

## Fuentes de verdad principales

- `00-governance/cmms-functional-lab-incremental-protocol.md`
- `01-vision/cmms-functional-lab-vision.md`
- `02-functional/process-model/functional-journey.md`
- `02-functional/process-model/human-system-decisions.md`
- `05-meetings/2026/2026-08-14_revision-modelo-conceptual-amef-rcm.md`
- `05-meetings/01_Analysis/ANL-002_revision-funcional-post-reunion-2026-08-14.md`
- `06-ui-ux/functional-lab/architecture.md`
- `06-ui-ux/functional-lab/design-system.md`
- `06-ui-ux/functional-lab/implementation-status.md`
- `06-ui-ux/functional-lab/development/f01-00-power-apps-foundation-audit.md`
- `06-ui-ux/functional-lab/development/compatibility.md`
- `07-it-handoff/functional-document-set.md`
