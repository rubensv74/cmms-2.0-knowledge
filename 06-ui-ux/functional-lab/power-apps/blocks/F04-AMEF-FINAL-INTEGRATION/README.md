# F04 — AMEF Final Integration Gate — SUPERSEDED

**Estado:** `SUPERSEDED` desde 2026-08-11.  
**No ejecutar como procedimiento de integración.**

## Motivo

F04 proponía actualizar simultáneamente `cmp_FL_RiskMatrixPro` y `scr_FL_AMEF` y cerrar un smoke integrado. La revisión posterior demostró que la pantalla AMEF todavía no tenía una geometría estable y que mezclar estructura, componente, integración y color en el mismo incremento dificultaba aislar regresiones.

Además, la estrategia vigente exige:

```text
skeleton first
→ placeholders
→ block S/C/I
→ Studio validation
→ freeze
→ next block
```

Por tanto, F04 se conserva únicamente como **evidencia histórica del objetivo funcional de AMEF**, no como bloque ejecutable.

## Qué se conserva de F04

Continúan siendo requisitos válidos:

```text
RiskMatrix 900×650
AMEF 5×5
S=4
O=3
D=3
S×O=12
NPR=36
criticidad separada del riesgo AMEF
sistema separado de decisión humana
Process Rail visible y legible
```

## Qué queda retirado

No ejecutar:

```text
actualizar RiskMatrix + scr_FL_AMEF en un solo incremento
pegar pantalla AMEF monolítica
propagar patrón AMEF a otras pantallas después de un único smoke
usar AMEF como laboratorio de color
```

## Sustitución vigente

Seguir:

```text
../../../../development/TOMORROW_RUNBOOK_2026-08-12.md
../../../../development/FREEZE_REGISTER_2026-08-11.md
../../../../development/RECOVERY_HARDENING_AUDIT_2026-08-11.md
../S-AMEF-01/CONTRACT.md
```

Secuencia AMEF planificada:

```text
S-AMEF-01  skeleton completo
→ validate / GEOMETRY FROZEN
C-AMEF-01  Sidebar
C-AMEF-02  Header
C-AMEF-03  Process Rail
C-AMEF-04  FL-07 contextual effects
C-AMEF-05  FL-09 RiskMatrix
C-AMEF-06  Decision
C-AMEF-07  status/control de avance
I-AMEF-01  stage switching
I-AMEF-02  S/O/D → S×O/NPR
```

Cada bloque se valida antes del siguiente. Cualquier reparación utiliza su bloque `FIX` correspondiente.
