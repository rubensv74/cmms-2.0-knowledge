# CMMS 2.0 Functional Lab — Instalación canónica y validación integrada

**Estado:** recovery-hardened candidate para Power Apps Studio  
**Rama:** `feature/f01-premium-foundation`  
**Fecha:** 2026-08-11

## 1. Regla principal

La instalación se realiza **exclusivamente desde la rama actual**.

No utilizar commits históricos para reconstruir archivos individuales. No mezclar pantallas y componentes de revisiones distintas.

La secuencia obligatoria es:

```text
25 identidades de pantalla
→ 9 componentes actuales in situ
→ 25 fuentes de pantalla actuales
→ reinicio de sesión / bootstrap
→ smokes integrados
→ Visual QA
```

## 2. Crear primero las 25 identidades de pantalla

Antes de juzgar errores `Navigate(...)`, deben existir en Studio las 25 pantallas canónicas:

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

Si una no existe, crear una `Blank screen` y asignar el nombre exacto. Todavía no es necesario pegar su contenido.

### Gate de dependencias

Después de crear los nombres, abrir Formulas/App Checker.

Un error previo del tipo:

```text
Name isn't valid. 'scr_FL_X'
```

no se considera un fallo de la fórmula si `scr_FL_X` era una pantalla canónica que aún no existía en Studio.

## 3. Actualizar los 9 componentes canónicos

Carpeta:

`power-apps/components/`

Orden:

```text
1 cmp_FL_SidebarPro
2 cmp_FL_PageHeaderPro
3 cmp_FL_TreePro
4 cmp_FL_ProcessRailPro
5 cmp_FL_DecisionPanelPro
6 cmp_FL_GatePanelPro
7 cmp_FL_RiskMatrixPro
8 cmp_FL_LineagePanelPro
9 cmp_FL_ApplicabilityMatrixPro
```

### Identidad

Si el componente ya existe en la app, actualizar **la definición existente in situ**.

No añadir una segunda copia con sufijo. Una definición nueva con identidad distinta no reasocia automáticamente las instancias existentes.

### Foundation visual esperada

```text
Sidebar             dark palette intencional
PageHeader          safe palette + Comfortable
TreePro             HARDENED SAFE PALETTE RC3
ProcessRail         safe palette + texto >=11
DecisionPanel       safe palette + texto >=11
GatePanel           HARDENED SAFE PALETTE RC2
RiskMatrix          Premium 5×5 RC4
LineagePanel        HARDENED SAFE PALETTE RC3 / Height 126
ApplicabilityMatrix HARDENED READABILITY RC2
```

Guardar una vez después de actualizar los nueve y comprobar que no existe un error de definición bloqueante.

## 4. Sustituir las 25 pantallas por su fuente actual

Carpeta:

`power-apps/screens/`

Si una pantalla ya existe, conservar su identidad y sustituir su Source Code por el archivo actual de la rama.

### Lote A — Foundation y Activos

```text
scr_FL_Home
scr_FL_FLH
scr_FL_Taxonomy
scr_FL_ADR
scr_FL_AssetCriticality
scr_FL_Asset360
```

### Lote B — Ingeniería reutilizable

```text
scr_FL_FmeaLibrary
scr_FL_FmeaRevision
scr_FL_AssetApplication
```

### Lote C — AnalysisCase

```text
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
```

### Lote D — Handoff y gobierno

```text
scr_FL_MaintenancePlans
scr_FL_Governance
scr_FL_Settings
```

Guardar una vez al finalizar cada lote. No ejecutar una investigación de fórmula por cada pantalla individual.

## 5. Bootstrap

La autoridad ejecutable de la versión alineada es `scr_FL_Home.OnVisible`, protegida por `varFLAlignedInitialized`.

Existe copia conceptual en:

`runtime/functional-lab-aligned-bootstrap.powerfx`

Después de instalar las 25 fuentes:

1. guardar;
2. cerrar/reabrir Studio o recargar la sesión para limpiar variables;
3. abrir `scr_FL_Home`;
4. dejar que `Home.OnVisible` inicialice el fixture.

No utilizar el antiguo `functional-lab-v2-bootstrap.powerfx`.

## 6. Fixture canónico P-101

```text
FmeaDefinition        AMEF-BOMBA-CENTRIFUGA
FmeaRevision          R01
Application           APP-P101-R01
TechnicalObject       P-101
AssetCriticality      Alta
Profile               HIGH
AnalysisCase          P101-AMEF-RCM-001
S                      4/5
O                      3/5
D                      3/5
S×O                    12
NPR                    36
```

