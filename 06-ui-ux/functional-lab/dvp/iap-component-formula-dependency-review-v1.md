# DVP v2 — Revisión estática de fórmulas y dependencias IAP

**Estado:** análisis estático de candidatos fuente completado; no equivale a importación, compilación ni validación en Power Apps Studio.  
**Fuente fijada:** `rubensv74/industrial-application-platform`, commit `377a6b3c00c7bef7a8d9e1cfdb5eeb968fbdfe2c`.  
**Alcance:** componentes seleccionados para Work Queue y Annual Order Detail, más controles nativos que debe aportar el host.

## Fuente y límites de confianza

La definición de `cmp_IAP_PageHeaderPhotoPro` aportada desde TMS se conserva como autoridad de la instancia. Su firma pública coincide con los 32 nombres/tipos revisados contra IAP, pero el cuerpo YAML difiere. Por eso las observaciones internas del encabezado se contrastaron con la definición TMS adjunta cuando eran relevantes; no se sustituye la variante importada por el archivo público.

El resto de candidatos se revisó en el pin IAP indicado. Las fórmulas describen la implementación candidata de esos blobs, no comportamiento probado en runtime. Ninguna fórmula del componente consulta SQL ni invoca Power Automate en el source revisado; el host recibe eventos y es dueño de los datos y el estado.

| Candidato | Blob SHA revisado | Dependencia / fórmula observada | Decisión de host para el DVP |
|---|---|---|---|
| `cmp_IAP_PageHeaderPhotoPro` (TMS importado) | TMS attachment blob `df38bf8faaa6af894960d38a8f0d0283abb17408`; firma IAP `ee19e10cf66b2648f5b91433e990cf988f64fcad` | La altura depende de `ShowHero` y `Density`; imagen/crop de `HeroImage` y `HeroFocusY`; contexto ordena `ContextItems`; la acción interna llama `OnAction()` y se muestra con `ShowAction`. El estado usa `ShowStatus`; su posición reserva espacio cuando `ShowAction=true`. | Conservar el encabezado; configurar `ShowAction=false`, `ShowStatus=false`. Botón “Cómo funciona” propiedad del host en la zona reservada de 120 px, con apertura del overlay por estado local. Esto evita una referencia inaccesible al control interno y evita el efecto de desplazamiento del status. |
| `cmp_IAP_MiniMetricStrip` | `84d958ef89c392817fd3d9c6d19c45c0d39f2e44` | Ordena `Metrics`; ancho de tarjeta usa `Max(210, Parent.Width / CountRows)`; los textos varían por estado READY/LOADING/EMPTY/ERROR/UNAVAILABLE; selección llama `OnMetricSelect(Key)` solo si `IsInteractive` y READY. | Métricas no interactivas. Medir ancho disponible en Studio para que el mínimo de 210 px no recorte la tira; host prepara los valores derivados del perfil sintético. |
| `cmp_IAP_FilterChips` | `8477dd1994e891cc84a59e027633d7a229307e67` | Ordena solo items visibles; deshabilita con `IsBusy` o `!IsEnabled`; `OnFilterSelect(Key)` emite intención, no el valor elegido; `OnClearAll()` vacía el conjunto. Reserva un tramo fijo de 110 px para el botón limpiar. | Host mantiene dropdowns/valores y estado combinado; usar el input de búsqueda y el pager del host. Verificar ancho/reflow; no interpretar Key como valor del filtro. |
| `cmp_IAP_DataGridPro` | `d0f5e601fb46c97a02480bab1e65a965f3421553` | Columnas C1–C10 normalizadas; ancho proporcional a `WidthWeight`; encabezados emiten `OnSort(SortKey)`; el indicador se deriva de `SortKeyIn/SortDirectionIn`; fila emite `OnRowSelect(RowKey)`; `SelectedRowKeyIn` resalta la selección; estado controla mensaje de loading/empty/error. | Host transforma filas y columnas, aplica orden, conserva clave seleccionada y pagina. No contiene búsqueda ni paginación ni consulta de datos. Mantener una clave de orden estable y devolver el estado de sort al componente. |
| `cmp_IAP_EntityInspector` | `5f6fa8007a250ace560fa3d25e2574d171935f1a` | Metadata visible se ordena por `Order`; acciones se ordenan y llaman `OnAction(Key)`; cierre llama `OnClose()`; acciones se deshabilitan con busy o `!IsEnabled`. | Usar para identidad/provenance con acciones ocultas en este recorrido de consulta. Las actuaciones programadas se renderizan por separado en el host. |
| `cmp_IAP_ActivityTimeline` | `5cdc1e922c2fe5d0d9d5f86d16c7e7ff23e5024c` | Ordena `Items` por `Order` descendente; selección llama `OnItemSelect(Key)`; cada item muestra actor/timestamp ya formateados por el host; muestra empty-state cuando no hay items. | Alimentar solo ExecutionRecords reales. El host fija `Order` para representar cronología, prepara texto de fechas/persona y vincula la selección a la evidencia inline. No añadir PlannedActions como eventos. |
| `cmp_IAP_SkeletonLoader` | `5b63cbe5b15ff9a82e52eff7ce29c5bce7b8735d` | Presenta formas estáticas cuando `VisibleState=true`; no dispara carga ni representa un resultado real. | Usar solo junto a un estado de carga del host; no usar como placeholder permanente del fixture ya disponible. |
| `cmp_IAP_ActionFeedbackBar` | `ef52e44ff0bd2edd8c82adbea859914fef9caa79` | Presenta mensaje/detalle/tone; `OnUndo()` y `OnDismiss()` solo se usan si se muestran sus botones. | Deferido: el slice es de solo lectura y no debe crear feedback de éxito ni affordances de deshacer ficticios. |
| `cmp_IAP_ResponsiveLayoutMetrics` | `258d1c07ee043b0cabd8d95ce89e49542f5be829` | Compara viewport con suma de mínimos + gap; produce modo SINGLE/SPLIT y widths derivados; umbrales/mínimos usan las unidades que configure el host. | Candidato para el split de actuaciones y evidencia en el detalle. No medir ni fijar valores hasta confirmar unidades y viewport reales de Canvas; nunca controla navegación entre pantallas. |

## Contrato mínimo del host identificado

- **Ayuda:** el botón del host establece `locScreenHelpOpen=true`; cerrar establece `false` y devuelve el foco al botón host. Esto es una fórmula candidata, pendiente de Studio.
- **Búsqueda y filtros:** búsqueda local y filtros se aplican sobre la colección sintética del host. FilterChips emite la clave de filtro; el host controla valor, combinación y limpiar.
- **Orden y selección:** DataGridPro emite SortKey/RowKey. El host controla dirección, orden, selección, paginación y retorno a Work Queue.
- **Detalle:** el host enlaza actuaciones previstas con su estado/fechas, y ExecutionRecords como evidencia real por actuación. No confundirlas ni derivar una de la otra.
- **Modal:** overlay nativo Canvas y contenido versionado por pantalla; preservar los estados de búsqueda, filtro, orden, página y selección.
- **Solo lectura:** sin acciones de crear, programar, ejecutar, cerrar, cancelar o exportar.

## Readiness de Phase A

La revisión fija las responsabilidades internas visibles en los candidatos y el host que debe suministrarlas. Queda listo para completar el contrato de host con nombres de controles, colecciones, eventos y fórmulas propuestas. Siguen pendientes el baseline review y el pin visual humano, la composición Canvas real, medición responsive, prueba accesible en Studio y el reporte D2P contra los hashes de target aprobados.

No se afirma que los componentes importen, compilen o funcionen en Studio.
