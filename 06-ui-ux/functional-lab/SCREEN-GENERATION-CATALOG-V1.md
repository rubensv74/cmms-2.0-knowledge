# CMMS 2.0 — Catálogo y secuencia de generación de pantallas V1

**Estado:** propuesta de trabajo; no aprobada por negocio ni validada en Power Apps Studio.  
**Ámbito:** ordenar el diseño visual de pantallas del producto usando el mapa funcional CMMS, el estándar premium, el catálogo IAP y el protocolo DVP.

Fuentes: [Screen Map V1](../../07-it-handoff/05-ui/screen-map.md), [Premium Screen Standard V1](../CMMS_PREMIUM_SCREEN_STANDARD_V1.md), [Page Header Hierarchy V1](../CMMS_PAGE_HEADER_HIERARCHY_V1.md), [CMMS Component Catalog V1](../CMMS_COMPONENT_CATALOG_V1.md), [Design System](design-system.md), [Architecture](architecture.md).

## 1. Decisión de alcance

El repositorio ya contiene un **mapa de pantallas de producto**, pero está marcado como propuesta, no aprobado y no validado en runtime. No encontré un backlog operativo que ordene su generación visual pantalla por pantalla. Este catálogo cubre ese hueco sin reemplazar ni aprobar el mapa.

Hay que mantener separadas estas superficies:

- **AS-01 Assets List / Hierarchy Explorer:** localizar activos y explorar FLH.
- **AS-04 Equipment Type Library:** administrar tipos de equipo, campos técnicos y mapeos visuales.
- **MSL-01 Maintenance Standards Library:** encontrar estándares corporativos trazables.

No son tres nombres para la misma biblioteca. WS-01…WS-09 tampoco se convertirán en nueve entradas del menú: son workspaces internos de REL-01.

## 2. DVP ya abierto

