# CMMS 2.0 Functional Lab — Auditoría estática de fuentes

**Fecha:** 2026-08-11  
**Rama:** `feature/f01-premium-foundation`  
**Alcance:** 9 componentes canónicos + grafo de 25 pantallas + utility lab + reglas de integración.

> Esta auditoría valida coherencia de fuente, contratos, patrones y riesgos observables. No sustituye Power Apps Studio y no promueve una pieza a `INSTANCE_SAFE` o `VISUAL_QA_VALIDATED`.

## 1. Autoridades consultadas

Antes de cerrar la auditoría se contrastaron:

```text
30-playbooks/power-platform/modular-power-apps-screen-construction.md
15-standards/power-platform/power-apps-source-code-compatibility-standard.md
15-standards/ux-ui/power-apps-visual-quality-standard.md
15-standards/ux-ui/enterprise-design-system-token-governance.md
80-learning/power-platform/POWER_APPS_UI_LESSONS_LEARNED.md
```

Y las referencias PULSE:

```text
cmp_HeatMapPro.pa.yaml
cmp_SidebarNav.pa.yaml
cmp_CustomFieldEditor.pa.yaml
```

## 2. Resultado de auditoría de los 9 componentes

### cmp_FL_SidebarPro

```text
Public contract           coherente
Gallery                   flat / referencia positiva equivalente disponible
Text baseline             >=11
Color                     fallback seguro cuando UseHostTheme=false
Identity                  debe preservarse in situ
Status                    evidencia positiva previa / no reabrir sin fallo real
```

No se modifica en esta recuperación.

### cmp_FL_PageHeaderPro

```text
Public contract           coherente
ModernText                AutoHeight=true
Typography                11 / 13 / 24
Color                     fallback seguro
Identity                  preservar in situ
Status                    evidencia positiva previa / no reabrir sin fallo real
```

No se modifica en esta recuperación.

### cmp_FL_TreePro — RC3

```text
Public contract           preservado
Gallery                   flat controls
Label Radius              no usado
Classic Button            sin AccessibleLabel
Typography                >=11 en RC3
Selection/highlight       fallback interno seguro
Search control            ModernTextInput@1.1.1
Status                    SOURCE_VALID candidate / Studio retest required
```

#### Riesgo aislado TREE-R01

`ModernTextInput@1.1.1` no forma parte de la lista de controles con evidencia positiva local equivalente a `Classic/TextInput@2.3.2`.

**No se sustituye preventivamente.**

Gate:

```text
insertar Tree RC3 en DesignSystemLab
→ probar búsqueda
```

Solo si falla y el delta apunta al search control:

```text
C-CMP-01-FIX
TOUCHES: txtFLTreeSearch only
DO NOT MODIFY: Gallery, outputs, toggle, selection, geometry
replacement candidate: Classic/TextInput@2.3.2
```

### cmp_FL_ProcessRailPro

```text
Public contract           coherente
Gallery                   flat
Stage typography          11–12
Scroll                     explícito
UseHostTheme              fallback seguro
Status                    SOURCE reviewed / Studio gate pending
```

#### Riesgo aislado RAIL-R01

La pantalla AMEF anterior comprimía el rail a ~250 px. El componente necesita suficiente ancho para etiquetas de etapa legibles.

No reducir tipografía. La corrección pertenece al **skeleton de AMEF**, no al componente.

Contrato recomendado de slot AMEF:

```text
Process Rail target width ≈300 px en desktop
```

### cmp_FL_DecisionPanelPro

```text
System result             separado
Recommendation            separada
Human decision            separada
Override                   explícito
Typography                11–16
Buttons                    Classic/Button@2.2.0 sin AccessibleLabel
Color                     fallback seguro
Status                    SOURCE reviewed / Studio gate pending
```

Sin cambio estático adicional.

### cmp_FL_GatePanelPro — RC2

```text
Public contract           preservado
Root fill                  safe fallback
Status states             passed/warning/blocked
Visible terminology       configurable por host
Typography                11–16
Button                    12
Status                    SOURCE_VALID candidate / Studio retest required
```

No usar “Gate” como lenguaje principal visible cuando se integre; el host debe aportar `Estado de la etapa`, `Control de avance`, etc.

### cmp_FL_RiskMatrixPro — RC4

```text
Geometry                  900×650
Matrix                    5×5
Default P-101             S4 / O3
Detection                 D3
Expected S×O              12
Expected NPR              36
Cell Gallery              Sequence(25)
Gallery.Default           sincronizado con S/O inputs
Outputs                   selected + fallback
Typography                >=12 en áreas visibles principales
Status                    SOURCE candidate / isolated Studio gate pending
```

#### Riesgo aislado RISK-R01

`Gallery.Selected` debe probarse con:

```text
initial S4/O3
→ select another cell
→ verify outputs
→ change/re-enter stage
→ verify expected retained/current state
```

No modificar la matriz antes de este smoke.

Si aparece un fallo de selección estable, generar `C-CMP-05-FIX` limitado al estado de selección; no rediseñar geometría/paleta/labels.

### cmp_FL_LineagePanelPro — RC3

```text
Public contract           preservado
Height                    126 compatible con hosts actuales
Typography                >=11
Internal visual path      safe fallback
Status                    SOURCE_VALID candidate / Studio retest required
```

#### Riesgo aislado LINEAGE-R01

El hint final usa `Wrap=false`. Debe probarse con el ancho real más estrecho que consuma el componente.

Si existe clipping:

```text
C-CMP-02-FIX
TOUCHES: lblFLLineageHint overflow strategy only
DO NOT MODIFY: contract, columns, lineage semantics, component height unless explicitly justified
```

