# CMMS 2.0 — Component Lab / C01 Studio Gate

**Fecha:** 2026-08-23
**Estado:** `C01 CANDIDATE / PENDING POWER APPS STUDIO GATE`
**Método:** `CREATE_SHARED_COMPONENT`

## Objetivo

Validar dentro de la app CMMS el primer Canvas Component compartido: `cmp_CMMS_PageHeaderPro_RC0`.

El gate no valida todavía Sidebar, Project Context ni State Panel. Primero debemos demostrar que el dialecto `ComponentDefinitions` y el ciclo de importación funcionan en la app CMMS.

## Carencia reusable demostrada

El Page Header aparece en todas las superficies del Product Map y debe mantener la misma jerarquía visual, semántica de status, tipografía y spacing.

- `REUSE`: no existe todavía un Page Header CMMS compartido.
- `EXTEND_SHARED`: no existe componente CMMS previo que pueda extenderse.
- `CREATE_SHARED`: procede.
- `LOCAL_ONLY`: descartado porque el patrón será consumido por decenas de pantallas.

## Contrato público RC0

Inputs:

- `EyebrowText`
- `Title`
- `Subtitle`
- `ShowStatus`
- `StatusText`
- `StatusTone`
- `SurfaceColor`
- `PrimaryTextColor`
- `SecondaryTextColor`
- `AccentColor`

`StatusTone` admite conceptualmente `NEUTRAL / INFO / SUCCESS / WARNING / DANGER`.

El componente no contiene lógica de negocio, navegación, consultas, persistencia ni permisos.

## Candidate component

`06-ui-ux/product-development/components/experimental/cmp_CMMS_PageHeaderPro_RC0.pa.yaml`

## Candidate lab screen

`06-ui-ux/product-development/screens/incremental/component-lab/scr_CMMS_ComponentLab_C01_Candidate.pa.yaml`

## Gate Studio

1. En Power Apps Studio, crear/importar el Canvas Component `cmp_CMMS_PageHeaderPro_RC0` desde Source Code usando el YAML candidato.
2. Confirmar ausencia de errores de Source Code Schema y Power Fx.
3. Crear una nueva pantalla temporal desde Source Code.
4. Pegar `scr_CMMS_ComponentLab_C01_Candidate.pa.yaml`.
5. Confirmar que se renderizan tres variantes:
   - Home sin status;
   - Maintenance Configuration con `DRAFT / WARNING`;
   - Plan Publication con `PUBLISHED / SUCCESS`.
6. Confirmar que títulos y subtítulos no se recortan a ancho desktop normal.
7. Confirmar que los status pills no se superponen con títulos largos.
8. Capturar una imagen completa del lab.

## Resultado esperado

Si pasa:

`C01-PH = PASS / STUDIO VALIDATED`

Entonces queda autorizado extraer en este orden:

1. `cmp_CMMS_ProjectContextPro_RC0`
2. `cmp_CMMS_StatePanelPro_RC0`
3. `cmp_CMMS_SidebarPro_RC0`

No sustituir todavía los primitives locales de `scr_Home S01`; la adopción se hará en un incremento posterior después de validar cada componente.
