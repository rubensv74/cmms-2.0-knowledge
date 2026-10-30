# CMMS Lab — Contrato de implementación del modal de ayuda v1

**Estado:** candidato implementable; pendiente de PaYaml y validación en Power Apps Studio  
**Pantallas:** Work Queue y Annual Order Detail  
**Activador requerido:** acción integrada `cmp_IAP_PageHeaderPhotoPro.Action` con etiqueta `How it works`  
**Modo de esta entrega:** consulta, fixture sintético, sin operaciones de escritura.

## Decisión de composición

Crear un componente local reusable de Canvas, `cmp_CMMS_ScreenHelpDecisionModal`, y colocar una instancia en cada pantalla. No hay un modal IAP en el pin revisado; la geometría, controles, apertura y cierre quedan en el host Canvas. Cada instancia usa el mismo layout y recibe contenido y referencias distintos.

El botón integrado del PageHeader es el único activador. No crear otro botón y no ocultar `ShowAction`.

## Contrato público candidato del modal

| Propiedad | Tipo | Uso |
|---|---|---|
| `Visible` | Boolean input | Muestra u oculta el overlay. |
| `ScreenTitle` | Text input | Título contextual: Work Queue o Annual Order Detail. |
| `HowItWorks` | Text input | Explica qué representa la pantalla y cómo leer sus datos. |
| `AvailableActions` | Table input | Filas con `Order`, `Label`, `EffectText` y `Availability`. Describe solo acciones visibles y su efecto. |
| `Boundaries` | Table input | Filas con `Order`, `BoundaryText`; enumera lo que la pantalla no permite hacer. |
| `DecisionRationale` | Table input | Filas con `Order`, `SourceId`, `SourceDate`, `AuthorityStatus`, `DecisionText` y `DesignEffect`. |
| `OnClose` | Event | El usuario cierra la ayuda; el host actualiza solo el estado del modal. |

El contenido visible se organiza siempre en tres secciones: **How this screen works**, **What you can do**, y **Decisions behind this design**. Cada decisión muestra fuente, fecha y estado de autoridad. No presentar AS-IS ni ratificación pendiente como política aprobada.

## Enlace del botón existente y ciclo de vida

Instancias y fórmulas candidatas del host:

| Elemento | Propiedad / fórmula candidata |
|---|---|
| Header de Work Queue | `ShowAction=true`; `ActionText="How it works"`; `ActionEnabled=true`; `ActionBusy=false`; evento `OnAction=UpdateContext({locScreenHelpOpen:true})`. |
| Header de Annual Order Detail | Misma configuración y evento, con estado local de esa pantalla. |
| Modal en cada pantalla | `Visible=locScreenHelpOpen`; las entradas de contenido corresponden a la pantalla actual. |
| Cierre | Evento del modal `OnClose=UpdateContext({locScreenHelpOpen:false})`. |

El overlay solo modifica `locScreenHelpOpen`. No ejecuta `Navigate`, `Reset`, `Refresh`, `ClearCollect` ni modifica la fila, los filtros, el sort, la página, la orden o la actuación seleccionadas. Abrir, cerrar y volver a abrir debe conservar el contexto subyacente. No se atribuye lógica de negocio ni acceso a datos al componente del modal.

## Contenido por instancia

### Work Queue

**How this screen works**  
La cola muestra órdenes preventivas anuales del perfil sintético. Cada fila representa una Work Order del ciclo y resume las actuaciones programadas. Los totales describen el fixture; no son indicadores de planta.

**What you can do**  
Buscar y filtrar por estado, activo, actividad o ciclo; limpiar filtros; ordenar y paginar; abrir una orden anual; volver a la cola con el contexto conservado. Las acciones aparecen como disponibles solo cuando el control correspondiente está implementado.

**Boundaries**  
Este recorrido no crea, asigna, programa, ejecuta, cierra, cancela ni exporta órdenes. No muestra aquí órdenes correctivas ni casos CBM.

**Decisions behind this design**

