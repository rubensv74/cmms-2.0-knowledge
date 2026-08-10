# Power Apps Screens — Architecture v2

## Canonical v2

| Module | Screen | Purpose |
|---|---|---|
| Home | `scr_FL_Home` | Inicio, KPIs, trabajo actual, acceso a activos/casos |
| Assets | `scr_FL_FLH` | Jerarquía FLH |
| Assets | `scr_FL_Taxonomy` | Clasificación / taxonomía |
| Assets | `scr_FL_ADR` | Relaciones ADR |
| Assets | `scr_FL_Asset360` | Ficha consolidada del objeto técnico |
| Strategy | `scr_FL_AnalysisRegister` | Registro de AnalysisCase |
| Strategy | `scr_FL_CaseOverview` | Object page del caso + Process Rail de 28 etapas |
| Strategy | `scr_FL_Context` | FL-01..03 |
| Strategy | `scr_FL_Functions` | FL-04..05 |
| Strategy | `scr_FL_FailureModes` | FL-06 |
| Strategy | `scr_FL_AMEF` | FL-07..11 |
| Strategy | `scr_FL_RCM` | FL-12..16 |
| Strategy | `scr_FL_Economics` | FL-17 |
| Strategy | `scr_FL_Task` | FL-18..19 |
| Strategy | `scr_FL_PlanPackage` | FL-20..22 |
| Strategy | `scr_FL_Traceability` | FL-23..24 |
| Strategy | `scr_FL_ReviewApproval` | FL-25..26 |
| Strategy | `scr_FL_Effectiveness` | FL-27..28 |
| Plans | `scr_FL_MaintenancePlans` | Preview honesto de planes derivados |
| Governance | `scr_FL_Governance` | Vista transversal de versión/findings/change |
| Settings | `scr_FL_Settings` | Rol simulado, idioma futuro, arquitectura del lab |

## Legacy

`scr_FL_WorkspaceShell.pa.yaml` pertenece a la arquitectura v1 basada en workspaces agrupados.

Se conserva temporalmente como evidencia histórica porque contiene resultados ya validados de WS-01 y WS-02, pero **no debe utilizarse como pantalla canónica de la arquitectura v2**.

No añadir nuevas funcionalidades a `scr_FL_WorkspaceShell`.

## Instalación

Seguir `../V2_INSTALLATION.md`.
