# CMMS 2.0 — SHELL-C01 Base Frame

**Fecha:** 2026-08-22  
**Estado:** ready for Power Apps Studio  
**Scope:** primer bloque visual ejecutable del Premium App Shell.

## 1. Objetivo

Construir un frame premium estable que pueda reutilizarse en las pantallas de CMMS 2.0 sin introducir todavía navegación, datos o reglas funcionales.

Resultado esperado:

```text
scr_Home
└── conAppRoot
    ├── conSidebar
    │   ├── conBrand
    │   └── conSidebarBody
    └── conMain
        ├── conTopBar
        └── conPageArea
            ├── conPageHeader
            └── conContentHost
```

SHELL-C01 no crea todavía un custom component. Primero se valida geometría, responsive behavior y controles reales en Studio. Una vez estable, se decidirá qué partes conviene encapsular como componentes reutilizables.

## 2. App settings recomendados

Para una Canvas App responsive:

- Scale to fit: Off
- Lock aspect ratio: Off
- Lock orientation: Off

Target visual de referencia: 1440×900, pero el frame debe usar `Parent.Width`/`Parent.Height` y contenedores para adaptarse.

## 3. Tokens iniciales

Se congelan para el primer specimen visual; podrán refinarse tras QA.

```text
Canvas:             ColorValue("#F6F8FB")
Sidebar:            ColorValue("#0B1628")
SidebarHover:       ColorValue("#14243A")
SidebarSelected:    ColorValue("#173A63")
Surface:            Color.White
Border:             ColorValue("#E4EAF1")
TextPrimary:        ColorValue("#172033")
TextSecondary:      ColorValue("#5C667A")
TextMuted:          ColorValue("#8993A5")
Primary:            ColorValue("#1769E0")
PrimaryHover:       ColorValue("#1359BF")
Success:            ColorValue("#198754")
Warning:            ColorValue("#B86B00")
Danger:             ColorValue("#C9363E")
Info:               ColorValue("#2563EB")
```

Geometry:

```text
SidebarExpanded = 248
SidebarCollapsed = 72
TopBarHeight = 64
PagePaddingDesktop = 24
PagePaddingCompact = 16
RadiusCard = 12
GapMajor = 16
```

## 4. App.OnStart

Create only UI tokens and shell state. No screen-specific source data here.

```powerfx
Set(gblTheme,
    {
        Canvas: ColorValue("#F6F8FB"),
        Sidebar: ColorValue("#0B1628"),
        SidebarHover: ColorValue("#14243A"),
        SidebarSelected: ColorValue("#173A63"),
        Surface: Color.White,
        Border: ColorValue("#E4EAF1"),
        TextPrimary: ColorValue("#172033"),
        TextSecondary: ColorValue("#5C667A"),
        TextMuted: ColorValue("#8993A5"),
        Primary: ColorValue("#1769E0"),
        PrimaryHover: ColorValue("#1359BF"),
        Success: ColorValue("#198754"),
        Warning: ColorValue("#B86B00"),
        Danger: ColorValue("#C9363E"),
        Info: ColorValue("#2563EB")
    }
);

Set(gblLayout,
    {
        SidebarExpanded: 248,
        SidebarCollapsed: 72,
        TopBarHeight: 64,
        PagePaddingDesktop: 24,
        PagePaddingCompact: 16,
        RadiusCard: 12,
        GapMajor: 16
    }
);

Set(gblSidebarCollapsed, false);
Set(gblSelectedNavKey, "home");
Set(gblShellReady, true);
```

If Power Apps Studio uses a locale where `;` is an argument separator, translate separators automatically using the editor; do not change the logical structure.

## 5. Screen

Create blank responsive screen:

```text
scr_Home
```

Properties:

```powerfx
Fill = gblTheme.Canvas
```

## 6. Root container

Insert Horizontal container:

```text
conAppRoot
```

Properties:

