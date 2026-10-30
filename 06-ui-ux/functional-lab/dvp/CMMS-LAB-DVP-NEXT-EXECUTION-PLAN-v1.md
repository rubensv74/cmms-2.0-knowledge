# CMMS Lab — Plan de ejecución DVP v1

**Actualizado:** 2026-10-30  
**Rama de trabajo:** `feat/cmms-annual-preventive-workorder-lab-v1`  
**PR:** [#13](https://github.com/rubensv74/cmms-2.0-knowledge/pull/13) — borrador, no fusionado  
**Alcance inicial:** recorrido de consulta Work Queue → Annual Work Order Detail, con datos sintéticos y sin comandos de escritura.

## Estado de partida comprobado

- La propuesta funcional distribuida el 30/10 confirma una orden preventiva anual para tareas seleccionadas, varias actuaciones periódicas y el registro separado de la fecha y resultado de cada ejecución (pp. 3 y 6).
- El DVP distingue **actuación preventiva programada** de `ExecutionRecord`; «visita» no es la etiqueta de interfaz.
- La revisión visual vigente incluye hero image en el encabezado, propósito de pantalla y acciones de consulta. Rubén indicó que la dirección visual era correcta y pidió continuar.
- Los dos targets y el contrato de pantalla están en el head revisado `94aab551f792041407f5c4260422cd40348a69ab`. Los SVG son artefactos de diseño; no son PaYaml, una aplicación Canvas ni capturas de Studio.
- El fixture sintético funcional está preparado. No se ha conectado a SQL, Power Automate ni datos reales.
- La propuesta no asigna roles concretos ni cierra las reglas operativas pendientes. Hernando y Eduardo son usuarios de walkthrough, no roles de seguridad inferidos.

## Tareas siguientes

| Orden | Tarea | Resultado verificable | Dependencia / estado |
|---:|---|---|---|
| 1 | **Cerrar FE-COVERAGE del primer recorrido** | Contrato `iap-functional-scope-v1` con inventario de requisitos esperado derivado independientemente de la propuesta y DEC-025; vistas, trayectos de ida/vuelta, estados, datos demo y acciones fuera de alcance. Ejecutar el gate de cobertura y conservar su informe. | Siguiente trabajo. No requiere esperar la ratificación de TR. No pasar a PaYaml de producto si quedan requisitos esenciales sin mapear. |
| 2 | **Fijar el target y su correspondencia regional** | Pin de cada SVG y evidencia de aprobación; matriz región → función/estado → componente IAP o brecha → controles Canvas → variante responsive → aceptación. Incluir manifiesto de recursos y reglas de uso de hero image. | La dirección visual está aceptada para continuar. Fijar los assets exactos antes de composición. |
| 3 | **Hacer preflight de componentes y host (D2P Phase A)** | Registro de fuentes IAP con SHA y propiedades reales; selección justificada de componentes por pantalla; grafo de dependencias Power Fx y contrato del host. Separar candidatos de componentes validados en Studio. | Requiere tareas 1–2. No es obligatorio colocar todos los componentes IAP en estas dos pantallas. |
| 4 | **Completar layout, capacidad y variantes (Phase B + D2P 3.3)** | Presupuestos de regiones para desktop/tablet/estrecho; capacidad mínima por lista; política de scroll/paginación; accesibilidad de acciones en la vista inicial; contrato medido contra los SVG fijados. | Requiere target regional y componentes seleccionados. No inferir medidas Canvas solo desde píxeles del SVG. |
| 5 | **Componer el slice Canvas candidato de extremo a extremo** | PaYaml completo de Work Queue y detalle, usando primero colecciones demo deterministas; búsqueda/filtros/orden/paginación/navegación de consulta; estados de carga, vacío, sin resultados, parcial y error; contexto conservado al volver. Sin operaciones de escritura ni falsas respuestas backend. | Solo cuando FE-COVERAGE y readiness de implementación estén listos. Será `CANDIDATE`, no `STUDIO_VALIDATED`. |
| 6 | **Completar gates de fuente y preparar una única entrega para Studio** | Informes D2P A/B/C y v3.3 para el mismo SHA; readiness ledger con los prerrequisitos manuales, errores conocidos y criterios de aceptación. Incluir el gate adicional de acción visible en la vista inicial. | Tareas 3–5. Entrega a Studio únicamente si el readiness global es `READY_FOR_STUDIO`. |
| 7 | **First-Touch en Power Apps Studio** | Importación, render y walkthrough de ambas pantallas con datos demo; capturas comparables de desktop, tablet y variante estrecha; revisión de navegación, estados, contenido visible y componentes. Registrar por separado importación, funcionalidad, fidelidad visual y backend. | Primer gate manual real. Solicitaré a Rubén solo el ciclo de Studio cuando el paquete esté preparado; objetivo: una ejecución y un FIX consolidado si hace falta. |
| 8 | **Revisión del primer uso con Hernando y Eduardo** | Hallazgos de comprensión y recorrido; cambios priorizados con trazabilidad a requisito/target; sin atribuir permisos ni aceptar reglas operativas en su nombre. | Después de First-Touch; su feedback mejora la usabilidad, no sustituye la ratificación de responsables. |
| 9 | **Mantener en paralelo el modelo funcional-técnico y los datos sintéticos** | Contratos de lectura y diccionario alineados con las pantallas; escenarios de fin de ciclo, CBM, correctivo y ejecución; perfil de volumen separado del fixture usado en la UI. | Puede avanzar en paralelo con 1–8. El modelo físico permanece candidato mientras afecte reglas abiertas. |
| 10 | **Preparar el incremento SQL/SP/Power Automate** | Migración aditiva, backfill, rollback, claves naturales, idempotencia/concurrencia y contratos versionados de cola/detalle/comandos, con validación real en entorno de desarrollo. | Gate C posterior: ratificación de reglas por TR Mantenimiento y TR Servicios y cierre de cardinalidades/transiciones con impacto en runtime. El paquete antiguo occurrence→WorkOrder no valida la semántica anual. |

## Criterios de aceptación del primer slice

1. El usuario entiende qué trabajo muestra la cola y qué cubre la orden.
2. La orden conserva la referencia al Plan de Mantenimiento Aprobado y a su versión, además del ciclo explícito disponible en los datos demo.
3. Cada actuación programada se distingue de su ejecución; las fechas previstas no se presentan como fechas reales.
4. Los conteos y estados agregados coinciden con los registros hijos del fixture.
5. Abrir y volver conserva proyecto, filtros, página y selección de cola.
6. Todas las acciones visibles producen feedback en el modo demo y ninguna aparenta persistencia o autorización real.
7. La vista responde de forma comprensible ante carga, vacío, sin resultados, datos parciales y error.
8. La pantalla se mantiene utilizable en variantes revisadas sin perder recorridos ni acciones esenciales.

## Límites y gates

- **Se puede avanzar ya:** contrato funcional del slice, pin de targets, inventario IAP, datos demo, layout/capacidad y composición Canvas candidata.
- **No se debe presentar como regla TR aprobada:** elegibilidad concreta por plan, definición final del ciclo, autoridad y disposición de pendientes, criterio de reparación mayor, cardinalidad de órdenes no anuales, estados/transiciones y asignación de recursos por actuación.
- **No se ha validado:** Studio, importación, Power Apps runtime, SQL, flows ni permisos.
- **Siguiente gate que requerirá intervención humana:** First-Touch de Studio, después de que el paquete completo esté listo. La ratificación de TR condiciona el runtime de negocio; no bloquea el DVP demo de lectura.

## Referencias fijadas

- [Propuesta funcional distribuida · versión 12 · 30/10/2026](https://chatgpt.com/library?file_id=libfile_f5251d0722e88191a6c495330180b566&account_id=personal)
- [Work Queue target](https://github.com/rubensv74/cmms-2.0-knowledge/blob/feat/cmms-annual-preventive-workorder-lab-v1/06-ui-ux/functional-lab/dvp/targets/work-queue-v1-candidate.svg)
- [Annual Work Order Detail target](https://github.com/rubensv74/cmms-2.0-knowledge/blob/feat/cmms-annual-preventive-workorder-lab-v1/06-ui-ux/functional-lab/dvp/targets/annual-order-detail-v1-candidate.svg)
- [Contrato de pantalla](https://github.com/rubensv74/cmms-2.0-knowledge/blob/feat/cmms-annual-preventive-workorder-lab-v1/06-ui-ux/functional-lab/dvp/work-queue-annual-order-screen-contract-v1.md)
- [DEC-025](https://github.com/rubensv74/cmms-2.0-knowledge/blob/feat/cmms-annual-preventive-workorder-lab-v1/00-governance/decisions/DEC-025-annual-preventive-work-order.md)
