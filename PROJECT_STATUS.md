# Estado del proyecto

**Última actualización:** 2026-08-24

## Estado general

CMMS 2.0 continúa en fase **Functional Lab**, con tres líneas gobernadas en paralelo:

1. **AMEF + RCM / Functional Lab** — foundation conceptual consolidada y siguiente gate técnico en Power Apps real.
2. **Asset Experience Redefinition** — AE-0 a AE-4 cerrados por contrato; AE-5 definido y pendiente de runtime; AE6-S01 preparado hasta el gate real de Studio.
3. **Work Management Discovery** — AS-IS inicial documentado; todavía no es modelo TO-BE ni workspace canónico.

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

## Power Apps Foundation

`F01-00` sigue pendiente de cierre en herramienta real.

Debe confirmarse en la Canvas app:

- Source Code/schema aceptado;
- authoring locale;
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

---

# 2. Asset Experience Redefinition

## Decisiones canónicas

1. `Assets` es una superficie nuclear y evoluciona hacia un Object 360 técnico/operativo.
2. Iconografía, jerarquía y componentes premium se gobiernan como sistema compartido.
3. CMMS no crea una biblioteca 3D propia; consume `AssetPlan Industrial Technical 3D` como fuente visual externa gobernada.
4. La UI consume un read model resuelto; no decide autoridad, applicability, unidad, provenance ni conflictos.

Documento de gobierno:

- `06-ui-ux/CMMS_ASSET_EXPERIENCE_REDEFINITION_V1.md`.

## AE-0 — Baseline y auditoría

**Estado:** `COMPLETE / AE-G0 PASS`.

Resultado:

- no existe una pantalla Assets productiva que deba retocarse;
- Asset Model y ADR históricos conservan valor funcional;
- FLH / Taxonomy / ADR, `EquipmentTypeCode`, composición física, ubicación y criticidad se conservan;
- el wizard visual histórico no es baseline premium;
- gaps de Technical Profile, provenance, Engineering/Visual Context y Maintenance Summary identificados.

Fuente:

- `06-ui-ux/audits/2026-08-24_AE0_ASSETS_CURRENT_STATE_AUDIT.md`.

## AE-1 — Asset Experience Contract

**Estado:** `COMPLETE / AE-G1 PASS_WITH_DEFERRED_ITEMS`.

Definidos:

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

Decisiones:

- CMMS no copia `PreservationAttributeCatalog` de AssetPlan;
- Manufacturer / Model / Serial usan authority policy por integración/proyecto;
- `Maintenance Summary` es read model;
- `HealthIndex` no entra en V1;
- `Model Template` queda DEFERRED.

Fuentes:

- `02-functional/asset-master/CMMS_ASSET_EXPERIENCE_CONTRACT_V1.md`;
- `02-functional/asset-master/CMMS_ASSET_DETAIL_READ_CONTRACT_V1.md`.

## AE-2 — Asset Visual System

**Estado:** `COMPLETE / AE-G2 PASS_CONTRACT`.

Definido:

- jerarquía N0–N4;
- Object 360 / Data Explorer / Configuration Studio;
- extensión del icon system CMMS;
- provenance/freshness grammar;
- Technical Value grammar;
- `Type Illustration / Model Image / Asset Photo`;
- estados `READY / LOADING / EMPTY / UNAVAILABLE / STALE / ERROR / BLOCKED`.

Guardrail:

```text
PNG con apariencia 3D != visor 3D interactivo
```

Fuente:

- `06-ui-ux/CMMS_ASSET_VISUAL_SYSTEM_V1.md`.

## AE-3 — Premium Components

**Estado:** `DESIGN BASELINE COMPLETE / AE-G3 CONTRACT PASS / PHYSICAL VALIDATION PENDING`.

Componentes Asset Experience definidos:

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

Auditoría de source real AssetPlan completada para AE6:

```text
PageHeader source SHA  f751f828f2cf99ab8150f5ee43f94774283d3af0
ActionButton source    6407ed46af2ccc0566a734203764b1d4ff031d94
StatePanel source      2e2878291ec3053db16f3e8c459c17774abafc38
IconPro source         1023c60b98e1cb465d4f6f86edc929a4c0163a68
```

Hallazgos:

- PageHeader debe eliminar breadcrumbs/status/acoplamiento AP antes de CMMS;
- ActionButton es baseline de alto valor y conserva `IsBusy`/lock visual;
- StatePanel requiere añadir `STALE` y `BLOCKED`;
- IconPro debe desacoplarse del `Switch()` de Media AP y usar resolver CMMS.

Fuentes:

- `06-ui-ux/CMMS_ASSET_PREMIUM_COMPONENTS_V1.md`;
- `06-ui-ux/audits/2026-08-24_AE6_COMPONENT_ADAPTATION_BASELINE.md`.

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

- Visual Mapping vive dentro de Equipment Type Library;
- no Standalone Visual Library V1;
- no Model Template screen mientras siga diferido;
- implementar `AS-02 Asset Detail` antes de Assets List.

