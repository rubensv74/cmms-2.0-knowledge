# Roadmap CMMS 2.0

**Última revisión:** 2026-08-24

## 1. Cómo leer este roadmap

Este documento separa:

1. **mapa funcional del producto** — capacidades que CMMS 2.0 debe cubrir;
2. **roadmap de validación** — orden en el que aprendemos, probamos y consolidamos esas capacidades.

Que un dominio se estudie antes no significa necesariamente que se implemente antes en producción.

---

# 2. Mapa funcional del producto

## A. Fundamentos de activos

- visión del producto;
- jerarquía funcional FLH;
- taxonomía corporativa;
- modelo de activos;
- registro de activos físicos;
- contexto operacional;
- criticidad configurable por proyecto/cliente;
- Asset Technical Profile;
- Technical Fields dinámicos por Equipment Type;
- contexto de ingeniería y provenance;
- contexto visual `Type Illustration / Model Image / Asset Photo`;
- reutilización de la colección técnica 3D gobernada por AssetPlan, sin crear una segunda biblioteca CMMS.

**Madurez conceptual:** alta en FLH/Taxonomía/ADR y Asset Experience V1. La implementación Power Apps sigue pendiente de runtime gates.

Fuentes canónicas:

- `02-functional/asset-master/CMMS_ASSET_EXPERIENCE_CONTRACT_V1.md`
- `06-ui-ux/CMMS_ASSET_EXPERIENCE_REDEFINITION_V1.md`
- `06-ui-ux/CMMS_ASSET_SCREEN_ARCHITECTURE_V1.md`

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

**Madurez conceptual:** alta en AMEF/RCM respecto del resto del programa. Procedimientos/checklists y reglas exactas de agrupación siguen pendientes.

## C. Gestión del trabajo

- handoff desde plan publicado;
- generación anual de preventivas;
- calendario preventivo;
- work candidates;
- planificación;
- validación/reprogramación;
- programación;
- routing organizativo;
- asignación de ejecutores;
- work orders;
- ejecución;
- feedback de campo;
- inspecciones;
- cierre técnico.

**Madurez conceptual:** discovery inicial.

La reunión 2026-08-21 aporta un primer AS-IS de referencia:

```text
Plan / calendario
→ inspecciones próximas
→ Planner
→ propuesta WO
→ Maintenance Responsible
→ Supervisor opcional
→ Technician / Executor
→ ejecución
```

Este flujo permanece `to_validate` y debe contrastarse con la demo y check sheets de Los Barrios antes de convertirse en modelo objetivo.

Documento de referencia:

- `02-functional/process-model/work-management-discovery.md`

## D. Gestión económica y empresarial

- centros de coste y contexto presupuestario;
- costes reales de mantenimiento;
- materiales y servicios;
- partidas de contrato/subcontrato;
- facturación cuando aplique;
- reporting;
- KPIs;
- integraciones corporativas;
- roles y seguridad.

**Madurez conceptual:** temprana / parcial.

La relación WO → coste → contrato/subcontrato → facturación sigue abierta y requiere incorporar conocimiento de perfiles responsables.

---

# 3. Roadmap de validación funcional

## Fase FL-0 — Foundation

**Estado:** completada documentalmente y revisada con reuniones de 2026-08-14 y 2026-08-21.

- auditoría de transición;
- protocolo incremental;
- visión del Functional Lab;
- Functional Journey de 28 etapas;
- matriz persona vs sistema;
- arquitectura del laboratorio;
- contratos JSON;
- fixture P-101;
- paquete documental para IT;
- revisión riesgo/RCM/aplicabilidad;
- apertura del discovery de Gestión del Trabajo.

## Fase FL-1 — Power Apps Foundation + WS-01

**Estado:** siguiente fase técnica.

1. cerrar auditoría en Power Apps real;
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

Gate previo: contrato mínimo `RiskProfile`.

- `WS-03 Efectos y riesgo`;
- validar escalas, rangos, cálculos, recomendaciones y gates;
- demostrar que la matriz procede de configuración.

## Fase FL-4 — Decisión RCM

Gate previo: contrato mínimo de árbol RCM.

- `WS-04 Decisión RCM`;
- representar preguntas, respuestas, evidencia y ramas sin scoring;
- hacer visibles factibilidad técnica y efectividad;
- separar recomendación del sistema y autoridad humana.

