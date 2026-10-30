# DVP v2 — Region map y cobertura de estados (candidato)

**Target Work Queue:** blob ecf0515db8e12d102ab3862ad4b7b0f3fcbff61c  
**Target Annual Order Detail:** blob 1d243ce29a0c09259beb0d41cf6f7e152b97a1b5  
**Estado:** DRAFT; revisión funcional/visual pendiente  
**Lienzo de referencia:** SVG viewBox 1440×900. Regiones visuales del SVG, no medidas ni breakpoints Canvas.

**Estados de ayuda:** Work Queue open-state blob e92600690ef25dddcbd5442f5f7b0378c3871c8c; Annual Order Detail open-state blob 1ff8eb5e398ac1ccb1fc7bc07ea6a08e508f4208.

## Work Queue — región → tarea y aceptación

| Región visual | Tarea del usuario | Datos / estado | Aceptación para el demo |
|---|---|---|---|
| Shell y barra de contexto | Reconocer CMMS Lab, espacio Work Management y entorno sintético | Contexto fijo del demo | Aviso visible de datos sintéticos y sin escrituras; no aparentar datos productivos. |
| Breadcrumb y encabezado con hero | Entender propósito y salir hacia el espacio de trabajo | Propósito de la cola anual; navegación de shell existente | Propósito legible; navegación externa al slice se marca como host. Fijar provenance/crop de hero antes de import. |
| Acción How it works y modal de Work Queue | Entender uso, límites y decisiones que justifican esta cola | Contenido curado para Work Queue; referencias 21/08 AS-IS, 25/09 y DEC-025/propuesta 30/10 | Apertura/cierre conserva búsqueda, filtros, orden y página. Mostrar estados de autoridad; el baseline anual posterior sigue pendiente TR. |
| Banda de aviso del entorno | Distinguir demostración de sistema real | SYNTHETIC LAB; no production writes | Siempre visible en vista inicial; no interpretarlo como live. |
| KPI strip | Dimensionar la cola anual | 62 órdenes; 248 acciones; 124 ExecutionRecords; 124 acciones no completadas | Cada valor deriva de perfil v1.1 con etiqueta/definición breve; no confundir acciones con órdenes. |
| Búsqueda y filtros | Reducir órdenes por número, activo, actividad, estado o ciclo | Colección demo; filtros combinables y limpiables | Selección y borrado producen resultado visible; conservar filtros al volver. |
| Tabla de órdenes anuales | Comparar activo/actividad/ciclo, progreso, siguiente fecha y estado | Cuatro filas iniciales; 2/4 acciones completadas | Solo PM anual; seleccionar fila abre detalle. Orden activo visible y accesible por teclado. |
| Paginación | Recorrer 62 filas de demo | 4 filas por página / 16 páginas según target | Página conserva filtros; límites y etiquetas deben coincidir con el adaptador. |

## Annual Order Detail — región → tarea y aceptación

| Región visual | Tarea del usuario | Datos / estado | Aceptación para el demo |
|---|---|---|---|
| Breadcrumb/Back | Volver sin perder contexto | Selección LAB-PM-2026-00004 y filtro/orden/página previos | Restaura contexto; no crea orden ni cambia estado. |
| Encabezado y hero | Identificar la consulta y estado de demo | Orden anual, estado In progress sintético | Conserva contexto global/sintético; sin acción Refresh. |
| Acción How it works y modal de Detail | Entender cómo leer actuaciones y actuals y las decisiones detrás de su separación | Contenido curado del detalle; reunión 25/09, 21/08 AS-IS y DEC-025/propuesta 30/10 | Abrir/cerrar no cambia selección ni estado; diferenciar reunión, contexto AS-IS y baseline posterior no ratificado. |
| Provenance cards | Ver activo, actividad, plan publicado y ciclo | HX-0004; ACT-HX-PM; SYN-PLAN-000004; CYCLE-2026 | Identificadores visibles; ciclo ilustrativo; no presentar regla como aprobada. |
| Resumen del ciclo | Distinguir completado, programado y pendiente | 4 planificadas; 2 con ExecutionRecords; 1 scheduled; 1 planned | Estados disjuntos y suman 4; completed with deviation sigue dentro de completadas. |
| Actuaciones planificadas | Revisar secuencia, fecha prevista y estado | Q1–Q4; Q3 con programación 20 Nov; Q4 planned | Separar fecha prevista, programación y fecha real; nombre de tarea alineado con actividad. |
| Panel ExecutionRecord | Inspeccionar ejecución y feedback asociado | Q2 → SYN-EXEC-000042, actuals, resultado, hallazgo/follow-up | Solo aparece con acción ejecutada; no inferir reparación automática; separar feedback del estado. |
| Aviso de perfil sintético | Entender límites del caso y del ciclo | Sin datos de planta/escrituras; cierre anual abierto | Visible al final, sin elegir disposición para pendientes. |

