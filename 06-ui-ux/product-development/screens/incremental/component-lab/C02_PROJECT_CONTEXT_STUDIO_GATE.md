# CMMS 2.0 — C02 Project Context Studio Gate

**Fecha:** 2026-08-23  
**Estado:** `C02 CANDIDATE / PENDING POWER APPS STUDIO GATE`  
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

## Gate Studio

1. Importar/crear `cmp_CMMS_ProjectContextPro_RC0` desde Source Code.
2. Confirmar ausencia de errores de Source Code Schema y Power Fx.
3. Crear una pantalla temporal nueva desde Source Code.
4. Pegar `scr_CMMS_ComponentLab_C02_Candidate.pa.yaml`.
5. Confirmar las tres variantes:
   - `SELECTOR MODE` con proyectos sintéticos explícitos;
   - `CONTEXT_ONLY MODE` con proyecto aceptado;
   - `NO CONTEXT` mostrando exactamente `No project selected`.
6. En el selector, abrir el dropdown y comprobar que los tres proyectos sintéticos se muestran correctamente, incluido el nombre largo.
7. Cambiar selección una vez y confirmar que no aparece error de runtime aunque el evento esté deliberadamente desconectado del host.
8. Confirmar que ninguna variante inventa un proyecto cuando los inputs aceptados están vacíos.
9. Capturar una imagen completa del lab.

## Resultado esperado

`C02-PC = PASS / STUDIO VALIDATED`

Tras PASS queda autorizado `C03 — State Panel`.

No integrar todavía el componente en `scr_Home S01`; la sustitución de primitives locales se hará después de validar la primera foundation compartida.
