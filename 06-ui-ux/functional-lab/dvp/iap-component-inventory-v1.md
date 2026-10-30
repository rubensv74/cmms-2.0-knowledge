# DVP v2 — Inventario de componentes IAP y host

**Estado:** SOURCE_CANDIDATE con contratos de propiedades extraídos; sin grafo de dependencias completo ni validación Studio  
**IAP source pin:** rubensv74/industrial-application-platform, commit 377a6b3c00c7bef7a8d9e1cfdb5eeb968fbdfe2c (13-Oct-2026)  
**Propósito:** fijar la procedencia real de los componentes candidatos y limitar su papel en el slice Work Queue anual → Annual Order Detail.

Los SHA de abajo son blob SHA de los archivos en el commit citado. Se revisaron nombre de componente y CustomProperties relevantes en el YAML. Esto no constituye revisión de fórmulas internas, dependency graph, uso canónico, compatibilidad visual ni Studio validation.

## Source registry

| Componente definido | Path canónico IAP | Blob SHA | Contrato observado / decisión para este slice |
|---|---|---|---|
| cmp_IAP_GlobalContextBar | components/canvas/candidates/cmp_IAP_GlobalContextBar_G02_Candidate.pa.yaml | 44433d652bf9fc2b2ff807145c1364e444dfaa16 | Inputs EnvironmentText, Projects, SelectedProjectCode/Name y control de proyecto; emite OnProjectChange y PendingProjectCode. El host conserva autorización, carga y persistencia. Shell contextual solamente; no incluir cambio de proyecto en el recorrido. |
| cmp_IAP_ContextBreadcrumb | components/canvas/candidates/cmp_IAP_ContextBreadcrumb_WA_Candidate.pa.yaml | 41676fa5bf5f8593ef3c259a15c49c4316fe130e | Items: Order, Key, Label, IsCurrent, IsEnabled; evento OnItemSelect emite clave. El host gobierna navegación y conservación de filtros/selección. |
| cmp_IAP_PageHeaderPhotoPro | components/canvas/candidates/cmp_IAP_PageHeaderPhotoPro.pa.yaml | ee19e10cf66b2648f5b91433e990cf988f64fcad | Inputs Density (COMPACT/HERO), Title, Subtitle, HeroImage, HeroFocusY, estado/eyebrow/context; acción opcional ShowAction/ActionText/OnAction. Usar ShowAction=true, ActionText=How it works y OnAction para abrir el modal; retorno lo gobierna el host. |
| cmp_IAP_MiniMetricStrip | components/canvas/candidates/cmp_IAP_MiniMetricStrip_WE_Candidate.pa.yaml | 84d958ef89c392817fd3d9c6d19c45c0d39f2e44 | Metrics: Order, Key, Title, ValueText, SupportingText, Tone, State, IsInteractive; evento OnMetricSelect. Para estos KPI, IsInteractive=false. |
| cmp_IAP_FilterChips | components/canvas/candidates/cmp_IAP_FilterChips_WC_Candidate.pa.yaml | 8477dd1994e891cc84a59e027633d7a229307e67 | Items: Order, Key, Label, ValueText, IsVisible, IsActive, IsEnabled; OnFilterSelect y OnClearAll. El host mantiene el modelo de filtros y compone la colección resultante. |
| cmp_IAP_DataGridPro | components/canvas/candidates/cmp_IAP_DataGridPro_WC_Candidate.pa.yaml | d0f5e601fb46c97a02480bab1e65a965f3421553 | Columns normalizadas C1..C10; Rows con RowKey, C1..C10 y secundarios opcionales; State READY/LOADING/EMPTY/ERROR/UNAVAILABLE; inputs SelectedRowKeyIn, SortKeyIn/SortDirectionIn; eventos OnRowSelect y OnSort. El host mapea dominio, filas responsivas y sort. No expone paginación; control y estado de página pertenecen al host. |
| cmp_IAP_EntityInspector | components/canvas/candidates/cmp_IAP_EntityInspector_WD_Candidate.pa.yaml | 5f6fa8007a250ace560fa3d25e2574d171935f1a | EntityType/EntityKey, Metadata con Order/Key/Label/ValueText/Tone/IsVisible, Actions con Order/Key/Label/Tone/IsVisible/IsEnabled; OnClose/OnAction. Adecuado para provenance/identidad; lista de actuaciones requiere composición separada del host. |
| cmp_IAP_ActivityTimeline | components/canvas/candidates/cmp_IAP_ActivityTimeline_WE_Candidate.pa.yaml | 5cdc1e922c2fe5d0d9d5f86d16c7e7ff23e5024c | Items con Order, Key, EventType, Title, Detail, ActorText, TimestampText, Tone, IsEnabled; OnItemSelect. Candidato solo para hechos de ejecución; no mostrar PlannedAction como evento ya ocurrido. Confirmar que formato de timestamp/actor cubre ExecutionRecord. |
| cmp_IAP_SkeletonLoader | components/canvas/candidates/cmp_IAP_SkeletonLoader_WA_Candidate.pa.yaml | 5b63cbe5b15ff9a82e52eff7ce29c5bce7b8735d | VisibleState y colores de surface/skeleton. Solo estado visual de carga; no acredita una consulta real. |
| cmp_IAP_ActionFeedbackBar | components/canvas/candidates/cmp_IAP_ActionFeedbackBar_WA_Candidate.pa.yaml | ef52e44ff0bd2edd8c82adbea859914fef9caa79 | VisibleState, Tone, Message/Detail y controles ShowUndo/ShowDismiss. Solo feedback de lectura/error si el host puede producirlo; ShowUndo=false, sin mensajes de éxito ficticios. |
| cmp_IAP_ResponsiveLayoutMetrics | components/canvas/candidates/cmp_IAP_ResponsiveLayoutMetrics.pa.yaml | 258d1c07ee043b0cabd8d95ce89e49542f5be829 | Inputs de viewport, mínimos de primary/detail, preferred detail width y gap; outputs Density/LayoutMode/IsCompact/UseSinglePane/PrimaryWidth/DetailWidth/EffectiveGap/HeaderHeight/Spacing. Fórmula SINGLE usa suma de mínimos + gap; SPLIT reparte espacio restante. Revisar unidades y validar medidas reales en Studio antes de uso. |
| cmp_IAP_ResponsiveScreenBudget | components/canvas/candidates/cmp_IAP_ResponsiveScreenBudget.pa.yaml | 137fe0d88254b31bdfeb97025931db95a738f71a | Contrato específico Directory/Photo/Passport y presupuesto Upper/Lower; no coincide con la pantalla de dos vistas de este slice. Deferido; no forzar este componente. |