## Fase FL-5 — Tratamiento y plan

- `WS-05 Economía y tarea`;
- `WS-06 Recursos y alcance`;
- validar tareas, frecuencias, recursos y condiciones;
- validar agrupación;
- validar candidatos de aplicabilidad y overrides por activo.

Gate previo a WS-06:

- `BasePlan`;
- `CandidateAssets`;
- `ApplicabilityDecision`;
- `AssetPlanOverride`.

Caso pedagógico reservado: bomba con lubricación convencional frente a lubricación por neblina.

## Fase FL-6 — Gobernanza y handoff

- `WS-07 Trazabilidad y calidad`;
- `WS-08 Revisión y publicación`;
- validar approvals y snapshots;
- producir `PublishedPlanVersion`;
- mostrar handoff conceptual hacia preparación anual y Gestión del Trabajo.

La demo podrá mostrar:

```text
PublishedPlanVersion
→ Annual Preventive Preparation
→ Work Management (discovery / to_validate)
```

No se implementarán todavía reglas operativas de planning/scheduling.

## Fase FL-7 — Efectividad

- `WS-09 Efectividad y mejora`;
- cerrar el loop con datos reales simulados;
- abrir revisión sin sobrescribir versiones anteriores.

## Fase FL-8 — Consolidación AMEF/RCM para IT

- requisitos funcionales;
- reglas de negocio;
- modelo conceptual de datos;
- mapa de pantallas;
- roles y dependencias;
- preguntas de arquitectura;
- contrato de salida hacia Gestión del Trabajo.

## Fase FL-9 — Discovery de Gestión del Trabajo

**Estado:** iniciado documentalmente el 2026-08-21; todavía no es una fase de implementación Power Apps.

### WM-G01 — observar AS-IS

- demo de la aplicación actual de Los Barrios;
- actores;
- estados;
- decisiones;
- excepciones.

### WM-G02 — revisar contenido operativo

- hojas/check sheets reales;
- tarea vs procedimiento;
- procedimiento vs WO;
- feedback de ejecución.

### WM-G03 — validar planning/scheduling

- horizonte temporal;
- work candidates;
- agrupación;
- ventanas;
- reprogramación;
- capacidad;
- turnos;
- asignación;
- rutas organizativas configurables.

### Gate de salida FL-9

Solo cuando exista evidencia suficiente se decidirá:

- journey canónico de Gestión del Trabajo;
- nuevos workspaces del Functional Lab;
- contratos funcionales;
- fixture/caso de demostración.

## Fase FL-10 — Gestión económica

No iniciar diseño detallado hasta incorporar conocimiento de perfiles responsables de Contratos/Subcontratos.

Objetivo posterior:

```text
WO ejecutada
→ coste real
→ centro de coste / presupuesto
→ contrato / subcontrato
→ integración corporativa / facturación
```

---

# 4. Track transversal AE — Asset Experience Redefinition

**Estado actual:** `AE-0..AE-4 COMPLETE AT CONTRACT LEVEL / AE-5 RUNTIME HOLD`.

Este track no sustituye las fases FL. Revisa la foundation de activos y el sistema visual que utilizarán superficies presentes y futuras.

Secuencia:

```text
AE-0 Baseline y auditoría                 PASS
→ AE-1 Asset Experience Contract          PASS_WITH_DEFERRED_ITEMS
→ AE-2 Asset Visual System                PASS_CONTRACT
→ AE-3 Premium Component Contracts        PASS_CONTRACT / physical validation pending
→ AE-4 Screen Architecture                PASS_CONTRACT
→ AE-5 AssetPlan 3D Consumption           CONTRACT PASS / RUNTIME HOLD
→ AE-6 Incremental Power Apps             BLOCKED_BY_AE-G5 + Studio foundation
→ AE-7 Convergence                        FUTURE
```

## AE-0 — Baseline y auditoría

**Estado:** `COMPLETE / AE-G0 PASS`.

Conclusión:

- no existe Assets productivo que retocar;
- Asset Model + ADR son foundation funcional reusable;
- shell visual histórico se retira;
- gaps de Technical Profile/provenance/visual/engineering quedan localizados.

Fuente:

- `06-ui-ux/audits/2026-08-24_AE0_ASSETS_CURRENT_STATE_AUDIT.md`

## AE-1 — Contrato

