# Power Apps Components — CMMS 2.0 Functional Lab

**Fuente canónica:** rama `feature/f01-premium-foundation`  
**Estado:** 9 componentes publicados / validación integrada Studio pendiente para las revisiones de hardening del 11-08-2026.

## Regla de identidad

Si un componente ya existe en Power Apps Studio, actualizar **la definición existente in situ**.

No insertar una segunda copia para “actualizar” el componente. Una copia con identidad nueva no reasocia automáticamente las instancias existentes.

## Componentes canónicos

| Orden | Componente | Estado de fuente |
|---|---|---|
| 1 | `cmp_FL_SidebarPro` | safe dark palette + Comfortable; revisión de fuente completa |
| 2 | `cmp_FL_PageHeaderPro` | safe palette + Comfortable; revisión de fuente completa |
| 3 | `cmp_FL_TreePro` | **HARDENED SAFE PALETTE RC3** |
| 4 | `cmp_FL_ProcessRailPro` | safe palette + Comfortable |
| 5 | `cmp_FL_DecisionPanelPro` | safe palette + Comfortable |
| 6 | `cmp_FL_GatePanelPro` | **HARDENED SAFE PALETTE RC2** |
| 7 | `cmp_FL_RiskMatrixPro` | Premium AMEF 5×5 RC4 |
| 8 | `cmp_FL_LineagePanelPro` | **HARDENED SAFE PALETTE RC3 / Height 126** |
| 9 | `cmp_FL_ApplicabilityMatrixPro` | **HARDENED READABILITY RC2** |

## Hardening aplicado

### FL-SC-004 — superficies negras

En los componentes afectados por el incidente de materialización visual de Inputs `Color`, el contrato público se conserva pero la paleta base de render no depende de dichos Inputs.

Especialmente:

```text
TreePro       root/selection/highlight/text → safe internal palette
LineagePanel  root/text/accent              → safe internal palette
GatePanel     root surface                  → safe internal palette
```

`PageHeader`, `Sidebar`, `ProcessRail`, `DecisionPanel`, `RiskMatrix` y `ApplicabilityMatrix` utilizan fallback seguro cuando no se activa el tema del host.

### Legibilidad

Baseline:

```text
mínimo visible 11
supporting     12
body           13–14
section title  16–18
page title     24–28
button         12–13
```

`TreePro`, `LineagePanel` y `ApplicabilityMatrix` fueron elevados expresamente para eliminar texto 7–10 en sus zonas principales.

## Compatibilidad protegida

- `GroupContainer@1.5.0`
- `Gallery@2.15.0`
- `Classic/Icon@2.5.0`
- `Label@2.5.1`
- `Classic/Button@2.2.0`
- `ModernText@1.0.0`
- contratos `CustomProperties` completos
- no `AccessibleLabel` en `Classic/Button@2.2.0`
- no `Radius*` en `Label@2.5.1`
- controles planos dentro de Gallery cuando aplica
- fórmulas con riesgo YAML `: ` expresadas como bloque `|-`

## Niveles de aceptación

La publicación en GitHub no autoriza a declarar automáticamente:

```text
INSTANCE_SAFE
PUBLIC_CONTRACT_VALIDATED
VISUAL_QA_VALIDATED
READY_FOR_INTEGRATION
```

Power Apps Studio y App Checker son el gate final.

## Instalación

Seguir:

- `../V2_INSTALLATION.md`
- `../../development/TOMORROW_RUNBOOK_2026-08-12.md`
- `../../development/RECOVERY_HARDENING_AUDIT_2026-08-11.md`
