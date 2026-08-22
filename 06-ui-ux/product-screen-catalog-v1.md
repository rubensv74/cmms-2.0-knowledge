# CMMS 2.0 — Product Screen Catalog v1

**Fecha:** 2026-08-22  
**Estado:** active baseline  
**Scope:** interfaz futura hasta publicación del plan de mantenimiento.

## 1. Regla de diseño

Cada pantalla declara un trabajo dominante y un arquetipo SaaS dominante.

No se usa un arquetipo solo para variar visualmente la aplicación.

Arquetipos canónicos disponibles en `functional-engineering-knowledge-base`:

- Operational Review Workspace;
- Agent / Case Workspace;
- Data Explorer;
- Object 360;
- Operational Control Tower;
- Planning Board;
- Workflow Builder;
- Configuration Studio;
- Import & Mapping Wizard;
- Audit Timeline;
- Exception Resolution Queue.

Los árboles FLH/Taxonomy/ADR se consideran **patrones de interacción secundarios**; no se inventa un nuevo arquetipo `Tree Builder` cuando la tarea dominante encaja en Configuration Studio, Data Explorer u Object 360.

## 2. Shell global

Todas las pantallas comparten:

- Project/Corporate context selector;
- global search;
- sidebar agrupado;
- Needs Attention;
- help/contextual guidance;
- user/role context;
- semantic status language;
- command/action area;
- loading/empty/error states;
- dirty guard;
- version context when applicable.

## 3. Catálogo canónico

