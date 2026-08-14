# CL-C07 — ApplicabilityMatrixPro — Source precheck

**Fecha:** 2026-08-14  
**Componente:** `cmp_FL_ApplicabilityMatrixPro` RC2  
**Estado:** `SOURCE PRECHECK PASS / STUDIO PENDING`

## Alcance

Se revisó la fuente canónica `power-apps/components/cmp_FL_ApplicabilityMatrixPro.pa.yaml` antes de crear una instancia aislada en `scr_ComponentLab`.

## Resultado

- Se preserva la identidad `cmp_FL_ApplicabilityMatrixPro`.
- El contrato público contiene `Items`, `OnSelectApplication`, `SelectedAssetCodeOut`, `SelectedApplicationCodeOut` y `SelectedRecordOut`.
- `GroupContainer@1.5.0`, `Gallery@2.15.0`, `ModernText@1.0.0` y `Classic/Button@2.2.0` pertenecen al conjunto de controles ya aceptado por el Functional Lab.
- El botón de fila no usa `AccessibleLabel`.
- No se observan propiedades `Radius*` aplicadas a controles incompatibles.
- La tipografía visible cumple el baseline Comfortable (>=11).
- `UseHostTheme=false` mantiene la ruta visual base en la paleta segura.

## Riesgos deliberadamente abiertos

### `APPLICABILITY-R01` — geometría horizontal fija

La tabla distribuye las columnas mediante valores `X` y `Width` fijos. El source nominal mide 920 px. No se modifica preventivamente.

CL-C07 debe demostrar si esta composición sigue siendo legible cuando el host baja a 760 px.

### `APPLICABILITY-R02` — activo sin wrap

`lblFLApplicabilityAsset` usa `Wrap=false` y `Width=320`. El smoke de estrés utilizará nombres de activo largos para comprobar si se pierde información crítica.

### `APPLICABILITY-R03` — columna intervalo residual

`lblFLApplicabilityInterval.Width = Parent.TemplateWidth-690`. En host estrecho esta columna puede quedar demasiado comprimida. Debe validarse en Studio antes de decidir estrategia responsive.

## Gate funcional

Además del render, CL-C07 debe comprobar:

1. selección de una fila;
2. actualización de `SelectedAssetCodeOut`;
3. actualización de `SelectedApplicationCodeOut`;
4. coherencia de `SelectedRecordOut`;
5. disparo de `OnSelectApplication`.

## Decisión de precheck

No corregir RC2 antes de Studio.

```text
SOURCE_VALID
→ COMPONENT_DEFINITION_ACCEPTED
→ INSTANCE_SAFE
→ PUBLIC_CONTRACT_VALIDATED
→ VISUAL_QA_VALIDATED
→ READY_FOR_INTEGRATION
```

Si solo Stress 760 falla por clipping/solape, abrir `CL-C07-FIX-01` limitado a layout responsive. No reducir tipografía ni eliminar columnas/datos para hacer caber la tabla.