No reducir fuente.

### cmp_FL_ApplicabilityMatrixPro — RC2

```text
Public contract           preservado
Title                     16
Hint/rows                  12
Headers                    11
Gallery                    flat
Selection outputs          Gallery.Selected
Status                    SOURCE_VALID candidate / Studio retest required
```

#### Riesgo aislado APP-R01

La tabla usa anchos de columna específicos para un componente de ~920 px. Probar en el host real antes de considerarlo responsive.

No comprimir tipografía si el host es más estrecho; un FIX de layout será independiente.

## 3. Conclusión de componentes

No hay justificación estática para volver a reconstruir ninguno de los nueve componentes completos.

Acción correcta:

```text
validar revisión actual en aislamiento
→ si pasa, freeze/integrate
→ si falla, FIX del delta concreto
```

Esto sustituye el ciclo anterior de recuperar/rediseñar componentes completos ante cada síntoma visual.

## 4. Auditoría del grafo de pantallas

El repositorio contiene las 25 fuentes funcionales canónicas documentadas en `power-apps/screens/README.md`.

El diagnóstico de `Name isn't valid. 'scr_FL_X'` se considera no concluyente mientras `scr_FL_X` no exista como identidad en Studio.

Preparación permitida:

```text
crear Blank screen
→ asignar nombre canónico
```

Esto no implica pegar su contenido.

## 5. Clasificación por freeze

### Ya aprobadas funcionalmente

```text
scr_FL_Home
scr_FL_FLH
scr_FL_Taxonomy
scr_FL_ADR
scr_FL_FmeaLibrary
scr_FL_FmeaRevision
scr_FL_AssetApplication
```

Regla:

```text
NO bulk replacement
NO geometry redesign
solo C / I / FIX sobre slot declarado
```

### Requieren smoke actual / consolidación incremental

```text
scr_FL_AssetCriticality
scr_FL_Asset360
scr_FL_AnalysisRegister
scr_FL_CaseOverview
scr_FL_Context
scr_FL_Functions
scr_FL_FailureModes
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

Las fuentes actuales se conservan como referencia funcional. Si una de estas pantallas requiere reconstrucción o cambio estructural, se aplica skeleton first antes de un nuevo YAML.

### Pantalla abierta a reconstrucción

```text
scr_FL_AMEF
STATUS = IN_CONSTRUCTION
STRUCTURE = OPEN
BEHAVIOR = OPEN
COLOR = PENDING
```

No utilizar su YAML monolítico actual como siguiente paso de recuperación.

## 6. Deuda tipográfica de pantallas

Se ha confirmado en fuentes existentes la presencia de textos `Size=9/10` heredados.

Esto se registra como deuda visual, no como motivo para hacer un search-and-replace global.

Regla:

```text
geometry/function freeze
→ bloque visual acotado
→ Studio QA
→ freeze
```

Nunca reducir texto para evitar clipping.

## 7. Color — hallazgo transversal

Los componentes actuales todavía contienen valores `ColorValue(...)` concretos. Estos valores se tratan como **fallback de compatibilidad**, no como paletas semánticas autónomas.

La evolución de color se traslada a:

```text
scr_DesignSystemLab
DS-C01 semantic tokens
DS-C02 Classic/Modern
DS-C03 interaction states
DS-C04 data palette
```

Hasta aprobarlos:

```text
COLOR = PENDING
```

## 8. Utility lab — DS-S01

Archivo preparado:

`power-apps/labs/design-system/DS-S01_scr_DesignSystemLab_skeleton.pa.yaml`

Auditoría estática DS-S01:

```text
Type                      S — Structural
Scope                     scr_DesignSystemLab only
Dependencies              none
Reusable components       none
Controls                  GroupContainer@1.5.0 + ModernText@1.0.0
ModernText                AutoHeight=true
Visible text <11          not intentionally present
Classic Button issues     n/a
Label Radius issues       n/a
Color semantics           placeholder neutral only; not approved Theme
Status                    SOURCE_VALID candidate / Studio pending
```

No preparar `DS-C01` hasta validar DS-S01 en Studio y congelar geometría.

## 9. AMEF — restricciones derivadas de la auditoría

El skeleton AMEF debe garantizar desde el principio:

```text
Sidebar                    slot congelable
Header                     slot congelable
Process Rail               ≈300 px desktop target, scroll vertical
Primary workspace          >=900 px útiles para RiskMatrix en FL-09
RiskMatrix                 900×650 sin compresión
Stage context              slot opcional/colapsable por etapa
Status/action              slot independiente
Color                      pending hasta DesignSystemLab
```

La geometría se valida con placeholders antes de integrar componentes.

## 10. Blindajes finales

```text
[1] playbook obligatorio antes de YAML
[2] block contract S/C/I/FIX
[3] one block / one purpose
[4] TOUCHES + DO NOT MODIFY
[5] geometry freeze
[6] component isolated gate
[7] PULSE positive reference first
[8] no component copy _1 as update
[9] no diagnostic Navigate over partial graph
[10] color isolated in DesignSystemLab
[11] FUNCTIONAL_FROZEN may coexist with COLOR PENDING
[12] no bulk typography/color replacement
[13] no monolithic AMEF recovery
[14] Studio/App Checker are runtime authority
```

## 11. Pendiente real para mañana

No queda pendiente otra auditoría teórica de los componentes.

Quedan pendientes **gates de Studio** y la construcción incremental:

```text
PREP-01 screen identities
DS-S01 Studio validation
DS-C01…04 one by one
component isolated gates
frozen-screen targeted integrations
S-AMEF-01 skeleton
AMEF C/I blocks
remaining screens by same method
```
