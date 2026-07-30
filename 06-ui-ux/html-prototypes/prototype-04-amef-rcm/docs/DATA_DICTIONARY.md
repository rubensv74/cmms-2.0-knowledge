# Diccionario de datos visible

Los nombres conceptuales no prescriben tablas, APIs ni tecnologia productiva.

| Entidad | Campos principales visibles | Tipo de informacion | Relaciones |
|---|---|---|---|
| Revision AMEF | ID, titulo, revision, estado, tipo de analisis, snapshot | Entrada / resultado | Raiz del analisis |
| Contexto operacional | planta, sistema, servicio, regimen, redundancia, criticidad, fuentes, supuestos | Entrada | Pertenece a revision |
| Funcion | ID, descripcion, tipo, estandar, valor, unidad, condicion, fuente | Entrada | Revision 1:N funciones |
| Fallo funcional | ID, tipo, descripcion, deteccion | Entrada | Funcion 1:N fallos |
| Modo de fallo | ID, descripcion, mecanismo, detectabilidad, velocidad, oculto | Entrada | Fallo 1:N modos |
| Causa | ID, descripcion, categoria, control, evidencia | Entrada | Modo 1:N causas |
| Efecto | ID, nivel, descripcion | Entrada | Modo 1:N efectos |
| Evaluacion de consecuencia | dimensiones, severidad, probabilidad, salvaguardas, justificacion | Entrada | Modo 1:1 evaluacion |
| Riesgo | puntuacion, nivel, inherente/residual, version de matriz | Resultado | Derivado de evaluacion |
| Evaluacion RCM | version de arbol, respuestas, evidencia, recomendacion, override | Entrada / resultado | Modo 1:1 recorrido |
| Respuesta RCM | pregunta, respuesta, explicacion, evidencia, usuario, fecha | Entrada | Evaluacion 1:N respuestas |
| Tarea propuesta | ID, tipo, tecnica, frecuencia, fundamento, rol, criterio, evidencia | Entrada | N:M con modos |
| Decision sin tarea | ID, modo, tipo, justificacion, condiciones | Entrada | Modo 1:N decisiones |
| Regla de aplicabilidad | campo, operador, valor, efecto | Configuracion | Evalua activos |
| Perfil | ID, nombre, efecto | Configuracion | Se asigna a aplicaciones |
| Aplicacion a activo | activo, contexto, sugerencia, decision humana, motivo, usuario, fecha | Entrada / resultado | Revision N:M activos |
| Etapa de aprobacion | ID, nombre, estado, actor, fecha, comentario | Entrada / resultado | Revision 1:N etapas |
| Cambio | ID, fecha, usuario, accion, detalle | Resultado | Revision 1:N cambios |
| Estado UI | paso, seleccion, escenario, cambios sin guardar | Interfaz | No es dato de negocio |

## Configuracion centralizada

- Catalogos de funciones, fallos, tareas, tecnicas, disciplinas, roles y estados.
- Matriz `DEMO-RISK-5X5-v1`.
- Arbol `DEMO-RCM-v1`.
- Perfiles y resultados de aplicabilidad.
- Estados y etapas de aprobacion.

## Identificadores de demostracion

`AMEF-CW-PUMP-001`, `FUN-001`, `FF-001`, `FM-001`, `FM-002`, `TASK-001` a `TASK-005`, `APR-001` a `APR-005`, `APP-01` a `APP-05`.
