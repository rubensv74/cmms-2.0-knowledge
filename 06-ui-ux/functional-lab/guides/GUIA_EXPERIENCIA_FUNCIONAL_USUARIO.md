# CMMS 2.0 Functional Lab — Guía de experiencia funcional del usuario

**Estado:** guía canónica de experiencia v2  
**Fecha:** 2026-08-10  
**Caso de referencia:** P-101 · Bomba centrífuga de agua de refrigeración  
**Ámbito:** Activos + Estrategia de mantenimiento + Planes + Gobernanza

---

## 1. Para qué sirve esta guía

Esta guía explica **cómo debe experimentar un usuario el CMMS 2.0 Functional Lab y qué lógica de negocio hay detrás de cada pantalla**.

No es un manual técnico de Power Apps. Su objetivo es permitir que una persona que conoce mantenimiento industrial, pero no necesariamente el desarrollo de la aplicación, pueda entender:

1. qué problema de negocio resuelve cada pantalla;
2. qué conceptos de mantenimiento aparecen;
3. qué información ya debería existir en el CMMS;
4. qué información debe aportar una persona;
5. qué puede calcular o recomendar el software;
6. qué decisiones requieren autoridad humana;
7. qué condiciones impiden continuar;
8. qué resultado estructurado genera cada etapa;
9. cómo comprobar que la aplicación implementa correctamente el modelo funcional acordado.

La guía tiene tres usos principales:

- **aprendizaje:** entender AMEF, RCM y el proceso completo mediante el caso P-101;
- **validación funcional:** comprobar que la aplicación cumple los requisitos y no mezcla datos, cálculos, recomendaciones y decisiones;
- **presentación:** disponer de un hilo narrativo para explicar la aplicación durante una reunión.

> La aplicación no pretende decidir el mantenimiento por el usuario. Pretende organizar la información, hacer explícito el razonamiento, automatizar lo que sea determinista y dejar trazada la autoridad de cada decisión.

---

## 2. La idea central de la experiencia

El usuario no entra en un asistente de 28 páginas. Entra en una **aplicación CMMS real**, navega por objetos reconocibles y abre un caso de análisis de mantenimiento.

La secuencia conceptual es:

```text
ACTIVO
  ↓
CONTEXTO OPERACIONAL
  ↓
FUNCIONES
  ↓
FALLOS FUNCIONALES
  ↓
MODOS DE FALLO
  ↓
EFECTOS Y RIESGO (AMEF)
  ↓
DECISIÓN RCM
  ↓
ECONOMÍA
  ↓
TAREA + INTERVALO
  ↓
RECURSOS + PAQUETE DE PLAN
  ↓
TRAZABILIDAD + CALIDAD
  ↓
REVISIÓN + APROBACIÓN
  ↓
EFECTIVIDAD + MEJORA CONTINUA
```

Las 28 etapas del método siguen existiendo y permanecen visibles mediante el **Process Rail**, pero las pantallas se organizan por objetos y trabajos de negocio reconocibles.

---

## 3. Cómo distinguir persona y software

La aplicación utiliza cinco tipos de participación.

### 3.1. Información existente

Es información que debería proceder de otros módulos o fuentes: maestro de activos, jerarquías, históricos, documentación técnica, órdenes de trabajo, catálogos o configuración.

**Ejemplo:** código P-101, tipo de equipo, posición en FLH, fabricante, histórico de OT.

El usuario puede revisar esta información, pero un análisis AMEF/RCM no debería modificar silenciosamente el maestro de activos.

### 3.2. Input humano

Es información que requiere interpretación o conocimiento del negocio.

**Ejemplo:** describir el efecto operacional de un fallo, confirmar una función o valorar severidad.

### 3.3. Cálculo automático

El software obtiene un resultado aplicando una regla definida sin interpretación humana.

**Ejemplo:** calcular `NPR = Severidad × Ocurrencia × Detección`.

El cálculo debe mostrar de dónde salen los valores y qué regla se ha aplicado.

### 3.4. Recomendación del sistema

El software puede analizar datos o reglas y proponer una opción.

**Ejemplo:** recomendar el modo de fallo FM-03 o una política RCM.

Una recomendación **no es una decisión**. Deben conservarse ambas:

```text
recomendación del sistema
+ decisión humana
+ motivo si existe override
```

### 3.5. Decisión humana

Es una decisión cuya autoridad corresponde a una persona o rol.

**Ejemplo:** aceptar una estrategia RCM, aprobar una versión o confirmar una consecuencia.

La aplicación debe registrar quién decidió, cuándo y por qué cuando sea necesario.

### 3.6. Gate

Un gate comprueba si existen las condiciones mínimas para continuar.

Un gate no debe limitarse a deshabilitar un botón. Debe explicar:

- qué falta;
- por qué bloquea;
- quién puede resolverlo;
- qué output se producirá al superarlo.

---

## 4. Gramática visual esperada

La interfaz utiliza una semántica visual estable:

| Significado | Tratamiento esperado |
|---|---|
| Dato maestro / referencia | neutro / slate |
| Cálculo o información del sistema | azul / cyan |
| Decisión o autoridad humana | púrpura |
| Advertencia / excepción / override | ámbar / naranja |
| Error o bloqueo | rojo |
| Confirmado / aprobado / gate superado | verde |

Esta gramática es funcional. No es únicamente decorativa.

---

# PARTE I — INICIO Y CONTEXTO DEL ACTIVO

## 5. Pantalla 01 — Inicio

### Propósito