## 7. Smoke 1 — Foundation integrada

Recorrer en una única sesión:

```text
Home
→ FLH
→ Taxonomía
→ ADR
→ Criticidad
→ Ficha 360
→ Biblioteca AMEF
→ Revisión AMEF
→ Aplicación multi-activo
```

Validar:

```text
[ ] ningún Name isn't valid por pantallas canónicas
[ ] ningún componente duplicado con sufijo
[ ] ninguna superficie negra accidental
[ ] Sidebar oscuro únicamente donde corresponde
[ ] P-101 permanece cargado
[ ] TreePro funciona en FLH/Taxonomía/ADR
[ ] criticidad del activo está separada del riesgo AMEF
[ ] R01 se aplica a P-101/P-102/P-103 sin duplicar ingeniería
```

Resultado:

```text
FOUNDATION INTEGRATED PASS
```

## 8. Smoke 2 — AnalysisCase

Abrir Case Overview y confirmar:

- referencia a `FmeaRevision`;
- aplicación activa;
- criticidad utilizada como contexto;
- 28 etapas;
- lineage visible;
- FL-01..06 como revisión/aplicabilidad, no creación silenciosa de nueva ingeniería.

## 9. Smoke 3 — Failure Modes / AMEF

Verificar:

- modo heredado de biblioteca;
- causas visibles;
- recomendación separada de decisión humana;
- `Matriz de riesgo AMEF` 5×5;
- criticidad mostrada por separado;
- S=4, O=3, D=3, S×O=12, NPR=36;
- control de avance explicable.

No rediseñar RiskMatrix durante este smoke.

## 10. Smoke 4 — RCM

Verificar que la pantalla representa respuestas y resultado de una lógica versionable, sin presentar la secuencia concreta como una regla corporativa cerrada.

## 11. Smoke 5 — Task

Comprobar las tres capas:

```text
ProposedMaintenanceTask
TaskProfileVariant
MaintenanceTask
```

Validar intervalo, estado operativo, parada/aislamiento/permiso, duración, crew, H-H y procedimiento opcional.

## 12. Smoke 6 — Plan Package

Verificar `PlanScopeItem`, tags incluidos, restricciones derivadas, H-H y regla de agrupación candidata.

## 13. Smoke 7 — Maintenance Plans

Distinguir visualmente:

```text
MaintenanceTask
MaintenanceProcedure
JobPlan / Route
PreventiveMaintenancePlan
WorkOrder
ExecutionResult
```

Confirmar que la agrupación conserva trazabilidad por `TechnicalObject`.

## 14. Smoke 8 — Trazabilidad / revisión / efectividad

Reconstruir:

```text
Biblioteca
→ Aplicación
→ Decisión
→ Tarea
→ Plan
→ Ejecución
→ Efectividad
```

Confirmar que un resultado real puede desencadenar un cambio de aplicación o una nueva revisión AMEF.

## 15. Visual QA después de la estabilidad funcional

La foundation Comfortable exige:

```text
texto visible mínimo     11
supporting               12
label                    12–13
body                     13–14
card title               15–17
section title            16–18
page title               24–28
button                    12–13
```

Existen pantallas históricas con `Size` 9/10. No se hará un reemplazo masivo ciego: primero se corrige una pantalla de referencia, se comprueba clipping y después se propaga el patrón.

Nunca reducir fuente para evitar scroll.

## 16. Qué NO se cierra todavía por inferencia

- escalas AMEF corporativas;
- umbrales y colores corporativos;
- reglas oficiales de criticidad;
- árbol RCM definitivo;
- P–F/intervalo;
- roles y autoridades finales;
- evidencia mínima;
- sobreclasificación;
- criterios de aprobación;
- KPIs de efectividad;
- reglas definitivas de agrupación;
- sistema destino/integración;
- arquitectura física de datos.

## 17. Niveles de aceptación

```text
PASS_STATIC
DEFINITION_ACCEPTED
INSTANCE_SAFE
PUBLIC_CONTRACT_VALIDATED
VISUAL_QA_VALIDATED
READY_FOR_INTEGRATION
```

`PASS_STATIC` nunca implica `INSTANCE_SAFE`. Power Apps Studio y App Checker siguen siendo la autoridad de runtime.

## 18. Runbook operativo

Para la ejecución de mañana seguir:

`../development/TOMORROW_RUNBOOK_2026-08-12.md`
