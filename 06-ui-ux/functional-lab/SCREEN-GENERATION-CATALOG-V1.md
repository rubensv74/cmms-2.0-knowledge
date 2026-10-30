# CMMS 2.0 — Catálogo y secuencia de generación de pantallas V1

**Estado:** propuesta de trabajo; no aprobada por negocio ni validada en Power Apps Studio.  
**Ámbito:** ordenar el diseño visual de pantallas del producto usando el mapa funcional CMMS, el estándar premium, el catálogo IAP y el protocolo DVP.

Fuentes: [Screen Map V1](../../07-it-handoff/05-ui/screen-map.md), [AS-01 UX Contract](../CMMS_ASSETS_LIST_UX_CONTRACT_V1.md), [Asset Screen Architecture](../CMMS_ASSET_SCREEN_ARCHITECTURE_V1.md), [Asset Premium Components](../CMMS_ASSET_PREMIUM_COMPONENTS_V1.md), [Premium Screen Standard V1](../CMMS_PREMIUM_SCREEN_STANDARD_V1.md), [Page Header Hierarchy V1](../CMMS_PAGE_HEADER_HIERARCHY_V1.md), [CMMS Component Catalog V1](../CMMS_COMPONENT_CATALOG_V1.md), [Design System](design-system.md), [Architecture](architecture.md).

## 1. Decisión de alcance

El repositorio contiene un **mapa general de pantallas de producto**, marcado como propuesta, y contratos de pantalla aceptados para dominios concretos como Activos. No encontré un backlog operativo que ordene la generación visual de todo el producto. La app Power Apps tampoco parte de cero: la evidencia aportada muestra dos pantallas de laboratorio y componentes FL importados, pero ningún componente IAP instalado.

Hay que mantener separadas estas superficies:

- **AS-01 Assets List:** localizar activos; el contrato UX define un Data Explorer con filtros de ubicación/alcance FLH. La frase “Hierarchy Explorer” del mapa general no autoriza por sí sola un árbol visual independiente.
- **AS-04 Equipment Type Library:** administrar tipos de equipo, campos técnicos y mapeos visuales.
- **MSL-01 Maintenance Standards Library:** encontrar estándares corporativos trazables.

No son tres nombres para la misma biblioteca. WS-01…WS-09 tampoco se convertirán en nueve entradas del menú: son workspaces internos de REL-01.

## 2. DVP ya abierto

