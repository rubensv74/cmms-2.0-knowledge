# FL-SC-001 — Studio se cierra al insertar instancia de CanvasComponent

**Fecha:** 2026-08-10  
**Estado:** OPEN — BLOCKING  
**Severidad:** alta para el flujo de autoría  
**Bloque afectado:** F01-00A  
**Componente:** `cmp_FL_SidebarPro`

## 1. Efecto confirmado

La definición Source Code completa inicial de `cmp_FL_SidebarPro` fue integrada en Power Apps Studio sin errores aparentes.

Al insertar una instancia del componente completo inicial en la app `CMMS 2.0 Functional Lab`, Power Apps Studio se cerró.

Estado de aquella versión:

```text
SOURCE_VALID                  PASS
COMPONENT_DEFINITION_ACCEPTED PASS
INSTANCE_SAFE                 FAIL
READY_FOR_INTEGRATION         NO
```

## 2. Acción exacta anterior al cierre

```text
Insertar una instancia de cmp_FL_SidebarPro
→ Power Apps Studio se cierra
```

No se reportó mensaje de error ni Session ID porque el síntoma observado fue un cierre de Studio.

## 3. Fuente afectada

Fuente completa inicial que produjo el incidente:

```text
06-ui-ux/functional-lab/power-apps/components/cmp_FL_SidebarPro.pa.yaml
```

Blob/source SHA observado antes de la reducción:

```text
c8e3ac6bc2ef81c1fffdc90a8ec60807b75e9500
```

## 4. Causa

### Causa de proceso confirmada

La aceptación de `ComponentDefinitions:` fue tratada como un gate insuficiente para demostrar seguridad de instancia.

El protocolo se ha corregido para exigir explícitamente `INSTANCE_SAFE` antes de integrar un CanvasComponent en una pantalla funcional.

### Causa técnica concreta

```text
UNKNOWN — INVESTIGATION ACTIVE
```

No se atribuye todavía el cierre a:

- `Gallery@2.15.0`;
- propiedad custom `Table`;
- propiedad `Event`;
- propiedad `Output`;
- `ModernText@1.0.0`;
- AutoLayout;
- fórmulas de geometría;
- ningún control individual.

Promover cualquiera de esas hipótesis a causa sin reproducer mínimo produciría una regla preventiva falsa.

## 5. Evidencia transversal ya existente

La base de conocimiento central ya documenta el mismo patrón de efecto en otro componente (`cmp_PageHeaderPro`): definición aceptada y cierre de Studio al insertar instancia.

Referencias:

```text
rubensv74/functional-engineering-knowledge-base
15-standards/power-platform/power-apps-source-code-compatibility-standard.md
80-learning/power-platform/POWER_APPS_UI_LESSONS_LEARNED.md
```

Este segundo caso refuerza la obligatoriedad del gate `INSTANCE_SAFE`, pero no confirma todavía una causa técnica común.

## 6. Estrategia de diagnóstico

Aplicar reconstrucción incremental manteniendo el mismo nombre de componente:

```text
R1 root only
→ R2 identidad/texto
→ R3 contenedores estáticos
→ R4 navegación visual sin eventos
→ R5 custom inputs simples
→ R6 Gallery + Table input
→ R7 outputs/events
→ R8 geometría completa
```

El primer estadio que vuelva a cerrar Studio delimitará la superficie sospechosa.

No se preparará F01-00B mientras este incidente permanezca abierto.

## 7. Resultados de reducción

### R1 — Root only

**Resultado real comunicado:** `R1 instancia OK`.

Configuración probada:

- `CanvasComponent`;
- propiedades `Fill`, `Height`, `Width`;
- un único `GroupContainer@1.5.0` ManualLayout;
- sin custom properties;
- sin controles de texto;
- sin Gallery;
- sin Event;
- sin Output;
- sin Table;
- sin AutoLayout anidado.

Resultado:

```text
DEFINITION_ACCEPTED PASS
INSTANCE_SAFE       PASS
```

### Interpretación R1

El mecanismo básico de CanvasComponent Source Code en la app activa **no es suficiente para reproducir el cierre**.

El patrón mínimo `CanvasComponent + GroupContainer@1.5.0` raíz también resulta seguro en esta prueba.

Por tanto, la investigación continúa únicamente sobre responsabilidades añadidas respecto a R1.

Esto no demuestra todavía que cualquier uso de `GroupContainer@1.5.0` sea universalmente seguro; demuestra que el patrón concreto de R1 no reproduce FL-SC-001.

### R2 — Identidad / texto

**Estado:** PENDING STUDIO VALIDATION.

Se añaden únicamente cuatro controles `ModernText@1.0.0` estáticos, con texto constante y `AutoHeight=true`, directamente dentro del root ya validado.

Se mantienen excluidos:

- custom properties;
- Gallery / Table;
- Output / Event;
- Label / Button / Icon;
- navegación;
- geometría condicional;
- contenedores anidados;
- AutoLayout anidado.

Objetivo: comprobar si la capa de controles hijos de texto estático es suficiente para reproducir el cierre.

## 8. Regla preventiva inmediata

Todo CanvasComponent nuevo debe registrar estados separados:

```text
PASS_STATIC
DEFINITION_ACCEPTED
INSTANCE_SAFE
PUBLIC_CONTRACT_VALIDATED
VISUAL_QA_VALIDATED
READY_FOR_INTEGRATION
```

Nunca usar `validado`, `listo` o equivalente mientras `INSTANCE_SAFE` no haya pasado.

Cuando se diagnostique un cierre de instancia, reconstruir desde un baseline mínimo que ya haya demostrado `INSTANCE_SAFE`, añadiendo una sola responsabilidad por iteración.

## 9. Criterio de cierre

FL-SC-001 solo podrá cerrarse cuando:

1. exista un reproducer reducido o una causa técnica suficientemente delimitada;
2. la fuente corregida completa pueda instanciarse de forma estable;
3. guardar/reabrir no rompa la instancia;
4. la regla preventiva esté reflejada en `development/compatibility.md`;
5. el aprendizaje reutilizable central quede actualizado si aporta evidencia nueva respecto al estándar existente.
