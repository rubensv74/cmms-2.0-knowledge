# CMMS Lab — Plan de ejecución DVP v2

**Actualizado:** 2026-10-30  
**Rama:** feat/cmms-annual-preventive-workorder-lab-v1  
**PR:** #13, draft  
**Slice:** Work Queue PM anual → Annual Order Detail → retorno con contexto; solo lectura, datos sintéticos.

## Hecho en la rama

1. Se actualizó el fixture a synthetic profile v1.1 con actividad y fechas programadas.
2. Se generó una proyección DVP determinista de cuatro órdenes anuales enlazadas al perfil; el caso seleccionado contiene cuatro actuaciones y dos ExecutionRecords.
3. Work Queue v2 usa cuatro métricas derivadas del perfil, solo PM anual, sin Export y sin fila correctiva.
4. Annual Order Detail v2 apunta a orden/activo/plan existentes; diferencia actuaciones planificadas y ejecuciones reales inline.
5. Se escribieron el screen contract y la First-Touch experience del recorrido mínimo.
6. Se creó scope funcional candidato v2. baseline_review.status sigue PENDING; no se declara FE-COVERAGE aprobado.
7. Se incorporó como requisito transversal el modal How it works por pantalla: explica propósito, acciones/límites y decisiones con fecha/estado. Se añadieron dos requisitos al scope, contrato del modal y variantes visuales cerradas/abiertas. No hay un modal IAP candidato; la composición Canvas sigue pendiente.

## Artefactos de preparación añadidos

- Inventario IAP/host: iap-component-inventory-v1.md. Pin IAP 377a6b3c y 12 blob SHAs/contratos principales extraídos; fórmulas internas, grafo Power Fx, usos y host siguen pendientes.
- Mapa regional y de estado candidato: work-queue-annual-order-region-map-v2-candidate.md. Deriva propósito/aceptación de regiones visibles del SVG; no afirma layout medido en Canvas.
- Se retiró Refresh de ambos SVG porque no tenía contrato funcional. El detalle ahora muestra los nombres de la actividad asociada al registro seleccionado.
- Readiness findings v2 registra hallazgos corregidos y gates pendientes; no declara screen readiness.

## Gates vigentes

| Gate | Estado | Siguiente evidencia concreta |
|---|---|---|
| Fuente funcional | Preparado para revisión | Vincular requisitos a propuesta 30/10 y DEC-025; registrar APPROVED o brechas. |
| Target visual exacto | Candidato | Revisar/pinar Work Queue blob ecf0515db8e12d102ab3862ad4b7b0f3fcbff61c, detalle blob 1d243ce29a0c09259beb0d41cf6f7e152b97a1b5 y modal-open blobs e92600690ef25dddcbd5442f5f7b0378c3871c8c / 1ff8eb5e398ac1ccb1fc7bc07ea6a08e508f4208; decisión humana pendiente. |
| D2P Phase A | Draft | Completar Phase A con fórmulas, dependencias Power Fx, usos canónicos, host de búsqueda/pager y overlay; el activador del modal usa PageHeaderPhotoPro.Action. Registry de 12 paths/SHAs/CustomProperties ya extraído. Ver iap-component-inventory-v1.md. |
| D2P Phase B | No iniciado | Redactar region map y presupuesto responsive; medir/contrastar después en Canvas. No traducir píxeles SVG a medidas Canvas. |
| D2P Phase C / v3.3 | No iniciado | Cubrir navegación, filtros, sort/page, Help open/close, retorno del foco, estados, accesibilidad y acción inicial visible. |
| Product PaYaml | No iniciado | Solo con evidencia de los gates funcionales, visuales, A/B/C y v3.3 para los mismos hashes de target/source. |
| Studio | Pendiente | First-Touch manual cuando readiness D2P indique READY_FOR_STUDIO; guardar evidencia de importación, render e interacciones. |

## Siguiente orden de trabajo autónomo

1. Completar análisis interno/dependencias Power Fx de componentes elegidos y definir overlay Canvas accesible, búsqueda local y paginador del host.
2. Medir en Studio el region map candidato y resolver presupuesto responsive, capacidad, scroll y paginación.
3. Medir modal y reflow con el shell en Studio; comprobar apertura/cierre, foco, teclado, lectura, scroll interno y persistencia de contexto.
4. Actualizar matriz de estados/interacción con evidencia Studio; mantener separadas actuaciones planificadas y ExecutionRecord.
5. Con source evidence, generar los informes D2P requeridos contra hashes fijados y registrar hallazgos.
6. Entregar targets exactos y cobertura para revisión humana; no presentar PaYaml de producto como listo antes de ese gate.

## Límites

Los SVG son candidatos y no renders de Studio. El scope sigue pendiente de revisión y el target exacto aún no está aprobado. No se han modificado SQL, Power Automate ni Power Apps; no existe validación runtime. La ratificación TR sigue siendo necesaria para políticas de runtime, pero no bloquea este DVP demostrativo de solo lectura.
