# Functional Lab — Power Apps Source Code Compatibility

**Estado:** activo antes de cualquier YAML  
**Origen inicial:** lecciones transferibles confirmadas en `rubensv74/app_pulse`.

## Gate obligatorio pre-YAML

Antes de redactar, corregir o publicar cualquier `.pa.yaml` del Functional Lab:

1. leer la versión vigente de este documento;
2. confirmar control y versión exactos;
3. comparar con ejemplos ya validados;
4. no asumir que un componente existe en la app porque exista en GitHub;
5. registrar cualquier error nuevo y convertirlo en regla preventiva.

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

## Decisiones para Functional Lab

### FL-COMP-001 — Bloque 01 sin dependencia de componentes premium

El primer shell se construirá únicamente con controles cuyo tipo y versión hayan sido confirmados en la app base.

Objetivo: evitar que el primer gate dependa de una biblioteca de componentes todavía no instalada.

### FL-COMP-002 — Componentes Pulse son candidatos, no dependencias asumidas

`cmp_PageHeaderPro`, `cmp_SidebarNav`, `cmp_EmptyState`, `cmp_SkeletonLoader` y otros componentes de Pulse podrán evaluarse posteriormente.

Para utilizar cualquiera de ellos debe existir un paso explícito de incorporación y validación en la app del Functional Lab.

### FL-COMP-003 — No copiar propiedades por apariencia

Una propiedad válida en un control o componente no se trasladará a otro por similitud visual.

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
Functional Lab Studio validation: PENDING
```
