# CMMS 2.0 Functional Lab — Guía guiada de demostración alineada

**Fecha:** 2026-08-11  
**Caso de referencia:** P-101 · Bomba centrífuga de agua de refrigeración  
**Público:** Operaciones, Mantenimiento, Fiabilidad, Ingeniería, responsables de negocio, IT y perfiles no técnicos

## 1. Qué queremos demostrar

El Functional Lab no pretende enseñar una sucesión de formularios.

La idea principal que debe quedar clara es:

> **No empezamos creando tareas para P-101. Primero reutilizamos conocimiento técnico de una familia de equipos, comprobamos cómo aplica a P-101 y solo después convertimos ese razonamiento en mantenimiento ejecutable.**

El recorrido completo que vamos a enseñar es:

```text
Biblioteca de ingeniería
→ revisión AMEF aprobada
→ activo y contexto de planta
→ aplicación de esa revisión a P-101
→ análisis AMEF/RCM contextual
→ tarea ejecutable
→ plan / ruta / PM
→ ejecución real
→ aprendizaje y mejora
```

## 2. Qué papel tiene P-101

P-101 sigue siendo nuestro hilo conductor, pero ya no representa “el AMEF”.

P-101 es un activo concreto al que aplicamos una revisión AMEF reutilizable de la familia **Bomba centrífuga**.

Eso permite demostrar algo muy importante: P-101, P-102 y P-103 pueden compartir la misma ingeniería base y, aun así, terminar con frecuencias o tratamientos distintos por criticidad, redundancia y servicio.

## 3. Cómo explicar persona y software

Durante toda la demostración conviene repetir una regla sencilla:

- el sistema **muestra datos existentes**;
- el sistema **calcula** cuando existe una fórmula clara;
- el sistema **recomienda** cuando existen reglas o evidencia;
- una persona **confirma o decide** cuando hace falta criterio o autoridad;
- el sistema deja trazado qué ocurrió.

La frase útil es:

> **El software ayuda a razonar, pero no oculta quién toma la decisión.**

# PARTE I — ENTENDER EL ACTIVO

## 4. Inicio

Aquí vemos una aplicación CMMS, no una portada de prototipo.

Mostramos trabajo pendiente, revisiones AMEF, aplicaciones y casos.

**Mensaje para la reunión:**

> “P-101 es un caso de ejemplo. La estructura está preparada para trabajar con muchas familias de equipo, revisiones y activos.”

## 5. Árbol FLH

Responde: **¿dónde está P-101?**

Explica la jerarquía física/funcional y mantiene la identidad del activo.

**Mensaje:**

> “Antes de hablar de mantenimiento tenemos que saber exactamente qué objeto estamos analizando y dentro de qué sistema trabaja.”

## 6. Taxonomía

Responde: **¿qué tipo de equipo es?**

Aquí aparece la relación con la familia `Bomba centrífuga`.

Esa clasificación es la que permite después buscar conocimiento reutilizable.

**Mensaje:**

> “FLH nos dice dónde está la bomba. Taxonomía nos dice qué tipo de bomba es. Esa diferencia es la que nos permite reutilizar ingeniería entre equipos similares.”

## 7. ADR

Responde: **¿con qué otros objetos está relacionada P-101?**

Podemos mostrar motor, acoplamiento, P-102 de reserva, E-201 u otros objetos relacionados.

El árbol es una forma de navegar; el modelo real sigue siendo relación origen-tipo-destino.

**Mensaje:**

> “ADR nos ayuda a entender dependencias y redundancias que la jerarquía FLH por sí sola no explica.”

## 8. Criticidad del activo

Esta pantalla merece una explicación específica.

La criticidad de P-101 es contextual: depende de su papel en la planta, producción, seguridad, medioambiente, redundancia y servicio.

No es el mismo concepto que el riesgo AMEF de un modo de fallo.

```text
Criticidad del activo ≠ Matriz S×O ≠ NPR
```

**Mensaje:**

> “La misma familia de bomba puede tener distinta criticidad según dónde esté instalada. Por eso la criticidad pertenece al activo y su contexto, no al AMEF genérico.”

## 9. Ficha 360

Resume todo lo que sabemos de P-101 y enlaza con su criticidad, revisión AMEF aplicada, análisis y planes.

**Mensaje:**

> “La ficha 360 no crea otra copia de los datos. Nos permite ver la misma identidad del activo desde distintos procesos.”

# PARTE II — LA BIBLIOTECA DE INGENIERÍA

## 10. Biblioteca AMEF

Esta es una de las pantallas nuevas más importantes.

Aquí dejamos de pensar en P-101 y pensamos en **familias de equipo**.

Ejemplos:

- Bomba centrífuga;
- Compresor centrífugo;
- Compresor reciprocante.

**Mensaje:**

