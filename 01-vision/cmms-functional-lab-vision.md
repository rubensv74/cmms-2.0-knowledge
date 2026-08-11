# CMMS 2.0 Functional Lab — Visión

**Versión conceptual:** v2 — library-first

## 1. Propósito

CMMS 2.0 Functional Lab es una aplicación de validación funcional destinada a convertir el modelo conceptual de CMMS 2.0 en una experiencia ejecutable y discutible durante las reuniones de trabajo.

Su objetivo principal no es anticipar la solución técnica final, sino hacer visible el razonamiento del negocio paso a paso y comprobar que el conocimiento de ingeniería puede reutilizarse, aplicarse a activos concretos y contrastarse después con resultados reales.

## 2. Problema que resuelve

Los prototipos HTML permitieron explicar AMEF y RCM mediante un caso P-101, pero un caso centrado en un único activo no demuestra la escalabilidad necesaria para un CMMS industrial.

El Functional Lab debe permitir responder, entre otras, estas preguntas:

- qué conocimiento pertenece a una biblioteca reusable y qué pertenece a un activo;
- cuándo debe crearse una nueva revisión y cuándo basta con una variante contextual;
- qué información debe existir antes de cada paso;
- quién debe introducirla o validarla;
- qué puede calcular el sistema;
- qué puede recomendar automáticamente;
- qué decisión debe asumir una persona;
- qué condiciones impiden avanzar o publicar;
- qué salida estructurada consume la siguiente capa;
- cómo se conserva trazabilidad desde ingeniería hasta resultados;
- qué pantallas necesita realmente el producto.

El Functional Lab convierte esas preguntas en interacción.

## 3. Modelo funcional rector

La primera versión seguirá esta jerarquía:

```text
Engineering Library
→ Asset Application
→ Execution Plan
→ Results & Learning
```

### Engineering Library

Contiene conocimiento reusable y versionado:

- `FmeaDefinition`;
- `FmeaRevision`;
- funciones, fallos, modos, causas y efectos;
- consecuencias y evaluación RCM;
- tareas de mantenimiento o decisiones explícitas sin tarea;
- procedimientos y formatos opcionales;
- economía y costes estimados;
- revisión, aprobación y publicación.

### Asset Application

Aplica una revisión publicada a un activo/contexto concreto mediante `FmeaAssetApplication`.

Aquí aparecen:

- activo;
- contexto operacional;
- criticidad del activo;
- aplicabilidad;
- perfiles y variantes;
- overrides contextualizados.

### Execution Plan

Convierte tareas aplicables en trabajo contextualizado sin perder la identidad de la tarea reusable de origen.

### Results & Learning

Registra resultados, hallazgos y costes reales y permite decidir si debe ajustarse la aplicación/plan o reabrirse la ingeniería mediante una nueva revisión.

## 4. Usuarios del laboratorio

El laboratorio está pensado para sesiones de revisión con perfiles como:

- Ingeniería de Fiabilidad;
- Mantenimiento;
- Operaciones;
- HSE;
- responsables de activos;
- analistas funcionales;
- representantes de IT cuando sea necesario revisar requisitos.

Los roles de la aplicación productiva se definirán posteriormente.

## 5. Resultado esperado

Al recorrer un caso, el grupo debe poder identificar y validar:

1. datos necesarios y capa propietaria;
2. entidades y relaciones conceptuales;
3. reglas de negocio;
4. cálculos automáticos;
5. recomendaciones del sistema;
6. decisiones humanas;
7. gates;
8. outputs;
9. responsabilidades;
10. necesidades de trazabilidad;
11. pantallas o workspaces necesarios;
12. puntos que deben quedar abiertos para validación o IT.

## 6. Caso de referencia inicial

P-101 seguirá siendo el caso didáctico inicial, pero cambia su papel.

Ya no representa “el AMEF de P-101”. El caso demuestra:

```text
Biblioteca reusable de bomba centrífuga
FMEA-CWPUMP-001 / Rev 1
        ↓
aplicación sobre P-101
        ↓
Execution Plan de P-101
        ↓
resultados y revisión de efectividad
```

