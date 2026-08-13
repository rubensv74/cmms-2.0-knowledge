# ADR-006 — Autoridad humana separada de cálculo y recomendación

**Estado:** Aprobado  
**Fecha:** 2026-08-10

## Decisión

La aplicación distingue permanentemente:

- información existente;
- input humano;
- cálculo del sistema;
- recomendación del sistema;
- decisión humana;
- gate;
- output.

Un cálculo no sustituye una decisión. Una recomendación no se considera confirmada hasta que la persona con autoridad actúa.

Cuando la persona modifica una recomendación se conserva:

```text
SystemRecommendation
HumanDecision
DecisionReason
ActorRole
Timestamp
```

## Consecuencias

- Se crea un patrón visual reusable `cmp_FL_DecisionPanelPro`.
- Los gates explican qué falta y qué rol puede resolverlo.
- Una automatización futura solo puede asumir autoridad si se aprueba expresamente mediante una decisión posterior.
