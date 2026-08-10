# CMMS 2.0 Functional Lab — Guía guiada de demostración

**Fecha:** 2026-08-10  
**Caso de referencia:** P-101 · Bomba centrífuga de agua de refrigeración  
**Público:** Operaciones, Mantenimiento, Fiabilidad, Ingeniería, responsables de negocio, IT y perfiles no técnicos  
**Objetivo:** explicar la aplicación de forma sencilla, profesional y comprensible, sin perder el rigor del proceso de mantenimiento.

---

## 1. Qué queremos demostrar

CMMS Functional Lab no intenta enseñar una sucesión de prototipos ni una colección de pantallas independientes.

La demostración debe transmitir una idea mucho más sencilla:

> **Antes de decidir qué mantenimiento hacer, necesitamos entender el activo, saber qué función debe cumplir, identificar cómo puede dejar de cumplirla, valorar qué consecuencias tendría y justificar técnicamente la estrategia que finalmente adoptemos.**

La aplicación organiza ese razonamiento, automatiza lo que puede calcularse de forma objetiva y deja en manos de las personas las decisiones que necesitan conocimiento, criterio o autoridad.

El objetivo final no es obtener un plan preventivo “porque siempre se ha hecho así”. El objetivo es poder responder, incluso meses o años después:

- por qué existe una tarea;
- qué modo de fallo pretende controlar;
- qué evidencia utilizamos;
- qué riesgo se valoró;
- qué recomendó el sistema;
- quién tomó la decisión;
- por qué se eligió esa alternativa;
- y si, con datos reales, la decisión está funcionando.

Ese es el hilo que une toda la demostración.

---

## 2. El ejemplo que nos acompañará durante todo el recorrido

Para que la demostración sea fácil de seguir utilizamos siempre el mismo activo:

**P-101 · Bomba centrífuga de agua de refrigeración**.

No buscamos demostrar que los valores del ejemplo sean una instrucción de mantenimiento real. P-101 es un caso de trabajo coherente que nos permite recorrer toda la lógica del futuro CMMS.

Durante la demostración veremos la misma P-101 desde distintos puntos de vista:

```text
Dónde está instalada        → FLH
Qué tipo de equipo es       → Taxonomía
Con qué objetos se relaciona→ ADR
Qué sabemos de ella         → Ficha 360
Qué debe hacer              → Funciones
Cómo puede fallar           → Modos de fallo
Qué consecuencias tendría   → AMEF
Qué política conviene       → RCM
Qué tarea debemos ejecutar  → Plan de mantenimiento
Cómo sabemos si funciona    → Efectividad
```

Esto es importante: **no estamos creando información distinta en cada pantalla; estamos observando y enriqueciendo el mismo objeto a lo largo de todo su ciclo de análisis.**

---

## 3. Cómo leer la aplicación durante la demostración

Antes de entrar en las pantallas conviene explicar una regla visual y funcional muy sencilla.

En CMMS Functional Lab hay cuatro tipos de información:

### Información que ya existe

Son datos que el sistema debería recibir del maestro de activos, documentación técnica, históricos, órdenes de trabajo, catálogos o configuraciones.

Ejemplos:

- código P-101;
- tipo de equipo;
- posición dentro de la planta;
- fabricante;
- documentación disponible;
- histórico de incidencias.

El análisis consulta estos datos, pero no debería modificarlos silenciosamente.

### Información que aporta una persona

Hay elementos que requieren conocimiento del proceso o experiencia técnica.

Ejemplos:

- definir correctamente una función;
- describir un efecto de fallo;
- valorar severidad;
- confirmar una consecuencia;
- elegir una estrategia de mantenimiento.

### Información que calcula o propone el software

El sistema puede:

- hacer cálculos;
- comprobar condiciones;
- detectar incoherencias;
- comparar alternativas;
- generar recomendaciones.

Pero una recomendación no se debe presentar como si fuera una decisión humana.

### Decisiones que necesitan autoridad humana

Cuando la decisión afecta a estrategia, aceptación de riesgo, aprobación o cambio de versión, debe quedar claro quién confirma la decisión y por qué.

La frase que conviene mantener durante toda la demostración es:

> **El software ayuda a razonar; la responsabilidad no desaparece detrás del software.**

---

# PARTE I — ENTENDER EL ACTIVO ANTES DE ANALIZARLO

## 4. Inicio

