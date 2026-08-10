# CMMS 2.0 — Paquete documental funcional para IT

## 1. Propósito

Definir un conjunto modular de documentos para trasladar a IT el modelo funcional validado sin crear una única especificación monolítica.

El paquete se alimentará progresivamente con los resultados del Functional Lab.

## 2. Principio

> Cada documento responde a una pregunta distinta y todos se relacionan mediante identificadores trazables.

No se duplicará el mismo requisito en varios documentos con redacciones diferentes.

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
- qué etapas existen;
- qué precedencias hay;
- qué decisiones son humanas;
- qué acciones puede realizar el sistema.

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
- datos maestros;
- datos transaccionales;
- datos derivados.

Las decisiones físicas de base de datos corresponden posteriormente a IT.

## 8. Documento 05 — UI

Se genera a partir de workspaces funcionalmente validados.

Cada pantalla incluirá:

```text
Screen ID
Purpose
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
- quién mantiene catálogos y reglas.

## 10. Documento 07 — Integraciones

Debe identificar necesidades funcionales sin imponer prematuramente su tecnología.

Ejemplo:

```text
Necesidad: obtener criticidad vigente del activo
Origen lógico: Asset Management
Consumidor: AMEF/RCM
Momento: apertura/evaluación del análisis
Comportamiento si falta: requiere revisión
Tecnología: pendiente de arquitectura IT
```

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

## 12. Documento 09 — Trazabilidad

Debe permitir recorrer:

```text
Decisión de reunión
→ requisito
→ regla
→ etapa del journey
→ pantalla/workspace
→ entidad
→ contrato
→ prueba / evidencia
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
| decisión humana | process / roles / requirement |
| cálculo | business rule |
| recomendación | business rule / UI |
| gate | validations-and-gates |
| nueva pantalla | UI / screen map |
| dependencia externa | integrations |
| override | rules / roles / traceability |
| duda | open-functional-questions |

## 15. Criterio de entrega a IT

Un dominio estará preparado para handoff cuando:

1. el flujo esté validado;
2. las decisiones persona/sistema estén claras;
3. los requisitos principales tengan identificador;
4. las reglas críticas estén documentadas;
5. el modelo conceptual de datos sea coherente;
6. las pantallas necesarias estén descritas por responsabilidad funcional;
7. las dependencias externas estén identificadas;
8. las preguntas abiertas estén explícitas;
9. exista trazabilidad suficiente hacia las decisiones de origen.
