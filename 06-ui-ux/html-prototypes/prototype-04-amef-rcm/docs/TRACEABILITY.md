# Matriz inicial de trazabilidad

`Disenado` significa asignado a vista, componente y prueba; no implementado.

| Requisito | Vista/componente | Prueba prevista | Sprint | Estado |
|---|---|---|---|---|
| AC-001, AC-002 | Landing, `WhyThisMatters` | Comprension AMEF/RCM y narrativa previa | P04.1 | Implementado |
| AC-003 | Contexto, arbol y cobertura | Coherencia activo-funcion-modo-tarea | P04.1-P04.4 | Implementado |
| AC-010, AC-021 | `WizardStepper`, navegacion | Recorrido, progreso y accion visibles | P04.1-P04.5 | Implementado |
| AC-011 | `FmeaTree`, formularios | Entidades diferenciadas y relaciones validas | P04.2 | Implementado |
| AC-012 | `RiskMatrix` | Matriz versionada y justificacion | P04.3 | Implementado |
| AC-013, AC-016 | Arbol RCM, evidencia | Resultado reproducible; override protegido | P04.3 | Implementado |
| AC-014 | RCM y tareas | Condicion y busqueda de fallos | P04.3-P04.4 | Implementado |
| AC-015, AC-017 | Tratamiento | Decision sin tarea; separacion de Job Plan/PM | P04.4 | Implementado |
| AC-018 | `ApplicabilityTable` | Cuatro activos y resultados distintos | P04.4 | Implementado |
| AC-019 | Revision, timeline | Bloqueo y nueva revision | P04.5 | Implementado |
| AC-020 | Shell y narrativa | Revision visual: no hoja unica | P04.1-P04.6 | Implementado |
| AC-022-024 | Todos | 1280/768 px, teclado, foco, texto+color | P04.6 | Disenado |
| AC-030 | Trazabilidad | Revision a activo y salida futura | P04.5 | Implementado |
| AC-031 | `Ver datos y reglas` | Entrada/configuracion/resultado | P04.1-P04.5 | Implementado |
| AC-032 | Esta matriz | Auditoria requisito-vista-prueba | Todos | En curso |
| AC-033 | `IT_HANDOFF.md` | Neutralidad tecnologica | Todos | En curso |

## Reglas criticas y pruebas

| Regla | Prueba minima |
|---|---|
| Contexto requerido para avanzar | 3 |
| Modo requiere fallo; riesgo requiere efecto y justificacion | 4, 5 |
| RCM completo o pendiente | 6 |
| Override requiere motivo | 7 |
| Tarea trata un modo; modo sin tarea tiene decision | 8, 9 |
| Aplicabilidad conserva divergencia humana | 10, 11 |
| No publicar con error critico | 12 |
| Revision publicada inmutable y versionable | 13, 14 |
| Persistencia y reinicio | 15 |

P04.5 completa gobierno y trazabilidad. P04.6 cerrara calidad, estados alternativos y handoff.
