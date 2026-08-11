# CMMS 2.0 Functional Lab — Freeze Register

**Fecha base:** 2026-08-11  
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

Capas adicionales:

```text
STRUCTURE       OPEN | FROZEN
BEHAVIOR        OPEN | FROZEN
DATA CONTRACT   OPEN | FROZEN
COLOR           PENDING | APPROVED
```

> Un estado histórico positivo no autoriza a promover automáticamente una revisión de fuente modificada después. Si cambió la definición, la revisión actual vuelve al gate que corresponda.

---

# Componentes reutilizables

| Componente | Estado actual | Structure | Behavior/contract | Color | Evidencia / restricción |
|---|---|---:|---:|---:|---|
| `cmp_FL_SidebarPro` | `FUNCTIONAL_FROZEN` con smoke actual recomendado | FROZEN | FROZEN | PENDING | evidencia instance-safe previa; no tocar salvo fallo real |
| `cmp_FL_PageHeaderPro` | `FUNCTIONAL_FROZEN` con smoke actual recomendado | FROZEN | FROZEN | PENDING | evidencia instance-safe previa; AutoHeight + Comfortable |
| `cmp_FL_TreePro` | `FUNCTIONAL` | FROZEN en fuente RC3 | OPEN hasta Studio retest | PENDING | RC3 hardened; requiere definición + instancia + contrato |
| `cmp_FL_ProcessRailPro` | `FUNCTIONAL` | FROZEN en fuente actual | OPEN hasta Studio gate | PENDING | flat Gallery; no integrar revisión nueva sin instance-safe |
| `cmp_FL_DecisionPanelPro` | `FUNCTIONAL` | FROZEN en fuente actual | OPEN hasta Studio gate | PENDING | separación sistema/recomendación/decisión |
| `cmp_FL_GatePanelPro` | `FUNCTIONAL` | FROZEN en fuente RC2 | OPEN hasta Studio retest | PENDING | root palette hardened |
| `cmp_FL_RiskMatrixPro` | `FUNCTIONAL` | FROZEN para patrón 900×650 / 5×5 | OPEN hasta S4/O3/D3 smoke | PENDING | no rediseñar; RC4 |
| `cmp_FL_LineagePanelPro` | `FUNCTIONAL` | FROZEN para H=126 actual | OPEN hasta Studio retest | PENDING | RC3 hardened; mantener contrato |
| `cmp_FL_ApplicabilityMatrixPro` | `FUNCTIONAL` | FROZEN en fuente RC2 | OPEN hasta Studio retest | PENDING | legibilidad corregida; runtime anterior no cubre RC2 |

## Regla de componentes

Antes de integrar una revisión marcada `FUNCTIONAL`:

```text
SOURCE_VALID
→ COMPONENT_DEFINITION_ACCEPTED
→ INSTANCE_SAFE
→ PUBLIC_CONTRACT_VALIDATED
→ VISUAL_QA_VALIDATED
→ READY_FOR_INTEGRATION
```

El color puede permanecer `PENDING` si estructura, legibilidad y estados son válidos; el Theme pass queda separado.

---

# Pantallas — Foundation y Activos

| Pantalla | Estado | Structure | Behavior | Color | DO NOT MODIFY salvo bloque explícito |
|---|---|---:|---:|---:|---|
| `scr_FL_Home` | `FUNCTIONAL_FROZEN` por evidencia previa | FROZEN | FROZEN | PENDING | bootstrap, sidebar slot, header slot, cards, navegación, geometría |
| `scr_FL_FLH` | `FUNCTIONAL_FROZEN` condicionado a TreePro actual | FROZEN | FROZEN intención / revalidar Tree RC3 | PENDING | tabs, detail panel, shell, geometría |
| `scr_FL_Taxonomy` | `FUNCTIONAL_FROZEN` condicionado a TreePro actual | FROZEN | FROZEN intención / revalidar Tree RC3 | PENDING | tabs, detail panel, shell, geometría |
| `scr_FL_ADR` | `FUNCTIONAL_FROZEN` condicionado a TreePro actual | FROZEN | FROZEN intención / revalidar Tree RC3 | PENDING | tabs, detail panel, shell, geometría |
| `scr_FL_AssetCriticality` | `FUNCTIONAL` | FROZEN según fuente actual | requiere smoke | PENDING | no fusionar criticidad con AMEF |
| `scr_FL_Asset360` | `FUNCTIONAL` | FROZEN según fuente actual | requiere smoke | PENDING | master data solo lectura |

---

# Pantallas — Ingeniería reutilizable

