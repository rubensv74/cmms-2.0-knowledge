# CMMS 2.0 — Asset Screen Architecture V1

**Fecha:** 2026-08-24  
**Track:** Asset Experience Redefinition  
**Fase:** `AE-4`  
**Gate:** `AE-G4`  
**Estado:** `SCREEN_CONTRACT_BASELINE / IMPLEMENTATION_PENDING`  
**Veredicto:** `PASS_CONTRACT / READY_FOR_AE-5`

## 1. Propósito

Convertir el contrato funcional y visual de Asset Experience en un mapa mínimo de pantallas coherente.

V1 define cuatro superficies:

```text
Assets
Asset Detail
Asset Create / Edit
Equipment Type Library
```

No se crean todavía:

```text
Model Template Detail   -> DEFERRED
Standalone Visual Library -> NOT NEEDED IN V1
```

El visual mapping se integra dentro de `Equipment Type Library` mientras no exista volumen/ownership que justifique una aplicación separada.

---

# 2. Navigation model

```text
ASSETS
├─ Assets List
│   └─ Asset Detail
│       ├─ Overview
│       ├─ Technical Profile
│       ├─ Engineering
│       ├─ Visuals
│       └─ Maintenance
│
├─ Asset Create / Edit
│
└─ Administration / Asset Master
    └─ Equipment Type Library
        ├─ Equipment Types
        ├─ Technical Fields
        └─ Visual Mapping
```

La ubicación exacta en sidebar se decide con el shell/navigation governance; este mapa expresa relación funcional, no rutas hard-coded.

---

# 3. Screen AS-01 — Assets List

## PRIMARY_USER_TASK

```text
Find the asset I need and understand enough context to open the correct record.
```

## SUCCESS_CRITERION

El usuario puede localizar inequívocamente un Asset mediante identidad, tipo, ubicación o filtros y acceder a su detalle sin interpretar datos ambiguos.

## PRIMARY_ARCHETYPE

```text
Data Explorer
```

## SECONDARY_PATTERNS

```text
Filter/Search Surface
Optional Context Preview
Explicit Data States
```

## PREMIUM_COMPONENTS

```text
PageHeaderPro
FilterBarPro
DataGridPro
StatePanelPro
IconPro
```

## N1 — Page Identity

```text
Assets
Explore and manage maintainable assets
```

No incluir Asset seleccionado en N1.

## N2 — Context Strip

Cuando aplique:

```text
Project / Site context
Asset Model version
scope/freshness indicator when material
```

No repetir filtros de la tabla en Context Strip.

## N3 — Summary optional

Solo métricas con fuente real y uso decisional.

Candidatos futuros:

```text
Total assets in current scope
Assets with stale engineering data
Assets requiring data review
```

No incluir hasta existir read model gobernado.

## N4 — Workspace

### Search

Debe poder buscar al menos:

```text
AssetCode
Description
```

Cuando el read model lo soporte puede incluir Manufacturer/Model/Serial.

### Filters baseline

```text
Equipment Type
FLH Location / hierarchy scope
Lifecycle Status
Criticality
```

Candidatos posteriores:

```text
data freshness
source/provenance
has open work
```

### Grid columns baseline

```text
Type icon
AssetCode
Description
Equipment Type
Location
Criticality
Lifecycle Status
Manufacturer / Model optional
```

Reglas:

- Type illustration 3D no se carga como imagen grande por fila;
- preferir Equipment Type icon para escaneo rápido;
- thumbnail solo si rendimiento y densidad lo justifican;
- `UNAVAILABLE` explícito para Manufacturer/Model si la columna es visible;
- row selection no modifica datos.

### Primary action

```text
Open Asset
```

Puede ejecutarse por row select/double action según implementación accesible; no es una acción transaccional.

### Secondary actions

```text
Create Asset
Export current view only if contract exists
```

No añadir `Create Work Order` en cada fila como ruido si la tarea principal es exploración. Puede vivir en Asset Detail.

## States

```text
LOADING
READY
EMPTY
ERROR
UNAVAILABLE_SOURCE
```

