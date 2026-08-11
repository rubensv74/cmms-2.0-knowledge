# CMMS 2.0 Functional Lab — Guía de experiencia funcional alineada

**Estado:** canónica tras auditoría de las últimas reuniones  
**Fecha:** 2026-08-11  
**Caso de referencia:** P-101 · Bomba centrífuga de agua de refrigeración

## 1. Para qué sirve esta guía

Esta guía explica cómo debe vivirse el Functional Lab desde el punto de vista del negocio.

No describe Power Apps. Describe qué objeto se está viendo, de dónde viene la información, qué aporta la persona, qué calcula o recomienda el software, qué decisión sigue siendo humana, qué resultado queda preparado para continuar y qué debemos comprobar para considerar correcta cada pantalla.

La idea que protege toda la experiencia es esta:

> **La ingeniería AMEF/RCM no nace en P-101. Existe como conocimiento reutilizable por familia de equipo y después se aplica a P-101 utilizando su contexto real de planta.**

## 2. El recorrido completo

```text
Biblioteca AMEF
→ revisión aprobada
→ activo y criticidad de planta
→ aplicación de la revisión al activo
→ AnalysisCase
→ funciones/fallos/modos aplicables
→ riesgo AMEF
→ decisión RCM
→ tarea ejecutable
→ recursos/procedimiento/intervalo
→ agrupación y plan
→ Job Plan / PM / WO
→ resultados y coste real
→ efectividad
→ mejora de la aplicación o de la biblioteca
```

Esto corrige el enfoque anterior donde parecía que P-101 era propietario de las funciones, fallos y modos.

## 3. Tipos de información

### Dato maestro o de referencia

Ya existe fuera del análisis: activo, FLH, taxonomía, ADR, documentos, criticidad aprobada, histórico, etc.

### Ingeniería reutilizable

Pertenece a una revisión AMEF: funciones, fallos funcionales, modos, causas, efectos y tareas propuestas.

### Información contextual

Explica cómo se aplica esa ingeniería a un activo concreto: servicio, redundancia, criticidad, frecuencia, exclusiones y overrides.

### Cálculo o recomendación del sistema

El software puede calcular, comprobar reglas y proponer opciones. Debe explicar cómo llega al resultado.

### Decisión humana

Cuando hay autoridad, aceptación de riesgo, selección de estrategia, override o aprobación, debe quedar registrada la decisión humana.

## 4. Activos

### Inicio

**Propósito:** mostrar trabajo, revisiones AMEF, aplicaciones y casos abiertos.  
**Humano:** elige qué revisar.  
**Software:** consolida estado y accesos.  
**Verificación:** P-101 debe aparecer como una aplicación/caso, no como propietario del AMEF.

### Árbol FLH

**Pregunta:** ¿dónde está el activo?  
FLH representa una jerarquía padre-hijo de planta. Debe soportar profundidad variable.  
**Output:** `TechnicalObject` + `AssetHierarchyNode`.

### Taxonomía

**Pregunta:** ¿qué tipo de equipo es?  
La taxonomía relaciona P-101 con la familia `Bomba centrífuga`, que posteriormente sirve para localizar conocimiento AMEF reutilizable.

### ADR

**Pregunta:** ¿con qué objetos se relaciona?  
ADR persiste relaciones `origen → tipo de relación → destino`. El árbol es solo una representación navegable.

### Criticidad del activo

**Pregunta:** ¿qué importancia tiene P-101 dentro de esta planta y este servicio?  
Puede considerar producción, seguridad, medioambiente, redundancia y servicio.

```text
AssetCriticalityAssessment ≠ RiskAssessment AMEF
```

La criticidad de P-101 no se obtiene multiplicando S×O ni S×O×D.

### Ficha 360

Consolida identidad, FLH, taxonomía, ADR, criticidad, revisión AMEF aplicada, casos y planes relacionados. No crea una segunda copia del maestro.

## 5. Biblioteca de ingeniería AMEF

### Biblioteca AMEF

