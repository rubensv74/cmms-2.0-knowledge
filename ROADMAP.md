# Roadmap CMMS 2.0

## 1. Cómo leer este roadmap

Este documento separa:

1. **mapa funcional del producto** — capacidades que CMMS 2.0 debe cubrir;
2. **roadmap de validación** — orden en el que se aprenden, prueban y consolidan esas capacidades.

Que un dominio se valide antes no significa que se implemente antes en producción.

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

- Engineering Library;
- AMEF / FMEA;
- revisiones y gobernanza;
- causas, efectos y consecuencias;
- RCM;
- tareas de mantenimiento reutilizables;
- relación N:M tareas–modos;
- procedimientos y formatos de inspección;
- aplicabilidad por activo/contexto;
- Execution Plans;
- economía y costes estimados;
- resultados y revisión de efectividad.

**Madurez conceptual:** alta respecto del resto del programa; dominio elegido para iniciar Functional Lab.

Modelo rector:

```text
Engineering Library
→ Asset Application
→ Execution Plan
→ Results & Learning
```

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

## Fase FL-0 — Foundation v1

**Estado:** completada el 2026-08-10 y posteriormente remediada.

Produjo:

- auditoría de transición;
- protocolo incremental;
- visión inicial;
- journey de 28 etapas;
- matriz persona vs sistema;
- arquitectura inicial;
- contratos JSON v1;
- fixture P-101 v1;
- paquete documental para IT.

Su principal limitación fue conservar P-101 como raíz conceptual del recorrido.

## Fase FL-0R — Remediación library-first

**Estado:** completada conceptualmente el 2026-08-11.

- auditar 14 desviaciones;
- crear modelo conceptual en `03-data-model/`;
- introducir `FmeaDefinition` / `FmeaRevision`;
- introducir `FmeaAssetApplication`;
- separar criticidad del activo y riesgo AMEF;
- introducir causas/efectos explícitos;
- versionar RCM y respuestas;
- soportar `NoScheduledTaskDecision`;
- hacer N:M tarea–modo;
- separar tarea/procedimiento/formato;
- separar las tres capas económicas;
- dividir contratos JSON por capas;
- crear fixture P-101 v2;
- rehacer journey, matriz persona/sistema y arquitectura;
- definir contratos de componentes;
- adaptar guías y clasificar Experience Center v3 como histórico.

Gate de salida: ningún nuevo desarrollo puede usar v1 como modelo runtime canónico.

## Fase FL-1 — Power Apps Foundation + WS-01 Library & Revision

**Estado:** siguiente fase técnica.

1. auditar Canvas app baseline y compatibilidad Source Code;
2. crear Premium App Shell Foundation;
3. crear layered runtime state;
4. implementar adaptador fixture v2;
5. implementar navegación de workspaces/capas;
6. completar `WS-01 Library & Revision`;
7. validar en Power Apps Studio;
8. actualizar documentación funcional.

Gate de salida: WS-01 integrado y validado sin errores abiertos.

## Fase FL-2 — Functions & Failure Structure

- `WS-02`;
- validar funciones y estándares;
- validar fallos funcionales;
- validar modos, causas y efectos como entidades separadas;
- confirmar trazabilidad por IDs.

## Fase FL-3 — Consequence & Risk

- `WS-03`;
- validar matriz/version y escalas;
- validar cálculos/recomendaciones/gates;
- comprobar explícitamente que riesgo AMEF no se presenta como criticidad del activo;
- separar reglas corporativas de hipótesis del laboratorio.

## Fase FL-4 — RCM Decision

- `WS-04`;
- hacer visible la lógica versionada y las respuestas;
- diferenciar recomendación del sistema y decisión humana;
- validar overrides;
- validar salida `MaintenanceTask` o `NoScheduledTaskDecision`.

## Fase FL-5 — Treatment Engineering

- `WS-05`;
- validar `MaintenanceTask` reusable;
- validar N:M tarea–modo;
- validar `MaintenanceProcedure` / `InspectionFormat` opcionales;
- validar `MaintenanceCostEstimate`;
- validar `EconomicAssessment` solo sobre alternativas técnicamente válidas.

## Fase FL-6 — Library Publication

- `WS-06`;
- validar calidad, discrepancias, aprobación y snapshot;
- demostrar que una revisión publicada es inmutable;
- validar creación de nueva revisión sin sobrescritura.

## Fase FL-7 — Asset Application

- `WS-07`;
- aplicar una revisión publicada a P-101;
- congelar contexto operacional;
- cargar `AssetCriticalitySnapshot` independiente del AMEF;
- validar aplicabilidad, perfiles, variantes y overrides;
- demostrar que la biblioteca no se clona ni modifica.

## Fase FL-8 — Execution Plan

- `WS-08`;
- instanciar tareas aplicables;
- conservar `maintenanceTaskId` de origen;
- contextualizar intervalo, recursos, alcance, procedimiento/formato y agrupación;
- congelar/publicar plan de aplicación.

## Fase FL-9 — Results & Improvement

- `WS-09`;
- registrar resultados simulados;
- registrar `ActualMaintenanceCost` separado del estimado;
- comparar hipótesis con realidad;
- decidir entre ajuste contextual y `EngineeringChangeRequest`;
- abrir nueva `FmeaRevision` sin sobrescribir la anterior cuando corresponda.

## Fase FL-10 — Consolidación AMEF/RCM para IT

- consolidar requisitos funcionales;
- consolidar reglas de negocio;
- consolidar modelo conceptual de datos;
- consolidar mapa de pantallas;
- consolidar roles y dependencias;
- consolidar contratos de aplicación;
- registrar gates de arquitectura para IT;
- distinguir claramente decisiones validadas de asuntos todavía abiertos.

## Fase FL-11 — Selección del siguiente dominio

Solo después de cerrar suficientemente AMEF/RCM se seleccionará el siguiente dominio funcional a llevar al laboratorio.

La selección se basará en valor de aprendizaje, dependencias y madurez del conocimiento, no en el orden del mapa funcional.