`ERROR` nunca produce lista vacía aparentemente válida.

---

# 4. Screen AS-02 — Asset Detail / Asset Technical Profile

## PRIMARY_USER_TASK

```text
Understand this asset as a technical and maintenance object and reach the correct next action.
```

## SUCCESS_CRITERION

El usuario identifica el activo, su contexto físico, sus especificaciones, origen de datos, documentación/visuales y mantenimiento relacionado sin confundir datos de ingeniería con datos CMMS.

## PRIMARY_ARCHETYPE

```text
Object 360
```

## SECONDARY_PATTERNS

```text
Tabbed Object Detail
Contextual Summary
Technical Data Grid
Evidence / Document Panel
```

## PREMIUM_COMPONENTS

```text
PageHeaderPro
AssetIdentityHero
TechnicalSpecificationGrid
TechnicalValue
EngineeringContextPanel
AssetVisualGallery
HierarchyPath
MaintenanceSummary
StatePanelPro
ActionButtonPro
IconPro
```

## N1 — Page Identity

```text
Asset
Technical and maintenance profile
```

N1 no contiene todos los datos del Asset.

## N2 — Asset Context Strip

```text
AssetCode
Description
Equipment Type
Lifecycle Status
Criticality
Location
```

Este strip debe permanecer estable entre tabs para evitar perder contexto.

## N3 — Attention Summary optional

Solo cuando existe información accionable real:

```text
stale technical data
source conflict
open critical work
inspection issue
```

No mostrar métricas genéricas para rellenar espacio.

## N4 — Information architecture

### Tab `Overview`

Objetivo: lectura ejecutiva del Asset.

Contenido candidato:

```text
AssetIdentityHero
FLH Hierarchy Path
ADR relationship summary
selected Technical Profile highlights
Engineering Context summary
Maintenance Summary when available
```

No repetir el Technical Profile completo.

### Tab `Technical Profile`

Contenido:

```text
TechnicalSpecificationGrid
sections by TechnicalFieldCategory
per-value provenance/freshness
source/override details on demand
```

Filtros/controls posibles:

```text
All
Required
Unavailable
Stale / Needs review
```

Solo si el volumen lo requiere.

### Tab `Engineering`

Contenido:

```text
Engineering source links
Datasheet
P&ID
GA Drawing
O&M Manual
Certificate
other governed document types
```

Acciones reales únicamente:

```text
Open source
Open document
View details
```

### Tab `Visuals`

Contenido:

```text
Type Illustration
Model Image when governed
Asset Photos
```

Reglas:

- cada visual se etiqueta por kind;
- no fake 3D interactions;
- fullscreen solo si es image fullscreen real;
- missing Model Image no se suplanta con Type Illustration sin label.

### Tab `Maintenance`

Estado V1:

```text
READ_MODEL_DEPENDENT
```

Contenido cuando exista contrato:

```text
Maintenance Summary
Open WOs
Preventive context
Inspection context
Recent maintenance history
```

No duplicar Work Management; esta tab contextualiza y navega a sus dominios.

## Actions

### Context asset management

```text
Edit Asset
View hierarchy
```

### Maintenance actions

```text
Create Work Order
Open Work Orders
```

solo cuando Work Management contract lo permita.

Regla: no tener dos acciones primarias simultáneas de dominios distintos sin contexto claro.

## Mobile/tablet priority

```text
Context Strip
→ Asset Identity
→ current tab primary content
→ related summaries
```

Right rails desktop se apilan; no reducirlos a columnas ilegibles.

---

# 5. Screen AS-03 — Asset Create / Edit

## PRIMARY_USER_TASK

```text
Create or correct a maintainable Asset without breaking classification, FLH/ADR relationships or source authority.
```

## SUCCESS_CRITERION

El Asset queda válido, trazable y coherente con Asset Model, Equipment Type, FLH/ADR y authority policies.

## PRIMARY_ARCHETYPE

```text
Governed Form / Guided Configuration
```

No se adopta automáticamente el wizard lateral histórico.

## SECONDARY_PATTERNS

