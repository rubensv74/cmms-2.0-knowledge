# CMMS 2.0 — C02 Project Context Studio Gate

**Fecha:** 2026-08-23  
**Estado:** `C02-PC = PASS / STUDIO VALIDATED`  
**Método:** `CREATE_SHARED_COMPONENT`

## Objetivo

Validar `cmp_CMMS_ProjectContextPro_RC0` como primitive compartido para contexto y selección de proyecto.

## Procedencia

El patrón se inspira en `cmp_ProjectContextPro_RC1` de AssetPlan, pero el contrato se adapta a CMMS 2.0 y no reutiliza datos, IDs ni reglas de AssetPlan.

## Carencia reusable demostrada

El contexto de proyecto aparece en Home, Project Setup, Assets, Maintenance Engineering, Plans y Governance.

- `REUSE`: no existe todavía un Project Context CMMS compartido.
- `EXTEND_SHARED`: no existe componente CMMS previo con este contrato.
- `CREATE_SHARED`: procede.
- `LOCAL_ONLY`: descartado porque el patrón es transversal.

## Contrato RC0

Inputs principales:

- `Projects`
- `SelectedProjectCode`
- `SelectedProjectName`
- `SelectedProjectId`
- `Mode` (`SELECTOR` / `CONTEXT_ONLY`)
- `Label`
- `EmptyText`
- `IsLoading`
- `IsEnabled`

Outputs:

- `PendingProjectCode`
- `PendingProjectName`
- `PendingProjectId`

Evento:

- `OnProjectChange`

El componente no cambia el proyecto aceptado por sí mismo. El host conserva la autoridad para aceptar el cambio, cargar datos y decidir navegación.

## Candidate component

`06-ui-ux/product-development/components/experimental/cmp_CMMS_ProjectContextPro_RC0.pa.yaml`

## Candidate lab

`06-ui-ux/product-development/screens/incremental/component-lab/scr_CMMS_ComponentLab_C02_Candidate.pa.yaml`

## Studio validation result

Validado en Power Apps Studio el 2026-08-23:

1. Source Code import sin errores de schema ni Power Fx visibles;
2. `SELECTOR MODE` renderiza proyectos sintéticos controlados;
3. `CONTEXT_ONLY MODE` presenta el contexto aceptado como solo lectura;
4. `NO CONTEXT` muestra explícitamente `No project selected`;
5. no se infiere ni fabrica un proyecto cuando no existe contexto aceptado;
6. las tres variantes conviven sin overlap/clipping a ancho desktop.

## Resultado

`C02-PC = PASS / STUDIO VALIDATED`

Queda autorizado `C03 — State Panel`.

No integrar todavía el componente en `scr_Home S01`; la sustitución de primitives locales se hará después de validar la primera foundation compartida.
