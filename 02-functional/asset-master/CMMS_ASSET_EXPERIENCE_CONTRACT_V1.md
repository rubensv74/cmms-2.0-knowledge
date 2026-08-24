# CMMS 2.0 — Asset Experience Contract V1

**Fecha:** 2026-08-24  
**Track:** Asset Experience Redefinition  
**Fase:** `AE-1`  
**Gate:** `AE-G1`  
**Estado:** `ACCEPTED / CONTRACT_V1 / READY_FOR_AE-2`  
**Veredicto:** `PASS_WITH_DEFERRED_ITEMS`

## 1. Propósito

Definir el contrato funcional mínimo que permite evolucionar CMMS 2.0 desde un modelo capaz de clasificar y estructurar activos hacia una experiencia que representa el activo como **objeto técnico y de mantenimiento**, sin duplicar fuentes de ingeniería ni mezclar datos de distinta autoridad.

Este contrato gobierna qué significa la información antes de decidir cómo se representa en Power Apps.

No fija todavía:

- layout final;
- tabs definitivas;
- geometría;
- tecnología documental;
- API productiva;
- modelo físico SQL definitivo;
- sincronización concreta con ALEP u otros sistemas.

---

# 2. Principio de arquitectura

CMMS debe distinguir tres hechos diferentes:

```text
1. qué es el activo para mantenimiento
2. qué información técnica conocemos del activo
3. de dónde procede y quién tiene autoridad sobre cada dato
```

Por tanto:

```text
Asset Master
+ Technical Profile
+ Engineering Context
+ Visual Context
+ Maintenance Context
```

son capas relacionadas, pero no intercambiables.

## Regla principal

> **La incorporación de información de ingeniería a CMMS no convierte automáticamente a CMMS en el sistema maestro de ingeniería.**

CMMS puede almacenar una copia operativa, una referencia o un override gobernado según el contrato de cada dato.

---

# 3. Qué se conserva del modelo actual

La foundation actual queda vigente:

```text
FLH       = dónde está instalado
Taxonomy  = qué tipo de activo es
ADR       = de qué forma parte físicamente
```

También se conservan:

- `AssetCode` como identidad CMMS del activo;
- `EquipmentTypeCode` como clasificación gobernada;
- `ParentAssetCode` para composición física ADR;
- `LocationCode` para relación con FLH;
- `RelationshipType`;
- `LocationMode` propio/heredado;
- criticidad gobernada;
- versionado del Asset Model.

Este contrato **extiende** ese modelo. No lo reemplaza.

---

# 4. Aggregate conceptual — Asset

```text
Asset
├─ Identity
├─ Classification
├─ Physical Context
├─ Technical Profile
├─ Engineering Context
├─ Visual Context
└─ Maintenance Context (read model)
```

Cada bloque tiene autoridad y lifecycle distintos.

---

# 5. Asset Identity

## 5.1 Contrato mínimo

```text
AssetId                 surrogate técnico interno
AssetCode               identificador funcional único CMMS
Description             descripción operativa
EquipmentTypeCode       clasificación técnica
LocationCode            ubicación FLH
ParentAssetCode          padre físico ADR opcional
RelationshipType        relación con padre opcional
LocationMode            OWN / INHERIT
CriticalityCode         criticidad gobernada
LifecycleStatus         estado de ciclo de vida
ManufacturerName        opcional
ModelName               opcional
SerialNumber            opcional
CommissioningDate       opcional
```

## 5.2 Autoridad

CMMS es autoridad sobre la **existencia del Asset como objeto mantenible dentro de CMMS** y sobre sus relaciones funcionales de mantenimiento.

Esto no significa que todos los valores nazcan manualmente en CMMS.

Un dato puede ser:

```text
IMPORTED
SYNCED
MANUAL
DERIVED
OVERRIDDEN
```

La adquisición inicial desde ALEP, Handover u otro sistema debe conservar provenance.

## 5.3 Manufacturer / Model / Serial

Se aceptan como parte del perfil identificativo del activo, pero **no se fija una autoridad global única en V1**.

Su `AuthorityPolicy` se resolverá por configuración/integración:

