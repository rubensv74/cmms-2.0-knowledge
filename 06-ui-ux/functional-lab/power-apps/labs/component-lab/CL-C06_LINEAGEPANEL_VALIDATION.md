# CL-C06 — LineagePanelPro — Studio validation

## Objetivo

Validar `cmp_FL_LineagePanelPro` RC3 en aislamiento antes de integrarlo en pantallas funcionales.

El componente debe comunicar con claridad la cadena:

`Biblioteca / revisión → Aplicación → Activo / contexto → Handoff`

La criticidad mostrada pertenece al contexto del activo y no sustituye el riesgo AMEF.

## Preparación

1. Mantener la identidad existente `cmp_FL_LineagePanelPro`.
2. Si es necesario, actualizar su definición in situ desde `power-apps/components/cmp_FL_LineagePanelPro.pa.yaml`.
3. En `scr_ComponentLab`, sustituir solo `ph_ComponentUnderTest` y `ph_TestControls` con `CL-C06_LineagePanelPro_isolated_validation.pa.yaml`.

## Smoke único

### 1 — Normal 900

Pulsa `Normal · 900 px`.

Debe verse sin clipping:

- Biblioteca y revisión.
- Aplicación.
- Activo y criticidad contextual.
- Handoff.
- Hint inferior completo.

### 2 — Stress 700

Pulsa `Stress · 700 px`.

El harness introduce códigos y estados largos. Comprobar:

- las cuatro etapas siguen siendo distinguibles;
- ninguna etapa invade visualmente a la siguiente;
- las flechas conservan su función de separación;
- no desaparece información crítica por `Wrap=false`;
- el hint inferior sigue completo o, como mínimo, no se recorta silenciosamente;
- no aparecen superficies negras;
- no se reduce la tipografía.

### 3 — Save / reopen

Guardar y reabrir la app. Volver a `Normal 900` y confirmar que el componente conserva el render.

## PASS

`CL-C06 LINEAGEPANEL PASS`

Implica:

- `INSTANCE_SAFE`;
- `VISUAL_QA_VALIDATED`;
- `READY_FOR_INTEGRATION`.

## FAIL

Si Normal 900 funciona pero Stress 700 presenta clipping u overlap:

`CL-C06 FAIL_VISUAL_QA`

Abrir `CL-C06-FIX-01` limitado a estrategia de overflow/layout interno. No reducir tipografía y no modificar el contrato público salvo necesidad demostrada.
