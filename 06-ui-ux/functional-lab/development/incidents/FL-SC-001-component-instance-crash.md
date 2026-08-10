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

Tras R1, R2 y R3 puede afirmarse de forma limitada que no son suficientes por sí solos para reproducir el cierre:

- `CanvasComponent + GroupContainer@1.5.0` ManualLayout mínimo;
- cuatro `ModernText@1.0.0` estáticos con `AutoHeight=true`;
- raíz `AutoLayout` vertical;
- tres `GroupContainer@1.5.0` anidados y estáticos.

Siguen sin aislarse como causa o superficie suficiente:

- `Rectangle@2.3.0`;
- `Classic/Icon@2.5.0`;
- `Label@2.5.1`;
- `Classic/Button@2.2.0`;
- `Gallery@2.15.0`;
- custom properties;
- `Table`;
- `Output`;
- `Event`;
- lógica dinámica y geometría condicional.

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

```text
DEFINITION_ACCEPTED PASS
INSTANCE_SAFE       PASS
```

El mecanismo básico de CanvasComponent Source Code y el root `GroupContainer@1.5.0` ManualLayout no reproducen el incidente.

### R2 — Identidad / texto

**Resultado real comunicado:** `R2 instancia OK`.

```text
DEFINITION_ACCEPTED PASS
INSTANCE_SAFE       PASS
```

Cuatro `ModernText@1.0.0` estáticos sobre R1 no reproducen el incidente.

### R3 — Contenedores estáticos

**Resultado real comunicado:** `R3 instancia OK`.

Configuración añadida sobre el baseline validado:

- root `GroupContainer@1.5.0` como `AutoLayout` vertical;
- tres `GroupContainer@1.5.0` hijos estáticos;
- identidad, zona de workspace y footer distribuidos entre ellos;
- sin navegación interactiva;
- sin custom properties;
- sin Gallery / Table;
- sin Output / Event.

Resultado:

```text
DEFINITION_ACCEPTED PASS
INSTANCE_SAFE       PASS
```

### Interpretación R3

La composición estática probada con AutoLayout y contenedores anidados no reproduce FL-SC-001.

Por tanto, la investigación avanza a la siguiente responsabilidad: controles visuales de navegación sin fórmulas de evento ni datos dinámicos.

### R4 — Navegación visual sin eventos

**Estado:** PENDING STUDIO VALIDATION.

R4 reintroducirá únicamente controles visuales utilizados por la navegación original, con valores estáticos y sin `OnSelect`:

- `Rectangle@2.3.0`;
- `Classic/Icon@2.5.0`;
- `Label@2.5.1`;
- `Classic/Button@2.2.0` como hit surface visual sin evento.

Se mantienen fuera `Gallery`, `Table`, custom properties, outputs, events y navegación real.

Si R4 falla, se subdividirá esta etapa por tipo de control antes de avanzar.

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
