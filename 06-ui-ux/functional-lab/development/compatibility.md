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
7. para CanvasComponent, separar siempre aceptación de definición y seguridad de instancia.

## Niveles de validación obligatorios para CanvasComponent

```text
PASS_STATIC
DEFINITION_ACCEPTED
INSTANCE_SAFE
PUBLIC_CONTRACT_VALIDATED
VISUAL_QA_VALIDATED
READY_FOR_INTEGRATION
```

Regla crítica:

> `DEFINITION_ACCEPTED` no implica `INSTANCE_SAFE`.

## Reglas heredadas y confirmadas por conocimiento previo

| Patrón | Riesgo / efecto confirmado | Regla preventiva |
|---|---|---|
| `Label@2.5.1` + `Radius*` | `PA2108` | Aplicar radios al contenedor, no a la etiqueta. |
| `Classic/Button@2.2.0` + `AccessibleLabel` | `PA2108` | No declarar esa propiedad sin validación específica. |
| `TabList@2.2.30` + `Reset()` | error de fórmula | Controlar selección mediante variable. |
| `CanvasComponent` solo existente en GitHub | `PA2301` | Confirmar que el componente está añadido a la app activa. |
| CanvasComponent con definición aceptada | puede cerrar Studio al insertar instancia | Smoke test de instancia aislada obligatorio. |
| SVG inline como sustituto visual | renderizado poco fiable | No usar como fallback automático. |
| `ModernText@1.0.0` estático con altura rígida | mini-scrollbars/clipping | `AutoHeight=true` por defecto. |

## Evidencia específica de Functional Lab

```text
FL-EVID-001  R1 root-only                                      PASS
FL-EVID-002  R2 ModernText estático                            PASS
FL-EVID-003  R3 AutoLayout + contenedores anidados             PASS
FL-EVID-004  R4 Rectangle/Icon/Label/Button estáticos          PASS
FL-EVID-005  R5 Input Text+Boolean+Color                       FAIL
FL-EVID-006  R5-T Input/Text declarado+consumido               FAIL
FL-EVID-007  R5-TD Input/Text declarado, NO consumido          FAIL
```

### FL-EVID-007 — Input/Text declarado por Source Code, sin consumo

R5-TD usa el baseline mínimo R1 y añade exclusivamente:

```yaml
CustomProperties:
  AppTitle:
    PropertyKind: Input
    DataType: Text
    Default: ="CMMS 2.0"
```

Ningún control referencia la propiedad.

Resultado real:

```text
DEFINITION_ACCEPTED PASS
INSTANCE_SAFE       FAIL — Studio closes on insertion
```

Interpretación permitida:

> En el baseline y mecanismo de autoría probados, la mera declaración **mediante Source Code** de una CustomProperty `Input/Text` es suficiente para reproducir FL-SC-001.

Interpretaciones NO permitidas todavía:

- afirmar que `Input/Text` sea inseguro cuando se crea manualmente en Studio;
- afirmar que Canvas Components no soporte custom inputs de texto;
- extrapolar el fallo a Boolean, Color, Table, Output o Event;
- atribuir el fallo al consumo/binding, porque R5-TD no consume la propiedad.

## Evidencia oficial Microsoft relevante

Microsoft documenta las propiedades Data/Input como mecanismo soportado para componentes Canvas, incluyendo valores como texto y color. citeturn310826view1

Microsoft también indica que el esquema `.pa.yaml` está en desarrollo activo, que el Source Code actual está orientado a control de código fuente y que la edición externa se soporta únicamente mediante Power Platform Git Integration. citeturn310826view0

Por tanto, FL-SC-001 se sigue tratando como incidente de compatibilidad/autoría; no como comportamiento funcional esperado.

## Decisiones para Functional Lab

### FL-COMP-001 — Foundation premium por componentes propios
El Functional Lab tendrá una biblioteca propia de componentes premium.

### FL-COMP-002 — Incorporación secuencial antes del shell

```text
F01-00A  cmp_FL_SidebarPro
F01-00B  cmp_FL_PageHeaderPro
F01-01   Premium App Shell Foundation
```

Un componente debe alcanzar `INSTANCE_SAFE` antes de ser consumido.

### FL-COMP-003 — Componentes Pulse son referencias, no dependencias
Los componentes de Pulse se usan como referencia, no como dependencia directa.

### FL-COMP-004 — No copiar propiedades por apariencia
Una propiedad válida en un control no se trasladará a otro por similitud visual.

### FL-COMP-005 — Sin estado global oculto dentro de componentes
El estado deberá entrar por inputs y salir por outputs/events una vez demostrada su compatibilidad.

### FL-COMP-006 — Premium no significa sobrecarga visual
Priorizar jerarquía, legibilidad, densidad, estados, accesibilidad, feedback y consistencia.

### FL-COMP-007 — Reducir antes de reescribir cuando falla una instancia
El primer estadio que reproduce el fallo se subdivide; no se avanza al siguiente.

### FL-COMP-008 — Separar contrato de componente y mecanismo de autoría

R5-TD obliga a añadir un nuevo gate:

> Cuando una CustomProperty creada mediante Source Code provoque `FAIL_INSTANCE`, antes de descartar el contrato funcional debe recrearse el mismo contrato **manualmente en Studio** sobre un baseline instance-safe.

Diagnóstico actual:

```text
R5-TM — Data / Input / Text creado manualmente en Studio, sin consumo
```

Interpretación:

- `R5-TM PASS` → el contrato `Input/Text` es viable y el problema queda concentrado en el camino de autoría Source Code/serialización/hidratación;
- `R5-TM FAIL` → investigar Enhanced component properties/app baseline/Studio antes de continuar.

Hasta obtener este resultado, no preparar R6, PageHeader ni App Shell.

## Incidentes Functional Lab

### FL-SC-001 — `cmp_FL_SidebarPro` cierra Studio al insertar instancia

**Fecha:** 2026-08-10  
**Causa técnica:** `UNKNOWN — SOURCE-CODE INPUT/TEXT DECLARATION PATH IS SUFFICIENT TO REPRODUCE`.  
**Estado:** `OPEN — BLOCKING`.  
**Resultados:** `R1 PASS`, `R2 PASS`, `R3 PASS`, `R4 PASS`, `R5 FAIL`, `R5-T FAIL`, `R5-TD FAIL`.  
**Correctivo actual:** `F01-00A-R5-TM`, creación manual de Input/Text en Studio.

## Estado de validación

```text
cmp_FL_SidebarPro complete initial instance: FAIL
R1 root-only instance: PASS
R2 identity/text instance: PASS
R3 static containers instance: PASS
R4 static navigation instance: PASS
R5 primitive custom inputs combined: FAIL
R5-T Text input declared+consumed: FAIL
R5-TD Text input declaration only via Source Code: FAIL
R5-TM manual Text input: PENDING
FL-SC-001: OPEN — BLOCKING
F01-00B: BLOCKED
```