| ID | Módulo | Pantalla | Trabajo principal | Arquetipo dominante | Patrones secundarios |
|---|---|---|---|---|---|
| SCR-001 | Home | Portfolio Overview | Ver proyectos, madurez y dónde actuar | Operational Control Tower | KPI strip, Needs Attention |
| SCR-002 | Home | Project Home / Needs Attention | Entender estado del proyecto y abrir trabajo prioritario | Operational Control Tower | Exception Resolution Queue, shortcuts |
| SCR-010 | Project Setup | Project Profile | Definir identidad, ámbito y parámetros base del proyecto | Configuration Studio | form sections, impact hints |
| SCR-011 | Project Setup | Maintenance Configuration | Gobernar opciones de mantenimiento del proyecto | Configuration Studio | impact analysis, tabs |
| SCR-012 | Project Setup | Risk Profile / Matrix Configuration | Crear/versionar dimensiones, niveles, matriz y overrides | Configuration Studio | matrix editor, version comparison |
| SCR-013 | Project Setup | Project Teams & Roles | Asignar responsabilidades y autoridades | Configuration Studio | role matrix, approval routing preview |
| SCR-020 | Corporate Libraries | Equipment Taxonomy Library | Gobernar clases de equipo y conocimiento asociado | Configuration Studio | taxonomy tree, Object 360 detail, 3D hero |
| SCR-021 | Corporate Libraries | Technical Fields Library | Crear/gobernar campos, unidades, value lists y aplicabilidad | Configuration Studio | Data Explorer, impact panel |
| SCR-022 | Corporate Libraries | Failure Knowledge Library | Encontrar y gobernar failure modes/mechanisms reutilizables | Data Explorer | inspector, governance status |
| SCR-023 | Corporate Libraries | Maintenance Task Library | Encontrar/crear tareas estándar reutilizables | Data Explorer | inspector, versioning |
| SCR-024 | Corporate Libraries | Job Plan Library | Gobernar plantillas de Job Plan | Data Explorer | Object 360 preview, revisions |
| SCR-025 | Corporate Libraries | RCM Model Library | Configurar modelos/preguntas/ramas RCM | Workflow Builder | Configuration Studio, validation/simulation |
| SCR-026 | Corporate Libraries | Equipment Visual Library | Gobernar imágenes 3D, variantes y fallbacks por clase | Data Explorer | visual gallery, Object 360 preview |
| SCR-030 | Assets | FLH Builder | Crear y validar la jerarquía funcional/localización | Configuration Studio | hierarchical tree, node inspector, validation queue |
| SCR-031 | Assets | Project Taxonomy Builder | Seleccionar/excluir/extender la taxonomía corporativa | Configuration Studio | taxonomy tree, compare Corporate vs Project, 3D preview |
| SCR-032 | Assets | ADR Builder | Crear/gobernar la composición física de activos | Configuration Studio | physical tree, Object 360 inspector, 3D visual |
| SCR-033 | Assets | Asset Register | Buscar, filtrar, comparar y mantener muchos activos | Data Explorer | filter rail, bulk actions, inspector |
| SCR-034 | Assets | Asset 360 | Comprender un activo concreto y todas sus relaciones | Object 360 | contextual tabs, activity/history, 3D/photo hero |
| SCR-035 | Assets | Criticality Assessment | Evaluar activos con el modelo de criticidad configurado | Operational Review Workspace | queue, matrix/radar summary, inspector |
| SCR-040 | Maintenance Engineering | AMEF / FMEA Workspace | Analizar múltiples funciones/fallos/modos y completar AMEF | Operational Review Workspace | matrix/table, queue, inspector, risk profile context |
| SCR-041 | Maintenance Engineering | RCM Analysis | Investigar un modo y confirmar política mediante lógica explicable | Agent / Case Workspace | decision tree, evidence, human approval |
| SCR-042 | Maintenance Engineering | Maintenance Task Definition | Convertir políticas en tareas ejecutables/frecuencias justificadas | Operational Review Workspace | technical/economic rationale, inspector |
| SCR-043 | Maintenance Engineering | Applicability & Asset Overrides | Decidir dónde aplica un plan base y gestionar excepciones | Data Explorer | exception resolution, inspector, compare |
| SCR-050 | Maintenance Planning | Job Plans | Componer tareas, recursos, herramientas, permisos y secuencia | Configuration Studio | task table, dependency editor, reusable template lookup |
| SCR-051 | Maintenance Planning | Maintenance Strategies | Agrupar política/tareas/Job Plans en estrategias mantenibles | Configuration Studio | object summary, impact analysis |
| SCR-052 | Maintenance Planning | Maintenance Plan | Consolidar estrategias aplicables en el plan del proyecto | Data Explorer | readiness KPIs, inspector, filters |
| SCR-053 | Maintenance Planning | Plan Review & Publication | Revisar un paquete, resolver blockers y publicar versión | Agent / Case Workspace | checklist, approval trail, version summary |
| SCR-060 | Governance | Reviews & Approvals | Procesar elementos pendientes de revisión/aprobación | Exception Resolution Queue | Operational Review Workspace, filters |
| SCR-061 | Governance | Versions & Publication Status | Consultar, comparar y gobernar versiones/publicaciones | Data Explorer | version compare, publication status |
| SCR-062 | Governance | Audit & Traceability | Reconstruir decisiones, cambios, actores y versiones | Audit Timeline | filters, object drill-down |
| SCR-063 | Governance | Library Promotion Requests | Revisar extensiones project-specific candidatas a corporate | Exception Resolution Queue | impact analysis, compare, approval action |
| SCR-070 | Administration | Users & Global Roles | Gobernar usuarios y permisos globales | Configuration Studio | role matrix, audit |
| SCR-071 | Administration | Global Configuration | Gobernar parámetros transversales | Configuration Studio | impact warnings, versioning |

## 4. Pantallas que deliberadamente NO existen todavía

No se crean en esta baseline:

- Work Candidate Queue;
- Maintenance Planning Board temporal;
- Scheduling Board;
- Work Order Workspace;
- Technician Execution;
- Field Feedback;
- Actual Cost Workspace;
- Contract/Billing surfaces.

Estas funciones pertenecen al siguiente dominio de Work Management y no deben diseñarse hasta superar sus gates de discovery.

## 5. Risk Profile / Matrix Configuration

`SCR-012` debe ser una superficie de producto de primer nivel, no un modal escondido dentro de AMEF.

### Anatomy propuesta

