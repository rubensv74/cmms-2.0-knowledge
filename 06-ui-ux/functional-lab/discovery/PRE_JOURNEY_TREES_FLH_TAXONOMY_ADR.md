# Discovery — Contexto previo al journey: FLH, Taxonomía y ADR

**Fecha:** 2026-08-10  
**Estado:** `captured-for-analysis`  
**Prioridad:** alta para visión global, sin bloquear F01-06 WS-02  
**Decisión de implementación:** pendiente

## 1. Motivo

El Functional Lab recorre actualmente 28 etapas de la metodología de mantenimiento, desde FL-01 hasta FL-28. Antes de entrar en ese recorrido falta una capa de contexto que permita entender dónde vive el activo analizado y cómo se relacionan las distintas jerarquías y clasificaciones del modelo conceptual.

Se proponen tres vistas previas al journey, todas usando el mismo caso P-101:

1. **Árbol FLH** — localizar físicamente/funcionalmente P-101 dentro de la jerarquía de planta.
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

Existe en PULSE un componente/experiencia de árbol actualmente utilizada con una profundidad aproximada de tres niveles. Debe auditarse como posible base de un componente premium reutilizable para CMMS 2.0.

### Pregunta principal

> ¿Puede evolucionar el patrón de árbol de PULSE desde una jerarquía fija de tres niveles a una jerarquía de profundidad variable, capaz de representar hasta once niveles cuando sea necesario, sin diseñar un componente distinto por profundidad?

El objetivo práctico no es obligar a mostrar once niveles. El componente debe poder soportarlos, aunque en una planta concreta solo se utilicen cinco o seis.

## 5. Criterios de auditoría del árbol PULSE

La investigación deberá cubrir como mínimo:

### 5.1 Modelo de datos

Determinar si el componente actual depende de columnas fijas tipo:

```text
Level1
Level2
Level3
```

O si puede migrarse a un modelo genérico tipo:

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

La segunda forma sería preferible para profundidad variable, pero no se adopta todavía como decisión de arquitectura.

### 5.2 Renderizado

Evaluar:

- indentación dinámica por `Level`;
- expandir / contraer nodos;
- estado expandido independiente por nodo;
- iconografía por tipo de nodo;
- selección única del nodo activo;
- resaltado de P-101;
- breadcrumbs del nodo seleccionado;
- path completo visible bajo demanda;
- nombres largos;
- scroll vertical;
- profundidad visual máxima razonable antes de degradar UX.

### 5.3 Profundidad variable

Validar si el algoritmo actual está realmente limitado a tres niveles o si la limitación procede solo del dataset / fórmulas actuales.

Comparar al menos estas alternativas:

1. galerías anidadas por nivel fijo;
2. colección aplanada de nodos visibles;
3. relación padre-hijo con cálculo de path/nivel;
4. carga progresiva / lazy expansion cuando el volumen lo justifique.

No decidir hasta medir complejidad y estabilidad real en Canvas Apps.

### 5.4 Rendimiento

Probar conceptualmente escenarios representativos:

```text
5 niveles / pocos nodos
6 niveles / cientos de nodos
11 niveles / ramas profundas
miles de nodos totales con solo una parte expandida
```

La prueba debe distinguir entre **profundidad máxima** y **número total de nodos visibles**, porque son problemas distintos.

### 5.5 Contrato reusable premium

Si la adaptación es viable, estudiar un futuro componente genérico, provisionalmente:

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

Este contrato es únicamente material de investigación; no debe convertirse en YAML hasta cerrar la auditoría.

## 6. Reutilización entre las tres pantallas

La hipótesis preferida es **un único motor de árbol** y tres configuraciones/datasets diferentes:

```text
Tree engine
├── FLH dataset
├── Taxonomy dataset
└── ADR dataset
```

Evitar tres componentes distintos salvo que exista una diferencia funcional real que lo justifique.

## 7. Caso P-101 como hilo conductor

Las tres vistas deberán usar el mismo caso que el journey actual.

P-101 deberá poder aparecer:

- resaltado en FLH;
- clasificado en la taxonomía;
- relacionado con su rama ADR;
- y después continuar al WS-01 sin cambiar de contexto de caso.

El usuario debe sentir que está mirando **tres perspectivas del mismo activo**, no tres ejemplos diferentes.

## 8. Valor potencial para una futura CMMS 2.0 en Power Apps

Esta investigación también tiene valor estratégico. Si Power Apps resultara finalmente una plataforma viable para una versión productiva de CMMS 2.0, disponer de componentes premium reutilizables para:

- jerarquías profundas;
- navegación de activos;
- taxonomías;
- estructuras ADR;
- selección contextual;

reduciría sustancialmente el riesgo y el esfuerzo de una futura implementación.

El Functional Lab puede funcionar por tanto como banco de pruebas de componentes reutilizables, sin convertir esa posibilidad en una decisión productiva anticipada.

## 9. Momento recomendado

No interrumpir F01-06 WS-02.

Checkpoint recomendado:

```text
cerrar WS-02
→ auditar componente árbol PULSE
→ decidir si construir prototipo TreePro ahora
   o mantenerlo como backlog hasta completar el journey
→ continuar WS-03
```

La auditoría puede alterar la navegación global del Functional Lab, pero no debe modificar la lógica de las 28 etapas.

## 10. Estado inicial de la búsqueda PULSE

Se ha iniciado la localización del componente en `rubensv74/app_pulse`.

La carpeta actual `power-apps/components` no expone, por nombre obvio, un fichero `Tree*` o `Hierarchy*`. La búsqueda de código por términos genéricos tampoco ha localizado todavía el origen con suficiente certeza.

Por tanto, antes de analizar la implementación debemos localizar la **fuente real del árbol que el usuario identifica en PULSE** —puede estar embebida en una pantalla, bajo otro nombre de componente, en otra rama o no estar todavía reflejada en el snapshot actual del repositorio.

No se inferirá su arquitectura hasta identificar esa fuente exacta.

## 11. Criterio de salida de la investigación

La auditoría futura debe terminar con una recomendación explícita:

```text
A — reutilizar componente PULSE sin cambio estructural
B — evolucionar componente PULSE a TreePro de profundidad variable
C — conservar patrón visual pero reconstruir motor de árbol
D — Power Apps no es una solución razonable para esta profundidad/volumen
```

La recomendación debe venir acompañada de:

- evidencia del componente actual;
- modelo de datos propuesto;
- límites conocidos;
- riesgos de rendimiento;
- prueba mínima representativa;
- impacto sobre FLH / Taxonomía / ADR;
- decisión sobre cuándo integrarlo en el Functional Lab.
