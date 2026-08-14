# Roadmap CMMS 2.0

**Última revisión:** 2026-08-14

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
- criticidad configurable por proyecto/cliente.

**Madurez conceptual:** media-alta en FLH, taxonomía y activos; la reunión 2026-08-14 confirma que criticidad/riesgo no debe hardcodearse a una única matriz.

## B. Ingeniería de mantenimiento y fiabilidad

- biblioteca de mantenimiento;
- AMEF / FMEA;
- perfiles y matrices de riesgo configurables;
- RCM como árbol lógico de decisión;
- criterios de factibilidad técnica y efectividad;
- estrategias y políticas;
- definición de tareas y frecuencias;
- recursos y condiciones de ejecución;
- agrupación de tareas;
- aplicabilidad a activos equivalentes;
- plan genérico y overrides por activo;
- Job Plans / procedimientos;
- revisión, publicación y versionado;
- revisión de efectividad.

**Madurez conceptual:** alta en AMEF/RCM respecto del resto del programa; dominio elegido para iniciar Functional Lab. Procedimientos/checklists y reglas exactas de agrupación siguen pendientes.

## C. Gestión del trabajo

- handoff desde plan publicado;
- generación anual de órdenes preventivas;
- forecast;
- work candidates;
- planificación;
- programación;
- asignación de ejecutores;
- work orders;
- ejecución;
- feedback de campo;
- inspecciones;
- cierre técnico.

**Madurez conceptual:** temprana. La reunión 2026-08-14 valida el principio `plan vigente → ejercicio/contexto presupuestario → generación anual explícita de preventivas`; el resto requiere consolidación específica.

## D. Gestión económica y empresarial

- centros de coste y contexto presupuestario;
- costes reales de mantenimiento;
- materiales y servicios;
- partidas de contrato/subcontrato cuando aplique;
- facturación cuando aplique;
- reporting;
- KPIs;
- integraciones corporativas;
- roles y seguridad.

**Madurez conceptual:** temprana / parcial. La relación WO → coste → contrato/subcontrato → facturación queda abierta y requiere incorporar perfiles de Contratos/Subcontratos.

---

# 3. Roadmap de validación funcional

## Fase FL-0 — Foundation

**Estado:** completada y revisada funcionalmente el 2026-08-14.

- auditoría de transición;
- protocolo incremental adaptado desde Pulse;
- visión del Functional Lab;
- Functional Journey de 28 etapas;
- matriz persona vs sistema;
- arquitectura del laboratorio;
- contratos JSON;
- fixture P-101;
- paquete documental modular para IT;
- revisión v1.1 derivada de la reunión 2026-08-14.

## Fase FL-1 — Power Apps Foundation + WS-01

**Estado:** siguiente fase técnica.

1. auditorar el entorno Power Apps y compatibilidad;
2. crear shell;
3. crear runtime state compatible con configuración y decisiones trazadas;
4. implementar adaptador P-101 v1.1;
5. implementar navegación;
6. completar `WS-01 Caso y contexto`;
7. validar en Power Apps Studio;
8. actualizar documentación funcional.

Gate de salida: WS-01 integrado y validado sin errores abiertos.

## Fase FL-2 — Funciones y fallos

- `WS-02 Funciones y fallos`;
- validar responsabilidad sobre funciones, fallos y modos;
- consolidar requisitos y entidades asociadas.

## Fase FL-3 — AMEF y riesgo configurable

Antes de implementar el workspace debe existir un contrato mínimo `RiskProfile`.

- `WS-03 Efectos y riesgo`;
- validar escalas, rangos, cálculos, recomendaciones y gates;
- demostrar que el perfil se renderiza desde configuración y no desde una matriz 5×5 fija;
- separar reglas corporativas, configuración de proyecto e hipótesis de laboratorio.

## Fase FL-4 — Decisión RCM

Antes de implementar el workspace debe existir un contrato mínimo del árbol RCM.

- `WS-04 Decisión RCM`;
- representar respuestas, evidencia y ramas sin scoring acumulado;
- hacer visibles criterios de factibilidad técnica y efectividad;
- validar qué deriva el sistema y qué confirma una persona.

## Fase FL-5 — Tratamiento y plan

- `WS-05 Economía y tarea`;
- `WS-06 Recursos y alcance`;
- validar transición desde decisión RCM a propuesta ejecutable;
- validar fuentes de justificación de tarea/frecuencia;
- validar recursos, cantidad de ejecutores, horas-hombre y parada;
- validar agrupación de actividades;
- validar candidatos de aplicabilidad, decisión humana y overrides por activo.

Antes de WS-06 deben existir contratos mínimos para `BasePlan`, `CandidateAssets`, `ApplicabilityDecision` y `AssetPlanOverride`.

## Fase FL-6 — Gobernanza y handoff

- `WS-07 Trazabilidad y calidad`;
- `WS-08 Revisión y publicación`;
- validar roles, discrepancias, approvals y snapshots;
- producir `PublishedPlanVersion`;
- mostrar handoff conceptual hacia ejercicio/contexto presupuestario y generación anual explícita de preventivas.

No se implementarán todavía planificación, programación, ejecución ni costes reales.

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
- registrar preguntas de arquitectura para IT;
- documentar la frontera con Gestión del Trabajo.

## Fase FL-9 — Selección del siguiente dominio

Después de cerrar suficientemente AMEF/RCM se decidirá el siguiente dominio funcional a llevar al laboratorio.

**Candidato natural identificado el 2026-08-14:** Gestión del Trabajo, comenzando por la transición desde plan publicado hacia generación anual de órdenes preventivas y continuando con planning/scheduling.

La selección definitiva se basará en valor de aprendizaje, dependencias y madurez del conocimiento, no únicamente en el orden del mapa funcional.

Antes de modelar costes/facturación será necesario incorporar conocimiento de Contratos/Subcontratos y de los procesos corporativos de coste.
