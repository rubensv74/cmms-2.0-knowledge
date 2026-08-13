# CMMS 2.0 Functional Lab — Instalación canónica modular

**Estado:** recovery-hardened / Studio-first  
**Rama:** `feature/f01-premium-foundation`  
**Fecha:** 2026-08-11

## 1. Autoridad

La construcción y evolución de pantallas/componentes sigue obligatoriamente:

`functional-engineering-knowledge-base/30-playbooks/power-platform/modular-power-apps-screen-construction.md`

Power Apps Studio es el entorno principal. GitHub conserva fuentes y bloques, pero no sustituye la validación.

## 2. Secuencia vigente

No se instalan 25 pantallas monolíticas por lotes.

La secuencia es:

```text
A. preparar identidades/dependencias
B. construir DesignSystemLab skeleton
C. validar tokens/color
D. validar componentes reutilizables aisladamente
E. integrar solo el componente validado en una pantalla congelada
F. para pantallas nuevas/abiertas: skeleton → placeholders → C → I
G. Theme pass separado
```

## 3. Preparar el grafo de identidades

Antes de diagnosticar `Navigate(...)`, deben existir como objetos de Studio las 25 pantallas funcionales canónicas:

```text
scr_FL_Home
scr_FL_FLH
scr_FL_Taxonomy
scr_FL_ADR
scr_FL_AssetCriticality
scr_FL_Asset360
scr_FL_FmeaLibrary
scr_FL_FmeaRevision
scr_FL_AssetApplication
scr_FL_AnalysisRegister
scr_FL_CaseOverview
scr_FL_Context
scr_FL_Functions
scr_FL_FailureModes
scr_FL_AMEF
scr_FL_RCM
scr_FL_Economics
scr_FL_Task
scr_FL_PlanPackage
scr_FL_Traceability
scr_FL_ReviewApproval
scr_FL_Effectiveness
scr_FL_MaintenancePlans
scr_FL_Governance
scr_FL_Settings
```

Si falta una, crear `Blank screen` y renombrar exactamente. No es necesario pegar aún su contenido.

Esto resuelve dependencias de nombre sin violar `skeleton first`.

## 4. Utility screen de validación

Crear/usar:

```text
scr_DesignSystemLab
```

No es una pantalla funcional del CMMS ni se incluye en navegación del producto.

Construcción:

```text
DS-S01 skeleton
→ freeze geometry
→ DS-C01 semantic tokens
→ DS-C02 Classic/Modern controls
→ DS-C03 interaction states
→ DS-C04 data visualisation
→ COLOR FOUNDATION APPROVED
```

No propagar color antes de ese gate.

## 5. Gate reutilizable de componentes

Cada componente modificado debe pasar:

```text
SOURCE_VALID
→ COMPONENT_DEFINITION_ACCEPTED
→ INSTANCE_SAFE
→ PUBLIC_CONTRACT_VALIDATED
→ VISUAL_QA_VALIDATED
→ READY_FOR_INTEGRATION
```

Prueba mínima:

1. actualizar definición existente in situ;
2. guardar y revisar App Checker;
3. insertar una única instancia en `scr_DesignSystemLab`;
4. guardar y reabrir;
5. probar contrato público;
6. revisar clipping/scroll/estados;
7. integrar en pantalla real solo al pasar.

No crear componentes `_1` como mecanismo de actualización.

## 6. Componentes canónicos

```text
cmp_FL_SidebarPro
cmp_FL_PageHeaderPro
cmp_FL_TreePro
cmp_FL_ProcessRailPro
cmp_FL_DecisionPanelPro
cmp_FL_GatePanelPro
cmp_FL_RiskMatrixPro
cmp_FL_LineagePanelPro
cmp_FL_ApplicabilityMatrixPro
```

Consultar el estado exacto en:

`../development/FREEZE_REGISTER_2026-08-11.md`

## 7. Pantallas ya aprobadas: no reconstruir

Las áreas con evidencia positiva conservan su geometría/intención:

```text
Home
FLH
Taxonomía
ADR
Biblioteca AMEF
Revisión AMEF
Aplicación multi-activo
```

Cuando una revisión de componente deba incorporarse, usar un bloque `C`/`I`/`FIX` acotado al slot concreto.