Dar al usuario una visión de entrada del trabajo disponible: casos activos, estado general y accesos principales.

No debe explicar qué es el prototipo. Debe comportarse como la portada de una aplicación de mantenimiento.

### Conceptos que aparecen

- caso de análisis;
- activo;
- progreso;
- estado del caso;
- trabajo pendiente;
- accesos a Activos y Estrategia.

### Inputs

**Existentes:** casos abiertos, activo asociado, fase actual, estado y propietario.

**Humanos:** normalmente ninguno para iniciar el recorrido.

### Qué hace automáticamente el software

- carga el contexto del usuario y del caso activo;
- calcula/representa el progreso;
- muestra accesos relevantes.

### Decisiones humanas

Elegir qué caso o módulo abrir.

### Output

Selección del objeto/caso que se va a consultar o trabajar.

### Qué debemos verificar

- no se presenta como una portada de demostración;
- P-101 aparece como un caso, no como el único caso posible;
- los módulos principales están claramente diferenciados;
- los estados mostrados son coherentes con el estado real del caso.

### Cómo explicarla en reunión

> “El laboratorio empieza ya con una lógica de producto: vemos trabajo y casos reales. P-101 es simplemente nuestro caso de ejemplo.”

---

## 6. Pantalla 02 — Árbol FLH

### Propósito

Mostrar **dónde vive físicamente y funcionalmente el activo P-101 dentro de la planta**.

FLH proporciona contexto de localización/estructura. Antes de decidir mantenimiento debemos saber exactamente qué objeto estamos analizando y dentro de qué sistema funciona.

### Conceptos

- jerarquía de planta;
- padre/hijo;
- nivel jerárquico;
- sistema / subsistema / equipo;
- ruta del activo;
- profundidad variable.

### Inputs

**Existentes:** jerarquía técnica, códigos, nombres, relaciones padre-hijo y niveles.

### Qué hace automáticamente el software

- representa el árbol;
- permite buscar, expandir y contraer;
- calcula la ruta/breadcrumb;
- resalta P-101.

### Decisiones humanas

No se decide mantenimiento aquí. El usuario selecciona el objeto que quiere consultar.

### Output

`TechnicalObject` + contexto `AssetHierarchyNode` seleccionado.

### Qué debemos verificar

- el árbol puede soportar jerarquías profundas sin depender de un número fijo de niveles;
- P-101 es el mismo objeto que aparecerá después en el análisis;
- el componente no codifica significados según nivel;
- búsqueda, selección y breadcrumb funcionan;
- la jerarquía es información maestra, no un dato editable dentro del AMEF.

### Cómo explicarla

> “Antes del AMEF necesitamos la foto de dónde está el activo. Esta misma identidad P-101 nos acompañará durante todo el análisis.”

---

## 7. Pantalla 03 — Taxonomía

### Propósito

Mostrar **qué es el activo**, independientemente de dónde esté instalado.

FLH responde “¿dónde está?”. Taxonomía responde “¿qué tipo de objeto es?”.

### Conceptos

- clasificación;
- familia de equipos;
- clase/subclase;
- esquema ISO 14224 o esquema corporativo;
- herencia de características.

### Inputs

**Existentes:** clasificación del activo, esquema, códigos y jerarquía taxonómica.

### Automatización

- navegación y búsqueda de clasificación;
- representación de la ruta taxonómica;
- asociación de P-101 con su clase.

### Decisión humana

En el análisis no se redefine la taxonomía. Una corrección de clasificación debería gestionarse como mantenimiento del dato maestro.

### Output

`AssetClassification` asociado al objeto técnico.

### Qué debemos verificar

- FLH y Taxonomía no se confunden;
- la misma P-101 mantiene una identidad única;
- la pantalla puede trabajar con distintos esquemas de clasificación;
- no se fuerza ISO 14224 como único esquema técnico si la organización usa extensiones corporativas.

### Cómo explicarla

> “Una cosa es dónde está instalada la bomba y otra qué clase de equipo es. Separar ambas visiones evita muchos problemas de datos.”

---

## 8. Pantalla 04 — Árbol ADR

### Propósito

Mostrar **con qué otros objetos está relacionada P-101 y qué dependencias técnicas existen**.

No toda relación relevante puede expresarse mediante un único árbol padre-hijo.

### Conceptos

- relación origen/destino;
- dependencia técnica;
- redundancia;
- equipos asociados;
- relación funcional;
- dirección de la relación.

### Inputs

**Existentes:** relaciones ADR y objetos técnicos relacionados.

### Automatización

- representar relaciones;
- navegar entre objetos;
- indicar tipo, dirección y criticidad si existe.

### Decisión humana

Consultar o seleccionar una relación. La creación/modificación de ADR pertenece al gobierno del maestro, no al AMEF.

### Output

Conjunto `ADRRelation` que da contexto al análisis.

### Qué debemos verificar

- ADR no se presenta como otra copia de FLH;
- relaciones múltiples pueden convivir;
- la dependencia con la bomba de reserva P-102 puede representarse sin modificar la jerarquía FLH.

### Cómo explicarla

> “El árbol FLH no explica todas las dependencias. ADR nos permite entender relaciones técnicas que después condicionan el análisis, como redundancias o equipos asociados.”

---

## 9. Pantalla 05 — Ficha 360 del activo

### Propósito

Concentrar la información esencial de P-101 y ofrecer acceso a sus análisis, planes y contexto técnico.

### Conceptos

- Technical Object;
- atributos principales;
- estado;
- documentación;
- análisis asociados;
- planes asociados.

