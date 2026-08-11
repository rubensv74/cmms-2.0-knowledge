# CMMS 2.0 Functional Lab — Runbook de cierre para 2026-08-12

**Objetivo del día:** instalar una única versión coherente de la rama `feature/f01-premium-foundation`, eliminar el ruido de referencias a pantallas inexistentes y ejecutar una validación integrada sin volver a mezclar commits históricos.

> No usar enlaces históricos. Todos los archivos se toman de la rama actual.

---

## PASO 0 — No borrar lo que ya funciona

Mantener las pantallas existentes y los componentes existentes.

No crear copias con sufijos como:

```text
cmp_FL_TreePro_1
cmp_FL_LineagePanelPro_1
scr_FL_Home_1
```

Si un componente ya existe, se actualiza **su definición in situ**.

---

## PASO 1 — Completar primero el grafo de pantallas

Antes de volver a mirar App Checker, comprobar que existen en Studio las 25 pantallas con estos nombres exactos:

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

Las que todavía no existan se crean como **Blank screen** y se renombran exactamente. No pegar aún su código.

### Gate 1

Abrir **Formulas / App Checker**.

Resultado esperado:

```text
los errores Name isn't valid causados exclusivamente por scr_FL_<pantalla ausente>
deben desaparecer o reducirse drásticamente
```

Si permanece un `Name isn't valid` que apunta a uno de los 25 nombres anteriores, comprobar primero ortografía/nombre de pantalla antes de tocar fórmulas.

---

## PASO 2 — Actualizar los 9 componentes canónicos

Carpeta única:

`06-ui-ux/functional-lab/power-apps/components/`

Actualizar **in situ**, en este orden:

```text
1  cmp_FL_SidebarPro
2  cmp_FL_PageHeaderPro
3  cmp_FL_TreePro
4  cmp_FL_ProcessRailPro
5  cmp_FL_DecisionPanelPro
6  cmp_FL_GatePanelPro
7  cmp_FL_RiskMatrixPro
8  cmp_FL_LineagePanelPro
9  cmp_FL_ApplicabilityMatrixPro
```

### Qué debe aportar la revisión actual

```text
Sidebar             dark palette intencional + texto legible
PageHeader          safe palette + Comfortable
TreePro             HARDENED SAFE PALETTE RC3
ProcessRail         safe palette + texto >=11
DecisionPanel       safe palette + separación sistema/humano
GatePanel           HARDENED SAFE PALETTE RC2
RiskMatrix          Premium 5×5 RC4
LineagePanel        HARDENED SAFE PALETTE RC3 / Height 126
ApplicabilityMatrix HARDENED READABILITY RC2
```

### Gate 2

Después de actualizar los nueve, guardar una vez y revisar App Checker.

No empezar a corregir fórmulas de pantalla mientras exista un error de definición del componente que las consume.

---

## PASO 3 — Sustituir las pantallas por la fuente canónica actual

Carpeta única:

`06-ui-ux/functional-lab/power-apps/screens/`

Aunque una pantalla ya exista y hoy haya funcionado, **no recuperar su commit histórico**. Reemplazar su Source Code con el archivo actual de la rama.

### Lote A — Foundation / Activos

```text
scr_FL_Home
scr_FL_FLH
scr_FL_Taxonomy
scr_FL_ADR
scr_FL_AssetCriticality
scr_FL_Asset360
```

Guardar una vez al terminar el lote.

### Lote B — Ingeniería reutilizable

```text
scr_FL_FmeaLibrary
scr_FL_FmeaRevision
scr_FL_AssetApplication
```

Guardar una vez al terminar el lote.

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

Guardar una vez al terminar el lote.

### Lote D — Handoff / gobierno

```text
scr_FL_MaintenancePlans
scr_FL_Governance
scr_FL_Settings
```

Guardar una vez al terminar el lote.

---

## PASO 4 — Reiniciar la sesión y ejecutar bootstrap

