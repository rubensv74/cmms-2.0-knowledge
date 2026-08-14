# Changelog

Todos los cambios relevantes del repositorio documental se registran aquí.

## [0.9.2] - 2026-08-14

### Añadido

- Notas de reunión `2026-08-14_revision-modelo-conceptual-amef-rcm.md`.
- Análisis `ANL-002` con impacto de la reunión sobre el modelo funcional y CMMS 2.0 Functional Lab.
- Handoff conceptual después de publicación: plan vigente → ejercicio/contexto presupuestario → generación anual explícita de preventivas.

### Actualizado

- Functional Journey a v1.1.
- Matriz Persona vs Sistema a v1.1.
- Visión y arquitectura del Functional Lab.
- Fixture P-101 a v1.1.0.
- Estado de implementación y estado general del proyecto.

### Decisiones

- La matriz de riesgo debe ser configurable por cliente/proyecto; una 5×5 solo puede ser un perfil de ejemplo.
- El RCM se representa como árbol lógico de decisión, no como scoring.
- Factibilidad técnica y efectividad deben formar parte de la explicación de la política RCM.
- La taxonomía puede sugerir activos equivalentes, pero la aplicabilidad es decisión humana.
- El modelo debe soportar plan genérico y overrides específicos por activo.
- Actividades compatibles pueden agruparse por activo/frecuencia, pero el algoritmo exacto de duración/horas-hombre sigue pendiente de validación.
- Las órdenes preventivas se plantean por ejercicio/año y mediante acción explícita; no se pregeneran para toda la vida útil.

### Pendiente

- Definir contrato mínimo `RiskProfile` antes de WS-03.
- Definir contrato de árbol RCM antes de WS-04.
- Definir contratos de aplicabilidad/overrides antes de WS-06.
- Validar planificación/programación, ejecución, costes y facturación con perfiles adicionales.
- Crear/identificar la Canvas app `CMMS 2.0 Functional Lab` y cerrar F01-00 en la herramienta real.

## [0.9.1] - 2026-08-10

### Añadido

- Auditoría estática `F01-00 — Power Apps Foundation`.
- Registro propio de compatibilidad Power Apps Source Code para el Functional Lab.
- Secuencia técnica F01-01 a F01-09 para construir y validar `WS-01 Caso y contexto` por incrementos.

### Decisiones

- El primer shell Power Apps no dependerá de componentes premium no confirmados en la app activa.
- Los componentes de Pulse son candidatos a reutilización, pero no se considerarán instalados hasta validarlos en Power Apps Studio.
- Las lecciones de compatibilidad de Pulse se heredan como reglas preventivas y deberán confirmarse contra las versiones reales de control del Functional Lab.
- No se generará `F01-01` hasta disponer de una Canvas app real y obtener el baseline de Power Apps Studio / App Checker.

### Pendiente

- Crear o identificar la Canvas app `CMMS 2.0 Functional Lab`.
- Completar el gate F01-00 en la herramienta real.

## [0.9.0] - 2026-08-10

### Añadido

- Auditoría de transición hacia CMMS 2.0 Functional Lab.
- Protocolo incremental del Functional Lab derivado del método activo de Pulse.
- Gate funcional previo al gate técnico.
- Visión y límites del laboratorio.
- Functional Journey de 28 etapas y agrupación inicial en nueve workspaces.
- Matriz preliminar persona vs sistema.
- Arquitectura conceptual del Functional Lab.
- Schemas JSON para journey y fixtures.
- Conversión del caso P-101 existente a fixture JSON canónico.
- Estado incremental de implementación y primer vertical slice WS-01.
- Estructura modular de documentación funcional para IT.

### Actualizado

- `PROJECT_STATUS.md` para reflejar la nueva fase.
- `MASTER_INDEX.md` con la estructura funcional real.
- `ROADMAP.md` separando mapa funcional y secuencia de validación.

### Decisiones

- Los prototipos HTML se conservan como evidencia y material conceptual, pero dejan de ser el vehículo principal de validación.
- Power Apps se utilizará como laboratorio funcional, no como decisión de arquitectura productiva.
- JSON será la fuente canónica de los casos de ejemplo; el mecanismo de persistencia productiva queda abierto.
- No se generará el primer YAML hasta completar la auditoría Power Apps Foundation F01-00.

## [0.8.0] - 2026-07-30

### Añadido

- P04.6 con selector de trece estados alternativos.
- Runner autónomo con quince pruebas funcionales.
- Diccionario de datos, guion de demo y registro de decisiones.
- Validación responsive en escritorio, tablet y móvil.

### Actualizado

- Esquema local P04.6, trazabilidad, estado y paquete documental final.

## [0.7.0] - 2026-07-30

### Añadido

- P04.5 con revisión global y cinco etapas de aprobación.
- Devolución comentada, publicación simulada y snapshot.
- Modo publicado inmutable y creación de revisión siguiente.
- Trazabilidad extremo a extremo y registro de cambios.

### Corregido

- Secuencias de codificación incorrectas heredadas en shell, estado e interfaz.

### Actualizado

- Esquema local P04.5, trazabilidad, estado y guía del prototipo.

## [0.6.0] - 2026-07-30

### Añadido

- P04.4 con tratamiento editable, tareas y decisiones sin tarea.
- Matriz de cobertura muchos-a-muchos entre modos y tareas.
- Aplicabilidad explicable sobre cuatro activos y cuatro perfiles.
- Validación humana trazada con usuario, fecha y motivo.

### Actualizado

- Esquema local P04.4, trazabilidad, estado y guía del prototipo.

## [0.5.0] - 2026-07-30

### Añadido

- P04.3 con consecuencias y matriz de riesgo 5x5 versionada.
- Árbol RCM con respuestas, explicación, evidencia y recomendación reproducible.
- Estados de información insuficiente y override justificado.
- Rama principal basada en condición y rama oculta de búsqueda de fallos.

### Actualizado

- Esquema local P04.3, trazabilidad, estado y guía del prototipo.

## [0.4.0] - 2026-07-30

### Añadido

- P04.2 con Pasos 1-4 editables del núcleo AMEF.
- Dataset normalizado con modo principal y fallo oculto.
- Validaciones de alcance, funciones, fallos, modos y efectos.
- Árbol AMEF navegable y persistencia versionada.

### Actualizado

- Trazabilidad, estado y guía del prototipo 04.

## [0.3.0] - 2026-07-30

### Añadido

- P04.1 con landing pedagógica, shell, stepper y cabecera de contexto.
- Estado base, caso separado, navegación, recorrido guiado y panel de reglas.
- Guardado y reinicio local con degradación recuperable.
- Validación específica de P04.1.

### Actualizado

- Trazabilidad, estado y guía del prototipo 04.

## [0.2.0] - 2026-07-30

### Añadido

- Entrega ejecutable P04.0 del prototipo HTML 04 AMEF + RCM.
- Alcance, arquitectura, inventario, trazabilidad y validación inicial.
- Handoff a IT sin decisiones productivas.

### Actualizado

- Estado del proyecto e índice maestro.

## [0.1.0] - Inicial

### Añadido

- Estructura documental base.
- Documentos de gobierno y seguimiento.
- Plantillas de reuniones y decisiones.
- Mapa Mermaid inicial.
