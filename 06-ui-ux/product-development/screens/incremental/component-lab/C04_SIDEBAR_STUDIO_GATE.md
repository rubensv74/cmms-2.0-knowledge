# CMMS 2.0 — C04 Sidebar Studio Gate

**Fecha:** 2026-08-23  
**Estado:** `C04 CANDIDATE / PENDING POWER APPS STUDIO GATE`  
**Método:** `CREATE_SHARED_COMPONENT`

## Objetivo

Validar `cmp_CMMS_SidebarPro_RC0` como primitive transversal de navegación del producto.

## Procedencia

El patrón toma como referencia la experiencia validada de `cmp_AssetPlanSidebarPro_RC2`, pero el contrato, dimensiones, marca, colores, claves y responsabilidad se adaptan a CMMS 2.0. No reutiliza navegación, proyectos ni reglas de AssetPlan.

## Carencia reusable demostrada

El sidebar será común a Home, Project Setup, Assets, Libraries, Maintenance Engineering, Plans, Governance y Administration.

- `REUSE`: no existía un Sidebar CMMS compartido.
- `EXTEND_SHARED`: no existía un primitive CMMS previo con este contrato.
- `CREATE_SHARED`: procede.
- `LOCAL_ONLY`: descartado porque el patrón define el shell transversal del producto.

## Contrato RC0

Inputs principales:

- `ActiveKey`
- `AppTitle`
- `AppVersion`
- `EnvironmentLabel`
- `IsCollapsed`
- `NavItems`
- `ProjectCode`
- `ProjectName`
- `ShowProjectContext`
- tokens de superficie, acento y texto

`NavItems` usa una tabla normalizada con:

- `Order`
- `Key`
- `Label`
- `ShortLabel`
- `IsVisible`
- `IsEnabled`
- `Tooltip`

Output:

- `SelectedKey`

Eventos:

- `OnSelectItem`
- `OnToggleCollapse`

## Límite de responsabilidad

El componente:

- no conoce nombres de pantallas;
- no ejecuta `Navigate()`;
- no carga datos;
- no cambia proyecto;
- no decide permisos;
- no decide disponibilidad funcional;
- no ejecuta escrituras.

El host conserva toda autoridad. El sidebar solo representa navegación, expone la selección y solicita eventos.

## Candidate component

`06-ui-ux/product-development/components/experimental/cmp_CMMS_SidebarPro_RC0.pa.yaml`

## Candidate lab

`06-ui-ux/product-development/screens/incremental/component-lab/scr_CMMS_ComponentLab_C04_Candidate.pa.yaml`

## Gate Studio

1. Importar/crear `cmp_CMMS_SidebarPro_RC0` desde Source Code.
2. Confirmar ausencia de errores de Source Code Schema y Power Fx.
3. Crear una nueva pantalla temporal desde Source Code.
4. Pegar `scr_CMMS_ComponentLab_C04_Candidate.pa.yaml`.
5. Confirmar que aparecen dos especímenes completos:
   - sidebar expandido de 248 px;
   - sidebar colapsado de 72 px.
6. Confirmar que `Project Setup` aparece activo en el expandido y `Home` activo en el colapsado.
7. Confirmar que las capacidades futuras deshabilitadas son visibles pero no parecen activas.
8. Confirmar que el footer expandido muestra `P-001 · SYNTHETIC DEMO PROJECT A` como contexto controlado.
9. Confirmar que el footer colapsado, sin proyecto, no inventa contexto y muestra un estado neutro.
10. Confirmar ausencia de overlap/clipping vertical y horizontal a ancho desktop normal.
11. Comprobar visualmente hover/pressed sobre un item habilitado sin que el lab navegue.
12. Capturar una imagen completa del lab.

## Resultado esperado

`C04-SB = PASS / STUDIO VALIDATED`

Tras PASS queda autorizada la consolidación de la primera **CMMS Shared UI Foundation RC0**:

- `cmp_CMMS_PageHeaderPro_RC0`
- `cmp_CMMS_ProjectContextPro_RC0`
- `cmp_CMMS_StatePanelPro_RC0`
- `cmp_CMMS_SidebarPro_RC0`

Después se podrá crear un incremento nuevo de `scr_Home` que sustituya primitives locales por componentes compartidos. No modificar `scr_Home S01` antes de este PASS.
