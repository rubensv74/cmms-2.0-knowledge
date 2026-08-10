# cmp_FL_SidebarPro — Component Specification

**Status:** REVIEW_REQUIRED / FL-SC-001 diagnostic reconstruction  
**Increment:** F01-00A  
**Purpose:** navegación premium común del CMMS 2.0 Functional Lab.

## 1. Responsibility

Proporcionar navegación persistente entre workspaces del Functional Lab sin conocer la lógica interna de cada workspace.

El componente final deberá:

- mostrar identidad del producto;
- mostrar los workspaces disponibles;
- destacar el workspace activo;
- exponer la selección realizada;
- mostrar el caso actual y el rol de demostración;
- soportar modo compacto/expandido.

No debe:

- ejecutar lógica de negocio;
- decidir si un gate permite avanzar;
- cargar fixtures;
- navegar directamente a pantallas concretas;
- depender de variables globales de PULSE o del Functional Lab.

## 2. Public contract previsto

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

La pantalla host recibirá el evento y decidirá qué hacer con `SelectedKey`.

Este contrato permanece temporalmente retirado del Source Code durante el diagnóstico de `FL-SC-001` y se restaurará por etapas.

## 3. Supported states previstos

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

## 4. Visual contract previsto

Expanded width: 220 px  
Collapsed width: 76 px

Estructura prevista:

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
- `Gallery@2.15.0` para navegación cuando alcance su etapa diagnóstica.
- `Classic/Icon@2.5.0` para iconografía inicial cuando se reintroduzca.
- `Label@2.5.1` sin propiedades `Radius*`.
- `Classic/Button@2.2.0` sin `AccessibleLabel` hasta validación específica.
- `ModernText@1.0.0` estático con `AutoHeight=true` por defecto.
- sin SVG inline.
- sin assets de imagen externos.
- sin variables globales internas.
- `DEFINITION_ACCEPTED` y `INSTANCE_SAFE` son gates independientes.

## 6. FL-SC-001 — estado diagnóstico

La versión completa inicial fue aceptada como definición pero cerró Power Apps Studio al insertar una instancia.

Resultados confirmados:

```text
R1 root-only                              PASS / INSTANCE_SAFE
R2 identidad + ModernText estático       PASS / INSTANCE_SAFE
R3 contenedores estáticos + AutoLayout   PENDING
```

Interpretación actual:

- CanvasComponent mínimo no reproduce el cierre;
- root `GroupContainer@1.5.0` ManualLayout no reproduce el cierre;
- cuatro `ModernText@1.0.0` estáticos tampoco lo reproducen;
- la causa técnica concreta continúa `UNKNOWN`;
- F01-00B permanece bloqueado.

R3 reintroduce únicamente composición estática de contenedores anidados y AutoLayout. Si R3 falla se subdividirá antes de añadir navegación o contrato público.

## 7. Initial icon vocabulary previsto

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

## 8. Validation gate final para F01-00A

El componente completo solo podrá salir de `REVIEW_REQUIRED` cuando supere:

```text
[ ] PASS_STATIC
[ ] DEFINITION_ACCEPTED
[ ] INSTANCE_SAFE con una instancia aislada
[ ] Save después de insertar instancia
[ ] Reopen estable
[ ] PUBLIC_CONTRACT_VALIDATED
[ ] render expanded correcto
[ ] render collapsed correcto
[ ] item activo visible
[ ] click cambia SelectedKey
[ ] OnSelectItem se dispara
[ ] texto sin clipping/mini-scrollbars
[ ] App Checker sin nuevos errores atribuibles al componente
[ ] VISUAL_QA_VALIDATED
[ ] READY_FOR_INTEGRATION
```
