# CMMS 2.0 Functional Lab — Auditoría de recuperación y hardening

**Fecha:** 2026-08-11  
**Rama:** `feature/f01-premium-foundation`  
**Playbook obligatorio:** `functional-engineering-knowledge-base/30-playbooks/power-platform/modular-power-apps-screen-construction.md`

## 1. Conclusión ejecutiva

La arquitectura funcional no es el origen del bloqueo. La rama contiene los **9 componentes canónicos** y las **25 pantallas funcionales canónicas** del Functional Lab.

Los problemas observados en Studio proceden de tres causas distintas que se habían mezclado:

1. **Grafo de pantallas incompleto en Studio.** Fórmulas `Navigate(...)` apuntaban a pantallas canónicas todavía inexistentes como objetos de Studio, generando `Name isn't valid. 'scr_FL_...'`.
2. **Rollback histórico por archivo.** Se recuperaron versiones funcionalmente estables pero anteriores al hardening visual, reintroduciendo dependencias de color que coincidieron con superficies negras.
3. **Evolución demasiado amplia por incremento.** Shell, navegación, rail, AMEF, matriz, tipografía y color llegaron a modificarse simultáneamente; esto impidió aislar regresiones y contradice la estrategia incremental ahora vigente.

La corrección **no** es reconstruir otra vez toda la app ni sustituir 25 pantallas por lotes. La corrección es:

```text
completar dependencias de identidad
→ congelar lo ya aprobado
→ validar color en superficie aislada
→ validar componentes reutilizables de uno en uno
→ construir/evolucionar pantallas por skeleton + placeholders + bloques S/C/I
```

## 2. Cambio de método obligatorio

Quedan retirados dos métodos:

```text
A) recuperación por commits históricos individuales
B) sustitución masiva de componentes/pantallas antes de validar cada incremento
```

El método vigente es:

```text
SKELETON
→ PLACEHOLDER CONTRATADO
→ BLOCK S / C / I
→ STUDIO
→ VALIDATE
→ FREEZE
→ NEXT BLOCK
```

Si un bloque falla:

```text
BLOCK X ❌
→ BLOCK X-FIX
→ VALIDATE
→ BLOCK X ✅
```

No se usa el bloque siguiente para reparar silenciosamente el anterior.

## 3. Qué explican los errores `Name isn't valid`

Los errores visibles incluyen referencias como:

```text
scr_FL_AnalysisRegister
scr_FL_MaintenancePlans
scr_FL_Governance
scr_FL_Settings
scr_FL_FmeaLibrary
scr_FL_AssetApplication
scr_FL_CaseOverview
...
```

Todas son pantallas canónicas existentes en el repositorio. Si todavía no existen como objetos en Studio, el error es una dependencia de instalación pendiente.

Por tanto:

```text
Name isn't valid
+ target canónico ausente en Studio
= dependencia de identidad pendiente
≠ demostración de una fórmula Navigate incorrecta
```

Se permite crear las identidades faltantes como `Blank screen` antes de construir su contenido. Eso limpia el grafo de dependencias sin obligar a pegar pantallas monolíticas.

## 4. Qué explica el render negro

El render negro no queda explicado por una referencia `Navigate(...)` no resuelta.

La inspección de versiones históricas mostró componentes donde el camino visual dependía directamente de Inputs `Color` como:

```text
SurfaceColor
BorderColor
TextColor
MutedTextColor
SelectionFill
HighlightFill
```

Durante esta fase ya se había observado materialización visual incorrecta de algunos defaults `Color` en Studio. La causa interna exacta de Power Apps no se afirma resuelta.

### Decisión de arquitectura visual

El nuevo playbook obliga a separar el Theme de la estructura y el comportamiento.

Por tanto:

```text
STRUCTURE       puede quedar FROZEN
BEHAVIOR        puede quedar FROZEN
DATA CONTRACT   puede quedar FROZEN
COLOR           puede quedar PENDING
```

Los colores dejan de validarse pantalla por pantalla. Se validarán primero mediante roles/tokens compartidos en `scr_DesignSystemLab`.

## 5. Autoridad cromática

El sistema visual no debe depender de paletas arbitrarias por componente.

Roles mínimos:

```text
Background
Surface
SurfaceAlt
Border
TextPrimary
TextSecondary
Primary
PrimaryHover
PrimarySelected
SelectedBackground
SelectedBorder
SelectedAccent
SelectedText
Success
Warning
Danger
Chart01…Chart06
```

Los valores actuales hardcoded en componentes se consideran **fallback de compatibilidad**, no una segunda fuente de verdad semántica.

La aprobación cromática final requiere Studio/runtime en una superficie aislada.

## 6. Design System Lab

Se incorpora una pantalla técnica no productiva:

```text
scr_DesignSystemLab
```

No forma parte de las 25 pantallas funcionales ni de la navegación del CMMS.

Su construcción seguirá el playbook:

```text
DS-S01 skeleton + placeholders
→ validate
→ freeze geometry
→ DS-C01 tokens
→ DS-C02 Classic/Modern controls
→ DS-C03 interaction states
→ DS-C04 data visualisation
→ color approval
```

No se propagará ninguna corrección cromática mientras no exista evidencia en esta superficie.

## 7. Auditoría de componentes

| Componente | Hallazgo | Estado de fuente | Próximo gate |
|---|---|---|---|
| `cmp_FL_SidebarPro` | patrón comparable con PULSE Sidebar; safe dark fallback; tipografía >=11 | revisado | no tocar salvo fallo real; smoke aislado si cambia |
| `cmp_FL_PageHeaderPro` | safe fallback + ModernText AutoHeight; tipografía Comfortable | revisado | conservar contrato/identidad; smoke si cambia |
| `cmp_FL_TreePro` | rollback había reintroducido Color inputs en ruta visual y texto 9/10 | **HARDENED SAFE PALETTE RC3** | definición + una instancia aislada + contrato |
| `cmp_FL_ProcessRailPro` | flat Gallery, safe fallback, tipografía >=11 | revisado | definición + instancia aislada |
| `cmp_FL_DecisionPanelPro` | separación sistema/recomendación/decisión humana; safe fallback | revisado | definición + instancia aislada |
| `cmp_FL_GatePanelPro` | root Fill dependía de input de superficie | **HARDENED SAFE PALETTE RC2** | definición + instancia aislada |
| `cmp_FL_RiskMatrixPro` | matriz premium 5×5, Gallery.Default sincronizado con S/O | **RC4** | instancia aislada; S4/O3/D3; QA visual |
| `cmp_FL_LineagePanelPro` | rollback reintrodujo Color inputs; texto y altura no compatibles con todos los hosts | **HARDENED SAFE PALETTE RC3 / H=126** | instancia aislada + Home slot |
| `cmp_FL_ApplicabilityMatrixPro` | texto 7–9 incumplía baseline | **HARDENED READABILITY RC2** | instancia aislada + multi-activo |

### Referencias positivas PULSE

El playbook obliga a comparar antes de fragmentar el diagnóstico. Se revisaron como contraejemplos positivos:

```text
PULSE cmp_HeatMapPro
PULSE cmp_SidebarNav
```

Ambos confirman que contratos públicos complejos, Table inputs, Gallery, eventos, `Selected`, `ThisItem` y paletas explícitas son viables; por tanto, no deben declararse incompatibles de forma general. El diagnóstico debe localizar el delta concreto del componente que falla.

## 8. Estado de validación honesto

Publicar una fuente no equivale a validarla en Studio.

Escalera:

```text
SOURCE_VALID
→ COMPONENT_DEFINITION_ACCEPTED
→ INSTANCE_SAFE
→ PUBLIC_CONTRACT_VALIDATED
→ VISUAL_QA_VALIDATED
→ READY_FOR_INTEGRATION
```

Para pantalla/bloque:

```text
IN_CONSTRUCTION
→ FUNCTIONAL
→ FUNCTIONAL_FROZEN
→ VISUAL_APPROVED
→ FINAL_FROZEN
```

No promover estados por inferencia.

## 9. Auditoría del grafo de pantallas

Las 25 identidades funcionales se mantienen:

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

`scr_DesignSystemLab` es utility/lab y no aumenta el alcance funcional del producto.

## 10. Evidencia Studio que se conserva

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

Esta evidencia permite **congelar intención, geometría y comportamiento ya aprobados**, pero cualquier componente cuya fuente haya cambiado después necesita revalidar su revisión actual antes de volver a ser `READY_FOR_INTEGRATION`.

