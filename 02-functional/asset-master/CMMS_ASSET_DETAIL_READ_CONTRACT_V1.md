# CMMS 2.0 — Asset Detail Read Contract V1

**Fecha:** 2026-08-24  
**Track:** Asset Experience Redefinition  
**Fase:** AE-6 preparation  
**Estado:** `CONTRACT_V1 / READ_ONLY / IMPLEMENTATION_PENDING`

## 1. Propósito

Definir el contrato de lectura que alimentará `Asset Detail` sin acoplar Power Apps al modelo físico SQL, a ALEP, a nombres de columnas de integración ni a una tecnología documental concreta.

La pantalla consume un `AssetDetailReadModel`. El adaptador futuro será responsable de resolver y combinar las fuentes autorizadas según `CMMS_ASSET_EXPERIENCE_CONTRACT_V1.md`.

Regla:

> La UI muestra hechos ya resueltos con su estado y provenance; no decide autoridad, applicability, unidad, herencia ni conflictos.

---

## 2. Operación lógica

```text
CMMS_GetAssetDetail
```

### Input

```json
{
  "assetCode": "P-101"
}
```

`assetCode` es obligatorio y representa la identidad CMMS del activo.

### Resultado raíz

```json
{
  "ok": true,
  "status": "READY",
  "asset": {},
  "technicalProfile": [],
  "engineeringContext": {},
  "visualContext": {},
  "maintenanceContext": {},
  "freshness": {}
}
```

Estados raíz permitidos:

```text
READY
STALE
NOT_FOUND
UNAVAILABLE
ERROR
```

`NOT_FOUND` no se transforma en registro vacío. `ERROR` no se transforma en `UNAVAILABLE` ni en valores por defecto.

---

# 3. Asset identity

```json
{
  "assetCode": "P-101",
  "description": "Bomba centrífuga de agua de refrigeración",
  "equipmentTypeCode": "PUMP_CENTRIFUGAL_HORIZONTAL",
  "equipmentTypeLabel": "Pump — Centrifugal Horizontal",
  "lifecycleStatusCode": "IN_OPERATION",
  "lifecycleStatusLabel": "In operation",
  "criticalityCode": "A",
  "criticalityLabel": "Criticality A",
  "locationCode": "...",
  "locationLabel": "...",
  "locationPath": ["Plant", "Area", "System", "Subsystem", "Location"],
  "parentAssetCode": null,
  "relationshipType": null,
  "manufacturerName": null,
  "modelName": null,
  "serialNumber": null
}
```

### Reglas

- `assetCode`, `equipmentTypeCode` y `locationCode` son claves, no labels visuales libres.
- Manufacturer, Model y Serial pueden ser `null` si no existe dato autorizado.
- Un `null` real se muestra como no disponible; no se rellena con texto inventado.
- La UI no reconstruye `locationPath` mediante consultas adicionales.

---

# 4. Technical Profile

Cada elemento es un `TechnicalValueViewModel` resuelto.

```json
{
  "fieldKey": "DUTY_FLOW",
  "label": "Duty flow",
  "sectionKey": "OPERATING_POINT",
  "sectionLabel": "Operating point",
  "displayOrder": 10,
  "valueType": "NUMBER",
  "rawValue": 120,
  "valueDisplay": "120",
  "unitCode": "M3_H",
  "unitDisplay": "m³/h",
  "availabilityStatus": "READY",
  "isRequired": true,
  "isOverride": false,
  "provenance": {
    "type": "IMPORTED",
    "sourceSystem": "ALEP",
    "sourceReference": null,
    "sourceLabel": "Engineering data",
    "freshnessStatus": "CURRENT",
    "effectiveAt": null
  }
}
```

### AvailabilityStatus

```text
READY
UNAVAILABLE
NOT_APPLICABLE
STALE
ERROR
```

### ProvenanceType

```text
IMPORTED
SYNCED
MANUAL
DERIVED
OVERRIDE
```

### Reglas

- `valueDisplay` es el valor listo para presentación; Power Apps no hace conversiones técnicas.
- `unitDisplay` va separado del label.
- `UNAVAILABLE` no equivale a cero ni cadena vacía válida.
- `NOT_APPLICABLE` significa que el campo no corresponde al Equipment Type/activo.
- `STALE` conserva el último valor conocido solo cuando el contrato de fuente lo permite y debe seguir claramente marcado.
- los Technical Fields se ordenan por `sectionKey/displayOrder`, no por nombres de controles.