### Inputs

**Existentes:** maestro del activo y referencias a otros módulos.

### Automatización

Consolidar y presentar información procedente de distintas entidades.

### Decisión humana

Elegir qué información consultar o qué análisis abrir.

### Output

Contexto de objeto técnico para el proceso seleccionado.

### Qué debemos verificar

- la ficha no duplica la base de datos;
- distingue información maestra de información derivada de análisis;
- los enlaces llevan siempre al mismo `TechnicalObjectId`.

---

# PARTE II — CASO DE ESTRATEGIA DE MANTENIMIENTO

## 10. Pantalla 06 — Registro de análisis

### Propósito

Permitir buscar, filtrar y abrir casos de análisis AMEF/RCM.

P-101 deja de ser “la aplicación” y pasa a ser una fila de `AnalysisCase`.

### Conceptos

- AnalysisCase;
- lifecycle status;
- versión;
- etapa actual;
- propietario;
- riesgo/estado.

### Inputs

**Existentes:** casos abiertos, cerrados, aprobados o reabiertos.

### Automatización

- búsqueda y filtros;
- cálculo/representación de progreso;
- estados derivados.

### Decisión humana

Elegir el caso que se va a abrir o, en un futuro, iniciar un nuevo análisis.

### Output

`AnalysisCaseId` activo.

### Qué debemos verificar

- soporta varios casos;
- muestra claramente Draft / InReview / Approved / Frozen / Reopened;
- no mezcla estado del caso con estado del activo.

---

## 11. Pantalla 07 — Resumen del caso / Case Overview

### Propósito

Dar una **visión integral del análisis P-101 y de las 28 etapas**.

Es la pantalla que permite no perder nunca la secuencia metodológica, aunque el usuario navegue por pantallas de negocio reales.

### Conceptos

- etapa actual;
- fases del journey;
- estado por etapa;
- responsable;
- progreso;
- bloqueos y advertencias.

### Inputs

**Existentes:** `AnalysisCase` + 28 `AnalysisStageExecution`.

### Automatización

- ordenar las etapas;
- representar estado;
- mostrar responsable y accesibilidad;
- navegar a la pantalla correspondiente.

### Decisión humana

Elegir una etapa accesible para consultar o continuar trabajo.

### Output

Etapa/pantalla seleccionada.

### Qué debemos verificar

- aparecen las 28 etapas;
- no se elimina ninguna para ahorrar pantallas;
- consultar una etapa futura no equivale a aprobarla;
- los gates siguen controlando el avance formal;
- H/C/R/G se pueden distinguir visualmente.

### Cómo explicarla

> “Aquí conservamos el recorrido completo de 28 etapas. El usuario puede entender dónde está, qué ha sido confirmado y quién debe actuar, pero luego trabaja en pantallas de negocio reales.”

---

# FASE 1 — COMPRENDER EL PROBLEMA

## 12. Pantalla 08 — Contexto del análisis · FL-01 a FL-03

### Propósito

Asegurar que antes de hablar de fallos sabemos **qué activo se analiza, dónde están sus límites, en qué condiciones trabaja y con qué evidencia contamos**.

### FL-01 — Activo y límites

**Humano:** confirma el objeto físico y la frontera del análisis.

**Software:** muestra información maestra disponible.

### FL-02 — Contexto operacional

**Humano:** describe demanda, modos de operación, redundancia y restricciones.

**Software:** presenta datos existentes y puede comprobar coherencias básicas.

### FL-03 — Preparación de datos

**Humano:** confirma que las fuentes son adecuadas y valora su confianza.

**Software:** cuenta/comprueba evidencias y evalúa condiciones del gate.

### Inputs principales

- TechnicalObject P-101;
- servicio;
- límites físicos;
- modos de operación;
- redundancia P-102;
- restricciones;
- ficha técnica;
- P&ID;
- histórico de OT;
- manual O&M;
- conocimiento de Operaciones.

### Outputs

- contexto del `AnalysisCase`;
- `Evidence` confirmada;
- preparación de datos;
- estado FL-01..03.

### Gate

No se debería pasar a funciones si el activo, límites o contexto no están suficientemente definidos o la evidencia es insuficiente.

### Qué debemos verificar

- el usuario entiende qué datos vienen del maestro y cuáles puede completar;
- las fuentes de evidencia son visibles;
- el gate explica exactamente qué falta;
- confirmar evidencia es una acción humana explícita.

### Cómo explicarla

> “La metodología no empieza inventando tareas preventivas. Empieza entendiendo el activo, su función en proceso y la calidad de la información disponible.”

---

## 13. Pantalla 09 — Funciones y fallos funcionales · FL-04 y FL-05

### Propósito

Definir **qué debe hacer P-101** antes de preguntar por qué puede fallar.

### FL-04 — Funciones

Una función debe expresar una prestación esperada y, cuando sea posible, un estándar medible.

Ejemplo conceptual:

> Transferir agua de refrigeración al caudal y presión requeridos.

**Decisión humana:** confirmar/redactar la función y su estándar.

### FL-05 — Fallos funcionales

Un fallo funcional expresa cómo puede incumplirse la función.

Ejemplos:

- pérdida total de la función;
- prestación parcial por debajo del estándar.

**Decisión humana:** definir fallos totales/parciales coherentes con la función.

### Automatización

El software puede ordenar, validar campos obligatorios y relacionar función ↔ fallo, pero no debe inventar la función final sin confirmación.

### Outputs

