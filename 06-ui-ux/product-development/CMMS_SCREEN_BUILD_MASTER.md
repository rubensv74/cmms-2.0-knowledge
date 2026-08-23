# CMMS 2.0 — Screen Build Master

**Última actualización:** 2026-08-23  
**Rama:** `baseline/premium-powerapps-v1`  
**Ámbito:** pantallas desarrollables de CMMS 2.0 hasta `Published Maintenance Plan`.

## 1. Propósito

Este documento es la **fuente operativa de verdad para el orden y estado de construcción de pantallas**.

No sustituye al Product Map ni al Screen Catalog. Los complementa:

- `Product Map` = qué producto queremos construir;
- `Screen Catalog` = qué pantallas existen y cuál es su trabajo dominante;
- `Screen Build Master` = en qué orden las construimos, de qué dependen, qué las bloquea y dónde estamos hoy.

Debe actualizarse cada vez que una pantalla:

- obtiene contrato funcional;
- genera un candidato Source Code;
- pasa un gate de Power Apps Studio;
- cambia de dependencia o bloqueo;
- se promueve a baseline estable.

---

## 2. Estados usados

### Madurez conceptual

| Nivel | Significado |
|---|---|
| `ALTA` | Propósito, límites y lógica principal suficientemente cerrados para construir. |
| `MEDIA` | La pantalla está justificada y su dominio es claro, pero faltan contratos o decisiones de detalle. |
| `DISCOVERY` | Hay comportamiento relevante sin validar. No debe construirse como regla definitiva. |

### Estado de construcción

| Estado | Significado |
|---|---|
| `STUDIO_VALIDATED` | Candidato probado en Power Apps Studio. |
| `FOUNDATION_VALIDATED` | Estructura compartida validada, pero la profundidad funcional de la pantalla aún crecerá. |
| `CANDIDATE_READY` | YAML/candidato listo para pegar; pendiente de gate Studio. |
| `READY_TO_BUILD` | Contrato suficientemente cerrado; puede comenzar `CREATE_NEW_SCREEN`. |
| `READY_FOR_CONTRACT` | Dominio suficientemente claro para redactar el contrato de pantalla. |
| `CONTRACT_PENDING` | Pantalla prevista, pero su contrato todavía no está cerrado. |
| `DEFERRED` | Se puede diseñar más adelante sin bloquear la secuencia actual. |
| `DISCOVERY_BLOCKED` | No construir comportamiento definitivo hasta resolver discovery. |

---

## 3. Foto actual

| Elemento | Estado |
|---|---|
| Premium Shell / Shared UI Foundation RC0 | `STUDIO_VALIDATED` |
| `scr_Home_I01` — integración de Sidebar + Project Context + Page Header + State Panel | `STUDIO_VALIDATED` |
| `SCR-010 Project Profile S01` | `STUDIO_VALIDATED` para estados base/dirty/save; hardening menor puede continuar |
| `SCR-011 Maintenance Configuration S01` | `STUDIO_VALIDATED` — provenance + dirty state confirmados en Studio |
| `SCR-012 Risk Profile / Matrix Configuration S01` | `CANDIDATE_READY` |
| Próxima pantalla tras validar SCR-012 | `SCR-013 Project Teams & Roles` |

Shared UI Foundation validada:

- `cmp_CMMS_PageHeaderPro_RC0`;
- `cmp_CMMS_ProjectContextPro_RC0`;
- `cmp_CMMS_StatePanelPro_RC0`;
- `cmp_CMMS_SidebarPro_RC0`.

---

# 4. Orden maestro de construcción

