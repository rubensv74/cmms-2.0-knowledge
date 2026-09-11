# CMMS 2.0 Functional Journey

**Versión funcional:** v1.2  
**Última revisión:** 2026-09-11  
**Fuentes de revisión:**  
- [`../../05-meetings/2026/2026-08-14_revision-modelo-conceptual-amef-rcm.md`](../../05-meetings/2026/2026-08-14_revision-modelo-conceptual-amef-rcm.md)  
- [`../../05-meetings/2026/2026-09-11_revision-cmms-estandares-job-plans.md`](../../05-meetings/2026/2026-09-11_revision-cmms-estandares-job-plans.md)

## 1. Propósito

Definir el recorrido funcional de **ingeniería RCM** independiente de la interfaz. Este documento es la referencia para decidir qué procesos existen dentro de esa ruta, qué responsabilidad tiene cada etapa y cómo se agrupan posteriormente en workspaces de Power Apps.

Reglas:

> Una etapa funcional no equivale necesariamente a una pantalla.

> Este journey ya no se considera el único camino para crear un plan de mantenimiento.

La revisión 2026-09-11 confirma una segunda ruta gobernada basada en estándares corporativos, OEM/vendor y experiencia. Esa ruta se documenta en [`maintenance-standards-library.md`](maintenance-standards-library.md) y converge con la ruta RCM en la definición/adopción del plan del proyecto.

## 2. Modelo superior de Maintenance Engineering

```text
Maintenance Engineering
├── Route A — RCM specific engineering
│   └── este Functional Journey
└── Route B — Corporate maintenance standard adoption
    └── maintenance-standards-library.md

                     ↓
          Project Maintenance Plan
                     ↓
              Governance / Publish
                     ↓
              Work Management
```

Las rutas pueden coexistir en un mismo proyecto. Un estándar puede utilizarse como baseline general y determinados equipos/modos de fallo críticos pueden requerir RCM específico.

## 3. Modelo de etapa

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

## 4. Fases y etapas canónicas — RCM route v1.2

### Fase 1 — Comprender el problema

| ID | Etapa | Propósito |
|---|---|---|
| FL-01 | Definir el activo y sus límites | Establecer el objeto físico y la frontera del análisis. |
| FL-02 | Describir el contexto operacional | Definir demanda, modos, redundancia y restricciones. |
| FL-03 | Comprobar la preparación de datos | Confirmar evidencia y nivel de confianza. |
| FL-04 | Definir funciones con estándar | Expresar qué debe hacer el activo y cómo se mide el cumplimiento. |
| FL-05 | Identificar fallos funcionales | Definir cómo puede incumplirse total o parcialmente cada función. |
| FL-06 | Seleccionar modos de fallo relevantes | Seleccionar mecanismos causales plausibles y justificar exclusiones. |

**Aclaración 2026-09-11:** funciones, fallos funcionales, modos y efectos forman parte del análisis RCM; AMEF/FMEA no debe presentarse como un proceso ajeno que simplemente “precede” a RCM.

### Fase 2 — Evaluar efectos y riesgo

| ID | Etapa | Propósito |
|---|---|---|
| FL-07 | Describir efectos del modo de fallo | Separar efecto local, de sistema y operacional. |
| FL-08 | Clasificar las consecuencias | Determinar la naturaleza principal del impacto. |
| FL-09 | Aplicar el perfil de riesgo del proyecto | Valorar el riesgo utilizando dimensiones, escalas, rangos y matriz configurados para el cliente/proyecto; el modelo no presupone una 5×5 fija. |
| FL-10 | Aplicar reglas de criticidad y sobreclasificación | Elevar o ajustar prioridad cuando existan condiciones críticas definidas por el perfil aplicable. |
| FL-11 | Revisar controles y excepciones | Confirmar si existe información suficiente para continuar la decisión RCM. |

### Fase 3 — Tomar la decisión RCM

| ID | Etapa | Propósito |
|---|---|---|
| FL-12 | Confirmar si el fallo es evidente | Elegir la rama correcta del árbol RCM. |
| FL-13 | Demostrar degradación detectable | Confirmar si existe una condición de fallo potencial observable cuando la rama lo requiera. |
| FL-14 | Evaluar la ventana P–F | Verificar el intervalo entre fallo potencial detectable y fallo funcional y confirmar que existe tiempo suficiente para detectar y actuar. |
| FL-15 | Comparar políticas técnicamente válidas y efectivas | Aplicar criterios de factibilidad técnica y efectividad para descartar alternativas no aplicables o ineficaces. |
| FL-16 | Emitir la decisión RCM explicable | Consolidar la política resultante del árbol lógico, sus condiciones, evidencias y autoridad humana. No existe scoring RCM acumulado. |

