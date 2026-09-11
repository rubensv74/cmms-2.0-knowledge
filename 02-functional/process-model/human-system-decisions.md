# Matriz preliminar — Persona vs sistema

**Versión funcional:** v1.2  
**Última revisión:** 2026-09-11  
**Fuentes de revisión:**  
- [`../../05-meetings/2026/2026-08-14_revision-modelo-conceptual-amef-rcm.md`](../../05-meetings/2026/2026-08-14_revision-modelo-conceptual-amef-rcm.md)  
- [`../../05-meetings/2026/2026-09-11_revision-cmms-estandares-job-plans.md`](../../05-meetings/2026/2026-09-11_revision-cmms-estandares-job-plans.md)

## 1. Propósito

Hacer explícito qué parte del recorrido debe aportar una persona y qué parte puede calcular, sugerir o resolver el sistema.

La matriz principal sigue describiendo la **RCM Engineering Route**. La revisión 2026-09-11 añade decisiones específicas de la **Corporate Standard Route**.

**Estado general:** `to_validate`, con principios funcionales confirmados en reuniones.

## 2. Leyenda

- **H** — decisión o input humano.
- **C** — cálculo determinista del sistema.
- **R** — recomendación del sistema que necesita confirmación.
- **G** — gate automático o semiautomático.

## 3. Matriz RCM route v1.2

| Etapa | H | C | R | G | Resultado esperado |
|---|:---:|:---:|:---:|:---:|---|
| FL-01 Activo y límites | ✓ |  |  |  | Alcance confirmado. |
| FL-02 Contexto operacional | ✓ |  |  |  | Demanda, modos, redundancia y restricciones. |
| FL-03 Preparación de datos | ✓ | ✓ |  | ✓ | Evidencia/confianza suficiente o bloqueo. |
| FL-04 Funciones | ✓ |  |  |  | Funciones con estándar medible. |
| FL-05 Fallos funcionales | ✓ |  |  |  | Incumplimientos totales/parciales. |
| FL-06 Modos relevantes | ✓ |  | ✓ | ✓ | Modos incluidos/excluidos y justificación. |
| FL-07 Efectos | ✓ |  |  |  | Efectos local, sistema y operacional. |
| FL-08 Consecuencias | ✓ |  | ✓ |  | Consecuencia confirmada. |
| FL-09 Perfil de riesgo | ✓ | ✓ |  |  | Valoraciones sobre configuración activa y resultado calculado. |
| FL-10 Criticidad / sobreclasificación | ✓ | ✓ | ✓ |  | Prioridad ajustada y motivo. |
| FL-11 Controles y excepciones | ✓ | ✓ |  | ✓ | Análisis preparado o bloqueado. |
| FL-12 Fallo evidente | ✓ |  |  |  | Rama RCM seleccionada. |
| FL-13 Degradación detectable | ✓ |  | ✓ |  | Evidencia de fallo potencial. |
| FL-14 Ventana P–F | ✓ | ✓ | ✓ | ✓ | Ventana desde P hasta fallo funcional F y viabilidad de intervención. |
| FL-15 Políticas válidas | ✓ | ✓ | ✓ |  | Alternativas técnicamente válidas/efectivas. |
| FL-16 Decisión RCM | ✓ | ✓ | ✓ |  | Política resultante confirmada; sin scoring. |
| FL-17 Coste esperado | ✓ | ✓ | ✓ |  | Comparación económica cuando proceda. |
| FL-18 Actividad ejecutable | ✓ |  | ✓ |  | Actividad CMMS gestionable, `sourceBasis` y referencia a Job Plan/procedimiento. |
| FL-19 Intervalo | ✓ | ✓ | ✓ | ✓ | Intervalo justificable desde P–F, estándar, fabricante, histórico o experiencia. |
| FL-20 Recursos | ✓ | ✓ | ✓ |  | Disciplina, crew, horas-hombre, herramientas/equipos, materiales y condiciones. |
| FL-21 Alcance y aplicabilidad | ✓ | ✓ | ✓ | ✓ | Plan base/adoptado, activos candidatos y overrides. |
| FL-22 Gate del plan |  | ✓ | ✓ | ✓ | Paquete coherente y preparado para gobernanza. |
| FL-23 Trazabilidad | ✓ | ✓ |  | ✓ | Cadena completa incluyendo fuente/origen. |
| FL-24 Control de calidad | ✓ | ✓ | ✓ | ✓ | Observaciones resueltas, aceptadas o bloqueadas. |
| FL-25 Revisión multidisciplinar | ✓ |  |  |  | Resolución y responsable. |
| FL-26 Aprobación y snapshot | ✓ | ✓ |  | ✓ | Versión inmutable y handoff operacional. |
| FL-27 Datos reales | ✓ | ✓ | ✓ |  | Desviaciones frente a hipótesis/baseline. |
| FL-28 Mejora continua | ✓ | ✓ | ✓ |  | Mantener, ajustar, reabrir o proponer aprendizaje corporativo. |

## 4. Reglas de diseño derivadas

### 4.1. Un cálculo no sustituye a una decisión

El sistema puede calcular riesgo, vencimientos o consistencia. Las valoraciones y decisiones con interpretación necesitan autoridad humana definida.

### 4.2. La matriz de riesgo es configuración

No se asume 5×5. El proyecto/cliente puede definir niveles, rangos, dimensiones, umbrales y reglas.

### 4.3. RCM es árbol lógico, no scoring

Debe conservarse:

```text
questionId
answer
explanation
evidence
systemBranch
humanConfirmation
actorRole
```

