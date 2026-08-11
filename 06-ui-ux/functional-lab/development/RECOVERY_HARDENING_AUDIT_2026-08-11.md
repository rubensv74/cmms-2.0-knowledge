# CMMS 2.0 Functional Lab — Auditoría de recuperación y hardening

**Fecha:** 2026-08-11  
**Rama:** `feature/f01-premium-foundation`  
**Objetivo:** dejar una única línea canónica para terminar la instalación y validación en Power Apps Studio sin continuar recuperando commits históricos de forma aislada.

## 1. Conclusión ejecutiva

La arquitectura funcional no es el origen del bloqueo actual. La rama contiene los **9 componentes canónicos** y las **25 pantallas canónicas** del Functional Lab.

Los problemas observados en Studio proceden de tres causas distintas que se estaban mezclando:

1. **Grafo de pantallas incompleto en Studio.** Se estaban pegando pantallas una a una mientras sus fórmulas `Navigate(...)` apuntaban a pantallas canónicas todavía inexistentes. Esto produce de forma previsible errores `Name isn't valid. 'scr_FL_...'`.
2. **Rollback histórico demasiado amplio.** Se recuperaron definiciones antiguas que habían sido estables funcionalmente, pero que precedían al hardening visual de propiedades `Color`. Se recuperó estabilidad de definición y, al mismo tiempo, se reintrodujo el defecto de superficies negras.
3. **Deuda de legibilidad.** Algunas pantallas y componentes históricos aún contienen texto de 7–10 pt. La foundation actual fija 11 pt como mínimo visible y prohíbe reducir tipografía para hacer caber contenido.

La corrección no consiste en reconstruir la app otra vez. Consiste en **instalar el grafo completo de identidades, actualizar los componentes in situ desde la rama canónica actual y volver a cargar las pantallas desde esa misma rama**.

## 2. Cambio de método obligatorio

Queda retirado el método de recuperación basado en enlaces a commits históricos individuales.

Desde este punto:

```text
FUENTE ÚNICA
feature/f01-premium-foundation
        ↓
9 componentes actuales
        ↓
25 identidades de pantalla existentes en Studio
        ↓
25 pantallas actuales
        ↓
1 validación integrada
```

No se volverán a combinar una pantalla de un commit histórico con componentes de otra revisión.

## 3. Qué explican los 84 errores de fórmula

Los errores visibles en la captura del 11 de agosto incluyen referencias como:

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

Todas son pantallas canónicas que **sí existen en el repositorio**. El error aparece porque todavía no existen como objetos de pantalla dentro de la app de Studio reconstruida parcialmente.

Por tanto:

```text
Name isn't valid + target canónico ausente en Studio
= dependencia de instalación pendiente
≠ prueba de que la fórmula Navigate sea incorrecta
```

La instalación correcta debe crear primero las 25 identidades de pantalla, aunque las que falten estén temporalmente vacías.

## 4. Qué explica el render negro

El negro no queda explicado por una referencia `Navigate(...)` no resuelta.

La inspección de las definiciones recuperadas mostró componentes donde propiedades visuales internas dependían directamente de Inputs `Color`, por ejemplo:

```text
SurfaceColor
BorderColor
TextColor
MutedTextColor
SelectionFill
HighlightFill
```

Durante esta misma fase ya se había observado una materialización visual incorrecta de algunos defaults `Color` en Studio. Al recuperar versiones históricas anteriores al hardening se reintrodujo ese camino visual.

La estrategia canónica pasa a ser:

- conservar las propiedades `Color` cuando formen parte del contrato público existente;
- evitar que la visualización base dependa de ellas en componentes donde ya se ha observado el incidente;
- utilizar una paleta interna segura por defecto;
- mantener el tema del host como evolución posterior, no como requisito para terminar el Functional Lab.

## 5. Auditoría de componentes

| Componente | Estado de fuente tras auditoría | Acción 11-08 | Studio requerido |
|---|---|---|---|
| `cmp_FL_SidebarPro` | safe palette + Comfortable | revisado; sin cambio | conservar identidad; smoke integrado |
| `cmp_FL_PageHeaderPro` | safe palette + Comfortable | revisado; sin cambio | actualizar in situ desde rama actual |
| `cmp_FL_TreePro` | **HARDENED SAFE PALETTE RC3** | corregido: raíz/selección/texto independientes de Color inputs; texto >=11 | revalidar definición + instancias FLH/Taxonomía/ADR |
| `cmp_FL_ProcessRailPro` | safe palette + Comfortable | revisado; sin cambio | definición/instancia aún pendientes de validación final |
| `cmp_FL_DecisionPanelPro` | safe palette + Comfortable | revisado; sin cambio | definición/instancia aún pendientes de validación final |
| `cmp_FL_GatePanelPro` | **HARDENED SAFE PALETTE RC2** | corregido root Fill; contrato preservado | revalidar definición/instancia |
| `cmp_FL_RiskMatrixPro` | Premium 5×5 RC4 + safe root palette | revisado; no rediseñar | validar selección S4/O3 y QA visual |
| `cmp_FL_LineagePanelPro` | **HARDENED SAFE PALETTE RC3** | corregido: paleta interna segura + legibilidad >=11 + altura 126 compatible con hosts existentes | revalidar instancia existente |
| `cmp_FL_ApplicabilityMatrixPro` | **HARDENED READABILITY RC2** | tipografía 7–9 eliminada; cabeceras >=11, filas 12 | revalidar multi-activo |

