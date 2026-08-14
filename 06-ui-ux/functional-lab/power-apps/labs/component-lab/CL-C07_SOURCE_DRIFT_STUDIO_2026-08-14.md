# CL-C07 — ApplicabilityMatrixPro — Studio source drift

**Fecha:** 2026-08-14  
**Componente:** `cmp_FL_ApplicabilityMatrixPro`  
**Estado:** `SOURCE_DRIFT_DETECTED / REVALIDATION_REQUIRED`

## Evidencia

La definición actualmente cargada en Power Apps Studio no coincide con la fuente canónica RC2 del repositorio usada para preparar CL-C07.

### Studio actual

```text
Height                  330
Title Size              12
Hint Size                9
Column headers Size      7
Row text Size             9
Gallery TemplateSize    54
Gallery Y                96
```

### RC2 canónico

```text
Height                  350
Title Size              16
Hint Size               12
Column headers Size     11
Row text Size            12
Gallery TemplateSize    60
Gallery Y               110
```

La identidad y el contrato público son compatibles, pero la instancia Studio corresponde a una revisión anterior / compacta y no puede utilizarse como evidencia de validación del RC2 canónico.

## Lectura de las capturas

La ejecución observada demuestra que:

- el harness CL-C07 está funcionando;
- Normal 920 es legible con la revisión compacta actualmente instalada;
- Stress 760 degrada fuertemente la tabla: columnas estrechas, textos partidos y densidad insuficiente;
- esta evidencia no se declara todavía como `CL-C07 FAIL_VISUAL_QA`, porque no se ejecutó contra la fuente RC2 canónica.

## Acción requerida

1. Actualizar **in situ** la definición existente `cmp_FL_ApplicabilityMatrixPro` desde `power-apps/components/cmp_FL_ApplicabilityMatrixPro.pa.yaml`.
2. No crear una segunda identidad de componente.
3. Mantener el harness CL-C07 actual.
4. Repetir `Normal 920`, selección/outputs/evento y `Stress 760`.
5. Solo esa ejecución decidirá PASS o apertura de `CL-C07-FIX-01`.

## Regla

No reducir tipografía para resolver Stress 760. La fuente canónica RC2 ya representa el baseline Comfortable aprobado para esta validación.
