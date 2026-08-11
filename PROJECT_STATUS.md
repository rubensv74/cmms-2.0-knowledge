# Estado del proyecto

**Última actualización:** 2026-08-11

## Estado general

CMMS 2.0 está en transición desde prototipos conceptuales HTML hacia **CMMS 2.0 Functional Lab**, una aplicación Power Apps destinada a validar el modelo funcional mediante casos ejecutables y producir documentación trazable para IT.

La remediación de la primera foundation asset-centric queda **cerrada**. Las 14 desviaciones detectadas han sido corregidas en modelo conceptual, contratos, fixture, journey, arquitectura, componentes, guías y handoff funcional.

Modelo canónico vigente:

```text
Engineering Library
→ Asset Application
→ Execution Plan
→ Results & Learning
```

## Remediación library-first completada — 2026-08-11

Quedan establecidos como principios canónicos:

- `FmeaDefinition` y `FmeaRevision` como raíz del conocimiento reusable;
- revisiones publicadas inmutables;
- `FmeaAssetApplication` para aplicar una revisión a un activo/contexto;
- criticidad del activo independiente del riesgo AMEF;
- `FailureCause` y `FailureEffect` explícitos;
- RCM versionado con respuestas, recomendación, decisión humana y override;
- salida explícita `NoScheduledTaskDecision`;
- N:M `MaintenanceTask` ↔ `FailureMode`;
- separación `MaintenanceTask` / `MaintenanceProcedure` / `InspectionFormat`;
- separación `EconomicAssessment` / `MaintenanceCostEstimate` / `ActualMaintenanceCost`;
- lineage por identificadores desde Engineering Library hasta Results & Learning.

La evidencia de cierre 14/14 está en:

- `00-governance/audits/2026-08-11-functional-lab-library-first-remediation.md`.

## Artefactos canónicos preparados

### Modelo y gobierno

- `00-governance/cmms-functional-lab-incremental-protocol.md` — protocolo v2 con Domain Ownership Gate.
- `00-governance/architecture-gates.md` — decisiones cerradas, validaciones funcionales y gates futuros.
- `03-data-model/core/fmea-library-model.md` — modelo conceptual canónico.
- `03-data-model/core/traceability-layers.md` — trazabilidad entre capas.

### Functional Lab

- `01-vision/cmms-functional-lab-vision.md` — visión v2.
- `02-functional/process-model/functional-journey.md` — 28 etapas reorganizadas por capas.
- `02-functional/process-model/human-system-decisions.md` — responsabilidad persona/sistema v2.
- `06-ui-ux/functional-lab/architecture.md` — arquitectura layer-aware.
- `06-ui-ux/functional-lab/component-contracts.md` — contratos funcionales de componentes.
- `06-ui-ux/functional-lab/design-system.md` — estrategia SaaS premium.

### Contratos y caso

- `contracts/fmea-library.schema.json`.
- `contracts/fmea-asset-application.schema.json`.
- `contracts/execution-plan.schema.json`.
- `contracts/maintenance-results.schema.json`.
- `contracts/case-fixture.schema.json` v2.
- `cases/P101/p101-case.v2.json` — fixture canónico.
- `cases/P101/p101-case.v1.json` — legacy, solo evidencia histórica.

El fixture v2 demuestra expresamente:

- P-101 solo en Asset Application;
- N:M tarea–modo en ambos sentidos;
- rama RCM con tarea y rama con `NoScheduledTaskDecision`;
- procedimiento y formato independientes;
- economía prevista/decisional/real separada;
- lineage hasta `ExecutionPlanTask`, resultado, coste real y revisión de efectividad.

### Preparación de Power Apps

- `development/compatibility.md`.
- `development/f01-00-power-apps-foundation-audit.md`.
- `development/adapters/runtime-adapter-v2.md`.
- `development/workspaces/ws-01-library-revision.md`.
- `development/workspaces/workspace-catalog-v2.md`.
- `development/screens/functional-lab/screen-architecture.md`.
- `development/screens/functional-lab/blocks/block-plan.md`.
- `development/validation/validate-fixture-v2.py`.

La secuencia F01-01..F01-09 está especificada hasta el punto en que Power Apps Studio se vuelve imprescindible.

## Experience Center

El runtime HTML v3 se conserva deliberadamente como **evidencia histórica asset-centric**. No se seguirá desarrollando como modelo canónico.

Sus guías de negocio y el recorrido P-101 sí han sido actualizados para enseñar:

```text
Library
→ Application
→ Plan
→ Results
```

El destino de implementación es Functional Lab v2.

## Gates de arquitectura

No ha surgido una nueva decisión estructural que requiera intervención.

Siguen abiertos, pero dormidos hasta que el alcance llegue a ellos:

- persistencia productiva;
- frontera API/backend;
- identidad/autorización;
- motor de reglas;
- implementación física de revisiones/snapshots;
- integración Asset Master/FLH/taxonomía/ADR;
- generación de Job Plans/PM/WO u objetos equivalentes;
- estrategia documental productiva;
- multi-cliente/tenancy.

No se deben decidir por adelantado.

## Asuntos funcionales todavía `to_validate`

No se consideran desviaciones:

- matriz corporativa de riesgo;
- esquema de criticidad;
- árbol RCM definitivo;
- umbrales P–F;
- fórmulas económicas;
- roles/workflow de aprobación;
- nomenclaturas/catálogos finales;
- criterios exactos para exigir procedimiento/formato;
- frecuencias y límites técnicos del fixture.

El Functional Lab puede simularlos, siempre etiquetados como no aprobados.

## Frontera técnica actual — TG-001

La rama `agent/functional-lab-foundation` no contiene actualmente una Canvas app real, `.msapp` ni Source Code `.pa.yaml` del Functional Lab.

Por tanto no es seguro generar todavía YAML: obligaría a inventar dialecto Source Code, versiones de controles, componentes instalados, theme y baseline de App Checker.

La siguiente acción ejecutable, cuando exista una Canvas app baseline, es:

1. inventariar controles/componentes reales;
2. confirmar Source Code y App Checker;
3. implementar únicamente `F01-01 — Premium App Shell Foundation`;
4. validar en Studio;
5. continuar bloque a bloque.

Este límite es **técnico**, no una decisión de arquitectura.

## Riesgos principales vigentes

- reintroducir estructura asset-centric desde UI/Power Fx;
- confundir criticidad del activo con riesgo AMEF;
- simplificar la N:M a un campo único;
- fusionar tarea/procedimiento/formato;
- tratar ausencia de tarea como ausencia de decisión;
- mezclar estimación económica y coste real;
- editar una revisión publicada desde una capa contextual;
- convertir hipótesis en automatismos corporativos;
- generar Source Code contra un baseline no inspeccionado.

## Fuentes de verdad principales

- `00-governance/audits/2026-08-11-functional-lab-library-first-remediation.md`
- `00-governance/cmms-functional-lab-incremental-protocol.md`
- `00-governance/architecture-gates.md`
- `01-vision/cmms-functional-lab-vision.md`
- `02-functional/process-model/functional-journey.md`
- `02-functional/process-model/human-system-decisions.md`
- `03-data-model/core/fmea-library-model.md`
- `03-data-model/core/traceability-layers.md`
- `06-ui-ux/functional-lab/architecture.md`
- `06-ui-ux/functional-lab/implementation-status.md`
- `07-it-handoff/functional-document-set.md`
