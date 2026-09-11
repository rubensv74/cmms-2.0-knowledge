# CMMS Functional Lab — Maintenance Standards Extension

**Fecha:** 2026-09-11  
**Estado:** design discovery / no implementation  
**Fuente:** [`../../05-meetings/2026/2026-09-11_revision-cmms-estandares-job-plans.md`](../../05-meetings/2026/2026-09-11_revision-cmms-estandares-job-plans.md)

## 1. Objetivo

Definir cómo debe evolucionar CMMS Functional Lab para demostrar que un plan de mantenimiento puede originarse tanto en un RCM específico como en un estándar corporativo reutilizable.

No autoriza todavía nuevas pantallas Power Apps ni un fixture inventado.

## 2. Dos tipos de experiencia

### Experience A — RCM Engineering

Caso actual P-101:

```text
Asset / context
→ functions / failures / effects
→ risk
→ RCM decision
→ task / interval
→ resources / applicability
→ publication
```

P-101 se mantiene como caso pedagógico de ingeniería específica.

### Experience B — Corporate Standard Adoption

Caso futuro basado en fuente real normalizada:

```text
Equipment Type
→ find suggested Corporate Standard
→ inspect version / source
→ adopt into project
→ review activities/frequencies/resources
→ disable / modify / add
→ compare master vs project
→ approve Project Plan Version
```

## 3. Regla de demo

El laboratorio debe hacer visible el origen de cada tarea:

```text
sourceBasis = RCM | CORPORATE_STANDARD | OEM | EXPERT
sourceReference
sourceVersion
projectChangeType
changeReason
```

Nunca debe presentar una actividad estándar como “resultado RCM” si no lo es.

## 4. Granularidad visual

La demo debe distinguir tres niveles:

### Level 1 — Maintenance Activity

Unidad que se planifica y termina generando trabajo.

Ejemplo conceptual:

```text
Annual Gas Detector Maintenance
```

### Level 2 — Job Plan

Template reusable de preparación/ejecución, con recursos y referencias operativas.

### Level 3 — Procedure / Checklist

Detalle paso a paso.

La UX no debe representar cada checklist step como una actividad del plan.

## 5. Patrón visual candidato

Cuando exista un fixture real, una vista de estándar debería poder mostrar:

```text
┌ Corporate Standard ─────────────────────────────┐
│ Equipment Type: ...                            │
│ Version: ...       Source: ...                 │
│                                                 │
│ Activities                                      │
│ ✓ Monthly ...                                  │
│ ⊘ 6 Months ...        Not applicable in project│
│ ~ 1 Year ...          Frequency adjusted       │
│ ✓ 3 Years ...                                  │
│ + Project-specific activity                     │
└─────────────────────────────────────────────────┘

Master baseline  ← compare →  Project version
```

El símbolo exacto, layout y controles deberán seguir el estándar premium vigente; este esquema solo expresa comportamiento funcional.

## 6. Impacto sobre workspaces actuales

### WS-05 — Economía y tarea

Debe admitir que una tarea sea:

- creada desde RCM;
- seleccionada desde una biblioteca;
- derivada de OEM;
- ajustada por especialista.

### WS-06 — Recursos y alcance

Debe mostrar:

- estándar de origen;
- Job Plan asociado;
- recursos baseline;
- frecuencia baseline;
- project override;
- applicability;
- diferencia frente al maestro.

### WS-07 / WS-08

La trazabilidad y publicación deben conservar:

```text
masterVersion
projectAdoptionVersion
projectOverrides
approval
publishedProjectPlanVersion
```

## 7. Capacidad adicional probable

La Maintenance Standards Library probablemente necesitará una superficie propia de administración/ingeniería, separada del recorrido P-101.

Arquetipo candidato:

```text
Configuration Studio / Library Explorer
```

Posibles trabajos:

- buscar por Equipment Type;
- explorar versiones;
- comparar estándares;
- revisar provenance;
- editar draft corporativo;
- revisar change proposals;
- publicar nueva versión.

Esto sigue `to_validate`; no se añade todavía al mapa de pantallas V1.

## 8. Fixture futuro

No crear un caso sintético que imite los archivos mostrados en la reunión.

Gate previo:

```text
MSL-G01 Source normalization PASS
```

Después se seleccionará un ejemplo real normalizado —por ejemplo uno de los tipos de equipo mostrados— y se eliminará cualquier información sensible o específica que no deba formar parte del fixture.

## 9. Runtime state futuro

La foundation debe poder soportar conceptualmente:

```text
MaintenanceSource
CorporateStandardVersion
ProjectAdoption
ProjectOverrides
JobPlanReference
ProcedureReference
ResourceRequirements
```

No es necesario implementar esas colecciones durante WS-01, pero no debe diseñarse un runtime que asuma que toda tarea procede de RCM.

## 10. Gate de implementación

No iniciar una extensión Power Apps de biblioteca hasta disponer de:

1. `MSL-G01` — fuente real normalizada;
2. `MSL-G02` — contrato mínimo de standard/task/JobPlan/procedure/resources;
3. decisión de superficie UX;
4. fixture versionado;
5. gate de Studio equivalente al protocolo incremental activo.
