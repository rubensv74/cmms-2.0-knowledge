# Recorrido guiado P-101 — AMEF–RCM para CMMS 2.0

**Estado:** guía didáctica alineada con Functional Lab v2  
**Fecha de revisión:** 2026-08-11

## Propósito

P-101 sigue siendo el ejemplo didáctico principal, pero ya no se presenta como el contenedor del AMEF.

El recorrido demuestra cómo una **biblioteca reusable de ingeniería para bombas centrífugas** se crea y publica primero, se aplica después a P-101, se transforma en un plan contextual y finalmente se contrasta con resultados reales.

```text
FMEA-CWPUMP-001 / Rev 1
Engineering Library
        ↓
APP-P101-FMEAR1-001
Asset Application
        ↓
PLAN-P101-001
Execution Plan
        ↓
Maintenance Results
Results & Learning
```

El objetivo didáctico es que cualquier participante pueda distinguir qué conocimiento puede reutilizarse en muchos activos y qué decisiones pertenecen exclusivamente a P-101.

## Principios de diseño

1. **La biblioteca precede a la aplicación.** El recorrido comienza identificando el conocimiento reusable, no el activo.
2. **P-101 aparece cuando toca aplicar.** Contexto operacional y criticidad del activo pertenecen a `FmeaAssetApplication`.
3. **Una decisión cada vez.** El usuario avanza cuando confirma un output funcional.
4. **Gates explicables.** Todo bloqueo debe indicar qué falta y qué regla lo provoca.
5. **Trazabilidad por IDs.** La narrativa visible no sustituye las relaciones entre objetos.
6. **Riesgo y criticidad no son sinónimos.** La evaluación AMEF se realiza antes y por separado de la criticidad contextual del activo.
7. **Tarea, procedimiento y formato son objetos distintos.** Pueden relacionarse sin quedar fusionados.
8. **Modo y tarea son N:M.** Una tarea puede tratar varios modos y un modo puede necesitar varias tareas.
9. **Sin tarea también es una decisión.** RCM puede terminar en `NoScheduledTaskDecision`.
10. **El resultado real no sobrescribe el pasado.** Puede abrir una nueva revisión, pero conserva la versión que originó el plan.

## Las 28 etapas

### 1. Construir la Engineering Library

1. Seleccionar o crear `FmeaDefinition`.
2. Crear o seleccionar `FmeaRevision`.
3. Confirmar alcance, evidencia y supuestos.
4. Definir funciones con estándar.
5. Identificar fallos funcionales.
6. Identificar modos de fallo.
7. Descomponer causas y mecanismos.
8. Describir efectos ordenados.

### 2. Evaluar consecuencias y tomar la decisión RCM

9. Seleccionar contexto/perfil de evaluación y versión de matriz de riesgo.
10. Evaluar consecuencias y riesgo AMEF.
11. Revisar controles, evidencia y excepciones.
12. Confirmar si el fallo es evidente.
13. Demostrar degradación detectable.
14. Evaluar la ventana P–F.
15. Comparar políticas técnicamente válidas.
16. Emitir la decisión RCM explicable, con tarea o decisión explícita sin tarea.

### 3. Diseñar y publicar el tratamiento reusable

17. Diseñar `MaintenanceTask`.
18. Relacionar tareas y modos con cardinalidad N:M.
19. Asociar `MaintenanceProcedure` e `InspectionFormat` cuando proceda.
20. Estimar el coste de mantenimiento.
21. Comparar escenarios mediante `EconomicAssessment`.
22. Revisar, aprobar y publicar `FmeaRevision` como snapshot inmutable.

### 4. Aplicar la biblioteca a P-101 y construir el plan

23. Crear `FmeaAssetApplication` para P-101, congelando contexto y criticidad del activo.
24. Evaluar aplicabilidad, perfiles, variantes y overrides.
25. Construir `ExecutionPlan` con las tareas aplicables, recursos, alcance e intervalo efectivo.
26. Superar el gate y congelar/publicar la revisión del plan.

### 5. Registrar resultados y aprender

27. Registrar `MaintenanceResult` y `ActualMaintenanceCost`.
28. Ejecutar `EffectivenessReview`: mantener, ajustar aplicación/plan o abrir una solicitud de cambio que pueda crear una nueva `FmeaRevision`.

## Qué cambia respecto al recorrido histórico

### Antes

```text
P-101
→ funciones
→ modos
→ riesgo
→ RCM
→ tarea
→ plan
→ resultados
```

Esta narrativa era comprensible, pero inducía a pensar que funciones, modos y tareas pertenecían a P-101.

### Ahora

```text
Biblioteca reusable
→ revisión publicada
→ P-101 consume la revisión
→ plan contextual
→ resultados
```

Esto permite reutilizar el mismo conocimiento para P-102 u otros activos equivalentes y mantener únicamente las diferencias que realmente sean contextuales.

## Ejemplo de separación

### Biblioteca

```text
MaintenanceTask MT-CWPUMP-001
Monitorizar condición mecánica del tren rotativo
```

puede tratar:

```text
FM-CWPUMP-003 Degradación de rodamientos
FM-CWPUMP-009 Desalineación del tren
```

### Aplicación P-101

Decide si `MT-CWPUMP-001` aplica a P-101 y qué perfil/variante corresponde según su contexto.

### Plan P-101

Decide el intervalo efectivo, recursos, alcance y versiones de procedimiento/formato que se utilizarán en P-101.

### Resultado

Registra qué se encontró realmente y cuánto costó esa ejecución.

Ninguna de estas decisiones necesita clonar la definición AMEF.

## Uso recomendado en reunión

1. Presentar primero la cadena de cuatro capas.
2. Mostrar la biblioteca `FMEA-CWPUMP-001 / Rev 1` y explicar qué sería reusable.
3. Revisar función → fallo → modo → causa/efecto → riesgo → RCM.
4. Mostrar la relación N:M entre tareas y modos y la separación de procedimiento/formato.
5. Cambiar visualmente de capa y presentar P-101 como `FmeaAssetApplication`.
6. Comparar riesgo AMEF con criticidad del activo para confirmar que el grupo entiende la diferencia.
7. Construir el Execution Plan contextual.
8. Cerrar con resultados y explicar cuándo se ajusta solo el plan y cuándo se abre una nueva revisión de biblioteca.

## Límite

El caso es realista y coherente de extremo a extremo, pero no representa una instrucción de mantenimiento aprobada.

Permanecen pendientes de validación corporativa, entre otros:

- matrices y escalas de riesgo;
- esquema de criticidad;
- árbol RCM definitivo;
- umbrales P–F;
- fórmulas económicas;
- roles/autoridades;
- estados de aprobación;
- frecuencias y criterios técnicos del ejemplo.
