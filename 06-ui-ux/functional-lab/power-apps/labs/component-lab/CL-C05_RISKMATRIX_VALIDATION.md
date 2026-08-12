# CL-C05 — RiskMatrixPro — Validación en Studio

## Objetivo

Validar `cmp_FL_RiskMatrixPro` RC4 de forma aislada antes de integrarlo en la pantalla AMEF.

No se evalúa criticidad de activo. El componente representa exclusivamente la valoración AMEF del modo de fallo.

## Secuencia única

1. Pulsa **Cargar S4 · O3 · D3**.
2. Comprueba que la celda activa corresponde a **S=4 / O=3** y que se muestran:
   - `S×O = 12`
   - `D = 3`
   - `NPR = 36`
3. Selecciona manualmente la celda **S=5 / O=5**.
4. Comprueba:
   - outputs `S / O = 5 / 5`;
   - `S×O = 25`;
   - `NPR = 75`;
   - último evento `CELL`.
5. Pulsa **Cambiar solo D a 4**.
6. Comprueba:
   - la celda sigue en **S=5 / O=5**;
   - `S×O` sigue siendo `25`;
   - `D = 4`;
   - `NPR = 100`.
7. Pulsa otra vez **Cargar S4 · O3 · D3** y confirma que la selección vuelve visualmente a **S=4 / O=3**.

## QA visual

La prueba pasa si además:

- la matriz 5×5 se ve completa;
- los ejes Severidad/Ocurrencia son legibles;
- la celda seleccionada tiene un estado inequívoco;
- D y NPR se leen como métricas separadas de la matriz;
- no hay clipping;
- no aparecen superficies negras;
- no hay texto visible por debajo del estándar Comfortable.

## Resultado esperado

```text
CL-C05 RISKMATRIX PASS
```

Tras ese PASS:

```text
cmp_FL_RiskMatrixPro RC4 → READY_FOR_INTEGRATION
```

La integración posterior en `scr_FL_AMEF` conservará la regla:

```text
matriz = S×O
D = dimensión separada
NPR = S×O×D
```