Ejemplo:

```text
I-ASSET-01 — TreePro → FLH
TOUCHES: TreePro instance/bindings
DO NOT MODIFY: tabs, detail panel, shell, geometry
```

## 8. Pantallas abiertas o nuevas: skeleton first

Si una pantalla no está congelada o necesita reconstrucción estructural:

```text
S01 full screen skeleton
→ placeholders contratados
→ Studio validation
→ GEOMETRY FROZEN
→ C01 placeholder replacement
→ validation/freeze
→ C02 ...
→ I01 interaction
→ validation/freeze
→ Theme pass
```

No reutilizar una pantalla completa del repositorio como bloque monolítico si eso modifica simultáneamente estructura, componentes, comportamiento y color.

## 9. AMEF — caso especial de recuperación

`scr_FL_AMEF` está `IN_CONSTRUCTION`; no se considera congelada.

Debe reconstruirse mediante:

```text
S-AMEF-01  full screen skeleton
C-AMEF-01  Sidebar
C-AMEF-02  Header
C-AMEF-03  Process Rail
C-AMEF-04  FL-07 contextual effects
C-AMEF-05  FL-09 RiskMatrix
C-AMEF-06  Decision
C-AMEF-07  Stage status/control de avance
I-AMEF-01  stage switching
I-AMEF-02  S/O/D → S×O/NPR
```

Cada bloque se valida y congela antes del siguiente.

Fixture:

```text
S = 4
O = 3
D = 3
S×O = 12
NPR = 36
```

No rediseñar RiskMatrix durante integración.

## 10. Fixture canónico P-101

```text
FmeaDefinition        AMEF-BOMBA-CENTRIFUGA
FmeaRevision          R01
Application           APP-P101-R01
TechnicalObject       P-101
AssetCriticality      Alta
Profile               HIGH
AnalysisCase          P101-AMEF-RCM-001
```

La criticidad del activo es contexto externo al riesgo AMEF.

## 11. Bootstrap

`scr_FL_Home.OnVisible` sigue siendo la autoridad del fixture alineado mediante `varFLAlignedInitialized`.

No reinstalar bootstraps legacy.

## 12. Gate mínimo por bloque

Un bloque no pasa hasta cumplir:

```text
[ ] Studio acepta estructura/fórmulas
[ ] app guarda
[ ] App Checker no introduce error bloqueante nuevo
[ ] interacción principal acordada funciona
[ ] no rompe piezas congeladas
[ ] resultado visual es suficiente para el estado declarado
```

Si falla:

```text
BLOCK X
→ X-FIX
→ validate
```

No continuar con el bloque siguiente.

## 13. Color y Theme

La paleta se gobierna mediante roles compartidos, no por paletas arbitrarias de componente.

Roles mínimos:

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

Se permite:

```text
STRUCTURE       FROZEN
BEHAVIOR        FROZEN
DATA CONTRACT   FROZEN
COLOR           PENDING
```

Un problema cromático se reproduce primero en `scr_DesignSystemLab` y no reabre por defecto una pantalla funcionalmente congelada.

## 14. Visual QA

Baseline Comfortable:

```text
visible mínimo  11
supporting      12
label           12–13
body            13–14
card title      15–17
section title   16–18
page title      24–28
button          12–13
```

No reducir tipografía para hacer caber contenido. Ajustar layout/scroll mediante bloque explícito.

## 15. Definition of Done

Una pantalla final requiere:

- arquitectura consolidada;
- placeholders conscientemente sustituidos;
- componentes reutilizables `READY_FOR_INTEGRATION` antes de consumo;
- estados funcionales explícitos;
- navegación/contexto correcto;
- `FUNCTIONAL_FROZEN` antes del Theme pass;
- color validado centralmente;
- Visual QA en Studio;
- no regresión de bloques congelados;
- estado `FINAL_FROZEN` únicamente después de evidencia real.

## 16. Documentos operativos

Seguir:

```text
../development/TOMORROW_RUNBOOK_2026-08-12.md
../development/FREEZE_REGISTER_2026-08-11.md
../development/RECOVERY_HARDENING_AUDIT_2026-08-11.md
../development/compatibility.md
```
