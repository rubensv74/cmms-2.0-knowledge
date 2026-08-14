# CMMS 2.0 Functional Journey

**Versión funcional:** v1.1  
**Última revisión:** 2026-08-14  
**Fuente de revisión:** [`../../05-meetings/2026/2026-08-14_revision-modelo-conceptual-amef-rcm.md`](../../05-meetings/2026/2026-08-14_revision-modelo-conceptual-amef-rcm.md)

## 1. Propósito

Definir el recorrido funcional independiente de la interfaz. Este documento es la referencia para decidir qué procesos existen, qué responsabilidad tiene cada etapa y cómo se agrupan posteriormente en workspaces de Power Apps.

Regla:

> Una etapa funcional no equivale necesariamente a una pantalla.

## 2. Modelo de etapa

Cada etapa debe describirse mediante:

- `stageId`;
- fase funcional;
- pregunta de negocio;
- información disponible;
- inputs humanos;
- cálculos automáticos;
- recomendación del sistema;
- decisión humana;
- gate;
- outputs;
- actor responsable;
- evidencia / trazabilidad;
- estado de validación de reglas.

## 3. Fases y etapas canónicas v1.1

### Fase 1 — Comprender el problema

| ID | Etapa | Propósito |
|---|---|---|
| FL-01 | Definir el activo y sus límites | Establecer el objeto físico y la frontera del análisis. |
| FL-02 | Describir el contexto operacional | Definir demanda, modos, redundancia y restricciones. |
| FL-03 | Comprobar la preparación de datos | Confirmar evidencia y nivel de confianza. |
| FL-04 | Definir funciones con estándar | Expresar qué debe hacer el activo y cómo se mide el cumplimiento. |
| FL-05 | Identificar fallos funcionales | Definir cómo puede incumplirse total o parcialmente cada función. |
| FL-06 | Seleccionar modos de fallo relevantes | Seleccionar mecanismos causales plausibles y justificar exclusiones. |

### Fase 2 — Evaluar el riesgo

| ID | Etapa | Propósito |
|---|---|---|
| FL-07 | Describir efectos del modo de fallo | Separar efecto local, de sistema y operacional. |
| FL-08 | Clasificar las consecuencias | Determinar la naturaleza principal del impacto. |
| FL-09 | Aplicar el perfil de riesgo del proyecto | Valorar el riesgo utilizando las dimensiones, escalas, rangos y matriz configurados para el cliente/proyecto; el modelo no presupone una 5×5 fija. |
| FL-10 | Aplicar reglas de criticidad y sobreclasificación | Elevar o ajustar prioridad cuando existan condiciones críticas definidas por el perfil aplicable. |
| FL-11 | Revisar controles y excepciones | Confirmar si existe información suficiente para pasar a RCM. |

### Fase 3 — Tomar la decisión RCM

| ID | Etapa | Propósito |
|---|---|---|
| FL-12 | Confirmar si el fallo es evidente | Elegir la rama correcta del árbol RCM. |
| FL-13 | Demostrar degradación detectable | Confirmar si existe una condición de fallo potencial observable cuando la rama lo requiera. |
| FL-14 | Evaluar la ventana P–F | Verificar consistencia del intervalo P–F y tiempo suficiente para detectar y actuar. |
| FL-15 | Comparar políticas técnicamente válidas y efectivas | Aplicar criterios de factibilidad técnica y efectividad para descartar alternativas no aplicables o ineficaces. |
| FL-16 | Emitir la decisión RCM explicable | Consolidar la política resultante del árbol lógico, sus condiciones, evidencias y autoridad humana. No existe scoring RCM acumulado. |

### Fase 4 — Convertir la decisión en un plan

| ID | Etapa | Propósito |
|---|---|---|
| FL-17 | Comparar el coste esperado cuando aplique | Comparar alternativas técnicamente válidas desde el punto de vista económico sin sustituir los criterios de seguridad, ambiente o efectividad. |
| FL-18 | Diseñar una tarea ejecutable | Definir qué hacer, cómo, criterio de aceptación y reacción, registrando la base técnica utilizada: RCM, manual del fabricante, histórico y/o experiencia operacional. |
| FL-19 | Justificar el intervalo de la tarea | Relacionar frecuencia con P–F, recomendaciones del fabricante, experiencia, histórico y ventana de planificación según aplique. |
| FL-20 | Asignar recursos y condiciones de ejecución | Definir disciplina/especialidad, ejecutor, número de ejecutores, horas-hombre, herramientas, repuestos, permisos y necesidad de parada. |
| FL-21 | Construir alcance, aplicabilidad y variantes del plan | Formar el plan genérico, identificar activos candidatos mediante taxonomía/equivalencia, registrar la decisión humana de aplicabilidad y permitir overrides específicos por activo. |
| FL-22 | Superar el gate del plan | Confirmar que tareas, frecuencias, agrupaciones, recursos, aplicabilidad y excepciones forman un paquete coherente y preparado para gobernanza. |

### Fase 5 — Gobernar y mejorar

