# Alcance funcional

## Objetivo

Demostrar de forma comprensible y trazable como AMEF analiza fallos y RCM decide su tratamiento, usando el caso de una bomba centrifuga horizontal de agua de refrigeracion.

## Decisiones cerradas

- Diez etapas visibles: introduccion y nueve pasos de analisis.
- Funcion, fallo funcional, modo, causa y efecto son conceptos diferentes.
- El riesgo se evalua antes del tratamiento y las respuestas RCM conservan evidencia y justificacion.
- Un modo puede tener varias tareas y una tarea tratar varios modos.
- Todo modo termina en una tarea o en una decision explicita sin tarea.
- La aplicabilidad automatica es una recomendacion con validacion humana.
- Una tarea propuesta no es un Job Plan, una estrategia, un PM ni una orden.
- Una revision publicada es inmutable; los cambios crean otra revision.
- FLH, taxonomia y ADR son estructuras distintas.
- Los perfiles cambian tratamiento o intervalo sin duplicar el AMEF.

## Limites

Incluye una demo local con datos simulados, rama de fallo oculto, validaciones, estados demostrables, persistencia opcional, revision y trazabilidad. Excluye backend, SQL, APIs, Power Automate, autenticacion, integraciones, motor RCM productivo, matriz corporativa definitiva y generacion real de objetos de mantenimiento.

## Estado previo

El repositorio es documental y contiene prototipos autonomos de FLH, modelo de activos y registro fisico. Existe una especificacion AMEF/RCM en reuniones; el brief `CMMS2-PROT-REL-004` prevalece para este prototipo.

## Huecos que afectan a la demo

| Ref. | Hallazgo | Tratamiento P04.0 |
|---|---|---|
| GAP-01 | El texto habla de nueve pasos y enumera Paso 0 a Paso 9. | Paso 0 es introduccion; se conservan nueve pasos de analisis. |
| GAP-02 | Se pide riesgo residual sin formula ni relacion con salvaguardas. | Resultado configurable de demo; algoritmo pendiente para P04.3. |
| GAP-03 | No hay valores P-F ni regla corporativa de frecuencias. | Frecuencias precargadas como propuestas con fundamento, sin inventar P-F. |
| GAP-04 | No hay orden condicional, quorum ni permisos de aprobacion. | Cinco etapas visibles sin autorizacion real; decision en handoff. |
| GAP-05 | No se define formato de snapshot ni evidencias. | Identificadores y metadatos simulados; decision en handoff. |
| GAP-06 | Los estados obligatorios no estan asignados a pasos. | Escenarios centralizados y trazados al implementar cada sprint. |

Ningun hueco bloquea el prototipo ni reabre los principios no negociables.
