# CL-C05-FIX-01 — RiskMatrixPro RC5 — Studio validation

## Objetivo

Validar que RC5 mantiene el contrato funcional de RC4 y corrige el fallo visual detectado.

## Prueba única

1. Mantener el harness `CL-C05` existente.
2. Actualizar `cmp_FL_RiskMatrixPro` in situ con el candidato RC5.
3. Cargar `S4 · O3 · D3`.
4. Confirmar selección visual en S4/O3, banda correspondiente, `S×O = 12` y `NPR = 36`.
5. Seleccionar S5/O5 y confirmar `S×O = 25`, `NPR = 75` y evento de celda.
6. Cambiar solo D a 4 y confirmar `NPR = 100` sin mover la selección S5/O5.

## Gate visual

Debe cumplirse todo:

```text
[ ] La matriz es el workspace principal y no una pieza flotante aislada.
[ ] El panel derecho presenta S, O y D en una única lectura.
[ ] La banda S×O es visible como resultado cualitativo.
[ ] NPR es claramente secundario a la matriz pero suficientemente destacado.
[ ] La regla “D modifica NPR, no la celda” es visible sin ayuda externa.
[ ] La selección azul es inequívoca y distinta del color de riesgo.
[ ] La leyenda de bandas forma parte del componente.
[ ] No existe espacio muerto dominante dentro de la superficie 900×650.
[ ] Sin clipping, scrollbars accidentales ni superficies negras.
[ ] Ningún texto visible se ha comprimido por debajo del estándar Comfortable.
```

## Resultado

Si supera la prueba:

```text
CL-C05 RISKMATRIX RC5 PASS
```

Entonces se sincroniza el candidato con la fuente canónica `power-apps/components/cmp_FL_RiskMatrixPro.pa.yaml` y se promueve a `READY_FOR_INTEGRATION`.