- `Function`;
- `FunctionalFailure`;
- relaciones entre ambos.

### Qué debemos verificar

- una función no se confunde con una tarea de mantenimiento;
- un fallo funcional no se confunde con una causa;
- el estándar de funcionamiento es visible cuando aplica;
- existe trazabilidad función → fallo funcional.

### Cómo explicarla

> “Primero definimos qué esperamos del activo. Solo después describimos cómo puede dejar de cumplirlo.”

---

## 14. Pantalla 10 — Modos de fallo · FL-06

### Propósito

Pasar de **qué función se pierde** a **qué mecanismo puede causar esa pérdida**.

### Conceptos

- modo de fallo;
- mecanismo causal;
- plausibilidad;
- evidencia histórica;
- inclusión/exclusión;
- recomendación del sistema.

### Inputs

- funciones y fallos funcionales confirmados;
- catálogo de modos candidatos;
- histórico/evidencia.

### Qué hace el sistema

Puede comparar evidencia y sugerir un modo relevante. En P-101 el laboratorio puede marcar FM-03 como recomendación.

### Decisión humana

La persona selecciona explícitamente el modo que se analizará.

Si elige otro modo distinto al recomendado, debe justificar el override.

### Output

`FailureModeSelection` con:

```text
SystemRecommended
HumanConfirmed
DecisionReason
```

### Gate

Debe existir una selección humana explícita y, en caso de override, un motivo.

### Qué debemos verificar

- FM-03 nunca aparece como “decisión automática”;
- recomendación y selección final permanecen almacenadas por separado;
- las exclusiones también quedan justificadas;
- cambiar una decisión no borra la recomendación original.

### Cómo explicarla

> “El sistema puede ayudarnos a focalizar el análisis, pero la selección del mecanismo causal sigue teniendo autoridad humana.”

---

# FASE 2 — EVALUAR EL RIESGO · AMEF

## 15. Pantalla 11 — AMEF · Efectos y riesgo · FL-07 a FL-11

### Propósito

Entender **qué ocurre cuando se produce el modo de fallo**, cuál es su consecuencia y qué prioridad/riesgo tiene antes de entrar en RCM.

Esta pantalla debe dejar especialmente clara la diferencia entre **valoración humana, cálculo del sistema, recomendación y decisión**.

### FL-07 — Efectos del modo de fallo

El usuario documenta:

- efecto local;
- efecto en el sistema;
- efecto operacional.

**Decisión/input humano.** El software puede ayudar a estructurar, pero el contenido necesita conocimiento técnico.

**Output:** `FailureEffect`.

### FL-08 — Clasificación de consecuencias

El sistema puede recomendar una clase de consecuencia a partir de los efectos documentados.

**Sistema:** recomendación.

**Humano:** confirma o modifica la clasificación.

**Output:** `ConsequenceClass` confirmado + `HumanDecision`.

### FL-09 — Severidad, Ocurrencia y Detección

Los valores S/O/D necesitan criterio y evidencia.

**Humano:** selecciona/valora Severidad, Ocurrencia y Detección.

**Software:** calcula los indicadores derivados.

La interfaz separa dos representaciones:

```text
Severidad × Ocurrencia
        ↓
Matriz visual de riesgo
        ↓
Banda de criticidad
```

Y:

```text
Severidad × Ocurrencia × Detección
        ↓
NPR calculado automáticamente
```

La matriz y el NPR están relacionados, pero **no son el mismo indicador**.

#### Matriz de riesgo

`cmp_FL_RiskMatrixPro` permite seleccionar S y O y muestra la posición resultante.

Los umbrales actuales del laboratorio son demostrativos y deben considerarse configuración pendiente de validación corporativa.

#### NPR

El software calcula:

```text
NPR = S × O × D
```

El usuario no escribe el NPR manualmente.

### FL-10 — Reglas de sobreclasificación

Algunas condiciones críticas pueden justificar una prioridad superior a la sugerida por el producto numérico.

**Sistema:** puede detectar la condición y recomendar sobreclasificación.

**Humano:** confirma el criterio cuando la autoridad no esté automatizada explícitamente.

Debe conservarse el motivo.

### FL-11 — Controles y excepciones

Se revisan controles existentes, calidad/confianza y excepciones.

**Sistema:** comprueba consistencia y gate.

**Humano:** confirma información, acepta/resuelve excepciones según autoridad.

### Outputs de la pantalla

- `FailureEffect`;
- `RiskAssessment`;
- `SystemRecommendation`;
- `HumanDecision`;
- estado FL-07..FL-11.

### Gate AMEF

Debe explicar si el caso está preparado para RCM o qué información debe corregirse.

### Qué debemos verificar

- efectos local/sistema/operacional están separados;
- S/O/D se identifican como valoración humana;
- NPR se identifica inequívocamente como cálculo automático;
- la matriz S×O no se presenta como NPR;
- cualquier recomendación de consecuencia se distingue de la confirmación humana;
- los umbrales de criticidad no se presentan como estándar corporativo aprobado;
- un override conserva recomendación, resultado final y motivo;
- el gate AMEF explica el bloqueo.

### Cómo explicarla

> “AMEF no es solo calcular un número. Documentamos efectos, valoramos el riesgo con criterio técnico, el sistema calcula y puede recomendar, pero la consecuencia y cualquier excepción relevante quedan bajo decisión trazable.”

---

# FASE 3 — TOMAR LA DECISIÓN RCM

## 16. Pantalla 12 — Decisión RCM · FL-12 a FL-16

### Propósito

