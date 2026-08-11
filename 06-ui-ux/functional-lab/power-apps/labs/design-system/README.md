# scr_DesignSystemLab — construcción modular

**Tipo:** utility screen técnica.  
**No forma parte:** de las 25 pantallas funcionales ni de la navegación del CMMS.  
**Autoridad:** `30-playbooks/power-platform/modular-power-apps-screen-construction.md`.

## Propósito

Aislar la validación de tokens, color y comportamiento visual de Power Apps antes de propagar cambios a componentes o pantallas funcionalmente estables.

## Secuencia

```text
DS-S01  Skeleton + placeholders
        ↓ validate / freeze geometry
DS-C01  Semantic token roles
        ↓ validate
DS-C02  Classic + Modern controls
        ↓ validate
DS-C03  Interaction states
        ↓ validate
DS-C04  Data visualisation roles
        ↓ validate
DS-H01  Contrast / accessibility / theme consolidation
        ↓
COLOR FOUNDATION APPROVED
```

No generar DS-C01 hasta que DS-S01 haya sido pegado y aprobado en Studio.

---

# DS-S01 — Screen skeleton

## BLOCK

```text
BLOCK DS-S01 — Design System Lab skeleton
Operation: CREATE / REPLACE SCREEN STRUCTURE
Target control/property: scr_DesignSystemLab
Parent/anchor: screen root
Dependencies: none
Scope: structural geometry + placeholders only
Compatibility: GroupContainer@1.5.0 + ModernText@1.0.0; no component dependency
Expected status: STRUCTURE FROZEN after Studio validation
```

## TOUCHES

```text
scr_DesignSystemLab only
```

## DO NOT MODIFY

```text
scr_FL_Home
scr_FL_FLH
scr_FL_Taxonomy
scr_FL_ADR
scr_FL_AMEF
all reusable components
bootstrap
navigation
```

## Placeholder contracts

### ph_TokenRoles

```text
Purpose: semantic token swatches and role names
Geometry: top row, left ~64%
Future content: DS-C01 token roles
Expected inputs: none at S01
Expected outputs/events: none
Status: STRUCTURAL
```

### ph_Text

```text
Purpose: typography samples and long-text checks
Geometry: top row, right ~36%
Future content: typography / overflow sample set
Expected inputs: shared typography roles
Expected outputs/events: none
Status: STRUCTURAL
```

### ph_ClassicControls

```text
Purpose: Classic control rendering
Geometry: second row, first quarter
Future content: buttons/inputs/labels
Status: STRUCTURAL
```

### ph_ModernControls

```text
Purpose: Modern control rendering
Geometry: second row, second quarter
Future content: Modern text/input/control states
Status: STRUCTURAL
```

### ph_InteractionStates

```text
Purpose: Default/Hover/Pressed/Selected/Disabled/Focus samples
Geometry: second row, third quarter
Future content: DS-C03
Status: STRUCTURAL
```

### ph_DataViz

```text
Purpose: chart/data-role palette validation
Geometry: second row, fourth quarter
Future content: DS-C04
Status: STRUCTURAL
```

### ph_Status

```text
Purpose: display lab validation state and notes
Geometry: full-width bottom row
Future content: gate summary / validation notes
Status: STRUCTURAL
```

## Validation DS-S01

Después de pegar:

```text
TEST 1 — scr_DesignSystemLab carga/renderiza
TEST 2 — cero error Power Fx bloqueante nuevo
TEST 3 — siete placeholders visibles y no solapados
TEST 4 — ninguna pantalla/componente funcional fue modificado
TEST 5 — geometría legible a 100%; textos >=11; sin clipping
```

Si pasa, registrar:

```text
scr_DesignSystemLab
STRUCTURE = FROZEN
BEHAVIOR = OPEN
COLOR = PENDING
STATUS = IN_CONSTRUCTION
```

Solo entonces se redacta/pega `DS-C01`.
