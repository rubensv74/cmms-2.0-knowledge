# CMMS 2.0 — Catálogo de encargos para IA

**Estado:** `ACTIVE / PRODUCT-WIDE`.

Permite iniciar trabajo con instrucciones cortas sin depender del contexto de un hilo anterior.

## Engineering Orchestrator — PILOT V1

Para trabajo material o transversal no hace falta que el usuario seleccione una plantilla, un especialista ni un modelo.

La entrada automática es:

- `CMMS_AGENT_REGISTRY_V1.yaml` — agentes disponibles y reglas de routing;
- `CMMS_RUNTIME_ROUTING_V1.yaml` — selección de fuente, profundidad de razonamiento, ejecución y modalidad;
- `prompts/RUN_ENGINEERING_ORCHESTRATOR.md` — procedimiento de coordinación.

Flujo esperado:

```text
petición natural
→ contexto real
→ WIP/gates cuando aplique
→ conjunto mínimo de agentes
→ runtime/model/tool adecuado
→ ejecución por dependencias
→ revisión adversarial
→ gate humano solo si es real
```

Principio de routing:

```text
usar la capacidad más sencilla que pueda completar bien la tarea
→ escalar solo cuando haga falta
→ volver a un modo más sencillo después de cerrar la parte compleja
```

La preferencia tecnológica local es `Power Apps + Power Automate + SQL`, manteniendo `POWER_APPS_FIRST`, no `POWER_APPS_ONLY`.

El objetivo es que el usuario dirija el producto, no los prompts, la topología de agentes ni la selección de modelos.

Los contratos reutilizables del sistema viven en `rubensv74/functional-engineering-knowledge-base`. CMMS mantiene únicamente su configuración local.

## Plantillas específicas

Antes de ejecutar una plantilla solicitada explícitamente:
1. leer `AGENTS.md`, `PROJECT_STATUS.md` y la plantilla solicitada;
2. revisar documentación funcional/arquitectura/implementación real aplicable;
3. distinguir `validated`, `to_validate`, discovery e hipótesis;
4. para UI cargar Premium Screen Standard, Page Header Hierarchy y Component Catalog;
5. avanzar autónomamente hasta un gate real;
6. no fingir validación de Studio.

Guía rápida: `00-governance/ai/CMMS_AI_WORK_CATALOG_QUICK_REFERENCE.md`.

Regla UI: `REUSE_CMMS → ADAPT_VERIFIED_BASE → EXTEND_SHARED → CREATE_SHARED → LOCAL_ONLY`.