**Propósito:** localizar conocimiento reutilizable por familia de equipo.

Ejemplos del laboratorio: bomba centrífuga, compresor centrífugo y compresor reciprocante.

### Revisión AMEF

Una revisión contiene:

```text
funciones
→ fallos funcionales
→ modos
→ causas / mecanismos
→ efectos
→ tareas propuestas
```

Una revisión aprobada puede quedar congelada. Las mejoras deben generar una nueva revisión.

### Causa / mecanismo

```text
fallo funcional   capacidad perdida
modo de fallo     forma en que se produce
causa/mecanismo   condición o mecanismo que origina el modo
efecto            qué ocurre como consecuencia
```

### Tareas propuestas y cobertura

Una tarea puede cubrir varios modos y un modo puede necesitar varias tareas:

```text
ProposedMaintenanceTask ↔ FailureMode = N:M
```

Una tarea propuesta todavía no es un Job Plan ni una orden de trabajo.

## 6. Aplicación de AMEF a activos

Una misma revisión puede aplicarse a distintos activos sin duplicar la ingeniería:

```text
AMEF-BOMBA-CENTRIFUGA / R01
  ├─ P-101 · criticidad Alta
  ├─ P-102 · criticidad Media
  └─ P-103 · criticidad Baja
```

Los perfiles permiten ajustar aplicabilidad, frecuencia o tratamiento según contexto. En el laboratorio usamos `HIGH`, `MEDIUM`, `LOW`, `NEGLIGIBLE` como nombres demostrativos, no como taxonomía corporativa aprobada.

Un override debe registrar qué se cambia, respecto a qué revisión/perfil, motivo y responsable. No se debe clonar un AMEF completo solo para cambiar una frecuencia.

## 7. AnalysisCase y 28 etapas

`AnalysisCase` organiza una revisión contextual del activo y debe referenciar:

```text
TechnicalObject
FmeaRevision
FmeaAssetApplication
AssetCriticalityAssessment
```

Las 28 etapas siguen visibles mediante Process Rail.

- **FL-01..03:** confirman activo, límites, contexto, aplicabilidad y evidencia.
- **FL-04..05:** revisan funciones/fallos heredados; solo se registra override si el contexto lo justifica.
- **FL-06:** confirma modos y causas aplicables.

## 8. AMEF — FL-07..11

Puede existir un efecto base heredado de biblioteca y una contextualización para P-101.

El software puede recomendar una consecuencia, pero la autoridad final sigue siendo humana cuando así lo requiera el modelo.

Para P-101:

```text
Severidad   1..5
Ocurrencia  1..5
Detección   1..5
```

### Matriz de riesgo AMEF

```text
Severidad × Ocurrencia
```

La matriz 5×5 representa el riesgo del modo de fallo según esa configuración. **Nunca debe denominarse criticidad del activo.**

### NPR

```text
NPR = S × O × D
```

El software lo calcula automáticamente. P-101 inicia en `S=4`, `O=3`, `D=3`, `S×O=12`, `NPR=36`.

Los umbrales de bandas de color son demostrativos hasta validación corporativa.

## 9. RCM — FL-12..16

La experiencia guía preguntas RCM, pero el árbol no debe estar codificado permanentemente en la pantalla.

```text
DecisionLogic
→ DecisionLogicRevision
→ DecisionQuestion
→ DecisionTransition
→ RcmAssessment
→ RcmAssessmentAnswer
```

El árbol concreto y su correspondencia corporativa siguen pendientes de validar.

El sistema puede calcular o recomendar una política; la persona responsable acepta, rechaza o hace override con motivo.

## 10. Economía — FL-17

Se separan tres capas:

- `EconomicAssessment`: comparación de alternativas técnicamente válidas.
- `MaintenanceCostEstimate`: coste derivado de tarea, frecuencia, recursos y duración.
- `ActualMaintenanceCost`: coste procedente de la ejecución real.

Una alternativa barata no hace válida una política técnicamente inaceptable.

## 11. Tarea e intervalo — FL-18..19