| Orden | ID | Módulo | Pantalla | Propósito en CMMS | Lógica de negocio principal | Dependencias | Bloqueo / gate antes de construir | Madurez | Estado actual | Siguiente acción |
|---:|---|---|---|---|---|---|---|---|---|---|
| 01 | SCR-002 | Home | **Project Home / Needs Attention** | Dar contexto del proyecto y señalar la siguiente acción útil. | Selección/aceptación de proyecto; readiness; señales de configuración; accesos directos; no mostrar alertas de Work Management aún inexistentes. | Shared UI Foundation; Project Setup para señales reales. | La foundation ya está validada; la profundidad funcional final depende de SCR-010..013. | ALTA | `FOUNDATION_VALIDATED` | Completar contenido de readiness/Needs Attention después de Teams & Roles. |
| 02 | SCR-010 | Project Setup | **Project Profile** | Definir identidad, ámbito y contexto base del proyecto. | ProjectCode/Name; descripción; BU; Site/Plant; país; zona horaria; idioma; scope; validación; dirty state; draft local. | Shared UI Foundation; Project context. | Sin bloqueo para provider sintético. Unicidad real de ProjectCode queda para backend. | ALTA | `STUDIO_VALIDATED` | Hardening menor y conservar como patrón Configuration Studio. |
| 03 | SCR-011 | Project Setup | **Maintenance Configuration** | Definir cómo se comporta CMMS para el proyecto. | Corporate Default vs Project Override vs Project Specific; opciones de ingeniería y governance; draft/version; reset/inheritance. | Project Profile; Shared UI Foundation. | Gate Studio superado: provenance y dirty state validados. | ALTA | `STUDIO_VALIDATED` | Mantener como patrón de settings con provenance; hardening local menor no bloqueante. |
| 04 | SCR-012 | Project Setup | **Risk Profile / Matrix Configuration** | Configurar y versionar el modelo de riesgo consumido por Criticality y AMEF. | Dimensiones; niveles; rangos; bandas; colores semánticos; reglas; overrides; preview; versionado; no hardcodear 5×5. | Project Profile; Maintenance Configuration; Shared UI Foundation. | S01 debe demostrar un perfil 5×5 y otro 4×4 con la misma UI. | ALTA | `CANDIDATE_READY` | Validar `scr_RiskProfile_S01_Candidate.pa.yaml` en Studio. |
| 05 | SCR-013 | Project Setup | **Project Teams & Roles** | Definir responsabilidades y autoridad dentro del proyecto. | Roles requeridos; asignaciones; vacantes; authority scope; cobertura; preview de routing/aprobación. | Project Profile; configuración de proyecto. | Identity/security productiva no está congelada; usar principals sintéticos. | ALTA | `READY_TO_BUILD` | Crear después de Risk Profile. |
| 06 | SCR-001 | Home | **Portfolio Overview** | Ver proyectos accesibles, madurez y dónde actuar. | Lista de proyectos; setup completeness; Risk Profile status; Needs Attention summary; abrir proyecto. | Projects; Project Setup readiness. | Conviene construirlo cuando existan señales reales de P01 para evitar KPIs ficticios. | ALTA | `READY_TO_BUILD` | Construir al cerrar P01 Project Setup. |
| 07 | SCR-020 | Corporate Libraries | **Equipment Taxonomy Library** | Gobernar la clasificación corporativa de equipos y su conocimiento asociado. | Árbol de clases; definición; sinónimos; mappings; technical fields; failure/maintenance links; governance/version; 3D hero. | Taxonomy Foundation; governance Corporate/Project. | Investigación de familias en paralelo; UI puede usar dataset sintético gobernado. | ALTA | `READY_FOR_CONTRACT` | Cerrar contrato de pantalla y primera familia Rotating Equipment. |
| 08 | SCR-021 | Corporate Libraries | **Technical Fields Library** | Gobernar atributos técnicos reutilizables por clase de equipo. | Field definitions; datatype; units; value lists; required/optional; applicability; version/impact. | Equipment Taxonomy model; units/value-list semantics. | Afinar contrato de aplicabilidad y unidades antes de congelar SQL. | MEDIA | `READY_FOR_CONTRACT` | Redactar contrato después de Taxonomy Library. |
| 09 | SCR-026 | Corporate Libraries | **Equipment Visual Library** | Gobernar imágenes 3D y fallbacks visuales por clase. | VisualId; taxonomy class; hero/thumbnail/icon; default; variant; fallback; version/status. | Equipment Taxonomy. | Biblioteca de renders 3D se desarrolla en paralelo; no bloquea UI. | ALTA | `READY_FOR_CONTRACT` | Definir contrato y cargar primera familia visual. |
| 10 | SCR-022 | Corporate Libraries | **Failure Knowledge Library** | Reutilizar conocimiento de fallos entre equipos y proyectos. | Failure modes; mechanisms/causes; effects patterns; mappings; applicability; governance/version. | Equipment Taxonomy; engineering knowledge model. | Ampliar estudio de failure taxonomy por familia. | MEDIA | `READY_FOR_CONTRACT` | Cerrar modelo lógico y dataset sintético. |
| 11 | SCR-023 | Corporate Libraries | **Maintenance Task Library** | Gobernar tareas estándar reutilizables. | Task type; instruction intent; trigger/frequency basis; acceptance criteria; reaction; skills/tools/material hooks; version. | Failure Knowledge; taxonomy; RCM/task semantics. | Separar claramente Task vs Job Plan vs future Checksheet. | MEDIA | `READY_FOR_CONTRACT` | Cerrar semántica de tarea estándar. |
| 12 | SCR-024 | Corporate Libraries | **Job Plan Library** | Gobernar plantillas de trabajo reutilizables. | Secuencia; tareas; recursos; herramientas; materiales; condiciones; permisos; revisiones. | Maintenance Task Library. | Modelo detallado de recursos/materiales aún parcial; limitar S01 a scope validado. | MEDIA | `CONTRACT_PENDING` | Definir contrato funcional mínimo sin invadir Work Management. |
| 13 | SCR-025 | Corporate Libraries | **RCM Model Library** | Configurar modelos de decisión RCM reutilizables y explicables. | Preguntas; ramas; condiciones; outcomes; versionado; validación/simulación; trazabilidad. | RCM conceptual model; governance. | No introducir scoring acumulado no validado. | ALTA | `READY_FOR_CONTRACT` | Cerrar contrato de Workflow Builder. |
| 14 | SCR-030 | Assets | **FLH Builder** | Crear y validar la jerarquía funcional/localización del proyecto. | Nodos jerárquicos; tipos/niveles; parent-child; códigos; validación; completeness; import/edición futura. | Project Setup; location rules. | Nomenclatura exacta de niveles debe mantenerse configurable. | ALTA | `READY_FOR_CONTRACT` | Cerrar contrato de árbol y estados de validación. |
| 15 | SCR-031 | Assets | **Project Taxonomy Builder** | Seleccionar, excluir y extender la taxonomía corporativa para un proyecto. | Incluir/excluir ramas; herencia; extensión project-specific; compare Corporate vs Project; promotion request; 3D preview. | Equipment Taxonomy Library; Project Setup. | Requiere Corporate Taxonomy dataset gobernado. | ALTA | `READY_FOR_CONTRACT` | Construir tras Taxonomy Library. |
| 16 | SCR-032 | Assets | **ADR Builder** | Construir el registro físico maestro y la composición de activos. | Package/equipment/component; parent-child; vínculo a FLH; vínculo a Taxonomy Class; completeness; technical/document context. | FLH; Project Taxonomy; Technical Fields. | No confundir ADR con localización. Requiere IDs estables. | ALTA | `READY_FOR_CONTRACT` | Cerrar contrato físico y dataset sintético. |
| 17 | SCR-033 | Assets | **Asset Register** | Buscar, filtrar y mantener el conjunto de activos del proyecto. | Data Explorer; filtros; edición/bulk candidate; status; taxonomy/location; technical completeness; inspector. | ADR; FLH; Project Taxonomy; Technical Fields. | Import productivo desde Handover/ALEP no se congela aún; usar provider sintético. | ALTA | `READY_FOR_CONTRACT` | Diseñar read model y acciones lógicas. |
| 18 | SCR-034 | Assets | **Asset 360** | Comprender un activo y todas sus relaciones. | Overview; technical data; maintenance engineering; plans; docs; relationships; traceability; real photo/3D fallback. | Asset Register y relaciones maestras. | Requiere relaciones estables entre Asset, FLH y Taxonomy. | ALTA | `READY_FOR_CONTRACT` | Cerrar tabs y contratos read-only iniciales. |
| 19 | SCR-035 | Assets | **Criticality Assessment** | Evaluar criticidad de activos con reglas configuradas. | Criterios; cálculo; risk/criticality position; human review/override; evidence; traceability. | Asset Register; Risk Profile. | Afinar metodología de criticidad y límites del override humano. | MEDIA | `CONTRACT_PENDING` | Cerrar contrato antes de AMEF. |
| 20 | SCR-040 | Maintenance Engineering | **AMEF / FMEA Workspace** | Analizar funciones, fallos y riesgo de forma trazable. | Functions; functional failures; failure modes; causes/mechanisms; effects; existing controls; risk; evidence; readiness hacia RCM. | Asset context; Risk Profile; Criticality; Failure Knowledge. | Riesgo debe venir del RiskProfileVersion activo; no matriz fija. | ALTA | `READY_FOR_CONTRACT` | Reutilizar conocimiento histórico P-101 solo como fixture, no arquitectura. |
| 21 | SCR-041 | Maintenance Engineering | **RCM Analysis** | Confirmar la política de mantenimiento mediante lógica explicable y autoridad humana. | Consecuencia; preguntas RCM; evidence; feasibility; policy outcome; human confirmation; decision trace. | AMEF; RCM Model Library. | Árbol/modelo debe ser configurable/versionado; no scoring inventado. | ALTA | `READY_FOR_CONTRACT` | Cerrar contrato del Case Workspace. |
| 22 | SCR-042 | Maintenance Engineering | **Maintenance Task Definition** | Convertir políticas RCM en tareas mantenibles y justificadas. | Task intent; frequency basis; acceptance criteria; reaction; skill/tool/material hooks; rationale/evidence. | RCM; Maintenance Task Library. | Semántica Task/Job Plan/Checksheet debe permanecer separada. | MEDIA | `READY_FOR_CONTRACT` | Cerrar contrato de task engineering. |
| 23 | SCR-043 | Maintenance Engineering | **Applicability & Asset Overrides** | Decidir dónde aplica la estrategia base y gestionar excepciones sin mutarla. | Candidate assets; include/exclude; base definition; asset-specific override; reason/evidence; impact/trace. | Asset Register; Task Definition; Strategies base. | Regla obligatoria: editar excepción nunca modifica el plan base. | ALTA | `READY_FOR_CONTRACT` | Cerrar read model y operaciones de override. |
| 24 | SCR-050 | Maintenance Planning | **Job Plans** | Componer trabajo ejecutable a partir de tareas y plantillas. | Secuencia; task linkage; resources; tools; materials; conditions; permits; reusable template lookup. | Task Definition; Job Plan Library. | Recursos/materiales detallados aún parciales; no invadir ejecución futura. | MEDIA | `CONTRACT_PENDING` | Definir S01 limitado al alcance validado. |
| 25 | SCR-051 | Maintenance Planning | **Maintenance Strategies** | Agrupar políticas, tareas y Job Plans en una estrategia mantenible. | Strategy scope; class/asset applicability; policy; tasks; job plans; frequency logic; impact. | RCM; Task Definition; Job Plans. | Necesita contratos anteriores estabilizados. | ALTA | `READY_FOR_CONTRACT` | Cerrar objeto Strategy y relaciones. |
| 26 | SCR-052 | Maintenance Planning | **Maintenance Plan** | Consolidar el resultado de ingeniería en el plan del proyecto. | Strategies; tasks; job plans; assets/scope; frequencies; applicability; overrides; readiness/completeness. | Strategies; Applicability; Asset Register; Job Plans. | No incorporar todavía WO/scheduling/execution. | ALTA | `READY_FOR_CONTRACT` | Definir paquete de plan y readiness. |
| 27 | SCR-060 | Governance | **Reviews & Approvals** | Procesar decisiones pendientes de revisión y aprobación. | Queue; reviewer/approver; status; comments; approve/reject/request changes; routing evidence. | Teams & Roles; governed objects. | Routing exacto depende del proyecto; no hardcodear Supervisor universal. | MEDIA | `READY_FOR_CONTRACT` | Cerrar routing lógico y authority checks. |
| 28 | SCR-061 | Governance | **Versions & Publication Status** | Consultar, comparar y gobernar versiones. | Draft/active/published; compare; effective date; superseded; immutable published reference. | Versioned domain objects. | Requiere política común de versionado. | MEDIA | `READY_FOR_CONTRACT` | Definir contrato transversal de versión. |
| 29 | SCR-062 | Governance | **Audit & Traceability** | Reconstruir quién cambió qué, cuándo y por qué. | Audit events; decision trace; object/version links; actor; reason/evidence; timeline/filtering. | IDs estables; logical write operations; versions. | Persistencia final se define al estabilizar writes. | ALTA | `READY_FOR_CONTRACT` | Definir audit event contract. |
| 30 | SCR-053 | Maintenance Planning | **Plan Review & Publication** | Resolver blockers y publicar una versión gobernada del Maintenance Plan. | Readiness checklist; blockers/warnings; package review; approval trail; version summary; publish/freeze. | Maintenance Plan; Reviews & Approvals; Versions; Audit; Teams & Roles. | Publicación solo si gates están cumplidos. Fin del scope actual. | ALTA | `READY_FOR_CONTRACT` | Construir como último gate operativo de v1. |
| 31 | SCR-063 | Governance | **Library Promotion Requests** | Promover conocimiento project-specific a Corporate bajo gobierno. | Candidate extension; compare; impact; approve/reject; corporate version creation/reference. | Project Taxonomy/extensions; Corporate Libraries; governance roles. | Necesita al menos una extensión project-specific real/sintética. | ALTA | `READY_FOR_CONTRACT` | Construir cuando Project Taxonomy esté operativa. |
| 32 | SCR-070 | Administration | **Users & Global Roles** | Gobernar identidades y permisos globales de CMMS. | User/principal; global role; assignment; scope; status; audit. | Identity/security provider. | Security model productivo aún no congelado. No bloquea UI sintética actual. | MEDIA | `DEFERRED` | Retomar antes del provider productivo y rollout. |
| 33 | SCR-071 | Administration | **Global Configuration** | Gobernar parámetros realmente transversales del producto. | Corporate defaults; global policies; provenance; version; impact warnings. | Config domains estabilizados. | No convertirla en un contenedor arbitrario de switches. | MEDIA | `DEFERRED` | Diseñar cuando existan suficientes settings transversales reales. |

