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
| `cmp_FL_ProcessRailPro` | Journey de 28 etapas | PASS_STATIC / Studio pending |
| `cmp_FL_DecisionPanelPro` | Diferenciar sistema/recomendación/decisión humana | PASS_STATIC / Studio pending |
| `cmp_FL_GatePanelPro` | Control de avance explicable y acción necesaria | PASS_STATIC / Studio pending |
| `cmp_FL_RiskMatrixPro` | Matriz de riesgo configurable | PASS_STATIC / Studio pending |

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

Se reutiliza como cabecera contextual. No debe mostrar siempre journey; en pantallas de Activos puede representar objeto actual, contexto, estado de datos e indicador de fuente.

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

No se limita estructuralmente a 3 niveles. Debe permitir profundidad variable y reutilización en FLH, Taxonomía y ADR.

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

### Outputs

```text
SelectedStageIdOut
SelectedScreenKeyOut
SelectedRecordOut
```

### Event

```text
OnSelectStage
```

El host decide navegación y reglas de avance.

## 7. cmp_FL_DecisionPanelPro

### Responsabilidad

Hacer inequívoca la separación entre lo que sabe/calcula/recomienda el sistema y lo que debe decidir una persona.

### Contrato conceptual

```text
systemResult
systemRecommendation
humanDecision
reason
requiredRole
```

Los eventos de confirmación y override permanecen gobernados por el host.

## 8. cmp_FL_GatePanelPro

### Responsabilidad

Evitar controles de avance invisibles o simples botones deshabilitados.

Debe mostrar:

```text
status
summary
reason
requiredAction
responsibleRole
output
```

El término visible para usuario puede ser `Control de avance`, `Estado de la etapa` o equivalente; `Gate` permanece como término técnico interno.

## 9. cmp_FL_RiskMatrixPro

### Responsabilidad

Representar una matriz de riesgo sin acoplarla a una dimensión fija ni a una única metodología.

### Escalas

El componente recibe dos tablas:

```text
RowScale
ColumnScale
```

Cada una contiene:

```text
ScaleIndex
ScaleLabel
ScaleScore
```

La dimensión se deriva de `CountRows(RowScale) × CountRows(ColumnScale)`.

Ejemplos válidos:

```text
10×10
5×5
4×5
categorías con score numérico subyacente
```

### Modos de cálculo

`MatrixMode="PRODUCT"`

```text
CellScore = RowScore × ColumnScore
```

`MatrixMode="CONFIGURED"`

El host suministra `MatrixCells`:

```text
RowIndex
ColumnIndex
CellScore
BandKey
```

Esto permite reproducir matrices corporativas donde cada celda tenga un resultado explícito.

### Compatibilidad AMEF

Para P-101:

```text
RowAxisTitle       Severidad
ColumnAxisTitle    Ocurrencia
RowScale           1..10
ColumnScale        1..10
MatrixMode         PRODUCT
DetectionValue     D separada
RiskScore          NPR calculado por host
```

Los outputs `SelectedSeverityOut` y `SelectedOccurrenceOut` se conservan para no romper `scr_FL_AMEF`.

Además expone:

```text
SelectedRowLabelOut
SelectedColumnLabelOut
MatrixScoreOut
MatrixBandOut
```

### Regla arquitectónica

`10×10` es configuración del caso P-101, no una regla universal de CMMS 2.0.

## 10. Componentes candidatos posteriores

```text
cmp_FL_ObjectSummaryPro
cmp_FL_StatusBadgePro
cmp_FL_EvidenceListPro
cmp_FL_TraceTimelinePro
cmp_FL_ApprovalMatrixPro
cmp_FL_ComparisonTablePro
```

Se crearán solo cuando aparezca repetición real en dos o más pantallas.

## 11. Regla de promoción

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
