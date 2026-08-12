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
| `cmp_FL_SidebarPro` | `FUNCTIONAL_FROZEN` | FROZEN | FROZEN | APPROVED foundation | no tocar salvo fallo real |
| `cmp_FL_PageHeaderPro` | `FUNCTIONAL_FROZEN` | FROZEN | FROZEN | APPROVED foundation | no tocar salvo fallo real |
| `cmp_FL_TreePro` | `VISUAL_APPROVED` | **FROZEN RC3** | **FROZEN / PUBLIC_CONTRACT_VALIDATED** | APPROVED foundation | **READY_FOR_INTEGRATION → smoke dirigido Activos** |
| `cmp_FL_ProcessRailPro` | `FUNCTIONAL` | FROZEN source | OPEN | APPROVED foundation / integration pending | isolated Studio gate |
| `cmp_FL_DecisionPanelPro` | `FUNCTIONAL` | FROZEN source | OPEN | APPROVED foundation / integration pending | isolated Studio gate |
| `cmp_FL_GatePanelPro` | `FUNCTIONAL` | FROZEN RC2 | OPEN | APPROVED foundation / integration pending | isolated Studio gate |
| `cmp_FL_RiskMatrixPro` | `FUNCTIONAL` | FROZEN 900×650 / 5×5 | OPEN | APPROVED foundation / integration pending | S4/O3/D3 isolated smoke |
| `cmp_FL_LineagePanelPro` | `FUNCTIONAL` | FROZEN H=126 RC3 | OPEN | APPROVED foundation / integration pending | isolated Studio gate |
| `cmp_FL_ApplicabilityMatrixPro` | `FUNCTIONAL` | FROZEN RC2 | OPEN | APPROVED foundation / integration pending | isolated Studio gate |

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
| `scr_FL_Home` | `FUNCTIONAL_FROZEN` | FROZEN | FROZEN | APPROVED foundation / theme integration pending | no reconstruir bootstrap/shell/cards/navigation |
| `scr_FL_FLH` | `FUNCTIONAL_FROZEN` | FROZEN | FROZEN intent | APPROVED foundation / theme integration pending | smoke dirigido con TreePro RC3; no reconstruir |
| `scr_FL_Taxonomy` | `FUNCTIONAL_FROZEN` | FROZEN | FROZEN intent | APPROVED foundation / theme integration pending | smoke dirigido con TreePro RC3; no reconstruir |
| `scr_FL_ADR` | `FUNCTIONAL_FROZEN` | FROZEN | FROZEN intent | APPROVED foundation / theme integration pending | smoke dirigido con TreePro RC3; no reconstruir |
| `scr_FL_AssetCriticality` | `FUNCTIONAL` | FROZEN source | OPEN until smoke | APPROVED foundation / theme integration pending | criticidad ≠ riesgo AMEF |
| `scr_FL_Asset360` | `FUNCTIONAL` | FROZEN source | OPEN until smoke | APPROVED foundation / theme integration pending | master data read-only |

---

# Ingeniería reutilizable

| Pantalla | Estado | Structure | Behavior | Color | Restricción |
|---|---|---:|---:|---:|---|
| `scr_FL_FmeaLibrary` | `FUNCTIONAL_FROZEN` | FROZEN | FROZEN | APPROVED foundation / theme integration pending | biblioteca reusable |
| `scr_FL_FmeaRevision` | `FUNCTIONAL_FROZEN` | FROZEN | FROZEN | APPROVED foundation / theme integration pending | revisión ≠ AnalysisCase |
| `scr_FL_AssetApplication` | `FUNCTIONAL_FROZEN` condicionado a Applicability RC2 | FROZEN | FROZEN intent | APPROVED foundation / theme integration pending | no duplicar ingeniería por activo |

---

# AnalysisCase / handoff

| Pantalla | Estado | Structure | Behavior | Color | Estrategia |
|---|---|---:|---:|---:|---|
| `scr_FL_AnalysisRegister` | `FUNCTIONAL` | OPEN | OPEN | APPROVED foundation / integration pending | modular if changed |
| `scr_FL_CaseOverview` | `FUNCTIONAL` | OPEN | OPEN | APPROVED foundation / integration pending | modular if changed |
| `scr_FL_Context` | `FUNCTIONAL` | OPEN | OPEN | APPROVED foundation / integration pending | skeleton first if rebuilt |
| `scr_FL_Functions` | `FUNCTIONAL` | OPEN | OPEN | APPROVED foundation / integration pending | skeleton first if rebuilt |
| `scr_FL_FailureModes` | `FUNCTIONAL` | OPEN | OPEN | APPROVED foundation / integration pending | skeleton first if rebuilt |
| `scr_FL_AMEF` | `IN_CONSTRUCTION` | OPEN | OPEN | APPROVED foundation / integration pending | **S-AMEF-01 skeleton first** |
| `scr_FL_RCM` | `FUNCTIONAL` candidate | OPEN | OPEN | APPROVED foundation / integration pending | modular validation |
| `scr_FL_Economics` | `FUNCTIONAL` candidate | OPEN | OPEN | APPROVED foundation / integration pending | modular validation |
| `scr_FL_Task` | `FUNCTIONAL` candidate | OPEN | OPEN | APPROVED foundation / integration pending | modular validation |
| `scr_FL_PlanPackage` | `FUNCTIONAL` candidate | OPEN | OPEN | APPROVED foundation / integration pending | modular validation |
| `scr_FL_Traceability` | `FUNCTIONAL` candidate | OPEN | OPEN | APPROVED foundation / integration pending | modular validation |
| `scr_FL_ReviewApproval` | `FUNCTIONAL` candidate | OPEN | OPEN | APPROVED foundation / integration pending | modular validation |
| `scr_FL_Effectiveness` | `FUNCTIONAL` candidate | OPEN | OPEN | APPROVED foundation / integration pending | modular validation |
| `scr_FL_MaintenancePlans` | `FUNCTIONAL` candidate | OPEN | OPEN | APPROVED foundation / integration pending | modular validation |
| `scr_FL_Governance` | `FUNCTIONAL` candidate | OPEN | OPEN | APPROVED foundation / integration pending | modular validation |
| `scr_FL_Settings` | `FUNCTIONAL` candidate | OPEN | OPEN | APPROVED foundation / integration pending | modular validation |

