# CMMS 2.0 — Paquete documental funcional para IT

## 1. Propósito

Definir un conjunto modular de documentos para trasladar a IT el modelo funcional validado sin crear una única especificación monolítica.

El paquete se alimentará progresivamente con los resultados del Functional Lab.

## 2. Principio

> Cada documento responde a una pregunta distinta y todos se relacionan mediante identificadores trazables.

No se duplicará el mismo requisito en varios documentos con redacciones diferentes.

Para Ingeniería de Fiabilidad, el handoff debe respetar además:

```text
Engineering Library
→ Asset Application
→ Execution Plan
→ Results & Learning
```

La documentación de IT no debe volver a fusionar estas capas por comodidad de implementación.

## 3. Estructura objetivo

```text
07-it-handoff/
├── functional-document-set.md
├── 01-context/
│   ├── product-context.md
│   ├── scope-and-boundaries.md
│   └── glossary.md
├── 02-process/
│   ├── end-to-end-process.md
│   ├── stage-catalog.md
│   └── human-system-responsibility.md
├── 03-functional-requirements/
│   ├── requirements-catalog.md
│   ├── business-rules.md
│   ├── validations-and-gates.md
│   └── open-functional-questions.md
├── 04-data/
│   ├── conceptual-data-model.md
│   ├── entity-catalog.md
│   ├── relationships.md
│   └── data-dictionary.md
├── 05-ui/
│   ├── screen-map.md
│   ├── navigation-model.md
│   └── screens/
├── 06-roles/
│   ├── business-roles.md
│   └── responsibility-matrix.md
├── 07-integrations/
│   ├── system-boundaries.md
│   ├── functional-contracts.md
│   └── integration-requirements.md
├── 08-non-functional/
│   └── non-functional-requirements.md
└── 09-traceability/
    ├── decision-register.md
    ├── requirement-traceability.md
    └── unresolved-decisions.md
```

Las carpetas se materializarán a medida que exista contenido consolidado. No se crearán documentos vacíos solo para completar la estructura.

## 4. Documento 01 — Contexto

Responde:

- qué problema resuelve CMMS 2.0;
- qué queda dentro y fuera del alcance;
- qué términos deben interpretarse de forma consistente.

No contiene detalle de pantallas ni tablas técnicas.

## 5. Documento 02 — Proceso

Responde:

- cómo fluye el negocio;
- qué capas y etapas existen;
- qué precedencias hay;
- qué decisiones son humanas;
- qué acciones puede realizar el sistema;
- cuándo un cambio debe afectar a biblioteca y cuándo solo a una aplicación/plan.

Fuente principal inicial: `02-functional/process-model/functional-journey.md`.

## 6. Documento 03 — Requisitos y reglas

Contiene requisitos identificables y verificables.

Convenciones propuestas:

```text
FR-[DOMAIN]-NNN   requisito funcional
BR-[DOMAIN]-NNN   regla de negocio
VAL-[DOMAIN]-NNN  validación
GATE-[DOMAIN]-NNN gate funcional
```

Cada requisito debe incluir:

- descripción;
- razón;
- actor;
- capa/objeto afectado;
- precondición;
- resultado;
- regla asociada;
- estado;
- fuente de decisión;
- evidencia de validación.

## 7. Documento 04 — Datos

Describe el modelo conceptual, no la implementación SQL.

Debe diferenciar:

- entidad de negocio;
- atributos;
- relaciones;
- cardinalidad;
- ciclo de vida;
- ownership;
- revisión/versionado;
- datos maestros;
- datos de ingeniería reusable;
- datos de aplicación contextual;
- datos de planificación;
- datos transaccionales/resultados;
- datos derivados.

Para AMEF/RCM la fuente canónica inicial es `03-data-model/core/fmea-library-model.md`.

Relaciones que IT debe conservar conceptualmente aunque cambie la implementación física:

```text
FmeaDefinition 1:N FmeaRevision
MaintenanceTask N:M FailureMode
FmeaRevision N:M Asset mediante FmeaAssetApplication
FmeaAssetApplication → ExecutionPlan
ExecutionPlanTask → MaintenanceResult
```

Las decisiones físicas de base de datos corresponden posteriormente a IT.

