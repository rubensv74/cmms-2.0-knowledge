# Functional Lab — Power Apps Source Code Compatibility

**Estado:** activo antes de cualquier YAML  
**Origen:** evidencia real de Functional Lab, PULSE y conocimiento curado central.

## Gate obligatorio pre-YAML

Antes de redactar, corregir o publicar cualquier `.pa.yaml` del Functional Lab:

1. leer la versión vigente de este documento;
2. confirmar control y versión exactos contra referencias ya probadas;
3. comparar con ejemplos validados;
4. no asumir que un componente existe en la app porque exista en GitHub;
5. registrar cualquier error nuevo y convertirlo en regla preventiva;
6. separar aceptación de definición y seguridad de instancia;
7. no declarar `CustomProperties:` dentro del YAML pegable de esta superficie;
8. crear en Studio toda propiedad pública nueva solo cuando realmente se necesite;
9. confirmar nombre interno exacto y componente propietario antes de escribir un binding;
10. hacer un smoke test de instancia por componente completo antes de integrarlo.

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
| `CustomProperties:` inyectado en YAML pegable | definición aceptada pero cierre al instanciar | Crear contrato público en Studio; no inyectarlo desde esta superficie. |
| Propiedad pública creada en Studio + binding desde YAML | Input/Text validado estable | Patrón permitido cuando sea necesario. |
| Binding a propiedad no reconocida | `Name isn't valid` | Verificar propietario, nombre interno y persistencia antes de modificar YAML. |

## Evidencia Functional Lab

```text
R1 root-only                                         PASS
R2 ModernText estático                               PASS
R3 AutoLayout + contenedores anidados                PASS
R4 controles navegación estáticos                    PASS
R5 CustomProperties vía YAML                         FAIL
R5-TM Input/Text creado manualmente en Studio        PASS
R5-TB YAML consume propiedad Studio-created          PASS
RC1 Sidebar premium completo sin CustomProperties    PASS
```

### RC1 — recuperación completa del Sidebar

Configuración validada:

- `GroupContainer@1.5.0` AutoLayout + ManualLayout;
- `Gallery@2.15.0` con `Table(...)` local;
- `Rectangle@2.3.0`;
- `Classic/Icon@2.5.0`;
- `Label@2.5.1` sin `Radius*`;
- `Classic/Button@2.2.0` sin `AccessibleLabel`;
- `ModernText@1.0.0` con `AutoHeight=true`;
- selección local mediante `galFLNav.Selected`;
- sin `CustomProperties:`;
- sin globals ni assets externos.

Resultado real comunicado por el usuario: `funciona`.

Interpretación:

> El Sidebar premium body-only es `INSTANCE_SAFE` y puede utilizarse como referencia de controles y composición para la Foundation.

## Regla de autoría para componentes fundacionales

```text
PUBLIC CONTRACT
→ Studio, solo cuando una pantalla host lo necesite realmente

VISUAL BODY / LAYOUT / FORMULAS
→ YAML completo, incremental y validado

CustomProperties:
→ no inyectar en el YAML pegable probado
```

No validar Text/Boolean/Color/Table/Event uno a uno salvo fallo real de producto.

## F01-00B — PageHeaderPro

El PageHeader se construirá inicialmente como componente autónomo body-only:

- sin `CustomProperties:`;
- sin Event/Output;
- sin dependencia de variables globales;
- sin assets externos;
- textos/contextos realistas del caso P-101;
- `ModernText` con `AutoHeight=true`;
- radios en contenedores, no en Labels;
- botones clásicos sin `AccessibleLabel`;
- un único smoke test final de instancia.

El precedente `cmp_PageHeaderPro` de PULSE confirma el mismo problema de `CustomProperties:` y adoptó la misma frontera operativa Studio-first para contrato público.

## Incidente FL-SC-001

**Estado:** `RESOLVED — OPERATIONAL WORKAROUND VALIDATED`.  
**Resolución:** RC1 premium completo validado; patrón inseguro excluido del flujo normal.

## Estado actual

```text
cmp_FL_SidebarPro RC1       INSTANCE_SAFE PASS
FL-SC-001                   RESOLVED
cmp_FL_PageHeaderPro        CURRENT
F01-01 Premium App Shell    BLOCKED UNTIL PAGEHEADER PASS
```