**Estado:** `COMPLETE / AE-G1 PASS_WITH_DEFERRED_ITEMS`.

Cerrados:

- Asset Identity;
- Technical Field / Unit / Applicability / Value;
- authority/provenance;
- override/freshness;
- Engineering Context;
- Visual Context;
- Maintenance Summary read model.

Diferidos deliberadamente:

- Model Template;
- Health Index;
- repositorio documental concreto;
- tecnología API/SQL física;
- autoridad concreta Manufacturer/Model/Serial por integración.

Fuente:

- `02-functional/asset-master/CMMS_ASSET_EXPERIENCE_CONTRACT_V1.md`

## AE-2 — Sistema visual

**Estado:** `COMPLETE / AE-G2 PASS_CONTRACT`.

- jerarquía N0–N4;
- iconografía CMMS extendida, no reemplazada;
- provenance/freshness grammar;
- Type Illustration / Model Image / Asset Photo separados;
- `PNG 3D-look != interactive 3D viewer`;
- fake Rotate/Explode/Orbit prohibido.

Fuente:

- `06-ui-ux/CMMS_ASSET_VISUAL_SYSTEM_V1.md`

## AE-3 — Componentes premium

**Estado:** `CONTRACT COMPLETE / PHYSICAL VALIDATION PENDING`.

Shared candidates:

```text
AssetIdentityHero
TechnicalValue
TechnicalSpecificationGrid
ProvenanceBadge
EngineeringContextPanel
AssetVisualGallery
HierarchyPath
MaintenanceSummary
EquipmentTypeCard
```

Generic primitives deben adaptarse antes de recrearse.

Fuente:

- `06-ui-ux/CMMS_ASSET_PREMIUM_COMPONENTS_V1.md`

## AE-4 — Pantallas

**Estado:** `COMPLETE / AE-G4 PASS_CONTRACT`.

V1:

```text
AS-01 Assets List             Data Explorer
AS-02 Asset Detail            Object 360
AS-03 Asset Create/Edit       Governed Form
AS-04 Equipment Type Library  Configuration Studio
```

No V1:

```text
Standalone Visual Library = DO NOT CREATE
Model Template Detail      = DEFERRED
```

Orden recomendado:

```text
Asset Detail
→ Assets List
→ Technical Profile
→ Equipment Type Library
→ Engineering / Visuals
→ Create/Edit
→ Maintenance when source ready
```

Fuente:

- `06-ui-ux/CMMS_ASSET_SCREEN_ARCHITECTURE_V1.md`

## AE-5 — Reuso 3D

**Estado:** `CONTRACT PASS / AE-G5 RUNTIME HOLD`.

Fuente visual:

```text
AssetPlan Industrial Technical 3D
183 PNG
BASELINE_CLOSED
```

Mapping:

```text
EquipmentTypeCode
→ VisualProvider
→ AssetKey
→ controlled runtime distribution
```

Estrategia inicial recomendada:

```text
controlled Power Apps Media snapshot
```

solo para Equipment Types realmente mapeados.

### AE-G5 runtime — siguiente gate real

Requiere Canvas app:

1. importar subset representativo;
2. renderizar Asset Detail candidate;
3. medir app-size/carga;
4. validar fallback;
5. comprobar sourceVersion/rebuild;
6. save/close/reopen;
7. smoke/App Checker cuando aplique.

Hasta PASS:

```text
AE-6 PRODUCTIVE IMPLEMENTATION = HOLD
```

Fuente:

- `06-ui-ux/CMMS_ASSETPLAN_3D_CONSUMPTION_CONTRACT_V1.md`

## AE-6 — Implementación Power Apps

**Estado:** `HOLD`.

No avanzar como implementación productiva hasta:

```text
Premium App Shell Foundation available
+ AE-G5 runtime PASS
```

El primer target será `AS-02 Asset Detail` con subset visual controlado.

## AE-7 — Convergencia

**Estado:** `FUTURE`.

Retirar duplicaciones/legacy solo después de validar la nueva foundation en herramienta real.

---

# 5. Regla de continuidad

El siguiente dominio o implementación no se construirá porque “parezca lógico”.

Primero se observa, después se modela, después se valida y solo entonces se convierte en experiencia ejecutable.

Para Asset Experience, el siguiente paso ya no es más diseño documental: es **evidencia runtime de AE-G5 + Power Apps Foundation**.