### 4.4. AMEF forma parte de RCM

Funciones, fallos funcionales, modos y efectos forman parte del análisis RCM. La UI no debe inducir a pensar que AMEF y RCM son dos procesos independientes desconectados.

### 4.5. P–F termina en fallo funcional

`F` es el umbral de fallo funcional definido, no necesariamente la rotura física del activo.

El sistema puede calcular ventanas a partir de datos/umbrales, pero su definición técnica necesita fuente y autoridad.

### 4.6. Factibilidad técnica y efectividad son parte de la decisión

Cuando aplique deben quedar visibles:

- condición de fallo potencial detectable;
- P–F consistente;
- tiempo para actuar;
- frecuencia practicable;
- reducción/tolerabilidad del riesgo;
- razonabilidad económica.

### 4.7. Una recomendación conserva su identidad

```text
systemRecommendation
humanDecision
reason
```

### 4.8. Taxonomía y Equipment Type sugieren; la persona decide

Esto aplica tanto a activos candidatos como a estándares de mantenimiento candidatos.

```text
candidateAssets = system_recommendation
candidateStandard = system_recommendation
applicabilityDecision = human_decision
```

### 4.9. El override no modifica el baseline

Sea un plan genérico, un estándar corporativo o un plan de proyecto, el cambio específico debe quedar separado y trazado.

### 4.10. La unidad CMMS no es cada paso del checklist

Regla confirmada 2026-09-11:

```text
Maintenance Activity        → unidad planificable / cerrable
Job Plan                    → template reusable
Procedure / Checklist       → detalle de ejecución
```

El sistema no debe generar avance obligatorio de actividad por cada subpaso salvo que exista una regla funcional explícita que lo justifique.

### 4.11. Los recursos deben cuantificarse

El CMMS debe poder representar, según aplique:

```text
discipline / role
crew / quantity
labor hours
materials / consumables / spares
tools
special / heavy equipment
shutdown / permit / safety conditions
```

El sistema puede calcular totales si existe regla validada; no debe inventar lógica de suma/máximo entre disciplinas.

### 4.12. La agrupación de tareas necesita reglas explícitas

Puede sugerirse agrupación, pero el algoritmo exacto continúa `to_validate`.

### 4.13. La generación anual de órdenes debe ser explícita

```text
planVersion
planningYear
budgetContext
costCenterContext
generateAnnualPreventiveOrders = explicit_user_action
```

### 4.14. Un gate debe ser explicable

Debe mostrar:

- condición que falla;
- dato faltante;
- rol capaz de resolverlo;
- estado de validación de la regla.

### 4.15. Automatismo no significa autoridad

La app puede calcular, validar y sugerir. La autoridad funcional se define para cada decisión.

## 5. Corporate Standard Route — persona vs sistema

| Acción | Sistema | Persona | Estado |
|---|---|---|---|
| Resolver estándar candidato por Equipment Type | Busca/sugiere | Especialista confirma | principio confirmado |
| Mostrar versión y fuentes | Automático | Revisa | principio confirmado |
| Adoptar estándar en proyecto | Prepara snapshot | Usuario autorizado confirma | workflow `to_validate` |
| Desactivar actividad | Valida referencias | Especialista decide y justifica | principio confirmado |
| Ajustar frecuencia | Compara baseline | Especialista decide y justifica | principio confirmado |
| Ajustar recursos | Puede sugerir baseline | Responsable funcional decide | principio confirmado |
| Añadir actividad local | Asiste | Especialista decide | principio confirmado |
| Propagar cambio a maestro | **No automático** | Gobierno corporativo revisa/aprueba | principio confirmado |
| Crear nueva versión maestra | Sistema versiona | Rol autorizado publica | workflow `to_validate` |
| Escalar a RCM específico | Puede recomendar por criticidad/contexto | Autoridad funcional decide | `to_validate` regla |

## 6. Roles: hallazgo y precaución

La reunión distingue conceptualmente:

```text
Planner     → qué se ejecuta
Programmer  → cómo, con quién y recursos
```

Esto es útil como separación de responsabilidades, pero los nombres no deben convertirse todavía en roles de seguridad o workflow universales. La terminología corporativa y las variantes por proyecto deben validarse.

## 7. Frontera operacional

```text
Published Project Plan
→ Annual Preventive Preparation
→ Maintenance Activity / Work Candidate
→ Work Order
   └── references Job Plan / Procedure Checklist
→ planning / scheduling
→ assignment
→ execution / feedback
→ actual cost
```

Las responsabilidades del tramo Work Management siguen gobernadas por `work-management-discovery.md`.

## 8. Preguntas que deben resolverse

1. ¿Qué dato ya existe en otro módulo o estándar?
2. ¿Quién es responsable de su calidad?
3. ¿Puede calcularlo el sistema sin interpretación?
4. ¿Puede sugerirlo y debe confirmarlo una persona?
5. ¿Qué rol tiene autoridad?
6. ¿Qué evidencia queda registrada?
7. ¿Qué bloquea realmente el avance?
8. ¿La regla es corporativa o configurable por proyecto?
9. ¿El cambio afecta al master, al proyecto o a un activo?
10. ¿Cuál es el `sourceBasis` de la actividad?
11. ¿El detalle pertenece a actividad, Job Plan o procedure/checklist?
12. ¿Existe un estándar corporativo antes de iniciar ingeniería desde cero?
13. ¿La criticidad justifica escalar a RCM específico?

Las respuestas validadas deberán actualizar contratos, requisitos y demos asociados.
