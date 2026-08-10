# ADR-005 — Borrador automático y confirmación explícita

**Estado:** Aprobado  
**Fecha:** 2026-08-10

## Decisión

Los cambios ordinarios de trabajo se tratan como borrador. Las decisiones con autoridad, aprobaciones, overrides y congelación de versiones requieren acción explícita del usuario.

Patrón:

```text
edición ordinaria → Draft
confirmar decisión → Confirmed
aprobar → Approved
congelar versión → Frozen/Snapshot
```

## Consecuencias

- Se evita un botón `Guardar` genérico como semántica principal.
- La UI debe mostrar el estado Draft cuando existan cambios no confirmados.
- Confirmar/Aprobar registra actor, rol, timestamp, motivo cuando aplique y snapshot de inputs relevantes.
- En el laboratorio la persistencia puede ser local; el contrato se diseña como si fuera remoto.
