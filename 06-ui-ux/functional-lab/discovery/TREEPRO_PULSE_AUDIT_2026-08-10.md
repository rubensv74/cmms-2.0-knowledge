# Auditoría PULSE — `cmp_TreeViewPro` y evolución `cmp_FL_TreePro`

**Fecha:** 2026-08-10  
**Estado:** candidato técnico preparado  
**Recomendación:** **B — evolucionar el componente PULSE a TreePro de profundidad variable**

## 1. Fuente real localizada

Componente PULSE auditado:

```text
rubensv74/app_pulse
power-apps/components/cmp_TreeViewPro.pa.yaml
```

El componente ya utiliza un modelo plano de árbol basado en:

```text
RowNodeId
RowParentNodeId
RowLevel
RowLabel
RowDescription
RowSortPath
RowIcon
```

Esto es importante porque demuestra que la experiencia PULSE **no está estructuralmente construida como tres galerías fijas**.

## 2. Hallazgo principal

La profundidad no está fijada a tres niveles en el motor de renderizado.

La posición horizontal se calcula con `RowLevel`, por ejemplo mediante expresiones equivalentes a:

```text
nivel → sangría dinámica
```

Por tanto, un registro con `RowLevel = 6` o `RowLevel = 11` puede recibir una posición visual calculada sin añadir una nueva galería.

El límite observado de tres niveles procede principalmente de decisiones de presentación y del dataset utilizado, no de una estructura rígida de UI.

## 3. Fortalezas reutilizables de PULSE

Se conservan como base:

- `CanvasComponent` ya probado;
- `CustomProperties` completas;
- tabla plana como Input;
- `Gallery@2.15.0`;
- orden mediante `RowSortPath`;
- indentación por nivel;
- selección visual;
- búsqueda;
- iconografía;
- contrato de outputs y evento de selección.

Esto convierte `cmp_TreeViewPro` en una referencia positiva mucho mejor que reconstruir un árbol desde cero.

## 4. Limitaciones del componente PULSE actual

### 4.1 Expansión / contracción

El componente actual no mantiene una semántica real de expandir/contraer. Renderiza las filas recibidas después del filtro de búsqueda.

### 4.2 Estado global

La selección utiliza variables mediante `Set(varTree_...)`.

Es un patrón funcional en PULSE, pero para un componente reutilizable que pueda aparecer en diferentes contextos debe evitarse asumir aislamiento entre múltiples instancias.

### 4.3 Presentación orientada a tres niveles

Los `Switch` de color e iconografía tratan explícitamente niveles 1, 2 y 3 y después aplican fallback.

La lógica de posición sí es dinámica, pero la semántica visual por nivel no lo es.

### 4.4 Guías jerárquicas

Las líneas actuales representan la rama inmediata calculada por nivel. No dibujan necesariamente todos los conectores ancestrales de una jerarquía profunda.

Esto no impide representar 11 niveles, pero puede requerir refinamiento visual posterior.

### 4.5 Anchura

El componente PULSE parte de un ancho de 420 px y una sangría aproximada de 18 px por nivel.

A nivel 11, solo la sangría puede consumir aproximadamente 180 px. Es viable, pero obliga a diseñar conscientemente:

- ancho del componente;
- nombres largos;
- modo compacto;
- profundidad visual máxima;
- breadcrumb/path para recuperar contexto.

### 4.6 Búsqueda

La búsqueda filtra filas coincidentes, pero no reconstruye automáticamente toda la línea ancestral del resultado.

Para navegación de activos profunda puede ser conveniente una evolución posterior donde buscar P-101 muestre también su path.

## 5. Decisión de diseño

Se adopta para el prototipo:

```text
UN SOLO COMPONENTE
+
TABLA PLANA PADRE-HIJO
+
PROFUNDIDAD COMO DATO
```

No se crearán:

```text
11 galerías anidadas
11 columnas Level1..Level11
11 versiones del componente
```

## 6. Evolución propuesta — `cmp_FL_TreePro`

Contrato de entrada principal:

```text
RowNodeId
RowParentNodeId
RowLevel
RowLabel
RowDescription
RowSortPath
RowPath
RowNodeType
RowHasChildren
RowIsExpanded
RowIsVisible
```

Capacidades añadidas en el primer candidato:

- `MaxVisualDepth`;
- `IndentSize`;
- `HighlightNodeId`;
- `ShowBreadcrumb`;
- `SelectedPathOut`;
- `OnToggleNode`;
- `ToggleNodeIdOut`;
- `ToggleTargetExpandedOut`;
- búsqueda por nombre, descripción y path;
- modo compacto / cómodo;
- iconografía desacoplada parcialmente del nivel;
- P-101 resaltable sin forzar selección.

## 7. Estado y expansión

La primera evolución evita guardar la expansión mediante variables globales internas.

El componente:

```text
renderiza
selecciona
solicita toggle
emite outputs/eventos
```

El host mantiene:

```text
RowIsVisible
RowIsExpanded
```

Ventajas:

- una instancia no contamina a otra;
- el mismo componente sirve para FLH, Taxonomía y ADR;
- la lógica de datos puede migrar posteriormente a SQL/Dataverse/API sin rehacer la UI;
- expandir/contraer no queda acoplado al número de niveles.

## 8. Prueba de profundidad 11

Se ha preparado una pantalla aislada:

```text
scr_FL_TreeLab
```

El dataset de prueba contiene una rama de once niveles y coloca el caso P-101 en el nivel 11.

**Importante:** los nombres de los once niveles son únicamente un dataset de validación técnica. No se presentan como jerarquía ISO 14224 definitiva.

La prueba pretende validar en un único recorrido:

```text
profundidad 11
+ búsqueda
+ selección
+ highlight P-101
+ breadcrumb/path
+ expansión/contracción
+ ausencia de 11 galerías
```

## 9. Criterio de éxito

```text
DEFINITION_ACCEPTED
INSTANCE_SAFE
11 niveles representados
P-101 visible y resaltado
búsqueda funcional
selección devuelve nivel/path
contraer oculta descendientes
expandir permite recorrer de nuevo la rama
Studio permanece estable
```

No se harán micropruebas por nivel.

## 10. Recomendación

```text
A reutilizar sin cambios                  NO
B evolucionar a profundidad variable     SÍ
C reconstruir motor completo              NO por ahora
D descartar Power Apps                    NO según evidencia actual
```

El resultado de la prueba de 11 niveles determinará si B queda validada o si aparece algún límite de Canvas Apps que obligue a reconsiderar C/D.

## 11. Uso futuro

Si el candidato supera la prueba, el mismo motor podrá alimentar:

```text
cmp_FL_TreePro
├── dataset FLH
├── dataset Taxonomía
└── dataset ADR
```

Esto mantiene tres perspectivas distintas del mismo P-101 con un único activo UI reusable y prepara una posible reutilización en una futura CMMS 2.0 construida con Power Apps.
