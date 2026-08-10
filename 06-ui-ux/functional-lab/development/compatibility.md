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

A partir de `FL-SC-001`, ningún componente puede considerarse validado con una única etiqueta genérica.

Debe registrar explícitamente:

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

Antes de consumir cualquier componente en una pantalla funcional se debe:

1. integrar/crear la definición;
2. guardar y comprobar App Checker;
3. insertar una instancia por defecto en una superficie aislada;
4. guardar;
5. reabrir cuando sea razonable;
6. solo después probar contrato y visual QA.

Si Studio se cierra al insertar la instancia:

```text
INSTANCE_SAFE = FAIL
READY_FOR_INTEGRATION = NO
```

y se detiene cualquier bloque dependiente.

## Reglas heredadas y confirmadas por conocimiento previo

Estas reglas se aplican cuando el Functional Lab utilice las mismas versiones de control. Deben confirmarse de nuevo en Studio cuando corresponda.

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

## Decisiones para Functional Lab

### FL-COMP-001 — Foundation premium por componentes propios

El Functional Lab tendrá una biblioteca propia de componentes premium.

Los componentes podrán inspirarse en patrones y contratos probados en Pulse, pero su fuente canónica pertenecerá al Functional Lab y no deberá depender de:

- logo o assets de PULSE;
- variables globales de PULSE;
- nombres de pantallas de PULSE;
- contratos SQL/flows de PULSE;
- semántica específica de Punches.

### FL-COMP-002 — Incorporación secuencial antes del shell

Los componentes fundacionales se instalarán y validarán uno a uno en la app activa antes de que el shell los instancie.

Secuencia inicial:

```text
F01-00A  cmp_FL_SidebarPro
F01-00B  cmp_FL_PageHeaderPro
F01-01   Premium App Shell Foundation
```

Un componente no se considerará disponible por existir en GitHub ni por aceptar su definición. Debe alcanzar `INSTANCE_SAFE`.

### FL-COMP-003 — Componentes Pulse son referencias, no dependencias

Los componentes de Pulse se usan para aprender contratos, geometría y compatibilidad. No se copian sin auditoría.

Hallazgo inicial:

- `cmp_SidebarNav` está acoplado a PULSE mediante logo, textos y estado global; no se reutiliza directamente.
- `cmp_PageHeaderPro` es conceptualmente reusable, pero existe evidencia de cierre de Studio durante una prueba de instancia; se usa solo como referencia hasta comprender la causa.

### FL-COMP-004 — No copiar propiedades por apariencia

Una propiedad válida en un control o componente no se trasladará a otro por similitud visual.

### FL-COMP-005 — Sin estado global oculto dentro de componentes

Los componentes premium del Functional Lab deberán recibir estado mediante inputs y exponer selección/acciones mediante outputs y events. No usarán variables globales como estado de instancia salvo justificación y validación explícitas.

### FL-COMP-006 — Premium no significa sobrecarga visual

Los componentes deben priorizar:

- jerarquía;
- legibilidad;
- densidad correcta;
- estados claros;
- accesibilidad;
- feedback;
- consistencia;
- comportamiento realista.

No se añadirán gráficos, sombras o decoración sin función.

### FL-COMP-007 — Reducir antes de reescribir cuando falla una instancia

Ante un cierre de Studio o fallo de instancia cuya causa técnica no esté demostrada, no atribuir el problema por intuición a un control concreto.

Aplicar reducción incremental:

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

El primer estadio que reproduce el fallo delimita la superficie sospechosa.

## Incidentes Functional Lab

### FL-SC-001 — `cmp_FL_SidebarPro` cierra Studio al insertar instancia

**Fecha:** 2026-08-10  
**Bloque:** F01-00A  
**Efecto:** la definición fue aceptada; al insertar una instancia, Power Apps Studio se cierra.  
**Session ID:** no disponible en el cierre observado.  
**Causa técnica:** `UNKNOWN`.  
**Estado:** `OPEN — BLOCKING`.  
**Correctivo actual:** `F01-00A-R1`, reducción a root-only.  
**Registro completo:** `development/incidents/FL-SC-001-component-instance-crash.md`.

No se promueve ninguna hipótesis (`Gallery`, `Table`, `Event`, `Output`, `ModernText`, AutoLayout, etc.) a causa hasta obtener un reproducer reducido.

## Estado de validación

```text
Static inheritance / central standard: COMPLETE
Premium component strategy: ACTIVE
cmp_FL_SidebarPro definition: ACCEPTED
cmp_FL_SidebarPro instance: FAIL
FL-SC-001: OPEN — BLOCKING
F01-00B: BLOCKED
Current diagnostic: F01-00A-R1 root-only
```
