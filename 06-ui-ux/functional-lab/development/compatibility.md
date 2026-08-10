# Functional Lab — Power Apps Source Code Compatibility

**Estado:** activo antes de cualquier YAML  
**Origen inicial:** lecciones transferibles confirmadas en `rubensv74/app_pulse` y conocimiento curado en `rubensv74/functional-engineering-knowledge-base`.

## Gate obligatorio pre-YAML

Antes de redactar, corregir o publicar cualquier `.pa.yaml` del Functional Lab:

1. leer la versión vigente de este documento;
2. confirmar control y versión exactos contra referencias ya probadas;
3. comparar con ejemplos validados;
4. no asumir que un componente existe en la app porque exista en GitHub;
5. registrar cualquier error nuevo y convertirlo en regla preventiva;
6. separar aceptación de definición y seguridad de instancia;
7. no declarar `CustomProperties:` dentro del YAML pegable de esta superficie;
8. crear primero en Studio toda propiedad pública nueva y validarla por instancia;
9. confirmar el **nombre interno exacto y el componente propietario** antes de escribir un binding YAML;
10. probar el binding desde YAML como gate independiente.

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
| `ModernText@1.0.0` estático | clipping con altura rígida | `AutoHeight=true` por defecto. |
| `CustomProperties:` inyectado en el YAML pegable probado | definición aceptada pero cierre al instanciar | Crear el contrato público en Studio. |
| Propiedad pública creada en Studio + binding desde YAML | `Input/Text` validado estable en R5-TB | Patrón permitido, pero revalidar por tipo de propiedad. |
| Binding a propiedad pública no reconocida | `Name isn't valid. '<property>' isn't recognized.` | Detener el bloque; verificar en Studio propietario, nombre interno exacto y persistencia de la propiedad antes de modificar YAML. |

## Evidencia Functional Lab

```text
FL-EVID-001  R1 root-only                                         PASS
FL-EVID-002  R2 ModernText estático                               PASS
FL-EVID-003  R3 AutoLayout + contenedores anidados                PASS
FL-EVID-004  R4 controles de navegación estáticos                 PASS
FL-EVID-005  R5 CustomProperties Text+Boolean+Color               FAIL
FL-EVID-006  R5-T Input/Text declarado+consumido por YAML         FAIL
FL-EVID-007  R5-TD Input/Text solo declarado por YAML             FAIL
FL-EVID-008  R5-TM Input/Text creado manualmente en Studio        PASS
FL-EVID-009  R5-TS Studio Source Code omite AppTitle              CONFIRMED
FL-EVID-010  R5-TB YAML consume AppTitle creado en Studio         PASS
FL-EVID-011  R5-BM ShowEnvironment binding                        BLOCKED — PROPERTY NOT RECOGNIZED
```

### FL-EVID-010 — estrategia híbrida validada para Input/Text

```text
AppTitle → Data / Input / Text creado manualmente en Studio
YAML     → SIN CustomProperties
Binding  → ModernText.Text = cmp_FL_SidebarPro.AppTitle
```

```text
DEFINITION_ACCEPTED PASS
INSTANCE_SAFE       PASS
```

### FL-EVID-011 — resolver contrato antes del binding

R5-BM contiene:

```powerfx
Visible = cmp_FL_SidebarPro.ShowEnvironment
```

Power Apps Studio permanece abierto, pero informa:

```text
Name isn't valid. 'ShowEnvironment' isn't recognized.
```

Interpretación permitida:

> La prueba Boolean no ha llegado todavía al gate de binding. `ShowEnvironment` no está disponible con ese nombre en el contrato público observable de `cmp_FL_SidebarPro` en el momento de la prueba.

No afirmar incompatibilidad de Boolean. Antes de cualquier corrección YAML se debe verificar en Studio:

- que la propiedad se creó sobre `cmp_FL_SidebarPro`;
- el nombre interno exacto;
- que persiste después de guardar;
- si `AppTitle` sigue también presente.

## Estrategia de autoría Functional Lab

```text
PUBLIC CONTRACT
  Studio first
      ↓
  confirm owner + internal name
      ↓
  instance smoke test
      ↓
BODY / LAYOUT / FORMULAS
  Source Code incremental
      ↓
BINDING
  reference Studio-created contract
      ↓
  formula resolution gate
      ↓
  instance smoke test
```

### Regla Studio-first

No incluir `CustomProperties:` en el YAML pegable hasta nueva evidencia explícita de soporte para esa superficie.

### Regla por tipo

```text
Text     PASS
Boolean  BLOCKED — contract/name resolution
Color    PENDING
Table    PENDING
Output   PENDING
Event    PENDING
```

## Incidente FL-SC-001

**Estado:** `OPEN — BLOCKING UNTIL FULL SIDEBAR RECOVERY`.  
**Workaround demostrado:** Studio-first contract + YAML binding para `Input/Text`.  
**Correctivo actual:** resolver `ShowEnvironment` en Studio sin modificar el YAML.

## Estado

```text
R5-TB binding to Studio-created Text property    PASS
R5-BM Boolean binding                            BLOCKED — ShowEnvironment not recognized
FL-SC-001                                        OPEN
F01-00B                                          BLOCKED
```
