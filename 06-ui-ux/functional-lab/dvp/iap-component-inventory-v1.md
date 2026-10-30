# DVP v2 — Inventario preliminar de componentes IAP y host

**Estado:** DRAFT; las fuentes no están cerradas para la mayoría de los componentes  
**Rama:** feat/cmms-annual-preventive-workorder-lab-v1  
**Revisión de referencia IAP:** main commit 377a6b3c00c7bef7a8d9e1cfdb5eeb968fbdfe2c  
**Objetivo:** seleccionar los componentes mínimos del recorrido y enumerar evidencia necesaria antes de producir PaYaml. La presencia de un YAML candidato no equivale a componente validado en Studio.

## Mapeo de regiones propuesto

| Región | Candidato IAP | Uso previsto en el slice | Estado / evidencia pendiente |
|---|---|---|---|
| Shell contextual | cmp_IAP_GlobalContextBar_G02_Candidate | Marca CMMS y contexto global | Verificar fuente exacta, propiedades, eventos, dependencias y host. Contrato aún sin fijar. |
| Navegación | cmp_IAP_ContextBreadcrumb_WA_Candidate | Identificar Work Queue → orden anual y permitir retorno | Verificar bindings, evento de retorno y retención de selección/filtros. |
| Encabezado con hero | cmp_IAP_PageHeaderPhotoPro | Título, propósito y hero image a la derecha | Referencia candidate conocida: blob ee19e10cf66b2648f5b91433e990cf988f64fcad. No está validado en Studio; confirmar versión con el commit IAP fijado. |
| Resumen de cola | cmp_IAP_MiniMetricStrip_WE_Candidate | Métricas del perfil anual: 62 / 248 / 124 / 124 | Verificar esquema de items y layout COMPACT; documentar la fórmula y etiqueta de cada binding. |
| Filtros | cmp_IAP_FilterChips_WC_Candidate | Filtros de solo lectura sobre órdenes anuales | Verificar catálogo, selección controlada, reset y accesibilidad. |
| Lista principal | cmp_IAP_DataGridPro_WC_Candidate | Filas PM anuales y selección de orden | Verificar columnas, sort/filter/page, selección, empty/no-results/error y límites de capacidad. |
| Panel de detalle | cmp_IAP_EntityInspector_WD_Candidate | Contexto del activo, plan y orden anual | Verificar secciones, bindings, modos responsive y comportamiento que pertenece al host. |
| Ejecuciones | cmp_IAP_ActivityTimeline_WE_Candidate | Mostrar ExecutionRecords y secuencia planificada inline | Confirmar si timeline representa ejecución real o actividad genérica. No presentar acciones planificadas como hechos ejecutados. |
| Carga y feedback | cmp_IAP_SkeletonLoader_WA_Candidate; cmp_IAP_ActionFeedbackBar_WA_Candidate | Estados de carga, aviso de solo lectura y error de consulta | Verificar estados/props; evitar mensajes de éxito para acciones inexistentes. |
| Presupuesto responsive | cmp_IAP_ResponsiveLayoutMetrics; cmp_IAP_ResponsiveScreenBudget | Umbrales desktop, tablet y ancho estrecho | Verificar fórmulas, dependencias y contrato con host. El SVG de 1440×900 no equivale a unidades Canvas. |

## Límites de alcance

- No colocar componentes solo para completar el catálogo; justificar cada selección por la tarea.
- No crear navegación, exportación, escritura ni acciones backend no especificadas.
- Grilla y detalle usan colecciones demo deterministas; carga/error son estados de UI, no evidencia de servicio.
- La hero image pertenece al encabezado compartido. Fijar recurso, provenance/licencia y reglas de recorte antes de importarlo.
- Los píxeles SVG identifican regiones visuales, no medidas Canvas.

## Cierre necesario para Phase A

Para cada componente seleccionado, registrar path canónico, SHA de source, tipo de artefacto, custom properties y tipos, eventos, valores por defecto, árbol interno relevante, dependencias Power Fx, usos actuales, compatibilidad responsive y gaps. Añadir host global y grafo de dependencias al mismo conjunto de evidencia. Usar estados SOURCE_CANDIDATE, SOURCE_REVIEWED y STUDIO_VALIDATED solo con evidencia. Este inventario es preliminar y no afirma esos cierres.
