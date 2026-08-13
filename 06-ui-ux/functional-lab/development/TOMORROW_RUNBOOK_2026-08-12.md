# CMMS 2.0 Functional Lab — Runbook incremental para 2026-08-12

**Objetivo:** recuperar y terminar el Functional Lab sin volver a introducir regresiones, aplicando como autoridad de construcción el playbook:

`functional-engineering-knowledge-base/30-playbooks/power-platform/modular-power-apps-screen-construction.md`

Power Apps Studio es el centro del ciclo. GitHub se utiliza únicamente como fuente y archivo de los bloques preparados; **no es requisito para validar ni construir**.

---

# Regla de trabajo de mañana

```text
DEFINIR ESTRUCTURA
→ PLACEHOLDERS
→ BLOQUE S/C/I
→ PEGAR EN STUDIO
→ VALIDAR
→ CONGELAR
→ SIGUIENTE BLOQUE
```

No se sustituirán 9 componentes ni 25 pantallas de una sola vez.

No se volverá a un commit histórico para reconstruir una pieza.

No se utilizará el bloque siguiente para reparar el anterior. Un fallo genera un bloque `FIX` independiente.

---

# 0 — Preparación de dependencias, sin modificar UI

Antes de empezar con YAML, comprobar que existen en Studio las 25 identidades canónicas de pantalla:

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

Si falta alguna, crear **Blank screen** con el nombre exacto. No pegar todavía su implementación.

Esto es preparación del grafo de dependencias, no un cambio de geometría de las pantallas aprobadas.

### Gate PREP-01

App Checker no debe seguir mostrando `Name isn't valid. 'scr_FL_X'` únicamente porque un destino canónico no existe.

Si un nombre anterior sigue apareciendo como inválido, comprobar primero el nombre real del objeto en Studio. No modificar fórmulas de navegación por intuición.

---

# 1 — Abrir el laboratorio de design system antes de tocar color

Existe un incidente cromático activo (`FL-SC-004`). Por el nuevo playbook, **ninguna corrección de paleta se propagará directamente a Home, FLH, AMEF u otra pantalla productiva**.

La superficie de prueba será:

```text
scr_DesignSystemLab
```

No forma parte de las 25 pantallas funcionales ni de la navegación del producto. Es una pantalla técnica temporal de validación visual.

## Bloque DS-S01 — Skeleton del Design System Lab

**Tipo:** `S — Structural`

**Objetivo único:** crear la geometría completa del laboratorio mediante placeholders.

```text
ph_Header
ph_TokenRoles
ph_Text
ph_ClassicControls
ph_ModernControls
ph_InteractionStates
ph_DataViz
ph_Status
```

### DO NOT MODIFY

```text
scr_FL_Home
scr_FL_FLH
scr_FL_Taxonomy
scr_FL_ADR
scr_FL_AMEF
ningún componente funcional
```

### Gate DS-S01

Validar únicamente:

```text
[ ] pantalla abre
[ ] placeholders ocupan la geometría prevista
[ ] scroll es intencional
[ ] no hay clipping
[ ] no hay error nuevo de fórmula
```

Si pasa:

```text
DESIGN LAB STRUCTURE FROZEN
```

No avanzar a DS-C01 si no pasa.

---

# 2 — Validar tokens y color como capa independiente

Después de `DESIGN LAB STRUCTURE FROZEN`:

## DS-C01 — Semantic token roles

**Tipo:** `C — Component/content`

