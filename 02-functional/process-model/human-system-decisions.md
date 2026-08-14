# Matriz preliminar — Persona vs sistema

**Versión funcional:** v1.1  
**Última revisión:** 2026-08-14  
**Fuente de revisión:** [`../../05-meetings/2026/2026-08-14_revision-modelo-conceptual-amef-rcm.md`](../../05-meetings/2026/2026-08-14_revision-modelo-conceptual-amef-rcm.md)

## 1. Propósito

Hacer explícito, antes de construir pantallas, qué parte del recorrido debe aportar una persona y qué parte puede ejecutar o sugerir el sistema.

**Estado general:** `to_validate`, con criterios concretos confirmados en la reunión del 2026-08-14.

Esta matriz es una hipótesis funcional para las reuniones. No autoriza todavía automatismos productivos.

## 2. Leyenda

- **H** — decisión o input humano.
- **C** — cálculo determinista del sistema.
- **R** — recomendación del sistema que necesita confirmación.
- **G** — gate automático o semiautomático.
- **O** — output estructurado.

## 3. Matriz v1.1

| Etapa | H | C | R | G | Resultado esperado |
|---|:---:|:---:|:---:|:---:|---|
| FL-01 Activo y límites | ✓ |  |  |  | Alcance del análisis confirmado. |
| FL-02 Contexto operacional | ✓ |  |  |  | Demanda, modos, redundancia y restricciones. |
| FL-03 Preparación de datos | ✓ | ✓ |  | ✓ | Nivel de evidencia y confianza; bloqueo si es insuficiente. |
| FL-04 Funciones | ✓ |  |  |  | Funciones con estándar medible. |
| FL-05 Fallos funcionales | ✓ |  |  |  | Incumplimientos totales/parciales. |
| FL-06 Modos relevantes | ✓ |  | ✓ | ✓ | Modos incluidos/excluidos y modo de análisis. |
| FL-07 Efectos | ✓ |  |  |  | Efectos local, sistema y operacional. |
| FL-08 Consecuencias | ✓ |  | ✓ |  | Clasificación de consecuencia confirmada. |
| FL-09 Perfil de riesgo | ✓ | ✓ |  |  | Valoraciones humanas aplicadas sobre escalas/rangos configurados y resultado calculado por el sistema. |
| FL-10 Criticidad / sobreclasificación | ✓ | ✓ | ✓ |  | Prioridad ajustada según reglas configuradas y motivo. |
| FL-11 Controles y excepciones | ✓ | ✓ |  | ✓ | AMEF preparado o bloqueado para RCM. |
| FL-12 Fallo evidente | ✓ |  |  |  | Rama RCM seleccionada desde una respuesta trazada. |
| FL-13 Degradación detectable | ✓ |  | ✓ |  | Evidencia de fallo potencial y continuidad de la rama. |
| FL-14 Ventana P–F | ✓ | ✓ | ✓ | ✓ | Viabilidad de detección e intervención. |
| FL-15 Políticas válidas | ✓ | ✓ | ✓ |  | Alternativas técnicamente viables/efectivas según criterios del árbol. |
| FL-16 Decisión RCM | ✓ | ✓ | ✓ |  | Política resultante del árbol lógico, confirmada con evidencia y autoridad; sin scoring. |
| FL-17 Coste esperado | ✓ | ✓ | ✓ |  | Comparación económica cuando proceda. |
| FL-18 Tarea ejecutable | ✓ |  |  |  | Tarea, técnica, criterio, reacción y fuentes de justificación. |
| FL-19 Intervalo | ✓ | ✓ | ✓ | ✓ | Intervalo defendible desde P–F, fabricante, histórico y/o experiencia. |
| FL-20 Recursos | ✓ |  |  |  | Disciplina, ejecutor, cantidad, horas-hombre, herramientas, repuestos, permisos y parada. |
| FL-21 Alcance y aplicabilidad | ✓ | ✓ | ✓ | ✓ | Plan genérico, activos candidatos, decisión de aplicabilidad y overrides específicos. |
| FL-22 Gate del plan |  | ✓ | ✓ | ✓ | Paquete agrupado, coherente y preparado para gobernanza. |
| FL-23 Trazabilidad | ✓ | ✓ |  | ✓ | Cadena completa sin referencias huérfanas. |
| FL-24 Control de calidad | ✓ | ✓ | ✓ | ✓ | Observaciones resueltas, aceptadas o bloqueadas. |
| FL-25 Revisión multidisciplinar | ✓ |  |  |  | Resolución y responsable del seguimiento. |
| FL-26 Aprobación y snapshot | ✓ | ✓ |  | ✓ | Aprobaciones completas, versión inmutable y output de handoff operacional. |
| FL-27 Datos reales | ✓ | ✓ | ✓ |  | Desviaciones frente a hipótesis iniciales. |
| FL-28 Mejora continua | ✓ | ✓ | ✓ |  | Mantener, ajustar o abrir nueva revisión. |

## 4. Reglas de diseño derivadas

### 4.1. Un cálculo no sustituye a una decisión