## Host, shell y controles sin contrato resuelto

- No hay componente de modal/dialog en el catálogo IAP fijado. El target usa PageHeaderPhotoPro.Action como activador; el host deberá proveer un overlay de Canvas reutilizable y contenido por pantalla con foco/cierre accesible.
- La barra global del target contiene destinos de shell fuera del primer recorrido. Su navegación y retención no se atribuyen a esta capacidad; identificar el host real y sus bindings en Phase A.
- DataGridPro no ofrece paginación ni búsqueda textual. En el árbol candidato del commit fijado tampoco aparece un pager ni un componente de búsqueda local; GlobalSearch es de workspace y no se asigna a la búsqueda de cola. El host deberá componer input/pager nativos y orden estable, con su contrato y accesibilidad documentados.
- La selección de fila debe persistir como RowKey; el evento de detalle navega/selecciona en el host. El retorno debe restaurar filtros, sort y page.
- Los inputs de EntityInspector no representan por sí solos cuatro PlannedActions con su ExecutionRecord enlazado. El panel de actividad solo acepta hechos con EventType/Title/Detail/ActorText/TimestampText; mantener previstas fuera de esa cronología.
- Las métricas 62/248/124/124 son derivadas del perfil sintético, no KPIs operativos. Los controles no deben implicar actualización automática.
- Confirmar provenance/licencia y recorte de HeroImage; en el target, la foto es una referencia visual, no un recurso empaquetado aprobado.

## Cierre de Phase A pendiente

1. Extraer fórmulas internas, referencias y dependencias Power Fx de cada componente efectivamente seleccionado.
2. Inspeccionar usos canónicos del IAP, contrato del host global y bindings de navegación/selección; confirmar si hay patrón aprobado para búsqueda y paginación.
3. Documentar regiones objetivo, instancia/host, propiedades configuradas y estado/selección para la experiencia anual.
4. Generar y revisar el reporte Phase A para un mismo commit fuente, target pin y scope revisado.

No se ha generado PaYaml del producto. Los componentes siguen siendo candidatos fuente, no componentes validados en Studio.
