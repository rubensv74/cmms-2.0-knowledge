# Functional Lab — Implementation Status

**Fecha:** 2026-08-11  
**Estado general:** Foundation v2 — library-first remediated and hardened  
**Último gate superado:** remediación conceptual/contractual completa  
**Validación Power Apps:** auditoría estática completada; baseline real pendiente

## 1. Resultado de la remediación

La primera foundation convirtió el recorrido P-101 a un fixture ejecutable, pero mantuvo una estructura demasiado centrada en el activo.

La auditoría posterior detectó 14 desviaciones respecto al modelo reusable ya definido para AMEF/RCM. Las 14 han sido corregidas en modelo conceptual, journey, contratos, fixture, arquitectura, componentes, guías y handoff documental.

Principio vigente:

```text
Engineering Library
→ Asset Application
→ Execution Plan
→ Results & Learning
```

## 2. Estado de incrementos

| Incremento | Estado | Resultado |
|---|---|---|
| F00-01 Auditoría de transición | completed | Riesgos, fuentes y orden inicial de trabajo identificados. |
| F00-02 Protocolo incremental CMMS | superseded-by-v2 | Primera adaptación del protocolo de Pulse. |
| F00-03 Visión v1 | superseded-by-v2 | Primera frontera del Functional Lab. |
| F00-04 Journey v1 | superseded-by-v2 | 28 etapas asset-centric conservadas como antecedente. |
| F00-05 Persona vs sistema v1 | superseded-by-v2 | Primera matriz de responsabilidades. |
| F00-06 Contratos JSON v1 | legacy | Fixture monolítico asset-centric; no usar para nuevos bloques. |
| F00-07 Fixture P-101 v1 | legacy | Evidencia histórica, no fuente runtime canónica. |
| F00-08 Arquitectura v1 | superseded-by-v2 | Sustituida por arquitectura por capas. |
| F00-09 Paquete documental IT | completed | Estructura modular de handoff definida y posteriormente alineada a v2. |
| F00-R01 Auditoría library-first | completed | 14 desviaciones catalogadas y corregidas. |
| F00-R02 Modelo conceptual canónico | completed | `03-data-model/` con entidades, cardinalidades, invariantes y trazabilidad. |
| F00-R03 Contratos por capas | completed | Schemas Library, Application, Plan y Results. |
| F00-R04 Fixture P-101 v2 | completed | P-101 convertido en aplicación de una biblioteca reusable. |
| F00-R05 Journey v2 | completed | 28 etapas reorganizadas desde biblioteca hasta resultados. |
| F00-R06 Persona vs sistema v2 | completed | Responsabilidades adaptadas a cuatro capas. |
| F00-R07 Arquitectura v2 | completed | Estado, workspaces y trazabilidad runtime library-first. |
| F00-R08 Component contracts | completed | Patrones de dominio definidos sin inventar YAML. |
| F00-R09 Guías/artefactos históricos | completed | Guías alineadas; runtime HTML v3 clasificado como evidencia histórica. |
| F00-R10 Governance hardening | completed | Protocolo v2 con Domain Ownership Gate y registro de architecture gates. |
| F00-R11 Runtime preparation | completed | Runtime Adapter v2, WS-01 detallado y catálogo WS-01..WS-09. |
| F00-R12 Contract hardening | completed | Schemas reforzados, ambos caminos RCM en fixture y lineage corregido. |
| F00-R13 Validation tooling | completed | Validador local de sintaxis/referencias/dominio sin GitHub Actions. |
| F01-00 Auditoría Power Apps de foundation | static-complete / runtime-pending | Documento restaurado de `main` y adaptado a library-first; falta inspeccionar app real. |
| F01-01 Premium App Shell Foundation | blocked-by-real-baseline | Primer bloque técnico. |
| F01-02 Layered runtime state | planned | Estado local separado en Library/Application/Plan/Results. |
| F01-03 Runtime Adapter v2 | specified / implementation-planned | Fixture v2 → estado/colecciones Power Fx. |
| F01-04 Navegación base | planned | Workspaces y transición visual entre capas. |
| F01-05 WS-01 Library context | specified / implementation-planned | `FmeaDefinition` y `FmeaRevision`. |
| F01-06 WS-01 Evidence/revision work | specified / implementation-planned | Inputs permitidos sobre revisión editable/demostrativa. |
| F01-07 WS-01 Gate | specified / implementation-planned | Preparación de revisión y explicación del bloqueo. |
| F01-08 WS-01 Output | specified / implementation-planned | Referencias estructuradas hacia WS-02. |
| F01-09 Hardening WS-01 | planned | Loading/empty/error/dirty/read-only/accessibility. |