## 11. Freeze por áreas

### Home

```text
GEOMETRY      FROZEN
BOOTSTRAP     FROZEN
NAVIGATION    FUNCTIONAL_FROZEN
COLOR         PENDING
```

No reconstruir Home. Solo bloques `FIX` o de integración declarados sobre slots concretos.

### FLH / Taxonomía / ADR

```text
GEOMETRY      FROZEN
BEHAVIOR      evidencia positiva previa
TreePro rev.  REVALIDATION REQUIRED
COLOR         PENDING
```

### Biblioteca / Aplicación multi-activo

```text
FUNCTIONAL INTENT   FROZEN
DATA MODEL          FROZEN
Applicability RC2   REVALIDATION REQUIRED
COLOR               PENDING
```

### AMEF

```text
GEOMETRY      OPEN
BEHAVIOR      OPEN
COLOR         PENDING
STATUS        IN_CONSTRUCTION
```

AMEF es la excepción: la pantalla actual no se considera congelada. Debe reconstruirse correctamente **skeleton first**, no mediante otra sustitución monolítica.

## 12. Deuda de legibilidad

Existen pantallas legacy con `Size` 9/10. No se hará un reemplazo ciego global.

El estándar exige:

```text
visible mínimo  11
supporting      12
body            13–14
section title   16–18
page title      24–28
button          12–13
```

La corrección tipográfica se tratará como bloque visual claramente acotado después de congelar geometría y comportamiento de la pantalla afectada.

## 13. Reglas de blindaje definitivas

1. **Playbook obligatorio antes de cualquier nuevo YAML.**
2. **Skeleton first para nuevas pantallas y para AMEF, que sigue abierta.**
3. **Geometry freeze después de aprobación.**
4. **One block, one purpose.**
5. **S / C / I obligatorios; FIX para reparación.**
6. **TOUCHES / DO NOT MODIFY antes de cada bloque.**
7. **Component gate aislado antes de consumir una revisión nueva.**
8. **Color se valida en DesignSystemLab, no reabriendo pantallas funcionales.**
9. **No añadir segunda copia de un componente.** Actualización in situ o migración explícita.
10. **No diagnosticar Navigate sobre un grafo parcial.**
11. **No commits históricos como catálogo de piezas de instalación.**
12. **No texto visible <11 para hacer caber contenido.**
13. **Studio y App Checker son autoridad de runtime.**
14. **PULSE positive reference first** antes de micropruebas de componentes.

## 14. Fuente canónica para mañana

```text
Playbook
functional-engineering-knowledge-base/30-playbooks/power-platform/modular-power-apps-screen-construction.md

Auditoría
06-ui-ux/functional-lab/development/RECOVERY_HARDENING_AUDIT_2026-08-11.md

Freeze register
06-ui-ux/functional-lab/development/FREEZE_REGISTER_2026-08-11.md

Runbook
06-ui-ux/functional-lab/development/TOMORROW_RUNBOOK_2026-08-12.md

Design System Lab
06-ui-ux/functional-lab/power-apps/labs/
```

## 15. Gate de mañana

El primer objetivo no es pegar todo el repositorio. Es obtener, acumulativamente:

```text
PREP-01                grafo de nombres resuelto
DS-S01                 DesignSystemLab geometry frozen
DS-C01…04              color foundation approved
component gates        revisiones actuales instance-safe
Home / Assets          piezas previamente aprobadas revalidadas sin reconstrucción
AMEF S01               skeleton aprobado y geometry frozen
AMEF C/I               sustitución progresiva de placeholders
```

Solo después se continuará con el resto del recorrido.

## 16. Estado al cierre del 11 de agosto

```text
Arquitectura funcional                         CONSERVADA
9 componentes en repositorio                   SÍ
25 pantallas funcionales en repositorio        SÍ
Hardening fuente de componentes críticos       PUBLICADO
Playbook modular adoptado                      SÍ
Freeze model definido                          SÍ
Design System Lab                              PREPARADO / Studio pendiente
Studio QA de revisiones de esta noche          PENDIENTE
AMEF ready for integration                     NO
```

La app no se declara terminada ni `READY_FOR_INTEGRATION` hasta completar los gates de Studio correspondientes.