### Qué estamos viendo

La pantalla de Inicio se comporta como la entrada a una aplicación CMMS real: casos activos, trabajo pendiente y acceso a los módulos principales.

P-101 aparece como un caso disponible, no como “el prototipo”.

### Por qué importa

Queremos que desde el primer momento el usuario sienta que está trabajando con objetos de mantenimiento y no recorriendo una presentación.

### Qué hace la persona

Elige qué activo, caso o módulo quiere consultar.

### Qué hace el software

Carga el contexto del usuario, los casos disponibles, su progreso y sus estados.

### Mensaje para la reunión

> “El Functional Lab empieza ya con lógica de producto. P-101 es nuestro ejemplo, pero la estructura está pensada para trabajar con muchos activos y muchos casos.”

---

## 5. Árbol FLH

### La pregunta que responde

**¿Dónde está P-101 dentro de la planta?**

### Qué concepto estamos viendo

FLH representa la jerarquía funcional y de localización del activo. Nos permite recorrer niveles de planta, área, unidad, sistema, subsistema y equipo hasta llegar al objeto que queremos analizar.

El número exacto de niveles no debería limitar la aplicación. Una planta puede utilizar cinco, seis o más niveles según su modelo corporativo.

### Qué hace la persona

Navega, busca, expande ramas y selecciona el activo.

### Qué hace el software

Construye la jerarquía padre-hijo, mantiene la ruta del objeto y resalta P-101.

### Qué no estamos decidiendo aquí

No estamos decidiendo ninguna tarea de mantenimiento. Estamos estableciendo la identidad y el contexto estructural del activo.

### Mensaje para la reunión

> “Antes de analizar una bomba tenemos que estar seguros de qué bomba estamos analizando y dentro de qué sistema trabaja. Esta identidad será la misma durante todo el recorrido.”

---

## 6. Taxonomía

### La pregunta que responde

**¿Qué tipo de activo es P-101?**

### Diferencia respecto a FLH

FLH responde **dónde está**.

Taxonomía responde **qué es**.

Una bomba puede cambiar de ubicación sin dejar de pertenecer a la misma familia de equipos. Por eso ambos conceptos no deben mezclarse.

### Qué hace la persona

Consulta la clasificación y verifica que el activo está correctamente asociado a su familia, clase o subclase.

### Qué hace el software

Muestra el esquema de clasificación y la posición de P-101 dentro de él.

### Qué no se decide aquí

El análisis AMEF/RCM no debería modificar la taxonomía. Si la clasificación es incorrecta, debe corregirse mediante el gobierno del dato maestro.

### Mensaje para la reunión

> “Separar ubicación y clasificación parece un detalle, pero es fundamental para que después podamos comparar activos similares, reutilizar conocimiento y mantener una estructura de datos coherente.”

---

## 7. Árbol ADR

### La pregunta que responde

**¿Con qué otros objetos está relacionada P-101?**

### Por qué necesitamos ADR si ya tenemos FLH

La jerarquía padre-hijo no explica todas las relaciones importantes para mantenimiento.

P-101 puede estar relacionada con:

- su motor M-101;
- un acoplamiento;
- el intercambiador E-201 al que suministra refrigeración;
- la bomba de reserva P-102;
- puntos de monitorización de condición.

Esas relaciones pueden ser físicas, funcionales, de dependencia, redundancia o monitorización.

### Cómo se muestra

Para facilitar la navegación utilizamos una presentación jerárquica, pero conceptualmente ADR representa relaciones del tipo:

```text
objeto origen
   → tipo de relación
      → objeto destino
```

Por tanto, no debemos confundir el árbol visual ADR con una nueva jerarquía física de planta.

### Qué hace la persona

Selecciona una relación y consulta su significado.

### Qué hace el software

Agrupa y representa las relaciones del activo de forma navegable.

### Mensaje para la reunión

> “FLH nos dice dónde está P-101. ADR nos explica de qué depende y qué depende de ella. Esta información puede cambiar completamente la criticidad de un fallo.”

---

## 8. Ficha 360 del activo

### La pregunta que responde

**¿Qué sabemos de P-101 antes de iniciar un análisis?**

### Qué esperamos encontrar

Una visión consolidada del objeto:

- identificación;
- clasificación;
- ubicación;
- documentación;
- estado;
- relaciones;
- análisis asociados;
- planes de mantenimiento relacionados.

