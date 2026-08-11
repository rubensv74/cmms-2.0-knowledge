# CMMS 2.0 Functional Lab

## Propósito

Aplicación Canvas Power Apps para validar el modelo funcional de CMMS 2.0 mediante casos ejecutables, sin convertir el prototipo en arquitectura productiva.

El modelo canónico del laboratorio es **library-first**:

```text
Engineering Library
→ Asset Application
→ Execution Plan
→ Results & Learning
```

## Fuentes principales

- `../../01-vision/cmms-functional-lab-vision.md`
- `../../02-functional/process-model/functional-journey.md`
- `../../02-functional/process-model/human-system-decisions.md`
- `../../03-data-model/core/fmea-library-model.md`
- `../../03-data-model/core/traceability-layers.md`
- `../../00-governance/cmms-functional-lab-incremental-protocol.md`
- `../../00-governance/audits/2026-08-11-functional-lab-library-first-remediation.md`
- `architecture.md`
- `design-system.md`
- `component-contracts.md`

## Contratos canónicos v2

- `contracts/functional-journey.schema.json`
- `contracts/case-fixture.schema.json`
- `contracts/fmea-library.schema.json`
- `contracts/fmea-asset-application.schema.json`
- `contracts/execution-plan.schema.json`
- `contracts/maintenance-results.schema.json`

El fixture compuesto mantiene las cuatro capas separadas aunque Power Apps las cargue en un mismo runtime local.

## Casos

### Canónico

- `cases/P101/p101-case.v2.json`

P-101 demuestra la aplicación de una biblioteca reusable de bomba centrífuga (`FMEA-CWPUMP-001 / Rev 1`) a un activo concreto.

### Legacy

- `cases/P101/p101-case.v1.json`

La v1 se conserva como evidencia histórica de la primera foundation. Es **asset-centric** y no debe utilizarse como fuente runtime para nuevos bloques del Functional Lab.

## Principio de desarrollo

El laboratorio seguirá el protocolo incremental utilizado en Pulse, con gate funcional previo.

Orden obligatorio:

```text
Auditoría
→ responsabilidad funcional y capa
→ contrato de datos
→ arquitectura de interacción
→ bloque pequeño
→ repositorio
→ validación en Power Apps Studio
→ corrección
→ documentación
→ siguiente bloque
```

## Regla de modelo

Una pantalla o componente no puede introducir una relación que contradiga `03-data-model/`.

Especialmente:

- el activo no es padre del AMEF;
- `FmeaDefinition` tiene revisiones reutilizables;
- una revisión publicada es inmutable;
- criticidad del activo y riesgo AMEF son conceptos independientes;
- tarea y modo se relacionan N:M;
- `MaintenanceProcedure` e `InspectionFormat` están separados de `MaintenanceTask`;
- una decisión RCM puede terminar en `NoScheduledTaskDecision`;
- economía de decisión, coste estimado y coste real son objetos distintos;
- toda capa mantiene lineage por identificadores.

## Estructura prevista de implementación

```text
06-ui-ux/functional-lab/
├── README.md
├── architecture.md
├── design-system.md
├── component-contracts.md
├── implementation-status.md
├── contracts/
├── cases/
├── development/
│   ├── compatibility.md
│   ├── fixture-v1-to-v2-migration.md
│   ├── screens/
│   │   └── functional-lab/
│   │       ├── README.md
│   │       ├── screen-architecture.md
│   │       ├── blocks/
│   │       └── user-guide/
│   └── adapters/
└── power-apps/
    ├── screens/
    ├── components/
    └── runtime/
```

Las carpetas de código se crearán cuando comience el primer incremento técnico. No se introducirán YAML vacíos.

## Primera vertical slice

La primera funcionalidad completa será `WS-01 Library & Revision`:

- cargar el fixture v2;
- mostrar/seleccionar `FmeaDefinition`;
- mostrar/seleccionar `FmeaRevision`;
- mostrar código, revisión, estado y condición de solo lectura;
- mostrar evidencia y supuestos de biblioteca;
- distinguir datos existentes e input humano;
- ejecutar el gate de preparación;
- producir una salida estructurada consumible por WS-02.

**P-101 no es el objeto principal de WS-01.** Aparece por primera vez como aplicación concreta en WS-07.

No se implementará WS-02 hasta validar WS-01 en Power Apps Studio.

## Límite

El laboratorio no debe presentarse como:

- aplicación productiva;
- diseño final de pantallas;
- decisión de base de datos;
- definición de APIs;
- integración final con el CMMS existente;
- definición aprobada de matrices, umbrales, criticidad, roles o fórmulas todavía `to_validate`.
