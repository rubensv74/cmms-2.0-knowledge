# CMMS 2.0 — Asset Premium Components V1

**Fecha:** 2026-08-24  
**Track:** Asset Experience Redefinition  
**Fase:** `AE-3`  
**Gate:** `AE-G3`  
**Estado:** `CONTRACT_BASELINE / IMPLEMENTATION_PENDING`  
**Veredicto:** `PASS_CONTRACT / PHYSICAL_VALIDATION_PENDING`

## 1. Propósito

Definir la familia mínima de componentes compartidos necesaria para construir `Assets List`, `Asset Detail` y `Equipment Type Library` sin duplicar patrones locales.

La regla de decisión continúa siendo:

```text
REUSE_CMMS
→ ADAPT_VERIFIED_BASE
→ EXTEND_SHARED
→ CREATE_SHARED
→ LOCAL_ONLY
```

Ningún componente descrito aquí se considera `VALIDATED_CMMS` hasta existir implementación y evidencia real en Power Apps Studio.

---

# 2. Componentes genéricos a adaptar antes de crear nuevos

## `cmp_CMMS_PageHeaderPro`

**Estrategia:** `ADAPT_VERIFIED_BASE`.

Referencia: Page Header premium probado en AssetPlan/PULSE cuando el contrato encaje.

Responsabilidad:

- N1 Page Identity;
- título/subtítulo;
- utilidades subordinadas;
- no contiene KPIs ni identity fields extensos del Asset.

## `cmp_CMMS_StatePanelPro`

**Estrategia:** `ADAPT_VERIFIED_BASE`.

Estados:

```text
LOADING
EMPTY
UNAVAILABLE
STALE
ERROR
BLOCKED
```

Debe conservar la geometría del host y evitar overlays globales innecesarios.

## `cmp_CMMS_FilterBarPro`

**Estrategia:** `ADAPT_VERIFIED_BASE`.

Consumers iniciales:

- Assets List;
- Equipment Type Library.

## `cmp_CMMS_DataGridPro`

**Estrategia:** `ADAPT_VERIFIED_BASE`.

Consumers iniciales:

- Assets List;
- technical field catalogue/configuration.

No contiene lógica de negocio ni consultas.

## `cmp_CMMS_ActionButtonPro`

**Estrategia:** `ADAPT_VERIFIED_BASE`.

Debe soportar:

```text
IsEnabled
IsBusy
BusyText
primary/secondary/destructive hierarchy
```

No sustituye idempotencia backend.

## `cmp_CMMS_IconPro`

**Estrategia:** `ADAPT_VERIFIED_BASE`.

Responsabilidad:

- render consistente de iconos funcionales;
- soporte de semantic key / URI según implementación elegida;
- currentColor/tone gobernado;
- estados accesibles.

---

# 3. Componentes Asset Experience

## 3.1 `cmp_CMMS_AssetIdentityHero_RC0`

**Estrategia:** `CREATE_SHARED`.

### Propósito

Responder rápidamente:

```text
What asset is this?
What kind of equipment is it?
Where is it / what state is it in?
```

### Inputs

```text
AssetCode
Description
EquipmentTypeLabel
LifecycleStatusLabel
CriticalityLabel
LocationLabel
ManufacturerName optional
ModelName optional
PrimaryVisualUri optional
PrimaryVisualKind
VisualAvailabilityStatus
```

### Outputs / events

```text
OnVisualSelect optional
OnViewHierarchy optional
OnEditAsset optional host-governed
```

El componente no navega ni persiste por sí mismo.

### States

```text
READY
LOADING
NO_VISUAL
STALE_VISUAL
ERROR_VISUAL
```

### Guardrails

- no Technical Fields extensos;
- no KPIs de mantenimiento;
- no fake 3D controls;
- Type Illustration etiquetada como tal cuando sea la imagen mostrada;
- no afirmar Model Image si solo existe ilustración genérica.

---

## 3.2 `cmp_CMMS_TechnicalValue_RC0`

**Estrategia:** `CREATE_SHARED`.

### Propósito

Primitive reusable para un Technical Field individual.

### Inputs

```text
FieldKey
Label
ValueDisplay
UnitDisplay optional
AvailabilityStatus
ProvenanceType optional
SourceLabel optional
IsOverride
IsRequired
IconKey optional
HelpText optional
```

### States

```text
READY
UNAVAILABLE
NOT_APPLICABLE
STALE
ERROR
```

### Reglas

- `UNAVAILABLE` muestra `—`, nunca `0`;
- provenance queda subordinado salvo stale/conflict/override;
- unidad no forma parte del label del campo;
- icono opcional, no obligatorio para cada Technical Field.

