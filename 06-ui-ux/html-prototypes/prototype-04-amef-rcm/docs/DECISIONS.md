# Decisiones y supuestos del prototipo

| ID | Tipo | Decision o supuesto | Motivo |
|---|---|---|---|
| DEC-P04-001 | Decision | Paso 0 es introduccion; Pasos 1-9 son analisis. | Resuelve la referencia a nueve pasos sin eliminar ninguna etapa. |
| DEC-P04-002 | Decision | HTML, CSS y JavaScript nativos, sin build. | Coherente con el repositorio y apertura local. |
| DEC-P04-003 | Decision | Estado unico con relaciones por IDs. | Evita duplicacion y mantiene trazabilidad. |
| DEC-P04-004 | Supuesto demo | `localStorage` es opcional y reiniciable. | Persistencia local, no arquitectura productiva. |
| DEC-P04-005 | Decision | Riesgo inherente calculado; residual documentado. | El brief no define algoritmo residual corporativo. |
| DEC-P04-006 | Decision | Q9 se formula como aceptabilidad de operar hasta fallo. | Mantiene respuestas Si/No y la bifurcacion operar/redisenar. |
| DEC-P04-007 | Decision | Periodicidad de `TASK-005` queda por validar. | El brief no proporciona intervalo. |
| DEC-P04-008 | Supuesto demo | Autores, fechas, evidencias y aprobaciones son simulados. | No existe autenticacion ni workflow real. |
| DEC-P04-009 | Decision | Snapshot usa ID determinista de demostracion. | Demuestra inmutabilidad sin definir almacenamiento fisico. |
| DEC-P04-010 | Decision | Escenarios alternativos son una capa no persistente. | Permite demostrarlos sin corromper el caso conductor. |
| DEC-P04-011 | Decision | Iconos usan simbolos locales accesibles. | Evita CDN y dependencias externas. |
| DEC-P04-012 | Decision | Estrategia, Job Plan y PM son solo salida conceptual. | Su conversion corresponde a IT. |

Las decisiones productivas pendientes permanecen en `IT_HANDOFF.md`.