### Qué hace la persona

Consulta información y decide desde qué proceso quiere continuar.

### Qué hace el software

Consolida información procedente de distintas entidades sin duplicarla.

### Mensaje para la reunión

> “La Ficha 360 no pretende crear otra base de datos. Es el punto desde el que podemos entender el activo y acceder a toda la información que gira alrededor de él.”

---

# PARTE II — ABRIR UN CASO DE ANÁLISIS

## 9. Registro de análisis

### La pregunta que responde

**¿Qué análisis existen y en qué estado se encuentra cada uno?**

### Qué concepto aparece

El objeto principal ya no es únicamente el activo. Aparece un **caso de análisis**.

Una misma bomba puede tener distintos análisis a lo largo del tiempo, versiones, revisiones o reaperturas.

### Qué hace la persona

Busca, filtra y abre un caso.

### Qué hace el software

Muestra estado, versión, propietario, etapa actual y progreso.

### Mensaje para la reunión

> “P-101 es un activo. El análisis AMEF/RCM es otro objeto con su propio ciclo de vida. Separarlos nos permite versionar, revisar y auditar las decisiones sin alterar el maestro del activo.”

---

## 10. Resumen del caso y recorrido de 28 etapas

### La pregunta que responde

**¿Dónde estamos dentro del análisis y qué queda por hacer?**

### Qué estamos viendo

Las 28 etapas siguen existiendo. No las hemos eliminado para ahorrar pantallas.

El Process Rail funciona como mapa del recorrido:

```text
Comprender el problema
Evaluar el riesgo
Tomar la decisión RCM
Convertir la decisión en un plan
Gobernar y mejorar
```

Cada etapa muestra su estado y responsabilidad.

### Por qué es importante

Un usuario experto puede consultar diferentes secciones de la aplicación, pero el método no desaparece. La aplicación siempre debe dejar claro:

- qué se ha completado;
- qué está en curso;
- qué está pendiente;
- quién debe actuar;
- y qué condiciones deben cumplirse antes de formalizar el siguiente paso.

### Mensaje para la reunión

> “No queremos obligar al usuario a trabajar dentro de un wizard rígido, pero tampoco queremos que se pierda la secuencia. Por eso la metodología permanece visible durante todo el caso.”

---

# PARTE III — COMPRENDER EL PROBLEMA

## 11. Contexto del análisis — FL-01 a FL-03

### La pregunta que responde

**¿Qué estamos analizando exactamente y en qué condiciones debe funcionar?**

Antes de hablar de fallos necesitamos cerrar tres cuestiones.

### FL-01 · Activo y límites

La persona confirma dónde empieza y termina el alcance del análisis.

Esto evita analizar una bomba sin dejar claro si el motor, el acoplamiento, las protecciones o determinados auxiliares forman parte del mismo alcance.

### FL-02 · Contexto operacional

Se describe cómo trabaja realmente el activo:

- demanda;
- modos de operación;
- arranques y paradas;
- condiciones ambientales;
- redundancia;
- restricciones de producción.

### FL-03 · Preparación de los datos

El software puede comprobar qué evidencias están disponibles y avisar de carencias.

La persona confirma si la base de información es suficiente para continuar.

### Qué hace el software

Ordena la evidencia, comprueba campos obligatorios y muestra si falta información.

### Qué decide la persona

Confirma alcance, contexto y suficiencia de la evidencia.

### Mensaje para la reunión

> “Una de las ideas principales del modelo es no empezar diciendo qué preventivo queremos hacer. Primero tenemos que entender qué esperamos realmente del activo.”

---

## 12. Funciones y fallos funcionales — FL-04 y FL-05

### La pregunta que responde

**¿Qué debe hacer P-101 y qué significa que deje de hacerlo correctamente?**

### Función

Una función no debería ser simplemente “bombear”.

Debe expresar qué necesita el negocio del activo y, siempre que sea posible, con qué estándar.

Ejemplo conceptual:

> Transferir el caudal de agua de refrigeración requerido al sistema, manteniendo las condiciones de servicio definidas.

### Fallo funcional

Un fallo funcional describe la pérdida de esa capacidad.

Puede ser total o parcial.

Ejemplos:

- no suministrar caudal;
- suministrar un caudal insuficiente;
- no mantener presión;
- perder contención.

### Qué hace la persona

Define y confirma funciones y fallos funcionales.

