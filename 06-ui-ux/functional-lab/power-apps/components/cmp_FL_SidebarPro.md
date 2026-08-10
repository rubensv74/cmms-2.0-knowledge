# cmp_FL_SidebarPro — Component Specification

**Status:** VALIDATED — RC2 INSTANCE_SAFE  
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

## 2. Public contract validado

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

`NavItems` shape:

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

La pantalla host recibe el evento y decide la navegación o acción asociada a `SelectedKey`.

## 3. Contract declaration pattern

RC2 confirmó que el Sidebar completo puede declararse e instanciarse con `CustomProperties` cuando sus Inputs siguen el patrón de una referencia `INSTANCE_SAFE` real (`cmp_HeatMapPro`):

```yaml
PropertyKind: Input
DisplayName: ...
Description: ...
DataType: ...
Default: ...
```

Para Outputs y Events se conserva el patrón propio de su `PropertyKind`; no se añaden campos por simetría.

Regla:

> Los componentes nuevos deben copiar la forma completa del contrato de una referencia estable equivalente. No simplificar metadatos por intuición.

## 4. Supported states

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

## 5. Visual contract

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

- `GroupContainer@1.5.0` para geometría y radios.
- `Gallery@2.15.0` para navegación.
- `Classic/Icon@2.5.0` para iconografía inicial.
- `Label@2.5.1` sin propiedades `Radius*`.
- `Classic/Button@2.2.0` sin `AccessibleLabel` hasta validación específica.
- `ModernText@1.0.0` estático con `AutoHeight=true` por defecto.
- sin SVG inline.
- sin assets de imagen externos.
- sin variables globales internas.
- `DEFINITION_ACCEPTED` y `INSTANCE_SAFE` siguen siendo gates independientes.

## 7. FL-SC-001 — resolución

La versión completa inicial fue aceptada como definición pero cerró Power Apps Studio al insertar una instancia.

La investigación produjo dos aprendizajes:

1. `DEFINITION_ACCEPTED != INSTANCE_SAFE`.
2. `CustomProperties` no era la causa general: `cmp_HeatMapPro` demostró un contrato complejo y estable en PULSE.

RC2 reconstruyó el Sidebar completo con el contrato público restaurado y los Inputs normalizados según el patrón HeatMap-style.

Resultado:

```text
DEFINITION_ACCEPTED PASS
INSTANCE_SAFE       PASS
```

FL-SC-001 queda cerrado como `RESOLVED — CORRECTIVE PATTERN VALIDATED`.

La prueba RC2 se realizó además sobre una definición limpia, por lo que no se declara que `DisplayName` o `Description` sean individualmente la única causa técnica del cierre original. Se adopta el patrón completo porque es reproducible y suficiente para continuar.

## 8. Validation status F01-00A

```text
[x] PASS_STATIC
[x] DEFINITION_ACCEPTED
[x] INSTANCE_SAFE con instancia aislada
[x] contrato público restaurado
[x] CustomProperties complejas aceptadas
[x] patrón de referencia PULSE documentado
[ ] Save/reopen final del conjunto integrado
[ ] render expanded QA final
[ ] render collapsed QA final
[ ] click cambia SelectedKey en integración host
[ ] OnSelectItem se dispara en integración host
[ ] texto sin clipping/mini-scrollbars en shell final
[ ] App Checker sin nuevos errores atribuibles en shell final
[ ] VISUAL_QA_VALIDATED
[ ] READY_FOR_INTEGRATION final
```

El componente ya puede utilizarse para continuar F01-00B y preparar posteriormente el Premium App Shell, manteniendo los gates visuales y de integración pendientes.
