# CMMS 2.0 Functional Lab — Design System v2

**Estado:** canónico para arquitectura v2  
**Fecha:** 2026-08-11  
**Construcción:** regida por `30-playbooks/power-platform/modular-power-apps-screen-construction.md`

## 1. Objetivo

Hacer que el Functional Lab se perciba como una aplicación CMMS empresarial real y premium, no como un navegador de prototipos ni como una presentación paso a paso.

La interfaz debe comunicar:

1. dónde está el usuario dentro del producto;
2. qué objeto o caso está trabajando;
3. dónde está dentro de las 28 etapas metodológicas;
4. qué dato viene del maestro;
5. qué calcula o recomienda el sistema;
6. qué necesita una decisión humana;
7. qué control de avance permite o bloquea la progresión formal.

## 2. Dos capas de navegación

### Navegación global — Sidebar

```text
Inicio
Activos
Estrategia de mantenimiento
Planes de mantenimiento
Gobernanza
Configuración
```

No enumera las 28 etapas.

### Navegación del AnalysisCase — Process Rail

`cmp_FL_ProcessRailPro` representa FL-01…FL-28 dentro de un caso.

Muestra progreso, etapa actual, responsabilidad dominante, estado y navegación de consulta. El host conserva autoridad sobre workflow y progresión formal.

## 3. Pantallas por trabajo real

Una pantalla existe cuando un usuario CMMS reconocería un trabajo u objeto distinto. No se crea automáticamente una pantalla por `stageId` ni se fusionan trabajos distintos únicamente para reducir número de pantallas.

## 4. Tokens y roles visuales

El design system no se gobierna mediante paletas independientes dentro de cada componente.

Los colores se expresan conceptualmente mediante roles compartidos:

```text
Background
Surface
SurfaceAlt
Border
TextPrimary
TextSecondary

Primary
PrimaryHover
PrimarySelected

SelectedBackground
SelectedBorder
SelectedAccent
SelectedText

Success
Warning
Danger

Chart01
Chart02
Chart03
Chart04
Chart05
Chart06
```

Los valores concretos utilizados hoy en componentes pueden actuar como fallback de compatibilidad, pero no son una segunda fuente de verdad semántica.

La gobernanza transversal se apoya en:

`functional-engineering-knowledge-base/15-standards/ux-ui/enterprise-design-system-token-governance.md`

## 5. Gramática semántica de responsabilidad

### Master / referencia

Uso: datos maestros, referencias externas, metadatos y solo lectura.

### Sistema / cálculo / recomendación

Uso: cálculo, clasificación automática, recomendación, explicación y navegación activa.

### Persona / autoridad

Uso: decisión humana, rol con autoridad, confirmación y revisión multidisciplinar.

### Warning / excepción / override

Uso: finding, override, excepción o incertidumbre no bloqueante.

### Error / bloqueo

Uso: error, condición incompatible o avance formal bloqueado.

### Confirmado / aprobado

Uso: evidencia confirmada, control superado, aprobación y resultado estable.

El color no puede ser el único canal de significado cuando el estado es importante.

## 6. Theme separado de estructura y comportamiento

Una pieza puede alcanzar:

```text
STRUCTURE       FROZEN
BEHAVIOR        FROZEN
DATA CONTRACT   FROZEN
COLOR           PENDING
```

En ese estado queda `FUNCTIONAL_FROZEN` y no debe reabrirse por un problema exclusivamente cromático.

La aprobación final sigue:

```text
COLOR FOUNDATION APPROVED
→ VISUAL_APPROVED
→ FINAL_FROZEN
```

## 7. Design System Lab

Toda duda sobre render, contraste, selección o materialización de color se valida primero en:

```text
scr_DesignSystemLab
```

Es una utility screen técnica, fuera de la navegación funcional y fuera de las 25 pantallas de producto.

Debe cubrir como mínimo:

```text
Background / Surface / SurfaceAlt
TextPrimary / TextSecondary
Classic controls
Modern controls
Buttons
Borders
Selected / Hover / Pressed / Disabled / Focus
Success / Warning / Danger
Data visualisation palette
contraste sobre superficies reales
```

Construcción obligatoria:

```text
DS-S01 skeleton + placeholders
→ Studio validation
→ geometry freeze
→ DS-C01 token roles
→ DS-C02 controls
→ DS-C03 interaction states
→ DS-C04 data visualisation
→ COLOR FOUNDATION APPROVED
```

No se propaga una paleta directamente desde un editor externo o por considerar correctos los HEX.

## 8. Tipografía — Comfortable

Escala canónica:

```text
Micro badge / stage code   11
Eyebrow / meta             11–12
Supporting text            12
Form label                 12–13
Body                       13–14
Table / gallery row        12–13
Button                     12–13
Card title                 15–17
Section title              16–18
Page title                 24–28
KPI / principal value      24–32
```

Reglas:

- no texto visible `<11`;
- body principal `>=13`;
- labels ordinarios `>=12`;
- no reducir tipografía para hacer caber contenido;
- usar más altura, scroll o reordenación.

