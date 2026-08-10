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

Validado en Studio mediante `F01-00A-R1`:

```text
CanvasComponent
└── GroupContainer@1.5.0 / ManualLayout
```

Resultado real: `INSTANCE_SAFE = PASS`.

### FL-EVID-002 — ModernText estático sobre root seguro

Validado mediante `F01-00A-R2`:

- cuatro `ModernText@1.0.0`;
- texto constante;
- `AutoHeight=true`;
- hijos directos del root validado.

Resultado real: `INSTANCE_SAFE = PASS`.

### FL-EVID-003 — AutoLayout y contenedores anidados estáticos

Validado mediante `F01-00A-R3`:

- root `GroupContainer@1.5.0` `AutoLayout` vertical;
- tres `GroupContainer@1.5.0` ManualLayout anidados;
- textos estáticos repartidos en Brand, Workspace y Footer;
- sin propiedades custom, Gallery, Table, Output, Event ni navegación.

Resultado real: `INSTANCE_SAFE = PASS`.

Interpretación limitada: la composición concreta de AutoLayout + contenedores anidados probada en R3 no es suficiente para reproducir FL-SC-001.

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

```text
F01-00A  cmp_FL_SidebarPro
F01-00B  cmp_FL_PageHeaderPro
F01-01   Premium App Shell Foundation
```

Un componente no se considerará disponible por existir en GitHub ni por aceptar su definición. Debe alcanzar `INSTANCE_SAFE`.

### FL-COMP-003 — Componentes Pulse son referencias, no dependencias

- `cmp_SidebarNav` está acoplado a PULSE mediante logo, textos y estado global; no se reutiliza directamente.
- `cmp_PageHeaderPro` es conceptualmente reusable, pero existe evidencia de cierre de Studio durante una prueba de instancia; se usa solo como referencia hasta comprender la causa.

### FL-COMP-004 — No copiar propiedades por apariencia

Una propiedad válida en un control o componente no se trasladará a otro por similitud visual.

### FL-COMP-005 — Sin estado global oculto dentro de componentes

Los componentes premium del Functional Lab deberán recibir estado mediante inputs y exponer selección/acciones mediante outputs y events. No usarán variables globales como estado de instancia salvo justificación y validación explícitas.

### FL-COMP-006 — Premium no significa sobrecarga visual

Los componentes deben priorizar jerarquía, legibilidad, densidad correcta, estados claros, accesibilidad, feedback, consistencia y comportamiento realista.

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

El primer estadio que reproduce el fallo delimita la superficie sospechosa.

## Incidentes Functional Lab

### FL-SC-001 — `cmp_FL_SidebarPro` cierra Studio al insertar instancia

**Fecha:** 2026-08-10  
**Bloque:** F01-00A  
**Efecto inicial:** la definición completa fue aceptada; al insertar una instancia, Power Apps Studio se cerró.  
**Session ID:** no disponible.  
**Causa técnica:** `UNKNOWN — INVESTIGATION ACTIVE`.  
**Estado:** `OPEN — BLOCKING`.  
**Resultados diagnósticos:** `R1 PASS`, `R2 PASS`, `R3 PASS`.  
**Correctivo actual:** `F01-00A-R4`, navegación visual sin eventos.  
**Registro completo:** `development/incidents/FL-SC-001-component-instance-crash.md`.

## Estado de validación

```text
Static inheritance / central standard: COMPLETE
Premium component strategy: ACTIVE
cmp_FL_SidebarPro complete initial instance: FAIL
R1 root-only instance: PASS
R2 identity/text instance: PASS
R3 static containers instance: PASS
FL-SC-001: OPEN — BLOCKING
F01-00B: BLOCKED
Current diagnostic: F01-00A-R4 static navigation without events
```