## 3. Contratos canónicos vigentes

```text
case-fixture.schema.json (v2)
├─ fmea-library.schema.json
├─ fmea-asset-application.schema.json
├─ execution-plan.schema.json
└─ maintenance-results.schema.json
```

Caso canónico:

```text
cases/P101/p101-case.v2.json
```

La v1 se conserva exclusivamente como antecedente y referencia de migración.

El fixture v2 demuestra explícitamente:

- `FmeaDefinition` / `FmeaRevision` reusable;
- P-101 solo en Asset Application;
- riesgo AMEF separado de criticidad del activo;
- causas/efectos explícitos;
- RCM con tarea;
- RCM con `NoScheduledTaskDecision`;
- N:M en ambos sentidos entre tareas y modos;
- procedimiento y formato separados;
- `EconomicAssessment`, `MaintenanceCostEstimate` y `ActualMaintenanceCost` separados;
- lineage hasta `ExecutionPlanTask`, resultado y revisión de efectividad.

## 4. Gate funcional de WS-01 — Library & Revision

Especificación completa:

```text
development/workspaces/ws-01-library-revision.md
```

### Objeto activo

```text
FmeaDefinition
→ FmeaRevision
```

### Output mínimo

```text
{
  layer,
  fmeaDefinitionId,
  fmeaRevisionId,
  revisionNumber,
  status,
  validationStatus,
  publishedSnapshotId
}
```

**No existe `AssetId` en el output requerido de WS-01.**

## 5. Preparación técnica ya completada

Antes de YAML están disponibles:

- `development/compatibility.md`;
- `development/f01-00-power-apps-foundation-audit.md`;
- `development/adapters/runtime-adapter-v2.md`;
- `development/workspaces/ws-01-library-revision.md`;
- `development/workspaces/workspace-catalog-v2.md`;
- `development/validation/validate-fixture-v2.py`.

## 6. Estado de gates

Registro canónico:

```text
00-governance/architecture-gates.md
```

### Arquitectura conceptual

No existe un nuevo gate de arquitectura bloqueante.

Las decisiones estructurales que originaron la remediación están cerradas y registradas.

### Dependencia técnica actual

`TG-001 — Canvas app baseline`.

Antes de generar código Source Code de Power Apps deben confirmarse en la Canvas app real:

- schema Source Code aceptado;
- convenciones de nombres;
- controles Classic/Modern seguros;
- componentes premium instalados;
- propiedades incompatibles;
- baseline visual;
- App Checker;
- mecanismo de introducción del fixture / `ParseJSON` disponible.

Esto es una dependencia técnica verificable, no una decisión de arquitectura del dominio.

## 7. Validación local preparada

El script:

```text
development/validation/validate-fixture-v2.py
```

comprueba sin workflows:

- JSON syntax;
- referencias padre-hijo;
- application → revision;
- plan → application/task;
- result → execution plan task;
- actual cost → result;
- risk/asset criticality separation;
- N:M en ambos sentidos;
- branch con tarea y branch sin tarea;
- refs de procedimiento/formato;
- lineage;
- schemas de las cuatro capas si `jsonschema` está instalado.

No se ha creado ningún workflow ni se han consumido Actions para esta validación.

## 8. Regla de continuidad

Una vez exista baseline real:

> No se prepara el siguiente bloque técnico hasta que el anterior quede integrado y validado en Power Apps Studio o exista una corrección explícita en curso.

La misma disciplina se aplica a límites de dominio: WS-07 puede leer `FmeaRevision` pero no modificarla; WS-09 puede cuestionar ingeniería y abrir cambio, pero no sobrescribir hipótesis históricas.
