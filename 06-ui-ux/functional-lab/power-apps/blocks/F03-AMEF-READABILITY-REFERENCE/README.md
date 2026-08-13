# F03 — AMEF Readability Reference — HISTORICAL DESIGN EVIDENCE

**Estado:** `REFERENCE_ONLY` desde 2026-08-11.  
**No utilizar como secuencia de construcción ni como autoridad de color.**

## Qué permanece válido

F03 consolidó decisiones útiles que siguen vigentes:

```text
visible text        >=11
body                >=13
page title          24–28
button              12–13 / altura suficiente
Process Rail        scroll antes de reducir texto
RiskMatrix          AMEF 5×5
P-101               S4 / O3 / D3 / S×O12 / NPR36
criticidad          separada del riesgo AMEF
system decision     separada de autoridad humana
```

También conserva valor como evidencia de que una pantalla AMEF densa debe diseñarse pensando en un viewport desktop real y sin miniaturización.

## Qué ha cambiado

La estrategia vigente ya no utiliza AMEF como laboratorio para cerrar simultáneamente foundation, color y layout.

Responsabilidades actuales:

```text
scr_DesignSystemLab
→ tokens / color / contraste / control states / data palette

scr_FL_Home
→ referencia de shell, header, spacing y densidad estándar ya aprobada

scr_FL_AMEF
→ stress test funcional de alta densidad después de validar los componentes aisladamente
```

## Geometría AMEF

La composición de F03 que intentaba alojar simultáneamente Effects + Risk Matrix + Decision + Gate queda retirada.

El nuevo contrato estructural se define en:

`../S-AMEF-01/CONTRACT.md`

Puntos protegidos:

```text
Sidebar collapsed target     76
PageHeader target            112
Process Rail target          ~300 desktop
Primary workspace            suficiente para 900×650 RiskMatrix
Stage context                slot opcional/colapsable
Status/action                slot independiente
```

La geometría exacta se valida mediante placeholders antes de integrar componentes.

## Color

La paleta descrita históricamente en F03 expresa semántica útil —neutral/master, system, human, warning, danger, success— pero **los valores definitivos ya no se validan dentro de AMEF**.

La autoridad pasa a roles/tokens compartidos y `scr_DesignSystemLab`.

Un componente puede quedar:

```text
STRUCTURE       FROZEN
BEHAVIOR        FROZEN
DATA CONTRACT   FROZEN
COLOR           PENDING
```

## Construcción vigente

No propagar F03 a otras pantallas.

Seguir:

```text
30-playbooks/power-platform/modular-power-apps-screen-construction.md
../../../../development/TOMORROW_RUNBOOK_2026-08-12.md
../../../../development/FREEZE_REGISTER_2026-08-11.md
../S-AMEF-01/CONTRACT.md
```

## Valor documental

F03 se conserva porque registra el aprendizaje de legibilidad y densidad que motivó el baseline `Comfortable`. No es un bloque ejecutable ni una plantilla visual que deba copiarse completa.
