# CMMS 2.0 — Screen Map V1

**Fecha:** 2026-10-13  
**Estado:** PROPOSED_UX_BASELINE / NOT_APPROVED / NOT_RUNTIME_VALIDATED  
**Ámbito:** mapa funcional de pantallas del producto objetivo; no sustituye al mapa interno del Functional Lab.  
**Repositorio:** cmms-2.0-knowledge  
**Nombre de producto:** CMMS 2.0. «PlanWise» se ha utilizado en las imágenes conceptuales; no se considera branding aprobado.

## 1. Propósito y autoridad

Definir para las próximas pantallas premium y su posible implementación en Power Apps:
- qué entradas deben existir en el menú;
- qué trabajo realiza cada pantalla y qué resultado deja;
- qué operaciones son una pantalla secundaria, una pestaña/paso interno o un inspector;
- qué datos y decisiones pertenecen a cada dominio, evitando duplicar lógica;
- por qué contrato/gate debe pasar una pantalla antes de declararla ejecutable.

**Naturaleza de esta versión:** arquitectura de información y UX **propuesta**, trazada a contratos existentes. No crea requisitos aprobados ni significa que se hayan desarrollado pantallas, flows o nuevos dominios SQL. La aceptación de negocio y las pruebas en Studio siguen pendientes.

**Precedencia:** evidencia de reunión → análisis → Product Truth / Decision Register → contrato funcional → gate → screen map/mockup → implementación probada. Ante discrepancia, el Screen Map no prevalece sobre contratos existentes.

## 2. Convenciones de navegación

| Tipo | Regla |
|---|---|
| PRINCIPAL | Destino estable en menú lateral; orientado a una tarea recurrente o un dominio. |
| SECUNDARIA | Pantalla propia, abierta sobre un objeto y contexto concreto; tiene identidad, volver, validaciones y navegación directa gobernada. No es un mero modal. |
| INTERNA | Tab, stepper o panel de la pantalla anfitriona; comparte objeto, edición y estado de navegación. No tiene por defecto entrada independiente en el menú. |
| INSPECTOR | Vista lateral para lectura, selección y acciones ligeras; no aloja publicación, ejecución integral ni decisiones que requieren gates extensos. |
| FUTURA | Alcance de producto identificado, fuera de los gates/implementación actuales. |
| HOLD | UX aplazada expresamente; no bloquea el modelo de datos ni el núcleo de mantenimiento. |

Los identificadores siguientes son **propuestos** salvo AS-01…AS-04 y WS-01…WS-09, ya definidos en contratos del repositorio. No se debe renombrar esos identificadores por motivos estéticos.

### 2.1 Menú principal propuesto — 7 grupos

1. **Inicio** → OPS-01 Operations Overview.
2. **Activos** → AS-01 Assets List / Hierarchy Explorer.
3. **Ingeniería de mantenimiento** (grupo expandible, no landing obligatorio) → MSL-01 Standards Library; REL-01 Reliability Engineering.
4. **Planes de mantenimiento** → PMP-01 Project Maintenance Plans.
5. **Órdenes de trabajo** → WO-01 Work Orders Control Center.
6. **Planificación y programación** → SCH-01 Backlog & Scheduling Board.
7. **Repuestos y almacenes** → INV-01 Spare Parts & Inventory (**FUTURA**, no mostrar como operativa activa sin contratos).

Hay **7 grupos de primer nivel y 8 destinos funcionales principales**, ya que Ingeniería tiene dos entradas. Un proyecto puede ocultar un grupo no desplegado sin que desaparezca de este catálogo.

No promover al sidebar en V1: Asset Detail, Project Plan Studio, Trigger & Forecast, Work Order Execution, Digital Checksheets, Technical Closure, Standard Detail o cada workspace RCM.

Reporting/KPIs, documentación, permisos PTW/LOTO, compras/costes y administración avanzada siguen como capacidades contextuales/futuras, no entradas principales confirmadas por este mapa.

## 3. Catálogo canónico de pantallas y experiencias

### 3.1 Inicio y activos