| Fuente y fecha | Estado de autoridad | Relación con el diseño |
|---|---|---|
| Reunión CMMS, 21/08/2026 | Flujo descrito como AS-IS; organización objetivo sin fijar | La cola no asigna una jerarquía de Planner/Supervisor como regla universal. |
| Reunión CMMS, 25/09/2026 | Decisiones funcionales de esa reunión | No se antepone Preventive Work Candidate al preventivo aprobado ni se materializa preventivo para toda la vida útil. |
| DEC-025 + propuesta CMMS, 30/10/2026, pp. 3, 6–7 | Baseline aceptado por analista; ratificación TR pendiente | Una orden puede agrupar actuaciones de actividades elegibles en un ciclo anual; no se trata como regla universal ni política de producción ratificada. |

### Annual Order Detail

**How this screen works**  
El detalle separa la Work Order, las actuaciones programadas y los ExecutionRecords que realmente existen. Una actuación prevista no demuestra ejecución. Los datos y el ciclo son sintéticos.

**What you can do**  
Revisar activo, plan, actividad, ciclo y estados; seleccionar una actuación; consultar su ExecutionRecord inline cuando exista; volver a Work Queue manteniendo su contexto.

**Boundaries**  
No permite cambiar fechas, asignar personas, ejecutar, cerrar, cancelar, trasladar pendientes ni crear automáticamente una orden correctiva. No decide el destino de actuaciones pendientes al final del ciclo.

**Decisions behind this design**

| Fuente y fecha | Estado de autoridad | Relación con el diseño |
|---|---|---|
| Reunión CMMS, 25/09/2026 | Decisiones funcionales de esa reunión | El detalle mantiene el resultado real separado de lo planificado; una reparación derivada de un hallazgo corresponde a una WO correctiva independiente. |
| Reunión CMMS, 21/08/2026 | Flujo descrito como AS-IS; autoridad/reglas objetivo abiertas | No presenta reprogramación ni asignación como acciones aprobadas. |
| DEC-025 + propuesta CMMS, 30/10/2026, pp. 3, 6–7 | Baseline aceptado por analista; ratificación TR pendiente | Agrupa actuaciones elegibles y conserva fecha/estado por actuación y actuals/resultado por ejecución. |

Los identificadores/estados mostrados arriba son parte del contenido del modal, no metadatos ocultos. Al preparar las instancias Canvas, mapear cada fila de esta tabla a los campos tipados de `DecisionRationale`; no incluir un enlace que requiera acceso al repositorio para entender la decisión.

## Layout, comportamiento y aceptación

- Overlay centrado sobre la pantalla activa; fondo subyacente distinguible pero no operable mientras el modal está abierto.
- Título y cierre visibles. El cierre no depende de pulsar fuera del panel.
- Área de contenido desplazable dentro del modal; el cierre permanece disponible.
- Reflow para anchuras de escritorio y tablet sin recortar título, etiquetas, tablas de decisión ni cierre.
- Accesibilidad: etiqueta programática, orden de lectura comprensible, teclado y lector de pantalla; al abrir se entra en el modal y al cerrar el foco vuelve a la acción integrada del encabezado si Canvas lo permite.
- Un fallo de retorno de foco debe registrarse y resolverse con evidencia de Studio; no justifica cambiar el activador aprobado ni bloquear la composición del modal.
- El estado del modal se prueba en ambas pantallas: cerrado, abierto, cierre explícito y reapertura conservando contexto.
- Las variantes SVG cerrada/abierta sirven como referencia visual. No son evidencia de importación, comportamiento, accesibilidad ni render final.

## Secuencia de implementación

1. Aprobar/pinar los targets y el baseline funcional de la capability según los gates DVP existentes.
2. Crear el componente Canvas local conforme al contrato público y añadir las dos instancias con sus referencias de decisiones.
3. Conectar `PageHeaderPhotoPro.OnAction` y `cmp_CMMS_ScreenHelpDecisionModal.OnClose` con el estado local de cada pantalla.
4. Validar en Studio el render, la apertura/cierre, preservación de selección/filtros/página, teclado, lectura, reflow y retorno de foco.
5. Corregir el conjunto de hallazgos y actualizar el contrato/hash/evidencia; no declarar validación a partir de PaYaml o SVG únicamente.

No se generan aquí fórmulas de datos ni se afirma implementación Power Apps: el repositorio aún no contiene el source Canvas de este slice.
