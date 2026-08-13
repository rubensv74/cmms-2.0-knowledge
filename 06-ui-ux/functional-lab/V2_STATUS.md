# CMMS 2.0 Functional Lab — Estado canónico tras auditoría y adopción modular

**Fecha:** 2026-08-11  
**Rama:** `feature/f01-premium-foundation`  
**Playbook obligatorio:** `functional-engineering-knowledge-base/30-playbooks/power-platform/modular-power-apps-screen-construction.md`

## Estado global

```text
Arquitectura funcional D-01…D-14       ALINEADA
9 componentes canónicos                FUENTES PUBLICADAS
25 pantallas funcionales               FUENTES PUBLICADAS
Playbook modular S/C/I/FIX              ADOPTADO
Freeze register                         PUBLICADO
Design System Lab                       DS-S01 PREPARADO / Studio pendiente
Color foundation                        PENDING
Visual QA final                         PENDIENTE STUDIO
READY_FOR_INTEGRATION global            NO
```

## Regla de construcción vigente

Ya no se utiliza el patrón:

```text
actualizar 9 componentes
→ pegar 25 pantallas por lotes
→ validar al final
```

La estrategia vigente es:

```text
SKELETON
→ PLACEHOLDER CONTRATADO
→ BLOCK S / C / I
→ PEGAR EN POWER APPS STUDIO
→ VALIDAR
→ FREEZE
→ SIGUIENTE BLOQUE
```

Un fallo se repara mediante `FIX` del mismo incremento.

Power Apps Studio es la autoridad de implementación/runtime. GitHub conserva las fuentes y la documentación, pero no sustituye el gate Studio.

## Modelo funcional canónico

```text
FmeaDefinition → FmeaRevision
        ↓
TechnicalObject + FLH + Taxonomía + ADR + AssetCriticalityAssessment
        ↓
FmeaAssetApplication + perfil + variantes + overrides
        ↓
AnalysisCase + 28 etapas + AMEF + RCM
        ↓
MaintenanceTask + intervalo + recursos + procedimiento opcional
        ↓
PlanScopeItem → JobPlan/Route → PM → WorkOrder → ExecutionResult
        ↓
coste real + efectividad + mejora de aplicación o biblioteca
```

P-101 consume una revisión reusable de ingeniería y no posee el AMEF.

## Evidencia Studio que se conserva

Evidencia funcional previa:

```text
HOME OK
ACTIVOS OK
BIBLIOTECA AMEF OK
APLICACIÓN MULTI-ACTIVO OK
```

Evidencia de recuperación:

```text
HOME BASELINE PASS
FLH PASS
TAXONOMÍA PASS
ADR PASS
```

Esta evidencia permite congelar intención, geometría y comportamiento realmente aprobados. No autoriza a reinstalar versiones históricas ni a promover una revisión de componente modificada después sin revalidarla.

## Diagnóstico de la regresión

### Grafo parcial

Numerosos `Name isn't valid. 'scr_FL_...'` correspondían a destinos canónicos que existían en el repositorio pero no todavía como objetos de Studio.

Corrección operativa:

```text
crear las identidades faltantes como Blank screen
→ reevaluar App Checker
```

Esto resuelve dependencias de nombre sin obligar a pegar pantallas completas.

### Color

El rollback histórico reintrodujo componentes cuyo render dependía de Inputs `Color` que ya habían coincidido con superficies negras inesperadas.

La causa interna exacta de Power Apps no se declara demostrada.

El cambio metodológico es más importante que el workaround puntual:

```text
STRUCTURE       puede quedar FROZEN
BEHAVIOR        puede quedar FROZEN
DATA CONTRACT   puede quedar FROZEN
COLOR           puede permanecer PENDING
```

Las dudas cromáticas se validan primero en `scr_DesignSystemLab` mediante roles/tokens compartidos.

## Componentes — estado de fuente