Sustituir `ph_TokenRoles` por la muestra de roles compartidos:

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
Success
Warning
Danger
SelectedBackground
SelectedBorder
SelectedAccent
SelectedText
Chart01…Chart06
```

El propósito es validar roles, no crear una paleta diferente por componente.

### Gate DS-C01

```text
[ ] los valores se renderizan como se espera en Studio
[ ] contraste principal suficiente
[ ] no aparecen superficies negras inesperadas
[ ] selección y estado semántico se distinguen
```

Si pasa:

```text
TOKEN RENDER VALIDATED
```

## DS-C02 — Classic + Modern controls

**Tipo:** `C`

Sustituir únicamente:

```text
ph_ClassicControls
ph_ModernControls
```

Probar botones, texto, input, borde, surface y disabled sin tocar token roles.

## DS-C03 — Interaction states

**Tipo:** `C`

Sustituir `ph_InteractionStates` y validar:

```text
Default
Hover
Pressed
Selected
Disabled
Focus
Success
Warning
Error
```

## DS-C04 — Data visualisation

**Tipo:** `C`

Sustituir `ph_DataViz` y comprobar la paleta de datos sin reutilizarla como lenguaje de botón o selección.

### Gate de color

Solo cuando DS-C01…DS-C04 pasen:

```text
COLOR FOUNDATION APPROVED
```

Hasta entonces:

```text
STRUCTURE      puede estar FROZEN
BEHAVIOR       puede estar FROZEN
DATA CONTRACT  puede estar FROZEN
COLOR          PENDING
```

---

# 3 — Registro de congelación antes de tocar componentes

Consultar:

`FREEZE_REGISTER_2026-08-11.md`

Regla:

- una pieza `FUNCTIONAL_FROZEN` no se reabre por un problema exclusivamente cromático;
- una pieza `FINAL_FROZEN` solo se toca si el bloque declara expresamente el motivo;
- una revisión de color se valida primero en `scr_DesignSystemLab`.

---

# 4 — Gate aislado de componentes reutilizables

Ningún componente modificado puede volver a una pantalla real sin pasar primero por superficie aislada.

Secuencia obligatoria para cada componente:

```text
SOURCE_VALID
→ COMPONENT_DEFINITION_ACCEPTED
→ INSTANCE_SAFE
→ PUBLIC_CONTRACT_VALIDATED
→ VISUAL_QA_VALIDATED
→ READY_FOR_INTEGRATION
```

Prueba práctica:

1. actualizar **la definición existente in situ**;
2. guardar;
3. revisar App Checker;
4. insertar una sola instancia de prueba en `scr_DesignSystemLab`;
5. guardar y reabrir;
6. probar inputs/outputs/events esenciales;
7. revisar clipping y estados;
8. solo entonces integrar en pantalla real.

No crear copias `_1`.

## Orden de prioridad

```text
C-CMP-01  cmp_FL_TreePro
C-CMP-02  cmp_FL_LineagePanelPro
C-CMP-03  cmp_FL_ApplicabilityMatrixPro
C-CMP-04  cmp_FL_ProcessRailPro
C-CMP-05  cmp_FL_RiskMatrixPro
C-CMP-06  cmp_FL_DecisionPanelPro
C-CMP-07  cmp_FL_GatePanelPro
```

`cmp_FL_SidebarPro` y `cmp_FL_PageHeaderPro` tienen evidencia positiva previa; no se tocarán de nuevo salvo que el smoke actual revele un fallo real.

### Referencia positiva

Si un componente falla al instanciarse, antes de hacer micropruebas comparar con componentes PULSE `INSTANCE_SAFE`, especialmente:

```text
cmp_HeatMapPro
cmp_SidebarNav
```

Corregir el candidato completo y hacer **un** smoke. La reducción controlada es segunda línea, no primera reacción.

---

# 5 — Home: congelar, no reconstruir

Home ya aportó evidencia funcional positiva. No se sustituye el Source Code completo por rutina.

Estado objetivo inicial:

```text
GEOMETRY       FROZEN
BOOTSTRAP      FROZEN
NAVIGATION     FUNCTIONAL_FROZEN
COLOR          PENDING hasta Color Lab
```

### Única intervención permitida

Si `cmp_FL_LineagePanelPro` supera el gate aislado y la instancia de Home necesita actualización, realizar un bloque:

```text
C-HOME-01-FIX — Lineage instance update
```

**TOUCHES:** únicamente la instancia Lineage / su slot.

**DO NOT MODIFY:** Sidebar, Header, cards, bootstrap, navegación, geometría.

Después del smoke:

```text
HOME FUNCTIONAL FROZEN
```

---

# 6 — Activos: mantener geometría aprobada

FLH, Taxonomía y ADR ya tienen evidencia positiva. No reconstruir su layout.

Después de que `cmp_FL_TreePro` llegue a `READY_FOR_INTEGRATION`, integrar por bloques independientes:

```text
I-ASSET-01  TreePro → FLH
I-ASSET-02  TreePro → Taxonomía
I-ASSET-03  TreePro → ADR
```

Cada bloque toca únicamente la instancia TreePro y sus bindings.

No modificar tabs, header, detail panel ni navegación.

### Gate por pantalla

```text
[ ] render correcto
[ ] expand/collapse
[ ] selección
[ ] breadcrumb
[ ] búsqueda
[ ] P-101 resaltado
[ ] no regresión de geometría
```

Cada pantalla se congela al pasar su gate.

---

# 7 — Biblioteca AMEF y Aplicación multi-activo

Estas áreas ya tienen evidencia positiva. Se consideran candidatas a `FUNCTIONAL_FROZEN` y no se reconstruyen.

Solo si `cmp_FL_ApplicabilityMatrixPro` necesita entrar con la revisión legible actual:

```text
I-APP-01 — ApplicabilityMatrix integration
```

**TOUCHES:** slot/instancia de aplicabilidad.

**DO NOT MODIFY:** biblioteca, revisión, datos base, navigation shell.

---

# 8 — AMEF se reconstruye correctamente: skeleton first

La pantalla actual `scr_FL_AMEF` no está congelada y su composición previa generó regresiones. Aquí sí se aplica el playbook completo.

No pegar otra versión monolítica de AMEF.

## S-AMEF-01 — Full screen skeleton

Crear únicamente:

```text
Root
├── ph_Sidebar
└── Content
    ├── ph_Header
    └── Body
        ├── ph_ProcessRail
        └── Workspace
            ├── ph_StageContext
            ├── ph_PrimaryWorkspace
            └── ph_StatusAction