| ID | Etapa | Propósito |
|---|---|---|
| FL-23 | Reconstruir la trazabilidad integral | Verificar que puede justificarse la existencia de cada tarea desde activo, función, fallo, riesgo y decisión RCM. |
| FL-24 | Ejecutar el control de calidad | Resolver advertencias y errores metodológicos o de datos. |
| FL-25 | Resolver la revisión multidisciplinar | Conservar discrepancias y registrar la resolución. |
| FL-26 | Aprobar y congelar una versión | Registrar autoridades, crear una versión inmutable del plan y emitir un output preparado para el handoff operacional. |
| FL-27 | Comparar hipótesis con datos reales | Contrastar P–F, coste, fallos y comportamiento con datos procedentes de la ejecución real cuando estén disponibles. |
| FL-28 | Abrir la mejora continua | Decidir si mantener, ajustar o reabrir el análisis. |

## 4. Agrupación inicial en workspaces

La hipótesis de UI mantiene las 28 etapas en nueve workspaces.

| Workspace | Etapas | Objetivo |
|---|---|---|
| WS-01 Caso y contexto | FL-01 a FL-03 | Entender qué se analiza y con qué evidencia. |
| WS-02 Funciones y fallos | FL-04 a FL-06 | Definir funciones, fallos y modos relevantes. |
| WS-03 Efectos y riesgo | FL-07 a FL-11 | Aplicar el perfil de riesgo del proyecto, describir consecuencias y establecer prioridad. |
| WS-04 Decisión RCM | FL-12 a FL-16 | Recorrer el árbol lógico RCM y emitir una política defendible sin scoring. |
| WS-05 Economía y tarea | FL-17 a FL-19 | Convertir la política en una tarea con intervalo justificable. |
| WS-06 Recursos y alcance | FL-20 a FL-22 | Preparar recursos, agrupaciones, aplicabilidad y variantes por activo. |
| WS-07 Trazabilidad y calidad | FL-23 a FL-24 | Comprobar integridad antes de aprobación. |
| WS-08 Revisión y publicación | FL-25 a FL-26 | Resolver posiciones, congelar una versión y preparar el handoff operacional. |
| WS-09 Efectividad y mejora | FL-27 a FL-28 | Contrastar hipótesis y abrir nueva revisión si procede. |

Esta agrupación es una hipótesis de diseño del Functional Lab, no un requisito de la futura aplicación productiva.

## 5. Clasificación de responsabilidad

Cada elemento del journey utilizará una de estas categorías:

| Tipo | Significado |
|---|---|
| `existing_input` | Información que debería estar disponible desde otro proceso, módulo o fuente. |
| `user_input` | Dato que una persona introduce, corrige o completa. |
| `system_calculation` | Resultado determinista obtenido aplicando una fórmula o regla definida. |
| `system_recommendation` | Propuesta automática que debe ser revisada por una persona. |
| `human_decision` | Decisión que debe tener responsable humano y quedar trazada. |
| `gate` | Condición que debe cumplirse antes de continuar. |
| `output` | Resultado consumido por una etapa o módulo posterior. |

## 6. Principios de avance

1. El usuario puede retroceder sin perder el estado del caso.
2. Un gate bloqueado debe explicar exactamente qué falta.
3. Un cálculo automático debe mostrar sus inputs y regla.
4. Una recomendación debe diferenciarse visualmente de una decisión confirmada.
5. Un override debe conservar recomendación original, decisión final y motivo.
6. La etapa siguiente consume outputs estructurados, no textos de pantalla.
7. El laboratorio debe poder mostrar el journey completo aun cuando una etapa esté en estado `to_validate`.
8. Ninguna UI debe hardcodear una matriz 5×5 como regla del producto: debe consumir un perfil de riesgo configurado.
9. El árbol RCM debe representarse como lógica de ramas y criterios, nunca como una puntuación que determine la política.
10. La taxonomía puede identificar candidatos de aplicabilidad, pero no sustituye la decisión del especialista.
11. Una excepción de un activo debe quedar separada del plan genérico para no propagar cambios accidentalmente al resto.

## 7. Handoff operacional descubierto el 2026-08-14

La reunión del 14 de agosto confirmó que la publicación del plan no es el final del ciclo de mantenimiento. Existe una extensión operacional posterior.

### 7.1. Tramo suficientemente validado para modelar la frontera

```text
Plan publicado vigente
→ seleccionar ejercicio / contexto presupuestario
→ acción explícita: generar paquete anual de órdenes preventivas
```

Principios confirmados:

- no se deben pregenerar todas las órdenes de la vida útil de la planta;
- la generación preventiva se realiza año a año;
- debe partir de la versión vigente del plan;
- las órdenes están relacionadas con el contexto presupuestario/centro de coste aplicable;
- la generación debe ser una acción controlada, no un automatismo silencioso.

### 7.2. Tramo todavía `to_validate`

```text
Órdenes preventivas
→ planificación
→ programación
→ asignación de ejecutores
→ ejecución y feedback
→ coste real
→ imputación contractual / centro de coste
→ procesos corporativos de coste o facturación
```

Este tramo forma parte del **modelo objetivo** de CMMS 2.0, pero no se incorpora todavía como nuevas etapas canónicas FL porque requiere sesiones específicas con Mantenimiento/Planning y, para la parte económica, Contratos/Subcontratos.

En el Functional Lab actual solo debe mostrarse el **handoff conceptual** después de FL-26.

## 8. Relación con documentación funcional

Cada etapa validada debe poder trazarse, según aplique, a:

- requisito funcional;
- regla de negocio;
- entidad o atributo conceptual;
- rol / responsabilidad;
- especificación de workspace;
- decisión humano/sistema;
- integración o dato de entrada externo;
- pregunta abierta.

El objetivo es que el Functional Lab sea una fuente de descubrimiento y evidencia, no una documentación paralela.
