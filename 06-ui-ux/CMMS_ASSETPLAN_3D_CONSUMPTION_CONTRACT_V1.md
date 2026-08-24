# CMMS 2.0 — AssetPlan 3D Consumption Contract V1

**Fecha:** 2026-08-24  
**Track:** Asset Experience Redefinition  
**Fase:** `AE-5`  
**Gate:** `AE-G5`  
**Estado:** `CONTRACT_READY / RUNTIME_GATE_PENDING`  
**Veredicto:** `HOLD_RUNTIME_EVIDENCE`

## 1. Propósito

Definir cómo CMMS 2.0 consume la colección visual de AssetPlan sin crear una segunda biblioteca ni acoplar la UI a nombres de fichero, rutas GitHub o decisiones internas de AssetPlan.

Fuente gobernada actual:

```text
Repository: rubensv74/app_preserv
Collection: AssetPlan Industrial Technical 3D
Canonical source:
assets/equipment-illustrations/3d/runtime-hero-tight/r01/
```

Baseline observada 2026-08-24:

```text
format              PNG RGBA
background          transparent
max_dimension_px    384
target_size_kb      200
hard_limit_kb       250
asset_count         183
library_status      BASELINE_CLOSED
repository_status   SYNCED
```

Expansión genérica cerrada. Nuevos assets requieren un hueco real validado.

---

# 2. Principio de ownership

```text
AssetPlan repository = MASTER VISUAL SOURCE
CMMS                  = CONSUMER
```

CMMS sí puede mantener:

- mapping entre `EquipmentTypeCode` y `AssetKey`;
- metadata de provider/version;
- una copia de distribución generada para runtime cuando la plataforma lo necesite.

CMMS no puede mantener manualmente:

- otra colección maestra de PNG;
- variantes editadas sin upstream governance;
- nombres alternativos sin mapping/provenance;
- artwork generado únicamente para “rellenar” la UI.

---

# 3. Stable identity

CMMS referencia:

```text
AssetKey
```

No referencia como identidad funcional:

```text
FileName
relative GitHub path
batch name
local Power Apps Media name
```

Ejemplo source:

```text
AssetKey = ap-eq-pump-centrifugal-horizontal
FileName = ap-eq-pump-centrifugal-horizontal.png
```

El FileName es una propiedad de distribución. El `AssetKey` es la identidad visual externa.

---

# 4. Provider contract

## `VisualProvider`

```text
VisualProviderCode = ASSETPLAN_TECHNICAL_3D
DisplayName        = AssetPlan Industrial Technical 3D
SourceRepository   = rubensv74/app_preserv
SourceManifestPath = assets/equipment-illustrations/3d/runtime-hero-tight/r01/manifest.json
ProviderStatus
SourceVersion
LastValidatedAt
```

`SourceVersion` debe identificar el snapshot consumido.

Puede ser:

- commit SHA;
- release/tag;
- manifest version cuando exista.

No usar únicamente `R01` como prueba de contenido inmutable si el directorio evoluciona.

---

# 5. Equipment Type mapping

## `EquipmentTypeVisualMapping`

```text
EquipmentTypeCode
VisualProviderCode
AssetKey
MappingStatus
MappingReason optional
SourceVersion
IsPrimary
FallbackAssetKey optional
ValidatedAt optional
ValidatedBy optional
```

## MappingStatus

```text
DRAFT
VALID
UNMAPPED
SOURCE_MISSING
DEPRECATED
REVIEW_REQUIRED
```

### `VALID`

El AssetKey existe físicamente en el manifest y representa adecuadamente el Equipment Type.

### `UNMAPPED`

No existe mapping. No es un error de runtime.

### `SOURCE_MISSING`

El mapping apunta a una key que ya no existe en el snapshot de provider. Es error de integridad.

### `REVIEW_REQUIRED`

Existe candidato visual pero la equivalencia morfológica/semántica no está aprobada.

---

# 6. Mapping rules

1. Un `EquipmentTypeCode` puede tener como máximo una Type Illustration primaria activa por provider/version.
2. Un `AssetKey` puede reutilizarse en varios Equipment Types únicamente cuando la equivalencia visual sea deliberada.
3. No fuzzy-mapear por nombre como decisión final.
4. No crear mappings desde `Description` sin validación.
5. La ausencia de mapping no altera la clasificación del Asset.
6. El visual nunca decide Equipment Type.
7. Cambiar artwork no cambia automáticamente datos técnicos ni mantenimiento.
8. Un nuevo AssetKey upstream requiere revalidación de mappings afectados cuando sustituya una representación previa.