La pantalla distingue:

```text
ProposedMaintenanceTask  biblioteca
TaskProfileVariant       ajuste por activo/perfil
MaintenanceTask          tarea ejecutable
```

Una tarea ejecutable incluye cuando aplique técnica, criterio de aceptación, acción si falla, intervalo, estado operativo requerido, parada, aislamiento, permiso, duración, cuadrilla, H-H, disciplina y work center.

### Procedimiento

No toda tarea necesita procedimiento:

```text
MaintenanceTask
  └─ TaskProcedureLink? → MaintenanceProcedure / Checklist / InspectionFormat
```

La ausencia de procedimiento es válida cuando así se haya definido.

## 12. Paquete de plan — FL-20..22

`PlanScopeItem` mantiene cada `TechnicalObjectId` incluido aunque varios objetos se agrupen.

La agrupación debe considerar duración, cuadrilla, H-H, disciplina y restricciones. Puede usar criterios como frecuencia, actividad, planta, ejecutor o localización.

El objetivo es reducir proliferación de rutas/planes sin perder trazabilidad por tag.

## 13. Handoff a planes y ejecución

```text
MaintenanceTask
≠ MaintenanceProcedure
≠ JobPlan / Route
≠ PreventiveMaintenancePlan
≠ WorkOrder
```

Cadena:

```text
MaintenanceTask
→ JobPlan / Route
→ PreventiveMaintenancePlan
→ WorkOrder
→ ExecutionResult
```

Cada resultado conserva `TechnicalObjectId` incluso cuando varios equipos comparten ruta.

## 14. Trazabilidad y gobierno — FL-23..26

Debe poder reconstruirse:

```text
FmeaRevision
→ FailureMode / FailureCause
→ RCM decision
→ ProposedMaintenanceTask
→ TaskProfileVariant
→ MaintenanceTask
→ Procedure / JobPlan
→ PM
→ WO
→ ExecutionResult
```

Una aprobación congela una versión. Los cambios posteriores deben gestionarse mediante nueva revisión o reapertura controlada.

## 15. Efectividad y mejora — FL-27..28

El software compara hipótesis con fallos, hallazgos, cumplimiento, intervalos, costes y comportamiento real.

La persona decide si mantener, ajustar la aplicación, cambiar el perfil, modificar tarea/intervalo o abrir una mejora de la biblioteca AMEF.

## 16. Criterios funcionales de aceptación

Una pantalla no es correcta si:

- hace que P-101 parezca propietario del AMEF base;
- confunde criticidad de planta con riesgo AMEF;
- duplica ingeniería para cambiar una frecuencia;
- oculta causas/mecanismos;
- fuerza relación 1:1 entre tarea y modo;
- obliga a procedimiento para toda tarea;
- coloca parada/permiso solo a nivel de paquete;
- omite H-H/duración/cuadrilla en tarea ejecutable;
- mezcla coste preliminar, estimado y real;
- codifica permanentemente el árbol RCM;
- agrupa activos perdiendo identidad por tag;
- mezcla Job Plan, PM y WO;
- no permite volver de resultados reales a ingeniería.

## 17. Asuntos todavía por validar

No se presentan como decisiones cerradas:

- escala AMEF corporativa definitiva;
- bandas/umbrales/colores;
- reglas oficiales de criticidad;
- árbol RCM corporativo;
- reglas P–F e intervalo;
- roles y autoridades finales;
- evidencia mínima/confianza;
- sobreclasificación;
- criterios de aprobación;
- KPIs de efectividad;
- reglas corporativas definitivas de agrupación;
- sistema destino e integración;
- arquitectura física de datos.

## 18. Idea final

El modelo debe permitir explicar una tarea hacia atrás:

> “Esta tarea existe porque esta revisión AMEF identifica este modo y estas causas, se aplicó a este activo con esta criticidad y contexto, el RCM justificó esta política, una persona la confirmó, se transformó en una tarea ejecutable, se agrupó sin perder identidad y ahora podemos comprobar con datos reales si funciona.”
