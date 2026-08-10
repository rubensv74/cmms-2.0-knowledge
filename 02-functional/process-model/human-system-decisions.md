# Matriz preliminar — Persona vs sistema

## 1. Propósito

Hacer explícito, antes de construir pantallas, qué parte del recorrido debe aportar una persona y qué parte puede ejecutar o sugerir el sistema.

**Estado general:** `to_validate`.

Esta matriz es una hipótesis funcional para las reuniones. No autoriza todavía automatismos productivos.

## 2. Leyenda

- **H** — decisión o input humano.
- **C** — cálculo determinista del sistema.
- **R** — recomendación del sistema que necesita confirmación.
- **G** — gate automático o semiautomático.
- **O** — output estructurado.

## 3. Matriz v1

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
| FL-09 S/O/D | ✓ | ✓ |  |  | NPR y riesgo derivados de escalas. |
| FL-10 Sobreclasificación | ✓ | ✓ | ✓ |  | Prioridad ajustada y motivo. |
| FL-11 Controles y excepciones | ✓ | ✓ |  | ✓ | AMEF preparado o bloqueado para RCM. |
| FL-12 Fallo evidente | ✓ |  |  |  | Rama RCM seleccionada. |
| FL-13 Degradación detectable | ✓ |  | ✓ |  | Evidencia de fallo potencial. |
| FL-14 Ventana P–F | ✓ | ✓ | ✓ | ✓ | Viabilidad de detección e intervención. |
| FL-15 Políticas válidas | ✓ | ✓ | ✓ |  | Alternativas técnicamente viables. |
| FL-16 Decisión RCM | ✓ |  | ✓ |  | Estrategia aceptada, condiciones y autoridad. |
| FL-17 Coste esperado | ✓ | ✓ | ✓ |  | Comparación económica entre alternativas válidas. |
| FL-18 Tarea ejecutable | ✓ |  |  |  | Tarea, técnica, criterio y reacción. |
| FL-19 Intervalo | ✓ | ✓ | ✓ | ✓ | Intervalo defendible o necesidad de revisión. |
| FL-20 Recursos | ✓ |  |  |  | Disciplina, puesto, herramientas, repuestos y permisos. |
| FL-21 Alcance y paquete | ✓ |  | ✓ | ✓ | Alcance físico y agrupación coherente. |
| FL-22 Gate del plan |  | ✓ |  | ✓ | Paquete preparado o bloqueado para gobernanza. |
| FL-23 Trazabilidad | ✓ | ✓ |  | ✓ | Cadena completa sin referencias huérfanas. |
| FL-24 Control de calidad | ✓ | ✓ | ✓ | ✓ | Observaciones resueltas, aceptadas o bloqueadas. |
| FL-25 Revisión multidisciplinar | ✓ |  |  |  | Resolución y responsable del seguimiento. |
| FL-26 Aprobación y snapshot | ✓ | ✓ |  | ✓ | Aprobaciones completas y versión inmutable. |
| FL-27 Datos reales | ✓ | ✓ | ✓ |  | Desviaciones frente a hipótesis iniciales. |
| FL-28 Mejora continua | ✓ | ✓ | ✓ |  | Mantener, ajustar o abrir nueva revisión. |

## 4. Reglas de diseño derivadas

### 4.1. Un cálculo no sustituye a una decisión

Ejemplo: el sistema puede calcular S×O o NPR, pero la valoración de severidad, ocurrencia y detección necesita una fuente y una responsabilidad definida.

### 4.2. Una recomendación debe conservar su identidad

Cuando exista recomendación automática y decisión humana final, deben conservarse ambas.

```text
systemRecommendation
humanDecision
reason
```

### 4.3. Un override debe ser visible

Si la decisión humana contradice una recomendación, la app debe solicitar motivo y conservar la recomendación original.

### 4.4. Un gate debe ser explicable

No basta con deshabilitar `Siguiente`. Debe mostrarse:

- qué condición falla;
- qué dato falta;
- qué rol puede resolverlo;
- si el bloqueo es una regla validada o una simulación.

### 4.5. Automatismo no significa autoridad

La app puede calcular, validar consistencia y sugerir. La autoridad final se decide funcionalmente para cada proceso.

## 5. Preguntas que deben resolverse en reuniones

La matriz debe utilizarse para preguntar sistemáticamente:

1. ¿Este dato ya existe en otro módulo?
2. ¿Quién es responsable de su calidad?
3. ¿Puede calcularlo el sistema sin interpretación?
4. ¿Puede sugerirlo el sistema pero debe confirmarlo una persona?
5. ¿Qué rol tiene autoridad para aceptar o cambiar la recomendación?
6. ¿Qué evidencia debe quedar registrada?
7. ¿Qué condición debe bloquear realmente el avance?

Las respuestas validadas deberán actualizar esta matriz y generar requisitos funcionales asociados.