## 8. Documento 05 — UI

Se genera a partir de workspaces funcionalmente validados.

Cada pantalla incluirá:

```text
Screen ID
Purpose
Active layer
Primary domain object
Actors
Entry conditions
Inputs
Existing information
User actions
System actions
Human decisions
Gates
Outputs
States
Navigation
Permissions hypothesis
Related requirements
Related entities
Traceability requirement
Open questions
```

La pantalla del Functional Lab puede inspirar esta especificación, pero no obliga a IT a reproducir el mismo layout.

## 9. Documento 06 — Roles

Describe responsabilidades de negocio, no grupos técnicos de seguridad.

Debe aclarar:

- quién crea;
- quién revisa;
- quién decide;
- quién aprueba;
- quién puede hacer override;
- quién mantiene catálogos y reglas;
- qué autoridad puede modificar biblioteca frente a una aplicación contextual.

## 10. Documento 07 — Integraciones

Debe identificar necesidades funcionales sin imponer prematuramente su tecnología.

Ejemplo corregido:

```text
Necesidad: obtener criticidad vigente del activo
Origen lógico: Asset Management
Consumidor: FmeaAssetApplication
Momento: evaluación de aplicabilidad de una revisión publicada sobre un activo
Comportamiento si falta: Requires Review / gate según regla validada
Efecto sobre FmeaRevision: ninguno
Tecnología: pendiente de arquitectura IT
```

La criticidad no se utiliza como sustituto de la matriz de riesgo AMEF.

Otros contratos futuros deberán distinguir claramente si alimentan:

- Engineering Library;
- Asset Application;
- Execution Plan;
- Results.

## 11. Documento 08 — No funcionales

Agrupa requisitos como:

- auditabilidad;
- trazabilidad;
- versionado;
- inmutabilidad;
- seguridad;
- accesibilidad;
- rendimiento;
- localización;
- observabilidad;
- concurrencia.

Para AMEF/RCM debe exigirse que una ejecución pueda reconstruir la revisión exacta de ingeniería y aplicación que la originaron.

## 12. Documento 09 — Trazabilidad

Debe permitir recorrer dos perspectivas complementarias.

### Trazabilidad documental

```text
Decisión de reunión
→ requisito
→ regla
→ etapa del journey
→ workspace
→ entidad
→ contrato
→ prueba / evidencia
```

### Lineage funcional

```text
FmeaDefinition
→ FmeaRevision
→ FailureMode
→ RcmAssessment
→ MaintenanceTask | NoScheduledTaskDecision
→ FmeaAssetApplication
→ ExecutionPlan
→ MaintenanceResult
→ EffectivenessReview
```

## 13. Estados documentales

Los elementos funcionales usarán estados explícitos:

```text
hypothesis
proposed
to_validate
validated
approved
superseded
```

Una decisión de prototipo no debe aparecer en un handoff a IT como requisito aprobado si todavía está en validación.

## 14. Relación con el Functional Lab

El laboratorio actuará como generador de evidencia:

| Descubrimiento en Lab | Documento afectado |
|---|---|
| dato necesario | data / requirement |
| capa propietaria del dato | process / data / integration |
| decisión humana | process / roles / requirement |
| cálculo | business rule |
| recomendación | business rule / UI |
| gate | validations-and-gates |
| nueva pantalla | UI / screen map |
| dependencia externa | integrations |
| override | rules / roles / traceability |
| relación N:M | data / requirement / UI |
| revisión/snapshot | data / NFR / traceability |
| duda | open-functional-questions |

## 15. Criterio de entrega a IT

Un dominio estará preparado para handoff cuando:

1. el flujo y sus capas estén validados;
2. las decisiones persona/sistema estén claras;
3. los requisitos principales tengan identificador;
4. las reglas críticas estén documentadas y versionables cuando aplique;
5. el modelo conceptual de datos sea coherente;
6. las cardinalidades críticas estén explícitas;
7. las pantallas necesarias estén descritas por responsabilidad funcional;
8. las dependencias externas estén identificadas por consumidor lógico;
9. las preguntas abiertas estén explícitas;
10. exista trazabilidad suficiente hacia las decisiones de origen y entre capas del dominio.
