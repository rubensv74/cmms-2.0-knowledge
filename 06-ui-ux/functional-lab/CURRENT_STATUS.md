# CMMS 2.0 Functional Lab — Estado actual

**Fecha:** 2026-08-10  
**Rama:** `feature/f01-premium-foundation`  
**Estado:** D-01…D-14 corregidas / `PASS_STATIC` / validación integrada en Power Apps Studio pendiente

Este documento prevalece como resumen de estado cuando algún documento anterior todavía contenga una frase histórica como `revalidación estática pendiente`.

## Resultado de la corrección

Las 14 desviaciones identificadas al contrastar CMMS Functional Lab con las últimas reuniones están corregidas en:

- arquitectura funcional;
- contratos de dominio;
- componentes;
- pantallas Power Apps Source Code;
- runtime/fixture conceptual;
- guía de experiencia funcional;
- guía de demostración;
- instalación y smoke tests.

## Modelo canónico

```text
Biblioteca AMEF
→ FmeaRevision
→ FmeaAssetApplication
→ TechnicalObject + AssetCriticalityAssessment
→ AnalysisCase contextual
→ AMEF / RCM
→ MaintenanceTask / TaskProfileVariant
→ recursos / alcance / agrupación
→ JobPlan / PreventiveMaintenancePlan
→ WorkOrder / ExecutionResult
→ EffectivenessMeasurement
→ ChangeRequest sobre aplicación o nueva revisión de biblioteca
```

## Inventario

```text
Foundation components   9
Canonical screens       25
Journey stages          28
```

## Validación alcanzada

La revisión estática integral posterior a las correcciones ha finalizado con:

```text
PASS_STATIC
```

Se comprobaron:

- parse YAML;
- presencia del inventario canónico;
- destinos `Navigate(...)`;
- referencias `ComponentName`;
- clases de incompatibilidad Power Apps ya conocidas en el proyecto.

Evidencia:

`development/ALIGNED_STATIC_VALIDATION_2026-08-10.md`

`PASS_STATIC` no equivale a `INSTANCE_SAFE` ni a validación visual.

## Próximo gate

El siguiente paso requiere Power Apps Studio y no una nueva decisión de arquitectura:

```text
instalar 9 componentes
→ crear/actualizar 25 pantallas
→ ejecutar 7 smoke tests integrados
→ corregir incidencias de Studio si aparecen
→ Visual QA
```

Guía:

`power-apps/V2_INSTALLATION.md`

## Decisiones deliberadamente abiertas

No se han fijado por defecto:

- escalas AMEF corporativas definitivas;
- bandas, umbrales y colores de riesgo;
- reglas corporativas de criticidad;
- árbol RCM definitivo;
- reglas P–F / intervalo;
- autoridades y permisos finales;
- evidencias mínimas / confianza;
- sobreclasificación;
- criterios de aprobación;
- KPIs/umbrales de efectividad;
- reglas corporativas definitivas de agrupación;
- CMMS destino e integración;
- arquitectura física de datos.

Estas decisiones se abordarán después de validar en Studio el modelo ya corregido.
