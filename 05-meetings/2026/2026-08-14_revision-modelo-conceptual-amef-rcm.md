# Notas de reunión — Revisión Modelo Conceptual CMMS 2.0

**Fecha:** 2026-08-14  
**Participantes:** Rubén Seijo Vilaboy, Hernando Alberto Gómez de la Vega  
**Fuente:** transcripción de la reunión de Teams  
**Ámbito principal:** AMEF + RCM, definición del plan de mantenimiento y transición hacia órdenes de trabajo.

## 1. Aspectos revisados

- Se continuó revisando el flujo funcional **AMEF + RCM**, profundizando en la matriz de riesgo y en la lógica que conduce desde el análisis del modo de fallo hasta la estrategia de mantenimiento.
- Se confirmó que la **matriz de riesgo no debe quedar rígidamente fijada a 5×5**. Los rangos de severidad y el número de categorías deben poder adaptarse al negocio o proyecto; durante la reunión se utilizó 10×10 como ejemplo de configuración posible.
- Se destacó que el software debe poder adaptarse a la filosofía de criticidad del cliente en lugar de obligar al cliente a adoptar una única matriz corporativa.
- Se aclaró que el **árbol RCM no funciona mediante puntuación**. Las respuestas conducen por ramas del diagrama hasta el tipo de política o tarea que corresponde: basada en tiempo, basada en condición/predictiva, rediseño o funcionamiento hasta fallo, según el caso.
- Se revisaron los **criterios de factibilidad técnica** para tareas basadas en condición: existencia de una condición clara de fallo potencial, identificación y consistencia del intervalo P–F, tiempo suficiente para actuar y posibilidad práctica de ejecutar la tarea a una frecuencia menor que dicho intervalo.
- Se revisaron también criterios de **efectividad**, vinculados a las consecuencias de seguridad, ambientales, económicas, evidentes u ocultas.
- Se confirmó que la salida del análisis RCM debe convertirse en **tareas concretas de mantenimiento** y que su definición debe contemplar, entre otros datos, frecuencia, especialidad/ejecutor, número de ejecutores, horas-hombre y necesidad de sacar el equipo de servicio.
- Se comentó que la frecuencia y el contenido de las tareas se apoyan también en **manuales y recomendaciones del fabricante**, además de la experiencia operacional y el propio análisis.
- Se aclaró que varias actividades sobre el mismo equipo que deben ejecutarse con una frecuencia común pueden **agruparse en una misma orden de trabajo**, evitando generar órdenes independientes sin necesidad.
- El nivel detallado de **procedimientos/checklists** asociados a cada tarea todavía no está definido y deberá abordarse más adelante.
- Se revisó la **aplicabilidad del plan a activos similares**. El software puede localizar o sugerir candidatos mediante taxonomía/equivalencia, pero la decisión de aplicar el plan debe permanecer en manos del especialista.
- Se identificó la necesidad de soportar un **plan genérico con excepciones por activo**: una actividad puede eliminarse, modificarse o añadirse para un equipo concreto sin alterar el plan común del resto.
- Se revisó la etapa de **revisión y publicación** como cierre del análisis. Una vez listo el plan con frecuencias y recursos, el siguiente proceso es su ejecución mediante órdenes de trabajo.
- Se confirmó que las **órdenes preventivas no deben pregenerarse para toda la vida útil de la planta**. Deben generarse año a año a partir del plan vigente, asociadas al contexto presupuestario correspondiente y mediante una acción explícita del usuario.
- Se diferenció este proceso de las **órdenes correctivas**, que aparecen cuando se detecta una incidencia o fallo y se genera/evalúa la correspondiente solicitud de trabajo.
- Se abrió el siguiente tramo funcional del modelo: planificación/programación de la orden, asignación de personas, ejecución, feedback y registro del coste generado.
- Se comentó que las órdenes de trabajo pueden estar vinculadas a **centros de coste, presupuestos o partidas contractuales**, pero la relación concreta con facturación y sistemas corporativos todavía debe estudiarse.

## 2. Decisiones y criterios confirmados

1. La configuración de riesgo debe ser adaptable por proyecto/cliente y no quedar limitada a una matriz fija.
2. El árbol de decisión RCM es una lógica de recorrido, **no un sistema de scoring**.
3. El sistema puede calcular, validar y orientar, pero las decisiones relevantes de RCM y aplicabilidad deben conservar **autoridad humana y trazabilidad**.
4. La taxonomía puede sugerir equipos equivalentes; no debe aplicar automáticamente un plan a todos ellos.
5. Debe existir una estructura común de plan y un mecanismo de **override por activo**.
6. Las tareas compatibles por activo/frecuencia deben poder consolidarse en paquetes de ejecución/órdenes coherentes.
7. La publicación del plan debe producir un output estructurado preparado para el proceso posterior de generación de órdenes preventivas.
8. La generación preventiva debe plantearse **por ejercicio/año**, desde el plan vigente y el presupuesto aplicable, no mediante creación masiva de todas las órdenes futuras.

## 3. Aspectos todavía abiertos

- Reglas exactas para construir y versionar perfiles de riesgo por cliente/proyecto.
- Algoritmo exacto para agrupar actividades y calcular duración/horas-hombre cuando intervienen distintas disciplinas.
- Modelo de procedimiento, protocolo o checklist asociado a una tarea.
- Flujo detallado de planificación y programación de órdenes de trabajo.
- Modelo de ejecución y feedback en campo.
- Estructura de costes reales de ejecución.
- Relación entre orden de trabajo, centro de coste, presupuesto, contrato/subcontrato y facturación.
- Integración posterior con SAP u otros sistemas corporativos.

## 4. Próximas acciones

- Revisar el Functional Journey y la matriz Persona vs Sistema con los criterios confirmados en esta reunión.
- Revisar el caso P-101 y los contratos del **CMMS 2.0 Functional Lab** para evitar hardcodes de matriz 5×5, scoring RCM o aplicabilidad automática.
- Incorporar en el laboratorio una representación clara del plan genérico, candidatos de aplicabilidad y excepciones por activo.
- Representar el **handoff del plan publicado hacia la generación anual de órdenes preventivas** sin simular todavía que el proceso operacional completo está definido.
- Hernando revisará si dispone de documentación adicional sobre órdenes de trabajo.
- En una etapa posterior, comentar con Eduardo la incorporación de una persona de Contratos/Subcontratos que ayude a definir costes, partidas, información contractual y salida hacia facturación.

## 5. Trazabilidad

Esta reunión origina la revisión funcional documentada en:

- [`../01_Analysis/ANL-002_revision-funcional-post-reunion-2026-08-14.md`](../01_Analysis/ANL-002_revision-funcional-post-reunion-2026-08-14.md)

Los cambios derivados deberán mantenerse separados entre:

- **criterios confirmados** por la reunión;
- **hipótesis de diseño** del Functional Lab;
- **procesos operacionales abiertos** que requieren nuevas sesiones de validación.