```

Definir X/Y/Width/Height o contratos responsive de cada placeholder.

### Gate S-AMEF-01

```text
[ ] proporciones correctas
[ ] rail dispone de ancho legible
[ ] workspace admite RiskMatrix 900×650 cuando corresponda
[ ] scroll previsto
[ ] no existe solapamiento
[ ] geometría aceptada a 100%
```

Cuando se apruebe:

```text
AMEF GEOMETRY FROZEN
```

## C-AMEF-01 — Sidebar

`ph_Sidebar → cmp_FL_SidebarPro`

Solo después de gate del componente.

## C-AMEF-02 — Header

`ph_Header → cmp_FL_PageHeaderPro`

## C-AMEF-03 — Process Rail

`ph_ProcessRail → cmp_FL_ProcessRailPro`

## C-AMEF-04 — FL-07 contextual effects

Sustituye únicamente `ph_PrimaryWorkspace` para FL-07.

## C-AMEF-05 — FL-09 RiskMatrix

Sustituye únicamente `ph_PrimaryWorkspace` para FL-09 por `cmp_FL_RiskMatrixPro`.

Fixture esperado:

```text
S = 4
O = 3
D = 3
S×O = 12
NPR = 36
```

## C-AMEF-06 — Decision

Instala `cmp_FL_DecisionPanelPro` únicamente en el slot contractual.

## C-AMEF-07 — Stage status / avance

Instala `cmp_FL_GatePanelPro` usando lenguaje visible de “Estado de la etapa / Control de avance”.

## I-AMEF-01 — Stage switching

Conecta Process Rail y visibilidad de FL-07…FL-11 sin modificar geometría ni componentes.

## I-AMEF-02 — Risk selection

Conecta selección S/O/D → S×O/NPR.

### Gate AMEF integrado

```text
[ ] FL-07 efectos/contexto
[ ] FL-09 matriz 5×5 completa
[ ] S4/O3/D3 = S×O12 / NPR36
[ ] criticidad del activo separada del riesgo AMEF
[ ] recomendación separada de decisión humana
[ ] avance formal comprensible
[ ] sin clipping
[ ] sin superficies negras accidentales
[ ] ningún bloque previo reabierto incidentalmente
```

Solo entonces:

```text
scr_FL_AMEF → FUNCTIONAL_FROZEN
```

El Theme pass se realiza después, sin reabrir estructura/comportamiento.

---

# 9 — Resto del AnalysisCase

Una vez congelado el patrón AMEF, las pantallas restantes se construyen con el mismo mecanismo:

```text
S — skeleton completo
C — reemplazo de un placeholder
I — integración de piezas ya estables
FIX — reparación del bloque que falla
```

Orden funcional:

```text
Analysis Register
Case Overview
Contexto
Funciones
Modos de fallo
RCM
Economía
Tarea
Paquete de plan
Trazabilidad
Revisión y aprobación
Efectividad
Maintenance Plans
Gobernanza
Configuración
```

No propagar automáticamente el layout AMEF a pantallas con otro trabajo. Compartir lenguaje visual y componentes, no forzar la misma composición.

---

# 10 — Theme pass final

Solo después de que las piezas relevantes estén `FUNCTIONAL_FROZEN`:

```text
H-THEME-01 — aplicar tokens aprobados
H-THEME-02 — estados hover/pressed/selected/focus
H-THEME-03 — contraste y accesibilidad
H-THEME-04 — responsive/clipping
```

Los bloques H no deben alterar lógica funcional ni geometría congelada salvo que lo declaren expresamente.

---

# 11 — Qué registrar después de cada bloque

Usar exactamente uno de estos estados:

```text
IN_CONSTRUCTION
FUNCTIONAL
FUNCTIONAL_FROZEN
VISUAL_APPROVED
FINAL_FROZEN
```

Y registrar, cuando aplique:

```text
STRUCTURE       FROZEN | OPEN
BEHAVIOR        FROZEN | OPEN
DATA CONTRACT   FROZEN | OPEN
COLOR           APPROVED | PENDING
```

Actualizar `FREEZE_REGISTER_2026-08-11.md` después de cada validación relevante.

---

# 12 — Si algo falla

Clasificar antes de modificar:

```text
Name isn't valid scr_FL_*   → dependencia/identidad de pantalla
PA2301 CanvasComponent      → definición/identidad de componente
PA1001                      → estructura/scalar PaYaml
PA2108                      → control/versión/property contract
FAIL_INSTANCE               → comparar primero con referencia PULSE INSTANCE_SAFE
superficie negra            → reproducir en DesignSystemLab; no reabrir pantalla
clipping                    → FIX del bloque visual/layout responsable; no reducir fuente
```

No usar un bloque funcional posterior para reparar silenciosamente otro.

---

# Resultado de cierre

El objetivo no es “que existan 25 YAML pegados”. El objetivo es que cada avance sea acumulativo:

```text
Design System Lab validado
+ color centralizado
+ componentes reutilizables instance-safe
+ Home/Activos/Biblioteca/Aplicación congelados
+ AMEF construido por skeleton/placeholders y congelado
+ resto del flujo construido sin regresiones
+ App Checker sin errores bloqueantes
+ Theme pass separado
```

Ese es el punto en el que las piezas podrán promoverse de forma honesta a `READY_FOR_INTEGRATION` / `FINAL_FROZEN`.
