# CMMS 2.0 Functional Lab — Freeze Register

**Fecha base:** 2026-08-11  
**Última actualización:** 2026-08-12  
**Playbook:** `30-playbooks/power-platform/modular-power-apps-screen-construction.md`

Este registro evita que bloques posteriores modifiquen incidentalmente piezas ya aprobadas.

## Estados permitidos

```text
IN_CONSTRUCTION
FUNCTIONAL
FUNCTIONAL_FROZEN
VISUAL_APPROVED
FINAL_FROZEN
```

Capas:

```text
STRUCTURE       OPEN | FROZEN
BEHAVIOR        OPEN | FROZEN
DATA CONTRACT   OPEN | FROZEN
COLOR           PENDING | APPROVED
```

> Una revisión de fuente modificada después de un PASS debe revalidarse en Studio. Ningún PASS histórico promueve automáticamente una revisión posterior.

---

# Componentes reutilizables

| Componente | Estado | Structure | Behavior / contract | Color | Próximo gate |
|---|---|---:|---:|---:|---|
| `cmp_FL_SidebarPro` | `FUNCTIONAL_FROZEN` | FROZEN | FROZEN | PENDING | no tocar salvo fallo real |
| `cmp_FL_PageHeaderPro` | `FUNCTIONAL_FROZEN` | FROZEN | FROZEN | PENDING | no tocar salvo fallo real |
| `cmp_FL_TreePro` | `FUNCTIONAL` | FROZEN RC3 | OPEN | PENDING | isolated Studio gate |
| `cmp_FL_ProcessRailPro` | `FUNCTIONAL` | FROZEN source | OPEN | PENDING | isolated Studio gate |
| `cmp_FL_DecisionPanelPro` | `FUNCTIONAL` | FROZEN source | OPEN | PENDING | isolated Studio gate |
| `cmp_FL_GatePanelPro` | `FUNCTIONAL` | FROZEN RC2 | OPEN | PENDING | isolated Studio gate |
| `cmp_FL_RiskMatrixPro` | `FUNCTIONAL` | FROZEN 900×650 / 5×5 | OPEN | PENDING | S4/O3/D3 isolated smoke |
| `cmp_FL_LineagePanelPro` | `FUNCTIONAL` | FROZEN H=126 RC3 | OPEN | PENDING | isolated Studio gate |
| `cmp_FL_ApplicabilityMatrixPro` | `FUNCTIONAL` | FROZEN RC2 | OPEN | PENDING | isolated Studio gate |

Component gate:

```text
SOURCE_VALID
→ COMPONENT_DEFINITION_ACCEPTED
→ INSTANCE_SAFE
→ PUBLIC_CONTRACT_VALIDATED
→ VISUAL_QA_VALIDATED
→ READY_FOR_INTEGRATION
```

---

# Foundation / Activos

| Pantalla | Estado | Structure | Behavior | Color | Restricción |
|---|---|---:|---:|---:|---|
| `scr_FL_Home` | `FUNCTIONAL_FROZEN` | FROZEN | FROZEN | PENDING | no reconstruir bootstrap/shell/cards/navigation |
| `scr_FL_FLH` | `FUNCTIONAL_FROZEN` condicionado a Tree RC3 | FROZEN | FROZEN intent | PENDING | solo integrar Tree validado |
| `scr_FL_Taxonomy` | `FUNCTIONAL_FROZEN` condicionado a Tree RC3 | FROZEN | FROZEN intent | PENDING | solo integrar Tree validado |
| `scr_FL_ADR` | `FUNCTIONAL_FROZEN` condicionado a Tree RC3 | FROZEN | FROZEN intent | PENDING | solo integrar Tree validado |
| `scr_FL_AssetCriticality` | `FUNCTIONAL` | FROZEN source | OPEN until smoke | PENDING | criticidad ≠ riesgo AMEF |
| `scr_FL_Asset360` | `FUNCTIONAL` | FROZEN source | OPEN until smoke | PENDING | master data read-only |

---

# Ingeniería reutilizable

| Pantalla | Estado | Structure | Behavior | Color | Restricción |
|---|---|---:|---:|---:|---|
| `scr_FL_FmeaLibrary` | `FUNCTIONAL_FROZEN` | FROZEN | FROZEN | PENDING | biblioteca reusable |
| `scr_FL_FmeaRevision` | `FUNCTIONAL_FROZEN` | FROZEN | FROZEN | PENDING | revisión ≠ AnalysisCase |
| `scr_FL_AssetApplication` | `FUNCTIONAL_FROZEN` condicionado a Applicability RC2 | FROZEN | FROZEN intent | PENDING | no duplicar ingeniería por activo |

---

# AnalysisCase / handoff