Cuando las 25 pantallas tengan su fuente actual:

1. guardar;
2. cerrar/reabrir el editor o recargar la app para limpiar variables de la sesión;
3. abrir `scr_FL_Home`;
4. dejar que `Home.OnVisible` inicialice el fixture alineado.

No reinstalar ningún bootstrap antiguo.

Fixture esperado:

```text
Activo              P-101
AMEF                 AMEF-BOMBA-CENTRIFUGA
Revisión             R01
Aplicación           APP-P101-R01
Criticidad           Alta
Perfil               HIGH
AnalysisCase         P101-AMEF-RCM-001
S/O/D                4 / 3 / 3
S×O                  12
NPR                  36
```

---

## PASO 5 — Un único smoke de Foundation

Recorrer:

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

Validar de una sola vez:

```text
[ ] no hay superficies negras fuera del Sidebar intencional
[ ] no hay Name isn't valid por pantallas canónicas
[ ] P-101 permanece cargado
[ ] TreePro funciona en FLH, Taxonomía y ADR
[ ] Lineage es legible
[ ] Header es legible
[ ] criticidad sigue separada del riesgo AMEF
[ ] R01 se aplica a P-101/P-102/P-103 sin duplicar ingeniería
[ ] no aparecen componentes con sufijo _1
```

Si este smoke pasa, registrar:

```text
FOUNDATION INTEGRATED PASS
```

---

## PASO 6 — AnalysisCase / AMEF

Solo después de `FOUNDATION INTEGRATED PASS`:

```text
Analysis Register
→ Case Overview
→ Contexto
→ Funciones
→ Modos de fallo
→ AMEF
```

En AMEF comprobar exclusivamente:

```text
[ ] Process Rail legible y navegable
[ ] FL-07 efectos/contexto
[ ] FL-09 RiskMatrix 5×5 completa
[ ] selección inicial S=4 / O=3
[ ] D=3
[ ] S×O=12
[ ] NPR=36
[ ] criticidad del activo no se confunde con matriz AMEF
[ ] recomendación del sistema separada de decisión humana
[ ] control de avance explicado en lenguaje visible, no “Gate” como término principal
```

No rediseñar la matriz durante este smoke.

---

## PASO 7 — Cierre del recorrido funcional

Si AMEF pasa:

```text
RCM
→ Economía
→ Tarea e intervalo
→ Paquete de plan
→ Trazabilidad
→ Revisión y aprobación
→ Efectividad
→ Maintenance Plans
→ Gobernanza
→ Configuración
```

Validar los 11 smokes de `V2_INSTALLATION.md` como una secuencia integrada.

---

## PASO 8 — Visual QA final

Solo con App Checker funcionalmente limpio:

1. revisar texto < 11;
2. corregir primero una pantalla de referencia;
3. confirmar que no hay clipping;
4. propagar el patrón únicamente después de la aprobación visual.

No hacer reemplazos globales ciegos de tamaños de fuente.

---

## Si algo falla mañana

Usar esta clasificación antes de cambiar código:

```text
Name isn't valid scr_FL_*        → comprobar identidad de pantalla
PA2301 CanvasComponent           → comprobar definición/identidad del componente
superficie negra                 → comprobar que el componente actual hardened está pegado in situ
PA1001 YAML                      → revisar scalar inline / estructura PaYaml
PA2108 Unknown property          → comprobar control/versión/contrato público
clipping                         → corregir layout, no reducir texto
```

No volver a un commit histórico salvo análisis forense explícito.

---

## Resultado de cierre esperado

```text
25 pantallas instaladas
9 componentes actuales
0 navegación rota por nombres ausentes
0 superficies negras accidentales
Foundation integrada
AMEF 5×5 correcto
recorrido completo navegable
App Checker sin errores estructurales bloqueantes
```

Cuando eso ocurra, actualizar el estado a `READY_FOR_INTEGRATION` únicamente para las piezas que hayan superado Studio y Visual QA.