## Matriz de interacción/estado del recorrido

| Estado o interacción | Cola | Detalle | Evidencia/cierre |
|---|---|---|---|
| Carga inicial | Esqueleto de filas/KPIs | Esqueleto de provenance/actuaciones | Estado de UI; origen de consulta aún no contratado. |
| Datos cargados | 62 órdenes; página inicial | Caso seleccionado; 4 actuaciones | Cubierto por fixture sintético v1.1. |
| Cola vacía | Mensaje de sin órdenes | No aplica sin selección | Regresar a cola sin falso error. |
| Sin resultados | Mensaje y opción de limpiar filtros | No aplica | Limpiar restaura colección; copy pendiente. |
| Error total/parcial de lectura | Error; reintento fuera del slice | Error en detalle, regreso disponible | No presentar Refresh/retry sin contrato; decidir si estado se simula. |
| Filtros/sort/página | Lista refleja combinación activa | Sin cambio del detalle abierto | Contexto conservado al ir y volver. |
| Acción sin ejecución | Estado planned o scheduled | Sin ExecutionRecord | No mostrar fecha real ni resultado inventado. |
| Acción completada | Contador y estado | ExecutionRecord enlazado, actuals, resultado y feedback | Enlace por WorkOrderPlannedActionId, no solo por orden. |
| Acción con desviación | Cuenta como completada | Resultado completed with deviation y follow-up recomendado | No crear WO correctiva automáticamente. |
| Navegación de retorno | Reaparece misma página/contexto | Back to Work Queue | Único trayecto de salida específico del slice.
| Ayuda abierta/cerrada | Modal sobre cola, sin perder contexto | Modal sobre detalle, sin perder selección ni contexto de retorno | Cierre explícito; foco vuelve al activador; no modificar datos/estados. |

## Acción inicial visible y responsividad

- Primera vista: propósito, aviso sintético, KPI strip, búsqueda/filtros, acción How it works y al menos una fila seleccionable visibles a 1440×900. Foco/teclado/contraste requieren verificación al componer.
- Desktop: tabla completa y detalle con lista de acciones más panel de ejecución.
- Tablet: propuesta de reflujo de KPI y filtros; mantener claves de orden/activo y acción primaria visibles.
- Ancho estrecho: propuesta de filas en tarjetas y ejecución bajo actuación seleccionada; evitar scroll horizontal para identificar orden/estado.
- Los reflows son hipótesis. Requieren fuente de componente, responsive budget y medición en Power Apps Studio antes de marcar Phase B PASS.

## Bloqueos de evidencia

1. Revisión humana de baseline funcional y aceptación del target exacto.
2. Source registry IAP y contrato del host.
3. Mapa medido de regiones/breakpoints Canvas, capacidad, scroll y paginación.
4. Interacciones/estados completos contra el mismo source SHA y target pin.
5. Informes D2P v3.3 y puerta de acción inicial; luego First-Touch en Studio.
