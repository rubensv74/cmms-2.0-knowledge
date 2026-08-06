# Validación del paquete AMEF–RCM Experience Center

Fecha de última revisión: 06/08/2026

## Estado actual

La estructura integrada contiene un `index.html` único, mapa maestro y cinco prototipos. Después de generar el primer paquete se ampliaron en profundidad los Prototipos 3 y 4.

Por este motivo, el ZIP `AMEF_RCM_Experience_Center_v1.0.zip` debe considerarse una **entrega histórica de referencia**, no el paquete final vigente.

El ZIP único se regenerará cuando termine la revisión funcional del Prototipo 5, para evitar distribuir varias versiones intermedias con el mismo nombre.

## Comprobaciones de la estructura base

- Presencia del `index.html` único de entrada.
- Resolución de enlaces relativos entre inicio, mapa maestro y cinco prototipos.
- Existencia de un documento para público general por prototipo.
- Navegación independiente y offline de cada artefacto.
- Diseño adaptable para escritorio y anchuras reducidas.
- Scripts PowerShell y Bash preparados para generar el ZIP final.

## Validación incremental — Prototipo 3

- Siete etapas funcionales: entrada AMEF, consecuencias, evidencia, árbol RCM, aplicabilidad, escenarios y decisión.
- Selección de distintos modos de fallo.
- Tratamiento de consecuencias combinadas y fallos ocultos.
- Recorrido adaptativo del árbol de decisión.
- Interacción con intervalo P–F, capacidad de intervención y probabilidad de detección.
- Gate dinámico y trazabilidad de la recomendación.
- Persistencia local y exportación JSON.
- Comprobación sintáctica del JavaScript.

## Validación incremental — Prototipo 4

- Siete etapas funcionales: decisión RCM, economía, tareas, intervalos, recursos, plan neutro y gate.
- Cuatro paquetes de decisión RCM seleccionables.
- Recalculo de costes, riesgo económico residual, ahorro esperado y ROI conceptual.
- Alta, edición y eliminación de tareas.
- Validación de técnica, criterio de aceptación, acción ante desviación e intervalo.
- Comprobación conceptual del intervalo frente al P–F y la ventana de planificación.
- Asignación de disciplina, puesto, recursos, parada, permisos y riesgos de ejecución.
- Selección del alcance físico y regla de agrupación con periféricos.
- Representación de un modelo interno neutro y mapeos ilustrativos hacia SAP, IBM Maximo y Hexagon.
- Gate bloqueado, condicionado o preparado según los datos del plan.
- Persistencia local y exportación JSON.
- Corrección de estabilidad durante la edición de tareas.
- Comprobación sintáctica del JavaScript local antes de publicar.
- Comprobación del contenido publicado en la rama mediante el SHA de blob `e5df085553dcbc6061fa653128b9fcd543b77dcf`.

## Pendiente antes de la entrega final

- Ampliar y validar el Prototipo 5.
- Ejecutar una revisión completa de navegación entre los siete HTML principales.
- Comprobar la persistencia y el reinicio de los Prototipos 3, 4 y 5.
- Regenerar el ZIP desde la versión final de la rama.
- Calcular y registrar el nuevo SHA256.
- Sustituir cualquier referencia anterior al ZIP v1.0 en la documentación de entrega.

## Alcance de la validación

Esta validación comprueba la coherencia funcional y el comportamiento de la demostración. No valida como configuración corporativa definitiva:

- escalas de riesgo;
- costes y tasas de fallo;
- reglas de intervalo;
- catálogo de disciplinas y puestos;
- codificación ISO 14224;
- autoridades de aprobación;
- campos o mapeos concretos de los sistemas destino.