| ID / nombre | Tipo | Actor principal (hipótesis de UX) | Propósito y criterio de éxito | Entradas mínimas | Operativas / decisiones del usuario | Salida y navegación | Estado / dependencia |
|---|---|---|---|---|---|---|---|
| **OPS-01 — Operations Overview** | PRINCIPAL | Responsable de mantenimiento, supervisión | Encontrar trabajos y excepciones que necesitan acción; abrir el registro correcto | Proyecto/scope, datos de dominio autorizados | Filtrar contexto; explorar tendencias **solo si KPI definido**; abrir WO, activo, plan o planificación | Deep link con filtro/identidad preservados | PROPUESTA; definición de KPIs y read models pendiente. No Health Index inventado |
| **AS-01 — Assets List / Hierarchy Explorer** | PRINCIPAL | Planner, mantenimiento, ingeniería | Localizar inequívocamente un activo mantenible | Proyecto activo, permisos, Asset list read model | Buscar, filtrar, ordenar, explorar FLH; identificar Equipment Type / criticidad / estado; abrir detalle; crear solo con permiso | AssetCode → AS-02; acción crear → AS-03; conservar búsqueda | **AS-01 existente: ACCEPTED functional baseline**, Studio/runtime no acreditados por este mapa |
| **AS-02 — Asset Detail / Object 360** | SECUNDARIA | Mantenimiento e ingeniería | Entender activo, relaciones, documentación, contexto y mantenimiento sin duplicar maestros | AssetCode estable y read model Asset Detail | Cambiar tabs **Overview / Technical Profile / Engineering / Visuals / Maintenance**; abrir WO o plan; editar si autorizado | AS-03 con contexto; WO-02, PMP-01/02 o REL-01 con AssetCode | **AS-02 existente**; AS read contract. No calcular DueAt/Health Index desde UI |
| **AS-03 — Asset Create / Edit** | SECUNDARIA | Gestor autorizado de Asset Master | Crear/corregir activo coherente con FLH, taxonomía, ADR y autoridad de fuente | Proyecto, Asset Model/Equipment Type autorizado; AssetCode en edición | Completar identidad, ubicación, tipo, padre físico, atributos; comprobar conflictos y guardar según autorización | AssetCode válido → AS-02 y origen | **AS-03 existente**; escrituras/gates por definir y probar |
| **AS-04 — Equipment Type Library** | SECUNDARIA de administración | Administrador Asset Model | Gobernar Equipment Type, campos y mapeo visual, sin alterar planes ni estándares | Asset Model/version, permisos | Consultar tipos, technical fields, visual mapping; revisar/versionar cambios según su gate | EquipmentTypeCode → AS-01/03 y candidatos a MSL-01 | **AS-04 existente**; no fusionar con Maintenance Standards Library |

**Invariante Asset:** FLH (ubicación funcional), taxonomía/Equipment Type (clasificación) y ADR (composición física) son estructuras diferentes. La jerarquía mostrada en un árbol debe indicar qué relación está navegando. No añadir un Health Score sintético ni confundir Type Illustration con Asset Photo.

### 3.2 Ingeniería de mantenimiento

| ID / nombre | Tipo | Actor principal (hipótesis UX) | Propósito y criterio de éxito | Entradas mínimas | Operativas / decisiones del usuario | Salida y navegación | Estado / dependencia |
|---|---|---|---|---|---|---|---|
| **MSL-01 — Maintenance Standards Library** | PRINCIPAL bajo Ingeniería | Especialista de estándares | Encontrar estándar corporativo trazable para tipo de equipo | EquipmentTypeCode opcional, fuentes y revisiones gobernadas | Buscar/filtrar por tipo, versión, origen; comparar candidatos; abrir standard | StandardVersionId → MSL-02; propuesta de adopción → PMP-02 | MSL-G01/G02 PASS con salvedades; MSL-G03 adopción pendiente |
| **MSL-02 — Standard Detail / Revision** | SECUNDARIA | Ingeniería corporativa/proyecto | Entender contenido, revisión y origen antes de utilizar el estándar | StandardVersionId + EquipmentTypeCode | Ver actividades, intervalo **del plan/policy**, Job Plans, recursos y fuentes; comparar revisiones; solicitar adopción | Referencia versionada → PMP-02; JobPlanRevisionId → MSL-03 | No editar revisión publicada; cambios por nueva revisión gobernada |
| **MSL-03 — Job Plan / Operations Detail** | SECUNDARIA | Planner, ingeniería | Consultar preparación reusable y operaciones del Job Plan | JobPlanRevisionId, source/provenance | Ver operaciones, recursos, herramientas y procedimiento/checklist si independiente; navegar a fuente | Devuelve referencia a plan/orden sin crear WO | MSL-G02; JobPlan y frecuencia son conceptos distintos |
| **REL-01 — Reliability Engineering Workbench** | PRINCIPAL bajo Ingeniería | Reliability Engineer | Analizar funciones, fallos, consecuencias y árbol RCM; emitir recomendaciones justificadas | AssetCode/contexto, caso/revisión, RiskProfile configurado, fuentes | Operar WS-01…WS-09; editar entradas, revisar cálculos/reglas, documentar evidencia, confirmar decisiones y gates | MaintenanceRecommendation / decisiones/versión → PMP-02 o revisión futura | Journey v1.3; **no** asumir todo plan nace de RCM; wizard AMEF separado en HOLD |

