# Prototipo 3 — Tomar la decisión RCM

## Para qué sirve

Este prototipo muestra cómo un modo de fallo ya evaluado mediante AMEF se convierte en una decisión de mantenimiento técnicamente defendible.

El sistema no decide por sí solo. Ordena las preguntas, conserva la evidencia utilizada y permite explicar por qué una estrategia se considera aplicable, condicionada o descartada.

## Recorrido que verá el usuario

1. **Entrada AMEF.** Se selecciona un modo de fallo priorizado y se recuperan su función, fallo funcional, efectos, riesgo y controles existentes.
2. **Consecuencias.** Se identifica si el impacto afecta a seguridad, medioambiente, operación o únicamente al coste de reparación. También se determina si el fallo es evidente u oculto y si existe redundancia real.
3. **Evidencia y confianza.** Se documentan las fuentes utilizadas, el responsable técnico y el grado de confianza disponible.
4. **Árbol RCM.** Se recorren preguntas adaptadas al caso: degradación detectable, intervalo P–F, relación con la edad, efectividad de la política y aceptación del riesgo residual.
5. **Aplicabilidad.** Se comparan mantenimiento basado en condición, restauración o sustitución programada, búsqueda de fallos, rediseño y operación hasta fallo.
6. **Escenarios.** Se modifican el intervalo P–F, el tiempo necesario para intervenir y la probabilidad de detección para comprobar si la estrategia es robusta.
7. **Decisión explicable.** Se muestra la estrategia primaria, una alternativa, la autoridad requerida, las condiciones de validez y las acciones pendientes antes de construir el plan.

## Qué conviene observar durante la demostración

- Un riesgo alto no conduce automáticamente a una tarea preventiva.
- Una tarea solo puede proponerse cuando es técnicamente aplicable y efectiva.
- Un fallo oculto puede requerir una prueba funcional o búsqueda de fallos.
- Una consecuencia de seguridad o medioambiental limita la posibilidad de operar hasta fallo.
- El intervalo P–F no es una frecuencia elegida por costumbre: debe dejar tiempo suficiente para detectar, planificar e intervenir.
- Si cambian los supuestos, la recomendación puede dejar de ser válida.

## Mensaje principal

RCM no es un algoritmo autónomo ni un generador automático de tareas. Es un proceso estructurado para que la organización pueda justificar qué política de mantenimiento adopta para cada modo de fallo y bajo qué condiciones deberá revisarla.

## Resultado generado

El prototipo produce un paquete de decisión con:

- modo de fallo y riesgo AMEF de origen;
- clasificación de consecuencias;
- preguntas y respuestas del árbol;
- evidencia y nivel de confianza;
- alternativas evaluadas y descartadas;
- estrategia recomendada;
- robustez frente a escenarios;
- condiciones de validez;
- responsables y autoridad de aprobación.

Esta salida se utiliza como entrada del **Prototipo 4 — Convertir la decisión en un plan**.

## Límites de la demostración

Las escalas, porcentajes de efectividad, frecuencias, gates y autoridades incluidas son ejemplos funcionales. Antes de incorporarlos al CMMS deberán validarse el árbol corporativo definitivo, la evidencia mínima exigida, los criterios de aceptación del riesgo y las responsabilidades de aprobación.