Ejemplo: el sistema puede calcular la posición o indicador de riesgo según el `RiskProfile` configurado, pero las valoraciones de entrada necesitan fuente y responsabilidad definida.

### 4.2. La matriz de riesgo es configuración, no código de UI

El sistema no debe asumir una matriz 5×5. El cliente/proyecto debe poder definir y versionar, según aplique:

- número de niveles;
- rangos de severidad/consecuencia;
- dimensiones utilizadas;
- reglas de clasificación;
- umbrales y sobreclasificaciones.

La reunión del 2026-08-14 confirmó el principio de configurabilidad. La estructura exacta del `RiskProfile` permanece `to_validate`.

### 4.3. RCM es un árbol lógico, no scoring

Las respuestas a las preguntas RCM conducen a una rama/política. El sistema puede determinar de forma reproducible la siguiente rama a partir de respuestas y reglas configuradas, pero no debe inventar una puntuación acumulada.

Debe conservarse como mínimo:

```text
questionId
answer
explanation
evidence
systemBranch
humanConfirmation
actorRole
```

### 4.4. Factibilidad técnica y efectividad son parte de la decisión

Una política no debe mostrarse como válida solo porque una rama la alcance. Deben quedar visibles los criterios que la justifican, por ejemplo cuando aplique:

- condición de fallo potencial identificable;
- intervalo P–F conocido y razonablemente consistente;
- tiempo suficiente para actuar;
- posibilidad práctica de ejecutar a una frecuencia menor que P–F;
- reducción del riesgo a un nivel tolerable para consecuencias de seguridad/ambiente;
- razonabilidad económica para consecuencias económicas.

### 4.5. Una recomendación debe conservar su identidad

Cuando exista recomendación automática y decisión humana final, deben conservarse ambas.

```text
systemRecommendation
humanDecision
reason
```

### 4.6. La taxonomía recomienda candidatos; el especialista decide aplicabilidad

La búsqueda de activos similares/equivalentes puede automatizarse. La decisión de aplicar el plan no.

```text
candidateAssets = system_recommendation
applicabilityDecision = human_decision
```

No se aplicará silenciosamente un plan a todos los activos devueltos por taxonomía.

### 4.7. El override por activo no modifica el plan genérico

Si un especialista necesita añadir, eliminar o modificar una actividad para un activo concreto, debe crearse una variante/override trazado para ese activo.

Debe conservarse:

```text
basePlanVersion
assetId
overrideType
baseTaskId
assetSpecificTask
reason
actor
```

### 4.8. La agrupación de tareas necesita reglas explícitas

La reunión confirmó que actividades compatibles sobre el mismo equipo y frecuencia pueden agruparse en una misma orden/paquete de ejecución.

Sin embargo, el algoritmo exacto de duración y horas-hombre cuando intervienen distintas disciplinas permanece `to_validate`; no debe implementarse una suma o máximo automático sin regla validada.

### 4.9. La generación anual de órdenes debe ser explícita

El handoff posterior a publicación debe permitir conceptualmente:

```text
planVersion
planningYear
budgetContext
costCenterContext
generateAnnualPreventiveOrders = explicit_user_action
```

No se pregenerarán órdenes para toda la vida útil de la planta y no se generarán nuevas órdenes anuales mediante un automatismo silencioso.

### 4.10. Un override debe ser visible

Si la decisión humana contradice una recomendación, la app debe solicitar motivo y conservar la recomendación original.

### 4.11. Un gate debe ser explicable

No basta con deshabilitar `Siguiente`. Debe mostrarse:

- qué condición falla;
- qué dato falta;
- qué rol puede resolverlo;
- si el bloqueo es una regla validada o una simulación.

### 4.12. Automatismo no significa autoridad

La app puede calcular, validar consistencia y sugerir. La autoridad final se decide funcionalmente para cada proceso.

## 5. Frontera operacional todavía abierta

Después de FL-26 se ha identificado el siguiente flujo objetivo:

```text
plan publicado
→ generación anual de preventivas
→ planificación/programación
→ asignación
→ ejecución/feedback
→ coste real
→ imputación presupuestaria/contractual
→ integración corporativa / facturación
```

Solo el primer handoff está suficientemente validado para representarlo en la demo. Las responsabilidades persona/sistema del resto del flujo deben definirse en futuras reuniones.

## 6. Preguntas que deben resolverse en reuniones

La matriz debe utilizarse para preguntar sistemáticamente:

1. ¿Este dato ya existe en otro módulo?
2. ¿Quién es responsable de su calidad?
3. ¿Puede calcularlo el sistema sin interpretación?
4. ¿Puede sugerirlo el sistema pero debe confirmarlo una persona?
5. ¿Qué rol tiene autoridad para aceptar o cambiar la recomendación?
6. ¿Qué evidencia debe quedar registrada?
7. ¿Qué condición debe bloquear realmente el avance?
8. ¿La regla es corporativa o configurable por cliente/proyecto?
9. ¿Una decisión afecta al plan genérico o solo a un activo concreto?
10. ¿El output inicia otro proceso que todavía no está modelado?

Las respuestas validadas deberán actualizar esta matriz y generar requisitos funcionales asociados.