| Pantalla | Estado | Structure | Behavior | Color | Estrategia |
|---|---|---:|---:|---:|---|
| `scr_FL_AnalysisRegister` | `FUNCTIONAL` | OPEN | OPEN | PENDING | modular if changed |
| `scr_FL_CaseOverview` | `FUNCTIONAL` | OPEN | OPEN | PENDING | modular if changed |
| `scr_FL_Context` | `FUNCTIONAL` | OPEN | OPEN | PENDING | skeleton first if rebuilt |
| `scr_FL_Functions` | `FUNCTIONAL` | OPEN | OPEN | PENDING | skeleton first if rebuilt |
| `scr_FL_FailureModes` | `FUNCTIONAL` | OPEN | OPEN | PENDING | skeleton first if rebuilt |
| `scr_FL_AMEF` | `IN_CONSTRUCTION` | OPEN | OPEN | PENDING | **S-AMEF-01 skeleton first** |
| `scr_FL_RCM` | `FUNCTIONAL` candidate | OPEN | OPEN | PENDING | modular validation |
| `scr_FL_Economics` | `FUNCTIONAL` candidate | OPEN | OPEN | PENDING | modular validation |
| `scr_FL_Task` | `FUNCTIONAL` candidate | OPEN | OPEN | PENDING | modular validation |
| `scr_FL_PlanPackage` | `FUNCTIONAL` candidate | OPEN | OPEN | PENDING | modular validation |
| `scr_FL_Traceability` | `FUNCTIONAL` candidate | OPEN | OPEN | PENDING | modular validation |
| `scr_FL_ReviewApproval` | `FUNCTIONAL` candidate | OPEN | OPEN | PENDING | modular validation |
| `scr_FL_Effectiveness` | `FUNCTIONAL` candidate | OPEN | OPEN | PENDING | modular validation |
| `scr_FL_MaintenancePlans` | `FUNCTIONAL` candidate | OPEN | OPEN | PENDING | modular validation |
| `scr_FL_Governance` | `FUNCTIONAL` candidate | OPEN | OPEN | PENDING | modular validation |
| `scr_FL_Settings` | `FUNCTIONAL` candidate | OPEN | OPEN | PENDING | modular validation |

---

# Design System Lab

| Bloque / pantalla | Estado | Structure | Behavior | Color | Evidencia / siguiente paso |
|---|---|---:|---:|---:|---|
| `scr_DesignSystemLab` / `DS-S01` | `IN_CONSTRUCTION` | **FROZEN** | OPEN | PENDING | `DS-S01 STRUCTURE FROZEN` confirmado en Studio el 2026-08-12 |
| `DS-C01 Semantic Token Roles` | `VISUAL_APPROVED` | inherits FROZEN geometry | FROZEN content | PENDING | `DS-C01 PASS` confirmado visualmente en Studio el 2026-08-12; `ph_TokenRoles` congelado |
| `DS-C02 Classic + Modern controls` | `IN_CONSTRUCTION` | inherits FROZEN geometry | OPEN | PENDING | sustituir solo `ph_ClassicControls` + `ph_ModernControls`; Studio validation pendiente |
| `DS-C03 Interaction states` | `PLANNED` | FROZEN | OPEN | PENDING | no generar antes de DS-C02 PASS |
| `DS-C04 Data visualisation` | `PLANNED` | FROZEN | OPEN | PENDING | no generar antes de DS-C03 PASS |

## Geometry freeze de DS-S01

Desde `DS-S01 STRUCTURE FROZEN` quedan protegidos:

```text
conDSLabRoot
conDSLabHeader
conDSLabBody
ph_TokenRoles geometry
ph_Text geometry
ph_ClassicControls geometry
ph_ModernControls geometry
ph_InteractionStates geometry
ph_DataViz geometry
ph_Status geometry
```

Un bloque C puede sustituir contenido de su placeholder, pero no alterar X/Y/Width/Height del slot.

## Freeze de DS-C01

Desde `DS-C01 PASS` queda protegido:

```text
ph_TokenRoles content
16 semantic role candidates
```

Cualquier cambio posterior requiere `DS-C01-FIX` explícito.

---

# Evidencia Studio preservada

```text
HOME OK
ACTIVOS OK
BIBLIOTECA AMEF OK
APLICACIÓN MULTI-ACTIVO OK
HOME BASELINE PASS
FLH PASS
TAXONOMÍA PASS
ADR PASS
DS-S01 STRUCTURE FROZEN
DS-C01 PASS
```

## Regla de actualización

Después de cada bloque validado:

1. actualizar solo la pieza afectada;
2. registrar estado y capa congelada;
3. mantener `COLOR=PENDING` hasta completar DS-C01…DS-C04;
4. no promover otras piezas por asociación;
5. si falla, crear el `FIX` del mismo bloque antes de continuar.
