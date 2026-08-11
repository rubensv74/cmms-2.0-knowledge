# CMMS 2.0 Knowledge Repository

Repositorio de conocimiento funcional del programa CMMS 2.0 y fuente de verdad del **CMMS 2.0 Functional Lab**.

## Objetivo

Mantener una fuente trazable para:

- visión del producto;
- decisiones y reuniones;
- modelo funcional;
- reglas de negocio;
- modelo conceptual de datos;
- prototipos y evidencias históricas;
- Functional Lab en Power Apps;
- documentación funcional modular para IT.

## Fase actual

El proyecto está pasando de prototipos HTML conceptuales a un **laboratorio funcional ejecutable en Power Apps**.

Tras la auditoría de agosto de 2026, el modelo canónico del dominio AMEF/RCM es library-first:

```text
Engineering Library
→ Asset Application
→ Execution Plan
→ Results & Learning
```

El laboratorio no representa la arquitectura productiva final. Se utiliza para validar qué información necesita cada proceso, qué pertenece a biblioteca y qué a un activo, qué calcula el sistema, qué recomienda, qué debe decidir una persona, qué gates existen y qué outputs estructurados se generan.

## Principios canónicos AMEF/RCM

1. `FmeaDefinition` es la identidad estable del conocimiento reusable.
2. `FmeaRevision` gobierna su contenido versionado; una publicada es inmutable.
3. Un activo consume una revisión mediante `FmeaAssetApplication`; no es padre del AMEF.
4. Riesgo AMEF y criticidad del activo son conceptos separados.
5. `MaintenanceTask` y `FailureMode` se relacionan N:M.
6. `MaintenanceProcedure` e `InspectionFormat` están separados de la tarea.
7. RCM puede terminar en tarea o en una decisión explícita sin tarea programada.
8. Economía de decisión, coste estimado y coste real son objetos distintos.
9. La trazabilidad debe sobrevivir desde la revisión de biblioteca hasta los resultados.

## Navegación rápida

- [Estado actual](PROJECT_STATUS.md)
- [Roadmap](ROADMAP.md)
- [Índice maestro](MASTER_INDEX.md)
- [Historial de cambios](CHANGELOG.md)
- [Auditoría/remediación de 14 desviaciones](00-governance/audits/2026-08-11-functional-lab-library-first-remediation.md)
- [Visión del Functional Lab](01-vision/cmms-functional-lab-vision.md)
- [Functional Journey v2](02-functional/process-model/functional-journey.md)
- [Persona vs sistema v2](02-functional/process-model/human-system-decisions.md)
- [Modelo conceptual AMEF/RCM](03-data-model/core/fmea-library-model.md)
- [Trazabilidad por capas](03-data-model/core/traceability-layers.md)
- [Functional Lab](06-ui-ux/functional-lab/README.md)
- [Paquete documental para IT](07-it-handoff/functional-document-set.md)

## Método de trabajo

El Functional Lab se desarrolla con el Protocolo de Implementación Incremental Asistida por IA utilizado en Pulse y adaptado a CMMS 2.0.

Regla central:

> Validar responsabilidad funcional y capa → confirmar contrato de datos → definir arquitectura de interacción → implementar una pieza → guardar → validar en Power Apps Studio → corregir → documentar → continuar.

No se avanza sobre errores abiertos.

## Principios del repositorio

1. Toda decisión relevante debe quedar documentada.
2. Las hipótesis se distinguen de requisitos validados.
3. Los recursos originales de `08-resources` no se modifican.
4. Los prototipos históricos se conservan como evidencia, no como fuente automática de requisitos.
5. JSON es la fuente canónica de los casos de ejemplo del Functional Lab, no una decisión de persistencia productiva.
6. El fixture canónico actual es `p101-case.v2.json`; v1 es legacy.
7. `03-data-model/` tiene precedencia sobre simplificaciones de UI o prototipos cuando exista conflicto conceptual.
8. `PROJECT_STATUS.md` debe reflejar el estado real del proyecto.
