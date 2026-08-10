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
9. probar el binding desde YAML como gate independiente.

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
```

### FL-EVID-010 — estrategia híbrida validada para Input/Text

Configuración:

```text
AppTitle → Data / Input / Text creado manualmente en Studio
YAML     → SIN CustomProperties
Binding  → ModernText.Text = cmp_FL_SidebarPro.AppTitle
```

Resultado real:

```text
DEFINITION_ACCEPTED PASS
INSTANCE_SAFE       PASS
```

Interpretación permitida:

> Para `Input/Text`, el contrato creado en Studio puede ser consumido desde el cuerpo Source Code sin comprometer la seguridad de instancia.

No extrapolar todavía esta evidencia automáticamente a Boolean, Color, Table, Output o Event.

## Estrategia de autoría Functional Lab

```text
PUBLIC CONTRACT
  Studio first
      ↓
  instance smoke test
      ↓
BODY / LAYOUT / FORMULAS
  Source Code incremental
      ↓
BINDING
  reference Studio-created contract
      ↓
  instance smoke test
```

### Regla Studio-first

No incluir `CustomProperties:` en el YAML pegable hasta nueva evidencia explícita de soporte para esa superficie.

### Regla por tipo

Cada nuevo tipo de contrato público se valida de forma independiente antes de usarlo en el Sidebar completo:

```text
Text     PASS
Boolean  CURRENT
Color    PENDING
Table    PENDING
Output   PENDING
Event    PENDING
```

## Incidente FL-SC-001

**Estado:** `OPEN — BLOCKING UNTIL FULL SIDEBAR RECOVERY`.  
**Superficie problemática:** metadatos `CustomProperties` inyectados mediante el Source Code pegable probado.  
**Workaround demostrado:** Studio-first contract + YAML binding para `Input/Text`.  
**Correctivo actual:** `F01-00A-R5-BM`, Boolean Studio-first + binding simple.

## Estado

```text
R1 root-only                                     PASS
R2 identity/text                                 PASS
R3 static containers                             PASS
R4 static navigation                             PASS
R5 primitive CustomProperties                    FAIL
R5-T Text declared+consumed via YAML             FAIL
R5-TD Text declaration only via YAML             FAIL
R5-TM manual Text input in Studio                PASS
R5-TS Studio visible source                      AppTitle omitted
R5-TB binding to Studio-created Text property    PASS
R5-BM Boolean Studio-first                       PENDING
FL-SC-001                                        OPEN
F01-00B                                          BLOCKED
```