> “La idea es no volver a hacer el mismo AMEF cada vez que aparece una bomba nueva. La ingeniería se mantiene una vez y se reutiliza.”

## 11. Revisión AMEF

Abrimos `AMEF-BOMBA-CENTRIFUGA / R01`.

La revisión contiene:

```text
Funciones
→ Fallos funcionales
→ Modos
→ Causas / mecanismos
→ Efectos
→ Tareas propuestas
```

Una revisión aprobada puede quedar congelada. Si aprendemos algo nuevo, generamos una revisión posterior.

### Conceptos que conviene explicar

**Función:** lo que esperamos que haga el equipo.  
**Fallo funcional:** cómo deja de cumplirlo.  
**Modo de fallo:** cómo se produce esa pérdida.  
**Causa/mecanismo:** qué origina o favorece ese modo.  
**Efecto:** qué sucede cuando ocurre.

**Mensaje:**

> “Aquí vive el conocimiento reusable. Todavía no estamos diciendo cada cuánto lo haremos en P-101.”

## 12. Tareas propuestas y cobertura

La biblioteca puede proponer tareas base.

Una misma tarea puede detectar varios modos y un modo puede necesitar varias tareas.

**Mensaje:**

> “La relación entre tarea y fallo no es uno a uno. El modelo debe poder explicar exactamente qué riesgos cubre cada actividad.”

# PARTE III — APLICAR LA INGENIERÍA A P-101

## 13. Aplicación a activos

Mostramos la misma revisión aplicada a P-101, P-102 y P-103.

La ingeniería base no se duplica.

Lo que cambia puede ser:

- aplicabilidad;
- criticidad;
- intervalo;
- tratamiento;
- excepción contextual.

**Mensaje:**

> “Aquí está una de las mejoras clave: reutilizamos conocimiento sin obligar a que todos los activos tengan exactamente el mismo mantenimiento.”

## 14. Perfiles y overrides

P-101 puede usar un perfil de alta criticidad, P-102 uno medio y P-103 uno bajo.

Los nombres actuales son demostrativos.

Si una persona cambia algo respecto a la propuesta base, debe quedar registrado como override y con motivo.

# PARTE IV — ABRIR EL CASO CONTEXTUAL

## 15. Registro de análisis

Ahora sí aparece el `AnalysisCase`.

El caso une:

```text
P-101
+ revisión AMEF R01
+ aplicación APP-P101-R01
+ criticidad de planta
+ decisiones contextuales
```

**Mensaje:**

> “El caso no crea la ingeniería. La utiliza y documenta cómo la estamos aplicando a este activo concreto.”

## 16. Recorrido de 28 etapas

El Process Rail mantiene visible la metodología completa sin convertir la aplicación en un wizard rígido.

Las primeras etapas ahora se interpretan correctamente:

- confirmar activo, límites y contexto;
- revisar funciones y fallos heredados;
- confirmar qué modos y causas aplican;
- valorar el riesgo en este contexto.

# PARTE V — AMEF CONTEXTUAL

## 17. Modos y causas

En P-101 podemos trabajar con FM-03 · degradación de rodamiento.

La biblioteca aporta el modo y causas posibles, como lubricación insuficiente o desalineación.

El sistema puede destacar una hipótesis, pero la persona confirma qué aplica.

**Mensaje:**

> “No estamos inventando el modo para P-101. Estamos comprobando si un modo conocido de la familia realmente aplica aquí.”

## 18. Efectos y consecuencias

La biblioteca aporta una descripción base; el activo puede necesitar contextualización.

P-101 puede tener una consecuencia operacional distinta de otro activo similar por su servicio o redundancia.

## 19. Matriz de riesgo AMEF

Para el caso de demostración usamos escala 1–5:

```text
S = 4
O = 3
D = 3
S×O = 12
NPR = 36
```

La matriz visual representa **Severidad × Ocurrencia**.

Detección participa en NPR, no en la posición de la matriz.

**Mensaje clave:**

> “Esta matriz valora el riesgo del modo de fallo. No es la criticidad de P-101 en planta, que ya vimos antes.”

Los colores y umbrales siguen pendientes de validación corporativa.

# PARTE VI — DECISIÓN RCM

## 20. RCM

El objetivo no es obtener automáticamente una respuesta.

La aplicación guía preguntas sobre:

- si el fallo es evidente;
- si existe degradación detectable;
- si hay una ventana P–F aprovechable;
- qué políticas son técnicamente válidas.

La lógica RCM está preparada para ser versionable. El árbol definitivo todavía debe validarse corporativamente.

**Mensaje:**

> “El sistema puede recorrer una lógica y recomendar. La decisión final debe seguir siendo explicable y atribuible.”

## 21. P–F

Si existe evidencia de degradación detectable, podemos estimar una ventana entre el momento en que el fallo empieza a ser detectable y el fallo funcional.