Fuente:

- `06-ui-ux/CMMS_ASSET_SCREEN_ARCHITECTURE_V1.md`.

## AE-5 — AssetPlan 3D consumption

**Estado:** `CONTRACT PASS / RUNTIME HOLD`.

Fuente externa observada:

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

Contrato:

```text
EquipmentTypeCode
→ VisualProvider
→ AssetKey
→ controlled runtime distribution
```

Gate real:

- `06-ui-ux/gates/AE-G5_ASSETPLAN_3D_POWER_APPS_RUNTIME_GATE.md`.

Hasta runtime PASS no se puede declarar aprobado el visual de Asset Detail.

## AE-6 — primer incremento preparado

**Estado:** `AE6-S01 PREPARED / PENDING_POWER_APPS_STUDIO`.

Primer consumer:

```text
AS-02 Asset Detail
P-101 synthetic fixture
Object 360
read-only
no backend
no DML
```

Preparado:

1. `Asset Detail Read Contract V1`;
2. fixture `p101-asset-detail.v1.json`;
3. Power Fx loader copiable;
4. pre-Studio implementation plan S01-00..S01-06;
5. source audit de componentes AssetPlan;
6. `AE-G6 Asset Detail S01 Studio Gate`.

El fixture contiene de forma deliberada:

```text
Duty flow      READY
Duty pressure  READY
Redundancy     READY
Manufacturer   UNAVAILABLE
Model          UNAVAILABLE
```

La pantalla debe demostrar calidad visual también con datos incompletos.

### Repositorio ejecutable

La búsqueda GitHub actual solo encuentra `rubensv74/cmms-2.0-knowledge` para CMMS. No se ha identificado un repositorio separado con la Canvas app/source ejecutable.

Por tanto no se genera YAML `.pa.yaml` especulativo antes de `S01-00 App reality audit`.

### Gate real actual

```text
AE-G5 runtime
+
AE-G6 S01 Studio
```

El siguiente paso requiere la Canvas app real.

Fuentes:

- `06-ui-ux/functional-lab/development/AE6_ASSET_DETAIL_S01_PRESTUDIO_IMPLEMENTATION.md`;
- `06-ui-ux/functional-lab/cases/P101/p101-asset-detail.v1.json`;
- `08-resources/powerfx/asset-experience/AE6_ASSET_DETAIL_S01_FIXTURE_LOAD.powerfx.txt`;
- `06-ui-ux/gates/AE-G6_ASSET_DETAIL_S01_STUDIO_GATE.md`.

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

- convertir AS-IS en TO-BE sin validación;
- hardcodear routing organizativo;
- inventar planning/scheduling;
- confundir tarea, procedimiento y WO;
- crear componentes locales donde existe patrón compartido;
- copiar físicamente componentes AssetPlan ligados a Preservation;
- convertir CMMS en segundo maestro de ingeniería;
- duplicar la biblioteca 3D;
- presentar Type Illustration como CAD/BIM/modelo interactivo;
- mostrar `UNAVAILABLE` como cero/blank válido;
- generar YAML Power Apps contra un schema/locale no confirmado;
- implementar Asset Detail productivo antes de runtime/Studio gates.

---

# 5. Fuentes de verdad principales

- `ROADMAP.md`
- `00-governance/cmms-functional-lab-incremental-protocol.md`
- `02-functional/process-model/functional-journey.md`
- `02-functional/process-model/human-system-decisions.md`
- `02-functional/process-model/work-management-discovery.md`
- `02-functional/asset-master/CMMS_ASSET_EXPERIENCE_CONTRACT_V1.md`
- `02-functional/asset-master/CMMS_ASSET_DETAIL_READ_CONTRACT_V1.md`
- `06-ui-ux/CMMS_ASSET_EXPERIENCE_REDEFINITION_V1.md`
- `06-ui-ux/audits/2026-08-24_AE0_ASSETS_CURRENT_STATE_AUDIT.md`
- `06-ui-ux/CMMS_ASSET_VISUAL_SYSTEM_V1.md`
- `06-ui-ux/CMMS_ASSET_PREMIUM_COMPONENTS_V1.md`
- `06-ui-ux/audits/2026-08-24_AE6_COMPONENT_ADAPTATION_BASELINE.md`
- `06-ui-ux/CMMS_ASSET_SCREEN_ARCHITECTURE_V1.md`
- `06-ui-ux/CMMS_ASSETPLAN_3D_CONSUMPTION_CONTRACT_V1.md`
- `06-ui-ux/gates/AE-G5_ASSETPLAN_3D_POWER_APPS_RUNTIME_GATE.md`
- `06-ui-ux/gates/AE-G6_ASSET_DETAIL_S01_STUDIO_GATE.md`
- `06-ui-ux/CMMS_COMPONENT_CATALOG_V1.md`
- `06-ui-ux/branding/README.md`
- `06-ui-ux/functional-lab/architecture.md`
- `06-ui-ux/functional-lab/design-system.md`
