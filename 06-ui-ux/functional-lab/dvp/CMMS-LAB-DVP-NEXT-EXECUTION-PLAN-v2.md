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

## Gates vigentes

| Gate | Estado | Siguiente evidencia concreta |
|---|---|---|
| Fuente funcional | Preparado para revisión | Vincular requisitos a propuesta 30/10 y DEC-025; registrar APPROVED o brechas. |
| Target visual exacto | Candidato | Revisar/pinar Work Queue blob 9d52868acd79a8f4fbefaced1bc056ed21d77e3d y detalle blob 9f97bccf2bfa819d0f48e34b8466bc3192396d24; decisión humana pendiente. |
| D2P Phase A | Draft | Completar source registry con paths, SHAs, props/eventos, dependencias Power Fx y contrato del host. Ver iap-component-inventory-v1.md. |
| D2P Phase B | No iniciado | Redactar region map y presupuesto responsive; medir/contrastar después en Canvas. No traducir píxeles SVG a medidas Canvas. |
| D2P Phase C / v3.3 | No iniciado | Cubrir navegación ida/vuelta, selección, filtros, sort/page, estados, accesibilidad y acción inicial visible. |
| Product PaYaml | No iniciado | Solo con evidencia de los gates funcionales, visuales, A/B/C y v3.3 para los mismos hashes de target/source. |
| Studio | Pendiente | First-Touch manual cuando readiness D2P indique READY_FOR_STUDIO; guardar evidencia de importación, render e interacciones. |

## Siguiente orden de trabajo autónomo

1. Inspeccionar fuentes IAP y host contra el commit canónico; resolver nombres y contratos reales.
2. Preparar region map v2 como documento candidato con propósito, límites y estados por región.
3. Preparar matriz de interacción/estado basada en el screen contract; mantener separadas actuaciones planificadas y ExecutionRecord.
4. Con source evidence, generar los informes D2P requeridos contra hashes fijados y registrar hallazgos.
5. Entregar target exacto y cobertura para revisión humana; no presentar PaYaml de producto como listo antes de ese gate.

## Límites

Los SVG son candidatos y no renders de Studio. El scope sigue pendiente de revisión y el target exacto aún no está aprobado. No se han modificado SQL, Power Automate ni Power Apps; no existe validación runtime. La ratificación TR sigue siendo necesaria para políticas de runtime, pero no bloquea este DVP demostrativo de solo lectura.
