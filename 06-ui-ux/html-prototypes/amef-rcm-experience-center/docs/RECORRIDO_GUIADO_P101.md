# Recorrido guiado P-101 — AMEF–RCM para CMMS 2.0

## Propósito

Esta versión sustituye la navegación meramente conceptual por una experiencia didáctica basada en un caso realista: la bomba centrífuga **P-101**, destinada al servicio de agua de refrigeración.

El usuario recorre **28 etapas encadenadas** agrupadas en los cinco bloques funcionales AMEF–RCM. En cada etapa se muestran:

- la pregunta que debe responder el negocio;
- la información disponible del caso;
- la acción que debe realizar el equipo;
- la decisión que debe quedar registrada;
- los requisitos del gate;
- la salida que recibe la siguiente etapa.

## Principios de diseño

1. **El ejemplo precede a la teoría.** El recorrido comienza con un activo, un servicio y un contexto operacional concretos.
2. **Una decisión cada vez.** El usuario no avanza por páginas; avanza cuando confirma una decisión funcional.
3. **Gates explicables.** Cuando no se puede continuar, la aplicación indica exactamente qué información o criterio falta.
4. **Trazabilidad acumulativa.** Cada confirmación alimenta un registro que permite reconstruir el razonamiento completo.
5. **Datos editables.** El caso está precargado, pero puede discutirse y modificarse durante la reunión.
6. **Modo presentación.** Permite saltar a cualquier etapa sin eliminar los controles metodológicos.
7. **Módulos de detalle.** Los cinco prototipos anteriores siguen disponibles para profundizar en cada bloque.

## Etapas

### 1. Comprender el problema

1. Definir el activo y sus límites.
2. Describir el contexto operacional.
3. Comprobar la preparación de datos.
4. Definir funciones con estándar.
5. Identificar fallos funcionales.
6. Seleccionar modos de fallo relevantes.

### 2. Evaluar el riesgo

7. Describir efectos.
8. Clasificar consecuencias.
9. Valorar severidad, ocurrencia y detección.
10. Aplicar reglas de sobreclasificación.
11. Revisar controles y excepciones.

### 3. Tomar la decisión RCM

12. Confirmar si el fallo es evidente.
13. Demostrar degradación detectable.
14. Evaluar la ventana P–F.
15. Comparar políticas técnicamente válidas.
16. Emitir la decisión RCM explicable.

### 4. Convertir la decisión en un plan

17. Comparar el coste esperado.
18. Diseñar una tarea ejecutable.
19. Justificar el intervalo.
20. Asignar recursos y condiciones de ejecución.
21. Definir alcance y paquete de plan.
22. Superar el gate del plan.

### 5. Gobernar y mejorar

23. Reconstruir la trazabilidad integral.
24. Ejecutar el control de calidad.
25. Resolver la revisión multidisciplinar.
26. Aprobar y congelar una versión.
27. Comparar hipótesis con datos reales.
28. Abrir la mejora continua.

## Uso en reunión

La secuencia recomendada es:

1. Abrir `index.html`.
2. Explicar el caso P-101 en la primera etapa.
3. Confirmar varias decisiones para mostrar cómo se desbloquea el recorrido.
4. Utilizar el modo presentación para saltar a AMEF, RCM, plan y mejora continua.
5. Abrir un módulo de detalle solo cuando sea necesario discutir una etapa con mayor profundidad.

## Límite

El caso es realista y coherente de extremo a extremo, pero no representa una instrucción de mantenimiento aprobada. Las escalas, valores, roles, umbrales, frecuencias y autoridades deben validarse corporativamente.