Detalle: `TYPOGRAPHY_AND_DENSITY_STANDARD.md`.

## 9. Densidad

Perfil por defecto: **Comfortable**.

```text
Botón primario          >=44 px
Botón secundario        >=40 px
Input estándar          >=40 px
Fila compacta           >=42 px
Fila Comfortable        >=48 px
Hit target              >=40×40 cuando sea posible
```

El Process Rail usa scroll antes de reducir tipografía.

## 10. Layout responsive

Objetivo:

```text
Desktop
Tablet landscape
Tablet portrait cuando el contenido lo permita
```

Móvil completo queda fuera de v2.

Principios:

- Sidebar colapsable;
- contenido principal basado en `Parent.Width` y contratos claros;
- dos columnas evolucionables a flujo vertical;
- no depender de hover para información crítica;
- legibilidad antes que densidad extrema.

## 11. Page Header

`cmp_FL_PageHeaderPro` identifica pantalla/arquetipo, objeto/caso, journey cuando aplica, review state y progreso.

En Activos no debe fingir una etapa de AnalysisCase.

```text
Page title  24–28
Subtitle    13–14
```

## 12. TreePro

Foundation para FLH, Taxonomía y ADR.

Principios:

- modelo plano padre-hijo;
- profundidad variable;
- breadcrumb;
- búsqueda;
- expand/collapse;
- P-101 resaltado sin perder selección;
- compresión de indentación;
- detalle preferentemente en panel derecho.

```text
nodo principal       12–13
nodo secundario      12
breadcrumb           12
badge                11
```

## 13. Process Rail

Debe mostrar:

```text
estado
grupo/fase
stageId
etapa
responsabilidad dominante
```

Códigos compactos actuales:

```text
H human
R recommendation
C calculation
G gate
```

Texto visible mínimo:

```text
stage label      12
stageId          11
phase label      11
responsibility   11
```

## 14. Decision Panel

Debe hacer imposible confundir recomendación y decisión.

```text
SISTEMA
- resultado
- recomendación
- explicación

DECISIÓN HUMANA
- valor
- motivo
- autoridad
- override
```

Nunca ocultar la recomendación original después de un override.

## 15. Control de avance

`cmp_FL_GatePanelPro` expresa estado, resumen, motivo, acción necesaria, responsable, output y acción de continuar.

En UI visible se prefieren:

```text
Estado de la etapa
Control de avance
Requisitos para continuar
Validación de la etapa
```

“Gate” queda como término técnico interno.

## 16. Master data

En AnalysisCase:

```text
DATO MAESTRO · SOLO LECTURA
```

No editar silenciosamente código/nombre maestro, FLH, taxonomía o ADR desde el análisis.

## 17. Honestidad del prototipo

No fingir capacidades productivas inexistentes:

- PM/JobPlan/WO reales;
- persistencia de auditoría remota;
- seguridad definitiva;
- Azure SQL ya integrado.

Premium no equivale a simular backend inexistente.

## 18. Superficies de referencia

La estrategia anterior usaba `scr_FL_AMEF` como pantalla de referencia visual general. Esto queda refinado para separar responsabilidades:

### `scr_DesignSystemLab`

Referencia exclusiva para:

- tokens;
- color;
- contraste;
- estados de controles;
- render Classic/Modern;
- selección;
- data palette.

### `scr_FL_Home`

Referencia para:

- shell;
- Sidebar;
- Header;
- spacing general;
- jerarquía básica;
- cards y densidad estándar.

Su geometría ya cuenta con evidencia positiva y debe preservarse.

### `scr_FL_AMEF`

**Stress test funcional de alta densidad**, no laboratorio de color.

Se utiliza después de que tokens y componentes hayan sido validados aisladamente para comprobar:

- Header + Sidebar + Process Rail;
- lineage/contexto;
- RiskMatrix 5×5;
- Decision Panel;
- control de avance;
- densidad y scroll reales.

AMEF se reconstruye `skeleton first` porque su geometría actual no está congelada.

## 19. Gate de calidad visual

Una pantalla no es `VISUAL_QA_VALIDATED` si:

- existe texto visible <11;
- body principal <13;
- hay clipping o mini-scrollbars accidentales;
- se redujo tipografía para evitar scroll;
- estados interactivos no son visibles;
- la selección cambia de lenguaje entre componentes;
- se aplicó una paleta no validada en Studio;
- color es el único canal para un estado esencial.

Consultar:

`functional-engineering-knowledge-base/15-standards/ux-ui/power-apps-visual-quality-standard.md`

## 20. Criterio premium

Premium significa:

- jerarquía clara;
- densidad controlada;
- legibilidad real;
- consistencia;
- acciones previsibles;
- responsabilidad visible;
- estados explicables;
- componentes reutilizables;
- responsive;
- accesibilidad;
- ausencia de ruido visual;
- acabado comparable a SaaS empresarial moderno.

No significa añadir sombras, color o controles por decoración.
