# CMMS Lab — Contrato del modal de ayuda y decisiones por pantalla v1

**Estado:** requisito funcional transversal; candidato DVP  
**Aplicación:** Work Queue PM anual y Annual Order Detail  
**Fuente de diseño:** reuniones CMMS 2026-08-21 y 2026-09-25, DEC-025 y propuesta 2026-10-30  
**Implementación:** pendiente; el catálogo IAP fijado no contiene un modal/dialog candidato.

## Objetivo del modal

Cada pantalla Canvas deberá exponer un modal contextual con tres respuestas en una misma vista:

1. **Cómo funciona esta pantalla:** propósito, qué representan los datos, cómo se relacionan los estados y cómo se navega.
2. **Qué puede hacer el usuario aquí:** acciones realmente disponibles, su efecto visible y los límites de la pantalla.
3. **Qué decisiones justifican este diseño:** decisiones de reuniones y baseline posterior que explican la interacción, con fecha, identificador, estado de autoridad y referencia documental.

El modal es información contextual versionada junto con el contrato de pantalla. No cambia permisos, datos, estado de órdenes ni decisiones de negocio. No es un tutorial genérico ni una fuente alternativa de política.

## Contenido específico — Work Queue

### Cómo funciona

Esta cola del Functional Lab muestra órdenes preventivas anuales sintéticas. Cada fila es una Work Order del ciclo y resume sus actuaciones programadas. Las métricas provienen del perfil sintético v1.1 y no son KPIs de planta.

### Qué puedes hacer

- Buscar y filtrar órdenes PM anuales; limpiar filtros y ordenar/paginar resultados cuando esos controles estén implementados.
- Abrir una orden anual para revisar plan, ciclo, actuaciones y ejecuciones.
- Consultar la ayuda sin perder búsqueda, filtros, orden o página.

Este slice no crea, asigna, programa, ejecuta, cierra ni exporta órdenes. No contiene órdenes correctivas ni casos CBM en esta ruta.

### Decisiones y evidencia

| Referencia visible | Hecho y estado | Cómo justifica la pantalla |
|---|---|---|
| Reunión CMMS 21/08/2026 | Se describió el flujo de planner/responsable/supervisión como AS-IS, pendiente de validación. Se confirmó no fijar una única estructura organizativa. | La cola no asigna una jerarquía o rol que la reunión dejó abierto. |
| Reunión CMMS 25/09/2026 | Se confirmó que Preventive Work Candidate no es paso obligatorio para preventivo aprobado; no deben materializarse preventivas para toda la vida útil. | La pantalla empieza en Work Queue para órdenes aprobadas y muestra el ciclo disponible, sin proponer generación masiva. |
| DEC-025 y propuesta 30/10/2026, pp. 3, 6–7 | Baseline posterior: para actividades elegibles una única orden anual agrupa actuaciones periódicas; cada actuación conserva estado/fecha y cada ejecución sus actuals/resultado. Ratificación TR pendiente. | La cola agrupa por orden anual y permite entrar a inspeccionar actuaciones; la regla es selectiva, no universal. |

## Contenido específico — Annual Order Detail

### Cómo funciona

El detalle separa la cabecera de Work Order, las actuaciones preventivas programadas y los ExecutionRecords realmente registrados. Una actuación planificada no equivale a trabajo ejecutado. El ciclo visible es ilustrativo y los datos son sintéticos.

### Qué puedes hacer

- Revisar activo, actividad, plan/version, ciclo y estado de la orden.
- Seleccionar una actuación programada y consultar su ExecutionRecord inline cuando exista.
- Volver a Work Queue conservando el contexto de búsqueda, filtros, orden y página.
- Leer estados scheduled/planned sin elegir disposición ni producir cambios.

Este slice no permite modificar fechas, asignar personal, ejecutar, cerrar, cancelar, trasladar pendientes ni crear automáticamente una orden correctiva.

### Decisiones y evidencia

| Referencia visible | Hecho y estado | Cómo justifica la pantalla |
|---|---|---|
| Reunión CMMS 25/09/2026 | La ejecución debe generar datos fiables para comparar planificado vs real; la no ejecución requiere justificación; un hallazgo que requiere reparación puede dar lugar a una orden correctiva independiente. | El detalle diferencia planned y actuals, mantiene hallazgos/feedback junto a la ejecución y no genera automáticamente una WO correctiva. |
| Reunión CMMS 21/08/2026 | El flujo de validación, cambio de fecha, supervisión/asignación fue descrito como AS-IS; estados, autoridades y reglas objetivo seguían abiertos. | La pantalla de consulta no infiere autorización ni presenta reprogramación como acción aprobada. |
| DEC-025 y propuesta 30/10/2026, pp. 3, 6–7 | Baseline posterior de agrupación anual selectiva y separación por actuación entre fecha prevista, estado y resultado/fecha real. Ratificación TR pendiente. | El panel muestra varias actuaciones dentro de una Work Order y ExecutionRecord enlazado por actuación, sin confundir ambas entidades. |

## Reglas de presentación y trazabilidad

- Mostrar el estado de cada referencia: decisión confirmada en reunión, descripción AS-IS, abierto, baseline posterior aceptado por analista o ratificación pendiente.
- Una decisión de una reunión no debe presentarse como aprobada para el producto cuando las propias notas la registran como AS-IS o pendiente.
- Para cada afirmación, guardar el source ID, path/revisión documental y pantalla a la que aplica. En UI mostrar identificador, fecha y resumen; el detalle de fuente puede abrir un documento solo si existe destino interno estable y accesible.
- cmp_IAP_PageHeaderPhotoPro conserva su acción integrada “How it works”. Su evento OnAction abre el overlay contextual del host mediante un estado local por pantalla; no se añade un segundo botón. El source no expone públicamente el control interno para devolverle el foco de forma explícita, así que ese detalle se comprobará en Studio. La variante importada TMS prevalece como autoridad del encabezado porque su firma coincide con IAP, aunque el cuerpo difiere de la revisión pública fijada.

La ayuda se versiona junto con screen contract, scope y target. Si cambia una decisión, revisar el copy y su vinculación antes de liberar la pantalla.
- Mantener el badge sintético y la ausencia de writes también dentro del modal.

## Comportamiento accesible requerido

- Botón persistente por pantalla, con etiqueta visible “Cómo funciona”; el icono informativo solo no basta.
- Modal con título programático y sección enfocada al abrir; controles de cierre etiquetados; retorno del foco al botón integrado que lo abrió, sujeto a comprobar el comportamiento posible desde el host.
- Cierre explícito; no depender únicamente de clic fuera. El contenido puede desplazarse dentro del modal.
- La ayuda no debe borrar ni reinicializar filtros, selección, paginación ni foco de la pantalla subyacente.
- La implementación Canvas debe demostrar teclado, lector de pantalla, contraste y reflow en Studio. El patrón visual SVG no es evidencia de accesibilidad ni de implementación. Aunque la referencia pública no expone el botón interno, esa duda no bloquea el modal ni la construcción del resto del slice; comprobar apertura/cierre y foco en Studio, y resolver cualquier limitación accesible con evidencia.

## Contrato de implementación

La especificación implementable candidata está en [screen-help-modal-implementation-contract-v1.md](screen-help-modal-implementation-contract-v1.md). Define un componente Canvas local reutilizable con instancias y contenido distintos por pantalla, usando la acción integrada de PageHeaderPhotoPro como activador. La revisión IAP fijada no contiene un componente modal/dialog. Apertura/cierre, foco, teclado, scroll y reflow requieren verificación en Power Apps Studio. No llamar a esto modal validado hasta esa inspección.