---

# 7. Candidate mappings from current CMMS examples

Estos mappings son evidencia de viabilidad, no seed canónico hasta que los `EquipmentTypeCode` definitivos se confirmen.

| Current example | Candidate AssetKey | Status |
|---|---|---|
| Compressor - Centrifugal Multi Stage | `ap-eq-compressor-centrifugal` | REVIEW_REQUIRED |
| Pump - Rotary Gear | `ap-eq-pump-gear` | REVIEW_REQUIRED |
| Filter - Cartridge | `ap-eq-filter-cartridge` | REVIEW_REQUIRED |
| Motor - Induction | `ap-eq-motor-electric` | REVIEW_REQUIRED |
| Transmitter - Pressure | `ap-eq-pressure-transmitter` | REVIEW_REQUIRED |

No convertir automáticamente los display names históricos del prototipo en claves de taxonomía productivas.

---

# 8. Runtime distribution strategies

GitHub no debe asumirse como CDN runtime de Power Apps.

Se admiten tres estrategias, con preferencia condicionada por la arquitectura real.

## Strategy A — Controlled Power Apps Media snapshot

```text
AssetPlan source manifest
→ governed sync/package step
→ selected PNG distribution copy
→ Power Apps Media
→ generated key resolver
```

### Ventajas

- runtime simple;
- sin dependencia web externa para cada imagen;
- adecuado para Canvas app;
- assets ya optimizados para runtime.

### Condición

La copia es **distribution artifact**, no nueva master library.

Debe poder reconstruirse desde:

```text
SourceVersion + mapping + source manifest
```

No se edita manualmente en CMMS.

## Strategy B — Governed static hosting

Ejemplos futuros posibles:

```text
SharePoint/static corporate hosting
Azure Blob/CDN
other IT-approved static endpoint
```

CMMS almacena URL versionada/resuelta.

Requiere revisar:

- autenticación;
- disponibilidad;
- caché;
- CORS/Power Apps compatibility;
- lifecycle;
- offline expectations.

## Strategy C — Direct GitHub runtime URL

```text
NOT RECOMMENDED AS PRODUCTIVE DEFAULT
```

Razones:

- repositorio/permissions no son contrato CDN;
- URLs pueden cambiar;
- dependencia innecesaria del runtime del producto con GitHub;
- governance y disponibilidad no son las mismas que un asset host productivo.

Puede utilizarse solo como laboratorio temporal y explícitamente marcado.

---

# 9. Recommended initial strategy

Para la primera implementación Power Apps:

```text
Strategy A — Controlled Media snapshot
```

pero **solo para el subconjunto realmente mapeado a Equipment Types CMMS**.

No cargar los 183 PNG indiscriminadamente en la app si el catálogo CMMS utiliza una fracción.

Beneficios:

- menor tamaño de app;
- menor ruido de Media;
- mapping trazable;
- actualización controlada;
- no se convierte CMMS en owner.

Esta recomendación debe validarse físicamente en AE-G5.

---

# 10. Distribution manifest CMMS

El build/sync debe generar un manifest derivado, no editado a mano.

Forma conceptual:

```json
{
  "provider": "ASSETPLAN_TECHNICAL_3D",
  "sourceVersion": "<commit-or-release>",
  "sourceAssetCount": 183,
  "distributedAssetCount": 5,
  "assets": [
    {
      "equipmentTypeCode": "PUMP_ROTARY_GEAR",
      "assetKey": "ap-eq-pump-gear",
      "runtimeMediaKey": "cmms_eq_pump_gear",
      "sourceFile": "ap-eq-pump-gear.png"
    }
  ]
}
```

El `runtimeMediaKey` es transport-specific y no sustituye `AssetKey`.

---

# 11. Integrity checks

Antes de publicar una distribución:

```text
[ ] source manifest readable
[ ] sourceVersion recorded
[ ] every VALID mapping AssetKey exists
[ ] every distributed PNG exists
[ ] no distributed PNG > 250 KB
[ ] max dimension <= 384 unless upstream version changes contract
[ ] transparent/background behavior sampled
[ ] duplicate runtimeMediaKey = 0
[ ] orphan distributed files = 0 or explicitly retained
[ ] unresolved mappings reported
```

