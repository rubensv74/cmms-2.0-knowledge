# Estado del proyecto

**Última actualización:** 2026-08-11

## Estado general

CMMS 2.0 está en transición desde prototipos conceptuales HTML hacia **CMMS 2.0 Functional Lab**, una aplicación Power Apps destinada a validar el modelo funcional mediante casos ejecutables y producir documentación trazable para IT.

La foundation del laboratorio ha sido corregida tras detectar una desviación estructural importante: el primer modelo ejecutable trataba P-101 como contenedor del AMEF. El modelo canónico vigente es ahora:

```text
Engineering Library
→ Asset Application
→ Execution Plan
→ Results & Learning
```

## Completado

### Fundamentos previos

- Estructura documental inicial.
- Prototipos HTML 01-03 de fundamentos del modelo de activos.
- Prototipo 04 AMEF + RCM por sprints P04.0-P04.6.
- AMEF–RCM Experience Center v3 con caso P-101 y recorrido guiado de 28 etapas.
- Dossier de contexto para NotebookLM.
- Especificación AMEF/RCM que ya introducía biblioteca reusable, revisiones, N:M, aplicabilidad y snapshots.

### Foundation Functional Lab v1 — 2026-08-10

- Auditoría de transición inicial.
- Protocolo incremental adaptado desde Pulse.
- Gate funcional previo al gate técnico.
- Primer journey de 28 etapas.
- Primera matriz persona vs sistema.
- Arquitectura conceptual inicial.
- Primeros schemas JSON.
- Fixture P-101 v1.
- Paquete documental modular para IT.

### Remediación library-first — 2026-08-11

- Auditoría de 14 desviaciones arquitectónicas y funcionales.
- Introducción de `FmeaDefinition` y `FmeaRevision` como padres de biblioteca.
- Separación de `FmeaAssetApplication` para el contexto por activo.
- Separación formal entre criticidad del activo y riesgo AMEF.
- `FailureCause` y `FailureEffect` como objetos explícitos.
- RCM versionado con respuestas, recomendación y decisión humana.
- Salida explícita `NoScheduledTaskDecision`.
- Relación N:M `MaintenanceTask` ↔ `FailureMode`.
- Separación `MaintenanceTask` / `MaintenanceProcedure` / `InspectionFormat`.
- Economía dividida en `EconomicAssessment`, `MaintenanceCostEstimate` y `ActualMaintenanceCost`.
- Creación de `03-data-model/` como modelo conceptual canónico.
- Contratos JSON separados por Library, Application, Plan y Results.
- Fixture P-101 v2 library-first.
- Journey v2 de 28 etapas y nueve workspaces.
- Matriz persona vs sistema v2.
- Arquitectura Functional Lab v2.
- Contratos funcionales de componentes.
- Estrategia de diseño premium adaptada a las cuatro capas.
- Guía explícita de migración fixture v1→v2.
- Guías del Experience Center actualizadas y runtime HTML v3 clasificado como evidencia histórica asset-centric.

## En curso

- Alineación final de índices, roadmap, changelog y documentación transversal.
- Auditoría de residuos asset-centric en documentación activa.
- Preparación documental de `F01-00 — Auditoría Power Apps Foundation`.

## Siguiente gate técnico

### F01-00 — Auditoría Power Apps Foundation

Antes de generar YAML deben confirmarse en la Canvas app real:

- schema Source Code disponible;
- convenciones y componentes reutilizables instalados;
- controles seguros y versiones;
- restricciones y errores conocidos;
- baseline visual;
- mecanismo inicial de adaptación fixture v2 → estado Power Fx.

Este gate no implica decidir backend, SQL, Dataverse o API.

## Primera vertical slice después del gate

`WS-01 Library & Revision`

1. Premium App Shell Foundation.
2. Layered runtime state mínimo.
3. Adaptador P-101 v2.
4. Navegación base.
5. Contexto `FmeaDefinition` / `FmeaRevision`.
6. Evidencia y trabajo sobre revisión editable.
7. Gate de preparación.
8. Output estructurado hacia WS-02.
9. Hardening y documentación.

P-101 no será el objeto principal de WS-01; aparecerá en WS-07 como `FmeaAssetApplication`.

## Riesgos principales vigentes

- Volver a introducir estructura asset-centric desde la UI aunque el modelo de datos sea correcto.
- Confundir criticidad del activo con riesgo AMEF.
- Convertir una tarea en un contenedor de procedimiento y formato.
- Perder la N:M tarea–modo por simplificación de interfaz.
- Tratar ausencia de tarea como ausencia de decisión.
- Mezclar estimación económica con coste real.
- Convertir hipótesis conceptuales en automatismos sin validación.
- Introducir backend o integraciones antes de que el laboratorio las necesite.
- Crear YAML contra componentes o dialectos no comprobados en la app real.

## Asuntos todavía por validar

No se consideran desviaciones ni se cierran automáticamente:

- matriz corporativa de riesgo;
- esquema de criticidad;
- árbol RCM definitivo;
- umbrales P–F;
- fórmulas económicas;
- roles y workflow de aprobación;
- granularidad definitiva de procedimientos/formatos;
- backend, persistencia e integración productivos.

## Fuentes de verdad principales

- `00-governance/audits/2026-08-11-functional-lab-library-first-remediation.md`
- `00-governance/cmms-functional-lab-incremental-protocol.md`
- `01-vision/cmms-functional-lab-vision.md`
- `02-functional/process-model/functional-journey.md`
- `02-functional/process-model/human-system-decisions.md`
- `03-data-model/core/fmea-library-model.md`
- `03-data-model/core/traceability-layers.md`
- `06-ui-ux/functional-lab/architecture.md`
- `06-ui-ux/functional-lab/implementation-status.md`
- `07-it-handoff/functional-document-set.md`
