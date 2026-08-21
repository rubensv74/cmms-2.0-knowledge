# Notas de reunión — Revisión CMMS 2.0

**Fecha:** 2026-08-21  
**Participantes:** Rubén Seijo Vilaboy, Hernando Alberto Gómez de la Vega  
**Fuente:** transcripción de la reunión de Teams  
**Ámbito principal:** continuidad de la revisión AMEF + RCM, aplicabilidad de planes y primer análisis del proceso de gestión de órdenes de trabajo.

## 1. Aspectos revisados

- Se retomaron las conclusiones de la reunión anterior y se confirmó el criterio de que la **matriz de riesgo/criticidad debe ser configurable por cliente o proyecto**. Si un cliente dispone de una matriz propia, el modelo debe poder representarla en lugar de imponer una configuración fija.
- Se confirmó que esta configurabilidad deberá reflejarse visualmente en la futura aplicación de referencia / CMMS Functional Lab, evitando que la interfaz quede ligada a una matriz concreta como 5×5.
- Se revisó de nuevo la transición hacia **RCM** y se reafirmó la utilidad del cuestionario/árbol de decisión como mecanismo para incorporar el criterio del responsable de mantenimiento o especialista. La decisión no debe quedar delegada de forma opaca en el software.
- Se aclaró el punto pendiente sobre **variantes por equipo**. Puede existir un plan común para una familia de activos y, al mismo tiempo, equipos concretos con particularidades que obliguen a añadir, eliminar o modificar actividades.
- Como ejemplo, se comentó que una bomba con un sistema de **lubricación por neblina** puede necesitar una actividad adicional respecto de otra bomba centrífuga equivalente con lubricación convencional.
- Se relacionó este comportamiento con casos ya conocidos en HCS: un equipo puede compartir una estructura general de inspecciones con su familia, pero una característica física concreta puede hacer que una tarea no aplique o que sea necesaria otra diferente.
- Se confirmó que debe continuarse el análisis de la transición entre **plan de mantenimiento y órdenes de trabajo**, incluyendo la generación anual ya comentada en la sesión anterior.
- Rubén indicó que buscará ejemplos reales de **hojas/check sheets de mantenimiento del proyecto de Los Barrios** para utilizarlos como material de referencia y contrastar qué información debe acompañar a una tarea u orden de trabajo.

## 2. Primer flujo operativo de órdenes de trabajo identificado

Durante la reunión se explicó, como referencia del funcionamiento actual, el siguiente recorrido:

1. El plan/calendario contiene las inspecciones previstas.
2. El **planner de mantenimiento** identifica las inspecciones próximas a vencimiento.
3. El planner selecciona las inspecciones y las propone para una o varias órdenes de trabajo, según los equipos afectados y la agrupación aplicable.
4. La propuesta llega al **responsable de mantenimiento**, que valida la fecha prevista o puede proponer un cambio de fecha.
5. Si la organización del proyecto dispone de **supervisores o mandos intermedios**, la solicitud pasa a ellos para distribuir la carga de trabajo entre técnicos y turnos.
6. Si no existe ese nivel intermedio, la orden puede llegar directamente al **técnico/ejecutor**.
7. La planificación deberá considerar elementos como **ventanas de ejecución, tiempos disponibles y estructura organizativa del proyecto**.

Este flujo se ha descrito como referencia del sistema actual y deberá revisarse antes de convertirse en modelo objetivo del nuevo CMMS.

## 3. Decisiones y criterios confirmados

1. La matriz de riesgo/criticidad debe seguir siendo **configurable** y adaptable a la metodología del cliente/proyecto.
2. El recorrido RCM debe mantener **participación y autoridad humana**, utilizando preguntas, evidencia y criterios como base de la decisión.
3. El modelo de mantenimiento debe soportar **plan genérico + excepciones/variantes por activo**, sin obligar a duplicar todo el plan por cada particularidad.
4. La **estructura organizativa no puede hardcodearse** en un único flujo de asignación: algunos proyectos tendrán supervisores intermedios y otros no.
5. La gestión de órdenes de trabajo aparece como el **siguiente dominio natural de análisis** después de la publicación/generación anual del mantenimiento preventivo.
6. El flujo explicado hoy es una **referencia AS-IS**, no una decisión definitiva de diseño para CMMS 2.0.

## 4. Aspectos todavía abiertos

- Regla exacta para determinar qué inspecciones pasan de calendario a candidato de orden de trabajo.
- Criterios de agrupación de varias inspecciones/tareas en una o varias órdenes.
- Autoridades y reglas para cambiar fechas y reprogramar.
- Definición de ventanas de ejecución y restricciones de calendario.
- Modelo de capacidad, turnos, supervisores y asignación de técnicos.
- Estados y ciclo de vida completo de la orden de trabajo.
- Contenido definitivo de procedimientos/checklists y su relación con la orden.
- Feedback de ejecución, evidencias, cierre técnico y tratamiento de desviaciones.
- Costes, facturación, contratos y subcontratos, que se revisarán posteriormente con Eduardo y los perfiles adecuados.

## 5. Próximas acciones

- **Rubén:** localizar y enviar ejemplos de hojas/check sheets de mantenimiento de Los Barrios.
- Utilizar esos documentos para revisar qué información debe contener una actividad, procedimiento u orden de trabajo.
- En la próxima sesión, revisar mediante una **demo de la aplicación actual utilizada en Los Barrios** cómo se gestionan planificación, validación, asignación y ejecución.
- Comparar el flujo actual con el modelo que queremos construir, conservando lo que aporte valor y evitando copiar limitaciones del sistema existente.
- Mantener costes/facturación/contratos fuera de este incremento hasta realizar una sesión específica con Eduardo y/o Contratos/Subcontratos.

## 6. Impacto sobre CMMS 2.0

La reunión no modifica el núcleo AMEF + RCM ya revisado, pero aporta evidencia suficiente para abrir formalmente un **discovery de Gestión del Trabajo**.

La frontera pasa de ser únicamente:

```text
Plan publicado
→ generación anual de preventivas
```

a disponer de un primer flujo de referencia:

```text
Plan/calendario
→ inspecciones próximas
→ propuesta del planner
→ validación/reprogramación por responsable de mantenimiento
→ supervisor opcional
→ asignación a técnico/turno
→ ejecución
```

Este nuevo tramo permanece `to_validate` hasta contrastarlo con la demo y documentación real del proceso de Los Barrios.
