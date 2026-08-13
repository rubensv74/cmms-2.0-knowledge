# CMMS 2.0 Functional Lab — Estándar de tipografía y densidad

**Estado:** canónico antes de reimplementar componentes y pantallas  
**Fecha:** 2026-08-11  
**Objetivo:** asegurar legibilidad real en escritorio, tablet y demostraciones presenciales.

## 1. Problema detectado

La versión previa utilizaba numerosos tamaños `7`, `8`, `9` y `10` para metadatos, ayudas, estados, labels de cards y contenido secundario.

Aunque la densidad visual parecía compacta en diseño, en Power Apps Studio y en una pantalla de reunión estos tamaños resultan demasiado pequeños y perjudican:

- lectura rápida;
- comprensión por perfiles no técnicos;
- demostraciones proyectadas;
- accesibilidad;
- jerarquía visual;
- capacidad de revisar información sin acercarse físicamente a la pantalla.

La causa no debe corregirse pantalla por pantalla. Se redefine primero la escala canónica.

## 2. Regla principal

> En Functional Lab no se reduce tipografía para conseguir que más contenido quepa en una pantalla.

Si el contenido no cabe:

```text
reordenar
→ aumentar altura
→ usar scroll controlado
→ dividir en secciones
→ convertir dos columnas en flujo vertical
```

Nunca:

```text
reducir texto a 7–10 para evitar scroll
```

## 3. Escala canónica — perfil Comfortable

Este es el perfil por defecto del Functional Lab.

| Uso | Size recomendado | Mínimo |
|---|---:|---:|
| Micro badge / stage code | 11 | 11 |
| Eyebrow / meta | 11–12 | 11 |
| Supporting text / hint | 12 | 12 |
| Label de formulario | 12–13 | 12 |
| Body / descripción | 13–14 | 13 |
| Tabla / gallery row | 12–13 | 12 |
| Botón / acción | 12–13 | 12 |
| Section title | 16–18 | 16 |
| Card title | 15–17 | 15 |
| Page title | 24–28 | 24 |
| KPI / valor principal | 24–32 | 24 |

### Prohibición

No utilizar texto visible de usuario con `Size < 11`.

Los tamaños 7–10 quedan retirados del sistema visual v2 salvo elementos puramente decorativos que no transmitan información.

## 4. Jerarquía tipográfica

### Nivel 1 — Página

```text
Page title       24–28
Subtitle         13–14
Archetype/meta   11–12
```

### Nivel 2 — Sección

```text
Section title    16–18
Section hint     12–13
```

### Nivel 3 — Card / panel

```text
Card title       15–17
Label            12–13
Value            13–16 según importancia
Supporting       12
```

### Nivel 4 — Datos densos

```text
Column header    12 semibold
Row primary      12–13
Row secondary    12
Code / status    11–12
```

## 5. Componentes canónicos

### Sidebar

```text
App title        >= 13
Module item      >= 12
Case/context     >= 12
Role/footer      >= 11
```

### PageHeaderPro

```text
Page title       24–28
Subtitle         13–14
Case code/value  12–13
Journey/meta     11–12
```

### TreePro

```text
Node primary     12–13
Node secondary   12
Breadcrumb       12
Search input     12–13
Badge            11
```

### ProcessRailPro

```text
Stage label      >= 12
StageId          >= 11
Phase label      >= 11
Responsibility   >= 11
```

Si 28 etapas no caben, el rail debe hacer scroll. No reducir el texto.

### DecisionPanelPro / GatePanelPro

```text
Panel title      16–18
Body             13
Labels           12
Result/decision  13–16
Button           >= 12
```

### RiskMatrixPro

```text
Title            16–18
Axis title       11–12
Cell value       12–13
Legend           11–12
NPR / score      18–24 según espacio
```

### LineagePanelPro

```text
Title            15–17
Eyebrows         11
Values           12–13
Hint             12
```

### ApplicabilityMatrixPro

```text
Title            16–18
Headers          12
Rows             12–13
Supporting       12
```

## 6. Alturas y targets interactivos

La tipografía mayor debe ir acompañada de geometría suficiente.

```text
Botón primario          >= 44 px alto
Botón secundario        >= 40 px alto
Input estándar          >= 40 px alto
Fila compacta           >= 42 px
Fila comfortable        >= 48 px
Hit target interactivo  >= 40×40 px cuando sea posible
```

No aumentar Size sin revisar Height, padding y posiciones.

## 7. AutoHeight y wrapping

Para texto estático:

```text
ModernText → AutoHeight=true
```

Una línea:

```text
Wrap=false
```

Contenido explicativo:

```text
Wrap=true
```

Cuando el texto crezca, el contenedor debe crecer o permitir desplazamiento. El texto nunca debe quedar recortado como consecuencia de la nueva escala.

## 8. Densidad

Functional Lab usa **Comfortable** como baseline, no Compact.

La densidad debe favorecer:

- lectura a distancia normal de escritorio;
- lectura durante videollamada;
- lectura en proyector/pantalla de sala;
- diferenciación clara entre información y acción.

Compact solo podrá existir en el futuro como preferencia explícita, no como diseño de referencia.

## 9. Escala futura de usuario

Cuando exista soporte global:

```text
Normal       100%
Comfortable  115%  ← default
Large        130%
```

La escala debe afectar conjuntamente a:

- tipografía;
- alturas;
- padding;
- gaps;
- iconos;
- targets interactivos.

No implementar zoom independiente por componente.

## 10. Gate visual obligatorio

Antes de declarar una pantalla `VISUAL_QA_VALIDATED`:

```text
[ ] no existe texto visible < 11
[ ] body principal >= 13
[ ] labels >= 12
[ ] títulos de sección >= 16
[ ] botones >= 12 y altura suficiente
[ ] ningún texto relevante queda cortado
[ ] Process Rail y grids usan scroll antes que reducción tipográfica
[ ] contraste correcto
[ ] lectura posible a 100% de zoom del navegador
[ ] la pantalla sigue siendo comprensible en demostración
```

## 11. Regla de reconstrucción

Antes de volver a implementar componentes o pantallas del Functional Lab:

```text
1. corregir foundation visual
2. preservar identidad de componentes ya instanciados
3. aplicar escala Comfortable canónica
4. revisar geometría
5. validar una pantalla representativa de alta densidad
6. solo después propagar el patrón al resto
```

La pantalla representativa recomendada para este gate es `scr_FL_AMEF`, porque combina Header, Process Rail, lineage, formularios, Risk Matrix, Decision Panel y Gate Panel.
