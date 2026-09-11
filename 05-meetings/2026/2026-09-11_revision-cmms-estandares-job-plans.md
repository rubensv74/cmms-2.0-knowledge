# Notas de reunión — Revisión CMMS 2.0: estándares de mantenimiento y Job Plans

**Fecha:** 2026-09-11  
**Participantes:** Rubén Seijo Vilaboy, Hernando Alberto Gómez de la Vega, Eduardo Goitia  
**Fuente:** transcripción de la reunión de Teams  
**Ámbito principal:** nivel de detalle del mantenimiento en CMMS, relación RCM/AMEF, tareas estándar, procedimientos/Job Plans y biblioteca corporativa de planes de mantenimiento.

## 1. Aspectos revisados

- Se revisó el nivel de detalle que debe almacenarse y gestionarse como **actividad de mantenimiento en el CMMS**. Se identificó como riesgo funcional convertir cada subpaso del procedimiento en una actividad independiente, porque obligaría al ejecutor a registrar avance paso a paso y haría el sistema poco manejable.
- Como criterio de diseño, la actividad CMMS debe mantenerse a un nivel operativo suficientemente agregado, por ejemplo `Mantenimiento anual del detector de gas` o `Verificar nivel y condición del lubricante`.
- El detalle fino —qué comprobar, dónde medir, cómo hacerlo, criterios de aceptación, secuencia de pasos y acciones asociadas— debe quedar en un **procedimiento/checklist reutilizable** asociado a la actividad.
- Se revisó el concepto de **Job Plan** como plantilla reutilizable para preparar la ejecución de una tarea de mantenimiento. Los ejemplos revisados contienen operaciones, frecuencia, recursos, herramientas y otra información de ejecución. La frontera exacta entre Job Plan y procedimiento/checklist deberá normalizarse en el modelo corporativo, pero queda claro que no deben confundirse con una orden de trabajo ya emitida.
- Se distinguieron dos responsabilidades funcionales usadas durante la conversación: el **planificador** llega a definir qué tareas deben ejecutarse; el **programador** completa cómo/con quién se ejecutan y cuantifica los recursos necesarios. La nomenclatura definitiva de roles sigue pendiente de normalización.
- Para el CMMS se considera especialmente importante la **cuantificación de recursos**: horas-hombre, materiales/consumibles/repuestos según aplique, herramientas y equipos especiales o pesados necesarios.

## 2. Relación AMEF, RCM y estrategia de mantenimiento

- Se aclaró que el **AMEF forma parte del proceso RCM**; no debe tratarse conceptualmente como un estudio totalmente independiente seguido después por otro proceso RCM.
- El RCM parte de funciones, fallos funcionales, modos de fallo y efectos/consecuencias y conduce a la selección de políticas/estrategias y tareas de mantenimiento.
- Se repasaron tres estrategias principales: **mantenimiento basado en tiempo**, **mantenimiento basado en condición** y **run-to-failure**. Un mismo equipo puede tener tareas de más de una estrategia dependiendo de sus componentes y modos de fallo.
- Se revisó el **intervalo P–F**. La `P` representa el punto en el que una condición de fallo potencial comienza a ser detectable y la `F` el umbral de fallo funcional. La falla funcional no implica necesariamente rotura física inmediata: el equipo puede continuar funcionando, pero ya ha superado el criterio funcional aceptable.
- En el ejemplo de vibraciones de un rodamiento, el primer nivel de alarma puede representar la detección del fallo potencial y un segundo umbral el fallo funcional que requiere intervención. El tiempo entre ambos puntos constituye la ventana P–F utilizada para definir la lógica de monitorización/intervención.

## 3. No todos los planes necesitan un RCM completo

- Se confirmó que **no es necesario ejecutar un RCM completo para todos los equipos de una planta**.
- Los equipos críticos o especiales pueden justificar un análisis RCM específico.
- Para equipos de menor criticidad, un plan puede sustentarse en **manuales y recomendaciones OEM/vendor**, planes ya existentes y experiencia de especialistas.
- Si el fabricante no proporciona suficiente detalle, pueden definirse actividades iniciales con apoyo experto y ajustar posteriormente la frecuencia y el contenido mediante experiencia de operación/mantenimiento.
- La ausencia de un RCM específico **no significa que el equipo quede fuera del CMMS**. El CMMS debe contemplar equipos críticos, de criticidad media y no críticos; lo que cambia es la profundidad y estrategia de mantenimiento aplicable.

## 4. Evidencia revisada durante la sesión

Eduardo mostró documentación histórica de referencia que contiene ejemplos de mantenimiento para distintos tipos de equipos. Durante la reunión se revisaron, entre otros:

- detectores de gas;
- turbinas de gas;
- pressure safety valves;
- generadores/equipos asociados;
- ventiladores y otros equipos auxiliares.

Los documentos mostrados permiten observar estructuras con:

- equipo/tag;
- frecuencia;
- identificador o secuencia de Job Plan;
- operaciones/checklist;
- recursos/disciplinas;
- herramientas;
- referencia a carga del resultado o reporte en el CMMS.

