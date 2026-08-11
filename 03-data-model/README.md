# CMMS 2.0 — Modelo conceptual de datos

## Propósito

Esta carpeta contiene el modelo conceptual canónico que debe sostener el análisis funcional de CMMS 2.0 sin comprometer todavía una tecnología física de persistencia.

El modelo se utiliza para:

- mantener coherencia entre reuniones, Functional Lab y documentación para IT;
- distinguir objetos de ingeniería reutilizables de su aplicación a activos;
- definir identidades, relaciones y trazabilidad antes de diseñar tablas físicas;
- evitar que una interfaz o fixture de ejemplo se convierta accidentalmente en el modelo de datos.

## Principio rector

```text
Engineering Library
→ Asset Application
→ Execution Plan
→ Results & Learning
```

La primera implementación de este principio se documenta en:

- `core/fmea-library-model.md`
- `core/traceability-layers.md`

## Regla de interpretación

Los nombres de entidades son conceptuales. No presuponen:

- tablas SQL;
- entidades Dataverse;
- endpoints de API;
- colecciones Power Apps;
- microservicios;
- integración productiva.

La transformación al modelo físico corresponderá a una decisión arquitectónica posterior.

## Fuente funcional principal

El modelo consolida y normaliza lo ya definido en:

- `05-meetings/02-Specifications/SPC-001_ESPECIFICACION_CODEX_AMEF_RCM.md`;
- decisiones posteriores de la revisión conceptual;
- auditoría `00-governance/audits/2026-08-11-functional-lab-library-first-remediation.md`.