```text
Risk Profiles / versions
        │
        ├── Matrix Preview
        ├── Dimensions
        │   ├── Dimension A
        │   │   └── levels / labels / ranges
        │   └── Dimension B...
        ├── Calculation / band rules
        ├── Risk categories
        ├── Colors / semantic labels
        ├── Override rules
        ├── Consumers / impact
        └── Versions / approval
```

La pantalla debe soportar perfiles que no sean necesariamente 5×5 y dejar abierta la posibilidad de más de dos dimensiones lógicas, aun cuando una matriz 2D requiera seleccionar/proyectar dos dimensiones para visualización.

## 6. Equipment Taxonomy Library

`SCR-020` es una de las superficies fundacionales del producto.

Anatomía propuesta:

```text
Corporate taxonomy tree
        │
        ├── Selected class
        │   ├── 3D hero visual
        │   ├── definition
        │   ├── synonyms
        │   ├── external mappings
        │   ├── technical fields
        │   ├── failure knowledge
        │   ├── maintenance knowledge
        │   ├── documents/standards
        │   └── governance/version
        │
        └── Usage / impact
            ├── projects using class
            ├── asset instances
            ├── local extensions
            └── pending promotion/change requests
```

## 7. Project Taxonomy Builder

`SCR-031` no edita directamente la biblioteca corporativa.

Acciones:

- include/exclude corporate classes;
- include/exclude branches;
- inspect inherited technical fields;
- inspect 3D class visual;
- create project-specific extension;
- compare Corporate vs Project;
- submit promotion request;
- review impact of corporate version update.

## 8. ADR Builder

`SCR-032` representa la composición física y por tanto debe distinguir visualmente:

- package;
- equipment;
- maintainable component when modeled as asset;
- parent/child relationship;
- link to FLH;
- link to Taxonomy Class;
- completeness state;
- documents/technical fields;
- actual photo vs class 3D fallback.

No se utilizará ADR como árbol de localización.

## 9. Asset 360

`SCR-034` será la vista integral del registro físico.

Tabs candidatos:

- Overview;
- Technical Data;
- Maintenance Engineering;
- Maintenance Plans;
- Documents;
- Relationships;
- History / Traceability.

El hero visual puede mostrar:

```text
real asset image
OR
3D image inherited from Taxonomy Class
```

## 10. Regla de reutilización de imágenes 3D

Las imágenes grandes se reservan para superficies donde ayudan a reconocer/comprender el objeto:

- Taxonomy Library;
- Project Taxonomy;
- ADR Builder;
- Asset 360.

En Data Explorers se usan thumbnails.

En AMEF/RCM se utiliza una miniatura contextual; no debe robar espacio al trabajo analítico.

## 11. Navegación principal candidata

```text
HOME
- Portfolio
- Project Home

PROJECT SETUP
- Project Profile
- Maintenance Configuration
- Risk Profile
- Teams & Roles

ASSETS
- FLH Builder
- Project Taxonomy
- ADR Builder
- Asset Register
- Asset 360 (contextual)
- Criticality

LIBRARIES
- Equipment Taxonomy
- Technical Fields
- Failure Knowledge
- Maintenance Tasks
- Job Plans
- RCM Models
- Equipment Visuals

MAINTENANCE ENGINEERING
- AMEF / FMEA
- RCM
- Task Definition
- Applicability / Overrides

PLANS
- Job Plans
- Strategies
- Maintenance Plan
- Review & Publication

GOVERNANCE
- Reviews & Approvals
- Versions
- Audit & Traceability
- Promotion Requests

ADMINISTRATION
- Users & Roles
- Global Configuration
```

La visibilidad de ítems debe depender de rol y contexto; no todos los usuarios necesitan ver administración o bibliotecas corporativas.

## 12. Criterio de congelación

Una pantalla se considera canónica cuando:

- tiene tarea primaria;
- arquetipo dominante;
- inputs/outputs funcionales;
- owner/rol objetivo;
- estados principales;
- lugar claro en navegación;
- dependencia de datos identificada;
- no solapa de forma innecesaria otra superficie.

El siguiente paso será elaborar contratos de pantalla empezando por las superficies fundacionales de datos maestros y configuración.
