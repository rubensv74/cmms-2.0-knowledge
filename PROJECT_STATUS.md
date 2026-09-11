# Estado del proyecto

**Última actualización:** 2026-09-11

## Estado general

CMMS 2.0 mantiene varias líneas funcionales gobernadas en paralelo:

1. **Reliability Engineering / Functional Lab** — journey RCM consolidado y revisado a v1.2.
2. **Maintenance Standards Library** — nuevo modelo funcional confirmado a nivel de principios; contratos detallados pendientes.
3. **Asset Experience Redefinition** — contratos AE consolidados; implementación física sujeta a gates runtime/Studio.
4. **Work Management Discovery** — AS-IS y frontera de ejecución documentados; todavía no es modelo TO-BE canónico.

Principio general:

```text
observe
→ model
→ contract
→ implement small
→ validate real tool
→ promote
```

No se considera validada una capacidad por existir únicamente como documento, mockup o código no probado.

---

# 1. Reliability Engineering / Functional Lab

## Cambio funcional 2026-09-11

La reunión con Hernando y Eduardo corrige una suposición importante:

> RCM no es el único camino para crear un plan de mantenimiento.

Modelo superior actual:

```text
Maintenance Engineering Sources
├── RCM specific engineering
├── Corporate Maintenance Standards
├── OEM / Vendor
└── Expert / historical experience
        ↓
Governed Project Maintenance Plan
        ↓
Work Management
```

### Journey RCM

El Functional Journey pasa a **v1.2**.

Principios consolidados:

- AMEF/FMEA forma parte del análisis RCM;
- RCM es árbol lógico, no scoring;
- P–F termina en fallo funcional, no necesariamente rotura física;
- estrategias mínimas: `TIME_BASED`, `CONDITION_BASED`, `RUN_TO_FAILURE`;
- un mismo equipo puede combinar estrategias;
- riesgo/criticidad sigue configurable por cliente/proyecto;
- P-101 permanece como caso de referencia de la ruta RCM.

### Granularidad de mantenimiento

Regla confirmada:

```text
Maintenance Activity        = unidad planificable / programable / cerrable
Job Plan                    = template reusable de preparación/ejecución
Procedure / Checklist       = detalle paso a paso
```

No debe crearse una actividad CMMS independiente por cada subpaso del checklist salvo regla funcional explícita.

### Workspaces

Los nueve workspaces del caso RCM se mantienen.

WS-05/06 deberán soportar en el futuro `sourceBasis` y provenance, sin asumir que toda actividad procede de RCM.

---

# 2. Maintenance Standards Library

**Estado:** functional model v0.1; principles confirmed; contracts `to_validate`.

Fuente:

- `02-functional/process-model/maintenance-standards-library.md`

Modelo:

```text
Historical plans / OEM / RCM / experience
→ Corporate Standard by Equipment Type
→ Project Adoption Snapshot
→ Project Tailoring
→ Published Project Maintenance Plan
```

## Principios confirmados

1. La biblioteca corporativa es baseline, no imposición inmutable.
2. El proyecto puede desactivar, modificar o añadir actividades/frecuencias.
3. El cambio local no modifica automáticamente el master.
4. El aprendizaje del proyecto puede volver mediante propuesta gobernada y nueva versión.
5. Todos los equipos pueden estar en CMMS; la criticidad cambia profundidad/estrategia, no existencia.
6. Equipos críticos/especiales pueden requerir RCM específico; otros pueden usar estándar/OEM/expert judgement.
7. `EquipmentTypeCode` es candidato natural para resolver estándares aplicables.

## Gates

```text
MSL-G01 Source normalization
MSL-G02 Core contracts
MSL-G03 Project adoption/versioning
MSL-G04 Corporate feedback loop
```

No crear una biblioteca demo ficticia antes de MSL-G01/MSL-G02.

## Fuente real candidata

Durante la reunión se mostraron planes históricos para tipos como gas detector, gas turbine y pressure safety valve, con frecuencias, Job Plans, operations, recursos y herramientas.

Esos documentos son evidencia y posible seed del master, pero todavía deben registrarse/normalizarse antes de ser fixtures o datos canónicos.

---

# 3. Functional Lab — impacto de demo

## P-101

P-101 se conserva como RCM Engineering case.

No debe transformarse en ejemplo de biblioteca estándar.

## Segundo tipo de caso futuro

Después de MSL-G01/MSL-G02:

```text
Equipment Type
→ Corporate Standard candidate
→ inspect version/source
→ adopt project snapshot
→ disable / modify / add
→ compare master vs project
→ publish
```

Documento:

- `06-ui-ux/functional-lab/maintenance-standards-extension.md`

No se añade automáticamente un `WS-10`. La biblioteca probablemente necesite una superficie propia tipo Configuration Studio / Library Explorer, pendiente de contrato UX.