| Pantalla | Estado | Structure | Behavior | Color | Restricción |
|---|---|---:|---:|---:|---|
| `scr_FL_FmeaLibrary` | `FUNCTIONAL_FROZEN` por evidencia previa | FROZEN | FROZEN | PENDING | no convertir biblioteca en AMEF específico P-101 |
| `scr_FL_FmeaRevision` | `FUNCTIONAL_FROZEN` por evidencia previa | FROZEN | FROZEN | PENDING | revisión/versionado separado de AnalysisCase |
| `scr_FL_AssetApplication` | `FUNCTIONAL_FROZEN` condicionado a Applicability RC2 | FROZEN | FROZEN intención / revalidar componente | PENDING | no duplicar ingeniería por activo |

---

# Pantallas — AnalysisCase

| Pantalla | Estado | Structure | Behavior | Color | Estrategia |
|---|---|---:|---:|---:|---|
| `scr_FL_AnalysisRegister` | `FUNCTIONAL` | OPEN hasta primer Studio gate actual | OPEN | PENDING | construir/evolucionar por bloques si requiere cambio |
| `scr_FL_CaseOverview` | `FUNCTIONAL` | OPEN hasta primer Studio gate actual | OPEN | PENDING | ProcessRail + lineage requieren component gate |
| `scr_FL_Context` | `FUNCTIONAL` | OPEN | OPEN | PENDING | skeleton first si se reconstruye |
| `scr_FL_Functions` | `FUNCTIONAL` | OPEN | OPEN | PENDING | funciones/fallos heredados, no creación silenciosa |
| `scr_FL_FailureModes` | `FUNCTIONAL` | OPEN | OPEN | PENDING | modos + causas heredadas/aplicabilidad |
| `scr_FL_AMEF` | `IN_CONSTRUCTION` | OPEN | OPEN | PENDING | **reconstruir skeleton first; no pegar versión monolítica** |
| `scr_FL_RCM` | `FUNCTIONAL` source candidate | OPEN | OPEN | PENDING | lógica versionable + autoridad humana |
| `scr_FL_Economics` | `FUNCTIONAL` source candidate | OPEN | OPEN | PENDING | evaluación económica separada |
| `scr_FL_Task` | `FUNCTIONAL` source candidate | OPEN | OPEN | PENDING | ProposedTask / Variant / MaintenanceTask separados |
| `scr_FL_PlanPackage` | `FUNCTIONAL` source candidate | OPEN | OPEN | PENDING | alcance físico + agrupación sin perder tag |
| `scr_FL_Traceability` | `FUNCTIONAL` source candidate | OPEN | OPEN | PENDING | lineage biblioteca→ejecución |
| `scr_FL_ReviewApproval` | `FUNCTIONAL` source candidate | OPEN | OPEN | PENDING | snapshot + autoridad |
| `scr_FL_Effectiveness` | `FUNCTIONAL` source candidate | OPEN | OPEN | PENDING | execution result → mejora |

---

# Handoff / Gobierno

| Pantalla | Estado | Structure | Behavior | Color | Restricción |
|---|---|---:|---:|---:|---|
| `scr_FL_MaintenancePlans` | `FUNCTIONAL` source candidate | OPEN | OPEN | PENDING | distinguir Task/Procedure/JobPlan/PM/WO/Result |
| `scr_FL_Governance` | `FUNCTIONAL` source candidate | OPEN | OPEN | PENDING | no fingir persistencia productiva |
| `scr_FL_Settings` | `FUNCTIONAL` source candidate | OPEN | OPEN | PENDING | no fingir seguridad/configuración final |

---

# Utility Lab

| Pantalla | Estado | Structure | Behavior | Color | Alcance |
|---|---|---:|---:|---:|---|
| `scr_DesignSystemLab` | `IN_CONSTRUCTION` | OPEN hasta DS-S01 | n/a | PENDING | laboratorio técnico; no forma parte del producto |

---

# Evidencia que no debe perderse

```text
HOME OK
ACTIVOS OK
BIBLIOTECA AMEF OK
APLICACIÓN MULTI-ACTIVO OK
HOME BASELINE PASS
FLH PASS
TAXONOMÍA PASS
ADR PASS
```

Esta evidencia congela la **intención y las piezas realmente aprobadas**. No autoriza a reintroducir versiones antiguas de sus archivos.

---

# Regla para actualizar este registro

Después de cada bloque validado en Studio:

1. actualizar únicamente la fila afectada;
2. registrar el nuevo estado;
3. marcar qué capa quedó congelada;
4. mantener `COLOR PENDING` mientras la paleta no haya superado DesignSystemLab;
5. no promover otras piezas por asociación.