- external authoritative;
- CMMS owned;
- synchronized;
- manual allowed;
- override allowed.

Esto evita asumir que ALEP es siempre autoridad para esos campos en todos los proyectos.

---

# 6. Equipment Type

`EquipmentTypeCode` es el punto de conexión entre clasificación y conocimiento técnico reusable.

Ejemplo:

```text
PUMP_CENTRIFUGAL
MOTOR_INDUCTION
COMPRESSOR_CENTRIFUGAL
VALVE_GATE
HEAT_EXCHANGER_SHELL_TUBE
```

Reglas:

1. un Asset tiene un Equipment Type activo válido;
2. Equipment Type pertenece al Asset Model/taxonomía publicada;
3. Equipment Type define **qué Technical Fields pueden/aplican**;
4. Equipment Type puede resolver una Type Illustration;
5. Equipment Type no define automáticamente fabricante/modelo;
6. Equipment Type no fija por sí solo plan de mantenimiento, estrategia RCM ni tareas.

---

# 7. Technical Profile

## 7.1 Patrón reusable de AssetPlan

Se adopta el principio:

```text
Technical Field Definition
→ Unit / terminology
→ Equipment Type applicability
→ Asset Technical Value
→ provenance
```

No se copia el binding físico de AssetPlan `PreservationAttributeCatalog`, porque pertenece a su Rules Engine y crearía una dependencia de dominio incorrecta.

## 7.2 Entidades conceptuales V1

### `TechnicalFieldDefinition`

```text
TechnicalFieldId
TechnicalFieldKey
DisplayName
Description
CategoryCode
DataTypeCode
ValueStructureCode optional
IsActive
```

`TechnicalFieldKey` es estable y no depende del texto visible.

Ejemplos:

```text
DESIGN_PRESSURE
DESIGN_TEMPERATURE
RATED_FLOW
RATED_POWER
SPEED
VOLTAGE
MATERIAL
CONNECTION_SIZE
```

### `TechnicalFieldCategory`

Agrupa semánticamente campos.

Ejemplos candidatos:

```text
IDENTIFICATION
DESIGN_CONDITIONS
PERFORMANCE
ELECTRICAL
MECHANICAL
CONSTRUCTION
OPERATING_LIMITS
DIMENSIONS
```

El catálogo definitivo se validará con datos reales; estas categorías no son todavía un seed obligatorio.

### `TechnicalFieldUnit`

Define unidades válidas para el Technical Field.

Debe soportar como mínimo:

```text
UnitCode
DisplaySymbol
MeasurementDimension
IsDefault
IsActive
```

No convertir texto libre de unidad en parte inseparable del valor.

### `EquipmentTypeTechnicalField`

Relación entre Equipment Type y Technical Field.

```text
EquipmentTypeCode
TechnicalFieldId
RequiredLevel
DisplayOrder
SectionCode
DefaultUnitCode optional
AuthorityPolicy optional
OverridePolicy optional
IsActive
```

`RequiredLevel` puede evolucionar, pero V1 distingue como mínimo:

```text
REQUIRED
RECOMMENDED
OPTIONAL
```

### `AssetTechnicalValue`

Valor técnico de un Asset concreto.

```text
AssetId
TechnicalFieldId
ValueText / normalized typed value
UnitCode optional
AvailabilityStatus
ProvenanceType
SourceSystemCode optional
SourceReference optional
SourceUpdatedAt optional
LastSynchronizedAt optional
IsOverride
OverrideReason optional
UpdatedBy
UpdatedAt
```

El modelo físico decidirá cómo representar valores tipados sin sacrificar integridad ni capacidad de consulta.

---

# 8. Value provenance

## 8.1 `ProvenanceType`

V1 normaliza:

```text
IMPORTED
SYNCED
MANUAL
DERIVED
OVERRIDE
```

No se usará únicamente el nombre del sistema fuente para expresar el comportamiento del valor.

Ejemplo:

```text
SourceSystem = ALEP
Provenance   = SYNCED
```

es distinto de:

```text
SourceSystem = ALEP
Provenance   = IMPORTED
```

