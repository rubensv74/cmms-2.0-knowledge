# CMMS 2.0 Functional Lab — Referencia visual canónica de la matriz de riesgo AMEF

**Fecha:** 2026-08-11  
**Estado:** referencia visual obligatoria para `cmp_FL_RiskMatrixPro`  
**Caso de demostración:** P-101  

## 1. Decisión

La matriz de riesgo AMEF del Functional Lab debe conservar el lenguaje visual premium aprobado durante la revisión del 11 de agosto de 2026.

No debe degradarse a una tabla de celdas estrechas únicamente para reducir altura o aumentar densidad.

## 2. Composición objetivo

```text
┌──────────────────────────────────────────────────────────────┐
│ icono  Matriz de riesgo AMEF                      [ P-101 ]  │
│        Valoración contextual del modo de fallo              │
│                                                              │
│                        OCURRENCIA                             │
│                    1   2   3   4   5                        │
│                                                              │
│ SEVERIDAD  5      [ 5][10][15][20][25]                     │
│            4      [ 4][ 8][12][16][20]                     │
│            3      [ 3][ 6][ 9][12][15]                     │
│            2      [ 2][ 4][ 6][ 8][10]                     │
│            1      [ 1][ 2][ 3][ 4][ 5]                     │
│                                                              │
│ ───────────────────────────────────────────────────────────  │
│ Detección 3          S × O 12          NPR (S × O × D) 36   │
│                                                              │
│ i  Nota sobre configuración / procedencia de la escala      │
└──────────────────────────────────────────────────────────────┘
```

## 3. Reglas visuales obligatorias

- 5×5 es la representación principal del caso P-101.
- Severidad se muestra de **5 arriba a 1 abajo**.
- Ocurrencia se muestra de **1 izquierda a 5 derecha**.
- Las 25 celdas son tiles regulares, grandes, con radio contenido y separación visible.
- No utilizar celdas extremadamente anchas y bajas ni apariencia de hoja de cálculo.
- La celda activa utiliza borde azul de alta visibilidad sin ocultar el color de riesgo.
- Paleta suave: verde → amarillo → naranja → rojo.
- El título de página/componente tiene jerarquía clara y subtítulo legible.
- Detección no forma parte de los ejes de la matriz; se presenta como métrica separada.
- `S × O` se presenta como score de la celda actual.
- `NPR = S × O × D` se presenta como KPI principal de la franja inferior.
- La nota de escala es secundaria y no compite con el contenido principal.
- El contexto del activo puede mostrarse como badge superior derecho.

## 4. Tipografía

Aplicar `TYPOGRAPHY_AND_DENSITY_STANDARD.md`:

```text
Título                    22–24
Subtítulo                 13–14
Ejes                      14
Cabeceras de escala       14
Valor de celda            16–18
Labels métricas           12–13
Valores métricas          24–30
Nota inferior             >= 11
```

No reducir tipografía para forzar el componente dentro de un host demasiado pequeño.

## 5. Geometría

El componente debe diseñarse primero en su proporción premium independiente.

La pantalla host deberá adaptarse posteriormente al componente.

Patrón prohibido:

```text
host tiene 304 px disponibles
→ comprimir matriz completa a 304 px
→ celdas y textos pierden presencia
```

Patrón correcto:

```text
componente premium validado
→ definir espacio mínimo real
→ adaptar `scr_FL_AMEF`
→ usar scroll/reordenación si la pantalla no dispone de altura suficiente
```

## 6. Contrato funcional

La representación visual no cambia la separación conceptual:

```text
S × O       = posición / score de matriz
D           = valoración separada
NPR         = S × O × D
Criticidad  = contexto del activo, no dimensión de esta matriz
```

El componente mantiene soporte para:

- `PRODUCT`;
- `CONFIGURED`;
- escalas suministradas por host;
- colores/umbrales configurables;
- outputs de Severidad/Ocurrencia/score/banda;
- evento de selección de celda.

## 7. Criterio de aceptación visual

`VISUAL_QA_VALIDATED` solo puede declararse si, en Power Apps Studio:

```text
[ ] la composición se reconoce inmediatamente como la referencia premium
[ ] las celdas tienen tamaño y separación equilibrados
[ ] la matriz no parece una tabla compactada
[ ] 4×3 queda resaltado correctamente para P-101
[ ] D = 3 es visible y separado
[ ] S×O = 12 es visible
[ ] NPR = 36 es visualmente dominante
[ ] no existe texto visible < 11
[ ] no hay clipping o scroll interno accidental
[ ] la paleta no renderiza negro
```

## 8. Regla de no regresión

> Si una futura optimización de densidad hace que la matriz pierda el carácter visual de esta referencia, la optimización debe rechazarse y resolverse en el layout de la pantalla host, no degradando `cmp_FL_RiskMatrixPro`.