```powerfx
X = 0
Y = 0
Width = Parent.Width
Height = Parent.Height
Gap = 0
PaddingTop = 0
PaddingBottom = 0
PaddingLeft = 0
PaddingRight = 0
Fill = gblTheme.Canvas
```

## 7. Sidebar

Inside `conAppRoot`, insert Vertical container:

```text
conSidebar
```

Properties:

```powerfx
Width = If(gblSidebarCollapsed, gblLayout.SidebarCollapsed, gblLayout.SidebarExpanded)
Height = Parent.Height
Fill = gblTheme.Sidebar
Gap = 0
PaddingTop = 0
PaddingBottom = 0
PaddingLeft = 0
PaddingRight = 0
```

Turn Flexible width off for the sidebar. Main area receives remaining width.

### 7.1 Brand region

Insert Horizontal container:

```text
conBrand
```

Properties:

```powerfx
Height = 72
Fill = Color.Transparent
PaddingLeft = If(gblSidebarCollapsed, 16, 20)
PaddingRight = 16
PaddingTop = 16
PaddingBottom = 16
Align = Align.Center
```

Add a small square/rounded brand mark `shpBrandMark`:

```powerfx
Width = 34
Height = 34
Fill = gblTheme.Primary
BorderThickness = 0
RadiusTopLeft = 9
RadiusTopRight = 9
RadiusBottomLeft = 9
RadiusBottomRight = 9
```

Add label `lblBrand`:

```powerfx
Text = "CMMS 2.0"
Visible = !gblSidebarCollapsed
Color = Color.White
Size = 17
FontWeight = FontWeight.Semibold
Fill = Color.Transparent
```

Add icon/button `icoSidebarToggle` aligned right:

```powerfx
OnSelect = Set(gblSidebarCollapsed, !gblSidebarCollapsed)
Color = ColorValue("#B8C4D6")
HoverColor = Color.White
```

### 7.2 Sidebar body placeholder

Insert Vertical container:

```text
conSidebarBody
```

Properties:

```powerfx
Fill = Color.Transparent
PaddingTop = 12
PaddingLeft = 12
PaddingRight = 12
PaddingBottom = 16
Gap = 8
```

For SHELL-C01 add only one temporary Home navigation row. It will be replaced in SHELL-C02 by the grouped navigation contract.

Create button/row `btnNavHome`:

```powerfx
Text = If(gblSidebarCollapsed, "⌂", "  Home")
Height = 44
Fill = If(gblSelectedNavKey = "home", gblTheme.SidebarSelected, Color.Transparent)
Color = Color.White
BorderThickness = 0
RadiusTopLeft = 9
RadiusTopRight = 9
RadiusBottomLeft = 9
RadiusBottomRight = 9
OnSelect = Set(gblSelectedNavKey, "home")
```

## 8. Main area

Inside `conAppRoot`, after sidebar, insert Vertical container:

```text
conMain
```

Properties:

```powerfx
Fill = gblTheme.Canvas
Height = Parent.Height
Gap = 0
```

Flexible width = On.

## 9. Top bar

Inside `conMain`, insert Horizontal container:

```text
conTopBar
```

Properties:

```powerfx
Height = gblLayout.TopBarHeight
Fill = gblTheme.Surface
PaddingLeft = 24
PaddingRight = 24
PaddingTop = 10
PaddingBottom = 10
Gap = 12
```

Add `lblContextMode`:

```powerfx
Text = "PROJECT"
Color = gblTheme.TextMuted
Size = 10
FontWeight = FontWeight.Semibold
```

Add `lblProjectContext`:

```powerfx
Text = "No project selected"
Color = gblTheme.TextPrimary
Size = 14
FontWeight = FontWeight.Semibold
```

Add a flexible spacer container.

Add temporary `btnSearchShell`:

```powerfx
Text = "Search"
Fill = Color.Transparent
Color = gblTheme.TextSecondary
BorderColor = gblTheme.Border
BorderThickness = 1
Height = 36
```