```text
Sectioned Form
Validation Summary
Source/Provenance Indicators
```

## PREMIUM_COMPONENTS

```text
PageHeaderPro
ActionButtonPro
StatePanelPro
IconPro
TechnicalValue/edit variant future
Hierarchy selector adapters future
```

## Create flow V1

Secuencia conceptual:

```text
1 Identity
→ 2 Classification + FLH
→ 3 ADR / Physical Context
→ 4 Source / Review
→ Save
```

Puede materializarse como steps horizontales, sections o progressive disclosure; no fijar navegación hasta Studio prototype.

## Step 1 — Identity

```text
AssetCode
Description
Lifecycle Status
Manufacturer optional
Model optional
Serial optional
```

Source-owned fields pueden estar read-only.

## Step 2 — Classification + FLH

```text
EquipmentTypeCode
LocationCode
CriticalityCode
LocationMode
```

Equipment Type procede del modelo publicado.

## Step 3 — ADR

```text
ParentAssetCode optional
RelationshipType optional
```

Mostrar claramente:

```text
FLH = functional location
ADR = physical parent
```

No usar un único selector de “Parent/Location”.

## Step 4 — Source / Review

Resumen de:

```text
provenance
read-only external values
overrides
validation warnings
```

## Technical Profile on create

V1 no obliga a capturar todos los Technical Fields antes de crear el Asset si el negocio permite `UNAVAILABLE`.

Regla:

- Technical Fields `REQUIRED` deben evaluarse mediante policy;
- si bloquean creación, el gate debe estar explícito;
- si pueden completarse después, crear Asset y abrir Technical Profile con estado de completitud.

No inventar obligatoriedad universal.

## Save

Write action material:

```text
Async Action Guard required
backend validation required
idempotency/concurrency proportional to risk
```

---

# 6. Screen AS-04 — Equipment Type Library

## PRIMARY_USER_TASK

```text
Govern what technical information and visual identity applies to each Equipment Type.
```

## SUCCESS_CRITERION

El usuario autorizado puede entender y configurar un Equipment Type, sus Technical Fields y su Type Illustration dentro del Asset Model sin editar activos individuales.

## PRIMARY_ARCHETYPE

```text
Configuration Studio
```

## SECONDARY_PATTERNS

```text
Catalogue + Selected Object Workspace
Governed Table
Visual Mapping
Publish/Version Gate
```

## PREMIUM_COMPONENTS

```text
PageHeaderPro
FilterBarPro
DataGridPro
StatePanelPro
EquipmentTypeCard
TechnicalValue or technical field row pattern
AssetVisualGallery compact mode optional
ActionButtonPro
IconPro
```

## N1 — Page Identity

```text
Equipment Type Library
Technical definitions and visual mappings
```

## N2 — Context Strip

```text
Asset Model version
Status: Draft / Published
Taxonomy source
Project/Corporate scope
```

## N3 — Gate / Summary

Cuando aplique:

```text
unpublished changes
validation errors
missing required mappings
```

No usar KPI decorativos.

## N4 — Workspace

V1 utiliza tres tabs internas.

### `Equipment Types`

Layout candidato:

```text
left catalogue
→ selected type definition
→ summary/context rail optional
```

Selected type muestra:

```text
EquipmentTypeCode
DisplayName
Taxonomy path
Status
Description
```

### `Technical Fields`

Para el Equipment Type seleccionado:

```text
Field
Category
Data Type
Required Level
Default Unit
Display Section / Order
Authority Policy
Override Policy
Status
```

Actions:

```text
Add existing Technical Field
Change applicability settings
Remove/deactivate applicability
```

No crear Technical Field nuevo inline sin pasar por la gobernanza de Technical Dictionary.

### `Visual Mapping`

Muestra:

```text
EquipmentTypeCode
IllustrationKey
Provider = AssetPlan Industrial Technical 3D
Source Version
Preview
Mapping Status
Fallback
```

Actions:

```text
Select existing illustration
Clear mapping
Review unmatched type
```

No permite subir nuevos PNG directamente a una “CMMS library”. Un hueco real sigue el proceso gobernado de la fuente AssetPlan.