**Navegación INTERNA de REL-01**, no nueve pantallas de menú:

| Workspace existente | Responsabilidad |
|---|---|
| **WS-01 — Caso y contexto** | Seleccionar activo, límites, contexto y evidencia |
| **WS-02 — Funciones y fallos** | Definir funciones, fallos funcionales y modos |
| **WS-03 — Efectos y riesgo** | Consecuencias y riesgo conforme al perfil del proyecto |
| **WS-04 — Decisión RCM** | Árbol lógico con factibilidad, efectividad, P–F, respuestas y evidencias; **sin scoring RCM** |
| **WS-05 — Economía y tarea** | Proponer actividad, política, intervalo y sourceBasis |
| **WS-06 — Recursos y alcance** | Recursos, Job Plan, aplicabilidad y overrides |
| **WS-07 — Trazabilidad y calidad** | Reconciliar fuentes, advertencias y gates |
| **WS-08 — Revisión y publicación** | Decisión/autoridad, revisión y handoff gobernado |
| **WS-09 — Efectividad y mejora** | Comparar efectividad y proponer revisión de ingeniería |

El usuario debe poder retroceder sin pérdida, identificar qué es recomendación del sistema y qué es decisión humana, y ver la causa de cualquier bloqueo. El **wizard AMEF** sigue HOLD como opción UX, no entidad o precondición persistente.

### 3.3 Planes, disparos y trabajo

