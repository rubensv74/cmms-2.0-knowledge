# scr_DesignSystemLab — construcción modular

**Tipo:** utility screen técnica.  
**No forma parte:** de las 25 pantallas funcionales ni de la navegación del CMMS.  
**Autoridad:** `30-playbooks/power-platform/modular-power-apps-screen-construction.md`.

## Propósito

Aislar la validación de tokens, color y comportamiento visual de Power Apps antes de propagar cambios a componentes o pantallas funcionalmente estables.

## Secuencia

```text
DS-S01  Skeleton + placeholders             ✅ STRUCTURE FROZEN
        ↓
DS-C01  Semantic token roles                ← ACTIVO
        ↓ validate
DS-C02  Classic + Modern controls            PLANNED
        ↓ validate
DS-C03  Interaction states                   PLANNED
        ↓ validate
DS-C04  Data visualisation roles             PLANNED
        ↓ validate
DS-H01  Contrast / accessibility / theme     PLANNED
        ↓
COLOR FOUNDATION APPROVED
```

No generar el siguiente bloque hasta validar el actual en Studio.

---

# DS-S01 — Screen skeleton

**Resultado Studio:** `DS-S01 STRUCTURE FROZEN` confirmado el 2026-08-12.

Quedan congelados X/Y/Width/Height y distribución de:

```text
conDSLabRoot
conDSLabHeader
conDSLabBody
ph_TokenRoles
ph_Text
ph_ClassicControls
ph_ModernControls
ph_InteractionStates
ph_DataViz
ph_Status
```

Un bloque C puede sustituir el contenido de su placeholder, pero no rediseñar el slot.

---

# DS-C01 — Semantic Token Roles

## BLOCK

```text
BLOCK DS-C01 — Semantic Token Roles
Operation: REPLACE CONTROL
Target: ph_TokenRoles
Parent/anchor: conDSLabBody
Dependencies: DS-S01 STRUCTURE FROZEN
Scope: semantic role swatches only
Expected status after PASS: DS-C01 VISUAL_APPROVED; COLOR remains PENDING
```

## TOUCHES

```text
ph_TokenRoles only
```

## DO NOT MODIFY

```text
ph_Text
ph_ClassicControls
ph_ModernControls
ph_InteractionStates
ph_DataViz
ph_Status
conDSLabBody geometry
header
all Functional Lab screens
all reusable Functional Lab components
```

## Roles candidatos a validar

```text
Background            #F6F8FB
Surface               #FFFFFF
SurfaceAlt            #F8FAFC
Border                #E2E8F0
TextPrimary           #0F172A
TextSecondary         #64748B
Primary               #0284C7
PrimaryHover          #0369A1
PrimarySelected       #075985
SelectedBackground    #EFF6FF
SelectedBorder        #BFDBFE
SelectedAccent        #2563EB
SelectedText          #1D4ED8
Success               #15803D
Warning               #B45309
Danger                #B91C1C
```

Estos valores son **candidatos de Theme**. No se propagan a componentes después de DS-C01; todavía deben superar controles/estados/data visualisation.

## Archivo

`DS-C01_semantic_token_roles.pa.yaml`

El archivo sustituye únicamente el bloque existente `- ph_TokenRoles:` dentro de `conDSLabBody.Children`.

## Validation DS-C01

```text
TEST 1 — Studio acepta y guarda el bloque
TEST 2 — no aparece error bloqueante nuevo
TEST 3 — los 16 roles muestran el color esperado, sin negro inesperado
TEST 4 — nombres y HEX son legibles
TEST 5 — no hay clipping/solapamiento dentro de ph_TokenRoles
TEST 6 — X/Y/Width/Height del placeholder no cambian
TEST 7 — ninguna otra zona del DesignSystemLab cambia
```

Si pasa, registrar:

```text
DS-C01 PASS
DS-C01 VISUAL_APPROVED
COLOR = PENDING
```

Solo entonces se genera `DS-C02`.