## Publish

La publicación pertenece al Asset Model/version governance.

No se fija todavía si cada cambio de Equipment Type publica individualmente o si se publica una versión completa; se conserva el principio actual de modelo versionado.

---

# 7. Standalone Visual Library — decision

```text
V1 = DO NOT CREATE
```

Razón:

- la biblioteca fuente vive en AssetPlan;
- CMMS solo necesita mapping/preview;
- una pantalla independiente crearía más superficie y riesgo de ownership duplicado;
- Visual Mapping dentro de Equipment Type Library resuelve el consumer real actual.

Revisar solo si aparece:

```text
large cross-type mapping workload
approval workflow
provider/version management
multiple governed visual providers
```

---

# 8. Model Template Detail — decision

```text
V1 = DEFERRED
```

No se crea screen, route, icono ni componente específico mientras `Model Template` no supere su gate funcional.

Manufacturer/Model siguen siendo campos identificativos policy-based.

---

# 9. Screen-to-data dependency

| Screen | Required contract | Current readiness |
|---|---|---|
| Assets List | Asset list read model | DESIGNABLE / backend pending |
| Asset Detail Overview | Asset Identity + visual mapping | DESIGNABLE |
| Technical Profile | Technical Profile read model | CONTRACT READY / backend pending |
| Engineering | Engineering Context read model | CONTRACT READY / integration pending |
| Visuals | EquipmentTypeVisualMapping + AssetMedia | TYPE ILLUSTRATION READY FOR MAPPING DESIGN |
| Maintenance tab | Maintenance Summary read model | DEFERRED/BLOCKED BY WORK MANAGEMENT DATA |
| Asset Create/Edit | Asset write contract | FUNCTIONAL DESIGN READY / write boundary pending |
| Equipment Type Library | Asset Model + Technical Field applicability + visual mapping | DESIGNABLE / physical model pending |

---

# 10. Cross-screen invariants

1. Asset Context Strip uses the same grammar across Asset Detail tabs.
2. Assets List and Equipment Type Library do not invent separate filter components.
3. Equipment Type icon is not Type Illustration.
4. Visual Mapping never owns binary artwork.
5. FLH and ADR remain visibly separate.
6. Technical Profile values preserve provenance and availability.
7. Manufacturer/Model/Serial authority is visible where material.
8. `UNAVAILABLE` is not zero.
9. Unsupported Maintenance actions remain absent/disabled.
10. No screen receives local visual primitives when shared candidate exists.

---

# 11. Recommended implementation order

```text
AS-02 Asset Detail shell + identity baseline
→ AS-01 Assets List
→ AS-02 Technical Profile
→ AS-04 Equipment Type Library baseline
→ AS-02 Engineering + Visuals
→ AS-03 Asset Create/Edit
→ AS-02 Maintenance when read model exists
```

Reason:

- Asset Detail establishes Object 360 grammar and shared components;
- Assets List then has a real destination;
- Technical Profile validates the main discovery before expanding configuration;
- Equipment Type Library becomes meaningful once the consumer view is understood;
- Create/Edit comes after authority/provenance is visible and testable.

---

# 12. Gate AE-G4

```text
[x] four-screen minimum defined
[x] each screen has PRIMARY_USER_TASK
[x] each screen has SUCCESS_CRITERION
[x] each screen has PRIMARY_ARCHETYPE
[x] each screen has SECONDARY_PATTERNS
[x] each screen maps PREMIUM_COMPONENTS
[x] Information Architecture defined for Asset Detail
[x] Visual Mapping kept inside Configuration Studio
[x] Model Template screen deferred
[x] data readiness separated from visual readiness
[x] no unsupported capability presented as available
```

## Verdict

```text
AE-G4 = PASS_CONTRACT
AE-4  = COMPLETE AT SCREEN ARCHITECTURE LEVEL
NEXT  = AE-5 ASSETPLAN 3D CONSUMPTION CONTRACT
```

Physical screen implementation/Visual Approval remains pending Power Apps Studio and does not pass from this document.