| ID / nombre | Tipo | Actor principal (hipótesis UX) | Propósito y criterio de éxito | Entradas mínimas | Operativas / decisiones del usuario | Salida y navegación | Estado / dependencia |
|---|---|---|---|---|---|---|---|
| **PMP-01 — Project Maintenance Plans** | PRINCIPAL | Planner, responsable, ingeniería | Consultar cobertura, estado, versión y próximos vencimientos del mantenimiento gobernado del proyecto | Proyecto y planes publicados/borradores autorizados | Buscar, filtrar por tipo/activo/estado; comparar revisiones; abrir edición o previsión; detectar excepciones | PlanId/PlanVersionId → PMP-02; activo → AS-02; WO → WO-02 | Contratos core y Triggering; MSL-G03 adopción aún pendiente |
| **PMP-02 — Project Maintenance Plan Studio** | SECUNDARIA | Especialista y autoridad aprobadora | Crear/adoptar/ajustar y publicar Plan de Mantenimiento Aprobado con provenance | Proyecto, plan/revisión o nuevo draft, fuentes RCM/Standard/OEM/Expert, scope | Adoptar snapshot con decisión humana; incluir/desactivar/modificar/agregar actividades, recursos y reglas; resolver overrides, justificarlos; revisar gates; solicitar aprobación/publicar nueva versión | PublishedProjectMaintenancePlanVersion + ProjectMaintenancePlanItems → Triggering | **PROPUESTA UX**; MSL-G03, flujo de permisos/aprobación y runtime por validar |
| **PMP-T01 — Triggers & Forecast** | INTERNA de PMP-01/02, solo lectura según contexto | Planner, mantenimiento | Explicar cuándo será accionable cada actividad y distinguir forecast de órdenes reales | ProjectMaintenancePlanItem, TriggerPolicyVersion, TriggerState, scope temporal | Inspeccionar TIME/METER/CONDITION, Last/Next Due, ForecastOccurrence, MaintenanceOccurrence, ReleaseAt y DueAt; ver causas/alertas; abrir WO existente | Abrir WO-02 o volver a plan; **no genera por el mero hecho de visualizar** | TRG-G01 PASS_CONTRACT; valores y fuentes pueden estar incompletos. Monitor transversal independiente solo si se valida su necesidad |
| **WO-01 — Work Orders Control Center** | PRINCIPAL | Planner, supervisor | Encontrar y priorizar órdenes según estado real, origen y vencimiento | Proyecto, WorkOrder read model, permisos | Buscar/filtrar, consultar estado, origen y planificación; abrir WO; iniciar correctiva según flujo autorizado; acciones masivas solo tras contrato | WorkOrderId → WO-02; enlace a SCH-01 | WM-G05 V1 para estados; **PA-G01-RUNTIME-MIN pendiente** |
| **WO-02 — Work Order Detail** | SECUNDARIA | Planner, supervisor, ejecutor | Leer una WO completa y acceder a la acción correcta según estado/rol | WorkOrderId, ExecutionPackage y referencias de activo, Job Plan, permisos | Consultar alcance y origen, materiales/herramientas, documentos técnicos, asignación, historia, findings, restricciones; abrir ejecución o cierre | WO-03, WO-04, AS-02, PMP-01, SCH-01 | WM-G02 PASS_CONTRACT con frontera PTW externa; no duplicar masters |
| **WO-03 — Work Execution Workspace** | SECUNDARIA | Ejecutor, supervisor | Ejecutar trabajo liberado y registrar feedback fiable | WorkOrderId, estado habilitante, ExecutionPackage, permiso operativo si aplica | Iniciar, registrar actual start/finish, recursos, operaciones, readings, adjuntos, hallazgos y resultado; remitir fin de ejecución | ExecutionRecord/ExecutionActual/ExecutionFinding → WO-04; correctiva vinculada → WO-02 | WM-G05 PASS_BENCHMARKED_CONTRACT; validación operativa local pendiente |
| **WO-T01 — Digital Checksheets** | INTERNA de WO-03 | Ejecutor/inspector asignado | Cumplimentar el ProcedureChecklist/JobPlanOperation asociado a la ejecución | WorkOrderId + revisión de Job Plan/Checklist y operación vigente | Responder ítems, registrar valores/comentarios/evidencia y findings sin crear una WO por subpaso | Feedback/evidencia al WO-03; hallazgo → proceso correctivo gobernado | **PROPUESTA UX**; no declarar un programa independiente de inspecciones ni offline/sync confirmados |
| **WO-04 — Technical Closure** | SECUNDARIA bajo WO-02 | Planner / supervisor autorizado | Validar el feedback y registrar cierre técnico separado del fin de ejecución | WorkOrderId en EXECUTION_COMPLETE, actuals y findings vinculados | Revisar completitud, exigir/corregir datos, confirmar correctivas o waiver motivado; cerrar técnicamente | WorkOrderClosure → Triggering feedback / Reporting / Reliability | WM-G05 V1; no confundir cierre técnico y financiero |

**Estados WO de referencia V1:** PLANNING → READY → RELEASED_TO_EXECUTION → IN_PROGRESS → EXECUTION_COMPLETE → TECHNICALLY_CLOSED; CANCELLED gobernado. El estado de ScheduleAssignment es independiente. No inventar OPEN / ON HOLD / APPROVAL como estados canónicos por imitación de los mockups.

**Invariantes de disparo:** se preservan Policy, State, Forecast derivado, MaintenanceOccurrence persistente y MaintenanceDueEvent de auditoría. ReleaseAt ≠ DueAt. El rolling next due se calcula por regla versionada: **no crear preventivas para toda la vida útil ni automáticamente por ejercicio**. Mantener idempotencia, horizonte de liberación, deduplicación y autoridad del motor, nunca de la pantalla.

