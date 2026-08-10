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
6. registrar cualquier error nuevo y corregir también cualquier conclusión previa que quede refutada;
7. para nuevas `CustomProperties`, copiar el contrato completo del componente estable de referencia por `PropertyKind`.

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
| `CustomProperties:` en Source Code | es compatible cuando el contrato está bien formado; `cmp_HeatMapPro` y RC2 lo demuestran | No prohibirlo; usar un componente instance-safe como plantilla estructural. |
| Input nuevo de componente reutilizable | una forma reducida puede no ser equivalente a la referencia estable | Preservar `PropertyKind + DisplayName + Description + DataType + Default` cuando ese sea el patrón de referencia. |

## FL-SC-001 — diagnóstico corregido

Las pruebas R5 demostraron que **la declaración concreta** de `CustomProperties` usada inicialmente por el Sidebar podía ser aceptada y aun cerrar Studio al insertar una instancia. Eso nunca fue prueba suficiente para invalidar `CustomProperties` como característica.

`cmp_HeatMapPro` de PULSE aportó el contraejemplo decisivo:

- numerosos Inputs Text, Boolean, Number, Color y Table;
- Outputs de varios tipos;
- Events;
- bindings internos;
- componente integrado y estable en PULSE.

La regla anterior queda definitivamente retirada:

```text
FALSO COMO REGLA GENERAL:
"CustomProperties en Source Code es inseguro"
```

## RC2 — patrón HeatMap aplicado al Sidebar

Se reconstruyó el Sidebar completo con su contrato público completo, conservando:

- Inputs;
- `NavItems` Table;
- `SelectedKey` Output;
- `OnSelectItem` Event;
- Gallery y bindings internos;
- comportamiento expandido/colapsado.

Los Inputs se normalizaron siguiendo la forma observada en `cmp_HeatMapPro`:

```yaml
PropertyKind: Input
DisplayName: ...
Description: ...
DataType: ...
Default: ...
```

Resultado comunicado por el usuario:

```text
RC2 — definición aceptada
RC2 — instancia insertada correctamente
RC2 — Studio estable
```

Por tanto:

> `CustomProperties` queda validado para el Functional Lab cuando se usa un contrato completo modelado a partir de una referencia real instance-safe.

### Alcance exacto del hallazgo

RC2 se probó sobre un componente limpio y con el contrato HeatMap-style. Por ello se considera **patrón correctivo validado**, pero no se afirma que `DisplayName` o `Description` sean por sí solos requisitos universales del motor ni que su omisión sea la única causa técnica posible del cierre original.

La conclusión práctica es más útil y más segura:

> Para nuevos CanvasComponents reutilizables, no simplificar la declaración de propiedades respecto de un componente estable equivalente. Copiar el contrato completo por `PropertyKind` y validar la instancia.

## Evidencia Functional Lab

```text
R1 root-only                                      PASS
R2 identidad/texto                                PASS
R3 contenedores estáticos                         PASS
R4 navegación visual                              PASS
R5 contrato reducido de CustomProperties          FAIL_INSTANCE
R5-TM propiedad manual Studio                     PASS
R5-TB binding a propiedad manual                  PASS
cmp_HeatMapPro referencia PULSE                   PASS / integrated
RC2 Sidebar + contrato HeatMap-style              PASS / INSTANCE_SAFE
```

## Estado actual

```text
cmp_FL_SidebarPro RC2       INSTANCE_SAFE PASS
PUBLIC CONTRACT             RESTORED AND VALIDATED AT INSTANCE LEVEL
FL-SC-001                   RESOLVED — CORRECTIVE PATTERN VALIDATED
Next                        F01-00B cmp_FL_PageHeaderPro
```

El PageHeader deberá tomar como referencia contractual un componente PULSE estable antes de declarar sus CustomProperties; no se volverá a eliminar el contrato público por defecto como workaround.