## 8.2 Authority policy

Un campo o relación de aplicabilidad puede declarar:

```text
CMMS_OWNED
EXTERNAL_READ_ONLY
EXTERNAL_SYNCED
CMMS_OVERRIDE_ALLOWED
DERIVED
```

### `CMMS_OWNED`

CMMS es autoridad operativa del dato.

### `EXTERNAL_READ_ONLY`

CMMS lo presenta pero no lo modifica.

### `EXTERNAL_SYNCED`

CMMS conserva una copia operativa sincronizada.

### `CMMS_OVERRIDE_ALLOWED`

Existe una fuente externa, pero el negocio permite una desviación local explícita y trazada.

### `DERIVED`

El dato procede de cálculo/regla y no debe editarse manualmente.

---

# 9. Override semantics

Un override no modifica silenciosamente el valor fuente.

Debe conservar como mínimo:

```text
SourceValue
EffectiveValue
OverrideReason
OverrideBy
OverrideAt
```

Si el valor fuente cambia posteriormente mientras existe override, el sistema debe poder representar:

```text
SOURCE_CHANGED_WITH_OVERRIDE
```

V1 no decide automáticamente si prevalece el nuevo valor externo o el override. Esa política debe estar gobernada por `OverridePolicy`.

---

# 10. Availability / freshness

Un valor técnico no puede confundirse con cero, blank o error.

Estados mínimos:

```text
READY
UNAVAILABLE
NOT_APPLICABLE
STALE
ERROR
```

### `READY`
Existe un valor operativo disponible.

### `UNAVAILABLE`
El campo aplica, pero no existe valor disponible.

### `NOT_APPLICABLE`
El campo no aplica a ese Equipment Type / Asset.

### `STALE`
Existe valor, pero su freshness supera el criterio permitido o la fuente cambió sin reconciliación.

### `ERROR`
No puede determinarse el estado por fallo de lectura/sincronización.

`ERROR` nunca debe presentarse como `UNAVAILABLE`.

---

# 11. Engineering Context

## 11.1 Propósito

Relacionar el Asset CMMS con evidencia y fuentes de ingeniería sin copiar indiscriminadamente documentos o convertir CMMS en DMS.

## 11.2 `EngineeringSourceLink`

```text
AssetId
SourceSystemCode
ExternalObjectType
ExternalObjectKey
ExternalUrl optional
SyncMode
Status
LastVerifiedAt
```

Ejemplo:

```text
ALEP
EngineeringRegister
Documentum
SharePoint
future corporate engineering source
```

Los nombres reales se incorporarán mediante catálogo de sistemas fuente.

## 11.3 `EngineeringDocumentLink`

```text
AssetId
DocumentTypeCode
SourceSystemCode
ExternalDocumentKey
DocumentNumber optional
Title
Revision optional
Status optional
ExternalUrl optional
IsPrimary
LastVerifiedAt
```

Document types candidatos:

```text
DATASHEET
PID
GA_DRAWING
OM_MANUAL
CERTIFICATE
VENDOR_DOCUMENT
OTHER
```

V1 gobierna la **relación**, no dónde viven físicamente los binarios.

---

# 12. Visual Context

Los tres niveles visuales son semánticamente distintos.

```text
TYPE_ILLUSTRATION
MODEL_IMAGE
ASSET_PHOTO
```

## 12.1 Type Illustration

Propósito: reconocimiento rápido del tipo de equipo.

Fuente gobernada:

```text
AssetPlan Industrial Technical 3D
```

Contrato conceptual:

### `EquipmentTypeVisualMapping`

```text
EquipmentTypeCode
VisualProviderCode
IllustrationKey
SourceVersion
Status
FallbackKey optional
UpdatedAt
```

CMMS no mantiene una segunda biblioteca.

## 12.2 Model Image

Estado V1:

`DEFERRED_PENDING_MODEL_GOVERNANCE`.

No se crea una entidad/model library solo porque otros EAM la tengan.

Si AE posterior confirma `EquipmentModel` como objeto gobernado, la imagen podrá asociarse a ese nivel.

