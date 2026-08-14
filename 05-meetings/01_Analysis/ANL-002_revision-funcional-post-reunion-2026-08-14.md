# ANL-002 — Revisión funcional posterior a la reunión 2026-08-14

**Fecha:** 2026-08-14  
**Estado:** consolidado para actualizar el modelo conceptual; procesos operacionales posteriores permanecen `to_validate`.  
**Fuente principal:** [`../2026/2026-08-14_revision-modelo-conceptual-amef-rcm.md`](../2026/2026-08-14_revision-modelo-conceptual-amef-rcm.md)

## 1. Objetivo

Traducir los comentarios de la reunión del 14 de agosto en cambios concretos del modelo funcional de CMMS 2.0 y del CMMS 2.0 Functional Lab, sin convertir aspectos todavía no estudiados en requisitos cerrados.

## 2. Conclusión principal

La foundation actual es válida, pero contiene varias simplificaciones que deben corregirse **antes de implementar los workspaces de riesgo, RCM y plan**:

- la matriz de riesgo no puede modelarse como una 5×5 fija;
- RCM no debe representarse como un cuestionario con scoring;
- el plan no puede entenderse únicamente como tareas ligadas al activo analizado: debe soportar aplicabilidad a activos equivalentes y excepciones por activo;
- la publicación del plan no es el final del ciclo funcional: existe un handoff posterior hacia generación anual de órdenes preventivas;
- planificación, programación, ejecución, costes y facturación forman parte del modelo objetivo, pero todavía no están suficientemente definidos para incorporarlos como flujo validado del Functional Lab.

## 3. Matriz de impacto

| Hallazgo de la reunión | Impacto en el modelo | Impacto en Functional Lab | Estado |
|---|---|---|---|
| Matriz de riesgo configurable | Sustituir la asunción de matriz fija por un `RiskProfile` por proyecto/cliente | La UI de WS-03 debe renderizar la matriz desde configuración | Confirmado conceptualmente; reglas exactas `to_validate` |
| Severidad debe representar rangos propios del negocio | El perfil de riesgo debe versionar niveles y rangos | P-101 debe ser un ejemplo de perfil, no el estándar del producto | Confirmado |
| RCM no usa puntuación | FL-12..FL-16 deben modelar un árbol lógico de ramas | WS-04 no debe mostrar score acumulado | Confirmado |
| Factibilidad técnica y efectividad gobiernan la decisión | Las preguntas deben conservar criterios y evidencia | Cada rama RCM debe explicar por qué una política es válida/no válida | Confirmado |
| Manual del fabricante y experiencia intervienen en la tarea/frecuencia | Añadir fuentes de justificación de tarea e intervalo | WS-05 debe mostrar base de la frecuencia | Confirmado |
| Recursos incluyen ejecutor, cantidad, HH y parada | Completar atributos de tarea/plan | WS-06 debe permitir validar esos atributos | Confirmado |
| Actividades compatibles se agrupan | Introducir concepto de paquete/grupo de ejecución | Mostrar agrupación por frecuencia/activo y recursos | Principio confirmado; algoritmo exacto `to_validate` |
| La taxonomía sugiere activos equivalentes | Separar `candidateAssets` de `applicabilityDecision` | WS-06 debe mostrar sugerencia del sistema y decisión humana | Confirmado |
| Un activo puede tener excepciones | Introducir `AssetPlanOverride` | Permitir añadir/quitar/modificar tareas para un activo sin mutar el plan genérico | Confirmado |
| Plan aprobado pasa a órdenes preventivas | Añadir output explícito de publicación hacia capa operacional | Mostrar handoff simulado al final de WS-08 | Confirmado |
| Preventivas se generan año a año | No pregenerar vida útil completa; generación por ejercicio y acción explícita | El handoff debe mostrar año, plan vigente y contexto presupuestario | Confirmado conceptualmente |
| WO → planning/scheduling → ejecución → coste | Crear extensión operacional del modelo objetivo | No implementar aún como workspaces funcionales validados | Abierto |
| Coste/contrato/facturación | Requiere modelo contractual/económico e integración | No simular reglas de facturación | Abierto; requiere Contratos/Subcontratos |

## 4. Cambios que deben hacerse ahora

### 4.1. Functional Journey

Mantener los identificadores actuales para no romper contratos, pero revisar el contenido de estas etapas:

- **FL-09:** aplicar el perfil de riesgo del proyecto, no una matriz fija.
- **FL-12 a FL-16:** declarar explícitamente que el recorrido RCM es un árbol lógico y no scoring.
- **FL-18/FL-19:** incluir manual del fabricante, histórico y experiencia como posibles evidencias para tarea e intervalo.
- **FL-20:** incluir ejecutor/especialidad, cantidad de ejecutores, horas-hombre y parada.
- **FL-21:** separar plan genérico, candidatos de aplicabilidad, decisión humana y override por activo.
- **FL-22:** validar coherencia del paquete y agrupación antes de gobernanza.
- **FL-26:** emitir un output de plan publicado listo para el handoff operacional.

No se renumeran todavía FL-27/FL-28. La capa operacional se documenta como extensión posterior para evitar declarar validado un proceso que todavía necesita trabajo.

### 4.2. Persona vs Sistema

Ajustes de responsabilidad:

- configuración del perfil de riesgo: humana/configurable; cálculo de posición de riesgo: sistema;
- recorrido por el árbol RCM: el sistema deriva la rama desde respuestas; la respuesta, evidencia y aceptación de la política deben quedar bajo autoridad humana según rol;
- búsqueda de activos equivalentes: recomendación del sistema;
- aplicabilidad: decisión humana;
- override específico del activo: decisión humana trazada;
- generación anual de órdenes: acción explícita, no automatismo silencioso.

### 4.3. Caso P-101

P-101 debe demostrar los conceptos sin convertirlos en estándar:

- declarar el perfil de riesgo utilizado por el caso;
- declarar que RCM utiliza árbol lógico sin puntuación;
- registrar fuentes que justifican tarea e intervalo;
- registrar política de aplicabilidad y overrides;
- registrar el output de publicación y el handoff conceptual hacia órdenes preventivas anuales.

### 4.4. Arquitectura del Functional Lab

El runtime state debe poder representar desde Foundation:

```text
CaseFixture
+ ConfigurationProfile
+ UserChanges
+ SystemCalculations
+ SystemRecommendations
+ HumanDecisions
+ ApplicabilityDecisions
+ AssetPlanOverrides
+ GateResults
= ActiveCaseState
```

No es necesario implementar ahora todos esos objetos en UI, pero la foundation no debe asumir:

- matriz 5×5;
- un único método de criticidad;
- score RCM;
- una relación 1:1 entre análisis y plan de un solo activo;
- publicación como final absoluto del ciclo.

## 5. Extensión operacional descubierta

La reunión permite dibujar una **frontera funcional candidata** después de la publicación:

```text
Plan publicado vigente
→ seleccionar ejercicio / contexto presupuestario
→ generar paquete anual de órdenes preventivas
→ planificación y programación
→ asignación de ejecutores
→ ejecución y feedback
→ coste real
→ imputación a centro de coste / partida / contrato
→ salida hacia procesos corporativos de coste/facturación
```

### Estado de esta extensión

- `Plan publicado → generación anual`: suficientemente validado para representarlo como handoff conceptual.
- `Planificación/programación`: `to_validate`.
- `Ejecución/feedback`: `to_validate`.
- `Costes`: `to_validate`.
- `Contrato/facturación/integración SAP`: `to_validate` y requiere perfiles adicionales.

## 6. Consecuencia para la demo

El Functional Lab **no debe crecer ahora hacia un mini-CMMS operacional**. Eso sería prematuro y diluiría el objetivo actual.

La demo debe hacer tres cosas nuevas:

1. demostrar configurabilidad y trazabilidad en riesgo/RCM;
2. demostrar cómo un plan común se aplica o personaliza por activo;
3. terminar con un handoff visible: `Plan publicado → preparado para generar órdenes preventivas del ejercicio`, dejando claramente etiquetado que el flujo operacional posterior todavía está pendiente de validación.

## 7. Riesgo evitado

Sin esta revisión, la implementación habría consolidado cuatro errores conceptuales costosos:

- hardcode de matriz 5×5;
- representación falsa de RCM como scoring;
- aplicación automática o rígida de planes equivalentes;
- cierre del journey en la publicación sin preparar la transición hacia ejecución.

Corregirlos ahora, antes de F01 avanzado, reduce retrabajo en datos, reglas, UI y documentación funcional para IT.