### Qué hace el software

Puede ofrecer estructura, comprobar campos o reutilizar conocimiento, pero no debe inventar silenciosamente la función del activo.

### Mensaje para la reunión

> “Todavía no estamos buscando causas. Primero definimos qué debe conseguir el activo y de qué maneras puede dejar de cumplir esa función.”

---

## 13. Modos de fallo — FL-06

### La pregunta que responde

**¿Qué puede provocar el fallo funcional que estamos analizando?**

### Diferencia importante

No debemos confundir:

```text
Fallo funcional → qué capacidad se pierde
Modo de fallo    → qué mecanismo o causa provoca esa pérdida
```

### Caso P-101

El sistema puede destacar FM-03 como modo relevante a partir de la evidencia disponible.

Pero la recomendación del sistema no se convierte automáticamente en decisión.

### Qué hace el software

Ordena candidatos, puede priorizar y explicar por qué recomienda uno.

### Qué hace la persona

Selecciona el modo de fallo que se analizará.

Si se aparta de la recomendación, debe quedar trazado el motivo.

### Mensaje para la reunión

> “Aquí empieza a verse claramente la diferencia entre ayuda del sistema y autoridad humana. El software puede recomendar; una persona confirma qué hipótesis de fallo vamos a analizar.”

---

# PARTE IV — AMEF: ENTENDER EFECTOS Y RIESGO

## 14. AMEF — FL-07 a FL-11

Esta es una de las pantallas más importantes de la demostración.

AMEF nos ayuda a responder:

> **Si este modo de fallo ocurre, ¿qué sucede y qué importancia tiene para el negocio?**

---

### FL-07 · Efectos del fallo

La persona describe qué ocurre en tres niveles:

**Efecto local**  
Qué ocurre directamente en el componente o equipo.

**Efecto en el sistema**  
Cómo afecta al sistema del que forma parte.

**Efecto operacional**  
Qué consecuencia percibe la operación o el negocio.

Esta separación ayuda a evitar frases genéricas como “la bomba falla”.

---

### FL-08 · Consecuencia

A partir de los efectos, el sistema puede sugerir una clasificación de consecuencia.

Por ejemplo, operacional, seguridad, medioambiental u otra categoría definida por el modelo.

La clasificación final necesita confirmación humana.

### Mensaje clave

> **El software propone una interpretación; la persona confirma la consecuencia.**

---

### FL-09 · Severidad, Ocurrencia y Detección

Para P-101 mantenemos la escala utilizada en los prototipos revisados:

```text
Severidad     1–5
Ocurrencia    1–5
Detección     1–5
```

La persona valora los tres factores utilizando evidencia y criterio técnico.

El sistema no debería ocultar de dónde procede cada valor.

#### Matriz de criticidad

Severidad y Ocurrencia se representan mediante una matriz **5×5**.

Por tanto existen 25 posibles combinaciones.

En el caso inicial:

```text
S = 4
O = 3
S×O = 12
```

La posición en la matriz permite comprender visualmente la criticidad.

#### Detección y NPR

Detección se mantiene separada de la posición de la matriz.

El software calcula automáticamente:

```text
NPR = Severidad × Ocurrencia × Detección
```

Para el ejemplo:

```text
4 × 3 × 3 = 36
```

La matriz y el NPR están relacionados, pero no son el mismo indicador.

### Qué es humano

- asignar S;
- asignar O;
- asignar D;
- revisar la evidencia que justifica esos valores.

### Qué es automático

- calcular S×O;
- situar la combinación en la matriz;
- calcular el NPR;
- aplicar bandas configuradas;
- detectar incoherencias o datos ausentes.

### Nota importante para la demostración

Las bandas de color actuales son demostrativas. No debemos presentarlas como una escala corporativa aprobada.

---

### FL-10 · Sobreclasificación

Hay situaciones en las que una simple cifra no debe tener la última palabra.

Determinadas consecuencias de seguridad, medioambiente, cumplimiento o fallos ocultos pueden necesitar reglas especiales de prioridad.

El sistema puede detectar estas condiciones y recomendar una sobreclasificación.

La regla debe ser visible y explicable.

---

### FL-11 · Control de avance AMEF

Antes de entrar en RCM, la aplicación comprueba que el análisis contiene la información mínima necesaria.

No queremos un botón “Siguiente” deshabilitado sin explicación.

El control de avance debe indicar:

- qué está completo;
- qué falta;
- por qué importa;
- quién debe resolverlo;
- qué información pasará a RCM.

### Mensaje para la reunión

> “AMEF no consiste simplemente en obtener un número. El valor está en entender efectos, consecuencias, evidencia y riesgo. El cálculo ayuda; el razonamiento debe seguir siendo visible.”

---

# PARTE V — RCM: DECIDIR QUÉ HACER

## 15. Decisión RCM — FL-12 a FL-16

### La pregunta que responde

**Ahora que sabemos cómo puede fallar y qué consecuencias tendría, ¿qué política de mantenimiento tiene sentido aplicar?**

RCM no es un algoritmo que elige automáticamente una tarea. Es una secuencia de razonamiento estructurada.

---

### FL-12 · Fallo evidente u oculto

La persona confirma si el fallo será evidente para Operaciones en condiciones normales.

Esto cambia el camino de decisión.

---

### FL-13 · Degradación detectable

Se evalúa si existe una señal medible antes de que aparezca el fallo funcional.

Ejemplos:

- vibración;
- temperatura;
- análisis de aceite;
- pérdida de rendimiento;
- inspección visual.

El sistema puede identificar evidencias disponibles y recomendar si existe una oportunidad de mantenimiento por condición.

---

### FL-14 · Ventana P–F

Si existe degradación detectable, debemos saber si hay tiempo suficiente entre:

**P** — momento en que podemos detectar el fallo potencial.  
**F** — momento en que se produce el fallo funcional.

El sistema puede calcular o comparar intervalos si dispone de datos.

La persona debe confirmar que la hipótesis es razonable.

---

### FL-15 · Comparación de políticas

El sistema puede comparar opciones técnicamente válidas:

- mantenimiento por condición;
- restauración programada;
- sustitución programada;
- prueba funcional;
- rediseño;
- operar hasta fallo cuando sea justificable.

No todas las opciones son válidas para todos los modos de fallo.

---

### FL-16 · Decisión RCM

La persona responsable confirma la política elegida.

La aplicación conserva:

```text
recomendación del sistema
+ decisión humana
+ alternativa considerada
+ motivo
+ autoridad
```

### Mensaje para la reunión

> “El objetivo de RCM no es generar preventivos automáticamente. Es justificar qué estrategia tiene sentido para este modo de fallo y dejar claro por qué.”

---

# PARTE VI — CONVERTIR LA ESTRATEGIA EN UN PLAN EJECUTABLE

## 16. Evaluación económica — FL-17

### La pregunta que responde

**Entre las alternativas técnicamente válidas, ¿qué impacto económico tiene cada una?**

La economía aparece después de comprobar la validez técnica.

No queremos seleccionar una estrategia insegura simplemente porque sea más barata.

### Qué hace el software

Puede comparar:

- coste de la tarea;
- frecuencia esperada;
- coste de indisponibilidad;
- coste de fallo esperado;
- riesgo económico residual.

### Qué hace la persona

Revisa supuestos y utiliza la comparación como apoyo a la decisión.

### Mensaje para la reunión

> “Primero preguntamos qué es técnicamente defendible. Después comparamos el coste de las alternativas válidas.”

---

## 17. Tarea e intervalo — FL-18 y FL-19

### FL-18 · Diseñar una tarea ejecutable

Una estrategia todavía no es una orden de trabajo.

La persona transforma la política en una tarea concreta:

- qué hacer;
- sobre qué objeto;
- con qué método;
- qué condición observar;
- qué resultado esperar.

### FL-19 · Justificar el intervalo

La frecuencia no debe aparecer “porque siempre se ha hecho mensual”.

El intervalo debería derivarse de evidencia, experiencia, P–F, normativa, fabricante o una regla explícita.

El sistema puede recomendar un intervalo.

La persona confirma o modifica esa propuesta.

### Mensaje para la reunión

> “Queremos que cada frecuencia tenga una explicación. Si dentro de tres años alguien pregunta por qué hacemos una tarea cada mes, el sistema debe poder responder.”

---

## 18. Paquete de plan — FL-20 a FL-22

### La pregunta que responde

**¿Está la tarea suficientemente definida para que pueda ejecutarse en mantenimiento?**

### FL-20 · Recursos y condiciones

Se definen:

- especialidad;
- duración;
- herramientas;
- repuestos;
- permisos;
- condiciones de seguridad;
- necesidades de parada.

