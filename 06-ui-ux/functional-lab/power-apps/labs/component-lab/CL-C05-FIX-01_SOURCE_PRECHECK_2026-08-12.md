# CL-C05-FIX-01 — RiskMatrixPro RC5 — SOURCE PRECHECK

**Fecha:** 2026-08-12  
**Estado:** `SOURCE PRECHECK PASS / STUDIO PENDING`

## Contrato

- BLOCK: `CL-C05-FIX-01`
- TYPE: `FIX`
- TARGET: identidad existente `cmp_FL_RiskMatrixPro`
- ACTION: actualizar definición in situ
- DEPENDS ON: `CL-C05 FAIL_VISUAL_QA`, Color Foundation approved
- TOUCHES: composición visual interna de RiskMatrixPro
- DO NOT MODIFY: contrato público, semántica S/O/D, fórmula NPR, otros componentes, pantallas funcionales

## Comprobaciones estáticas

- Se mantiene la identidad canónica `cmp_FL_RiskMatrixPro`.
- Se preservan todas las CustomProperties públicas de RC4.
- `Gallery@2.15.0` de matriz conserva template plano con un único `Classic/Button@2.2.0`.
- No se añaden GroupContainer con Children dentro del template de Gallery.
- `ModernText@1.0.0` estático usa `AutoHeight=true`.
- No se usa SVG inline.
- No se usa `AccessibleLabel` en Classic/Button.
- Fórmulas complejas se expresan mediante bloque `|-` cuando corresponde.
- No se introducen literals Power Fx inline con patrones conocidos `: ` o ` #` que requieran protección adicional.
- `UseHostTheme=false` conserva el fallback cromático seguro para la validación inicial.
- Selección usa azul de interacción y permanece separada del color de banda de riesgo.

## Validación Studio requerida

```text
1. Baseline S4/O3/D3 → S×O 12 / NPR 36.
2. Seleccionar S5/O5 → S×O 25 / NPR 75.
3. Cambiar solo D a 4 → NPR 100 y la selección permanece S5/O5.
4. Verificar panel lateral S/O/D, banda y NPR.
5. Verificar ausencia de clipping y superficies negras.
6. Evaluar composición premium y aprovechamiento real de 900×650.
```

Solo un PASS real en Studio permite sincronizar el candidato con `power-apps/components/cmp_FL_RiskMatrixPro.pa.yaml`.
