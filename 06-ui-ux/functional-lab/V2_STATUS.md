# CMMS 2.0 Functional Lab — Estado canónico v2

**Fecha:** 2026-08-10  
**Rama:** `feature/f01-premium-foundation`  
**Estado global:** Architecture v2 generated / `PASS_STATIC` / Studio integrated QA pending

## 1. Qué es canónico desde ahora

La arquitectura v2 sustituye como dirección de producto al modelo v1 de un único `WorkspaceShell` con nueve workspaces agrupados.

La evidencia v1 se conserva porque validó correctamente:

- Sidebar;
- PageHeader;
- App Shell;
- Runtime P-101;
- WS-01 contexto;
- WS-02 funciones/fallos;
- TreePro profundo.

Pero **no se añadirá funcionalidad nueva al WorkspaceShell v1**.

## 2. Decisiones cerradas

```text
Identidad             CMMS 2.0 Functional Lab
Shell                  módulos reales de producto
Journey                28 etapas visibles mediante Process Rail
Pantallas              por objeto / trabajo de negocio
Navegación             guiada + consulta experta
FLH/Taxonomía/ADR      tres pantallas separadas
Caso                   AnalysisCase; P-101 es fixture inicial
Maestro                solo lectura durante análisis
Persistencia UX        draft ordinario + confirmación explícita
Roles                  5 roles iniciales
Colaboración            multirrol
Dispositivos            desktop + tablet
Idioma                  español actual, ES/EN-ready
Backend                 Azure SQL-oriented, adapter boundary
Componentes             reutilizables / future Component Library
Autoridad               humano salvo automatización aprobada
IA                      recomendación explicable, no autoridad implícita
```

Los ADR viven en `adr/`.

## 3. Foundation de componentes

| Componente | Estado |
|---|---|
| `cmp_FL_SidebarPro` | INSTANCE_SAFE PASS, v2 reutiliza contrato |
| `cmp_FL_PageHeaderPro` | INSTANCE_SAFE PASS, v2 reutiliza contrato |
| `cmp_FL_TreePro` | motor profundo cargado; premium candidate corregido; QA visual final pendiente |
| `cmp_FL_ProcessRailPro` | PASS_STATIC / Studio pending |
| `cmp_FL_DecisionPanelPro` | PASS_STATIC / Studio pending |
| `cmp_FL_GatePanelPro` | PASS_STATIC / Studio pending |
| `cmp_FL_RiskMatrixPro` | PASS_STATIC / Studio pending |

`cmp_FL_RiskMatrixPro` representa una matriz S×O de 10×10, permite seleccionar Severidad y Ocurrencia, muestra Detección de forma separada y recibe desde el host los umbrales que determinan las bandas de criticidad. La configuración demostrativa del laboratorio no constituye todavía una escala corporativa aprobada.

## 4. Pantallas v2 generadas

### Inicio

- `scr_FL_Home`

### Activos

- `scr_FL_FLH`
- `scr_FL_Taxonomy`
- `scr_FL_ADR`
- `scr_FL_Asset360`

### Estrategia de mantenimiento

- `scr_FL_AnalysisRegister`
- `scr_FL_CaseOverview`
- `scr_FL_Context`
- `scr_FL_Functions`
- `scr_FL_FailureModes`
- `scr_FL_AMEF`
- `scr_FL_RCM`
- `scr_FL_Economics`
- `scr_FL_Task`
- `scr_FL_PlanPackage`
- `scr_FL_Traceability`
- `scr_FL_ReviewApproval`
- `scr_FL_Effectiveness`

### Shell de producto

- `scr_FL_MaintenancePlans`
- `scr_FL_Governance`
- `scr_FL_Settings`

**Total: 21 pantallas canónicas.**

## 5. Cobertura FL-01…FL-28

```text
FL-01..03   Context
FL-04..05   Functions
FL-06       FailureModes
FL-07..11   AMEF
FL-12..16   RCM
FL-17       Economics
FL-18..19   Task
FL-20..22   PlanPackage
FL-23..24   Traceability
FL-25..26   ReviewApproval
FL-27..28   Effectiveness
```

