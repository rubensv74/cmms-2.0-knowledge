# cmp_FL_SidebarPro — Component Specification

**Status:** REVIEW_REQUIRED / FL-SC-001  
**Increment:** F01-00A  
**Purpose:** navegación premium común del CMMS 2.0 Functional Lab.

## 1. Current validation state

```text
PASS_STATIC                 PASS
DEFINITION_ACCEPTED         PASS
INSTANCE_SAFE               FAIL
PUBLIC_CONTRACT_VALIDATED   NOT TESTED
VISUAL_QA_VALIDATED         NOT TESTED
READY_FOR_INTEGRATION       NO
```

Power Apps Studio accepted the original component definition, but Studio closed when an instance was inserted.

The technical cause is deliberately recorded as `UNKNOWN` until a reduced reproducer isolates the failing responsibility.

Incident:

```text
../../development/incidents/FL-SC-001-component-instance-crash.md
```

Current source is temporarily `F01-00A-R1 root-only` and does **not** implement the final public contract described below. The contract remains the target design while the implementation is reconstructed incrementally.

## 2. Responsibility

Proporcionar navegación persistente entre workspaces del Functional Lab sin conocer la lógica interna de cada workspace.

El componente final:

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

## 3. Target public contract

> Este contrato está suspendido durante R1 y se restaurará por incrementos después de demostrar `INSTANCE_SAFE` en el estadio mínimo.

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

## 4. Supported states target

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

## 5. Visual contract target

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

## 6. Compatibility constraints

- consultar `development/compatibility.md` inmediatamente antes de cada corrección YAML;
- definición aceptada no equivale a instancia segura;
- cada estadio de reconstrucción debe superar inserción de instancia aislada antes del siguiente;
- `GroupContainer@1.5.0` para geometría y radios cuando se restaure;
- `Gallery@2.15.0` no se reincorpora hasta que los estadios anteriores sean `INSTANCE_SAFE`;
- `Classic/Icon@2.5.0` no se reincorpora hasta el estadio de navegación visual;
- `Label@2.5.1` sin propiedades `Radius*`;
- `Classic/Button@2.2.0` sin `AccessibleLabel` hasta validación específica;
- `ModernText@1.0.0` estático con `AutoHeight=true` por defecto;
- sin SVG inline;
- sin assets de imagen externos;
- sin variables globales internas.

## 7. Diagnostic reconstruction sequence

```text
R1 root only
R2 identidad/texto
R3 contenedores estáticos
R4 navegación visual sin eventos
R5 custom inputs simples
R6 Gallery + Table input
R7 Output/Event
R8 geometría completa
```

No se presupone que R6 o R7 sean la causa. Su posición tardía reduce la superficie de diagnóstico.

## 8. Validation — R1

Después de sustituir la fuente completa por F01-00A-R1:

```text
[ ] ComponentDefinitions aceptado
[ ] Save correcto
[ ] insertar UNA instancia en pantalla vacía
[ ] Studio permanece abierto y responde
[ ] superficie 220x700 visible
[ ] segundo Save correcto
[ ] App Checker sin nuevos errores atribuibles
```

Si R1 falla, no se añadirá ninguna complejidad: se investigará el baseline/mecanismo CanvasComponent Source Code.

Si R1 pasa, el siguiente incremento será R2 y solo restaurará identidad/texto.

## 9. Final validation before integration

El componente no podrá utilizarse en el shell hasta completar:

```text
[ ] PASS_STATIC
[ ] DEFINITION_ACCEPTED
[ ] INSTANCE_SAFE
[ ] PUBLIC_CONTRACT_VALIDATED
[ ] VISUAL_QA_VALIDATED
[ ] save/reopen estable
[ ] READY_FOR_INTEGRATION
```
