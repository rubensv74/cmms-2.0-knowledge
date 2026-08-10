# CMMS 2.0 Functional Lab — Arquitectura v2

**Estado:** arquitectura objetivo aprobada  
**Fecha:** 2026-08-10  
**Ámbito:** aplicación funcional ejecutable para validar CMMS 2.0.  
**Implementación actual:** Power Apps Canvas.  
**Backend objetivo de referencia:** contratos preparados para Azure SQL mediante adaptadores sustituibles.

## 1. Identidad del producto

La aplicación mantiene la identidad **CMMS 2.0 Functional Lab**.

No es un mockup, un navegador de prototipos ni una presentación de pantallas. Debe poder experimentarse como una aplicación CMMS real y coherente, usando datos de demostración y reglas funcionales todavía en validación cuando corresponda.

La etiqueta `Functional Lab` cumple una función de gobernanza: deja claro que las decisiones observadas son conceptuales y no constituyen todavía configuración productiva aprobada.

## 2. Principio rector

> El objetivo no es minimizar pantallas; el objetivo es representar correctamente objetos de negocio, responsabilidades, decisiones, estados y secuencias de trabajo.

Las 28 etapas AMEF/RCM siguen siendo el modelo metodológico canónico, pero **no se convierten automáticamente en 28 pantallas** ni se ocultan dentro de nueve bloques demasiado agregados.

La interfaz se organiza alrededor de objetos y procesos que un usuario de un CMMS pueda reconocer.

## 3. Arquitectura de navegación dual

La aplicación utiliza dos niveles de navegación distintos.

### 3.1 Navegación de producto

El Sidebar global navega por módulos CMMS:

```text
Inicio
Activos
Estrategia de mantenimiento
Planes de mantenimiento
Gobernanza
Configuración
```

Los módulos todavía no implementados pueden existir como estados `planned` o `preview`, pero el shell debe mostrar desde Foundation la arquitectura global del producto.

### 3.2 Navegación metodológica

Dentro de un `AnalysisCase`, un **Process Rail** muestra las 28 etapas del journey:

```text
Fase 1 · Comprender el problema       FL-01 … FL-06
Fase 2 · Evaluar el riesgo            FL-07 … FL-11
Fase 3 · Tomar la decisión RCM        FL-12 … FL-16
Fase 4 · Convertir en plan            FL-17 … FL-22
Fase 5 · Gobernar y mejorar           FL-23 … FL-28
```

El Process Rail no sustituye el menú principal. Su función es:

- hacer visible la secuencia completa;
- indicar etapa actual y estado;
- mostrar responsabilidad dominante;
- permitir consulta de otras etapas cuando el usuario tenga permiso contextual;
- impedir aprobación formal cuando un gate previo no esté satisfecho;
- navegar a la pantalla y sección de negocio correspondiente.

## 4. Modelo de pantallas

Las pantallas se definen por **objeto o proceso de negocio**, no por ahorro de pantallas ni por una equivalencia rígida etapa=pantalla.

Mapa objetivo inicial:

```text
CMMS 2.0 Functional Lab
│
├── Inicio
│   └── scr_FL_Home
│
├── Activos
│   ├── scr_FL_FLH
│   ├── scr_FL_Taxonomy
│   ├── scr_FL_ADR
│   └── scr_FL_Asset360
│
├── Estrategia de mantenimiento
│   ├── scr_FL_AnalysisRegister
│   ├── scr_FL_CaseOverview
│   ├── scr_FL_Context
│   ├── scr_FL_Functions
│   ├── scr_FL_FailureModes
│   ├── scr_FL_AMEF
│   ├── scr_FL_RCM
│   ├── scr_FL_Economics
│   ├── scr_FL_Task
│   ├── scr_FL_PlanPackage
│   ├── scr_FL_Traceability
│   ├── scr_FL_ReviewApproval
│   └── scr_FL_Effectiveness
│
├── Planes de mantenimiento
│   └── scr_FL_MaintenancePlans
│
├── Gobernanza
│   └── scr_FL_Governance
│
└── Configuración
    └── scr_FL_Settings
```

