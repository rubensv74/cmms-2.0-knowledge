# F03 — Actualización in situ en Power Apps Studio

**Objetivo:** instalar la referencia visual AMEF sin crear componentes duplicados ni romper las instancias existentes.

## Regla principal

No usar `Agregar componente` para estas revisiones.

El patrón correcto es:

```text
componente existente en Studio
→ abrir su Source Code
→ reemplazar la definición por la versión canónica
→ guardar
→ conservar la misma identidad
```

Si Studio crea una segunda definición con sufijo (`1`, `_1`, etc.), detenerse: esa copia no sustituye automáticamente las instancias existentes.

## Alcance F03

Actualizar **in situ** y en este orden:

1. `cmp_FL_SidebarPro`
2. `cmp_FL_PageHeaderPro`
3. `cmp_FL_ProcessRailPro`
4. `cmp_FL_LineagePanelPro`
5. `cmp_FL_RiskMatrixPro`
6. `cmp_FL_DecisionPanelPro`
7. `cmp_FL_GatePanelPro`
8. `scr_FL_AMEF`

No modificar en este bloque:

```text
cmp_FL_TreePro
cmp_FL_ApplicabilityMatrixPro
resto de pantallas
```

## Fuentes canónicas

Carpeta de componentes:

`06-ui-ux/functional-lab/power-apps/components/`

Pantalla:

`06-ui-ux/functional-lab/power-apps/screens/scr_FL_AMEF.pa.yaml`

## Qué cambia

### Paleta

Los componentes afectados por FL-SC-004 utilizan una paleta segura por defecto y no dependen de que Studio materialice correctamente los defaults Color del host.

### Tipografía

La referencia aplica:

```text
mínimo visible       11
supporting           12
body                 13
section/card title   15–16+
page title           24
button               12+
```

### Geometría

`scr_FL_AMEF` se reorganiza para 1366×768:

```text
Header                 100
ProcessRail             scroll vertical
Lineage                 108
Effects + RiskMatrix    304
Decision + Gate         216
```

El contexto redundante deja de ocupar tres bloques verticales separados.

## Validación única después de actualizar todo

No validar componente por componente.

Después de actualizar las ocho definiciones:

```text
1. guardar la app
2. abrir App Checker
3. iniciar desde scr_FL_Home
4. abrir P101-AMEF-RCM-001 por el flujo normal
5. navegar hasta AMEF
```

Comprobar en una sola revisión:

```text
[ ] no aparecen componentes duplicados
[ ] las instancias existentes siguen asociadas
[ ] Sidebar legible
[ ] PageHeader legible
[ ] ProcessRail legible y con scroll
[ ] lineage legible
[ ] efectos legibles y editables
[ ] D editable en 1–5
[ ] matriz 5×5 visible
[ ] S=4 / O=3 / D=3 → NPR=36 en fixture inicial
[ ] sistema y decisión humana diferenciados
[ ] gate legible
[ ] no hay bloques negros
[ ] ningún texto relevante parece microscópico
[ ] pantalla completa utilizable a 1366×768 y zoom 100%
```

## Resultado esperado

Si el smoke es satisfactorio:

```text
F03 AMEF reference       VISUAL_QA_VALIDATED
```

Solo entonces se propagará el patrón de legibilidad al resto de componentes y pantallas.