### 3.4 Programación e inventario

| ID / nombre | Tipo | Actor principal (hipótesis UX) | Propósito y criterio de éxito | Entradas mínimas | Operativas / decisiones del usuario | Salida y navegación | Estado / dependencia |
|---|---|---|---|---|---|---|---|
| **SCH-01 — Backlog & Scheduling Board** | PRINCIPAL | Planner, scheduler | Transformar demanda liberada en trabajo preparado/asignado, con capacidad y ventanas verificadas | WorkOrders, PlanningPackages, WorkConstraints, Readiness, calendarios/capacidad | Consultar backlog; priorizar; revisar readiness; proponer/registrar ScheduleAssignment; justificar cambios; identificar conflictos; abrir orden | ScheduleAssignment / ScheduleRevision → WO-02/03 | WM-G03 PASS_BENCHMARKED_CONTRACT, AS-IS/operativa local no validada |
| **SCH-T01 — Readiness & Assignment** | INTERNA de SCH-01 | Planner/scheduler | Confirmar preparación y asignación sin cambiar la obligación original | WO/PlanningPackage actual y restricciones | Revisar materiales, permisos, herramientas, personal, ventanas; resolver/waive con motivo; asignar y revisar calendario | ReadinessAssessment + planificación versionada | No modificar DueAt ni JobPlanRevision de la WO al reprogramar; agrupación automática no aprobada |
| **INV-01 — Spare Parts & Inventory** | PRINCIPAL **FUTURA** | Almacén, mantenimiento | Consultar disponibilidad y preparar suministro de materiales | Catálogo, stock, localización, activos compatibles, reservas | Buscar, reservar, transferir, registrar movimientos y solicitar reposición **sujetos a futuros contratos** | Material/Reserva → WO-02/SCH-01; detalle → INV-02 | Inventario/compras fuera del freeze DM-G02; **NO_IMPLEMENTABLE_CON_CORE_ACTUAL** |
| **INV-02 — Spare Part Detail** | SECUNDARIA **FUTURA** | Almacén/planner | Comprender repuesto, compatibilidades, existencias y movimientos | PartId, almacén, saldos y trazas autorizadas | Ver compatibilidad, reservas y movimientos; ejecutar acciones autorizadas por futuro contrato | Volver a INV-01 o WO-02 | Debe esperar contrato de inventory ownership, reserva e integración |

### 3.5 Elementos visuales existentes que se reclasifican

| Imagen conceptual original | Tratamiento en este mapa |
|---|---|
| Operations Overview | OPS-01; mantener como concepto, sin números/KPIs inventados |
| Work Orders Control Center | WO-01 + inspector rápido; acción extensa en WO-02/03/04 |
| Asset Master & Hierarchy Explorer | AS-01 + inspector rápido; AS-02/03/04 conservan sus contratos propios |
| Preventive Maintenance Plans | PMP-01; edición y aprobación en PMP-02; forecast en PMP-T01 |
| Backlog & Scheduling Board | SCH-01 + SCH-T01 |
| Spare Parts & Inventory | INV-01/02 FUTURO |
| Reliability Engineering — FMEA/RCM | REL-01 con WS-01…WS-09 como etapas internas; no wizard obligatorio |
| Digital Inspections & Checksheets | WO-T01 dentro de WO-03. Un módulo independiente solo tras validar inspecciones autónomas |
| Maintenance Standards Library (nueva) | MSL-01 y detalles MSL-02/03 |
| Project Maintenance Plan Studio (nueva) | PMP-02 |
| Maintenance Trigger & Forecast (nueva) | PMP-T01, no sidebar |
| Work Execution & Technical Closure (nueva) | WO-03 y WO-04; no duplicar WO-01 |

## 4. Contrato de navegación transversal