### FL-21 · Alcance y agrupación

Se establece sobre qué activos aplica la tarea y cómo se integrará en un paquete de mantenimiento.

### FL-22 · Control de avance del plan

El sistema comprueba que el paquete puede pasar a planificación/publicación.

### Mensaje para la reunión

> “Hasta aquí hemos estado razonando sobre estrategia. En este punto convertimos esa estrategia en algo que Planificación y Mantenimiento realmente puedan ejecutar.”

---

# PARTE VII — GOBERNAR LA DECISIÓN

## 19. Trazabilidad y calidad — FL-23 y FL-24

### La pregunta que responde

**¿Podemos reconstruir cómo llegamos desde el activo hasta la tarea final?**

La trazabilidad debe permitir recorrer la cadena:

```text
Activo
→ Función
→ Fallo funcional
→ Modo de fallo
→ Efectos
→ Riesgo
→ Decisión RCM
→ Tarea
→ Intervalo
→ Plan
```

### FL-23 · Trazabilidad

El software puede reconstruir automáticamente las relaciones entre objetos y decisiones.

### FL-24 · Control de calidad

El sistema identifica huecos, contradicciones o evidencias insuficientes.

Una persona revisa los hallazgos que necesitan interpretación.

### Mensaje para la reunión

> “La trazabilidad es lo que transforma un conjunto de formularios en un modelo defendible. Podemos explicar de dónde viene cada tarea y qué decisión la originó.”

---

## 20. Revisión y aprobación — FL-25 y FL-26

### La pregunta que responde

**¿Quién confirma que el análisis está preparado para convertirse en una versión oficial?**

### FL-25 · Revisión multidisciplinar

El análisis puede requerir participación de:

- Fiabilidad;
- Mantenimiento;
- Operaciones;
- Asset Owner;
- otras disciplinas cuando proceda.

No todos los roles aportan lo mismo, y por eso la aplicación debe conservar sus observaciones y decisiones.

### FL-26 · Aprobación y snapshot

Una vez aprobada una versión, debemos congelar una fotografía de lo que se aprobó.

Una modificación posterior no debería reescribir silenciosamente el pasado.

### Qué hace el software

- registra estados;
- conserva participantes;
- almacena fecha y versión;
- genera snapshot;
- controla reaperturas.

### Qué hace la persona

Revisa y aprueba con la autoridad correspondiente.

### Mensaje para la reunión

> “Una decisión aprobada tiene que poder auditarse. Si el análisis cambia después, debe existir una nueva versión, no una modificación invisible de la anterior.”

---

# PARTE VIII — COMPROBAR QUE EL PLAN FUNCIONA

## 21. Efectividad y mejora — FL-27 y FL-28

### La pregunta que responde

**Después de implantar el mantenimiento, ¿la estrategia funciona realmente?**

La metodología no termina cuando se publica una tarea.

### FL-27 · Comparar hipótesis con datos reales

El software puede comparar lo que esperábamos con lo que realmente sucede:

- fallos observados;
- alarmas;
- intervenciones;
- costes;
- indisponibilidad;
- resultados de inspección;
- comportamiento del intervalo.

### FL-28 · Mejora continua

Si la realidad contradice la hipótesis inicial, una persona puede solicitar un cambio y reabrir controladamente el análisis.

### Mensaje para la reunión

> “El plan no es el final del proceso. El dato real debe volver al análisis. Si nuestras hipótesis no se cumplen, el CMMS debe ayudarnos a aprender y cambiar la estrategia.”

---

# PARTE IX — CÓMO SE INTEGRA EN UNA APLICACIÓN CMMS COMPLETA

## 22. Planes de mantenimiento

Esta pantalla representa el lugar donde terminarían las estrategias ya convertidas en planes publicables.

Durante esta fase del Functional Lab es una vista inicial, no una integración productiva completa.

El mensaje importante es que AMEF y RCM **no viven aislados**: su resultado debe acabar conectado al mantenimiento ejecutable.

---

## 23. Gobernanza

Aquí se concentran conceptos como:

- versiones;
- aprobaciones;
- findings;
- excepciones;
- solicitudes de cambio;
- reaperturas.

No es un añadido administrativo. Es lo que permite que el modelo siga siendo defendible con el paso del tiempo.

---

## 24. Configuración

