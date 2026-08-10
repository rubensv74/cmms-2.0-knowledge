# Estado del proyecto

**Última actualización:** 2026-08-10

## Estado general

Transición desde prototipado conceptual HTML hacia **CMMS 2.0 Functional Lab**, una aplicación Power Apps destinada a validar el modelo funcional mediante casos ejecutables y a producir documentación funcional trazable para IT.

## Completado

### Fundamentos previos

- Estructura documental inicial.
- Prototipos HTML 01-03 de fundamentos del modelo de activos.
- Prototipo 04 AMEF + RCM por sprints P04.0-P04.6.
- AMEF–RCM Experience Center v3 con caso P-101 y recorrido guiado de 28 etapas.
- Dossier de contexto para NotebookLM.

### Foundation Functional Lab — 2026-08-10

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

## En curso

- Consolidación del modelo funcional CMMS 2.0 a partir de la nueva estructura.
- Preparación del primer vertical slice en Power Apps: `WS-01 Caso y contexto`.

## Siguiente gate

### F01-00 — Auditoría Power Apps Foundation

Antes de generar YAML deben confirmarse en el entorno real:

- schema Source Code;
- convenciones y componentes reutilizables;
- controles seguros;
- restricciones y errores conocidos;
- arquitectura visual base;
- mecanismo inicial de adaptación JSON → colecciones Power Fx.

Después se iniciará el primer bloque técnico siguiendo el protocolo incremental.

## Próximos incrementos

1. Shell de pantalla.
2. Runtime state mínimo.
3. Adaptador P-101.
4. Navegación base.
5. WS-01 — contexto visual.
6. WS-01 — edición.
7. WS-01 — gate de evidencia.
8. WS-01 — output hacia funciones y fallos.
9. Hardening y documentación de WS-01.

No se iniciará WS-02 hasta validar WS-01 en Power Apps Studio.

## Riesgos principales

- Confundir el Functional Lab con la arquitectura productiva futura.
- Convertir hipótesis conceptuales en automatismos sin validación.
- Identificar una etapa de negocio con una pantalla de forma automática.
- Introducir backend o integraciones antes de que el laboratorio las necesite.
- Duplicar conocimiento entre prototipos, app y documentación funcional.

## Fuentes de verdad principales

- `00-governance/cmms-functional-lab-incremental-protocol.md`
- `01-vision/cmms-functional-lab-vision.md`
- `02-functional/process-model/functional-journey.md`
- `02-functional/process-model/human-system-decisions.md`
- `06-ui-ux/functional-lab/architecture.md`
- `06-ui-ux/functional-lab/implementation-status.md`
- `07-it-handoff/functional-document-set.md`
