# F03 — AMEF Readability Reference

**Estado:** referencia canónica previa a reimplementar componentes/pantallas  
**Fecha:** 2026-08-11  
**Pantalla patrón:** `scr_FL_AMEF`  
**Objetivo de referencia:** 1366×768, perfil `Comfortable`, zoom navegador 100%.

## 1. Regla de diseño

La pantalla AMEF se utiliza como prueba de estrés del sistema visual.

No se permitirá resolver problemas de espacio reduciendo tipografía por debajo del estándar:

```text
micro/meta          >= 11
supporting          >= 12
label               >= 12
body                >= 13
card title          >= 15
section title       >= 16
page title          >= 24
button              >= 12
```

Si el contenido no cabe, se reorganiza o se desplaza. No se miniaturiza.

## 2. Restricción de identidad

Los componentes ya instalados en Studio mantienen su identidad.

No se crearán copias como:

```text
cmp_FL_PageHeaderPro_1
cmp_FL_ProcessRailPro_1
...
```

La reimplementación debe realizarse **sobre la definición existente en Studio**.

El Source Code de este bloque será candidato de sustitución in situ, no una nueva identidad de componente.

## 3. Geometría objetivo — 1366×768

```text
┌─────────────────────────────────────────────────────────────────────────────┐
│ Sidebar 220 │ PageHeader ~112                                               │
├─────────────┼───────────────────────────────────────────────────────────────┤
│             │                                                               │
│ ProcessRail │ Context strip ~96                                             │
│ 280–300     ├───────────────────────────┬───────────────────────────────────┤
│ scroll      │ Effects ~276              │ Risk Matrix ~276                  │
│             ├───────────────────────────┴───────────────────────────────────┤
│             │ Decision Panel ~190       │ Gate / avance ~190                │
│             │                                                               │
└─────────────┴───────────────────────────────────────────────────────────────┘
```

La intención no es usar valores absolutos rígidos en todo el producto, sino demostrar que una pantalla densa puede ser legible en el viewport de referencia.

## 4. Simplificación del bloque superior

La versión anterior apilaba:

```text
Lineage
Modo / causa
Criticidad
```

en tres bloques verticales.

Para la referencia se consolidan visualmente en un **context strip** único:

```text
BIBLIOTECA / REVISIÓN
AMEF-BOMBA-CENTRIFUGA · R01

APLICACIÓN
APP-P101-R01

ACTIVO
P-101 · Criticidad Alta

MODO / CAUSA
FM-03 · causa seleccionada
```

Esto reduce altura sin reducir legibilidad y mantiene la distinción conceptual Biblioteca → Aplicación → Activo → modo contextual.

`cmp_FL_LineagePanelPro` seguirá siendo reutilizable, pero su variante de referencia deberá ser más horizontal y compacta en geometría, no en tamaño de letra.

## 5. PageHeaderPro

Objetivo:

```text
Height              ~112
Page title           24–26
Subtitle             13
Archetype            11
Case / revision      12–13
Journey / state      11–12
```

Se elimina cualquier texto secundario que repita información ya visible en el contexto inmediato.

## 6. ProcessRailPro

Las 28 etapas no deben intentar verse simultáneamente.

```text
Width                280–300
Stage row            >= 48
Stage label          12
Stage ID             11
Phase/meta           11
```

El componente debe usar scrollbar y mantener visible la etapa activa.

`CompactMode` no puede significar texto de 8–9; solo menor padding/altura dentro de los límites del estándar.

## 7. RiskMatrixPro

Configuración P-101:

```text
5×5 S×O
S=4
O=3
D=3
S×O=12
NPR=36
```

Jerarquía objetivo:

```text
Title                16
Subtitle/body        12–13
Axis                 11–12
Cell value           12–13
NPR                   20–24
Legend               11–12
```

La matriz no se denomina `Matriz de criticidad`.

## 8. DecisionPanelPro

Debe poder trabajar en una altura aproximada de 190–210 sin miniaturización.

Se prioriza:

```text
Título                16
Resultado sistema     13–14
Recomendación         13
Decisión humana       13–14
Rol / motivo          12
Acciones              12–13 · Height >= 40
```

El texto explicativo largo pasa a una única línea/ayuda cuando sea posible. No se duplican explicación y contexto si transmiten lo mismo.

## 9. GatePanelPro

El control de avance mantiene:

```text
estado
resumen
motivo
acción requerida
responsable
continuar
```

pero la jerarquía visible favorece primero:

```text
¿puedo continuar?
¿por qué?
¿qué falta?
```

Tamaño:

```text
Title                16
Summary/body         13
Supporting           12
Button               12–13 · Height >= 40
```

## 10. Effects / inputs

Los efectos contextuales permanecen editables, con:

```text
Label                12
Input text           13
Input height          >= 44
```

Si los tres efectos no caben de forma cómoda en 276 px, el panel puede utilizar mayor altura y desplazar contenido inferior. No se reduce el texto.

## 11. Paleta

La referencia combina la corrección FL-SC-004 con el estándar de responsabilidad:

```text
master/reference       neutral/slate
system                  blue/cyan
human decision          purple
warning/override        amber/orange
blocked/error           red
confirmed               green
```

La paleta estándar no dependerá de que Studio materialice correctamente un `Default` Color de CustomProperty.

## 12. Qué se valida con F03

```text
[ ] ningún texto visible < 11
[ ] body principal >= 13
[ ] inputs y botones legibles
[ ] PageHeader no domina verticalmente la pantalla
[ ] ProcessRail hace scroll antes de reducir texto
[ ] Lineage/contexto es comprensible sin ocupar tres bloques verticales
[ ] matriz 5×5 legible
[ ] decisión sistema/humano diferenciada
[ ] gate comprensible
[ ] paleta correcta
[ ] P-101 / R01 / APP-P101-R01 visibles
[ ] pantalla utilizable a 1366×768 / 100% zoom
```

## 13. Propagación

Solo cuando `scr_FL_AMEF` obtenga `VISUAL_QA_VALIDATED`:

```text
AMEF reference
→ foundation components
→ restantes AnalysisCase screens
→ Ingeniería reutilizable
→ Activos
→ Handoff / Gobernanza
```

No volver a implementar las 25 pantallas simultáneamente antes de este gate.
