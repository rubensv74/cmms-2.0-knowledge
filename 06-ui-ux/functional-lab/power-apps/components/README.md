# Power Apps Components — CMMS 2.0 Functional Lab

**Fuente:** rama `feature/f01-premium-foundation`  
**Autoridad de construcción:** `functional-engineering-knowledge-base/30-playbooks/power-platform/modular-power-apps-screen-construction.md`

## Regla de identidad

Si un componente ya existe en Power Apps Studio, actualizar **la definición existente in situ**.

No insertar una segunda copia como mecanismo de actualización. Una identidad nueva no reasocia automáticamente las instancias antiguas.

## Gate obligatorio antes de integrar una revisión

```text
SOURCE_VALID
→ COMPONENT_DEFINITION_ACCEPTED
→ INSTANCE_SAFE
→ PUBLIC_CONTRACT_VALIDATED
→ VISUAL_QA_VALIDATED
→ READY_FOR_INTEGRATION
```

La prueba de instancia se realiza primero en `scr_DesignSystemLab` u otra superficie aislada. Solo después se toca una pantalla funcional.

Si un componente falla, comparar primero con un PULSE `INSTANCE_SAFE` comparable, corregir la versión completa y ejecutar un único smoke. La reducción es segunda línea.

Referencias principales:

```text
PULSE cmp_HeatMapPro
PULSE cmp_SidebarNav
PULSE Classic/TextInput@2.3.2
```

## Componentes canónicos

| Orden | Componente | Estado de fuente / freeze |
|---|---|---|
| 1 | `cmp_FL_SidebarPro` | evidencia positiva previa; estructura/contrato congelados; color pendiente |
| 2 | `cmp_FL_PageHeaderPro` | evidencia positiva previa; estructura/contrato congelados; color pendiente |
| 3 | `cmp_FL_TreePro` | **HARDENED SAFE PALETTE RC3**; requiere gate Studio de revisión actual |
| 4 | `cmp_FL_ProcessRailPro` | source revisado; requiere gate Studio |
| 5 | `cmp_FL_DecisionPanelPro` | source revisado; requiere gate Studio |
| 6 | `cmp_FL_GatePanelPro` | **HARDENED SAFE PALETTE RC2**; requiere gate Studio |
| 7 | `cmp_FL_RiskMatrixPro` | Premium AMEF 5×5 RC4; requiere S4/O3/D3 smoke y QA visual |
| 8 | `cmp_FL_LineagePanelPro` | **HARDENED SAFE PALETTE RC3 / Height 126**; requiere gate Studio |
| 9 | `cmp_FL_ApplicabilityMatrixPro` | **HARDENED READABILITY RC2**; requiere gate Studio |

Estado exacto: `../../development/FREEZE_REGISTER_2026-08-11.md`.

## Color — separación obligatoria

Los componentes no definen semántica cromática independiente.

Roles compartidos:

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

Los `ColorValue(...)` existentes en los componentes se consideran fallback de compatibilidad hasta consolidar el Theme; no son una segunda fuente semántica de verdad.

Se permite que un componente quede:

```text
STRUCTURE       FROZEN
BEHAVIOR        FROZEN
DATA CONTRACT   FROZEN
COLOR           PENDING
```

Un problema puramente cromático se reproduce primero en `scr_DesignSystemLab`. No reabre automáticamente estructura o comportamiento.

## Hardening aplicado

### FL-SC-004

En componentes afectados se evitó depender de Inputs `Color` en el camino visual base mientras el incidente no estuviera validado centralmente:

```text
TreePro       root/selection/highlight/text → fallback interno
LineagePanel  root/text/accent              → fallback interno
GatePanel     root surface                  → fallback interno
```

La causa interna exacta de Studio no se declara demostrada.

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

`TreePro`, `LineagePanel` y `ApplicabilityMatrix` fueron elevados en sus zonas principales. La aprobación final requiere Studio.

## Riesgo aislado pendiente — Tree search

`cmp_FL_TreePro` usa actualmente `ModernTextInput@1.1.1` para búsqueda. Esta revisión debe comprobarse como parte del gate aislado del Tree.

No se sustituye preventivamente.

Si el smoke demuestra que el control es el delta problemático, el bloque correcto será un `C-CMP-01-FIX` limitado al search control, usando como alternativa la referencia positiva `Classic/TextInput@2.3.2` sin reescribir el resto del Tree.

## Compatibilidad protegida

- `GroupContainer@1.5.0`
- `Gallery@2.15.0`
- `Classic/Icon@2.5.0`
- `Label@2.5.1`
- `Classic/Button@2.2.0`
- `ModernText@1.0.0`
- `Classic/TextInput@2.3.2` como referencia positiva
- contratos `CustomProperties` completos
- no `AccessibleLabel` en `Classic/Button@2.2.0` sin validación específica
- no `Radius*` en `Label@2.5.1`
- controles planos dentro de Gallery cuando aplica
- fórmulas con riesgo YAML `: ` expresadas como bloque `|-`

## Integración

Un bloque de pantalla que consuma una revisión nueva debe declarar:

```text
TOUCHES
slot/instancia concreta

DO NOT MODIFY
geometría y piezas congeladas
```

No integrar varios componentes pendientes dentro de un único bloque.

## Guías

- `../V2_INSTALLATION.md`
- `../../development/TOMORROW_RUNBOOK_2026-08-12.md`
- `../../development/FREEZE_REGISTER_2026-08-11.md`
- `../../development/RECOVERY_HARDENING_AUDIT_2026-08-11.md`