---

# 4. Asset Experience Redefinition

Se mantiene el estado consolidado anterior.

## AE-0

`COMPLETE / AE-G0 PASS`.

## AE-1

`COMPLETE / AE-G1 PASS_WITH_DEFERRED_ITEMS`.

Contratos principales:

- `02-functional/asset-master/CMMS_ASSET_EXPERIENCE_CONTRACT_V1.md`;
- `02-functional/asset-master/CMMS_ASSET_DETAIL_READ_CONTRACT_V1.md`.

## AE-2

`COMPLETE / AE-G2 PASS_CONTRACT`.

## AE-3

`CONTRACT COMPLETE / PHYSICAL VALIDATION PENDING`.

## AE-4

`COMPLETE / AE-G4 PASS_CONTRACT`.

Superficies:

```text
AS-01 Assets List
AS-02 Asset Detail
AS-03 Asset Create/Edit
AS-04 Equipment Type Library
```

## AE-5

`CONTRACT PASS / RUNTIME HOLD` para consumo de AssetPlan Industrial Technical 3D.

## AE-6

Primer consumer previsto: `AS-02 Asset Detail`, sujeto a gates runtime/Studio activos.

La revisión 2026-09-11 añade una conexión conceptual útil:

```text
Asset.EquipmentTypeCode
→ candidate Corporate Maintenance Standard
```

pero no modifica los contratos Asset Experience actuales hasta disponer del contrato MSL correspondiente.

---

# 5. Work Management Discovery

`work-management-discovery.md` pasa a discovery **v0.2**.

AS-IS inicial:

```text
Plan / calendario
→ trabajo próximo
→ Planner
→ propuesta WO
→ Maintenance Responsible
→ Supervisor opcional
→ Technician
→ ejecución
```

Nuevo principio confirmado 2026-09-11:

```text
Work Candidate / WO
→ Scheduled Maintenance Activity
   └── JobPlan / ProcedureChecklist
```

No:

```text
checklist step
→ work candidate independiente por defecto
```

## Gates

### WM-G01

Observar flujo real, actores, estados y excepciones.

### WM-G02

Normalizar contenido operativo y cerrar:

```text
Activity ↔ JobPlan ↔ ProcedureChecklist ↔ Execution Result
```

La reunión 2026-09-11 aporta evidencia, pero **WM-G02 sigue abierto**.

### WM-G03

Planning/scheduling: horizonte, agrupación, ventanas, reprogramación, capacidad, turnos y assignment.

### WM-G04

Costes/contratos/facturación con perfiles responsables.

---

# 6. Próximos gates funcionales

Orden recomendado:

```text
MSL-G01 — normalizar una fuente real
→ MSL-G02 — cerrar core contracts
→ seleccionar fixture real de standard adoption
→ decidir superficie UX de library
→ gate Studio incremental
```

En paralelo, el journey P-101/RCM puede continuar siguiendo sus gates propios sin esperar a completar toda la biblioteca corporativa, siempre que el runtime no hardcodee `sourceBasis = RCM` como única posibilidad.

---

# 7. Riesgos principales

- tratar RCM como única fuente de planes;
- confundir AMEF y RCM como procesos desconectados;
- confundir fallo funcional con rotura física;
- convertir cada checklist step en actividad CMMS;
- mezclar Job Plan, procedimiento y WO sin contrato;
- copiar planes históricos sin provenance/versionado;
- permitir que project overrides muten el master;
- promover aprendizajes al master sin governance;
- hardcodear una frecuencia estándar como universal;
- aplicar automáticamente un estándar por Equipment Type sin validación humana;
- inventar un fixture de biblioteca antes de normalizar una fuente real;
- convertir AS-IS de Work Management en TO-BE sin validación;
- implementar superficies Power Apps antes de sus gates funcionales/runtime.

---

# 8. Fuentes de verdad principales

- `ROADMAP.md`
- `02-functional/process-model/functional-journey.md`
- `02-functional/process-model/human-system-decisions.md`
- `02-functional/process-model/maintenance-standards-library.md`
- `02-functional/process-model/work-management-discovery.md`
- `05-meetings/2026/2026-09-11_revision-cmms-estandares-job-plans.md`
- `05-meetings/01_Analysis/ANL-004_revision-funcional-post-reunion-2026-09-11.md`
- `06-ui-ux/functional-lab/architecture.md`
- `06-ui-ux/functional-lab/implementation-status.md`
- `06-ui-ux/functional-lab/maintenance-standards-extension.md`
- `02-functional/asset-master/CMMS_ASSET_EXPERIENCE_CONTRACT_V1.md`
- `06-ui-ux/CMMS_ASSET_SCREEN_ARCHITECTURE_V1.md`