---

## 3.3 `cmp_CMMS_TechnicalSpecificationGrid_RC0`

**Estrategia:** `EXTEND_SHARED / CREATE_SHARED`.

Puede reutilizar primitives de grid/layout existentes, pero necesita contrato técnico específico.

### Inputs

```text
Items Table<TechnicalValueViewModel>
SectionMode
ColumnsRequested
ShowProvenance
ShowRequiredState
EmptyText
```

### Eventos

```text
OnValueSelect
OnSourceDetails
```

### Responsabilidad

- ordenar por section/display order;
- renderizar TechnicalValue;
- preservar estados por item;
- responder a ancho del host.

### No responsabilidad

- calcular valores;
- convertir unidades;
- resolver fuentes;
- decidir applicability;
- guardar edits.

---

## 3.4 `cmp_CMMS_ProvenanceBadge_RC0`

**Estrategia:** `CREATE_SHARED` only if repeated consumers justify it.

### Inputs

```text
ProvenanceType
SourceLabel optional
FreshnessStatus optional
IsOverride
CompactMode
```

### Semantics

```text
IMPORTED
SYNCED
MANUAL
DERIVED
OVERRIDE
```

### Guardrail

No usar colores distintos por sistema como decoración. Texto/icono deben mantener significado sin color.

---

## 3.5 `cmp_CMMS_EngineeringContextPanel_RC0`

**Estrategia:** `CREATE_SHARED`.

### Inputs

```text
SourceLinks Table<EngineeringSourceLinkVM>
Documents Table<EngineeringDocumentLinkVM>
PanelStatus
```

### Eventos

```text
OnOpenSource
OnOpenDocument
OnViewAllDocuments
```

### States

```text
READY
EMPTY
UNAVAILABLE
STALE
ERROR
```

### Guardrails

- no almacenar binarios;
- no inventar enlaces;
- revision/status solo si existen;
- no presentar un documento external como adjunto CMMS si solo es referencia.

---

## 3.6 `cmp_CMMS_AssetVisualGallery_RC0`

**Estrategia:** `CREATE_SHARED`.

### Visual kinds

```text
TYPE_ILLUSTRATION
MODEL_IMAGE
ASSET_PHOTO
```

### Inputs

```text
Items Table<AssetVisualVM>
SelectedVisualKind
AllowImageFullscreen
GalleryStatus
```

### Eventos

```text
OnSelectItem
OnChangeVisualKind
OnOpenFullscreen
```

### Guardrails

- no Rotate/Explode/Orbit;
- `MODEL_IMAGE` no disponible hasta gobernanza de modelo;
- `ASSET_PHOTO` nunca se sustituye silenciosamente por Type Illustration;
- cada item conserva VisualKind y provenance.

---

## 3.7 `cmp_CMMS_HierarchyPath_RC0`

**Estrategia:** `CREATE/ADAPT`.

### Propósito

Representar contexto estructural sin colapsar FLH y ADR.

### Modes

```text
FLH_PATH
ADR_PATH
```

Nunca una cadena híbrida que haga parecer ambos árboles una sola jerarquía.

### Inputs

```text
Mode
Nodes Table<HierarchyNodeVM>
SelectedNodeKey optional
```

### Eventos

```text
OnNodeSelect optional
```

### Guardrail

La navegación real es host-owned; el componente representa estructura.

---

## 3.8 `cmp_CMMS_MaintenanceSummary_RC0`

**Estrategia:** `CREATE/ADAPT` after read model availability.

### Inputs

```text
OpenWorkOrdersCount optional
NextPreventiveDueDate optional
LastInspectionDate optional
LastInspectionResult optional
ActiveMaintenancePlanCount optional
LastMaintenanceDate optional
SummaryStatus
```

### Events

```text
OnOpenWorkOrders
OnOpenMaintenance
OnOpenInspections
```

### Guardrails

- read-only summary;
- `UNAVAILABLE` no equivale a cero;
- no Health Index en V1;
- no KPI inventado para completar composición.

---

## 3.9 `cmp_CMMS_EquipmentTypeCard_RC0`

**Estrategia:** `CREATE/ADAPT` for Configuration Studio.

### Inputs

```text
EquipmentTypeCode
DisplayName
Description optional
AssetCount optional
TechnicalFieldCount optional
IllustrationUri optional
Status
IsSelected
```

### Guardrail

Counts solo si provienen de read model real. La card no se convierte en Asset instance card.

---

# 4. View models compartidos

## `TechnicalValueViewModel`

```text
FieldKey
Label
ValueDisplay
UnitDisplay
AvailabilityStatus
ProvenanceType
SourceLabel
FreshnessStatus
IsOverride
IsRequired
IconKey
SectionCode
DisplayOrder
```

