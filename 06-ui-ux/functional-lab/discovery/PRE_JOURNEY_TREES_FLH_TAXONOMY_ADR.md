# Discovery — Contexto previo al journey: FLH, Taxonomía y ADR

**Fecha:** 2026-08-10  
**Estado:** `active-discovery`  
**Prioridad:** alta para visión global, sin bloquear indefinidamente WS-03  
**Decisión de implementación:** pendiente

## 1. Motivo

El Functional Lab recorre actualmente 28 etapas de la metodología de mantenimiento, desde FL-01 hasta FL-28. Antes de entrar en ese recorrido falta una capa de contexto que permita entender dónde vive el activo analizado y cómo se relacionan las distintas jerarquías y clasificaciones del modelo conceptual.

Se proponen tres vistas previas al journey, todas usando el mismo caso P-101:

1. **Árbol FLH** — localizar física/funcionalmente P-101 dentro de la jerarquía de planta.
2. **Taxonomía** — mostrar la clasificación del activo y su posición dentro del modelo taxonómico vigente.
3. **Árbol ADR** — mostrar el contexto ADR aplicable al mismo activo según el modelo conceptual vigente.

Estas vistas no deben convertirse automáticamente en nuevas etapas FL-29..FL-31. La hipótesis inicial es tratarlas como **contexto previo al journey**, preservando intactas las 28 etapas metodológicas.

## 2. Objetivo de producto

Antes de comenzar FL-01, una persona debería poder responder visualmente:

- ¿Dónde está P-101 dentro de la planta?
- ¿Cómo se clasifica?
- ¿Qué rama ADR le aplica?
- ¿Qué relaciones existen entre jerarquía, taxonomía y análisis de mantenimiento?
- ¿Qué parte del contexto proviene de información maestra y qué parte se utiliza después durante AMEF/RCM?

El propósito es mantener una fotografía completa del modelo conceptual CMMS 2.0 y evitar que el Functional Lab quede reducido únicamente al journey AMEF/RCM.

## 3. Hipótesis de navegación

```text
CONTEXTO DEL ACTIVO
├── FLH
├── Taxonomía
└── ADR

METODOLOGÍA DE MANTENIMIENTO
├── WS-01 / FL-01..03
├── WS-02 / FL-04..06
├── ...
└── WS-09 / FL-27..28
```

Esta estructura es una hipótesis de UX y deberá validarse antes de modificar el Sidebar canónico.

## 4. Investigación solicitada — componente de árbol PULSE

Existe en PULSE una experiencia de árbol identificada por el usuario con una profundidad aproximada de tres niveles. Debe auditarse como posible base de un componente premium reutilizable para CMMS 2.0.

### Pregunta principal

> ¿Puede evolucionar el patrón de árbol de PULSE desde una jerarquía fija de tres niveles a una jerarquía de profundidad variable, capaz de representar hasta once niveles cuando sea necesario, sin diseñar un componente distinto por profundidad?

El objetivo práctico no es obligar a mostrar once niveles. El componente debe poder soportarlos, aunque en una planta concreta solo se utilicen cinco o seis.

## 5. Modelo objetivo a contrastar

No se adopta todavía como arquitectura definitiva, pero el patrón que debe evaluarse frente al árbol real es un modelo padre-hijo genérico:

```text
NodeId
ParentNodeId
NodeType
Level
Code
Name
Path
HasChildren
SortOrder
```

Esto permitiría separar profundidad máxima de diseño visual y evitar columnas rígidas `Level1`, `Level2`, `Level3`, etc.

## 6. Capacidades a auditar

Cuando se localice la fuente real del árbol PULSE se evaluarán conjuntamente:

- modelo fijo vs padre-hijo;
- indentación dinámica por nivel;
- expandir / contraer por nodo;
- estado expandido independiente;
- iconografía por tipo de nodo;
- selección única;
- resaltado de P-101;
- breadcrumbs y path completo;
- búsqueda;
- profundidad variable;
- colección aplanada de nodos visibles;
- scroll y nombres largos;
- rendimiento con cientos/miles de nodos;
- posible lazy expansion;
- contrato reusable para FLH, Taxonomía y ADR.

