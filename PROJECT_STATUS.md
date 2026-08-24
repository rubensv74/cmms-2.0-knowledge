# Estado del proyecto

**Última actualización:** 2026-08-24

## Estado general

CMMS 2.0 continúa en fase **Functional Lab**, con tres líneas gobernadas en paralelo:

1. **AMEF + RCM / Functional Lab** — foundation conceptual consolidada y siguiente gate técnico en Power Apps real.
2. **Asset Experience Redefinition** — contratos AE-0 a AE-4 cerrados; AE-5 preparado y detenido en runtime gate real.
3. **Work Management Discovery** — AS-IS inicial documentado; todavía no es modelo TO-BE ni workspace canónico.

El principio general sigue siendo:

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

# 1. Functional Lab — AMEF + RCM

## Foundation completada

- auditoría de transición;
- protocolo incremental;
- visión y límites;
- Functional Journey AMEF + RCM de 28 etapas / 9 workspaces;
- matriz persona vs sistema;
- contratos JSON base;
- fixture P-101 v1.1;
- arquitectura conceptual;
- paquete documental para IT;
- revisiones funcionales 2026-08-14 y 2026-08-21;
- discovery inicial de Gestión del Trabajo.

## Power Apps Foundation — estado

`F01-00` sigue pendiente de cierre en herramienta real.

Debe confirmarse en la Canvas app:

- Source Code/schema aceptado;
- controles y versiones reales;
- baseline App Checker;
- componentes premium disponibles/instalados;
- Premium App Shell Foundation;
- baseline visual real.

Siguiente secuencia:

```text
F01-01 Premium App Shell
→ F01-02 runtime state
→ F01-03 P-101 v1.1 adapter
→ F01-04 navigation
→ F01-05..09 WS-01 + validation/hardening
```

No iniciar WS-02 antes del gate real de WS-01.

## Gates funcionales ya identificados

- antes de WS-03: contrato `RiskProfile`;
- antes de WS-04: árbol RCM sin scoring;
- antes de WS-06: `BasePlan`, `CandidateAssets`, `ApplicabilityDecision`, `AssetPlanOverride` y agrupación;
- antes de cerrar WS-08: `PublishedPlanVersion` preparado para handoff operacional.

---

# 2. Asset Experience Redefinition

## Decisiones canónicas

1. `Assets` se considera una superficie nuclear y debe evolucionar hacia un Object 360 técnico/operativo.
2. Se revisan iconografía, jerarquía visual y componentes premium como sistema compartido.
3. CMMS no crea una biblioteca 3D propia; consume `AssetPlan Industrial Technical 3D` como fuente visual externa gobernada.

Documento de gobierno:

- `06-ui-ux/CMMS_ASSET_EXPERIENCE_REDEFINITION_V1.md`.

## AE-0 — Baseline y auditoría

**Estado:** `COMPLETE / AE-G0 PASS`.

Resultado principal:

- no existe todavía una pantalla Assets productiva que deba retocarse;
- existen dos prototipos conceptuales valiosos: Asset Model y ADR;
- FLH / Taxonomy / ADR, `EquipmentTypeCode`, composición física, ubicación y criticidad se conservan;
- el shell/wizard visual histórico se retira como baseline;
- iconografía CMMS actual se conserva y se extiende;
- gaps de Technical Profile, provenance, Engineering/Visual Context y Maintenance Summary quedan identificados.

Evidencia:

- `06-ui-ux/audits/2026-08-24_AE0_ASSETS_CURRENT_STATE_AUDIT.md`.

## AE-1 — Asset Experience Contract

**Estado:** `COMPLETE / AE-G1 PASS_WITH_DEFERRED_ITEMS`.

Contratos definidos:

```text
Asset Identity
Equipment Type
Technical Field Definition
Technical Field Unit
Equipment Type applicability
Asset Technical Value
Provenance / authority
Override / freshness
Engineering Context
Visual Context
Maintenance Summary read model
```

Decisiones importantes:

- CMMS no copia `PreservationAttributeCatalog` de AssetPlan;
- se reutiliza el patrón conceptual Technical Fields, no su binding físico de Rules;
- Manufacturer / Model / Serial usan authority policy por integración/proyecto;
- `Maintenance Summary` es read model;
- `HealthIndex` no forma parte de V1;
- `Model Template` queda `DEFERRED` hasta demostrar necesidad real.

Fuente:

- `02-functional/asset-master/CMMS_ASSET_EXPERIENCE_CONTRACT_V1.md`.

## AE-2 — Asset Visual System

**Estado:** `COMPLETE / AE-G2 PASS_CONTRACT`.

Definido:

- jerarquía N0–N4 aplicada a Assets;
- Object 360 / Data Explorer / Configuration Studio como arquetipos;
- extensión del icon system CMMS sin segundo estilo;
- Equipment Type icons y Technical Attribute icons como gaps gobernados;
- provenance/freshness visual grammar;
- Technical Value grammar;
- separación `Type Illustration / Model Image / Asset Photo`;
- criticality visual configurable;
- estados `READY / LOADING / EMPTY / UNAVAILABLE / STALE / ERROR / BLOCKED`.

Guardrail nuevo:

```text
PNG con apariencia 3D != visor 3D interactivo
```

No mostrar `Rotate / Explode / Orbit` sobre las ilustraciones estáticas actuales.

Fuente:

- `06-ui-ux/CMMS_ASSET_VISUAL_SYSTEM_V1.md`.

## AE-3 — Premium Components

**Estado:** `DESIGN BASELINE COMPLETE / AE-G3 CONTRACT PASS / PHYSICAL VALIDATION PENDING`.

