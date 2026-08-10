# FL-SC-001 — Studio se cierra al insertar instancia de CanvasComponent

**Fecha:** 2026-08-10  
**Estado:** OPEN — BLOCKING  
**Severidad:** alta para el flujo de autoría  
**Bloque afectado:** F01-00A  
**Componente:** `cmp_FL_SidebarPro`

## 1. Efecto confirmado

La definición Source Code de `cmp_FL_SidebarPro` fue integrada en Power Apps Studio sin errores aparentes.

Al insertar una instancia del componente en la app `CMMS 2.0 Functional Lab`, Power Apps Studio se cierra.

Por tanto, el componente alcanza únicamente:

```text
SOURCE_VALID                 PASS
COMPONENT_DEFINITION_ACCEPTED PASS
INSTANCE_SAFE                FAIL
READY_FOR_INTEGRATION        NO
```

## 2. Acción exacta anterior al cierre

```text
Insertar una instancia de cmp_FL_SidebarPro
→ Power Apps Studio se cierra
```

No se ha reportado mensaje de error ni Session ID porque el síntoma observado es un cierre de Studio.

## 3. Fuente afectada

Fuente que reproduce el incidente:

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

El proyecto ya disponía del concepto de validación en Studio, pero F01-00A debe registrar explícitamente el estado `INSTANCE_SAFE` antes de considerarse validado.

### Causa técnica concreta

```text
UNKNOWN
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

Aplicar reducción incremental manteniendo el mismo nombre de componente:

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

## 7. Primer correctivo

`F01-00A-R1` sustituirá temporalmente la fuente completa por un componente mínimo:

- sin custom properties;
- sin Gallery;
- sin Event;
- sin Output;
- sin Table;
- sin controles modernos;
- un único `GroupContainer@1.5.0` raíz.

Objetivo: comprobar si una definición CanvasComponent mínima creada por Source Code puede instanciarse de forma estable en esta app.

## 8. Resultado esperado R1

```text
Definition accepted
Instance inserts without closing Studio
Save succeeds
App Checker has no new error attributable to component
```

### Interpretación

Si R1 falla:

> la investigación se desplaza desde la complejidad interna del sidebar hacia el mecanismo/baseline de CanvasComponent Source Code en la app activa.

Si R1 pasa:

> la infraestructura mínima es segura y se reconstruirá el sidebar por responsabilidades hasta aislar el primer incremento que reproduce el cierre.

## 9. Regla preventiva inmediata

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

## 10. Criterio de cierre

FL-SC-001 solo podrá cerrarse cuando:

1. exista un reproducer reducido o una causa técnica suficientemente delimitada;
2. la fuente corregida pueda instanciarse de forma estable;
3. guardar/reabrir no rompa la instancia;
4. la regla preventiva esté reflejada en `development/compatibility.md`;
5. el aprendizaje reutilizable central quede actualizado si aporta evidencia nueva respecto al estándar existente.