---

# 5. Engineering Context

```json
{
  "status": "READY",
  "sources": [
    {
      "sourceKey": "ALEP",
      "sourceLabel": "Engineering data",
      "sourceType": "SYSTEM_REFERENCE",
      "status": "AVAILABLE",
      "reference": null,
      "revision": null,
      "lastSyncAt": null
    }
  ],
  "documents": [
    {
      "documentId": "...",
      "documentType": "DATASHEET",
      "title": "Pump datasheet",
      "revision": "A",
      "status": "CURRENT",
      "openReference": "..."
    }
  ]
}
```

Estados:

```text
READY
EMPTY
UNAVAILABLE
STALE
ERROR
```

La UI no debe presentar una referencia externa como archivo almacenado en CMMS.

---

# 6. Visual Context

```json
{
  "status": "READY",
  "primaryVisualKind": "TYPE_ILLUSTRATION",
  "items": [
    {
      "visualId": "TYPE:PUMP_CENTRIFUGAL_HORIZONTAL",
      "visualKind": "TYPE_ILLUSTRATION",
      "label": "Type illustration",
      "assetKey": "ap-eq-pump-centrifugal-horizontal",
      "runtimeUri": null,
      "status": "READY",
      "provenance": {
        "provider": "AssetPlan Industrial Technical 3D",
        "providerAssetKey": "ap-eq-pump-centrifugal-horizontal"
      }
    }
  ]
}
```

VisualKind:

```text
TYPE_ILLUSTRATION
MODEL_IMAGE
ASSET_PHOTO
```

### Reglas

- `assetKey` es identidad de mapping; `runtimeUri` es transporte.
- la UI no conoce rutas GitHub.
- Type Illustration debe permanecer etiquetada como ilustración de tipo.
- ausencia de Asset Photo no se cubre silenciosamente con una Type Illustration.
- no existen acciones Rotate / Orbit / Explode para PNG estático.

---

# 7. Maintenance Context

Es un read model derivado del dominio de mantenimiento, no una segunda persistencia del Asset Master.

```json
{
  "status": "READY",
  "activePlan": {
    "planVersionId": "...",
    "label": "Current maintenance plan",
    "strategyLabel": "Condition based maintenance",
    "status": "PUBLISHED"
  },
  "workSummary": {
    "openWorkOrders": null,
    "overdueWorkOrders": null,
    "nextDueAt": null
  },
  "recentEvents": []
}
```

### Reglas

- métricas no disponibles son `null`, nunca `0` fabricado;
- Asset Detail no calcula overdue ni next due;
- el read model puede evolucionar con Work Management sin cambiar la identidad del Asset;
- hasta que Work Management esté validado, las capacidades no demostradas permanecen `UNAVAILABLE`.

---

# 8. Freshness

```json
{
  "assetMasterStatus": "CURRENT",
  "technicalProfileStatus": "CURRENT",
  "engineeringContextStatus": "UNKNOWN",
  "maintenanceContextStatus": "UNAVAILABLE",
  "resolvedAt": "2026-08-24T00:00:00Z"
}
```

Estados de freshness:

```text
CURRENT
STALE
UNKNOWN
UNAVAILABLE
```

Freshness pertenece al read model y no debe deducirse en Power Fx comparando fechas sin contrato.

---

# 9. Power Apps boundary

Power Apps recibe colecciones ya orientadas a UI:

```text
recAssetDetail
colAssetTechnicalValues
colAssetEngineeringSources
colAssetDocuments
colAssetVisuals
recAssetMaintenanceSummary
```

La pantalla puede:

- ordenar/presentar;
- seleccionar tabs o visuales;
- abrir acciones host-governed;
- renderizar estados.

No puede:

- decidir source authority;
- mapear DS_COLUMNx;
- convertir unidades;
- resolver EquipmentType -> AssetKey mediante lógica dispersa en controles;
- calcular KPIs de mantenimiento;
- persistir cambios desde el read contract.

---

# 10. AE6-S01

El primer consumer será:

```text
AE6-S01 — Asset Detail / Object 360 synthetic fixture
```

Objetivo de S01:

1. validar el contrato de presentación;
2. validar la composición premium;
3. validar estados de Technical Value y provenance;
4. validar Type Illustration con el runtime gate AE-G5;
5. no introducir backend productivo ni DML.

Solo después de PASS se definirá el adapter real de lectura.
