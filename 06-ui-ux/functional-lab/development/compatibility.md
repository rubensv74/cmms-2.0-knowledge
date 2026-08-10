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
8. para CustomProperties, no asumir que una declaración escrita manualmente en YAML equivale a la serialización generada por Studio.

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
| CustomProperty escrita manualmente en YAML | puede ser aceptada como definición y aun cerrar Studio al instanciar | Crear/validar primero en Studio y comparar la serialización real antes de generar el contrato por YAML. |

## Evidencia específica de Functional Lab

```text
FL-EVID-001  R1 root-only                                         PASS
FL-EVID-002  R2 ModernText estático                               PASS
FL-EVID-003  R3 AutoLayout + contenedores anidados                PASS
FL-EVID-004  R4 Rectangle/Icon/Label/Button estáticos             PASS
FL-EVID-005  R5 Input Text+Boolean+Color via Source Code           FAIL
FL-EVID-006  R5-T Input/Text declarado+consumido via Source Code  FAIL
FL-EVID-007  R5-TD Input/Text declarado, no consumido via Source  FAIL
FL-EVID-008  R5-TM Input/Text creado manualmente en Studio        PASS
```

### FL-EVID-008 — mismo contrato, distinto camino de autoría

Contrato probado:

```text
Property name: AppTitle
Property type: Data
Definition: Input
Data type: Text
```

Resultados:

```text
Source Code manual declaration   → INSTANCE_SAFE FAIL
Studio manual creation           → INSTANCE_SAFE PASS
```

Interpretación permitida:

> `Input/Text` es viable en la app activa. La reproducción del cierre queda asociada al camino usado para crear/serializar/hidratar la CustomProperty desde Source Code, no al tipo Text en sí mismo.

Interpretaciones NO permitidas todavía:

- afirmar qué campo exacto falta o sobra en R5-TD;
- extrapolar la causa a Boolean, Color, Table, Output o Event;
- asumir que la representación visible después de crear la propiedad en Studio será idéntica a nuestro YAML sin capturarla;
- reanudar la construcción de contratos públicos por YAML antes de comparar la serialización real.

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

### FL-COMP-008 — Separar contrato del mecanismo de autoría

Cuando una CustomProperty creada mediante Source Code provoque `FAIL_INSTANCE`, antes de descartar el contrato funcional debe recrearse el mismo contrato manualmente en Studio sobre un baseline instance-safe.

### FL-COMP-009 — Studio-first para CustomProperties hasta cerrar FL-SC-001

Regla temporal obligatoria:

```text
crear propiedad en Studio
→ probar INSTANCE_SAFE
→ capturar serialización generada
→ comparar con representación propuesta
→ solo entonces automatizar/generar YAML
```

No generar una CustomProperty nueva a partir de memoria o de un ejemplo previo mientras esta regla esté activa.

## Incidentes Functional Lab

### FL-SC-001 — `cmp_FL_SidebarPro` cierra Studio al insertar instancia

**Fecha:** 2026-08-10  
**Causa técnica:** `UNKNOWN — SOURCE-CODE AUTHORING/SERIALIZATION PATH IS THE OBSERVED DIFFERENTIAL`.  
**Estado:** `OPEN — BLOCKING`.  
**Resultados:** `R1 PASS`, `R2 PASS`, `R3 PASS`, `R4 PASS`, `R5 FAIL`, `R5-T FAIL`, `R5-TD FAIL`, `R5-TM PASS`.  
**Correctivo actual:** `F01-00A-R5-TS`, capturar serialización real de Studio.

## Estado de validación

```text
cmp_FL_SidebarPro complete initial instance: FAIL
R1 root-only instance: PASS
R2 identity/text instance: PASS
R3 static containers instance: PASS
R4 static navigation instance: PASS
R5 primitive custom inputs via Source Code: FAIL
R5-T Text declared+consumed via Source Code: FAIL
R5-TD Text declaration only via Source Code: FAIL
R5-TM manual Text input in Studio: PASS
R5-TS Studio serialization capture: PENDING
FL-SC-001: OPEN — BLOCKING
F01-00B: BLOCKED
```
