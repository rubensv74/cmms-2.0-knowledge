# Functional Lab — Power Apps Source Code Compatibility

**Estado:** activo antes de cualquier YAML  
**Origen inicial:** lecciones transferibles confirmadas en `rubensv74/app_pulse`.

## Gate obligatorio pre-YAML

Antes de redactar, corregir o publicar cualquier `.pa.yaml` del Functional Lab:

1. leer la versión vigente de este documento;
2. confirmar control y versión exactos contra referencias ya probadas cuando sea posible;
3. comparar con ejemplos validados;
4. no asumir que un componente existe en la app porque exista en GitHub;
5. no reutilizar un componente de Pulse sin revisar acoplamientos de marca, variables, assets y contratos;
6. registrar cualquier error nuevo y convertirlo en regla preventiva.

## Reglas heredadas de Pulse

Estas reglas se aplican cuando el Functional Lab utilice las mismas versiones de control que Pulse. Deben confirmarse de nuevo en Studio.

| Patrón | Riesgo confirmado en Pulse | Regla preventiva |
|---|---|---|
| `Label@2.5.1` + `Radius*` | `PA2108` | Aplicar radios al contenedor, no a la etiqueta. |
| `Classic/Button@2.2.0` + `AccessibleLabel` | `PA2108` | No declarar esa propiedad sin validación específica. |
| `TabList@2.2.30` + `Reset()` | error de fórmula | Controlar selección mediante variable. |
| variable numérica inicializada solo con `Blank()` | tipo/nombre no establecido | Primera asignación numérica inequívoca, por ejemplo `0`. |
| `CanvasComponent` solo existente en GitHub | `PA2301` | Confirmar que el componente está añadido a la app activa. |
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

Un componente no se considerará disponible por existir en GitHub. Power Apps Studio debe aceptarlo primero.

### FL-COMP-003 — Componentes Pulse son referencias, no dependencias

Los componentes de Pulse se usan para aprender contratos, geometría y compatibilidad. No se copian sin auditoría.

Hallazgo inicial:

- `cmp_SidebarNav` está acoplado a PULSE mediante logo, textos y estado global; no se reutiliza directamente.
- `cmp_PageHeaderPro` es conceptualmente reusable, pero la fuente revisada conserva una corrección visual pendiente de revalidación; se tomará como referencia para un componente propio.

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

## Incidentes Functional Lab

Todavía no existen incidentes confirmados en Power Apps Studio.

Cuando aparezca el primero debe registrarse con:

```text
ID
Fecha
Bloque
Control / versión
Mensaje completo
Session ID
Causa
Corrección
Regla preventiva
Archivos afectados
Estado
```

## Estado de validación

```text
Static inheritance from Pulse: COMPLETE
Premium component strategy: ACTIVE
Functional Lab Studio validation: PENDING
First component to validate: cmp_FL_SidebarPro
```