Las reglas que una organización quiera parametrizar deberían vivir fuera de las pantallas de negocio siempre que sea posible.

Ejemplos:

- escalas de riesgo;
- bandas de criticidad;
- roles;
- catálogos;
- tipos de consecuencia;
- políticas;
- idiomas.

Por ejemplo, la matriz de riesgo del caso P-101 usa actualmente una escala 5×5 porque mantiene continuidad con los prototipos revisados, pero el componente está preparado para recibir otras configuraciones si la organización adopta otro modelo.

### Mensaje para la reunión

> “Queremos distinguir entre la lógica estable del producto y las reglas que cada organización puede necesitar configurar.”

---

# PARTE X — QUÉ HACE EL SOFTWARE Y QUÉ NO DEBE HACER

## 25. Automatizaciones que sí tienen sentido

El software puede asumir tareas deterministas o repetitivas como:

- cargar información existente;
- ordenar evidencias;
- buscar y filtrar;
- calcular rutas y jerarquías;
- calcular S×O;
- calcular NPR;
- calcular comparaciones económicas;
- comprobar campos obligatorios;
- identificar condiciones especiales;
- generar recomendaciones basadas en reglas;
- reconstruir trazabilidad;
- detectar inconsistencias;
- calcular progreso;
- comparar datos reales con hipótesis.

## 26. Decisiones que no deben desaparecer detrás del software

Necesitan intervención humana, entre otras:

- confirmar el alcance del análisis;
- definir funciones;
- validar fallos funcionales;
- seleccionar el modo de fallo relevante;
- describir efectos;
- valorar S/O/D;
- confirmar consecuencias;
- aceptar o modificar recomendaciones RCM;
- definir tareas;
- justificar excepciones;
- aprobar versiones;
- decidir una reapertura o cambio de estrategia.

La aplicación puede ayudar mucho en estos puntos, pero debe dejar siempre visible la autoridad.

---

# PARTE XI — QUÉ DEBEMOS PEDIR AL EQUIPO DURANTE LA DEMOSTRACIÓN

## 27. La demostración también es una sesión de validación

No buscamos únicamente que la aplicación “guste”. Necesitamos comprobar si representa correctamente la forma en la que la organización quiere trabajar.

Durante la reunión conviene escuchar especialmente comentarios sobre:

### Activos

- ¿FLH representa correctamente cómo queremos navegar la planta?
- ¿Taxonomía está suficientemente separada de ubicación?
- ¿ADR refleja las relaciones que necesitamos conocer?
- ¿qué relaciones técnicas faltan?

### AMEF

- ¿las categorías de consecuencia son las adecuadas?
- ¿la escala S/O/D 1–5 es la que queremos conservar?
- ¿qué criterios deben justificar cada valor?
- ¿qué bandas de criticidad debemos utilizar realmente?
- ¿qué situaciones deberían sobreclasificarse automáticamente?

### RCM

- ¿qué reglas de decisión son corporativas?
- ¿qué evidencias exigimos para aceptar mantenimiento por condición?
- ¿cómo justificamos P–F?
- ¿qué políticas deben estar disponibles?
- ¿qué decisiones requieren aprobación adicional?

### Planes

- ¿qué datos necesita Planificación antes de aceptar una tarea?
- ¿qué recursos y condiciones son obligatorios?
- ¿cómo agrupamos tareas en planes?

### Gobernanza

- ¿quién revisa?
- ¿quién aprueba?
- ¿qué cambios obligan a crear una nueva versión?
- ¿qué evidencia debe conservarse?

Estas preguntas son más importantes que cualquier detalle de color o posición de un botón.

---

# PARTE XII — RECORRIDO RECOMENDADO PARA UNA REUNIÓN

## 28. Demostración de 45–60 minutos

No es necesario dedicar el mismo tiempo a todas las pantallas.

### 1. Apertura — 3 minutos

Explicar el objetivo:

> “Queremos comprobar si podemos convertir nuestro razonamiento de mantenimiento en un proceso estructurado, trazable y apoyado por software, sin sustituir el criterio técnico de las personas.”

### 2. Activo — 7 minutos

Recorrer rápidamente:

```text
FLH
→ Taxonomía
→ ADR
→ Ficha 360
```

Idea que debe quedar clara:

> **El activo tiene una única identidad, pero necesitamos distintas vistas para comprenderlo.**

### 3. Caso y journey — 5 minutos