Esto permite que un segundo activo equivalente pueda reutilizar la misma `FmeaRevision` y tomar decisiones de aplicación diferentes sin duplicar funciones, fallos y modos.

Los valores son ilustrativos y no constituyen una instrucción de mantenimiento aprobada.

## 7. Principios del producto

### 7.1. Library-first

El activo consume conocimiento de ingeniería; no es el contenedor de ese conocimiento.

### 7.2. El ejemplo precede a la teoría

La experiencia seguirá siendo pedagógica. El usuario verá cómo una biblioteca reusable termina produciendo trabajo concreto en P-101.

### 7.3. Una decisión funcional debe ser explicable

La aplicación debe mostrar por qué solicita un dato, qué regla/version utiliza, qué recomienda y qué decisión queda registrada.

### 7.4. Sistema y persona no son intercambiables

La UI distinguirá claramente:

- información existente;
- input humano;
- cálculo;
- recomendación;
- decisión humana;
- override;
- gate;
- output.

### 7.5. Riesgo AMEF y criticidad del activo son conceptos independientes

El riesgo de un modo se evalúa dentro del análisis AMEF utilizando una matriz/version identificada.

La criticidad del activo se recibe o valida cuando la biblioteca se aplica a un activo.

Ninguno sustituye automáticamente al otro.

### 7.6. Las revisiones publicadas son inmutables

La evidencia real puede cuestionar una hipótesis, pero nunca sobrescribe silenciosamente la revisión publicada que originó el plan.

### 7.7. Una tarea no es un procedimiento

`MaintenanceTask`, `MaintenanceProcedure` e `InspectionFormat` son objetos separados. Una tarea puede utilizar opcionalmente un procedimiento y/o formato versionado.

### 7.8. La ausencia de tarea es una decisión

Cuando RCM concluye que no existe una tarea programada válida, debe registrarse un `NoScheduledTaskDecision` explícito y justificado.

### 7.9. El laboratorio no define la arquitectura productiva

Power Apps es el vehículo elegido para validar la experiencia funcional. SQL, Dataverse, APIs, flows, integración y persistencia productiva quedan sujetos a decisiones posteriores.

### 7.10. La documentación nace del recorrido

Cada workspace validado debe producir o actualizar documentación funcional estructurada para IT.

### 7.11. La trazabilidad es parte del modelo

Debe poder reconstruirse, cuando aplique:

```text
FmeaDefinition
→ FmeaRevision
→ FailureMode
→ RcmAssessment
→ MaintenanceTask | NoScheduledTaskDecision
→ FmeaAssetApplication
→ ExecutionPlan
→ MaintenanceResult
→ EffectivenessReview
```

## 8. Frontera de la primera versión

La primera versión se centrará en Ingeniería de Fiabilidad y AMEF–RCM porque es el dominio actualmente más maduro.

Debe permitir validar el recorrido:

```text
Definición y revisión reusable
→ funciones / fallos / modos / causas / efectos
→ consecuencias y riesgo AMEF
→ decisión RCM
→ tratamiento reusable
→ publicación de biblioteca
→ aplicación a activo y criticidad contextual
→ Execution Plan
→ resultados y coste real
→ mejora continua
```

No se implementarán inicialmente:

- órdenes de trabajo productivas;
- planificación productiva completa;
- integración con SAP, Maximo o Hexagon;
- persistencia corporativa definitiva;
- autenticación o permisos finales;
- optimización avanzada;
- automatizaciones consideradas todavía hipótesis;
- matrices, umbrales o autoridades no validadas corporativamente.

## 9. Métrica de éxito

El éxito no se medirá por número de pantallas ni por acabado visual.

Se medirá por la capacidad del grupo para:

- distinguir biblioteca de aplicación y ejecución;
- reutilizar una revisión sin clonar el análisis;
- explicar por qué una tarea existe y qué modos trata;
- mantener separadas criticidad y riesgo;
- detectar requisitos faltantes;
- detectar reglas ambiguas;
- descubrir responsabilidades mal asignadas;
- identificar automatismos incorrectos;
- eliminar pantallas innecesarias;
- reconocer información que debe heredarse de otros módulos;
- reconstruir el lineage desde ingeniería hasta resultados;
- señalar con claridad qué queda pendiente para validación o IT.