Determinar **qué política de mantenimiento es técnicamente adecuada para el modo de fallo**.

RCM no es un algoritmo que sustituye al experto. Es un proceso de decisión estructurado en el que el software puede calcular, comprobar condiciones y recomendar.

### FL-12 — ¿El fallo es evidente?

**Humano:** confirma si el fallo es observable durante la operación normal.

Esto selecciona la rama adecuada del razonamiento.

### FL-13 — ¿Existe degradación detectable?

**Sistema:** puede mostrar evidencia y recomendar si existe un indicador potencial.

**Humano:** confirma si realmente existe un fallo potencial observable y utilizable.

### FL-14 — Ventana P–F

Se compara el tiempo entre detectar una condición potencial y llegar al fallo funcional.

**Humano:** aporta/valida evidencia y supuestos.

**Software:** calcula ventanas y comprueba viabilidad.

**Sistema:** puede recomendar si existe margen suficiente para intervenir.

### FL-15 — Políticas técnicamente válidas

El software puede descartar opciones incompatibles con las condiciones conocidas y comparar alternativas.

La validez técnica viene **antes** que la economía.

### FL-16 — Decisión RCM explicable

**Sistema:** recomienda una estrategia y explica por qué.

**Humano:** acepta, modifica o selecciona una alternativa y deja trazada la autoridad.

### Outputs

- `RCMAnalysis`;
- `SystemRecommendation`;
- `HumanDecision`;
- `MaintenanceStrategy` candidata.

### Qué debemos verificar

- la rama RCM es comprensible;
- P–F muestra inputs y regla;
- no se elige una estrategia solo porque sea barata;
- las alternativas descartadas conservan motivo;
- la decisión final tiene rol/autoridad humana;
- un override exige justificación.

### Cómo explicarla

> “Aquí la aplicación no pregunta directamente ‘¿qué mantenimiento hacemos?’. Primero demuestra qué políticas son técnicamente válidas y después presenta una recomendación que debe quedar confirmada y explicada.”

---

# FASE 4 — CONVERTIR LA DECISIÓN EN UN PLAN

## 17. Pantalla 13 — Evaluación económica · FL-17

### Propósito

Comparar económicamente **solo las alternativas que ya han sido consideradas técnicamente válidas**.

### Inputs

- estrategias técnicamente válidas;
- costes esperados;
- inversión;
- supuestos;
- posible valor de riesgo evitado.

### Automatización

- calcular costes esperados;
- comparar escenarios;
- ordenar alternativas según reglas definidas.

### Decisión humana

Confirmar supuestos y seleccionar/ratificar la alternativa cuando la economía forme parte de la decisión.

### Outputs

`EconomicAssessment` por alternativa.

### Qué debemos verificar

- la economía no sustituye el filtro técnico de RCM;
- todos los supuestos son visibles;
- ranking del sistema y selección humana se distinguen;
- cambiar un coste recalcula resultados sin alterar silenciosamente decisiones aprobadas.

---

## 18. Pantalla 14 — Tarea e intervalo · FL-18 y FL-19

### Propósito

Convertir una estrategia conceptual en **una tarea que realmente pueda ejecutarse y una frecuencia que pueda defenderse técnicamente**.

### FL-18 — Tarea ejecutable

**Humano:** define:

- qué se hace;
- técnica;
- criterio de aceptación;
- acción si el criterio falla;
- tipo de tarea.

### FL-19 — Intervalo

**Humano:** aporta/valida contexto y supuestos.

**Software:** calcula/recomienda un intervalo cuando existe regla, P–F o factor de planificación.

**Humano:** confirma el intervalo final.

### Outputs

- `MaintenanceTask`;
- `IntervalJustification`.

### Gate

El intervalo debe ser defendible y compatible con la estrategia seleccionada.

### Qué debemos verificar

- una tarea contiene criterio de aceptación y reacción, no solo una descripción genérica;
- la frecuencia tiene justificación;
- recomendación calculada e intervalo confirmado son valores separados;
- el cambio de intervalo conserva motivo.

### Cómo explicarla

> “La salida del RCM todavía no es un plan de mantenimiento. Aquí la convertimos en una instrucción ejecutable con un intervalo justificable.”

---

## 19. Pantalla 15 — Paquete de plan · FL-20 a FL-22

### Propósito

Completar toda la información necesaria para que la tarea pueda convertirse en un paquete mantenible y gobernado.

### FL-20 — Recursos y condiciones

**Humano:** define disciplina, puesto, herramientas, repuestos, permisos, necesidades de parada y condiciones de ejecución.

### FL-21 — Alcance y agrupación

**Sistema:** puede proponer agrupaciones coherentes.

**Humano:** confirma alcance físico, objetos técnicos y agrupación.

### FL-22 — Gate del plan

**Sistema:** comprueba que el paquete está completo.

No existe una decisión metodológica nueva: existe una validación de preparación.

### Outputs

- `ResourceRequirement`;
- `MaintenancePlanPackage`;
- estado del gate del plan.

### Qué debemos verificar

- ningún recurso obligatorio queda implícito;
- parada/permisos son visibles;
- el alcance físico está relacionado con objetos técnicos reales;
- el gate lista exactamente los campos o condiciones pendientes.

---

# FASE 5 — GOBERNAR Y MEJORAR

## 20. Pantalla 16 — Trazabilidad y calidad · FL-23 y FL-24

### Propósito

Demostrar que **cada tarea del plan puede justificarse hacia atrás hasta la función, fallo, modo, riesgo y decisión que la originaron**.