Candidatos compartidos:

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

Adaptation candidates:

```text
PageHeader
StatePanel
FilterBar
DataGrid
ActionButton
IconPro
```

Todos permanecen `TO_VALIDATE_CMMS` hasta existir en la app real.

Fuente:

- `06-ui-ux/CMMS_ASSET_PREMIUM_COMPONENTS_V1.md`.

## AE-4 — Screen Architecture

**Estado:** `COMPLETE / AE-G4 PASS_CONTRACT`.

Superficies V1:

```text
AS-01 Assets List              = Data Explorer
AS-02 Asset Detail             = Object 360
AS-03 Asset Create / Edit      = Governed Form
AS-04 Equipment Type Library   = Configuration Studio
```

Decisiones:

- `Visual Mapping` vive dentro de Equipment Type Library;
- no crear Standalone Visual Library V1;
- no crear Model Template screen mientras el concepto siga diferido;
- implementar Asset Detail antes de Assets List para fijar el destino y lenguaje Object 360.

Fuente:

- `06-ui-ux/CMMS_ASSET_SCREEN_ARCHITECTURE_V1.md`.

## AE-5 — AssetPlan 3D consumption

**Estado:** `CONTRACT PASS / RUNTIME HOLD`.

Fuente externa real observada:

```text
AssetPlan Industrial Technical 3D
183 PNG
PNG RGBA
transparent
max 384 px
target <200 KB
hard limit <250 KB
BASELINE_CLOSED
```

Contrato definido:

```text
EquipmentTypeCode
→ VisualProvider
→ AssetKey
→ controlled runtime distribution
```

Estrategia inicial recomendada para Canvas app:

```text
controlled Media snapshot
```

solo del subconjunto realmente mapeado, manteniendo AssetPlan como master source.

### Gate real actual — AE-G5 runtime

Pendiente ejecutar en la Canvas app:

- importar subset representativo;
- renderizar varios tipos;
- medir impacto de tamaño/carga;
- validar fallback;
- comprobar sourceVersion/rebuild;
- save/close/reopen;
- smoke/App Checker cuando proceda.

Hasta ese PASS:

```text
AE-6 PRODUCTIVE IMPLEMENTATION = HOLD
```

Fuente:

- `06-ui-ux/CMMS_ASSETPLAN_3D_CONSUMPTION_CONTRACT_V1.md`.

## Siguiente acción Asset Experience

Preparar el primer baseline Power Apps de `AS-02 Asset Detail` con un subconjunto visual representativo y ejecutar `AE-G5` junto con el Premium App Shell/Studio foundation cuando la Canvas app esté disponible.

No seguir generando documentación downstream como si el runtime gate hubiera pasado.

---

# 3. Work Management Discovery

La reunión 2026-08-21 aporta AS-IS de referencia:

```text
Plan / calendario preventivo
→ inspecciones próximas
→ Maintenance Planner
→ propuesta WO
→ Maintenance Responsible
→ Supervisor opcional
→ Technician / Executor
→ ejecución
```

Permanece `to_validate`.

## Gates

### WM-G01 — Demo del proceso real

Revisar actores, secuencia, estados, decisiones y excepciones.

### WM-G02 — Check sheets reales

Separar:

```text
tarea
procedimiento/checklist
work order
feedback de ejecución
```

### WM-G03 — Planning/Scheduling

Validar horizonte, agrupación, ventanas, reprogramación, capacidad, turnos, asignación y routing.

### WM-G04 — Costes y contratos

Abrir detalle únicamente con conocimiento de responsables de Contratos/Subcontratos.

---

# 4. Riesgos principales

- convertir AS-IS de una instalación en TO-BE sin validación;
- hardcodear routing organizativo;
- inventar planning/scheduling;
- confundir tarea, procedimiento y WO;
- crear componentes visuales locales donde existe patrón compartido;
- copiar físicamente patrones AssetPlan ligados a Preservation;
- convertir CMMS en segundo maestro de ingeniería;
- duplicar la biblioteca 3D;
- presentar una Type Illustration como CAD/BIM/modelo interactivo;
- mostrar datos `UNAVAILABLE` como cero/blank válido;
- implementar Asset Detail productivo antes de runtime/Studio gates.

---

# 5. Fuentes de verdad principales

- `ROADMAP.md`
- `00-governance/cmms-functional-lab-incremental-protocol.md`
- `02-functional/process-model/functional-journey.md`
- `02-functional/process-model/human-system-decisions.md`
- `02-functional/process-model/work-management-discovery.md`
- `02-functional/asset-master/CMMS_ASSET_EXPERIENCE_CONTRACT_V1.md`
- `06-ui-ux/CMMS_ASSET_EXPERIENCE_REDEFINITION_V1.md`
- `06-ui-ux/audits/2026-08-24_AE0_ASSETS_CURRENT_STATE_AUDIT.md`
- `06-ui-ux/CMMS_ASSET_VISUAL_SYSTEM_V1.md`
- `06-ui-ux/CMMS_ASSET_PREMIUM_COMPONENTS_V1.md`
- `06-ui-ux/CMMS_ASSET_SCREEN_ARCHITECTURE_V1.md`
- `06-ui-ux/CMMS_ASSETPLAN_3D_CONSUMPTION_CONTRACT_V1.md`
- `06-ui-ux/CMMS_COMPONENT_CATALOG_V1.md`
- `06-ui-ux/branding/README.md`
- `06-ui-ux/functional-lab/architecture.md`
- `06-ui-ux/functional-lab/design-system.md`
