# CL-C07 — ApplicabilityMatrixPro — Studio validation

## Objetivo

Validar `cmp_FL_ApplicabilityMatrixPro` RC2 en aislamiento antes de integrarlo en pantallas funcionales.

El componente debe demostrar dos cosas simultáneamente:

1. que una misma revisión AMEF puede aplicarse a varios activos con perfiles e intervalos distintos;
2. que la selección de una aplicación expone correctamente el activo y la aplicación seleccionados al host.

## Preparación

1. Mantener la identidad existente `cmp_FL_ApplicabilityMatrixPro`.
2. Si es necesario, actualizar su definición in situ desde `power-apps/components/cmp_FL_ApplicabilityMatrixPro.pa.yaml`.
3. En `scr_ComponentLab`, sustituir solo `ph_ComponentUnderTest` y `ph_TestControls` por los bloques de `CL-C07_ApplicabilityMatrixPro_isolated_validation.pa.yaml`.

## Smoke

### 1 — Normal 920

Pulsa `Normal · 920 px`.

Comprobar:

- cabecera completa: Activo, Criticidad, Aplicabilidad, Perfil, Intervalo;
- cuatro filas visibles y diferenciables;
- nombres y códigos nominales legibles;
- sin superficies negras;
- sin clipping ni colisiones;
- tipografía sin reducción.

### 2 — Selección / contrato público

Selecciona una fila distinta de la inicial.

Comprobar en el panel derecho:

- `SelectedAssetCodeOut` cambia al activo pulsado;
- `SelectedApplicationCodeOut` cambia a la aplicación correspondiente;
- el resumen de `SelectedRecordOut` coincide con la misma fila;
- el contador de `OnSelectApplication` aumenta exactamente una vez por selección.

### 3 — Stress 760

Pulsa `Stress · 760 px`.

El harness carga nombres de activo, estados, perfiles e intervalos largos.

Comprobar:

- todas las cabeceras siguen siendo distinguibles;
- ninguna columna invade otra;
- no desaparece información crítica por `Wrap=false`;
- el intervalo no queda comprimido hasta ser ilegible;
- la selección sigue funcionando;
- outputs y evento siguen siendo coherentes;
- no aparecen superficies negras;
- no se reduce tipografía.

### 4 — Save / reopen

Solo si Normal 920, selección y Stress 760 pasan:

1. guardar la app;
2. cerrar Studio;
3. reabrir;
4. repetir Normal 920 y Stress 760;
5. confirmar una selección.

## PASS

```text
CL-C07 APPLICABILITYMATRIX PASS
```

Implica:

```text
INSTANCE_SAFE
PUBLIC_CONTRACT_VALIDATED
VISUAL_QA_VALIDATED
READY_FOR_INTEGRATION
```

## FAIL

Si Normal 920 y el contrato público funcionan pero Stress 760 presenta clipping, solape o pérdida de columnas:

```text
CL-C07 FAIL_VISUAL_QA
```

Abrir `CL-C07-FIX-01` limitado a estrategia responsive/layout. No reducir tipografía, no eliminar campos del contrato y no modificar semántica funcional para resolver densidad.
