# Functional Lab — Power Apps Source Code Compatibility

**Estado:** activo antes de cualquier YAML  
**Origen inicial:** lecciones transferibles confirmadas en `rubensv74/app_pulse` y conocimiento curado en `rubensv74/functional-engineering-knowledge-base`.

## Gate obligatorio pre-YAML

Antes de redactar, corregir o publicar cualquier `.pa.yaml` del Functional Lab:

1. leer la versión vigente de este documento;
2. confirmar control y versión exactos contra referencias ya probadas cuando sea posible;
3. comparar con ejemplos validados;
4. no asumir que un componente existe en la app porque exista en GitHub;
5. no reutilizar un componente de Pulse sin revisar acoplamientos de marca, variables, assets y contratos;
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
| variable numérica inicializada solo con `Blank()` | tipo/nombre no establecido | Primera asignación numérica inequívoca, por ejemplo `0`. |
| `CanvasComponent` solo existente en GitHub | `PA2301` | Confirmar que el componente está añadido a la app activa. |
| CanvasComponent con definición aceptada | puede cerrar Studio al insertar instancia | Smoke test de instancia aislada obligatorio antes de integración. |
| SVG inline como sustituto visual | renderizado poco fiable | No usar como fallback automático; preferir componente validado. |
| `ModernText@1.0.0` estático con altura rígida | mini-scrollbars/clipping | `AutoHeight=true` por defecto y validación visual real. |

## Evidencia específica de Functional Lab

### FL-EVID-001 — Baseline CanvasComponent mínimo
`F01-00A-R1`: `INSTANCE_SAFE = PASS`.

### FL-EVID-002 — ModernText estático
`F01-00A-R2`: `INSTANCE_SAFE = PASS`.

### FL-EVID-003 — AutoLayout y contenedores anidados estáticos
`F01-00A-R3`: `INSTANCE_SAFE = PASS`.

### FL-EVID-004 — Controles visuales de navegación sin eventos
`F01-00A-R4`: `INSTANCE_SAFE = PASS`.

Incluyó `Rectangle@2.3.0`, `Classic/Icon@2.5.0`, `Label@2.5.1` y `Classic/Button@2.2.0`, todos en configuración estática y sin `OnSelect`.

### FL-EVID-005 — CustomProperties primitivas combinadas

`F01-00A-R5` introdujo `Input/Text`, `Input/Boolean` e `Input/Color`, consumidos por controles ya validados.

```text
DEFINITION_ACCEPTED PASS
INSTANCE_SAFE       FAIL — Studio closes on insertion
```

### FL-EVID-006 — Input/Text declarado y consumido

`F01-00A-R5-T` volvió al baseline R4 y añadió únicamente:

- `AppTitle` — `PropertyKind: Input`;
- `DataType: Text`;
- `Default: ="CMMS 2.0"`;
- consumo: `ModernText.Text = cmp_FL_SidebarPro.AppTitle`.

Resultado real:

```text
DEFINITION_ACCEPTED PASS
INSTANCE_SAFE       FAIL — Studio closes on insertion
```

Interpretación obligatoria:

> El fallo ya puede acotarse al patrón `Input/Text` declarado + consumido, pero todavía NO distingue si el problema está en la mera declaración de la CustomProperty o en el binding/consumo desde un control hijo.

La documentación oficial de Microsoft considera soportadas las propiedades Data de tipo Input para valores como texto y color; por tanto, el cierre observado se trata como incompatibilidad/incidente de autoría, no como comportamiento esperado.

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
El estado deberá entrar por inputs y salir por outputs/events, una vez demostrada su compatibilidad.

### FL-COMP-006 — Premium no significa sobrecarga visual
Priorizar jerarquía, legibilidad, densidad, estados, accesibilidad, feedback y consistencia.

### FL-COMP-007 — Reducir antes de reescribir cuando falla una instancia

```text
root only
→ identidad/texto
→ contenedores estáticos
→ acciones sin eventos
→ custom inputs simples
→ colecciones/Table/Gallery
→ outputs/events
→ geometría completa
```

El primer estadio que reproduce el fallo se subdivide; no se avanza al siguiente.

### FL-COMP-008 — R5 se subdivide por tipo y después por declaración/consumo

Resultados:

```text
R5    Text+Boolean+Color              FAIL
R5-T  Input/Text declarado+consumido  FAIL
```

Siguiente reducción obligatoria:

```text
R5-TD  Input/Text declarado, NO consumido
```

Para maximizar poder diagnóstico, R5-TD usará el baseline mínimo R1 ya validado y añadirá exclusivamente la declaración `Input/Text`, sin referencias a esa propiedad desde ningún control hijo.

Interpretación:

- si R5-TD falla: la mera declaración `Input/Text` es suficiente para reproducir el cierre en este baseline;
- si R5-TD pasa: el foco se desplaza al binding/consumo de la propiedad o a su interacción con una composición más compleja.

## Incidentes Functional Lab

### FL-SC-001 — `cmp_FL_SidebarPro` cierra Studio al insertar instancia

**Fecha:** 2026-08-10  
**Bloque:** F01-00A  
**Causa técnica:** `UNKNOWN — SURFACE NARROWED TO INPUT/TEXT DECLARATION VS CONSUMPTION`.  
**Estado:** `OPEN — BLOCKING`.  
**Resultados:** `R1 PASS`, `R2 PASS`, `R3 PASS`, `R4 PASS`, `R5 FAIL`, `R5-T FAIL`.  
**Correctivo actual:** `F01-00A-R5-TD`, Input/Text declarado sin consumo.  
**Registro completo:** `development/incidents/FL-SC-001-component-instance-crash.md`.

## Estado de validación

```text
cmp_FL_SidebarPro complete initial instance: FAIL
R1 root-only instance: PASS
R2 identity/text instance: PASS
R3 static containers instance: PASS
R4 static navigation instance: PASS
R5 primitive custom inputs combined: FAIL
R5-T Text input declared+consumed: FAIL
R5-TD Text input declaration only: PENDING
FL-SC-001: OPEN — BLOCKING
F01-00B: BLOCKED
```
