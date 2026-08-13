# ADR-012 — Separar criticidad del activo y riesgo AMEF

**Estado:** accepted  
**Fecha:** 2026-08-10  
**Origen:** auditoría de alineación con las últimas reuniones.

## Contexto

La versión anterior utilizaba en AMEF una matriz S×O denominada visualmente `Matriz de criticidad`. Las reuniones confirmaron que son dos análisis distintos.

## Decisión

Mantener dos conceptos separados:

```text
AssetCriticalityAssessment
- evalúa al activo dentro de su contexto de planta
- considera servicio, producción, redundancia, seguridad, medioambiente y contexto
- puede producir un perfil Alta / Media / Baja / Despreciable u otro esquema corporativo

RiskAssessment (AMEF)
- evalúa un modo de fallo dentro de una aplicación AMEF
- utiliza S/O/D o la escala AMEF configurada
- puede mostrar matriz S×O y NPR
```

La criticidad del activo es un **input contextual** para la aplicación del AMEF y puede modificar aplicabilidad, frecuencia, prioridad o tratamiento. No se calcula a partir de NPR ni se sustituye por la matriz S×O.

## Reglas UI

- no usar `Matriz de criticidad` para S×O del AMEF;
- utilizar `Matriz de riesgo AMEF`, `Matriz S×O` o equivalente;
- mostrar la criticidad del activo en contexto separado y con su fuente/revisión;
- si una regla de criticidad modifica una tarea o frecuencia, mostrar explícitamente la regla y el override resultante.

## Consecuencias

- se añade `AssetCriticalityAssessment` al dominio;
- `FmeaAssetApplication` referencia la criticidad vigente utilizada;
- los perfiles de aplicación se versionan y no duplican el AMEF base;
- los umbrales AMEF y los umbrales de criticidad corporativa permanecen configurables e independientes.