La existencia de una pantalla en el mapa no implica que todas deban completarse antes de validar el módulo AMEF/RCM. Sí implica que la arquitectura, rutas y contratos deben ser coherentes desde el inicio.

## 5. Relación entre pantallas y las 28 etapas

| Pantalla | Etapas principales | Objeto dominante |
|---|---|---|
| `scr_FL_Context` | FL-01 a FL-03 | `AnalysisCaseContext` |
| `scr_FL_Functions` | FL-04 a FL-05 | `Function` + `FunctionalFailure` |
| `scr_FL_FailureModes` | FL-06 | `FailureModeSelection` |
| `scr_FL_AMEF` | FL-07 a FL-11 | `RiskAssessment` |
| `scr_FL_RCM` | FL-12 a FL-16 | `RCMAnalysis` |
| `scr_FL_Economics` | FL-17 | `EconomicAssessment` |
| `scr_FL_Task` | FL-18 a FL-19 | `MaintenanceTask` + `IntervalJustification` |
| `scr_FL_PlanPackage` | FL-20 a FL-22 | `MaintenancePlanPackage` |
| `scr_FL_Traceability` | FL-23 a FL-24 | `TraceLink` + `QualityFinding` |
| `scr_FL_ReviewApproval` | FL-25 a FL-26 | `Review` + `Approval` + `VersionSnapshot` |
| `scr_FL_Effectiveness` | FL-27 a FL-28 | `EffectivenessMeasurement` + `ChangeRequest` |

La separación FL-04/05 de FL-06 es deliberada: definir funciones/fallos y seleccionar causalidad son trabajos distintos. La separación FL-17 de FL-18/19 también es deliberada: comparar económicamente alternativas no es lo mismo que diseñar una tarea ejecutable.

## 6. Vistas previas al journey

Antes de entrar en las 28 etapas, el usuario debe poder situar P-101 en tres contextos estructurales independientes:

1. `scr_FL_FLH` — jerarquía funcional/ubicacional;
2. `scr_FL_Taxonomy` — clasificación/taxonomía;
3. `scr_FL_ADR` — relaciones y dependencias del activo.

Son pantallas de primer nivel dentro de **Activos**. No son FL-00 ni etapas metodológicas adicionales.

`cmp_FL_TreePro` será el motor jerárquico reusable para las tres vistas, con datasets y semántica diferentes.

## 7. Modelo de caso

P-101 es el primer caso de demostración, no la arquitectura de la aplicación.

Objeto raíz:

```text
AnalysisCase
```

Un caso referencia objetos maestros y contiene estado de análisis:

```text
AnalysisCase
├── TechnicalObject references
├── Context snapshot
├── Stage executions
├── Evidence
├── Functions
├── Functional failures
├── Failure mode selections
├── Risk assessments
├── RCM decisions
├── Economics
├── Maintenance tasks
├── Plan package
├── Reviews / approvals
├── Version snapshots
├── Effectiveness measurements
└── Change requests
```

## 8. Datos maestros vs datos del análisis

Datos maestros como:

- código de activo;
- nombre del activo;
- jerarquía;
- taxonomía;
- relaciones técnicas;

se consideran **read-only dentro de un caso de análisis**.

El análisis puede registrar un snapshot o contexto específico, pero una corrección del maestro pertenece a otro proceso gobernado.

## 9. Persistencia y borradores

Principio aprobado:

```text
cambio ordinario → borrador

decisión con autoridad → acción explícita Confirmar / Aprobar
```

En el Functional Lab los borradores pueden vivir temporalmente en colecciones/variables. El contrato debe asumir desde el diseño una persistencia remota futura.

No se utilizará un botón `Guardar` como sustituto genérico de la semántica del proceso.

## 10. Separación persona / sistema

Toda pantalla de análisis debe distinguir visual y contractualmente:

```text
existing_input
user_input
system_calculation
system_recommendation
human_decision
gate
output
```

Patrón obligatorio para decisiones relevantes:

```text
SystemResult
SystemRecommendation
HumanDecision
DecisionReason
ActorRole
Timestamp
ValidationStatus
```

Un cálculo nunca se presenta como decisión. Una recomendación nunca se presenta como decisión confirmada.

Si existe override:

```text
recomendación original + decisión final + motivo
```

se conservan conjuntamente.

