# Changelog

Todos los cambios relevantes del repositorio documental se registran aquí.

## [1.0.0] - 2026-08-11

### Cambio estructural

La foundation de CMMS Functional Lab se ha refactorizado desde un modelo centrado en el activo P-101 hacia una arquitectura **library-first**:

```text
Engineering Library
→ Asset Application
→ Execution Plan
→ Results & Learning
```

### Añadido

- Auditoría de remediación de 14 desviaciones.
- `03-data-model/` como área canónica del modelo conceptual.
- Modelo detallado con `FmeaDefinition` y `FmeaRevision`.
- `FmeaAssetApplication` para separar aplicación/contexto por activo.
- `FailureCause` y `FailureEffect` explícitos.
- Modelo RCM con lógica versionada, respuestas, recomendación y decisión humana.
- `NoScheduledTaskDecision` para resultados sin tarea programada.
- Relación N:M `MaintenanceTask` ↔ `FailureMode`.
- Separación `MaintenanceTask`, `MaintenanceProcedure` e `InspectionFormat`.
- Economía separada en `EconomicAssessment`, `MaintenanceCostEstimate` y `ActualMaintenanceCost`.
- Modelo transversal de trazabilidad por identificadores.
- Schemas JSON separados para Engineering Library, Asset Application, Execution Plan y Results.
- Fixture P-101 v2 como aplicación de una biblioteca reusable.
- Guía de migración fixture v1→v2.
- Contratos funcionales de componentes layer-aware.
- Estrategia premium de diseño adaptada a workspaces y capas.

### Refactorizado

- Visión del Functional Lab.
- Functional Journey de 28 etapas.
- Matriz persona vs sistema.
- Arquitectura del Functional Lab.
- `case-fixture.schema.json` como contrato compuesto v2.
- `functional-journey.schema.json` con `layer` y `primaryObjectType`.
- README y estado de implementación.
- Roadmap e índice maestro.
- Guías de flujo de negocio del Experience Center.
- Recorrido didáctico P-101 para explicar Library → Application → Plan → Results.

### Corregido

- P-101 deja de ser el padre conceptual del AMEF.
- Riesgo AMEF deja de denominarse o tratarse como criticidad del activo.
- `criticalOverride` de v1 queda deprecado y sin migración automática.
- Tarea y modo dejan de estar relacionados mediante un único `focusMode`.
- Procedimiento/formato dejan de estar embebidos conceptualmente en la tarea.
- Coste esperado, estimado y real dejan de mezclarse en un mismo agregado.
- La trazabilidad deja de depender de textos del caso.

### Legacy

- `p101-case.v1.json` se conserva como evidencia asset-centric y no debe alimentar nuevos bloques.
- El runtime HTML Experience Center v3.0 se conserva como prototipo histórico; sus guías de negocio sí se han actualizado al modelo v2.

### Decisiones no cerradas

No se han convertido en requisitos definitivos:

- matriz corporativa de riesgo;
- esquema corporativo de criticidad;
- árbol RCM definitivo;
- umbrales P–F;
- fórmulas económicas;
- workflow/roles definitivos;
- granularidad final de procedimientos y formatos;
- backend, base de datos, APIs, flows o integración productiva.

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
- Conversión del caso P-101 existente a fixture JSON canónico v1.
- Estado incremental de implementación y primer vertical slice WS-01 v1.
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