Hasta entonces una imagen de fabricante puede mostrarse únicamente como documento/media de referencia con provenance explícito, sin presentarla como master image del modelo.

## 12.3 Asset Photo

CMMS gobierna la asociación de una fotografía con el Asset, aunque el almacenamiento físico pueda residir fuera de la base de datos.

Contrato mínimo:

### `AssetMediaLink`

```text
AssetId
MediaKind = ASSET_PHOTO
SourceSystemCode
ExternalMediaKey / URI
Caption optional
TakenAt optional
UploadedBy optional
IsPrimary
Status
```

---

# 13. Maintenance Context

El mantenimiento no se duplica dentro de Asset Master.

Asset Detail podrá mostrar un **read model agregado** procedente de los dominios operativos.

### `AssetMaintenanceSummary`

Campos candidatos V1:

```text
OpenWorkOrdersCount
NextPreventiveDueDate
LastInspectionDate
LastInspectionResult
ActiveMaintenancePlanCount
LastMaintenanceDate
```

Reglas:

1. solo mostrar un campo cuando exista contrato/fuente real;
2. `UNAVAILABLE` no equivale a cero;
3. no persistir estos agregados como verdad independiente del dominio origen salvo necesidad técnica gobernada;
4. `HealthIndex` queda fuera de V1 hasta existir fórmula, autoridad y uso funcional aprobados.

**Decisión:** `MAINTENANCE_SUMMARY = READ_MODEL_ONLY`.

---

# 14. Model Template

## Estado V1

```text
MODEL_TEMPLATE = DEFERRED
```

Razón:

- SAP/Maximo demuestran que puede aportar valor;
- AssetPlan aporta conocimiento reusable de Equipment Type y Technical Fields;
- el repositorio CMMS actual no demuestra todavía que necesitemos herencia de valores por modelo comercial;
- introducirlo ahora aumentaría complejidad antes de resolver Manufacturer/Model authority.

V1 no impide añadirlo después.

Gate futuro para activarlo:

```text
real repeated manufacturer/model values
+ clear ownership
+ measurable reuse benefit
+ explicit inheritance/override semantics
```

---

# 15. Matriz de autoridad V1

| Familia | Autoridad CMMS | Puede venir de fuente externa | Override | Observación |
|---|---|---|---|---|
| Asset existence as maintainable object | YES | puede importarse | N/A | CMMS decide existencia operativa del Asset record |
| AssetCode | YES | puede originarse externamente | restringido | identidad estable |
| EquipmentTypeCode | YES / governed taxonomy | sí, como mapping/import | controlado | no aceptar texto libre como verdad |
| FLH LocationCode | CMMS functional model | puede importarse | gobernado | relación funcional |
| ADR ParentAssetCode | CMMS | puede importarse | gobernado | composición física |
| Criticality | CMMS/project governance | sí | según política | no hardcodear A/B/C product-wide |
| Manufacturer/Model/Serial | POLICY-BASED | YES | policy-based | autoridad concreta pendiente por integración |
| Technical Field definition | CMMS technical dictionary | puede inspirarse/importarse | approval required | catálogo canónico CMMS |
| Technical Field value | FIELD POLICY | YES | field policy | provenance obligatorio |
| Engineering document binary | NO by default | YES | N/A | CMMS gobierna link/contexto |
| Engineering document relation | YES | YES | gobernado | Asset ↔ document |
| Type Illustration | external AssetPlan source | YES | mapping only | no duplicar library |
| Asset Photo relation | YES | YES | YES | binary storage TBD |
| Maintenance Summary | source maintenance domains | N/A | NO | read model |

---

# 16. API / read model conceptual

La UI no debe ensamblar relaciones pesadas desde múltiples tablas/sistemas directamente.

Operaciones lógicas futuras:

```text
CMMS_GetAssets
CMMS_GetAssetDetail
CMMS_GetAssetTechnicalProfile
CMMS_GetAssetEngineeringContext
CMMS_GetAssetVisualContext
CMMS_GetAssetMaintenanceSummary
CMMS_GetEquipmentTypeDefinition
```

Esto no obliga todavía a una tecnología API concreta.