1. **Identidad estable:** URL/ruta lógica o parámetros con claves canónicas (AssetCode, WorkOrderId, PlanId + revisión, StandardVersionId, CaseId). La sintaxis técnica/host se definirá en implementación; no usar índices de galería como identidad.
2. **Contexto:** proyecto y permisos siempre explícitos; contexto de activo/WO/plan no se infiere de una selección global obsoleta.
3. **Vuelta:** volver conserva, cuando proceda, filtros, ordenación, scroll, tab y selección del workspace origen. Nunca guardar silenciosamente un borrador al abandonar.
4. **Inspector:** selección rápida sin abandonar vista; puede abrir pantalla secundaria completa. No guardar decisiones críticas ni publicar desde inspector.
5. **Edición:** dirty-state, guardar/cancelar, conflicto de versión/concurrencia y relectura tras cambios; versionado gobernado y auditoría de quién/cuándo/por qué.
6. **Autorización:** controles ocultos/deshabilitados no sustituyen validación backend; roles del catálogo son hipótesis funcionales, no grupos de seguridad definitivos.
7. **Read models:** pantalla consume salidas del dominio propietario. Asset Master no es owner de Work Orders/Plans; Triggering no es owner de scheduling; Execution no modifica el master de fallos/RCM.
8. **Estados UX:** READY, LOADING, EMPTY, UNAVAILABLE, STALE, ERROR, BLOCKED donde apliquen; gates explican motivo/acción siguiente. Ninguna cifra o ilustración sustituye datos acreditados.
9. **Contratos técnicos:** en el stack de laboratorio Power Apps → Power Automate → SQL no escribir directamente desde controles al SQL core. Nombres, parámetros y payloads deben validarse contra contratos SP/Flow y pruebas runtime.
10. **Accesibilidad/responsive:** shell común, navegación con teclado/foco, densidad y scroll controlados, inspector adaptable. No fijar geometría hasta gate Studio del shell.

## 5. Rutas críticas, inputs/outputs y gates de negocio

| Flujo | Ruta UX | Objeto de entrada → output autoritativo | Condición de avance |
|---|---|---|---|
| Buscar activo | AS-01 → AS-02 | AssetCode → AssetDetailReadModel | Identidad/tipo/FLH/ADR inequívocos; read contract y permiso |
| Engineering RCM | AS-02 → REL-01 / WS-01…09 → PMP-02 | Asset/context + FMEA/RCM → MaintenanceRecommendation → item candidato | RiskProfile, evidencia, autoridad, revisión y sourceBasis |
| Adopción de estándar | AS-02 o MSL-01 → MSL-02 → PMP-02 | StandardVersion → snapshot y ProjectPlanOverrides | MSL-G03, aplicación decidida por humano; master inmutable |
| Publicación | PMP-02 → PMP-01 | plan revisado → PublishedProjectMaintenancePlanVersion | Gates, aprobación y consistencia de actividad/frecuencia/recursos |
| Rolling preventive | PMP-01 / PMP-T01 → WO-01/02 | Policy/State → MaintenanceOccurrence → WO | Regla de ReleaseAt/DueAt, idempotencia y PA-G01-RUNTIME-MIN |
| Programación | WO-02 ↔ SCH-01 | WO + constraints + readiness → ScheduleAssignment/Revision | Readiness, ventanas, recursos, operaciones/permisivo |
| Ejecución y cierre | WO-02 → WO-03 / WO-T01 → WO-04 | ExecutionPackage → actuals/findings → WorkOrderClosure | Permisivo cuando aplica, feedback, validación humana |
| Hallazgo correctivo | WO-T01/WO-03 → WO-02 | ExecutionFinding → FollowUpWorkOrderLink → WO correctiva | No reparar silenciosamente dentro del scope de la preventiva |
| Mejora continua | WO-04 → REL-01 / PMP-02 / MSL governance | actuals/efectividad → propuesta de revisión, no publicación automática | Validación, comparativas y nueva versión gobernada |

## 6. Prioridad de diseño frente a prioridad técnica

**UX DESIGNABLE (sin afirmar runtime):** AS-01/02/03/04 según contratos AE; REL-01 y WS-01…09 como caso funcional; MSL-01/02/03 a partir de fuente normalizada; PMP-01/02 y WO-01/02/03/04 como objetivo de producto, mostrando pendientes donde corresponda; SCH-01 a nivel contrato benchmark.

**Pendientes fuertes:** PMP-02 adopción/publicación MSL-G03; permisos PTW/LOTO completos; KPI/Reporting; inventario/compras; inspecciones autónomas/offline; automatismos de agrupación; integración productiva.

