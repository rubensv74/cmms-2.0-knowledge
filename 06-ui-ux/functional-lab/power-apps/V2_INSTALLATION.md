# CMMS 2.0 Functional Lab — Instalación arquitectura v2

**Estado:** candidato para validación integrada en Power Apps Studio  
**Rama:** `feature/f01-premium-foundation`

## 1. Objetivo

Instalar la arquitectura v2 como una aplicación coherente, evitando validar 21 pantallas una por una.

La arquitectura v2 utiliza navegación de producto, pantallas por objeto/proceso real, Process Rail FL-01…FL-28, decisiones explícitas y controles de avance explicables.

## 2. Componentes requeridos

Crear o sustituir primero estos siete componentes con su Source Code completo:

1. `components/cmp_FL_SidebarPro.pa.yaml`
2. `components/cmp_FL_PageHeaderPro.pa.yaml`
3. `components/cmp_FL_TreePro.pa.yaml`
4. `components/cmp_FL_ProcessRailPro.pa.yaml`
5. `components/cmp_FL_DecisionPanelPro.pa.yaml`
6. `components/cmp_FL_GatePanelPro.pa.yaml`
7. `components/cmp_FL_RiskMatrixPro.pa.yaml`

No insertar pantallas que los consuman hasta que las siete definiciones estén guardadas en la app.

## 3. Crear primero las 21 pantallas vacías

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

Esto permite que todas las fórmulas `Navigate(...)` resuelvan los nombres de pantalla.

## 4. Orden recomendado

### Lote A — arranque

`scr_FL_Home.pa.yaml`

Abrir Home una vez para inicializar el runtime v2.

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

## 5. Estado inicial de P-101

```text
FL-01..FL-06   confirmed
FL-07          draft / current
FL-08..FL-28   not_started
```

El runtime conserva la valoración AMEF del prototipo:

```text
Severidad     4/5
Ocurrencia    3/5
Detección     3/5
S×O           12
NPR           36
```

## 6. Validación integrada

### Smoke 1 — Foundation

Guardar los siete componentes e insertar de forma aislada los cuatro componentes nuevos de arquitectura v2:

- `cmp_FL_ProcessRailPro`
- `cmp_FL_DecisionPanelPro`
- `cmp_FL_GatePanelPro`
- `cmp_FL_RiskMatrixPro`

Studio debe permanecer estable.

### Smoke 2 — Shell

Abrir `scr_FL_Home` y comprobar navegación, caso P-101 y accesos a FLH, Taxonomía y ADR.

### Smoke 3 — Activos

Abrir `scr_FL_FLH` y comprobar TreePro, P-101 resaltado, búsqueda, selección, expandir/contraer y navegación entre vistas de Activos.

### Smoke 4 — AnalysisCase

Abrir `scr_FL_CaseOverview` y comprobar 28 etapas, FL-01..06 confirmadas, FL-07 actual y navegación desde Process Rail.

### Smoke 5 — Decisión

Abrir `scr_FL_FailureModes` y comprobar recomendación FM-03, decisión humana separada, override con motivo y control de avance.

### Smoke 6 — AMEF completo con matriz

Abrir `scr_FL_AMEF` y comprobar en un único recorrido:

1. los tres efectos son editables;
2. la matriz representa **Severidad × Ocurrencia en escala 1–5**;
3. existen **25 celdas (5×5)**;
4. la celda inicial corresponde a `S=4`, `O=3` y `S×O=12`;
5. seleccionar otra celda actualiza S y O;
6. Detección se mantiene separada y editable entre 1 y 5;
7. el NPR se recalcula como `S × O × D`, con valor inicial 36;
8. la banda visual se muestra separada del NPR;
9. recomendación de consecuencia y decisión humana permanecen diferenciadas;
10. `GatePanelPro` explica qué falta y permite continuar a RCM cuando el AMEF está completo.

Bandas visuales provisionales del laboratorio:

```text
Bajo       S×O <= 5
Moderado   S×O <= 10
Alto       S×O <= 15
Crítico    S×O > 15
```

Estas bandas **no son una regla corporativa aprobada**. El componente permite sustituirlas sin reconstrucción.

Si los seis smokes pasan, la arquitectura v2 queda suficientemente validada para Visual QA por pantalla.

## 7. Qué no se considera validado todavía

Hasta ejecutar Studio:

```text
DEFINITION_ACCEPTED          pending para componentes nuevos
INSTANCE_SAFE                pending para componentes nuevos
VISUAL_QA_VALIDATED          pending para nuevas pantallas
READY_FOR_INTEGRATION        no
```

El control estático previo comprueba sintaxis YAML, referencias de pantallas/componentes y las incompatibilidades Source Code ya documentadas.

## 8. Bilingüismo

La v2 mantiene español como idioma visible actual y estructura preparada para ES/EN.

## 9. Backend

El runtime actual utiliza Power Fx y colecciones como adapter del laboratorio. La futura persistencia deberá respetar los contratos de dominio documentados y puede orientarse a Azure SQL sin convertirlo en dependencia del prototipo.