```text
cmp_FL_SidebarPro              evidencia positiva previa; no tocar sin fallo real
cmp_FL_PageHeaderPro           evidencia positiva previa; no tocar sin fallo real
cmp_FL_TreePro                 HARDENED SAFE PALETTE RC3 / Studio retest pendiente
cmp_FL_ProcessRailPro          SOURCE revisado / Studio pendiente
cmp_FL_DecisionPanelPro        SOURCE revisado / Studio pendiente
cmp_FL_GatePanelPro            HARDENED SAFE PALETTE RC2 / Studio retest pendiente
cmp_FL_RiskMatrixPro           Premium 5×5 RC4 / Studio QA pendiente
cmp_FL_LineagePanelPro         HARDENED SAFE PALETTE RC3 / Studio retest pendiente
cmp_FL_ApplicabilityMatrixPro  HARDENED READABILITY RC2 / Studio retest pendiente
```

Ninguna revisión modificada esta noche se declara `INSTANCE_SAFE` sin prueba real en Studio.

Escalera:

```text
SOURCE_VALID
→ COMPONENT_DEFINITION_ACCEPTED
→ INSTANCE_SAFE
→ PUBLIC_CONTRACT_VALIDATED
→ VISUAL_QA_VALIDATED
→ READY_FOR_INTEGRATION
```

## Freeze actual por áreas

### Home

```text
GEOMETRY       FROZEN
BOOTSTRAP      FROZEN
NAVIGATION     FUNCTIONAL_FROZEN
COLOR          PENDING
```

No reconstruir Home. Solo bloque explícito sobre el slot afectado.

### FLH / Taxonomía / ADR

```text
GEOMETRY       FROZEN
FUNCTIONAL     evidencia positiva previa
TREE RC3       REVALIDATION REQUIRED
COLOR          PENDING
```

### Biblioteca / Revisión / Aplicación

```text
FUNCTIONAL INTENT   FROZEN
DATA MODEL          FROZEN
APPLICABILITY RC2   REVALIDATION REQUIRED
COLOR               PENDING
```

### AMEF

```text
STATUS         IN_CONSTRUCTION
STRUCTURE      OPEN
BEHAVIOR       OPEN
COLOR          PENDING
```

AMEF no se recupera pegando otra pantalla monolítica. Debe construirse `skeleton first` y sustituir placeholders mediante bloques C/I validados.

## Design System Lab

Utility screen técnica:

```text
scr_DesignSystemLab
```

No forma parte de las 25 pantallas funcionales ni de la navegación del producto.

Primer bloque preparado:

```text
DS-S01 — skeleton + placeholders
```

Después de validarlo en Studio se congela la geometría y solo entonces se preparan:

```text
DS-C01 semantic token roles
DS-C02 Classic + Modern controls
DS-C03 interaction states
DS-C04 data visualisation
```

No se genera el siguiente bloque antes de validar el anterior.

## AMEF — fixture protegido

```text
S=4/5
O=3/5
D=3/5
S×O=12
NPR=36
```

`cmp_FL_RiskMatrixPro` mantiene el patrón premium 5×5 y no se rediseña durante la integración.

La criticidad del activo permanece separada del riesgo AMEF.

## Deuda visual controlada

Persisten pantallas de fuente histórica con `Size` 9/10. No se hará un reemplazo global ciego.

Baseline:

```text
mínimo visible 11
supporting     12
body           13–14
section title  16–18
page title     24–28
button         12–13
```

La tipografía se corrige mediante bloques visuales acotados, preservando estructura/comportamiento congelados.

## Documentos canónicos

```text
Playbook central
functional-engineering-knowledge-base/30-playbooks/power-platform/modular-power-apps-screen-construction.md

Auditoría
06-ui-ux/functional-lab/development/RECOVERY_HARDENING_AUDIT_2026-08-11.md

Freeze register
06-ui-ux/functional-lab/development/FREEZE_REGISTER_2026-08-11.md

Runbook
06-ui-ux/functional-lab/development/TOMORROW_RUNBOOK_2026-08-12.md

Compatibilidad
06-ui-ux/functional-lab/development/compatibility.md

Design System Lab
06-ui-ux/functional-lab/power-apps/labs/design-system/
```

`RECOVERY_BASELINE_R0.md` queda `SUPERSEDED` y solo se conserva como evidencia forense.

## Asuntos deliberadamente abiertos

Continúan abiertos y no se cerrarán por inferencia: escalas/bandas AMEF corporativas, reglas oficiales de criticidad, árbol RCM definitivo, reglas P-F/intervalo, autoridades finales, evidencia mínima, sobreclasificación, criterios de aprobación, KPIs de efectividad, agrupación definitiva, sistema destino, integración y arquitectura física de datos.