**Próximo gate técnico vigente (sin desplazar prioridades):** PA-G01-RUNTIME-MIN: validar CMMS_CORE_WorkQueue_List y CMMS_CORE_WorkOrder_Materialize con JSON de salida, requestId/idempotencia y errores; posteriormente integrar vertical mínima Power Apps y validar Studio. DB-G01-RUNTIME y SP-G01 constan PASS según las evidencias fechadas, pero no certifican las pantallas.

## 7. Checklist obligatorio antes de generar una nueva imagen o implementar una pantalla

Para cada pantalla o tab se debe producir una ficha con:
- Screen ID y **tipo** (PRINCIPAL / SECUNDARIA / INTERNA / INSPECTOR / FUTURA).
- **PRIMARY_USER_TASK**, **SUCCESS_CRITERION**, actor y permisos (hipótesis vs validado).
- Entrada desde qué pantalla, claves y contexto; salida y destino.
- Información existente, inputs editables, cálculos de sistema, recomendaciones, decisiones humanas y gates.
- Operativas completas; estados, errores, empty/loading y casos de concurrencia/idempotencia cuando aplica.
- Objetos y dominio owner; fuentes/provenance, revisiones y read/write contracts.
- Arquetipo premium, componentes reutilizables y justificación de navegación interna vs secundaria.
- Evidencia del contrato/decisión y estado de validación real.

**Gate visual:** comparar la imagen con propósito/operativa/contrato antes de codificar. Una imagen creada no valida comportamiento; una importación Power Apps sin errores tampoco valida la pantalla.

## 8. Fuentes autoritativas y pendientes

- [Product Truth Baseline](../../../00-governance/CMMS_PRODUCT_TRUTH_BASELINE_V1.md): PT-01…PT-15; revisar vigencia en estado más reciente.
- [Decision Register](../../../05-meetings/decisions/DECISION_REGISTER.md).
- [PROJECT_STATUS](../../../PROJECT_STATUS.md) y [ROADMAP](../../../ROADMAP.md).
- [Functional Journey RCM v1.3](../../../02-functional/process-model/functional-journey.md): WS-01…09; AMEF wizard HOLD.
- [Maintenance Standards Core Contract](../../../02-functional/process-model/maintenance-standards-core-contract-v0.1.md).
- [Triggering contract](../../../02-functional/process-model/triggering-condition-monitoring-contract-v0.1.md).
- [Work Management discovery](../../../02-functional/process-model/work-management-discovery.md).
- [Planning/Scheduling v1](../../../02-functional/process-model/work-management-planning-scheduling-contract-v1.0.md).
- [Execution Feedback v1](../../../02-functional/process-model/work-management-execution-feedback-contract-v1.0.md).
- [Asset Screen Architecture V1](../../../06-ui-ux/CMMS_ASSET_SCREEN_ARCHITECTURE_V1.md): AS-01…AS-04 prevalecen en dominio Assets.
- [Premium Screen Standard](../../../06-ui-ux/CMMS_PREMIUM_SCREEN_STANDARD_V1.md) y [Page Header Hierarchy](../../../06-ui-ux/CMMS_PAGE_HEADER_HIERARCHY_V1.md).
- [Document set / UI requirements](../../functional-document-set.md).

**Decisiones abiertas (no inventarlas):** aceptación del menú y destinos de V1, rol/seguridad final, profundidad UX de la adopción MSL-G03, programa de inspecciones independiente, necesidades de un Trigger Monitor transversal, cobertura de inventario, KPIs, branding definitivo y arquitectura productiva.

## 9. Criterio de aceptación de Screen Map V1

1. Mapa y contratos revisados por responsables de mantenimiento/ingeniería y por IT.
2. Se confirma la separación de siete grupos de navegación y destinos secundarios/internos.
3. AS-01…AS-04 y WS-01…09 respetan contratos ya documentados.
4. Ninguna superficie inventa dominio propietario o estado runtime.
5. Cada futura pantalla dispone de ficha y evidencia, sin pretender que diseño equivale a prueba.

**Estado actual:** Documento creado como propuesta trazable. **No aprobado por usuarios de negocio ni validado en Power Apps Studio.**