## `AssetVisualVM`

```text
VisualId
VisualKind
Uri
Title
SourceLabel
SourceVersion optional
Status
IsPrimary
```

## `HierarchyNodeVM`

```text
NodeKey
NodeType
Label
SecondaryLabel optional
Status optional
```

## `EngineeringDocumentLinkVM`

```text
DocumentKey
DocumentTypeCode
DocumentNumber
Title
Revision
Status
SourceLabel
OpenUri optional
```

Los view models son contratos UI; no implican tablas SQL equivalentes.

---

# 5. Component ownership

Todos los componentes de esta familia son product-wide CMMS cuando se implementen.

Ubicación objetivo futura sugerida:

```text
power-apps/components/shared/
```

La ruta exacta se decidirá cuando exista la foundation física de la Canvas app.

No crear copias por pantalla como:

```text
cmp_AssetDetail_TechnicalValue
cmp_EquipmentType_TechnicalValue
```

si `cmp_CMMS_TechnicalValue` cubre ambos consumers.

---

# 6. Lifecycle

```text
TO_VALIDATE
→ CMMS_RC
→ VALIDATED_CMMS
```

### `TO_VALIDATE`
Contrato definido, sin implementación validada.

### `CMMS_RC`
Implementación candidate presente en app/lab, gate pendiente.

### `VALIDATED_CMMS`
Import/render/save/close/reopen/smoke y Visual Gate completados según corresponda.

Una captura mockup o existencia en GitHub no promueve lifecycle.

---

# 7. Secuencia de implementación recomendada

```text
1. adapt PageHeader / StatePanel / ActionButton / IconPro
2. adapt FilterBar / DataGrid
3. implement TechnicalValue
4. implement AssetIdentityHero
5. implement TechnicalSpecificationGrid
6. implement EngineeringContextPanel
7. implement AssetVisualGallery
8. implement HierarchyPath
9. implement MaintenanceSummary only with read model
10. implement EquipmentTypeCard when Configuration Studio begins
```

No es necesario tener todos los componentes terminados para empezar una pantalla candidate si el siguiente bloque está bien aislado, pero no duplicar localmente un component pendiente solo para avanzar.

---

# 8. Reuse matrix

| Component | Strategy | Current lifecycle |
|---|---|---|
| PageHeaderPro | ADAPT_VERIFIED_BASE | TO_VALIDATE_CMMS |
| StatePanelPro | ADAPT_VERIFIED_BASE | TO_VALIDATE_CMMS |
| FilterBarPro | ADAPT_VERIFIED_BASE | TO_VALIDATE_CMMS |
| DataGridPro | ADAPT_VERIFIED_BASE | TO_VALIDATE_CMMS |
| ActionButtonPro | ADAPT_VERIFIED_BASE | TO_VALIDATE_CMMS |
| IconPro | ADAPT_VERIFIED_BASE | TO_VALIDATE_CMMS |
| AssetIdentityHero | CREATE_SHARED | TO_VALIDATE |
| TechnicalValue | CREATE_SHARED | TO_VALIDATE |
| TechnicalSpecificationGrid | EXTEND/CREATE_SHARED | TO_VALIDATE |
| ProvenanceBadge | CREATE_IF_REUSED | TO_VALIDATE |
| EngineeringContextPanel | CREATE_SHARED | TO_VALIDATE |
| AssetVisualGallery | CREATE_SHARED | TO_VALIDATE |
| HierarchyPath | CREATE/ADAPT | TO_VALIDATE |
| MaintenanceSummary | CREATE/ADAPT | BLOCKED_UNTIL_READ_MODEL |
| EquipmentTypeCard | CREATE/ADAPT | TO_VALIDATE |

---

# 9. Gate AE-G3

## Contract checks

```text
[x] generic capabilities checked for adaptation first
[x] Asset-specific gaps identified
[x] inputs/outputs/events defined at baseline level
[x] visual/business responsibilities separated
[x] view models defined
[x] component ownership shared
[x] lifecycle honest
[x] no component declared VALIDATED_CMMS
[x] MaintenanceSummary explicitly blocked by read-model evidence
```

## Verdict

```text
AE-G3-CONTRACT = PASS
PHYSICAL COMPONENT GATE = PENDING POWER APPS FOUNDATION / STUDIO
AE-3 DESIGN BASELINE = COMPLETE
NEXT = AE-4 SCREEN ARCHITECTURE
```

The physical validation portion of AE-G3 cannot close until components exist in the real Canvas app. This is a real future gate and must not be inferred from documentation.
