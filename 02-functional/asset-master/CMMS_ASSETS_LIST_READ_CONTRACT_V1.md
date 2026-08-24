# CMMS 2.0 — ASSETS List Read Contract V1

**Fecha:** 2026-08-24  
**Screen:** `AS-01 Assets`  
**Estado:** `UI_CONTRACT_ACCEPTED / PHYSICAL_SOURCE_DEFERRED`

## 1. Propósito

Definir la forma mínima de lectura que necesita la pantalla `Assets` sin fijar todavía SQL, API, Dataverse, ALEP ni otra implementación física.

La UI debe depender de este contrato y no de nombres físicos de tablas/columnas.

## 2. Request lógico

```text
ProjectContext        required
SearchText            optional
EquipmentTypeCode     optional
LocationScope         optional
LifecycleStatusCode   optional
CriticalityCode       optional
SortKey               optional
SortDirection         optional
PageSize              optional
Continuation          optional
```

En el Functional Lab inicial puede sustituirse por fixture/colección controlada.

## 3. Item shape

```text
AssetId                 internal stable id
AssetCode               required
Description             required
EquipmentTypeCode       required
EquipmentTypeLabel      required
EquipmentTypeIconKey    optional
LocationCode            optional
LocationLabel           optional
CriticalityCode         optional
CriticalityLabel        optional
LifecycleStatusCode     required
LifecycleStatusLabel    required
ManufacturerName        optional
ModelName               optional
SerialNumber            optional
FreshnessStatus         optional
```

## 4. Response lógico

```text
Status
Items
TotalCount optional
Continuation optional
SourceStatus optional
```

## 5. Estado por dato

Un campo opcional ausente no convierte el registro en error.

La UI debe distinguir:

```text
record available + optional field unavailable
≠
source unavailable
≠
read error
```

Manufacturer/Model no disponibles se representan como `—` cuando la columna sea visible.

## 6. Reglas de filtrado

### Search V1

Debe operar al menos sobre:

```text
AssetCode
Description
```

### Filters V1

```text
EquipmentTypeCode
LocationScope
LifecycleStatusCode
CriticalityCode
```

No se obliga a que el filtrado sea client-side o server-side en V1. La implementación física deberá decidirlo según volumen/delegación/rendimiento.

## 7. Sort baseline

Orden inicial recomendado:

```text
AssetCode ASC
```

Sorts candidatos:

```text
AssetCode
Description
EquipmentTypeLabel
LocationLabel
Criticality
LifecycleStatus
```

## 8. Seguridad

El adapter físico deberá respetar el scope de proyecto y permisos del usuario.

No confiar en filtros visuales como frontera de seguridad.

## 9. Rendimiento

La futura implementación productiva debe evitar cargar Technical Profile, documentos, fotos o Maintenance Summary completo para cada fila.

`Assets List` consume un read model ligero.

## 10. Escrituras

Este contrato es `READ ONLY`.

No define:

- Create Asset;
- Edit Asset;
- bulk update;
- Work Order creation;
- sync/refresh actions.

Esas operaciones requieren contratos separados y Async Action Guard cuando sean asíncronas/transaccionales.

## 11. Arquitectura runway

```text
UI / Data Explorer
      ↓
AssetsListReadContract
      ↓
Runtime adapter
      ↓
Fixture now / physical source later
```

La fuente física queda diferida deliberadamente hasta el incremento de lectura real.

## 12. Gate

```text
UI_READ_CONTRACT = PASS
PHYSICAL_SOURCE  = DEFERRED
```

Esto permite construir Shell, estados y fixture sin especular sobre infraestructura productiva.
