# CMMS 2.0 — Product Truth Baseline v1.0

**Fecha de consolidación:** 2026-10-02  
**Estado:** CANONICAL BASELINE

> Este documento congela lo aprendido en reuniones, análisis y Functional Lab antes de continuar implementación. Cuando exista una contradicción explícitamente reconciliada aquí, esta baseline prevalece sobre hipótesis anteriores.

## 1. Cadena canónica

Asset / Functional Context → Reliability & Maintenance Engineering → Governed Project Maintenance Plan → Rolling Next Due / Forecast → Work Management → Execution → Reliable Actuals → KPI / Effectiveness → Controlled Revision.

## 2. Product Truth confirmado

### PT-01 — El mantenimiento parte de función, fallo, consecuencia y riesgo
Las tareas no son el punto de partida. Debe poder demostrarse qué riesgo o necesidad funcional controla cada estrategia.

### PT-02 — AMEF forma parte del razonamiento RCM
AMEF/FMEA no se gobierna como un producto aislado que después pasa a RCM. Funciones, fallos, modos, causas, efectos y consecuencias alimentan la decisión RCM.

### PT-03 — RCM es árbol lógico, no scoring
La lógica conserva preguntas, respuestas, evidencia, justificación y versión. La matriz de riesgo es configurable por cliente/proyecto; 5x5 solo puede ser un ejemplo.

### PT-04 — Autoridad humana
El sistema puede recomendar y sugerir aplicabilidad, pero decisiones técnicas relevantes, overrides y publicación requieren autoridad humana trazable.

### PT-05 — RCM no es la única fuente
Maintenance Engineering admite RCM específico, Corporate Maintenance Standards, OEM/Vendor y experiencia de ingeniería/histórica. No todos los activos requieren un RCM completo.

### PT-06 — Biblioteca corporativa y adopción por proyecto
Los estándares se versionan por tipo de equipo. El proyecto adopta un snapshot y puede desactivar, modificar o añadir actividades con justificación. Los cambios locales no mutan el master.

### PT-07 — Aplicabilidad contextual
Taxonomía o Equipment Type puede sugerir candidatos, pero no aplica automáticamente un plan. Deben soportarse overrides por activo/contexto sin duplicar el conocimiento base.

### PT-08 — Granularidad de ejecución
Maintenance Activity es unidad planificable/programable/cerrable; Job Plan es plantilla reusable; Procedure/Checklist contiene detalle paso a paso; Work Order es instancia operacional. Los pasos de checklist no son actividades independientes por defecto.

### PT-09 — Publicación y versionado
Las revisiones publicadas son inmutables. Los cambios generan nueva revisión o versión y conservan provenance y motivo.

### PT-10 — Preventivo rolling, no materialización masiva
La hipótesis de generar preventivas por ejercicio/año como mecanismo runtime principal queda sustituida. El modelo es Published Plan → recurrence/next due → materialize WO according to governed horizon → execute → next due. Año y presupuesto quedan como forecast/contexto.

### PT-11 — Work Candidate no es universal
El preventivo recurrente ya aprobado no necesita atravesar obligatoriamente WorkCandidate. Puede conservarse para correctivos, solicitudes, backlog u otros trabajos aún no comprometidos.

### PT-12 — Execution Package
Una WO debe resolver Maintenance Activity + Job Plan + Procedure/Checklist + documentación técnica del activo + adjuntos específicos + permisos/restricciones, preferentemente por referencia.

### PT-13 — Hallazgo preventivo abre trabajo correctivo
Una preventiva no debe absorber una reparación nueva. Un hallazgo que requiere reparación abre una rama correctiva trazable.

### PT-14 — Feedback cierra el ciclo
Actual start/finish, duración, recursos, resultado, hallazgos, referencias correctivas y cierre técnico alimentan plan-vs-actual, KPIs y revisión de estrategia.

### PT-15 — FLH, taxonomía y ADR físico son estructuras distintas
ISO 14224 es referencia taxonómica, no jerarquía funcional rígida. Los activos hijos conservan identidad, historial, tareas, resultados y costes propios.

## 3. Hipótesis sustituidas o rechazadas

| Hipótesis anterior | Estado | Baseline vigente |
|---|---|---|
| Toda estrategia nace de RCM | SUPERSEDED | RCM + Standards + OEM + experiencia |
| AMEF es producto separado previo a RCM | SUPERSEDED | AMEF forma parte del razonamiento RCM |
| Wizard AMEF equivale al modelo funcional | SUPERSEDED | Wizard es UX opcional; master/versionado es el modelo persistente |
| Generación preventiva anual como runtime principal | SUPERSEDED | rolling next due + forecast separado |
| Todo preventivo pasa por WorkCandidate | SUPERSEDED | preventivo aprobado puede materializar WO al vencer |
| Cada paso del procedimiento es actividad CMMS | REJECTED | Activity y Procedure/Checklist están separados |
| Aplicabilidad automática por tipo de equipo | REJECTED | sugerencia + confirmación humana |

## 4. Product Truth todavía abierto

- Frontera definitiva JobPlan vs ProcedureChecklist.
- Maintenance Standards: MSL-G01 a MSL-G04.
- Trigger/horizon exacto para materializar WO.
- Lifecycle definitivo de Work Order.
- Capacity, shifts, grouping, assignment y replanning.
- Permit to Work / operations permissive contractual.
- Diagnosis y entrada correctiva.
- Costes, contratos, subcontratos y facturación.
- Catálogo KPI definitivo y reglas de calidad.
- Arquitectura productiva final e integraciones corporativas.

## 5. Functional Lab

- P-101 se conserva como caso de la RCM Engineering Route.
- No representa el único camino del producto.
- Maintenance Standards necesita un caso basado en fuente real normalizada; no fixture ficticio antes de MSL-G01/MSL-G02.
- Work Management se amplía únicamente al ritmo de sus gates.
- Ninguna pantalla, Flow o SQL debe asumir una hipótesis OPEN como requisito cerrado.

## 6. Estado por dominio

| Dominio | Estado |
|---|---|
| Asset context / estructuras conceptuales | CONFIRMED; reconciliación Asset Master pendiente |
| Reliability Engineering / RCM route | CONFIRMED para Functional Lab |
| Maintenance Standards Library | ACTIVE — siguiente gate MSL-G01 |
| Project maintenance plan governance | CONFIRMED conceptual; contracts parciales |
| Work Management | ACTIVE DISCOVERY — parcial |
| Execution feedback | PARTIAL |
| Costs / Contracts / Billing | OPEN |
| AMEF wizard | HOLD — futuro, no bloqueante |
| Productive architecture | OPEN / IT DECISION |

## 7. Siguiente gate ejecutable

**MSL-G01 — Source Normalization**

1. Elegir una fuente real de mantenimiento mostrada o compartida.
2. Registrar provenance.
3. Normalizar Equipment Type, actividades, frecuencias, Job Plans, procedimientos, recursos y herramientas.
4. Detectar ambigüedades sin inventar datos.
5. Producir el input verificable para MSL-G02 Core Contracts.

Hasta cerrar MSL-G01 no debe construirse una biblioteca corporativa ficticia.

## 8. Regla de implementación

Evidence → Decision → Product Truth → Contract → Gate → Implementation → Runtime Validation.

La existencia de mockup, HTML, YAML, Power Fx o SQL no equivale a validación funcional.