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

El contrato actual se conserva. El host suministra los módulos:

```text
Home        Inicio
Assets      Activos
Strategy    Estrategia de mantenimiento
Plans       Planes de mantenimiento
Governance  Gobernanza
Settings    Configuración
```

## 4. cmp_FL_PageHeaderPro

Cabecera contextual reutilizable para objeto, caso y proceso.

## 5. cmp_FL_TreePro

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

No se limita estructuralmente a tres niveles y se reutiliza en FLH, Taxonomía y ADR.

## 6. cmp_FL_ProcessRailPro

Muestra las 28 etapas sin convertirse en motor de workflow. El host decide navegación, accesibilidad y reglas de avance.

## 7. cmp_FL_DecisionPanelPro

Hace inequívoca la separación:

```text
systemResult
systemRecommendation
humanDecision
reason
requiredRole
```

## 8. cmp_FL_GatePanelPro

Representa de forma explícita:

```text
status
summary
reason
requiredAction
responsibleRole
output
```

En interfaz puede mostrarse como `Control de avance`, `Estado de la etapa` o expresión equivalente; `Gate` queda como término técnico interno.

## 9. cmp_FL_RiskMatrixPro

### Responsabilidad

Representar una matriz de riesgo sin acoplarla a una dimensión fija ni a una única metodología.

### Escalas

Recibe:

```text
RowScale
ColumnScale
```

Cada escala contiene:

```text
ScaleIndex
ScaleLabel
ScaleScore
```

La dimensión real se deriva de:

```text
CountRows(RowScale) × CountRows(ColumnScale)
```

Ejemplos soportados:

```text
5×5
10×10
4×5
categorías con score numérico subyacente
```

### Modos

`MatrixMode="PRODUCT"`

```text
CellScore = RowScore × ColumnScore
```

`MatrixMode="CONFIGURED"`

El host suministra:

```text
RowIndex
ColumnIndex
CellScore
BandKey
```

### Configuración canónica P-101

El Functional Lab utiliza la escala ya empleada en los prototipos AMEF:

```text
RowAxisTitle       Severidad
ColumnAxisTitle    Ocurrencia
RowScale           1..5
ColumnScale        1..5
MatrixMode         PRODUCT
DetectionValue     1..5, separada
RiskScore          NPR calculado por host
```

Valores iniciales:

```text
S=4
O=3
D=3
S×O=12
NPR=36
```

Los outputs `SelectedSeverityOut` y `SelectedOccurrenceOut` se conservan para AMEF. También se exponen:

```text
SelectedRowLabelOut
SelectedColumnLabelOut
MatrixScoreOut
MatrixBandOut
```

### Regla arquitectónica

**5×5 es la configuración actual de P-101 porque mantiene continuidad con los prototipos revisados. No es una limitación del componente.**

Una futura configuración corporativa podrá adoptar otra dimensión, categorías u otra distribución de celdas sin reconstruir `RiskMatrixPro`.

## 10. Componentes candidatos posteriores

```text
cmp_FL_ObjectSummaryPro
cmp_FL_StatusBadgePro
cmp_FL_EvidenceListPro
cmp_FL_TraceTimelinePro
cmp_FL_ApprovalMatrixPro
cmp_FL_ComparisonTablePro
```

Se crearán cuando aparezca repetición real en dos o más pantallas.

## 11. Regla de promoción

```text
PASS_STATIC
DEFINITION_ACCEPTED
INSTANCE_SAFE
PUBLIC_CONTRACT_VALIDATED
VISUAL_QA_VALIDATED
READY_FOR_INTEGRATION
```

La Component Library se aborda cuando varios componentes hayan alcanzado `READY_FOR_INTEGRATION`.
