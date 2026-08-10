# cmp_FL_SidebarPro — Component Specification

**Status:** Draft / pending Studio validation  
**Increment:** F01-00A  
**Purpose:** navegación premium común del CMMS 2.0 Functional Lab.

## 1. Responsibility

Proporcionar navegación persistente entre workspaces del Functional Lab sin conocer la lógica interna de cada workspace.

El componente:

- muestra identidad del producto;
- muestra los workspaces disponibles;
- destaca el workspace activo;
- expone la selección realizada;
- muestra el caso actual y el rol de demostración;
- soporta modo compacto/expandido.

No debe:

- ejecutar lógica de negocio;
- decidir si un gate permite avanzar;
- cargar fixtures;
- navegar directamente a pantallas concretas;
- depender de variables globales de PULSE o del Functional Lab.

## 2. Public contract

### Inputs

```text
AppTitle          Text
AppSubtitle       Text
EnvironmentLabel  Text
ActiveKey         Text
NavItems          Table
IsCollapsed       Boolean
CurrentCaseCode   Text
CurrentCaseName   Text
UserRole          Text
SurfaceColor      Color
SurfaceAltColor   Color
TextColor         Color
MutedTextColor    Color
AccentColor       Color
ActiveFillColor   Color
```

Expected `NavItems` shape:

```text
Order
Key
Label
IconKey
```

### Output

```text
SelectedKey       Text
```

### Event

```text
OnSelectItem()
```

La pantalla host recibe el evento y decide qué hacer con `SelectedKey`.

## 3. Supported states

```text
Default
Active item
Hover
Pressed
Collapsed
Expanded
No case selected
Case selected
```

## 4. Visual contract

Expanded width: 220 px  
Collapsed width: 76 px

Estructura:

```text
Product identity
Navigation list
Flexible spacer
Current case context
Role / environment
```

Principios:

- navegación oscura y estable;
- activo identificado mediante fondo + barra/acento, no solo color de texto;
- sin logo/asset obligatorio;
- icono + label en expandido;
- icono centrado en colapsado;
- contexto de caso secundario y no competidor con navegación.

## 5. Compatibility constraints

- `GroupContainer@1.5.0` para geometría y radios.
- `Gallery@2.15.0` para navegación.
- `Classic/Icon@2.5.0` para iconografía inicial.
- `Label@2.5.1` sin propiedades `Radius*`.
- `Classic/Button@2.2.0` sin `AccessibleLabel` hasta validación específica.
- `ModernText@1.0.0` estático con `AutoHeight=true` por defecto.
- sin SVG inline.
- sin assets de imagen externos.
- sin variables globales internas.

## 6. Initial icon vocabulary

```text
Overview
Context
Functions
Risk
Decision
Plan
Governance
Improve
Settings
```

El vocabulario se traducirá internamente a iconos Classic seguros. Si una clave no se reconoce, se utilizará un icono neutro.

## 7. Validation for F01-00A

Después de pegar el componente en Power Apps Studio:

```text
[ ] ComponentDefinitions aceptado
[ ] no PA1001
[ ] no PA2108
[ ] no dependencia de asset inexistente
[ ] no fórmula con variable global interna
[ ] render expanded correcto
[ ] render collapsed correcto
[ ] item activo visible
[ ] click cambia SelectedKey
[ ] OnSelectItem se dispara
[ ] texto sin clipping/mini-scrollbars
[ ] App Checker sin nuevos errores atribuibles al componente
```

El componente permanecerá `Draft` hasta superar esta prueba en la app real.