Add temporary `btnNeedsAttentionShell`:

```powerfx
Text = "Needs attention"
Fill = Color.Transparent
Color = gblTheme.TextSecondary
BorderColor = gblTheme.Border
BorderThickness = 1
Height = 36
```

Add circular/compact user placeholder `btnUserShell`:

```powerfx
Text = "RS"
Width = 36
Height = 36
Fill = ColorValue("#E8EEF7")
Color = gblTheme.TextPrimary
BorderThickness = 0
```

## 10. Page area

Inside `conMain`, insert Vertical container:

```text
conPageArea
```

Properties:

```powerfx
Fill = gblTheme.Canvas
PaddingLeft = If(App.Width < 900, gblLayout.PagePaddingCompact, gblLayout.PagePaddingDesktop)
PaddingRight = If(App.Width < 900, gblLayout.PagePaddingCompact, gblLayout.PagePaddingDesktop)
PaddingTop = 22
PaddingBottom = 24
Gap = 16
```

## 11. Page header specimen

Inside `conPageArea`, insert Vertical container:

```text
conPageHeader
```

Properties:

```powerfx
Height = 82
Fill = Color.Transparent
Gap = 4
```

Add label `lblPageEyebrow`:

```powerfx
Text = "OVERVIEW"
Color = gblTheme.Primary
Size = 10
FontWeight = FontWeight.Semibold
```

Add label `lblPageTitle`:

```powerfx
Text = "CMMS 2.0"
Color = gblTheme.TextPrimary
Size = 28
FontWeight = FontWeight.Semibold
```

Add label `lblPageSubtitle`:

```powerfx
Text = "Configure maintenance engineering from asset structure to published maintenance plan."
Color = gblTheme.TextSecondary
Size = 12
```

## 12. Content host specimen

Inside `conPageArea`, insert Vertical container:

```text
conContentHost
```

Properties:

```powerfx
Fill = gblTheme.Surface
BorderColor = gblTheme.Border
BorderThickness = 1
RadiusTopLeft = gblLayout.RadiusCard
RadiusTopRight = gblLayout.RadiusCard
RadiusBottomLeft = gblLayout.RadiusCard
RadiusBottomRight = gblLayout.RadiusCard
PaddingLeft = 24
PaddingRight = 24
PaddingTop = 24
PaddingBottom = 24
```

Add temporary labels:

```text
lblShellReadyTitle = "Premium shell ready"
lblShellReadyText  = "Navigation and project context will be connected in the next increment."
```

Typography:

```powerfx
lblShellReadyTitle.Color = gblTheme.TextPrimary
lblShellReadyTitle.Size = 18
lblShellReadyTitle.FontWeight = FontWeight.Semibold
lblShellReadyText.Color = gblTheme.TextSecondary
lblShellReadyText.Size = 12
```

## 13. Acceptance gate SHELL-C01

PASS only if:

1. Screen fills full browser canvas with no accidental outer scrollbar.
2. Sidebar width toggles 248 ↔ 72 without overlapping main content.
3. Main content automatically takes remaining width.
4. Top bar stays 64 px high.
5. At 1440×900 the UI feels spacious but operational, not dashboard-decoration-heavy.
6. At approximately 1024 px width the shell remains usable.
7. `gblTheme` is the only source of the colors used in the specimen, apart from explicitly temporary neutral values.
8. No business data is hardcoded into screen controls beyond placeholder copy.
9. No App Checker errors caused by the shell controls.
10. A screenshot is captured before proceeding to SHELL-C02.

## 14. Next increment

`SHELL-C02 — Grouped Navigation`

Will replace the temporary Home button with grouped modules:

```text
HOME
PROJECT SETUP
ASSETS
LIBRARIES
MAINTENANCE ENGINEERING
PLANS
GOVERNANCE
ADMINISTRATION
```

It will support selected state, collapsed mode, role/context visibility and `Coming later` destinations without pretending they are implemented.
