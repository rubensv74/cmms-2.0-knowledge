# BLOCK S-AMEF-01 — AMEF full screen skeleton

**Type:** `S — Structural`  
**Status:** `PLANNED` — no YAML generated until previous gates pass.  
**Authority:** `30-playbooks/power-platform/modular-power-apps-screen-construction.md`

## Operation

```text
CREATE / REPLACE SCREEN STRUCTURE
```

## Target

```text
scr_FL_AMEF
```

## Preconditions

No generar ni pegar el YAML de este bloque hasta completar:

```text
PREP-01               screen identities resolved
DS-S01                 DesignSystemLab geometry frozen
COLOR FOUNDATION       approved or explicitly still pending without blocking structure
ProcessRail            READY_FOR_INTEGRATION for structure/legibility
RiskMatrix             READY_FOR_INTEGRATION for geometry/selection
```

Color puede permanecer `PENDING`; no bloquea el skeleton.

## Purpose

Crear la geometría completa de AMEF con placeholders y demostrar que la pantalla puede alojar, sin solapamiento ni compresión tipográfica:

```text
Sidebar
Header
Process Rail
stage context
primary workspace
status/action region
RiskMatrix 900×650 en FL-09
```

No introducir lógica AMEF, selección S/O/D, decisiones, gate logic ni componentes reales en este bloque.

## Target tree

```text
scr_FL_AMEF
└── Root
    ├── ph_Sidebar
    └── Main
        ├── ph_Header
        └── Body
            ├── ph_ProcessRail
            └── Workspace
                ├── ph_StageContext
                ├── ph_PrimaryWorkspace
                └── ph_StatusAction
```

## Geometry contract — desktop

### ph_Sidebar

```text
Purpose          product navigation slot
Target width     76 px collapsed in dense AnalysisCase workspace
Height           App.Height
Frozen after S01 yes
Future component cmp_FL_SidebarPro
```

### Main

```text
X                ph_Sidebar.Width
Width            App.Width - ph_Sidebar.Width
Height           App.Height
```

### ph_Header

```text
Purpose          page/case/journey header
Target height    112 px
Width            Main.Width
Future component cmp_FL_PageHeaderPro
```

### Body

```text
Y                ph_Header.Height + 12
Height           Main.Height - Self.Y - 12
Width            Main.Width - 24
X                12
```

### ph_ProcessRail

```text
Purpose          FL-01…FL-28 navigation/progress
Target width     300 px desktop
Height           Body.Height
Scroll           vertical inside future component
Future component cmp_FL_ProcessRailPro
```

Do not reduce rail typography to compensate for narrow width.

### Workspace

```text
X                ph_ProcessRail.Width + 16
Width            Body.Width - Self.X
Height           Body.Height
```

Desktop target should leave at least ~940–960 px useful width when the window allows it so a 900 px RiskMatrix has breathing room.

### ph_StageContext

```text
Purpose          lineage/context/reference strip
Height           126 px when visible
Behavior         optional/collapsible by stage in a later I block
Future content   cmp_FL_LineagePanelPro or contextual stage content
```

### ph_PrimaryWorkspace

```text
Purpose          dominant work area of the current AMEF stage
Width            Workspace.Width
Height           available height after optional slots
Requirement      FL-09 mode must accommodate 900×650 RiskMatrix without scaling it down
```

### ph_StatusAction

```text
Purpose          decision/control-of-advance region
Position         independent lower/side slot according to approved skeleton
Behavior         can be hidden for stages where not applicable
Future content   DecisionPanel / GatePanel, introduced in separate C blocks
```

## Responsive contract

At widths where the desktop composition cannot preserve:

```text
ProcessRail readable width
+ primary workspace >= RiskMatrix width
```

the skeleton must choose an explicit responsive strategy in a later structural block rather than shrink text or matrix cells.

Permitted future strategies:

```text
collapse global Sidebar
horizontal/vertical reflow of non-critical context panels
intentional page scroll
```

Not permitted:

```text
font <11
RiskMatrix compressed below approved reference solely to fit
ProcessRail label truncation accepted as normal
```

## TOUCHES

```text
scr_FL_AMEF structure only
```

## DO NOT MODIFY

```text
cmp_FL_SidebarPro
cmp_FL_PageHeaderPro
cmp_FL_ProcessRailPro
cmp_FL_RiskMatrixPro
cmp_FL_DecisionPanelPro
cmp_FL_GatePanelPro
cmp_FL_LineagePanelPro
scr_FL_Home
scr_FL_FLH
scr_FL_Taxonomy
scr_FL_ADR
scr_FL_FmeaLibrary
scr_FL_FmeaRevision
scr_FL_AssetApplication
bootstrap
FMEA/RCM data contracts
```

## No behavior in S-AMEF-01

Do not implement:

```text
OnSelectStage
stage visibility switching
risk calculation
human decision
advance control
navigation to other AnalysisCase screens
```

Those belong to C/I blocks after geometry freeze.

## Validation

```text
TEST 1 — screen loads and saves
TEST 2 — no new blocking App Checker error
TEST 3 — all placeholders visible and non-overlapping
TEST 4 — rail slot is readable at target width
TEST 5 — primary workspace demonstrates a 900×650 reference rectangle fits for FL-09
TEST 6 — no visible text <11
TEST 7 — no frozen external screen/component changed
TEST 8 — scroll behavior is intentional
```

## Expected result

If approved in Studio:

```text
scr_FL_AMEF
STATUS          IN_CONSTRUCTION
STRUCTURE       FROZEN
BEHAVIOR        OPEN
DATA CONTRACT   FROZEN / inherited
COLOR           PENDING
```

Only then generate `C-AMEF-01`.