## 11. Roles

Roles conceptuales iniciales:

```text
ReliabilityEngineering     Ingeniería de Fiabilidad
MaintenancePlanning       Mantenimiento / Planificación
Operations                Operaciones
AssetOwner                Asset Owner / Aprobador
Administrator             Administrador
```

El diseño debe soportar participación de varios roles sobre el mismo `AnalysisCase`.

En el Functional Lab la identidad y concurrencia pueden simularse, pero las decisiones deben conservar `ActorRole` y autoridad requerida.

## 12. Responsive

Objetivo de experiencia completa:

```text
Desktop + Tablet
```

Móvil no se considera requisito funcional completo todavía.

Las pantallas no deben depender de un ancho fijo único. La arquitectura utilizará:

- sidebar colapsable;
- regiones con ancho relativo y mínimos razonables;
- paneles apilables en tablet;
- Process Rail capaz de alternar entre rail lateral y modo compacto.

## 13. Idioma y localización

La experiencia visible actual se mantiene en español.

Desde esta arquitectura los textos se diseñan para catálogo ES/EN mediante claves semánticas. No se implementa todavía el selector runtime como requisito del sprint actual.

Principio:

```text
TranslationKey → locale activo → texto visible
```

No se duplican pantallas por idioma.

## 14. Backend y adaptadores

Se diseñarán contratos pensando especialmente en Azure SQL, sin convertirlo todavía en dependencia irreversible.

```text
Power Apps UI
    ↓
Application / Adapter boundary
    ↓
Conceptual contracts
    ↓
Azure SQL / API / otra implementación futura
```

Durante el Functional Lab:

```text
Fixture JSON / Power Fx collections
```

puede implementar temporalmente el adaptador.

El objetivo es que sustituir el adaptador no obligue a rediseñar pantallas ni reglas funcionales.

## 15. Modelo conceptual persistente

Entidades objetivo iniciales:

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
FailureMode
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

Este modelo se detallará en `domain-contracts.md` y servirá como puente entre Power Fx y un backend futuro.

## 16. Componentes premium reutilizables

Todo componente genérico estable debe diseñarse para posterior promoción a Component Library.

Foundation objetivo:

```text
cmp_FL_SidebarPro        navegación de producto
cmp_FL_PageHeaderPro     cabecera de objeto/proceso
cmp_FL_TreePro           jerarquías profundas
cmp_FL_ProcessRailPro    journey de 28 etapas
cmp_FL_DecisionPanelPro  persona vs sistema
cmp_FL_GatePanelPro      gate explicable
```

Las reglas de negocio no viven dentro de los componentes visuales.

## 17. Automatización e IA

La arquitectura reserva `SystemRecommendation` como origen abstracto.

Una recomendación futura puede proceder de:

- regla determinista;
- analítica;
- motor experto;
- IA.

Hasta que una regla sea aprobada explícitamente como automática, las decisiones con autoridad humana requieren confirmación.

## 18. Estrategia de implementación

A partir de v2 se abandona la construcción secuencial de nueve `WS-*` como objetivo de UI.

Orden de construcción:

```text
A. Arquitectura + ADR + contratos
B. Foundation premium reusable
C. Shell de producto
D. Activos: FLH / Taxonomía / ADR / Asset 360
E. Registro y Overview de AnalysisCase
F. Pantallas del journey por objeto/proceso
G. Planes / Gobernanza / Configuración como módulos coherentes
H. Integración de persistencia futura
```

Los artefactos anteriores WS-01 y WS-02 se conservan como evidencia funcional y fuente de reglas, pero dejan de ser la arquitectura definitiva de pantallas.

## 19. Criterio de autenticidad

Una pantalla solo se considera válida si un usuario puede responder:

1. ¿Qué objeto de negocio estoy viendo?
2. ¿Qué puedo hacer aquí?
3. ¿Qué información viene del sistema?
4. ¿Qué debo decidir yo?
5. ¿Qué responsabilidad/rol interviene?
6. ¿Qué gate condiciona el avance?
7. ¿Qué queda persistido o disponible después?

Si la pantalla solo explica el prototipo o resume etapas sin permitir trabajo real, no cumple la arquitectura v2.