### FL-23 — Trazabilidad

**Software:** reconstruye enlaces y detecta referencias huérfanas.

**Humano:** revisa y corrige cuando la relación no refleja el razonamiento real.

### FL-24 — Control de calidad

**Software:** ejecuta comprobaciones metodológicas y de datos.

**Sistema:** puede recomendar correcciones.

**Humano:** resuelve, acepta o justifica findings según autoridad.

### Outputs

- `TraceLink`;
- `QualityFinding`;
- gate de calidad.

### Qué debemos verificar

- desde una tarea se puede reconstruir por qué existe;
- ningún warning desaparece solo por continuar;
- findings y su resolución quedan auditados;
- errores bloqueantes se diferencian de advertencias aceptables.

### Cómo explicarla

> “Una de las ambiciones del modelo es que dentro de años podamos preguntar por qué existe una tarea y reconstruir todo el razonamiento que la originó.”

---

## 21. Pantalla 17 — Revisión y aprobación · FL-25 y FL-26

### Propósito

Resolver las posiciones de los distintos roles y convertir una propuesta revisada en una **versión aprobada e inmutable**.

### FL-25 — Revisión multidisciplinar

Participan, según el caso:

- Ingeniería de Fiabilidad;
- Mantenimiento / Planificación;
- Operaciones;
- Asset Owner / Aprobador.

**Humano:** cada rol registra posición, comentario o discrepancia.

El sistema conserva la evidencia y estado de cada revisión.

### FL-26 — Aprobación y snapshot

**Humano:** las autoridades requeridas aprueban/rechazan.

**Software:** comprueba que las aprobaciones necesarias existen y genera un snapshot/versionado inmutable.

### Outputs

- `Review`;
- `Approval`;
- `VersionSnapshot`.

### Gate

No se congela la versión hasta completar las aprobaciones requeridas.

### Qué debemos verificar

- revisar y aprobar son acciones distintas;
- las discrepancias no se borran;
- queda registrado quién aprobó y cuándo;
- una versión congelada no se edita silenciosamente;
- cualquier cambio posterior abre una nueva revisión/version.

---

## 22. Pantalla 18 — Efectividad y mejora · FL-27 y FL-28

### Propósito

Cerrar el ciclo: comprobar si las hipótesis del análisis se cumplen cuando el plan ya se ejecuta y existen datos reales.

### FL-27 — Contrastar con datos reales

**Software:** compara hipótesis con valores observados: fallos, costes, intervalos, P–F, cumplimiento u otros KPI.

**Sistema:** identifica desviaciones y puede recomendar revisión.

**Humano:** interpreta si la desviación es relevante.

### FL-28 — Mejora continua

**Sistema:** puede recomendar mantener, ajustar o reabrir.

**Humano:** decide si:

- se mantiene la versión;
- se ajusta un parámetro;
- se abre un `ChangeRequest`;
- se reabre el análisis.

### Outputs

- `EffectivenessMeasurement`;
- `ChangeRequest`;
- nuevos `AuditEvent`;
- posible transición del caso a `Reopened`.

### Qué debemos verificar

- la aprobación no se considera el final del ciclo;
- los datos reales pueden cuestionar las hipótesis iniciales;
- una recomendación de cambio no modifica automáticamente una versión congelada;
- reapertura y cambio quedan trazados.

### Cómo explicarla

> “RCM no termina al publicar el plan. La última fase comprueba si aquello que supusimos funciona realmente y permite reabrir el análisis de forma controlada.”

---

# PARTE III — MÓDULOS DE PRODUCTO

## 23. Pantalla 19 — Planes de mantenimiento

### Propósito

Mostrar los planes derivados de análisis aprobados y su estado de publicación/integración.

En la v2 actual es un **preview funcional**, no una integración productiva terminada.

### Conceptos

- plan;
- paquete;
- versión;
- estado;
- procedencia del análisis.

### Inputs

`MaintenancePlanPackage` y versiones aprobadas.

### Automatización

Agrupar, filtrar y relacionar plan ↔ análisis de origen.

### Decisión humana

En la futura versión productiva podrían existir acciones de publicación o sincronización con el CMMS, pero no deben simularse como reales mientras no exista la integración.

### Qué debemos verificar

- nunca se presenta una integración ficticia como operativa;
- se puede identificar de qué análisis/versión procede cada plan.

---

## 24. Pantalla 20 — Gobernanza

### Propósito

Ofrecer una visión transversal de versiones, aprobaciones, findings, revisiones y cambios.

### Conceptos

- versión;
- aprobación;
- audit event;
- finding;
- change request;
- estado del caso.

### Automatización

Consolidar el historial y detectar elementos pendientes.

### Decisiones humanas

Resolver findings, aprobar cuando corresponda y gestionar solicitudes de cambio según rol.

### Output

Gobierno y trazabilidad transversal de los objetos del análisis.

### Qué debemos verificar

- no duplica la lógica de las pantallas de análisis;
- permite reconstruir historia y autoridad;
- no se pueden borrar decisiones previas para “limpiar” el histórico.

---

## 25. Pantalla 21 — Configuración

### Propósito

Representar dónde vivirán reglas y catálogos gobernados que no deben estar codificados dentro de cada pantalla.

### Conceptos

- escalas;
- umbrales;
- roles;
- catálogos;
- parámetros;
- localización/idioma;
- reglas configurables.

### Ejemplos

- bandas de matriz de riesgo;
- escalas S/O/D;
- roles de aprobación;
- catálogos de modos;
- opciones de estrategia;
- preferencias de interfaz.

