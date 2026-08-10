# CMMS 2.0 Functional Lab — Estado canónico v2

**Fecha:** 2026-08-10  
**Rama:** `feature/f01-premium-foundation`  
**Estado global:** Architecture v2 generated / `PASS_STATIC` / Studio integrated QA pending

## 1. Qué es canónico desde ahora

La arquitectura v2 sustituye como dirección de producto al modelo v1 de un único `WorkspaceShell` con nueve workspaces agrupados.

La evidencia v1 se conserva porque validó correctamente Sidebar, PageHeader, App Shell, Runtime P-101, WS-01, WS-02 y el motor profundo de TreePro.

No se añadirá funcionalidad nueva al WorkspaceShell v1.

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

## 3. Foundation de componentes

| Componente | Estado |
|---|---|
| `cmp_FL_SidebarPro` | INSTANCE_SAFE PASS |
| `cmp_FL_PageHeaderPro` | INSTANCE_SAFE PASS |
| `cmp_FL_TreePro` | motor profundo cargado; QA visual final pendiente |
| `cmp_FL_ProcessRailPro` | PASS_STATIC / Studio pending |
| `cmp_FL_DecisionPanelPro` | PASS_STATIC / Studio pending |
| `cmp_FL_GatePanelPro` | PASS_STATIC / Studio pending |
| `cmp_FL_RiskMatrixPro` | PASS_STATIC / Studio pending |

`cmp_FL_RiskMatrixPro` es dimensionalmente configurable. No impone 5×5 ni 10×10.

**Configuración canónica actual de P-101:**

```text
Severidad     1..5
Ocurrencia    1..5
Matriz        5×5 = 25 celdas
Detección     1..5, separada de la matriz
S inicial     4
O inicial     3
D inicial     3
S×O inicial  12
NPR inicial   36
```

La escala 1–5 procede del modelo ya utilizado en los prototipos AMEF. Los umbrales de color siguen siendo demostrativos y pendientes de validación corporativa.

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

La pantalla `scr_FL_AMEF` distingue:

```text
Selección humana S + O (1..5)
        ↓
Matriz visual 5×5 S×O
        ↓
score de matriz y banda visual

Valoración humana D (1..5)
        ↓
S × O × D
        ↓
NPR calculado por el sistema
```

La matriz S×O y el NPR están relacionados, pero no son el mismo indicador.

## 6. Runtime v2

`power-apps/runtime/functional-lab-v2-bootstrap.powerfx`

El runtime conserva los valores AMEF originales del prototipo P-101:

```text
Set(varFLSeverity,4)
Set(varFLOccurrence,3)
Set(varFLDetection,3)
NPR = 36
```

Las colecciones y variables actúan como adapter del laboratorio. La UI está orientada a contratos persistentes para una futura conexión de datos.

## 7. Estado P-101 de arranque

```text
FL-01..FL-06   confirmed
FL-07          draft / current
FL-08..FL-28   not_started
```

## 8. Responsabilidad visual

```text
Slate / neutral     dato maestro / referencia
Cyan / blue         cálculo o información del sistema
Purple              autoridad / decisión humana
Amber / orange      advertencia / override / excepción
Red                 bloqueo / error
Green               confirmado / aprobado / control superado
```

`DecisionPanelPro` separa resultado/recomendación del sistema de decisión humana.

`GatePanelPro` separa estado, motivo, acción requerida, responsable y output.

`RiskMatrixPro` separa selección humana S/O, posición y banda de matriz, valor humano D y NPR calculado por software.

## 9. Validación estática

Resultado actual:

```text
PASS_STATIC
```

La sustitución de `scr_FL_AMEF` por la configuración 5×5 se validó con parser YAML antes de publicarse. Esto no sustituye Power Apps Studio.

## 10. Gate actual

Ejecutar `power-apps/V2_INSTALLATION.md`.

Los seis smoke tests representativos son:

```text
1 Foundation components
2 Home / product shell
3 FLH / TreePro
4 CaseOverview / ProcessRail
5 FailureModes / DecisionPanel
6 AMEF / RiskMatrix 5×5 + NPR + decision + GatePanel
```

## 11. Definición de terminado de la reconstrucción

Completados:

- decisiones y ADR versionados;
- mapa de pantallas;
- contratos de dominio;
- siete componentes Foundation;
- 21 pantallas;
- runtime v2;
- PASS_STATIC;
- instalación y smoke plan.

Pendiente para declarar `INSTANCE_SAFE / VISUAL_QA`: validación integrada en Power Apps Studio.