No reparar silenciosamente un mapping roto eligiendo otro asset parecido.

---

# 12. Fallback policy

Orden recomendado:

```text
VALID Type Illustration
→ governed family/general illustration when explicit fallback exists
→ Equipment Type line icon
→ generic asset icon
```

Nunca:

```text
missing Type Illustration
→ random similar image
→ Asset Photo from another asset
→ generated fake model image
```

El fallback debe ser reconocible como genérico.

---

# 13. Power Apps resolver

Contrato lógico:

```text
CMMS_ResolveEquipmentTypeVisual(EquipmentTypeCode)
```

Output:

```text
VisualStatus
VisualProviderCode
AssetKey
RuntimeMediaKey or Uri
VisualKind = TYPE_ILLUSTRATION
SourceVersion
IsFallback
```

El screen/component consume este contrato; no contiene un `Switch(EquipmentTypeCode, ...)` gigante hard-coded.

V1 puede implementar el resolver mediante collection/configuration table si todavía no existe API, siempre que el mapping sea dato gobernado y no lógica dispersa por pantallas.

---

# 14. Visual component behavior

`AssetIdentityHero` y `AssetVisualGallery` reciben el resultado resuelto.

Reglas:

- mostrar label `Type Illustration` cuando material;
- alt/accessibility text usa Equipment Type display name;
- no exponer AssetKey técnico como label de usuario;
- no Rotate/Explode/Orbit;
- fullscreen, si existe, amplía imagen estática;
- loading/error/fallback distinguibles.

---

# 15. Update process

Cuando AssetPlan publica un nuevo baseline o asset:

```text
1 inspect source manifest diff
2 identify mappings affected
3 approve new/replacement mappings
4 generate CMMS distribution snapshot
5 run integrity checks
6 import/update runtime package
7 smoke test representative screens
8 record sourceVersion
```

No sincronización automática ciega a producción.

---

# 16. New visual gap process

Si CMMS tiene un Equipment Type sin representación adecuada:

```text
CMMS UNMAPPED REAL EQUIPMENT TYPE
→ check 183-asset source library
→ morphology/semantic review
→ if reusable existing asset: map it
→ if real gap: upstream AssetPlan visual governance process
→ generate + QA upstream
→ source manifest update
→ consume new sourceVersion in CMMS
```

CMMS no genera el PNG en una rama visual propia.

---

# 17. Performance gate

AE-G5 requiere evidencia real en la plataforma objetivo.

Mínimo:

```text
1. import a representative subset
2. render Assets/Asset Detail candidate
3. test initial load
4. test row/list density without loading large hero images per row
5. test hero swap between several Equipment Types
6. confirm no visible background/bounds defects
7. confirm app size impact
8. confirm fallback behavior
9. save / close / reopen
10. App Checker / runtime smoke as applicable
```

Representative set mínimo sugerido:

```text
centrifugal pump
motor
centrifugal compressor
vessel/tank
instrument or valve
```

---

# 18. Gate AE-G5

## Contract portion

```text
[x] external source of truth fixed
[x] stable AssetKey identity selected
[x] CMMS mapping contract defined
[x] runtime distribution alternatives defined
[x] recommended initial strategy defined
[x] derived manifest contract defined
[x] integrity checks defined
[x] fallback policy defined
[x] resolver contract defined
[x] update process defined
[x] real-gap upstream process defined
[x] fake 3D behavior prohibited
```

## Runtime portion

```text
[ ] physical Power Apps media/import tested
[ ] representative subset rendered
[ ] performance/app-size measured
[ ] fallback tested
[ ] sourceVersion reconstruction proven
[ ] Studio save/close/reopen evidence
```

## Verdict

```text
AE-G5 CONTRACT = PASS
AE-G5 RUNTIME  = HOLD
AE-5           = READY_FOR_RUNTIME_GATE
```

This is the first real gate that cannot be closed honestly from repository documentation alone.

Do not advance to productive AE-6 implementation as if AE-G5 had passed. The next action is to create the first Power Apps Asset Detail baseline together with a controlled representative visual subset and execute the runtime gate.
