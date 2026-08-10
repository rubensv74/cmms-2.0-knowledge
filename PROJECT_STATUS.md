# Estado del proyecto

**Última actualización:** 2026-08-10

## Estado general

CMMS 2.0 ha entrado en la fase **Functional Lab**. La foundation funcional está consolidada y se ha iniciado F01 — Power Apps Foundation.

El laboratorio se utilizará para validar el modelo funcional mediante casos ejecutables y producir documentación funcional trazable para IT, sin convertir Power Apps en una decisión de arquitectura productiva.

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

### Power Apps Foundation — F01-00 estático

- Revisión del protocolo modular Power Apps de Pulse.
- Revisión del registro de compatibilidad Source Code de Pulse.
- Revisión de un shell incremental real utilizado en Pulse.
- Creación del registro de compatibilidad propio del Functional Lab.
- Arquitectura técnica mínima de `scr_FunctionalLab`.
- Secuencia F01-01 a F01-09.
- Decisión: Bloque 01 no dependerá de componentes premium no confirmados en la app.

## En curso

### F01-00 — cierre en herramienta real

La auditoría estática está superada. Falta disponer de la Canvas app real del Functional Lab para confirmar:

- schema Source Code aceptado;
- versiones reales de controles;
- baseline de App Checker;
- aceptación del primer bloque en Power Apps Studio.

## Siguiente acción

Crear o identificar una Canvas app destinada al laboratorio, nombre recomendado:

```text
CMMS 2.0 Functional Lab
```

Una vez exista, se redactará `F01-01 Shell de pantalla` y se validará en Studio antes de preparar F01-02.

## Próximos incrementos

1. F01-01 — Shell de pantalla.
2. F01-02 — Runtime state mínimo.
3. F01-03 — Adaptador P-101.
4. F01-04 — Navegación base.
5. F01-05 — WS-01 contexto visual.
6. F01-06 — WS-01 edición.
7. F01-07 — WS-01 gate de evidencia.
8. F01-08 — WS-01 output hacia funciones y fallos.
9. F01-09 — Hardening y documentación de WS-01.

No se iniciará WS-02 hasta validar WS-01 en Power Apps Studio.

## Riesgos principales

- Confundir el Functional Lab con la arquitectura productiva futura.
- Convertir hipótesis conceptuales en automatismos sin validación.
- Identificar una etapa de negocio con una pantalla de forma automática.
- Introducir backend o integraciones antes de que el laboratorio las necesite.
- Asumir que un CanvasComponent disponible en GitHub está instalado en la app.
- Duplicar conocimiento entre prototipos, app y documentación funcional.

## Fuentes de verdad principales

- `00-governance/cmms-functional-lab-incremental-protocol.md`
- `01-vision/cmms-functional-lab-vision.md`
- `02-functional/process-model/functional-journey.md`
- `02-functional/process-model/human-system-decisions.md`
- `06-ui-ux/functional-lab/architecture.md`
- `06-ui-ux/functional-lab/implementation-status.md`
- `06-ui-ux/functional-lab/development/f01-00-power-apps-foundation-audit.md`
- `06-ui-ux/functional-lab/development/compatibility.md`
- `07-it-handoff/functional-document-set.md`
