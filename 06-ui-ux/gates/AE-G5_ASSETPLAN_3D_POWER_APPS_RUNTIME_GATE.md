# CMMS 2.0 — AE-G5 AssetPlan 3D Power Apps Runtime Gate

**Fecha:** 2026-08-24  
**Gate:** `AE-G5`  
**Estado inicial:** `WAITING_USER_TOOL_GATE`  
**Objetivo:** demostrar que CMMS puede consumir una distribución controlada de ilustraciones AssetPlan en la Canvas app real sin degradación visual, tamaño excesivo ni segunda fuente de verdad.

## 1. Prerrequisitos

Antes de ejecutar:

```text
[ ] Canvas app CMMS / Functional Lab disponible en Power Apps Studio
[ ] Premium App Shell Foundation importable o baseline de lab suficiente
[ ] acceso al repositorio rubensv74/app_preserv
[ ] source manifest actual revisado
```

Si la Canvas app aún no está disponible, el gate permanece `WAITING_USER_TOOL_GATE`; no se sustituye con HTML/mockup.

---

# 2. Source baseline

Fuente:

```text
rubensv74/app_preserv
assets/equipment-illustrations/3d/runtime-hero-tight/r01/
manifest.json
```

Contrato actual observado:

```text
183 assets
PNG RGBA
transparent
max 384 px
hard limit 250 KB
BASELINE_CLOSED
```

Registrar el commit/sourceVersion exacto utilizado el día de la prueba.

---

# 3. Representative subset

Importar únicamente estos cinco assets para el smoke inicial:

```text
ap-eq-pump-centrifugal-horizontal.png
ap-eq-motor-electric.png
ap-eq-compressor-centrifugal.png
ap-eq-vessel-horizontal.png
ap-eq-pressure-transmitter.png
```

AssetKeys:

```text
ap-eq-pump-centrifugal-horizontal
ap-eq-motor-electric
ap-eq-compressor-centrifugal
ap-eq-vessel-horizontal
ap-eq-pressure-transmitter
```

Motivo:

- rotating equipment;
- electrical;
- pressure/static equipment;
- instrumentation;
- distintos aspect ratios/morfologías.

No importar los 183 assets para este gate.

---

# 4. Runtime media naming

Usar nombres de distribución CMMS deterministas, por ejemplo:

```text
cmms_eq_pump_centrifugal_horizontal
cmms_eq_motor_electric
cmms_eq_compressor_centrifugal
cmms_eq_vessel_horizontal
cmms_eq_pressure_transmitter
```

No renombrar el `AssetKey` de origen; el runtime media name es una propiedad de transporte.

Registrar mapping temporal de gate:

| Equipment Type candidate | AssetKey | Runtime Media |
|---|---|---|
| Centrifugal Pump | `ap-eq-pump-centrifugal-horizontal` | `cmms_eq_pump_centrifugal_horizontal` |
| Electric Motor | `ap-eq-motor-electric` | `cmms_eq_motor_electric` |
| Centrifugal Compressor | `ap-eq-compressor-centrifugal` | `cmms_eq_compressor_centrifugal` |
| Horizontal Vessel | `ap-eq-vessel-horizontal` | `cmms_eq_vessel_horizontal` |
| Pressure Transmitter | `ap-eq-pressure-transmitter` | `cmms_eq_pressure_transmitter` |

Los Equipment Type names son de prueba; no crean taxonomía productiva.

---

# 5. Gate surface

No es necesario construir Asset Detail completo para probar el transporte.

Crear/usar una superficie de lab mínima con:

```text
Equipment Type selector/list
→ resolved static illustration
→ label VisualKind = Type Illustration
→ source/status metadata
```

Debe existir un caso sin mapping para validar fallback.

No añadir:

```text
Rotate
Explode
Orbit
fake 3D controls
```

---

# 6. Test cases

## G5-T01 — Media import

Expected:

```text
5/5 PNG import successfully
no conversion/background defect
```

## G5-T02 — Resolver

Seleccionar los cinco tipos.

Expected:

```text
correct AssetKey -> correct runtime image
no screen-specific Switch duplicated across controls
```

Para el gate puede existir una collection temporal gobernada; debe quedar claramente identificada como candidate mapping.

## G5-T03 — Unmapped fallback

Usar un tipo de prueba sin mapping.

Expected:

```text
status = UNMAPPED
fallback = Equipment Type icon or generic asset icon
no random image
```

## G5-T04 — Visual quality

Comprobar para cada PNG:

```text
transparent background
no clipping
no excessive whitespace
recognizable at hero size
recognizable at compact preview where used
```

No aprobar como icono 24 px; el test compacto solo valida preview/thumbnail.

## G5-T05 — Performance

Registrar:

```text
app size before subset
app size after subset
first render behavior
switch behavior between images
observable lag/errors
```

No fijar threshold inventado. Registrar evidencia y decidir con comportamiento real.

## G5-T06 — State behavior

Comprobar:

```text
READY
UNMAPPED
ERROR/invalid key simulation if practical
```

`UNMAPPED` no debe parecer `ERROR`.

## G5-T07 — Save / close / reopen

```text
Save app
Close Studio
Reopen app
Open gate surface
Repeat 5 mappings + fallback
```

Expected: no pérdida de media/mapping candidate.

## G5-T08 — App Checker

Ejecutar cuando el estado de la app lo permita.

Registrar únicamente issues introducidos/afectados por este incremento; no confundir deuda previa con fallo del gate.

---

# 7. Evidence to capture

Guardar como evidencia:

```text
sourceVersion / commit
five source AssetKeys
runtime media names
app size before/after
full-screen Studio capture
fallback capture
test result table
App Checker note
save/close/reopen result
```

Ruta sugerida:

```text
06-ui-ux/gates/evidence/AE-G5_YYYY-MM-DD/
```

---

# 8. Result template

```text
AE-G5 POWER APPS RUNTIME GATE
Date:
App:
SourceVersion:

T01 Media import:          PASS / FAIL
T02 Resolver:              PASS / FAIL
T03 Unmapped fallback:     PASS / FAIL
T04 Visual quality:        PASS / FAIL
T05 Performance:           PASS / FAIL / REVIEW
T06 State behavior:        PASS / FAIL
T07 Save-close-reopen:     PASS / FAIL
T08 App Checker:           PASS / WARN / FAIL

App size before:
App size after:
Delta:

Blocking findings:
Warnings:

VERDICT:
PASS / PASS_WITH_WARNINGS / HOLD / FAIL
```

---

# 9. Promotion rule

`AE-G5 = PASS` permite iniciar `AE-6` únicamente para la foundation que ha demostrado el consumo visual y sus dependencias.

No significa:

- 183 Equipment Types mapeados;
- Asset Detail completo;
- icon system completo;
- Model Image soportado;
- Asset Photos soportadas;
- Visual Approval final.

Es un gate de **transporte/runtime del Type Illustration system**.

---

# 10. Failure handling

Si falla por app size/performance:

```text
DO NOT reduce image quality ad-hoc inside CMMS
```

Revisar en este orden:

1. subset/distribution strategy;
2. lazy use / avoid hero images in list rows;
3. external governed hosting strategy;
4. upstream optimization only if evidence shows source asset problem.

Si falla por missing/mismatched visual:

1. revisar mapping;
2. revisar source manifest;
3. marcar `SOURCE_MISSING` / `REVIEW_REQUIRED`;
4. no fuzzy-substitute silently.
