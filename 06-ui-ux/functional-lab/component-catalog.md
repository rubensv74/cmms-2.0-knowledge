# CMMS 2.0 Functional Lab — Catálogo de componentes premium

**Estado:** foundation v2  
**Fecha:** 2026-08-10

## 1. Principio

Un componente se crea cuando resuelve una necesidad repetible y visual. Las reglas de negocio permanecen en host/runtime y documentación funcional.

## 2. Foundation

| Componente | Propósito | Estado |
|---|---|---|
| `cmp_FL_SidebarPro` | Navegación global de producto | Validado / reutilizar con nuevo dataset |
| `cmp_FL_PageHeaderPro` | Cabecera de objeto/proceso | Validado / adaptar contenidos desde host |
| `cmp_FL_TreePro` | Árbol jerárquico profundo | Candidato premium en QA |
| `cmp_FL_ProcessRailPro` | Journey de 28 etapas | Nuevo requerido |
| `cmp_FL_DecisionPanelPro` | Diferenciar sistema/recomendación/decisión humana | Nuevo requerido |
| `cmp_FL_GatePanelPro` | Gate explicable y acción necesaria | Nuevo requerido |

## 3. cmp_FL_SidebarPro

El contrato actual se conserva. Cambia el `NavItems` suministrado por el host:

```text
Home        Inicio
Assets      Activos
Strategy    Estrategia de mantenimiento
Plans       Planes de mantenimiento
Governance  Gobernanza
Settings    Configuración
```

Los keys permanecen técnicos e independientes del idioma.

## 4. cmp_FL_PageHeaderPro

Se reutiliza como cabecera contextual. No debe mostrar siempre journey; en pantallas de Activos puede representar:

- objeto actual;
- contexto;
- estado de datos;
- indicador de fuente.

En pantallas de `AnalysisCase` muestra caso, estado, posición del journey y review state.

## 5. cmp_FL_TreePro

Contrato de datos principal:

```text
RowNodeId
RowParentNodeId
RowLevel
RowLabel
RowDescription
RowSortPath
RowPath
RowNodeType
RowIconKey
RowHasChildren
RowIsExpanded
RowIsVisible
```

No se limita estructuralmente a 3 niveles. Debe permitir profundidad variable y reutilización en:

- FLH;
- Taxonomía;
- ADR.

## 6. cmp_FL_ProcessRailPro

### Responsabilidad

Mostrar las 28 etapas sin convertirse en motor de workflow.

### Input Items

```text
StageOrder
StageId
PhaseId
PhaseLabel
StageLabel
Status
ResponsibilityType
ResponsibleRole
ScreenKey
IsCurrent
IsAccessible
HasWarning
```

### Inputs adicionales

```text
ActiveStageId Text
CompactMode Boolean
ShowPhaseHeaders Boolean
AccentColor Color
SurfaceColor Color
BorderColor Color
TextColor Color
MutedTextColor Color
```

### Outputs

```text
SelectedStageIdOut Text
SelectedScreenKeyOut Text
SelectedRecordOut Record
```

### Event

```text
OnSelectStage
```

El host decide `Navigate(...)` o cambio de sección.

## 7. cmp_FL_DecisionPanelPro

### Responsabilidad

Hacer inequívoca la separación entre lo que sabe/calcula/recomienda el sistema y lo que debe decidir una persona.

### Inputs

```text
Title
ContextText
SystemResultLabel
SystemResultValue
RecommendationLabel
RecommendationValue
RecommendationExplanation
RequiredRole
DecisionState
HumanDecisionValue
DecisionReason
IsOverride
ShowSystemResult
ShowRecommendation
ShowDecision
```

### Outputs/Event

```text
SelectedDecisionOut
OnConfirmDecision
OnOverrideDecision
```

El primer contrato puede ser deliberadamente simple y host-driven.

## 8. cmp_FL_GatePanelPro

### Responsabilidad

Evitar gates invisibles o simples botones deshabilitados.

### Inputs

```text
GateTitle
GateStatus        passed | warning | blocked
Summary
Reason
RequiredAction
ResponsibleRole
OutputLabel
CanContinue
ContinueLabel
```

### Event

```text
OnContinue
```

## 9. Componentes candidatos posteriores

No bloquear Foundation por ellos:

```text
cmp_FL_ObjectSummaryPro
cmp_FL_StatusBadgePro
cmp_FL_EvidenceListPro
cmp_FL_TraceTimelinePro
cmp_FL_ApprovalMatrixPro
cmp_FL_ComparisonTablePro
```

Se crearán solo cuando aparezca repetición real en dos o más pantallas.

## 10. Regla de promoción

Para promocionar un componente a activo reusable:

```text
PASS_STATIC
DEFINITION_ACCEPTED
INSTANCE_SAFE
PUBLIC_CONTRACT_VALIDATED
VISUAL_QA_VALIDATED
READY_FOR_INTEGRATION
```

La Component Library se aborda cuando varios componentes hayan alcanzado `READY_FOR_INTEGRATION`; no se usa como sustituto de la validación en la app activa.