**Aclaración P–F 2026-09-11:** `F` representa el umbral de fallo funcional, no necesariamente la rotura física. El activo puede seguir funcionando después de F y, aun así, encontrarse funcionalmente fallado según el criterio definido.

### Fase 4 — Convertir la decisión en un plan

| ID | Etapa | Propósito |
|---|---|---|
| FL-17 | Comparar el coste esperado cuando aplique | Comparar alternativas técnicamente válidas desde el punto de vista económico sin sustituir criterios de seguridad, ambiente o efectividad. |
| FL-18 | Diseñar o seleccionar una actividad ejecutable | Definir la unidad de mantenimiento gestionable en CMMS y su `sourceBasis` (RCM, standard, OEM o expert). El detalle fino debe quedar en Job Plan/procedimiento/checklist, no como subactividades independientes por defecto. |
| FL-19 | Justificar el intervalo de la actividad | Relacionar frecuencia con P–F, estándar corporativo, fabricante, experiencia, histórico y ventana de planificación según aplique. |
| FL-20 | Asignar recursos y condiciones de ejecución | Definir disciplina/especialidad, ejecutor, cantidad, horas-hombre, herramientas/equipos, materiales/consumibles/repuestos, permisos y necesidad de parada. |
| FL-21 | Construir alcance, aplicabilidad y variantes del plan | Formar/adoptar el plan base, identificar activos candidatos mediante taxonomía/equivalencia, registrar decisión humana de aplicabilidad y permitir overrides específicos por proyecto/activo. |
| FL-22 | Superar el gate del plan | Confirmar que tareas, Job Plans/procedimientos, frecuencias, recursos, aplicabilidad y excepciones forman un paquete coherente y preparado para gobernanza. |

### Fase 5 — Gobernar y mejorar

| ID | Etapa | Propósito |
|---|---|---|
| FL-23 | Reconstruir la trazabilidad integral | Verificar que puede justificarse la existencia de cada actividad desde su origen: RCM, estándar corporativo, OEM/vendor, histórico o decisión experta. |
| FL-24 | Ejecutar el control de calidad | Resolver advertencias y errores metodológicos o de datos. |
| FL-25 | Resolver la revisión multidisciplinar | Conservar discrepancias y registrar la resolución. |
| FL-26 | Aprobar y congelar una versión | Registrar autoridades, crear una versión inmutable del plan de proyecto y emitir un output preparado para el handoff operacional. |
| FL-27 | Comparar hipótesis con datos reales | Contrastar P–F, coste, fallos, frecuencias y comportamiento con datos procedentes de la ejecución real cuando estén disponibles. |
| FL-28 | Abrir la mejora continua | Decidir si mantener, ajustar o reabrir el análisis; cuando proceda, proponer aprendizaje para el estándar corporativo sin modificarlo automáticamente. |

## 5. Ruta alternativa — Corporate Standard Adoption

Esta ruta no ejecuta obligatoriamente FL-04..FL-17.

Conceptualmente:

```text
Asset / Equipment Type / context / criticality
→ find Corporate Standard candidate
→ specialist confirms applicability
→ inspect source + version
→ adopt project snapshot
→ disable / adjust / add
→ validate frequency + resources + procedure
→ governance
→ Published Project Maintenance Plan
```

Principios:

- el sistema puede sugerir estándares por `EquipmentTypeCode`;
- la adopción es una decisión humana gobernada;
- una frecuencia del maestro es baseline, no mandato inmutable;
- el proyecto no muta el maestro;
- el aprendizaje del proyecto vuelve mediante change proposal y nueva versión corporativa;
- la ruta puede escalar a RCM específico cuando la criticidad o complejidad lo justifique.

## 6. Estrategias de mantenimiento

El modelo debe representar explícitamente, como mínimo:

```text
TIME_BASED
CONDITION_BASED
RUN_TO_FAILURE
```

Un activo puede combinar estrategias en actividades distintas.

`RUN_TO_FAILURE` es una política explícita y trazable; no significa “sin plan” ni “fuera del CMMS”.

## 7. Granularidad actividad vs procedimiento

Regla confirmada 2026-09-11:

```text
Maintenance Activity        = unidad planificable / programable / cerrable
Job Plan                    = template reusable de ejecución
Procedure / Checklist       = detalle operativo paso a paso
```