La misma frontera puede implementarse inicialmente con SQL/Power Automate y migrar posteriormente a API sin cambiar el contrato funcional de pantalla.

---

# 17. Contrato de `CMMS_GetAssetDetail`

Salida conceptual mínima:

```json
{
  "asset": {
    "assetCode": "P-101A",
    "description": "Cooling Water Pump",
    "equipmentTypeCode": "PUMP_CENTRIFUGAL",
    "locationCode": "UTL-CW-PMP-101A",
    "parentAssetCode": null,
    "criticalityCode": "HIGH",
    "lifecycleStatus": "IN_OPERATION",
    "manufacturerName": "Flowserve",
    "modelName": "XYZ-200",
    "serialNumber": "1837472"
  },
  "technicalProfile": {
    "status": "READY",
    "fields": []
  },
  "engineeringContext": {
    "status": "READY",
    "sources": [],
    "documents": []
  },
  "visualContext": {
    "typeIllustration": null,
    "modelImage": null,
    "assetPhotos": []
  },
  "maintenanceSummary": {
    "status": "UNAVAILABLE"
  }
}
```

El ejemplo demuestra forma, no disponibilidad real de todos los datos.

---

# 18. Reuse de AssetPlan — frontera explícita

## Reutilizar

```text
technical dictionary pattern
unit catalog pattern
equipment applicability pattern
source/provenance concept
semantic aliases/search lessons
equipment 3D source library
premium component patterns where contract fits
icon registry lessons
```

## No copiar directamente

```text
PreservationAttributeCatalog physical binding
AssetPlan Preservation-specific rules
EquipmentType -> Preservation semantics
ALEP mappings specific to AssetPlan projects
AssetPlan database surrogate IDs
AssetPlan UI globals / host state
```

CMMS consume aprendizaje, no accidental coupling.

---

# 19. Invariantes AE-1

1. `EquipmentType != Model`.
2. `Type Illustration != Model Image != Asset Photo`.
3. `FLH != ADR`.
4. Technical Field definition no es un valor de Asset.
5. `UNAVAILABLE != ZERO != ERROR != NOT_APPLICABLE`.
6. Valor sincronizado debe conservar fuente/freshness.
7. Override nunca destruye silenciosamente el valor fuente.
8. CMMS no crea un segundo repositorio de documentos por comodidad de UI.
9. CMMS no crea una segunda biblioteca 3D.
10. Maintenance Summary es read model, no nueva fuente de verdad.
11. Model Template permanece diferido hasta existir evidencia de necesidad.
12. La UI no inventa KPIs, Health Index ni datos técnicos faltantes.

---

# 20. Estados de pantalla derivados del contrato

Las superficies Assets deberán soportar cuando apliquen:

```text
READY
LOADING
EMPTY
UNAVAILABLE
STALE
ERROR
BLOCKED
```

Además, cada valor técnico puede tener estado individual distinto del estado general del panel.

---

# 21. Gate AE-G1

## Comprobaciones

```text
[x] Asset Identity definido
[x] FLH / Taxonomy / ADR preservados
[x] Technical Profile definido
[x] Technical Field / Unit / Applicability / Value separados
[x] provenance normalizado
[x] authority policy definida
[x] override semantics definidas
[x] freshness/availability definidos
[x] Engineering Context definido sin duplicar DMS
[x] Visual Context definido
[x] AssetPlan 3D reuse contract definido
[x] Maintenance Summary limitado a read model
[x] Model Template decidido como DEFERRED
[x] AssetPlan conceptual reuse separado de su physical binding
```

## Veredicto

```text
AE-G1 = PASS_WITH_DEFERRED_ITEMS
AE-1  = COMPLETE
NEXT  = AE-2 VISUAL SYSTEM
```

Deferred items compatibles con el gate:

- autoridad concreta Manufacturer/Model/Serial por integración/proyecto;
- technology/document repository;
- Model Template;
- Health Index;
- physical SQL design;
- exact API implementation.

Ninguno impide diseñar la semántica visual y componentes de AE-2/AE-3 siempre que la UI respete `UNAVAILABLE` y provenance.