El [PR #13 — DEC-025: modelo de orden preventiva anual](https://github.com/rubensv74/cmms-2.0-knowledge/pull/13), con su [plan DVP v2](https://github.com/rubensv74/cmms-2.0-knowledge/blob/feat/cmms-annual-preventive-workorder-lab-v1/06-ui-ux/functional-lab/dvp/CMMS-LAB-DVP-NEXT-EXECUTION-PLAN-v2.md), trabaja el recorrido candidato **Work Queue → Annual Order Detail → volver conservando contexto**, con datos sintéticos y solo lectura. Incluye targets SVG, contrato de pantalla, inventario de componentes y readiness findings.

El PR está en draft. Sus targets no están aprobados; la revisión del scope funcional está pendiente; no hay PaYaml de producto ni evidencia de Studio. Se conserva como un slice DVP activo y acotado. **No define el orden del catálogo completo ni sustituye AS-01, MSL-01 o REL-01.**

## 3. Secuencia propuesta de generación visual

| Orden | Superficie | Motivo | Salida DVP esperada |
|---|---|---|---|
| 0 | **App Shell / Foundation** (base compartida, no pantalla de dominio) | Fija navegación, identidad, contexto y gramática visual. La geometría exacta depende del gate de Foundation en Studio. | Baseline de shell, inventario de componentes instalados y evidencia Studio antes de congelar geometría. |
| 1 | **AS-01 — Assets List / Hierarchy Explorer** | Entrada operativa para localizar activos y comprobar que FLH, taxonomía y ADR físico no se confunden en el árbol. | Contrato, referencia candidata, mapa de regiones, estados de búsqueda/árbol/lista/detalle y mapeo de componentes. |
| 2 | **MSL-01 — Maintenance Standards Library** | Da superficie propia a la biblioteca corporativa y la separa de la administración de Equipment Types. MSL-G01/G02 tienen evidencia contractual; MSL-G03 sigue pendiente. | DVP de biblioteca, filtros, provenance y estados; adopción permanece gobernada por su gate. |
| 3 | **REL-01 — Reliability Engineering Workbench** | Es la experiencia principal de ingeniería, con WS-01…WS-09 como navegación interna. | Diseñar REL-01 y avanzar workspace por workspace; empezar por WS-01 cuando contrato y Foundation lo permitan. |
| 4 | **PMP-01 — Project Maintenance Plans** | Conecta biblioteca, activos y planes versionados; forecast no debe parecer una orden real. | Referencia de lista/seguimiento; PMP-02 queda como estudio separado de edición/publicación. |
| 5 | **WO-01 — Work Orders Control Center** | Centro de trabajo; PR #13 aporta un recorrido demostrativo de PM anual, no todo el control center. | Reconciliar el DVP activo con el contrato de producto y gates de work management antes de ampliar. |
| 6 | **SCH-01 — Backlog & Scheduling Board** | Consume órdenes preparadas y restricciones; benchmark no acredita operación local. | DVP de readiness/asignación condicionado a sus contratos. |
| 7 | **Pantallas secundarias** | Diseñarlas cuando anfitrión y contratos estén claros. | AS-02/03/04, MSL-02/03, PMP-02 y WO-02/03/04, en el orden de la experiencia que las abre. |
| HOLD | **INV-01 / INV-02 — Inventario y repuestos** | El Screen Map las marca futuras; no hay contrato core actual para sus acciones. | No diseñar una experiencia que implique reservas o movimientos hasta que exista el contrato. |

La secuencia ordena la **generación visual**. No aprueba prioridades de producto ni permite saltarse gates funcionales, de datos, permisos o runtime.

## 4. Registro de superficies

### Pantallas principales

| ID | Superficie | Nota |
|---|---|---|
| OPS-01 | Operations Overview | En espera de definición de KPIs y read models; no inventar health score. |
| AS-01 | Assets List / Hierarchy Explorer | Primera pantalla de dominio propuesta. El árbol debe indicar qué relación navega. |
| MSL-01 | Maintenance Standards Library | Biblioteca corporativa; distinta de AS-04. |
| REL-01 | Reliability Engineering Workbench | Un workspace compuesto; WS-01…WS-09 son internos. |
| PMP-01 | Project Maintenance Plans | Diferenciar forecast de órdenes reales. |
| WO-01 | Work Orders Control Center | PR #13 cubre solo un recorrido candidato acotado. |
| SCH-01 | Backlog & Scheduling Board | Separar contrato benchmark de validación operativa local. |
| INV-01 | Spare Parts & Inventory | Futura; fuera del alcance ejecutable actual. |

### Secundarias, internas y futuras

| Grupo | Superficies | Regla |
|---|---|---|
| Activos | AS-02 Asset Detail; AS-03 Asset Create/Edit; AS-04 Equipment Type Library | Mantener distintas FLH, taxonomía y ADR. Escritura y permisos requieren contrato. |
| Estándares | MSL-02 Standard Detail/Revision; MSL-03 Job Plan/Operations Detail | La frecuencia pertenece al plan/policy; un Job Plan no implica frecuencia. |
| Reliability | WS-01…WS-09 | Navegación interna de REL-01. Sin scoring RCM; AMEF continúa en HOLD. |
| Planes | PMP-02 Project Maintenance Plan Studio; PMP-T01 Triggers & Forecast | PMP-02 es secundaria; PMP-T01 es interna y contextual. Ver forecast no materializa órdenes. |
| Órdenes | WO-02 Work Order Detail; WO-03 Work Execution Workspace; WO-T01 Digital Checksheets; WO-04 Technical Closure | Separar detalle, ejecución y cierre técnico. |
| Programación | SCH-T01 Readiness & Assignment | Interna de SCH-01; reprogramar no cambia DueAt ni la revisión del Job Plan. |
| Inventario | INV-02 Spare Part Detail | Futura; depende del contrato de inventario y reservas. |

## 5. Componentes y evidencias

El [catálogo de fuentes IAP](https://github.com/rubensv74/industrial-application-platform/blob/main/docs/ui/IAP_COMPONENT_SOURCE_CATALOG_2026-10-11.md) localiza **fuentes candidatas**; no demuestra que estén instaladas o validadas en CMMS. El catálogo IAP registra Studio como NOT_RUN para varias fuentes; el catálogo CMMS también clasifica capacidades de activos como TO_VALIDATE.

| Necesidad | Candidatos a investigar | Límite actual |
|---|---|---|
| Shell, navegación y encabezado | Page Header / Navigation de PULSE o IAP | Confirmar contrato CMMS e instalación; no asumir equivalencia ni geometría aprobada. |
| Lista de activos | IAP DataGridPro y FilterChips | Validar estados, accesibilidad y bindings; búsqueda local/paginación pueden pertenecer al host. |
| Exploración jerárquica | IAP GroupedCardExplorer como referencia para inspección | No asumir que representa FLH. Si no cubre el árbol requerido, documentar un gap compartido. |
| Biblioteca y revisión de estándares | DataGridPro, FilterChips y, si encajan, DiffViewer/SideBySideComparison | Comparación y provenance vienen de contratos de estándares, no del estilo visual. |
| REL-01 / decisión RCM | Componentes compartidos de navegación, contexto y estado; composición propia gobernada | No hay evidencia de un árbol RCM compartido aprobado. No inventar scoring. |
| Estados de pantalla | State Surface / Skeleton Loader | Un estado visual no acredita consulta, permisos ni datos conectados. |

Aplicar la regla de componentes del proyecto: **REUSE_CMMS → ADAPT_VERIFIED_BASE → EXTEND_SHARED → CREATE_SHARED → LOCAL_ONLY**. Antes de seleccionar una fuente, fijar repositorio, ruta, blob SHA, contrato, fórmulas/dependencias, instalación y evidencia Studio. No duplicar capacidades compartidas compatibles.

## 6. Paquete mínimo por pantalla

Antes de generar una referencia, registrar:

1. ID del Screen Map y estado de aprobación.
2. Usuario, tarea primaria y criterio de éxito.
3. Arquetipo y patrones secundarios, aprobados o identificados como candidatos.
4. Contrato funcional, datos visibles y acciones permitidas.
5. Estados inicial, carga, vacío, error, bloqueado, seleccionado y contexto.
6. Jerarquía de página: navegación → identidad → contexto → summary/gate opcional → workspace.
7. Referencia DVP con hash exacto y rationale de cambios directos, adaptados o rechazados.
8. Mapa de regiones y componentes con fuentes/versiones fijadas; separar fórmulas del host.
9. Revisión responsive, teclado, foco, lector de pantalla y scroll.
10. Estado de validación: candidate, Studio-validated, runtime-validated y synced son distintos.

Si falta baseline YAML, render real o referencia aprobada, el trabajo será preparatorio/candidato. No declarar PaYaml de producto o pantalla validada sin sus entradas y gates.

## 7. Próximas acciones

1. **Preparar AS-01:** reconciliar su baseline funcional y referencias; definir el caso visual de árbol/lista y comprobar qué componentes IAP aplican.
2. **Cerrar el DVP AS-01 como candidato:** target, contrato, region map y estados; dejar visibles datos/permisos pendientes y no presentar el target como aprobado.
3. **Preparar MSL-01** con los contratos MSL-G01/G02 y el gate de adopción separado; no mezclarlo con Equipment Type Library.
4. **Diseñar REL-01 por etapas** y abrir cada workspace según su gate; AMEF queda en HOLD hasta decisión propia.
5. **Completar los gates del PR #13 en su rama actual** sin ampliar su slice: revisión funcional, pin de targets, usos canónicos/host, evidencia Studio y PaYaml solo cuando readiness lo habilite.
6. Continuar PMP-01, WO-01 y SCH-01 según contratos. Mantener inventario en HOLD.

Los flows de Power Automate quedan fuera de este catálogo y aparcados por prioridad del usuario.

## 8. Gates conocidos

- **Screen Map:** propuesta; aceptación de negocio y Studio pendientes.
- **Premium App Shell Foundation:** se requiere evidencia Studio antes de congelar geometría.
- **IAP:** fuente candidata no equivale a componente instalado ni Studio-validado en CMMS.
- **AS-01 / MSL-01 / REL-01:** los contratos y referencias no prueban implementación ni runtime.
- **PR #13:** DVP candidato; revisión humana, target exacto, usos/host y Studio siguen pendientes.
- **Power Automate:** flows en pausa; no cambia su gate por crear este backlog.

NOT_RUN significa que una validación posible no se ejecutó; GATED indica que falta una entrada, contrato, permiso o entorno necesario. Ninguno equivale a PASS.
