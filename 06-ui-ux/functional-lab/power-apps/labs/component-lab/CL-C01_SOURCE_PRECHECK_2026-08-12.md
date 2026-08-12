# CL-C01 — TreePro RC3 source pre-flight

**Fecha:** 2026-08-12  
**Estado:** `SOURCE PRECHECK PASS / STUDIO PENDING`  
**Componente:** `cmp_FL_TreePro` RC3  
**Harness:** `CL-C01_TreePro_isolated_validation.pa.yaml`

## Alcance

Revisión estática previa al siguiente pegado en Power Apps Studio. Esta revisión **no** sustituye los gates `COMPONENT_DEFINITION_ACCEPTED`, `INSTANCE_SAFE`, `PUBLIC_CONTRACT_VALIDATED` ni `VISUAL_QA_VALIDATED`.

## Comprobaciones realizadas

- `CL-S01` permanece `STRUCTURE FROZEN`.
- `CL-C01` toca únicamente `ph_ComponentUnderTest` y `ph_TestControls`.
- No se modifica FLH, Taxonomía, ADR ni otra pantalla funcional.
- `cmp_FL_TreePro` conserva identidad y contrato público RC3; no se crea una segunda copia.
- `ModernTextInput@1.1.1` permanece como búsqueda interna; su render básico ya fue probado en DesignSystemLab DS-C02.
- Gallery mantiene controles planos dentro del template; no se introduce `GroupContainer` anidado en Gallery.
- Fórmulas complejas (`OnToggleNode`, `OnSelect`, `Items`, records Power Fx) usan bloques YAML `|-` cuando corresponde.
- Se revisó la clase de errores PaYaml sensible ya observada:
  - literal Power Fx con `: ` en scalar inline;
  - literal Power Fx con ` #` en scalar inline.
- El único defecto encontrado en CL-C01 fue `lblCLTreeGate.Text` con `Gate: ...`; quedó corregido mediante `|-` en `CL-C01-FIX-01` y en el archivo canónico CL-C01.
- No se identifican otros scalars inline de la misma clase en el harness corregido.
- TreePro RC3 no presenta en la revisión actual otro scalar Power Fx inline equivalente que requiera reapertura preventiva.
- Tipografía visible del componente sigue baseline Comfortable (`>=11`).
- Colores internos actuales se consideran fallback compatible con la foundation aprobada; este gate no rediseña Theme.

## Riesgos que solo puede resolver Studio

El pre-flight no permite inferir:

```text
COMPONENT_DEFINITION_ACCEPTED
INSTANCE_SAFE
PUBLIC_CONTRACT_VALIDATED
VISUAL_QA_VALIDATED
READY_FOR_INTEGRATION
```

La siguiente evidencia válida debe venir de Power Apps Studio.

## Única validación manual pendiente

```text
1. pegar CL-C01 corregido
2. Cargar fixture
3. buscar P-102
4. seleccionar P-102 y P-101
5. collapse/expand de Conjunto bomba-motor
6. comprobar outputs
7. guardar/reabrir
8. confirmar ausencia de superficies negras, clipping y errores bloqueantes
```

Resultado esperado:

```text
CL-C01 TREEPRO PASS
```

Si falla, abrir únicamente `CL-C01-FIX-xx` sobre el delta demostrado.