La frontera física `JobPlan ↔ ProcedureChecklist` permanece `to_validate`, pero los pasos del checklist no deben convertirse por defecto en actividades CMMS independientes.

## 8. Agrupación inicial en workspaces — RCM case

La hipótesis de UI mantiene las 28 etapas RCM en nueve workspaces.

| Workspace | Etapas | Objetivo |
|---|---|---|
| WS-01 Caso y contexto | FL-01 a FL-03 | Entender qué se analiza y con qué evidencia. |
| WS-02 Funciones y fallos | FL-04 a FL-06 | Definir funciones, fallos y modos como parte del análisis RCM. |
| WS-03 Efectos y riesgo | FL-07 a FL-11 | Aplicar perfil de riesgo, describir consecuencias y establecer prioridad. |
| WS-04 Decisión RCM | FL-12 a FL-16 | Recorrer el árbol lógico RCM y emitir una política defendible sin scoring. |
| WS-05 Economía y tarea | FL-17 a FL-19 | Convertir la política en una actividad con origen e intervalo justificables. |
| WS-06 Recursos y alcance | FL-20 a FL-22 | Preparar recursos, Job Plan/procedimiento, agrupaciones, aplicabilidad y variantes. |
| WS-07 Trazabilidad y calidad | FL-23 a FL-24 | Comprobar integridad antes de aprobación. |
| WS-08 Revisión y publicación | FL-25 a FL-26 | Resolver posiciones, congelar versión y preparar handoff operacional. |
| WS-09 Efectividad y mejora | FL-27 a FL-28 | Contrastar hipótesis y abrir nueva revisión/aprendizaje. |

La Maintenance Standards Library no se añade automáticamente como un décimo workspace del caso P-101. Es una capacidad reusable cuya superficie UX debe decidirse por separado.

## 9. Clasificación de responsabilidad

Cada elemento utilizará, según aplique:

| Tipo | Significado |
|---|---|
| `existing_input` | Información disponible desde otro proceso, estándar o fuente. |
| `user_input` | Dato que una persona introduce, corrige o completa. |
| `system_calculation` | Resultado determinista obtenido mediante fórmula/regla definida. |
| `system_recommendation` | Propuesta automática revisable por una persona. |
| `human_decision` | Decisión con responsable humano y trazabilidad. |
| `gate` | Condición que debe cumplirse antes de continuar. |
| `output` | Resultado consumido por etapa o módulo posterior. |

## 10. Principios de avance

1. El usuario puede retroceder sin perder el estado del caso.
2. Un gate bloqueado debe explicar exactamente qué falta.
3. Un cálculo automático debe mostrar inputs y regla.
4. Una recomendación debe diferenciarse de una decisión confirmada.
5. Un override debe conservar baseline, decisión final y motivo.
6. La etapa siguiente consume outputs estructurados, no textos de pantalla.
7. El laboratorio puede mostrar etapas `to_validate` sin fingir aprobación.
8. Ninguna UI debe hardcodear una matriz 5×5.
9. RCM se representa como lógica de ramas, nunca como scoring acumulado.
10. Taxonomía/Equipment Type puede sugerir applicability/standard, pero no sustituye la decisión humana.
11. Una excepción de proyecto/activo no modifica accidentalmente el plan/estándar base.
12. Toda actividad publicada debe conservar `sourceBasis` y provenance.
13. El runtime no debe asumir que toda actividad procede de RCM.

## 11. Handoff operacional

El tramo suficientemente validado sigue siendo:

```text
Published Project Maintenance Plan
→ seleccionar ejercicio / contexto presupuestario
→ acción explícita: preparar/generar preventivas del año
```

Después:

```text
Scheduled Maintenance Activity
→ Work Candidate / Work Order
   └── references Job Plan / Procedure Checklist
→ planificación / programación
→ asignación
→ ejecución / feedback
→ coste real
```

El detalle de Work Management continúa gobernado por `work-management-discovery.md`.

## 12. Relación con documentación funcional

Cada etapa o estándar validado debe poder trazarse a:

- requisito funcional;
- regla de negocio;
- entidad o atributo conceptual;
- rol / responsabilidad;
- fuente/provenance;
- versión del estándar/configuración;
- especificación de workspace/superficie;
- decisión humano/sistema;
- integración o dato externo;
- pregunta abierta.

El objetivo es que Functional Lab sea fuente de descubrimiento y evidencia, no documentación paralela.
