# CMMS 2.0 Functional Lab — Instalación arquitectura v2

**Estado:** candidato para validación integrada en Power Apps Studio  
**Rama:** `feature/f01-premium-foundation`

## 1. Objetivo

Instalar la arquitectura v2 como una aplicación coherente, evitando validar 21 pantallas una por una.

La arquitectura v2 sustituye el enfoque anterior de un único Workspace Shell por:

```text
Navegación de producto
+ pantallas por objeto/proceso real
+ Process Rail de FL-01...FL-28
+ decisiones y gates explícitos
```

## 2. Componentes requeridos

Crear o sustituir primero estos seis componentes con su Source Code completo:

1. `components/cmp_FL_SidebarPro.pa.yaml`
2. `components/cmp_FL_PageHeaderPro.pa.yaml`
3. `components/cmp_FL_TreePro.pa.yaml`
4. `components/cmp_FL_ProcessRailPro.pa.yaml`
5. `components/cmp_FL_DecisionPanelPro.pa.yaml`
6. `components/cmp_FL_GatePanelPro.pa.yaml`

No insertar todavía pantallas que los consuman hasta que las seis definiciones estén guardadas en la app.

## 3. Crear primero las 21 pantallas vacías

Antes de pegar cualquier pantalla v2, crear pantallas vacías con exactamente estos nombres:

```text
scr_FL_Home
scr_FL_FLH
scr_FL_Taxonomy
scr_FL_ADR
scr_FL_Asset360
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

Motivo: las fórmulas `Navigate(...)` deben resolver los nombres de pantalla aunque su contenido todavía no esté pegado.

## 4. Orden de pegado recomendado

### Lote A — arranque

```text
scr_FL_Home.pa.yaml
```

`Home.OnVisible` contiene el bootstrap v2 protegido por `varFLV2Initialized`.

Abrir Home una vez después de guardar para inicializar:

- locale;
- rol activo;
- navegación;
- P-101;
- `AnalysisCase`;
- 28 `AnalysisStageExecution`;
- funciones/fallos/modos;
- variables AMEF/RCM/economía/tarea/plan/gobernanza/efectividad.

### Lote B — Activos

```text
scr_FL_FLH.pa.yaml
scr_FL_Taxonomy.pa.yaml
scr_FL_ADR.pa.yaml
scr_FL_Asset360.pa.yaml
```

### Lote C — Estrategia / caso

```text
scr_FL_AnalysisRegister.pa.yaml
scr_FL_CaseOverview.pa.yaml
scr_FL_Context.pa.yaml
scr_FL_Functions.pa.yaml
scr_FL_FailureModes.pa.yaml
scr_FL_AMEF.pa.yaml
scr_FL_RCM.pa.yaml
scr_FL_Economics.pa.yaml
scr_FL_Task.pa.yaml
scr_FL_PlanPackage.pa.yaml
scr_FL_Traceability.pa.yaml
scr_FL_ReviewApproval.pa.yaml
scr_FL_Effectiveness.pa.yaml
```

### Lote D — módulos de shell

```text
scr_FL_MaintenancePlans.pa.yaml
scr_FL_Governance.pa.yaml
scr_FL_Settings.pa.yaml
```

## 5. Estado inicial intencional del caso P-101

La v2 comienza en:

```text
FL-01..FL-06   confirmed
FL-07          draft / current
FL-08..FL-28   not_started
```

Esto conserva la evidencia ya validada durante WS-01 y WS-02 y sitúa el trabajo real siguiente en AMEF.

La navegación experta permite consultar cualquier etapa, pero los gates controlan la progresión formal.

## 6. Validación integrada — no validar 21 pantallas por separado

### Smoke 1 — Foundation

1. guardar los seis componentes;
2. insertar una instancia aislada de los tres componentes nuevos:
   - `cmp_FL_ProcessRailPro`;
   - `cmp_FL_DecisionPanelPro`;
   - `cmp_FL_GatePanelPro`;
3. comprobar que Studio permanece estable.

### Smoke 2 — Shell real

Abrir `scr_FL_Home` y verificar:

- Sidebar muestra módulos de producto;
- P-101 aparece como caso activo;
- botón `Abrir caso` abre Case Overview;
- accesos FLH / Taxonomía / ADR navegan correctamente.

### Smoke 3 — Activos representativo

Abrir `scr_FL_FLH` y verificar:

- TreePro carga;
- P-101 resaltado;
- búsqueda;
- selección;
- expandir/contraer;
- panel derecho;
- tabs navegan a Taxonomía, ADR y Ficha 360.

### Smoke 4 — AnalysisCase representativo

Abrir `scr_FL_CaseOverview` y verificar:

- Process Rail muestra 28 etapas;
- FL-01..06 confirmadas;
- FL-07 actual;
- seleccionar una etapa navega a su pantalla de negocio.

### Smoke 5 — decisión representativa

Abrir `scr_FL_FailureModes` y verificar:

- FM-03 aparece recomendado;
- selección humana separada de recomendación;
- un override exige motivo;
- Gate permite continuar solo con decisión completa.

### Smoke 6 — cálculo + decisión + gate

Abrir `scr_FL_AMEF` y verificar:

- efectos editables;
- S/O/D y NPR visibles como cálculo del sistema;
- consecuencia recomendada y decisión humana diferenciadas;
- gate AMEF explicable.

Si los seis smokes funcionan, la arquitectura v2 se considera suficientemente validada para continuar correcciones visuales por pantalla sin volver a discutir el modelo de navegación.

## 7. Qué no se considera validado todavía

Hasta ejecutar Studio:

```text
DEFINITION_ACCEPTED          pending para componentes nuevos
INSTANCE_SAFE                pending para componentes nuevos
VISUAL_QA_VALIDATED          pending para nuevas pantallas
READY_FOR_INTEGRATION        no
```

El control estático previo sí ha comprobado:

- sintaxis YAML;
- referencias de pantallas;
- referencias de componentes;
- ausencia de `Label@2.5.1 + Radius*`;
- ausencia de `Classic/Button@2.2.0 + AccessibleLabel`;
- ausencia de la clase conocida de scalars inline con `: `;
- ausencia del patrón que provocó el último TreePro: `GroupContainer` con `Children` dentro de una Gallery.

## 8. Bilingüismo

La v2 mantiene español como idioma visible actual.

Existe catálogo estructural ES/EN (`colFLText`) y la arquitectura no depende del idioma para keys o reglas.

No se activará selector ES/EN hasta migrar todos los textos visibles al catálogo. Esto evita una app parcialmente traducida.

## 9. Backend

El runtime actual utiliza Power Fx y colecciones.

No representa el backend final.

La futura conexión debe sustituir el adapter respetando los contratos de:

```text
AnalysisCase
AnalysisStageExecution
Function
FunctionalFailure
FailureModeSelection
RiskAssessment
RCMAnalysis
SystemRecommendation
HumanDecision
MaintenanceTask
MaintenancePlanPackage
Review / Approval / VersionSnapshot
EffectivenessMeasurement / ChangeRequest
```

La arquitectura está orientada a una futura implementación Azure SQL sin convertir Azure SQL en dependencia del laboratorio.
