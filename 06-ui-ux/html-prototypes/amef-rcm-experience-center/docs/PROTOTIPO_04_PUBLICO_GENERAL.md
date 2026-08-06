# Prototipo 4 — Convertir la decisión en un plan

## Para qué sirve

Este prototipo muestra cómo una estrategia seleccionada mediante RCM se transforma en un plan que pueda programarse, ejecutarse, costearse, revisar y exportarse a distintos sistemas de mantenimiento.

La tarea no se crea por costumbre ni copiando un plan anterior. Debe conservar la relación con el modo de fallo, la decisión RCM, el criterio técnico, el fundamento del intervalo y las condiciones que obligarían a revisarla.

## Recorrido que verá el usuario

1. **Paquete de decisión RCM.** Se selecciona una decisión procedente del Prototipo 3 y se recuperan el modo de fallo, la estrategia, su fundamento y las condiciones pendientes.
2. **Viabilidad económica.** Se compara el coste esperado sin política con el coste directo, el riesgo económico residual y la inversión de la política candidata.
3. **Diseño de tareas.** Se define qué se hace, mediante qué técnica, qué modo de fallo se trata, qué criterio determina el resultado y qué acción debe ejecutarse cuando no se cumple.
4. **Intervalo y activación.** Se comprueba que la frecuencia propuesta es coherente con el intervalo P–F y deja tiempo suficiente para detectar, planificar e intervenir.
5. **Recursos y alcance.** Se asignan disciplina, puesto de trabajo, cuadrilla, herramientas, repuestos, permisos, riesgos de ejecución y necesidad de parada. También se decide qué periféricos forman parte del mismo paquete.
6. **Plan interno y exportación.** Se genera un plan corporativo neutro y se muestra cómo sus campos podrían mapearse posteriormente a SAP, IBM Maximo, Hexagon u otro sistema.
7. **Gate de publicación.** El sistema identifica bloqueos y condiciones antes de enviar el paquete a revisión multidisciplinar.

## Qué conviene observar durante la demostración

- Una decisión condicionada en RCM continúa condicionada al construir el plan.
- El análisis económico solo compara alternativas que ya son técnicamente válidas.
- Una tarea genérica como “inspeccionar bomba” no es ejecutable ni auditable.
- El criterio de aceptación y la acción ante una desviación son tan importantes como la descripción de la tarea.
- El intervalo no se selecciona directamente de una lista sin justificarlo.
- El equipo principal, motor, acoplamiento, filtro e instrumentación pueden agruparse o mantenerse separados según una regla explícita.
- El modelo interno no depende de un CMMS concreto; la exportación se resuelve mediante perfiles de mapeo.
- El gate no publica el plan. Solo indica si está preparado para la revisión y aprobación del Prototipo 5.

## Mensaje principal

Un plan de mantenimiento no es una lista de tareas periódicas. Es el resultado documentado de una cadena de razonamiento:

**modo de fallo → riesgo AMEF → decisión RCM → tarea → intervalo → recursos → coste → aprobación**

Si se rompe esta cadena, la organización pierde la capacidad de justificar por qué existe una tarea, por qué se ejecuta con una frecuencia determinada y qué riesgo pretende controlar.

## Resultado generado

El prototipo produce un paquete de plan con:

- decisión RCM y condiciones heredadas;
- comparación económica y supuestos utilizados;
- tareas vinculadas a modos de fallo;
- técnica o procedimiento;
- criterio de aceptación;
- acción cuando el resultado no cumple;
- intervalo y fundamento P–F;
- disciplina, puesto, cuadrilla y duración;
- herramientas, repuestos, permisos y riesgos de ejecución;
- necesidad de parada;
- alcance del equipo principal y periféricos;
- regla de agrupación;
- codificación interna;
- estructura de exportación neutra;
- bloqueos y condiciones para la revisión.

Esta salida se utiliza como entrada del **Prototipo 5 — Gobernar y mejorar**.

## Cómo funciona el gate

El resultado puede ser:

- **Bloqueado:** existen tareas incompletas, intervalos incoherentes, falta alcance físico o faltan datos esenciales de ejecución.
- **Condicionado:** el plan puede revisarse, pero conserva condiciones RCM, decisiones económicas o codificaciones pendientes.
- **Preparado:** el paquete contiene la información necesaria para pasar a revisión multidisciplinar.

“Preparado” no significa “aprobado” ni “publicado”.

## Límites de la demostración

Los costes, tasas de fallo, porcentajes de reducción, reglas P–F, códigos, puestos de trabajo y equivalencias con sistemas destino son datos de ejemplo.

Antes de incorporarlos al CMMS deberán validarse:

- el modelo corporativo de costes;
- las reglas aplicables a cada tipo de política;
- el catálogo de disciplinas y puestos;
- la codificación alineada con ISO 14224;
- las reglas de agrupación entre equipo principal y periféricos;
- el modelo interno de planes, operaciones y paquetes;
- los perfiles de exportación por cliente y sistema destino;
- las autoridades que pueden aprobar y publicar un plan.
