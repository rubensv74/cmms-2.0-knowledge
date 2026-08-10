# Functional Lab — Power Apps Source Code Compatibility

**Estado:** activo antes de cualquier YAML  
**Origen:** evidencia real de Functional Lab, PULSE y conocimiento curado central.

## Gate obligatorio pre-YAML

Antes de redactar, corregir o publicar cualquier `.pa.yaml` del Functional Lab:

1. leer la versión vigente de este documento;
2. confirmar control y versión exactos contra referencias ya probadas;
3. comparar con componentes reales que ya funcionen en PULSE cuando exista un equivalente;
4. no asumir que una hipótesis diagnóstica es una regla general;
5. separar aceptación de definición y seguridad de instancia;
6. registrar cualquier error nuevo y corregir también cualquier conclusión previa que quede refutada.

## Niveles de validación obligatorios

```text
PASS_STATIC
DEFINITION_ACCEPTED
INSTANCE_SAFE
PUBLIC_CONTRACT_VALIDATED
VISUAL_QA_VALIDATED
READY_FOR_INTEGRATION
```

> `DEFINITION_ACCEPTED` no implica `INSTANCE_SAFE`.

## Reglas de compatibilidad confirmadas

| Patrón | Riesgo / efecto confirmado | Regla preventiva |
|---|---|---|
| `Label@2.5.1` + `Radius*` | `PA2108` | Radios en el contenedor, no en Label. |
| `Classic/Button@2.2.0` + `AccessibleLabel` | `PA2108` | No declarar sin validación específica. |
| `TabList@2.2.30` + `Reset()` | error de fórmula | Gestionar selección mediante variable. |
| CanvasComponent solo en GitHub | `PA2301` | Confirmar instalación real en la app. |
| Definición aceptada | puede cerrar Studio al instanciar | Smoke test aislado obligatorio. |
| SVG inline como sustituto visual | renderizado poco fiable | No usar como fallback automático. |
| `ModernText@1.0.0` estático | clipping/mini-scroll con altura rígida | `AutoHeight=true` por defecto. |

## FL-SC-001 — corrección del diagnóstico

Las pruebas R5 demostraron que **nuestra declaración concreta** de `CustomProperties` podía ser aceptada y aun cerrar Studio al insertar una instancia. Eso NO demuestra que `CustomProperties` sea inseguro en Source Code.

El componente `cmp_HeatMapPro` de PULSE aporta una referencia real más fuerte:

- usa `CustomProperties` extensamente;
- contiene Inputs Text, Boolean, Number, Color y Table;
- contiene Outputs y Events;
- consume esas propiedades desde el cuerpo del componente;
- se integra y funciona correctamente en PULSE.

Por tanto queda retirada la regla anterior:

```text
NO VÁLIDA COMO REGLA GENERAL:
"CustomProperties en YAML pegable es inseguro"
```

## Diferencial estructural encontrado

Comparando el Sidebar original que fallaba con `cmp_HeatMapPro`, el primer diferencial sistemático es el contrato de los Inputs.

Patrón validado en HeatMap:

```yaml
AccentColor:
  PropertyKind: Input
  DisplayName: AccentColor
  Description: Selection and interaction accent color
  DataType: Color
  Default: =ColorValue("#1677FF")
```

Patrón usado en el Sidebar fallido:

```yaml
AppTitle:
  PropertyKind: Input
  DataType: Text
  Default: ="CMMS 2.0"
```

El Sidebar omitía `DisplayName` y `Description` en sus Inputs.

Microsoft documenta la creación de una propiedad custom indicando explícitamente `Display name`, `Property name` y `Description` como parte de la definición del contrato en Studio. Esto no prueba por sí solo que su ausencia sea la causa del cierre, pero convierte ese delta en el candidato principal que debe contrastarse antes de culpar a `CustomProperties`.

## Estrategia actual

No habrá más micro-pruebas por tipo.

Se realizará una única prueba de alto valor:

```text
Sidebar completo original
+
mismo contrato funcional
+
Inputs declarados con DisplayName y Description siguiendo cmp_HeatMapPro
+
Output/Event conservados según patrón ya funcional
→ insertar instancia
```

Interpretación:

- PASS → la causa queda fuertemente asociada al contrato incompleto de propiedades custom del Sidebar original;
- FAIL → comparar el siguiente delta estructural con `cmp_HeatMapPro` sin volver a generalizar prematuramente.

## Estado actual

```text
cmp_HeatMapPro                 REFERENCE — CUSTOM PROPERTIES WORKING
cmp_FL_SidebarPro original     INSTANCE FAIL
FL-SC-001                      REOPENED — ROOT CAUSE NOT CONFIRMED
Next                           RC2 full sidebar with HeatMap-style property metadata
F01-00B                        BLOCKED UNTIL SIDEBAR RC2 RESULT
```