### Automatización

La aplicación consume esta configuración.

### Decisión humana

Administradores autorizados mantienen los parámetros. Un usuario de análisis no debería modificar una regla corporativa para conseguir que su caso pase un gate.

### Qué debemos verificar

- los valores demostrativos del Functional Lab se identifican como tales;
- configuración y datos transaccionales están separados;
- una modificación futura de reglas puede versionarse y auditarse.

---

# PARTE IV — MATRIZ COMPLETA PERSONA VS SISTEMA

## 26. Resumen de las 28 etapas

La siguiente tabla debe utilizarse como checklist durante reuniones. **Es una hipótesis funcional `to_validate` donde las reglas corporativas aún no hayan sido aprobadas.**

| Etapa | Humano | Cálculo sistema | Recomendación sistema | Gate | Resultado |
|---|:---:|:---:|:---:|:---:|---|
| FL-01 Activo y límites | ✓ | | | | Alcance confirmado |
| FL-02 Contexto operacional | ✓ | | | | Contexto documentado |
| FL-03 Preparación de datos | ✓ | ✓ | | ✓ | Evidencia/confianza |
| FL-04 Funciones | ✓ | | | | Funciones |
| FL-05 Fallos funcionales | ✓ | | | | Fallos funcionales |
| FL-06 Modos relevantes | ✓ | | ✓ | ✓ | Modo seleccionado |
| FL-07 Efectos | ✓ | | | | FailureEffect |
| FL-08 Consecuencias | ✓ | | ✓ | | Consecuencia confirmada |
| FL-09 S/O/D | ✓ | ✓ | | | Matriz/NPR |
| FL-10 Sobreclasificación | ✓ | ✓ | ✓ | | Prioridad ajustada |
| FL-11 Controles/excepciones | ✓ | ✓ | | ✓ | AMEF preparado/bloqueado |
| FL-12 Fallo evidente | ✓ | | | | Rama RCM |
| FL-13 Degradación detectable | ✓ | | ✓ | | Evidencia potencial |
| FL-14 Ventana P–F | ✓ | ✓ | ✓ | ✓ | Viabilidad detección/intervención |
| FL-15 Políticas válidas | ✓ | ✓ | ✓ | | Alternativas viables |
| FL-16 Decisión RCM | ✓ | | ✓ | | Estrategia confirmada |
| FL-17 Coste esperado | ✓ | ✓ | ✓ | | Comparación económica |
| FL-18 Tarea ejecutable | ✓ | | | | MaintenanceTask |
| FL-19 Intervalo | ✓ | ✓ | ✓ | ✓ | Intervalo confirmado |
| FL-20 Recursos | ✓ | | | | ResourceRequirement |
| FL-21 Alcance/paquete | ✓ | | ✓ | ✓ | MaintenancePlanPackage |
| FL-22 Gate del plan | | ✓ | | ✓ | Plan preparado/bloqueado |
| FL-23 Trazabilidad | ✓ | ✓ | | ✓ | TraceLink completo |
| FL-24 Calidad | ✓ | ✓ | ✓ | ✓ | Findings resueltos/bloqueados |
| FL-25 Revisión | ✓ | | | | Review multidisciplinar |
| FL-26 Aprobación/snapshot | ✓ | ✓ | | ✓ | Versión inmutable |
| FL-27 Datos reales | ✓ | ✓ | ✓ | | Desviaciones detectadas |
| FL-28 Mejora continua | ✓ | ✓ | ✓ | | Mantener/ajustar/reabrir |

---

# PARTE V — CHECKLIST GLOBAL DE REQUISITOS

## 27. Requisitos que toda pantalla de análisis debe respetar

### Contexto e identidad

- [ ] El usuario sabe siempre qué `AnalysisCase` está abierto.
- [ ] El usuario sabe qué activo está analizando.
- [ ] El Process Rail conserva las 28 etapas y la etapa actual.
- [ ] El responsable actual es visible.

### Datos

- [ ] Los datos maestros se distinguen de los datos editables del análisis.
- [ ] Cada dato editable tiene un objeto conceptual donde persistirse.
- [ ] La etapa siguiente consume outputs estructurados, no texto visual de la pantalla anterior.

### Persona vs software

- [ ] Los cálculos automáticos están identificados como cálculos.
- [ ] Sus inputs y regla pueden explicarse.
- [ ] Una recomendación del sistema nunca se presenta como una decisión confirmada.
- [ ] La decisión humana registra rol/autoridad.
- [ ] Un override conserva recomendación original, decisión final y motivo.

### Gates

- [ ] El gate muestra estado.
- [ ] Explica qué condición falla.
- [ ] Indica qué acción es necesaria.
- [ ] Identifica el rol responsable.
- [ ] Explica qué output se genera cuando se supera.

### Trazabilidad

- [ ] Se conserva el razonamiento que origina una tarea.
- [ ] Las revisiones no eliminan decisiones anteriores.
- [ ] Las versiones aprobadas son inmutables.
- [ ] Los cambios posteriores generan nueva revisión o Change Request.

### Honestidad del Functional Lab

- [ ] Los datos ficticios se reconocen como datos de ejemplo.
- [ ] Las escalas/umbrales no aprobados se identifican como demostrativos.
- [ ] No se simula como real una integración Azure SQL/CMMS que todavía no exista.
- [ ] Una funcionalidad `preview` se diferencia de una capacidad ya validada.

---

# PARTE VI — RECORRIDO RECOMENDADO PARA LA REUNIÓN