Eso puede ayudar a recomendar un intervalo.

La regla definitiva de cálculo sigue pendiente.

# PARTE VII — CONVERTIR LA DECISIÓN EN TRABAJO EJECUTABLE

## 22. Economía

Distinguimos:

- comparación económica de alternativas;
- coste estimado de la tarea/plan;
- coste real de ejecución.

**Mensaje:**

> “El coste nos ayuda a elegir entre alternativas técnicamente válidas. No convierte una mala estrategia técnica en una buena estrategia.”

## 23. Tarea e intervalo

Aquí se produce una transformación importante:

```text
Tarea propuesta de biblioteca
→ variante aplicada a P-101
→ tarea ejecutable
```

La tarea puede incluir:

- técnica;
- criterio de aceptación;
- acción si falla;
- intervalo;
- parada requerida;
- aislamiento/permiso;
- duración;
- cuadrilla;
- H-H;
- disciplina.

## 24. Procedimiento opcional

No toda actividad necesita un procedimiento independiente.

Una inspección sencilla puede no necesitarlo; una actividad más compleja puede requerir checklist o procedimiento versionado.

**Mensaje:**

> “Tarea y procedimiento son objetos distintos. El procedimiento existe cuando aporta valor, no por obligación del sistema.”

## 25. Paquete de plan y alcance físico

El plan puede incluir equipo principal y equipos de soporte.

Cada objeto mantiene su identidad mediante `PlanScopeItem`.

Aunque agrupemos tareas, nunca perdemos qué tag recibió qué trabajo.

## 26. Agrupación

Podemos agrupar por frecuencia, actividad, planta, ejecutor o localización.

El objetivo es evitar miles de rutas y planes difíciles de mantener.

**Mensaje:**

> “Queremos simplificar la gestión sin sacrificar trazabilidad.”

# PARTE VIII — DEL PLAN A LA EJECUCIÓN

## 27. Planes de mantenimiento

Aquí conviene explicar que no son sinónimos:

```text
MaintenanceTask
MaintenanceProcedure
JobPlan / Route
PreventiveMaintenancePlan
WorkOrder
```

La cadena conceptual es:

```text
Tarea
→ Job Plan / Ruta
→ PM
→ Orden de trabajo
→ Resultado
```

Cada resultado sigue asociado al `TechnicalObject` concreto.

# PARTE IX — GOBERNAR Y APRENDER

## 28. Trazabilidad

La aplicación debe poder explicar una tarea hacia atrás:

```text
Revisión AMEF
→ modo / causa
→ decisión RCM
→ tarea propuesta
→ variante P-101
→ tarea ejecutable
→ Job Plan / PM
→ WO
→ resultado
```

## 29. Revisión y aprobación

Aprobar no significa perder historial.

Una versión aprobada debe poder congelarse y cualquier cambio posterior debe ser controlado.

## 30. Efectividad

Una estrategia no termina cuando generamos el plan.

Comparamos hipótesis con datos reales: fallos, hallazgos, cumplimiento, costes y resultados.

La persona decide si mantiene, ajusta la aplicación o abre una mejora de la biblioteca.

**Mensaje final:**

> “El resultado de mantenimiento vuelve a ingeniería. El modelo aprende sin borrar por qué se tomó la decisión anterior.”

# PARTE X — RECORRIDO RECOMENDADO PARA LA REUNIÓN

Para una sesión de 45–60 minutos:

1. Inicio — 2 min.
2. FLH / Taxonomía / ADR — 6 min.
3. Criticidad — 4 min.
4. Biblioteca AMEF — 5 min.
5. Revisión AMEF — 6 min.
6. Aplicación multi-activo — 5 min.
7. AnalysisCase / Process Rail — 4 min.
8. AMEF + matriz S×O/NPR — 8 min.
9. RCM — 6 min.
10. Tarea / procedimiento / H-H — 5 min.
11. Plan / Job Plan / PM / WO — 5 min.
12. Trazabilidad / efectividad — 4 min.

# PARTE XI — ASUNTOS QUE DEBEMOS PRESENTAR COMO ABIERTOS

No presentar todavía como regla corporativa:

- escalas AMEF definitivas;
- umbrales y colores;
- reglas oficiales de criticidad;
- árbol RCM definitivo;
- regla P–F / intervalo;
- autoridades finales;
- evidencia mínima;
- reglas de sobreclasificación;
- criterios de aprobación;
- KPIs de efectividad;
- reglas finales de agrupación;
- sistema destino e integración;
- arquitectura física de datos.

## 31. Cierre recomendado

> “El cambio principal respecto a un CMMS tradicional es que no partimos de una lista de preventivos. Partimos de conocimiento técnico reutilizable, lo aplicamos al contexto real de cada activo, documentamos las decisiones y terminamos generando trabajo ejecutable cuya efectividad después podemos comprobar.”
