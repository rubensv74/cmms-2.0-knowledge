# CMMS 2.0 Functional Lab — Catálogo de componentes premium

**Estado:** foundation alineada  
**Fecha:** 2026-08-10

## 1. Principio

Un componente se crea cuando resuelve una necesidad visual repetible. Las reglas de negocio permanecen en host/runtime y documentación funcional.

## 2. Foundation

| Componente | Propósito | Estado |
|---|---|---|
| `cmp_FL_SidebarPro` | Navegación global | INSTANCE_SAFE PASS |
| `cmp_FL_PageHeaderPro` | Cabecera de objeto/proceso | INSTANCE_SAFE PASS |
| `cmp_FL_TreePro` | Árbol profundo FLH/Taxonomía/ADR | candidato premium / QA pendiente |
| `cmp_FL_ProcessRailPro` | Journey de 28 etapas | PASS_STATIC / Studio pending |
| `cmp_FL_DecisionPanelPro` | Sistema vs decisión humana | PASS_STATIC / Studio pending |
| `cmp_FL_GatePanelPro` | Control de avance explicable | PASS_STATIC / Studio pending |
| `cmp_FL_RiskMatrixPro` | Matriz de riesgo configurable | PASS_STATIC / Studio pending |
| `cmp_FL_LineagePanelPro` | Biblioteca → aplicación → activo → handoff | PASS_STATIC / Studio pending |
| `cmp_FL_ApplicabilityMatrixPro` | Aplicación de una revisión a múltiples activos/perfiles | PASS_STATIC / Studio pending |

## 3. Sidebar y PageHeader

Se conservan sus contratos actuales. El host sigue siendo responsable de navegación, títulos y contexto.

## 4. TreePro

Contrato principal:

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

No se limita estructuralmente a tres niveles.

En ADR el árbol es una **representación visual** de relaciones; la persistencia ADR sigue siendo origen → relación → destino.

## 5. ProcessRailPro

Muestra FL-01…FL-28 sin convertirse en motor de workflow. El host suministra estado, accesibilidad, responsable y navegación.

## 6. DecisionPanelPro

Hace inequívoca la separación:

```text
systemResult
systemRecommendation
humanDecision
reason
requiredRole
```

## 7. GatePanelPro

El término técnico `gate` se mantiene internamente. Para usuario visible se prefiere `Control de avance`, `Requisitos para continuar` o `Estado de la etapa`.

## 8. RiskMatrixPro

No está acoplado a una dimensión fija.

Recibe:

```text
RowScale
ColumnScale
MatrixMode
MatrixCells
```

Para P-101:

```text
RowAxisTitle       Severidad
ColumnAxisTitle    Ocurrencia
RowScale           1..5
ColumnScale        1..5
MatrixMode         PRODUCT
DetectionValue     D separada
RiskScore          NPR calculado por host
```

Regla de lenguaje:

> La matriz S×O se denomina `Matriz de riesgo AMEF`, nunca `criticidad del activo`.

## 9. LineagePanelPro

### Responsabilidad

Hacer visible la procedencia de la información y evitar que el usuario interprete que P-101 es propietario del AMEF.

Presenta:

```text
FmeaDefinition / FmeaRevision
        ↓
FmeaAssetApplication
        ↓
TechnicalObject + AssetCriticality
        ↓
Handoff / ejecución
```

Inputs:

```text
LibraryCode
RevisionCode
ApplicationCode
AssetCode
CriticalityLabel
ExecutionLabel
```

No modifica datos ni decide aplicabilidad.

## 10. ApplicabilityMatrixPro

### Responsabilidad

Mostrar cómo una revisión AMEF se aplica a distintos activos sin duplicar ingeniería.

Contrato `Items`:

```text
AssetCode
AssetName
Criticality
ApplicabilityStatus
ProfileCode
IntervalSummary
ApplicationCode
```

Outputs:

```text
SelectedAssetCodeOut
SelectedApplicationCodeOut
SelectedRecordOut
```

Event:

```text
OnSelectApplication
```

El host calcula reglas, perfiles y overrides.

## 11. Componentes candidatos posteriores

Solo se crearán cuando exista repetición real:

```text
cmp_FL_ObjectSummaryPro
cmp_FL_StatusBadgePro
cmp_FL_EvidenceListPro
cmp_FL_TraceTimelinePro
cmp_FL_ApprovalMatrixPro
cmp_FL_ComparisonTablePro
cmp_FL_TaskCoveragePro
cmp_FL_ExecutionChainPro
```

## 12. Regla de promoción

```text
PASS_STATIC
DEFINITION_ACCEPTED
INSTANCE_SAFE
PUBLIC_CONTRACT_VALIDATED
VISUAL_QA_VALIDATED
READY_FOR_INTEGRATION
```

No se declara seguridad de instancia únicamente por aceptar YAML.
