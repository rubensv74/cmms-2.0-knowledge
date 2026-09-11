# Functional Lab — Implementation Status

**Fecha:** 2026-09-11  
**Estado general:** RCM foundation revisada a v1.2 + Maintenance Standards discovery incorporado  
**Último gate documental superado:** revisión funcional posterior a reunión 2026-09-11  
**Validación Power Apps del journey RCM:** pendiente de los gates técnicos activos del laboratorio

## 1. Estado de incrementos documentales

| Incremento | Estado | Resultado |
|---|---|---|
| F00-01..09 Foundation inicial | completed | Journey, contratos, fixture P-101, arquitectura y handoff definidos. |
| F00-10 Revisión 2026-08-14 | completed | Riesgo configurable, RCM sin scoring, overrides y handoff anual. |
| F00-11 Revisión 2026-08-21 | completed | Work Management discovery y routing organizativo configurable. |
| F00-12 Revisión 2026-09-11 | completed | RCM deja de ser ruta única; biblioteca corporativa, task granularity y Job Plan/procedure incorporados. |

## 2. Cambios confirmados 2026-09-11

### 2.1. Dos rutas de Maintenance Engineering

```text
RCM specific engineering
OR
Corporate Standard adoption
        ↓
Project Maintenance Plan
```

P-101 continúa representando la ruta RCM.

### 2.2. Maintenance Standards Library

Nuevo modelo funcional:

- [`../../02-functional/process-model/maintenance-standards-library.md`](../../02-functional/process-model/maintenance-standards-library.md)

Gates:

```text
MSL-G01 Source normalization
MSL-G02 Core contracts
MSL-G03 Project adoption/versioning
MSL-G04 Corporate feedback loop
```

### 2.3. Activity granularity

El laboratorio debe respetar:

```text
Maintenance Activity        = unidad planificable/cerrable
Job Plan                    = template reusable
Procedure / Checklist       = detalle paso a paso
```

No se modelará cada checklist step como actividad independiente por defecto.

### 2.4. RCM / AMEF

La experiencia RCM debe dejar claro que AMEF/FMEA forma parte del análisis RCM.

### 2.5. P–F

Cuando se demuestre P–F:

```text
P = detectable potential failure
F = functional failure threshold
```

No se equipara F a rotura física.

## 3. Impacto sobre P-101

P-101 **no se sustituye ni se transforma en estándar corporativo**.

Se conserva porque permite validar:

- funciones/fallos/modos;
- efectos/riesgo;
- árbol RCM;
- P–F;
- estrategia;
- actividad y frecuencia;
- recursos;
- publicación.

Sí debe evolucionar conceptualmente para conservar `sourceBasis = RCM` cuando el contrato runtime correspondiente exista.

No se modifica el fixture solo para añadir campos sin contrato.

## 4. Segundo tipo de experiencia futura

Debe prepararse después de MSL-G01/MSL-G02 un caso real normalizado:

```text
Equipment Type
→ suggested Corporate Standard
→ version/source
→ adopt into project
→ disable / modify / add
→ compare master vs project
→ publish
```

No se crea fixture sintético a partir de memoria de la reunión.

Documento UX/discovery:

- [`maintenance-standards-extension.md`](maintenance-standards-extension.md)

## 5. Workspaces afectados

### WS-05

Debe admitir `sourceBasis` distinto de RCM.

### WS-06

Debe soportar conceptualmente:

- Job Plan;
- Procedure/Checklist reference;
- resource baseline;
- corporate standard version;
- project override;
- applicability.

### WS-07 / WS-08

Deben conservar provenance y version lineage hasta `PublishedProjectPlanVersion`.

## 6. No se añade WS-10 todavía

La Maintenance Standards Library probablemente requiera una superficie propia tipo Configuration Studio / Library Explorer.

Estado: `to_validate`.

No añadir una pantalla únicamente porque el concepto exista en documentación.

## 7. Relación con Work Management

`work-management-discovery.md` avanza a v0.2.

Regla nueva confirmada:

```text
Work Candidate / WO
→ Maintenance Activity
   └── references Job Plan / Procedure Checklist
```

WM-G02 sigue abierto hasta normalizar fuentes y cerrar el execution package.

## 8. Gates de workspaces RCM

### Antes de WS-03

Contrato mínimo `RiskProfile`.

### Antes de WS-04

Contrato de árbol RCM sin scoring.

### Antes de WS-06

Contratos mínimos para:

- plan/base standard;
- CandidateAssets;
- ApplicabilityDecision;
- Project/Asset Override;
- JobPlan/Procedure reference.

### Antes de cerrar WS-08

Output versionado con provenance y handoff hacia preventivas/work management.

## 9. Gates Maintenance Standards

### MSL-G01

Normalizar al menos una fuente real mostrada/compartida por el equipo.

### MSL-G02

Cerrar:

```text
EquipmentTypeStandard
StandardPlanVersion
StandardMaintenanceActivity
JobPlan
ProcedureChecklist
ResourceRequirement
Frequency
SourceReference
```

### MSL-G03

Validar master → project snapshot → override → published project version.

### MSL-G04

Validar project learning → change proposal → corporate review → new master version.

## 10. Regla de continuidad

> No implementar como comportamiento aprobado lo que siga marcado como discovery o `to_validate`.

> No crear un segundo fixture de Maintenance Standards hasta disponer de una fuente real normalizada y contrato mínimo.

> La foundation debe evitar asumir que toda tarea procede de RCM.
