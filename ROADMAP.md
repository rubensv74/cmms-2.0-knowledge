# Roadmap CMMS 2.0

## 1. Cómo leer este roadmap

Este documento separa dos dimensiones que antes estaban mezcladas:

1. **mapa funcional del producto** — capacidades que CMMS 2.0 debe cubrir;
2. **roadmap de validación** — orden en el que estamos aprendiendo, probando y consolidando esas capacidades.

Que un dominio se valide antes no significa necesariamente que se implemente antes en producción.

---

# 2. Mapa funcional del producto

## A. Fundamentos de activos

- visión del producto;
- jerarquía funcional FLH;
- taxonomía corporativa;
- modelo de activos;
- registro de activos físicos;
- contexto operacional;
- criticidad.

**Madurez conceptual:** media-alta en FLH, taxonomía y activos; requiere consolidación documental.

## B. Ingeniería de mantenimiento y fiabilidad

- biblioteca de mantenimiento;
- AMEF / FMEA;
- RCM;
- estrategias y políticas;
- aplicabilidad;
- Job Plans / procedimientos;
- revisión de efectividad.

**Madurez conceptual:** alta en AMEF/RCM respecto del resto del programa; dominio elegido para iniciar Functional Lab.

## C. Gestión del trabajo

- forecast;
- work candidates;
- planificación;
- programación;
- work orders;
- ejecución;
- inspecciones;
- cierre técnico.

**Madurez conceptual:** pendiente de consolidación.

## D. Gestión económica y empresarial

- costes de mantenimiento;
- materiales y servicios;
- facturación cuando aplique;
- reporting;
- KPIs;
- integraciones;
- roles y seguridad.

**Madurez conceptual:** temprana / parcial.

---

# 3. Roadmap de validación funcional

## Fase FL-0 — Foundation

**Estado:** completada documentalmente el 2026-08-10.

- auditoría de transición;
- protocolo incremental adaptado desde Pulse;
- visión del Functional Lab;
- Functional Journey de 28 etapas;
- matriz persona vs sistema;
- arquitectura del laboratorio;
- contratos JSON;
- fixture P-101;
- paquete documental modular para IT.

## Fase FL-1 — Power Apps Foundation + WS-01

**Estado:** siguiente fase.

1. auditorar el entorno Power Apps y compatibilidad;
2. crear shell;
3. crear runtime state;
4. implementar adaptador P-101;
5. implementar navegación;
6. completar `WS-01 Caso y contexto`;
7. validar en Power Apps Studio;
8. actualizar documentación funcional.

Gate de salida: WS-01 integrado y validado sin errores abiertos.

## Fase FL-2 — Funciones y fallos

- `WS-02 Funciones y fallos`;
- validar responsabilidad sobre funciones, fallos y modos;
- consolidar requisitos y entidades asociadas.

## Fase FL-3 — AMEF y riesgo

- `WS-03 Efectos y riesgo`;
- validar escalas, cálculos, recomendaciones y gates;
- separar reglas corporativas de hipótesis de laboratorio.

## Fase FL-4 — Decisión RCM

- `WS-04 Decisión RCM`;
- hacer visible la lógica y el override;
- validar qué recomienda el sistema y qué acepta una persona.

## Fase FL-5 — Tratamiento y plan

- `WS-05 Economía y tarea`;
- `WS-06 Recursos y alcance`;
- validar transición desde decisión RCM a propuesta ejecutable.

## Fase FL-6 — Gobernanza

- `WS-07 Trazabilidad y calidad`;
- `WS-08 Revisión y publicación`;
- validar roles, discrepancias, approvals y snapshots.

## Fase FL-7 — Efectividad

- `WS-09 Efectividad y mejora`;
- validar el cierre del loop con datos reales simulados;
- abrir revisión sin sobrescribir la versión anterior.

## Fase FL-8 — Consolidación AMEF/RCM para IT

- consolidar requisitos funcionales;
- consolidar reglas de negocio;
- consolidar modelo conceptual de datos;
- consolidar mapa de pantallas;
- consolidar roles y dependencias;
- registrar preguntas de arquitectura para IT.

## Fase FL-9 — Selección del siguiente dominio

Solo después de cerrar suficientemente AMEF/RCM se seleccionará el siguiente dominio funcional a llevar al laboratorio.

La selección se basará en valor de aprendizaje, dependencias y madurez del conocimiento, no en el orden del mapa funcional.