### Estados que NO se deben inferir

Una corrección publicada en GitHub no equivale a `INSTANCE_SAFE` ni a `VISUAL_QA_VALIDATED`.

La escalera sigue siendo:

```text
PASS_STATIC
→ DEFINITION_ACCEPTED
→ INSTANCE_SAFE
→ PUBLIC_CONTRACT_VALIDATED
→ VISUAL_QA_VALIDATED
→ READY_FOR_INTEGRATION
```

## 6. Auditoría del grafo de pantallas

La rama contiene exactamente las 25 identidades canónicas documentadas:

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

No se crearán nombres alternativos ni pantallas duplicadas.

## 7. Evidencia Studio que se conserva

Antes de la regresión visual se había obtenido evidencia funcional real de:

```text
HOME OK
ACTIVOS OK
BIBLIOTECA AMEF OK
APLICACIÓN MULTI-ACTIVO OK
```

Durante la recuperación del 11 de agosto se volvió a confirmar:

```text
HOME BASELINE PASS
FLH PASS
TAXONOMÍA PASS
ADR PASS
```

Esa evidencia demuestra que el modelo de navegación, bootstrap y datos no necesita ser replanteado. La regresión posterior se trata como **incidente de instalación/visual foundation**, no como fallo de arquitectura funcional.

## 8. Auditoría de pantallas — hallazgos

### A. Dependencias cruzadas

Las pantallas usan navegación hacia el conjunto canónico. Mientras el conjunto no exista completo en Studio, App Checker genera ruido que impide distinguir errores reales de dependencias aún no instaladas.

**Corrección:** crear primero todas las identidades.

### B. Bootstrap

`scr_FL_Home.OnVisible` continúa siendo la autoridad del fixture alineado y está protegido por `varFLAlignedInitialized`.

No reinstalar el bootstrap legacy.

### C. Legibilidad

Existen pantallas históricas con `Size` 9/10 en textos auxiliares, tabs y botones. Esto no invalida la lógica, pero **no cumple todavía la Visual QA final**.

No se va a hacer un reemplazo ciego global de tamaños porque podría provocar clipping en 25 pantallas. La corrección visual se hará después de que el grafo compile limpio y se aplicará sobre la pantalla de referencia antes de propagarse.

### D. AMEF

`scr_FL_AMEF` no es el punto de recuperación. Se mantiene publicado como candidato de trabajo, pero no se instalará/validará hasta que:

```text
foundation limpia
+ 25 identidades resueltas
+ Home/Activos/Biblioteca/Aplicación estables
```

`cmp_FL_RiskMatrixPro` conserva el patrón premium 5×5 y no se rediseña durante la recuperación.

## 9. Reglas de blindaje añadidas

1. **Recovery unit = ensamblaje, no archivo histórico aislado.**
2. **No juzgar fórmulas cross-screen con un grafo parcial.**
3. **No añadir una segunda copia de un componente para actualizarlo.** Editar definición in situ preservando identidad.
4. **No depender de Inputs Color para la paleta base en componentes afectados por FL-SC-004.**
5. **No visible text < 11.** Las excepciones deben justificarse expresamente.
6. **No propagar cambios visuales a 25 pantallas antes de aprobar una pantalla de referencia.**
7. **GitHub/source no sustituye Studio.** Studio y App Checker son el gate de runtime.
8. **No volver a commits históricos para instalación normal.** Los commits históricos quedan solo como evidencia forense.

## 10. Fuente canónica para mañana

### Componentes

`06-ui-ux/functional-lab/power-apps/components/`

### Pantallas

`06-ui-ux/functional-lab/power-apps/screens/`

### Instalación

`06-ui-ux/functional-lab/power-apps/V2_INSTALLATION.md`

### Runbook corto

`06-ui-ux/functional-lab/development/TOMORROW_RUNBOOK_2026-08-12.md`

## 11. Gate de mañana

El primer objetivo no es “terminar AMEF”. Es obtener:

```text
25 nombres de pantalla resueltos
0 errores Name isn't valid por pantallas ausentes
9 definiciones de componente actuales pegadas in situ
Home / FLH / Taxonomía / ADR / Criticidad sin superficies negras
sin duplicación de componentes
```

Una vez superado ese gate, se instala el resto por lotes y se ejecutan los smokes funcionales ya definidos.

## 12. Estado al cierre del 11 de agosto

```text
Arquitectura funcional                    CONSERVADA
9 componentes en repositorio              SÍ
25 pantallas en repositorio               SÍ
Hardening de componentes críticos         PUBLICADO
Grafo completo instalado en Studio        NO
Studio QA de revisiones de esta noche     PENDIENTE
AMEF ready for integration                NO
Runbook de recuperación                   PREPARADO
```

La app no se declara terminada ni `READY_FOR_INTEGRATION` hasta completar el gate Studio de mañana.