Estos documentos se consideran **fuentes candidatas para construir una base corporativa**, pero no se han incorporado todavía como datos canónicos del repositorio. Deben revisarse y normalizarse antes de convertirlos en contrato funcional o fixture.

## 5. Decisión principal — Biblioteca corporativa de mantenimiento

Se acordó como dirección funcional disponer de una **biblioteca/maestro corporativo de planes de mantenimiento por tipo de equipo**.

Conceptualmente:

```text
Fuentes históricas + OEM + RCM + experiencia
→ estándar corporativo por tipo de equipo
→ incorporación al proyecto
→ adaptación al cliente/proyecto
→ plan publicado del proyecto
```

Principios confirmados:

1. El estándar corporativo sirve como **punto de partida**, no como imposición inmutable.
2. Al crear/configurar un proyecto se debe poder incorporar el estándar aplicable al tipo de equipo.
3. En el proyecto se pueden **desactivar, modificar o añadir** actividades/frecuencias según filosofía del cliente, criticidad, condiciones de servicio o particularidades del equipo.
4. Los cambios de un proyecto no deben modificar automáticamente la biblioteca corporativa.
5. Los aprendizajes o nuevas variantes detectadas en un proyecto pueden proponerse posteriormente para **promoción gobernada** a la biblioteca maestra.
6. La biblioteca debe poder mantener variantes cuando un mismo tipo de equipo presenta diferencias relevantes de diseño o servicio.

Ejemplo discutido:

```text
Corporate Standard — Gas Turbine
├── Monthly
├── 6 Months
├── 1 Year
└── 3 Years

Project A
├── Monthly       active
├── 6 Months      disabled / not applicable
├── 1 Year        adjusted
└── 3 Years       active
```

## 6. Modelo conceptual que se deriva

La reunión permite distinguir al menos los siguientes conceptos:

```text
MaintenanceStandardLibrary
EquipmentTypeStandard
StandardMaintenanceActivity
JobPlan
ProcedureChecklist
ResourceRequirement
ProjectMaintenancePlan
ProjectPlanOverride
SourceReference
```

La relación exacta entre `JobPlan` y `ProcedureChecklist` todavía debe cerrarse, pero debe respetarse esta regla:

> El CMMS no debe convertir cada paso del procedimiento/checklist en una actividad independiente que requiera avance individual.

## 7. Aspectos abiertos

- Contrato definitivo entre `StandardMaintenanceActivity`, `JobPlan` y `ProcedureChecklist`.
- Catálogo corporativo de frecuencias y unidades de frecuencia.
- Modelo de versionado de estándares y snapshots por proyecto.
- Reglas para decidir cuándo una modificación de proyecto se propone de vuelta al maestro corporativo.
- Workflow y autoridad para aprobar cambios de la biblioteca maestra.
- Modelo definitivo de roles `Planner / Scheduler / Programmer` y su terminología corporativa.
- Reglas para seleccionar automáticamente estándares por `EquipmentTypeCode` y criticidad sin sustituir la decisión humana.
- Estructura exacta de recursos: disciplina, crew, horas-hombre, herramientas, materiales, consumibles, repuestos y equipos especiales.
- Estrategia de ingestión y normalización de la documentación histórica mostrada durante la reunión.

## 8. Próximas acciones

- **Eduardo:** mantener compartida la documentación de referencia y valorar asignar una persona/becario para compilar por tipo de equipo los planes, frecuencias, actividades y Job Plans existentes.
- Definir un formato común para esa recopilación antes de convertirla en maestro corporativo.
- Utilizar el resultado para construir un primer catálogo real de estándares de mantenimiento.
- Revisar el modelo funcional de CMMS 2.0 para soportar las dos rutas: análisis RCM específico y adopción/adaptación de estándar corporativo.
- Revisar CMMS Functional Lab para que P-101 permanezca como caso RCM y preparar posteriormente un segundo caso de adopción de estándar basado en datos reales normalizados.
- Hernando indicó que no estará disponible la semana siguiente; se prevé continuar la revisión en aproximadamente dos semanas.

## 9. Impacto inmediato sobre CMMS 2.0

La reunión corrige una suposición importante del modelo anterior: **RCM no debe ser el único camino para crear un plan de mantenimiento**.

El modelo objetivo debe soportar como mínimo:

```text
Ruta A — Ingeniería específica
Activo / contexto
→ criticidad
→ RCM (incluye AMEF)
→ estrategia y tareas
→ Job Plan / procedimiento
→ plan del proyecto

Ruta B — Estándar corporativo
Tipo de equipo + contexto/criticidad
→ seleccionar estándar corporativo
→ revisar OEM / condiciones del proyecto
→ adaptar / desactivar / añadir
→ aprobar
→ plan del proyecto
```

Ambas rutas convergen en un plan versionado que posteriormente alimentará calendario, órdenes de trabajo y ejecución.