El [PR #13 — DEC-025: modelo de orden preventiva anual](https://github.com/rubensv74/cmms-2.0-knowledge/pull/13), con su [plan DVP v2](https://github.com/rubensv74/cmms-2.0-knowledge/blob/feat/cmms-annual-preventive-workorder-lab-v1/06-ui-ux/functional-lab/dvp/CMMS-LAB-DVP-NEXT-EXECUTION-PLAN-v2.md), trabaja el recorrido candidato **Work Queue → Annual Order Detail → volver conservando contexto**, con datos sintéticos y solo lectura. Incluye targets SVG, contrato de pantalla, inventario de componentes y readiness findings.

El PR está en draft. Sus targets no están aprobados; la revisión del scope funcional está pendiente; no hay PaYaml de producto ni evidencia de Studio. Se conserva como un slice DVP activo y acotado. **No define el orden del catálogo completo ni sustituye AS-01, MSL-01 o REL-01.**

## 3. Baseline actual de Power Apps

**Evidencia aportada el 2026-10-30:** captura de Power Apps Studio y dos exportaciones YAML de las pantallas existentes. Rubén indica que los YAML tienen aproximadamente dos meses; por ello describen un baseline histórico reciente, no certifican el estado actual completo.

| Evidencia | Hecho comprobado | Uso y límite |
|---|---|---|
| Árbol de componentes en Studio | Se ven Component1, cmp_FL_SidebarPro, cmp_FL_PageHeaderPro, cmp_FL_TreePro, cmp_FL_ProcessRailPro, cmp_FL_DecisionPanelPro, cmp_FL_GatePanelPro, cmp_FL_RiskMatrixPro, cmp_FL_RiskMatrixPro_1, cmp_FL_LineagePanelPro y cmp_FL_ApplicabilityMatrixPro. | Hay componentes Functional Lab importados. La captura no incluye sus definiciones, hashes, versiones ni prueba de todos sus usos. |
| scr_DesignSystemLab | Pantalla estructural para probar sistema visual; el YAML la describe como skeleton sin componentes funcionales y dice que el color aún no está aprobado. Los valores de tokens aparecen como candidatos que no se deben propagar todavía. | Baseline parcial de diseño, no sistema visual aprobado ni shell de producto validado. |
| scr_ComponentLab | Pantalla de validación aislada; el YAML marca IN_CONSTRUCTION y muestra una instancia de cmp_FL_ApplicabilityMatrixPro RC3. | El harness propone prueba normal a 920 px, compacta a 760 px, selección, outputs, evento y Save/Reopen. El código enumera criterios; no demuestra que hayan pasado. |
| Componentes IAP | El usuario confirma que no hay componentes IAP instalados en la app. | Las fuentes IAP son opciones futuras de evaluación, no componentes disponibles para instanciar ahora. |

**Conclusión:** existe una foundation parcial —dos pantallas y una familia de componentes FL—, pero todavía no hay pantallas funcionales de producto ni un baseline actual verificado en Power Apps Studio. Component1 y el sufijo _1 de RiskMatrixPro requieren inventario y comparación de uso; no se deben borrar por el nombre. La captura solo muestra el árbol de componentes, no el render actual de las dos pantallas.

## 4. Secuencia propuesta de generación visual

| Orden | Superficie | Motivo | Salida DVP esperada |
|---|---|---|---|
| 0 | **Actualizar Foundation existente**: scr_DesignSystemLab + scr_ComponentLab | Son las dos pantallas ya presentes. El sistema visual aún se declara en construcción; ComponentLab aporta un harness de validación, no una pantalla de producto. | First-Touch actual: YAML/export, renders completos, versiones/hashes de componentes, App Checker y gates 920/760 + Save/Reopen. No congelar tokens/geométría antes de revisar evidencia. |
| 1 | **AS-01 — Assets List** | Su UX Contract está ACCEPTED / READY_FOR_INCREMENTAL_BUILD y AE-G4 está en PASS_CONTRACT. El contrato define un Data Explorer con búsqueda, filtros —incluido alcance FLH— y data surface; no especifica un árbol separado. | Target DVP candidato basado en sus contratos, estados y mapa de componentes. La referencia seguirá provisional mientras falten baseline YAML/render real y evidencia Studio. |
| 2 | **MSL-01 — Maintenance Standards Library** | Da superficie propia a la biblioteca corporativa y la separa de la administración de Equipment Types. MSL-G01/G02 tienen evidencia contractual; MSL-G03 sigue pendiente. | DVP de biblioteca, filtros, provenance y estados; adopción permanece gobernada por su gate. |
| 3 | **REL-01 — Reliability Engineering Workbench** | Es la experiencia principal de ingeniería, con WS-01…WS-09 como navegación interna. | Diseñar REL-01 y avanzar workspace por workspace; empezar por WS-01 cuando contrato y Foundation lo permitan. |
| 4 | **PMP-01 — Project Maintenance Plans** | Conecta biblioteca, activos y planes versionados; forecast no debe parecer una orden real. | Referencia de lista/seguimiento; PMP-02 queda como estudio separado de edición/publicación. |
| 5 | **WO-01 — Work Orders Control Center** | Centro de trabajo; PR #13 aporta un recorrido demostrativo de PM anual, no todo el control center. | Reconciliar el DVP activo con el contrato de producto y gates de work management antes de ampliar. |
| 6 | **SCH-01 — Backlog & Scheduling Board** | Consume órdenes preparadas y restricciones; benchmark no acredita operación local. | DVP de readiness/asignación condicionado a sus contratos. |
| 7 | **Pantallas secundarias** | Diseñarlas cuando anfitrión y contratos estén claros. | AS-02/03/04, MSL-02/03, PMP-02 y WO-02/03/04, en el orden de la experiencia que las abre. |
| HOLD | **INV-01 / INV-02 — Inventario y repuestos** | El Screen Map las marca futuras; no hay contrato core actual para sus acciones. | No diseñar una experiencia que implique reservas o movimientos hasta que exista el contrato. |

La secuencia ordena la **generación visual**. No aprueba prioridades de producto ni permite saltarse gates funcionales, de datos, permisos o runtime.

## 5. Registro de superficies

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

## 6. Componentes y evidencias

El usuario confirma que **no hay componentes IAP instalados** en esta app. El [catálogo de fuentes IAP](https://github.com/rubensv74/industrial-application-platform/blob/main/docs/ui/IAP_COMPONENT_SOURCE_CATALOG_2026-10-11.md) localiza fuentes que podrían evaluarse e importarse; no son reutilizables en runtime CMMS hasta superar selección, importación y validación. Los componentes FL visibles sí están importados, pero su fuente/versionado y evidencia actual aún deben reconciliarse.

| Necesidad | Candidatos a investigar | Límite actual |
|---|---|---|
| Shell, navegación y encabezado | Priorizar los componentes CMMS de reuse ya descritos en AS-01; contrastar PULSE/IAP para gaps concretos | Confirmar fuente, instalación y contrato en la app activa; no asumir equivalencia ni geometría aprobada. |
| Lista de activos | cmp_CMMS_PageHeaderPro_RC0, ProjectContextPro_RC0 y StatePanelPro_RC0 están clasificados como REUSE en el contrato AS-01; FilterBarPro/DataGridPro son candidatos CMMS para más adelante | No materializar FilterBar/DataGrid en el primer incremento AS-01. IAP DataGridPro/FilterChips se comparan solo si aparece un gap; validar host, bindings y accesibilidad. |
| Jerarquía de activos | El contrato AS-01 define un filtro FLH Location / hierarchy scope; la navegación estructural requiere confirmar el contrato correspondiente | No sustituir el data grid por GroupedCardExplorer ni inferir un árbol FLH aprobado. Si se confirma la necesidad de árbol, resolver su semántica y componente compartido antes del target definitivo. |
| Biblioteca y revisión de estándares | DataGridPro, FilterChips y, si encajan, DiffViewer/SideBySideComparison | Comparación y provenance vienen de contratos de estándares, no del estilo visual. |
| REL-01 / decisión RCM | Componentes compartidos de navegación, contexto y estado; composición propia gobernada | No hay evidencia de un árbol RCM compartido aprobado. No inventar scoring. |
| Estados de pantalla | State Surface / Skeleton Loader | Un estado visual no acredita consulta, permisos ni datos conectados. |

Aplicar la regla de componentes del proyecto: **REUSE_CMMS → ADAPT_VERIFIED_BASE → EXTEND_SHARED → CREATE_SHARED → LOCAL_ONLY**. Antes de seleccionar una fuente, fijar repositorio, ruta, blob SHA, contrato, fórmulas/dependencias, instalación y evidencia Studio. No duplicar capacidades compartidas compatibles.

## 7. Paquete mínimo por pantalla

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

## 8. Próximas acciones

1. **Actualizar el First-Touch baseline** de las dos pantallas existentes: contrastar los YAML de hace ~2 meses con el estado actual de Studio, guardar renders completos, confirmar componentes instalados y revisar App Checker.
2. **Cerrar la Foundation con evidencia:** revisar tokens candidatos de scr_DesignSystemLab y completar en scr_ComponentLab las pruebas pendientes del harness; auditar cmp_FL_RiskMatrixPro_1 y Component1 antes de decidir conservarlos, reemplazarlos o retirarlos.
3. **Preparar AS-01** con su UX Contract ACCEPTED y AE-G4 PASS_CONTRACT. Diseñar un Data Explorer de búsqueda, filtros y grid con FLH como alcance; no dibujar un árbol independiente sin decisión funcional. Evaluar IAP por componente solo cuando exista una necesidad y contrato compatibles.
4. **Preparar MSL-01** con contratos MSL-G01/G02 y adopción separada; no mezclarlo con Equipment Type Library.
5. **Diseñar REL-01 por etapas** y abrir cada workspace según su gate; AMEF queda en HOLD hasta decisión propia.
6. **Completar los gates del PR #13** sin ampliar su slice: revisión funcional, pin de targets, usos canónicos/host y Studio; PaYaml solo cuando readiness lo habilite.
7. Continuar PMP-01, WO-01 y SCH-01 según contratos. Mantener inventario en HOLD.

Los flows de Power Automate quedan fuera de este catálogo y aparcados por prioridad del usuario.

## 9. Gates conocidos

- **Screen Map:** propuesta; aceptación de negocio y Studio pendientes.
- **Foundation actual:** dos pantallas y componentes FL importados; los YAML son de hace ~2 meses y la captura solo acredita nombres visibles. Falta First-Touch actual y evidencia de pruebas/Save-Reopen.
- **Premium App Shell Foundation:** se requiere evidencia Studio antes de aprobar tokens o congelar geometría.
- **IAP:** cero componentes instalados en la app según el usuario; cualquier incorporación requiere selección, importación y validación por consumer.
- **AS-01 / MSL-01 / REL-01:** los contratos y referencias no prueban implementación ni runtime.
- **PR #13:** DVP candidato; revisión humana, target exacto, usos/host y Studio siguen pendientes.
- **Power Automate:** flows en pausa; no cambia su gate por crear este backlog.

NOT_RUN significa que una validación posible no se ejecutó; GATED indica que falta una entrada, contrato, permiso o entorno necesario. Ninguno equivale a PASS.