Abrir Registro de análisis y Case Overview.

Mostrar las 28 etapas y explicar que el usuario trabaja en pantallas reales sin perder la metodología.

### 4. Funciones y modos de fallo — 8 minutos

Detenerse en:

- función;
- fallo funcional;
- modo de fallo;
- recomendación del sistema frente a selección humana.

Esta parte prepara al público para entender AMEF.

### 5. AMEF — 10 minutos

Es una de las paradas principales.

Mostrar:

- efectos;
- consecuencia;
- matriz 5×5;
- S=4, O=3, D=3;
- S×O=12;
- NPR=36;
- recomendación frente a decisión;
- control de avance.

### 6. RCM — 10 minutos

Mostrar el razonamiento:

```text
fallo evidente
→ degradación detectable
→ P–F
→ políticas válidas
→ recomendación
→ decisión humana
```

### 7. Del análisis al plan — 7 minutos

Recorrer:

```text
Economía
→ Tarea e intervalo
→ Paquete de plan
```

Idea principal:

> **La estrategia termina convertida en algo que mantenimiento puede ejecutar.**

### 8. Gobernanza y mejora — 5 minutos

Recorrer:

```text
Trazabilidad
→ Revisión y aprobación
→ Efectividad
```

Cerrar el círculo:

> **La decisión queda auditada y los datos reales vuelven al modelo.**

---

# PARTE XIII — CONCEPTOS QUE CONVIENE EXPLICAR SI APARECEN EN LA REUNIÓN

## 29. AMEF

Análisis de Modos y Efectos de Fallo.

Sirve para estudiar de forma estructurada cómo puede fallar un activo, qué ocurre cuando falla y qué importancia tiene ese fallo.

## 30. RCM

Mantenimiento Centrado en Fiabilidad.

Es una metodología para decidir qué política de mantenimiento resulta técnicamente adecuada para un modo de fallo y sus consecuencias.

No debe entenderse como un algoritmo automático que “genera un preventivo”.

## 31. NPR

Número de Prioridad de Riesgo.

En nuestro caso se calcula como:

```text
Severidad × Ocurrencia × Detección
```

Es una ayuda para priorizar, no una sustitución automática del análisis de consecuencias.

## 32. P–F

Intervalo entre el momento en que un fallo potencial puede detectarse y el momento en que se convierte en fallo funcional.

Ayuda a determinar si una tarea de monitorización puede detectar el deterioro con tiempo suficiente para intervenir.

## 33. FLH

Jerarquía utilizada para situar el objeto dentro de la estructura funcional o de localización de la planta.

## 34. ADR

Modelo de relaciones entre objetos que permite representar dependencias que no encajan necesariamente en una jerarquía padre-hijo física.

## 35. Gate / Control de avance

Punto de control que verifica si una etapa contiene la información y decisiones mínimas necesarias para formalizar el siguiente paso.

En la interfaz es preferible hablar de **Control de avance**, **Estado de la etapa** o **Requisitos para continuar**. `Gate` puede permanecer como término técnico interno.

---

# PARTE XIV — MENSAJE DE CIERRE

## 36. Qué debería llevarse cualquier asistente

Al terminar la demostración, incluso una persona que no conozca AMEF o RCM debería poder resumir la propuesta aproximadamente así:

> “El CMMS no empieza creando tareas. Primero entiende el activo y su contexto. Después define qué debe hacer, cómo puede fallar y qué consecuencias tendría. El software ayuda a calcular, ordenar información y recomendar opciones, pero las decisiones relevantes siguen siendo humanas y quedan trazadas. La estrategia elegida se convierte finalmente en un plan ejecutable y, cuando existe información real, se comprueba si ese plan está funcionando.”

Si conseguimos que ese mensaje quede claro, la demostración habrá cumplido su objetivo.

---

## 37. Principio que debe proteger el desarrollo

A medida que el Functional Lab evolucione, cualquier nueva pantalla o componente debería respetar esta regla:

```text
Dato existente
      ↓
Trabajo humano
      ↓
Cálculo / recomendación del sistema
      ↓
Decisión humana cuando corresponde
      ↓
Control de avance explicable
      ↓
Output estructurado y trazable
```

La interfaz puede cambiar. Los componentes pueden mejorar. El backend puede pasar de fixtures a Azure SQL u otra tecnología.

**Lo que no debería perderse es la claridad del razonamiento.**