La prueba debe distinguir siempre **profundidad máxima** de **número total de nodos visibles**, porque son problemas diferentes.

## 7. Contrato reusable premium a explorar

Nombre provisional:

```text
cmp_FL_TreePro
```

Contrato conceptual posible:

```text
Inputs
- Nodes
- SelectedNodeId
- HighlightNodeId
- MaxVisualDepth
- ShowBreadcrumb
- ShowSearch
- IsReadOnly
- colores / densidad

Outputs
- SelectedNode
- SelectedNodeId
- SelectedPath

Events
- OnSelectNode
- OnExpandNode
- OnCollapseNode
```

No se generará YAML de este componente hasta disponer de evidencia del árbol actual y cerrar la decisión de diseño.

## 8. Reutilización entre las tres pantallas

Hipótesis preferida:

```text
Tree engine
├── FLH dataset
├── Taxonomy dataset
└── ADR dataset
```

Evitar tres componentes distintos salvo que exista una diferencia funcional real que lo justifique.

## 9. Caso P-101 como hilo conductor

P-101 deberá poder aparecer:

- resaltado en FLH;
- clasificado en la taxonomía;
- relacionado con su rama ADR;
- y después continuar al WS-01 sin cambiar de contexto.

El usuario debe sentir que está mirando **tres perspectivas del mismo activo**, no tres ejemplos diferentes.

## 10. Valor potencial para CMMS 2.0 en Power Apps

Si Power Apps resultara finalmente una plataforma viable para una versión productiva de CMMS 2.0, disponer de componentes premium reutilizables para jerarquías profundas, taxonomías y estructuras ADR reduciría sustancialmente el riesgo de una futura implementación.

El Functional Lab puede funcionar como banco de pruebas de componentes reutilizables sin convertir esa posibilidad en una decisión productiva anticipada.

## 11. Checkpoint ejecutado tras WS-02

WS-02 ha sido validado por el usuario y se ejecutó el checkpoint acordado.

Evidencia obtenida del snapshot `main` de `rubensv74/app_pulse`:

```text
power-apps/components
→ no aparece Tree*, Hierarchy* ni componente equivalente por nombre evidente

búsqueda de código
→ tree / hierarchy / ParentId / FLH sin coincidencia suficiente para identificar la fuente

power-apps/screens
→ Home
→ PunchReview
→ Punches
```

Conclusión del checkpoint:

> El árbol que el usuario identifica en PULSE no está todavía localizado en el contenido versionado examinado. Puede estar embebido bajo otro nombre, en una versión no reflejada en `main`, en otra fuente o pendiente de sincronización con el repositorio.

No se inferirá su implementación ni se declarará una limitación real de tres niveles hasta analizar el artefacto exacto.

## 12. Decisión operativa tras el checkpoint

El discovery permanece abierto, pero no bloquea el journey.

Secuencia adoptada:

```text
WS-02 VALIDATED PASS
→ checkpoint TreePro ejecutado
→ fuente exacta del árbol PULSE pendiente
→ continuar WS-03
→ retomar auditoría TreePro en cuanto el componente real esté disponible
```

Si durante WS-03/WS-04 aparece la fuente real del árbol, la auditoría puede retomarse inmediatamente sin alterar las 28 etapas.

## 13. Criterio de salida de la investigación

La auditoría debe terminar con una recomendación explícita:

```text
A — reutilizar componente PULSE sin cambio estructural
B — evolucionar componente PULSE a TreePro de profundidad variable
C — conservar patrón visual pero reconstruir motor de árbol
D — Power Apps no es una solución razonable para esta profundidad/volumen
```

La recomendación debe venir acompañada de evidencia del componente actual, modelo de datos propuesto, límites conocidos, riesgos de rendimiento, prueba mínima representativa e impacto sobre FLH / Taxonomía / ADR.