---

# Design System Lab

| Bloque / pantalla | Estado | Structure | Behavior | Color | Evidencia |
|---|---|---:|---:|---:|---|
| `scr_DesignSystemLab` / `DS-S01` | `VISUAL_APPROVED` | **FROZEN** | FROZEN lab purpose | **APPROVED** | `DS-S01 STRUCTURE FROZEN` + DS-C01…04 cerrados en Studio |
| `DS-C01 Semantic Token Roles` | `VISUAL_APPROVED` | inherits FROZEN geometry | FROZEN content | **APPROVED** | PASS + responsive FIX validado |
| `DS-C02 Classic + Modern controls` | `VISUAL_APPROVED` | inherits FROZEN geometry | FROZEN content | **APPROVED** | Classic/Button, Classic/TextInput, ModernText y ModernTextInput correctos |
| `DS-C03 Interaction states` | `VISUAL_APPROVED` | inherits FROZEN geometry | FROZEN content | **APPROVED** | Default/Selected/Disabled/Hover-Pressed/Focus correctos |
| `DS-C04 Data visualisation` | `VISUAL_APPROVED` | inherits FROZEN geometry | FROZEN content | **APPROVED** | `DS-C04-FIX PASS`; Chart01…06 correctos |

## COLOR FOUNDATION APPROVED

Desde 2026-08-12 queda aprobado el lenguaje semántico:

```text
Background
Surface
SurfaceAlt
Border
TextPrimary
TextSecondary
Primary
PrimaryHover
PrimarySelected
SelectedBackground
SelectedBorder
SelectedAccent
SelectedText
Success
Warning
Danger
Chart01…Chart06
```

Los roles/tokens no se rediseñan desde componentes individuales. Cualquier cambio futuro requiere un bloque Theme/DesignSystem explícito y nueva validación en `scr_DesignSystemLab`.

---

# Component Lab

| Bloque / pantalla | Estado | Structure | Behavior | Color | Evidencia / siguiente paso |
|---|---|---:|---:|---:|---|
| `scr_ComponentLab` / `CL-S01` | `FUNCTIONAL_FROZEN` | **FROZEN** | FROZEN lab purpose | APPROVED foundation | `CL-S01 STRUCTURE FROZEN`; harness preservado para futuros componentes |
| `CL-C01 TreePro` | `VISUAL_APPROVED` | inherits FROZEN geometry | **FROZEN** | APPROVED foundation | **`CL-C01 TREEPRO PASS` — RC3 READY_FOR_INTEGRATION** |

## Cierre CL-C01

```text
cmp_FL_TreePro RC3
SOURCE_VALID                    PASS
COMPONENT_DEFINITION_ACCEPTED   PASS
INSTANCE_SAFE                   PASS
PUBLIC_CONTRACT_VALIDATED       PASS
VISUAL_QA_VALIDATED             PASS
READY_FOR_INTEGRATION           PASS
```

El cierre de CL-C01 no promueve automáticamente las pantallas host. FLH, Taxonomía y ADR requieren únicamente smoke dirigido; su geometría no se reabre.

## Geometry freeze de CL-S01

Quedan protegidos:

```text
conComponentLabRoot
conComponentLabHeader
conComponentLabBody
ph_ComponentUnderTest geometry
ph_TestControls geometry
```

Los bloques `CL-Cxx` pueden sustituir el **contenido** de los dos placeholders para probar un único componente, pero no modificar X/Y/Width/Height de los slots.

## Regla de aislamiento

```text
un componente bajo prueba por vez
→ limpiar/reemplazar el harness anterior
→ no acumular componentes
→ no editar pantallas funcionales durante el gate aislado
```

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
DS-C01 PASS + FIX validado
DS-C02 PASS
DS-C03 PASS
DS-C04-FIX PASS
COLOR FOUNDATION APPROVED
CL-S01 STRUCTURE FROZEN
CL-C01 TREEPRO PASS
TREEPRO RC3 READY_FOR_INTEGRATION
```

## Regla de actualización

Después de cada bloque validado:

1. actualizar solo la pieza afectada;
2. registrar estado y capa congelada;
3. no reabrir roles/tokens desde un componente;
4. no promover otras piezas por asociación;
5. si falla una pieza previa, abrir un `FIX` explícito sin modificar el bloque que reveló el defecto.