No se ha eliminado ninguna etapa para ahorrar pantallas.

### FL-09 — criticidad y NPR

La pantalla `scr_FL_AMEF` distingue ahora explícitamente:

```text
Severidad + Ocurrencia
        ↓
Matriz visual S×O
        ↓
banda de criticidad

Severidad × Ocurrencia × Detección
        ↓
NPR calculado por el sistema
```

La matriz y el NPR son representaciones relacionadas, pero no se presentan como el mismo indicador.

## 6. Runtime v2

`power-apps/runtime/functional-lab-v2-bootstrap.powerfx`

El runtime usa colecciones y variables solamente como adapter del laboratorio. La UI se ha diseñado alrededor de contratos persistentes:

```text
TechnicalObject
AssetHierarchyNode
AssetClassification
ADRRelation
AnalysisCase
AnalysisStageExecution
Evidence
Function
FunctionalFailure
FailureModeSelection
FailureEffect
RiskAssessment
RCMAnalysis
SystemRecommendation
HumanDecision
EconomicAssessment
MaintenanceStrategy
MaintenanceTask
IntervalJustification
ResourceRequirement
MaintenancePlanPackage
TraceLink
QualityFinding
Review
Approval
VersionSnapshot
EffectivenessMeasurement
ChangeRequest
AuditEvent
```

## 7. Estado P-101 de arranque

La v2 conserva la validación funcional ya obtenida:

```text
FL-01..FL-06   confirmed
FL-07          draft / current
FL-08..FL-28   not_started
```

Esto no fuerza al usuario a repetir WS-01/WS-02 para entrar en AMEF, aunque las pantallas reconstruidas permanecen disponibles y editables como draft.

## 8. Responsabilidad visual

La v2 utiliza una gramática explícita:

```text
Slate / neutral     dato maestro / referencia
Cyan / blue         cálculo o información del sistema
Purple              autoridad / decisión humana
Amber / orange      advertencia / override / excepción
Red                 bloqueo / error
Green               confirmado / aprobado / gate superado
```

`DecisionPanelPro` separa:

```text
systemResult
systemRecommendation
humanDecision
reason
requiredRole
```

`GatePanelPro` separa:

```text
status
reason
requiredAction
responsibleRole
output
```

`RiskMatrixPro` separa:

```text
human severity / occurrence selection
matrix position and band
human detection value
system NPR calculation
critical override information
```

## 9. Validación estática

`development/V2_STATIC_VALIDATION_2026-08-10.md`

Resultado base:

```text
PASS_STATIC
```

El incremento RiskMatrix se validó además con parser YAML antes de publicar tanto el componente como la pantalla AMEF de sustitución. Esto NO sustituye Studio.

## 10. Gate actual

Ejecutar `power-apps/V2_INSTALLATION.md`.

La validación se hace mediante seis smoke tests representativos, no 21 pruebas aisladas:

```text
1 Foundation components
2 Home / product shell
3 FLH / TreePro
4 CaseOverview / ProcessRail
5 FailureModes / DecisionPanel
6 AMEF / RiskMatrix + calculation + decision + gate
```

Si estos seis pasan, se considera validado el esqueleto de arquitectura v2 y se continúa con Visual QA y correcciones funcionales por pantalla.

## 11. Definición de terminado para esta reconstrucción

La reconstrucción arquitectónica se considera terminada cuando:

- decisiones y ADR están versionados;
- mapa de pantallas existe;
- contratos de dominio existen;
- siete componentes Foundation existen;
- 21 pantallas están generadas;
- runtime v2 está generado;
- PASS_STATIC completado;
- instalación y smoke plan están documentados.

**Todos estos puntos están completados.**

Lo único pendiente antes de declarar `INSTANCE_SAFE / VISUAL_QA` para v2 es la validación integrada en Power Apps Studio.