## 28. Guion de demostración

No es necesario presentar las 21 pantallas con el mismo detalle. Un recorrido de alto valor puede seguir esta secuencia.

### 1. Inicio — 1 minuto

Mensaje:

> “Lo que estamos viendo ya no es un conjunto de prototipos aislados. Es una propuesta de aplicación CMMS navegable construida alrededor de objetos y procesos reales.”

Mostrar módulos principales.

### 2. FLH → Taxonomía → ADR — 3 minutos

Mensaje:

> “Antes del análisis queremos tener una visión completa de P-101: dónde está, qué es y con qué objetos se relaciona.”

No entrar en detalle de los 11 niveles. Mostrar que el componente está preparado para profundidad variable.

### 3. Registro → Case Overview — 2 minutos

Mensaje:

> “P-101 es un AnalysisCase. El Process Rail mantiene visibles las 28 etapas sin convertir toda la aplicación en un wizard.”

Mostrar estado confirmado FL-01..06 y etapa actual.

### 4. Contexto → Funciones → Modos de fallo — 4 minutos

Mensaje:

> “El proceso no empieza definiendo tareas. Empieza entendiendo el activo, qué debe hacer, cómo puede dejar de cumplirlo y qué mecanismos causales son relevantes.”

En Failure Modes enfatizar recomendación del sistema vs selección humana.

### 5. AMEF + Matriz de riesgo — 5 minutos

Esta es una de las pantallas clave.

Explicar:

- efectos local / sistema / operacional;
- recomendación de consecuencia vs confirmación humana;
- selección humana S/O/D;
- matriz S×O;
- NPR automático S×O×D;
- sobreclasificación/excepciones;
- gate AMEF.

Mensaje:

> “La aplicación automatiza el cálculo, no la responsabilidad. Podemos ver exactamente qué ha introducido la persona, qué ha calculado el software y qué sigue necesitando confirmación.”

### 6. RCM — 4 minutos

Mensaje:

> “RCM guía el razonamiento: evidencia del fallo, degradación detectable, P–F, políticas técnicamente válidas y finalmente una estrategia explicable.”

Enfatizar que la economía todavía no ha intervenido.

### 7. Economía → Tarea → Plan — 4 minutos

Mensaje:

> “Solo después de demostrar qué alternativas son técnicamente válidas comparamos economía y convertimos la estrategia en una tarea ejecutable, con intervalo, recursos y alcance.”

### 8. Trazabilidad → Aprobación → Efectividad — 4 minutos

Mensaje:

> “La salida no es solo un plan. Conservamos por qué existe, quién lo revisó, qué versión fue aprobada y, posteriormente, si los datos reales confirman las hipótesis.”

### 9. Cierre — 1 minuto

Mensaje sugerido:

> “El objetivo del Functional Lab no es cerrar hoy todas las reglas del futuro CMMS. Es hacer el modelo suficientemente tangible para que podamos validar juntos el proceso, detectar qué decisiones corresponden a negocio y entregar posteriormente a IT una especificación funcional mucho menos ambigua.”

---

# PARTE VII — PREGUNTAS QUE DEBEMOS HACER EN LAS REUNIONES

## 29. Preguntas de validación funcional

Para cualquier etapa donde exista duda, preguntar:

1. ¿Este dato ya existe en algún sistema o debe introducirlo el usuario?
2. ¿Quién es responsable de que sea correcto?
3. ¿El software puede calcularlo de manera determinista?
4. ¿El software puede recomendarlo pero necesita confirmación?
5. ¿Qué rol tiene autoridad para decidir?
6. ¿Qué evidencia debe quedar guardada?
7. ¿Qué condición debería bloquear realmente el avance?
8. ¿Qué ocurre si una persona contradice la recomendación?
9. ¿Qué objeto/dato debe recibir la siguiente etapa?
10. ¿Esta regla es corporativa y aprobada o solo una hipótesis del Functional Lab?

Estas preguntas convierten la demostración de la app en una sesión de análisis funcional productiva.

---

## 30. Estado actual de implementación

A fecha de esta guía:

- arquitectura v2: generada;
- 21 pantallas canónicas: generadas;
- 7 componentes Foundation: generados;
- `Sidebar` y `PageHeader`: ya tienen evidencia `INSTANCE_SAFE` previa;
- `TreePro`: motor profundo cargado, QA visual final pendiente;
- `ProcessRailPro`, `DecisionPanelPro`, `GatePanelPro`, `RiskMatrixPro`: `PASS_STATIC`, pendientes de validación integrada en Studio;
- nueva arquitectura v2: `PASS_STATIC`;
- Power Apps Studio: sigue siendo la autoridad para `INSTANCE_SAFE` y `VISUAL_QA`.

Por tanto, esta guía describe el **contrato funcional que queremos validar** y debe utilizarse junto con los smoke tests de la arquitectura v2.

---

## 31. Fuentes canónicas relacionadas

- `02-functional/process-model/functional-journey.md`
- `02-functional/process-model/human-system-decisions.md`
- `06-ui-ux/functional-lab/screen-map.md`
- `06-ui-ux/functional-lab/domain-contracts.md`
- `06-ui-ux/functional-lab/V2_STATUS.md`
- `06-ui-ux/functional-lab/design-system-v2.md`
- `06-ui-ux/functional-lab/power-apps/V2_INSTALLATION.md`

La guía no sustituye estos documentos. Los conecta desde el punto de vista de la experiencia del usuario y de la explicación funcional del proceso.
