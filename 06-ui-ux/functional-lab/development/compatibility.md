# Functional Lab — Power Apps Source Code Compatibility

**Estado:** activo antes de cualquier YAML  
**Origen inicial:** lecciones transferibles confirmadas en `rubensv74/app_pulse` y conocimiento curado en `rubensv74/functional-engineering-knowledge-base`.

## Gate obligatorio pre-YAML

Antes de redactar, corregir o publicar cualquier `.pa.yaml` del Functional Lab:

1. leer la versión vigente de este documento;
2. confirmar control y versión exactos contra referencias ya probadas cuando sea posible;
3. comparar con ejemplos validados;
4. no asumir que un componente existe en la app porque exista en GitHub;
5. no reutilizar un componente de Pulse sin revisar acoplamientos;
6. registrar cualquier error nuevo y convertirlo en regla preventiva;
7. para CanvasComponent, separar siempre aceptación de definición y seguridad de instancia;
8. no declarar `CustomProperties:` dentro del YAML pegable mientras esta superficie no haya sido demostrada como instance-safe.

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
| CanvasComponent solo existente en GitHub | `PA2301` | Confirmar instalación real en la app. |
| CanvasComponent con definición aceptada | puede cerrar Studio al instanciar | Smoke test de instancia aislada obligatorio. |
| SVG inline como sustituto visual | renderizado poco fiable | No usar como fallback automático. |
| `ModernText@1.0.0` estático | riesgo de clipping con altura rígida | `AutoHeight=true` por defecto. |
| `CustomProperties:` inyectado en el YAML pegable probado | definición aceptada pero cierre de Studio al instanciar | No crear el contrato público desde esta superficie; crear custom properties en Studio. |

## Evidencia específica de Functional Lab

```text
FL-EVID-001  R1 root-only                                         PASS
FL-EVID-002  R2 ModernText estático                               PASS
FL-EVID-003  R3 AutoLayout + contenedores anidados                PASS
FL-EVID-004  R4 Rectangle/Icon/Label/Button estáticos             PASS
FL-EVID-005  R5 Input Text+Boolean+Color via CustomProperties     FAIL
FL-EVID-006  R5-T Input/Text declarado+consumido                  FAIL
FL-EVID-007  R5-TD Input/Text declarado, no consumido             FAIL
FL-EVID-008  R5-TM mismo Input/Text creado manualmente en Studio  PASS
FL-EVID-009  R5-TS Source Code visible tras R5-TM                 OMITE AppTitle
```

### FL-EVID-009 — la superficie Source Code visible no representa el contrato completo

Tras crear manualmente `AppTitle` en Studio y comprobar `INSTANCE_SAFE = PASS`, se capturó el Source Code completo mostrado por Studio.

El código visible contiene:

```text
DefinitionType
Properties
Children
```

y no contiene:

```text
CustomProperties
AppTitle
```

aunque `AppTitle` existe funcionalmente en el componente.

Interpretación permitida:

> En la superficie concreta de Source Code usada por este flujo, una propiedad custom creada por Studio puede existir sin aparecer en el código visible. Por tanto, no se puede reconstruir el contrato público añadiendo manualmente `CustomProperties:` y asumir equivalencia con Studio.

Esto es coherente con la documentación de Microsoft, que advierte que el YAML de canvas apps está en desarrollo activo y puede ser incompleto.

## Decisiones Functional Lab

### FL-COMP-001 — Foundation premium por componentes propios
Los componentes premium pertenecen al Functional Lab y no dependen de PULSE.

### FL-COMP-002 — Incorporación secuencial

```text
F01-00A  cmp_FL_SidebarPro
F01-00B  cmp_FL_PageHeaderPro
F01-01   Premium App Shell Foundation
```

### FL-COMP-003 — Studio-first para el contrato público

A partir de FL-SC-001:

```text
Custom property / public contract
        ↓
crear en Studio
        ↓
INSTANCE_SAFE
        ↓
probar binding desde cuerpo Source Code
        ↓
PUBLIC_CONTRACT_VALIDATED
```

No incluir `CustomProperties:` en bloques YAML pegables hasta nueva evidencia explícita.

### FL-COMP-004 — Source Code para cuerpo visual, no para inventar metadatos invisibles

El YAML pegable puede seguir utilizándose incrementalmente para controles, layout y fórmulas demostradas. No se utilizará para reconstruir metadatos que Studio no expone en esa superficie.

### FL-COMP-005 — Sin estado global oculto
El estado deberá entrar/salir por contratos públicos una vez creados y validados en Studio.

### FL-COMP-006 — Reducir antes de reescribir
El primer estadio que reproduce el fallo se subdivide; no se avanza al siguiente.

## Incidente FL-SC-001

**Estado:** `OPEN — BLOCKING`.  
**Superficie técnica:** `CustomProperties` inyectado en Source Code es suficiente para reproducir; el mismo Input/Text creado en Studio es instance-safe.  
**Hallazgo R5-TS:** Studio no muestra `AppTitle` en el Source Code visible.  
**Correctivo actual:** `F01-00A-R5-TB`, probar binding desde YAML sin `CustomProperties` hacia `AppTitle` creado manualmente.

## Estado de validación

```text
R1 root-only                                     PASS
R2 identity/text                                 PASS
R3 static containers                             PASS
R4 static navigation                             PASS
R5 primitive custom inputs via CustomProperties  FAIL
R5-T Text declared+consumed                      FAIL
R5-TD Text declaration only                      FAIL
R5-TM manual Text input in Studio                PASS
R5-TS visible Studio source                      AppTitle omitted
R5-TB bind to Studio-created property            PENDING
FL-SC-001                                        OPEN — BLOCKING
F01-00B                                          BLOCKED
```