---

# 5. Cadena de dependencias principal

```text
Shared UI Foundation
        ↓
Project Profile
        ↓
Maintenance Configuration
        ↓
Risk Profile ───────────────┐
        ↓                   │
Teams & Roles               │
        ↓                   │
Corporate Libraries         │
        ↓                   │
FLH + Project Taxonomy      │
        ↓                   │
ADR                         │
        ↓                   │
Asset Register / Asset 360  │
        ↓                   │
Criticality ◄───────────────┘
        ↓
AMEF
        ↓
RCM
        ↓
Task Definition
        ↓
Job Plans / Strategies
        ↓
Applicability / Overrides
        ↓
Maintenance Plan
        ↓
Reviews / Versions / Audit
        ↓
Plan Review & Publication
        ↓
Published Maintenance Plan
```

---

# 6. Gates que NO deben bloquear el desarrollo actual

Estas capacidades pueden seguir avanzando conceptualmente en reuniones, pero no forman parte del orden de construcción de esta tabla:

- Work Candidates;
- Work Orders;
- Planning / Scheduling;
- Technician Execution;
- checksheets operativos de ejecución;
- actual maintenance cost;
- inventory / storerooms;
- contracts / billing;
- mobile/offline;
- condition monitoring / IoT;
- predictive maintenance;
- advanced reliability analytics.

Cuando una de ellas alcance suficiente madurez conceptual se añadirá a una **fase posterior del Screen Build Master**, no se insertará silenciosamente en v1.

---

# 7. Regla de actualización

Después de cada incremento:

```text
concept decision
→ screen contract
→ candidate YAML
→ Studio gate
→ screenshot/evidence
→ update Screen Build Master
→ next screen
```

Una pantalla no cambia a `STUDIO_VALIDATED` por existir un YAML. Requiere evidencia de Power Apps Studio.
