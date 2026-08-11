# CMMS 2.0 Functional Lab — Estado canónico tras hardening

**Fecha:** 2026-08-11  
**Rama:** `feature/f01-premium-foundation`

## Estado global

```text
Arquitectura funcional D-01…D-14       ALINEADA
9 componentes canónicos                PUBLICADOS
25 pantallas canónicas                 PUBLICADAS
Studio reconstruido con 25 identidades NO TODAVÍA
Hardening de paleta/legibilidad         PUBLICADO EN COMPONENTES CRÍTICOS
Visual QA final                         PENDIENTE STUDIO
READY_FOR_INTEGRATION                   NO
```

## Modelo canónico

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

P-101 consume una revisión reusable de ingeniería; no posee el AMEF.

## Evidencia Studio acumulada que se conserva

Se obtuvo anteriormente:

```text
HOME OK
ACTIVOS OK
BIBLIOTECA AMEF OK
APLICACIÓN MULTI-ACTIVO OK
```

Durante la recuperación del 11 de agosto se reconfirmó:

```text
HOME BASELINE PASS
FLH PASS
TAXONOMÍA PASS
ADR PASS
```

La posterior aparición de superficies negras y ~84 errores se ha clasificado como incidente de **instalación parcial + regresión visual por rollback histórico**, no como refutación de la arquitectura funcional.

## Diagnóstico de los errores actuales

### Fórmulas

Muchas referencias `Name isn't valid. 'scr_FL_...'` corresponden a destinos que sí existen en el repositorio pero que todavía no habían sido creados como pantallas en la app de Studio reconstruida parcialmente.

Corrección: crear primero las 25 identidades de pantalla y después evaluar App Checker.

### Superficies negras

El rollback histórico reintrodujo componentes cuyo camino visual dependía directamente de propiedades `Color` que ya habían mostrado materialización incorrecta en Studio.

Correcciones publicadas:

```text
cmp_FL_TreePro                 HARDENED SAFE PALETTE RC3
cmp_FL_LineagePanelPro         HARDENED SAFE PALETTE RC3
cmp_FL_GatePanelPro            HARDENED SAFE PALETTE RC2
cmp_FL_ApplicabilityMatrixPro  HARDENED READABILITY RC2
```

Continúan como fuentes actuales revisadas:

```text
cmp_FL_SidebarPro              safe dark palette + Comfortable
cmp_FL_PageHeaderPro           safe palette + Comfortable
cmp_FL_ProcessRailPro          safe palette + Comfortable
cmp_FL_DecisionPanelPro        safe palette + Comfortable
cmp_FL_RiskMatrixPro           Premium 5×5 RC4
```

Ninguna revisión publicada esta noche se declara `INSTANCE_SAFE` hasta que Studio la acepte y se prueben instancias reales.

## Fuente única de instalación

No utilizar commits históricos.

```text
componentes  → power-apps/components/
pantallas    → power-apps/screens/
guía         → power-apps/V2_INSTALLATION.md
runbook      → development/TOMORROW_RUNBOOK_2026-08-12.md
auditoría    → development/RECOVERY_HARDENING_AUDIT_2026-08-11.md
```

`RECOVERY_BASELINE_R0.md` queda `SUPERSEDED` y solo se conserva como evidencia forense.

## Gate de recuperación para 12 de agosto

```text
25 nombres de pantalla resueltos en Studio
→ 9 componentes actuales actualizados in situ
→ 25 fuentes actuales instaladas
→ reinicio de sesión + Home bootstrap
→ Foundation smoke integrado
```

Foundation smoke:

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

Debe terminar con:

```text
0 Name isn't valid por pantallas canónicas
0 superficies negras accidentales
0 componentes duplicados
P-101 cargado
criticidad separada de AMEF
R01 aplicada a P-101/P-102/P-103
```

Resultado esperado:

```text
FOUNDATION INTEGRATED PASS
```

Solo entonces vuelve al flujo AnalysisCase/AMEF.

## AMEF

Fixture P-101:

```text
S=4/5
O=3/5
D=3/5
S×O=12
NPR=36
```

`cmp_FL_RiskMatrixPro` conserva la referencia premium 5×5; no se rediseña durante la recuperación.

`scr_FL_AMEF` permanece como candidato de fuente y requiere Studio QA después de cerrar Foundation.

## Deuda visual controlada

La auditoría detecta pantallas históricas con texto de 9/10 pt. No se realizará un reemplazo global ciego porque puede introducir clipping.

El estándar sigue siendo:

```text
mínimo visible 11
supporting     12
body           13–14
section title  16–18
page title     24–28
button         12–13
```

La propagación tipográfica se hará únicamente después del `FOUNDATION INTEGRATED PASS`, empezando por una pantalla de referencia.

## Asuntos deliberadamente abiertos

Continúan abiertos y no se cerrarán por inferencia: escalas/bandas AMEF corporativas, reglas oficiales de criticidad, árbol RCM definitivo, reglas P-F/intervalo, autoridades finales, evidencia mínima, overclassification, criterios de aprobación, KPIs de efectividad, agrupación definitiva, sistema destino, integración y arquitectura física de datos.
