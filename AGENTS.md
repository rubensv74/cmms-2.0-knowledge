# AGENTS.md — CMMS 2.0

## Propósito

Reglas obligatorias para cualquier agente de IA que trabaje en este repositorio.

## Fuentes de verdad

Prioridad:
1. evidencia confirmada en la herramienta real;
2. decisiones funcionales y documentación vigente del modelo;
3. `PROJECT_STATUS.md` y `ROADMAP.md` para estado/gates;
4. arquitectura, contratos y documentación del Functional Lab;
5. implementación/prototipos vigentes;
6. hipótesis del agente.

No presentar hipótesis, mockups o YAML no probado como comportamiento validado.

## Desarrollo incremental

Trabajar en incrementos pequeños y verificables:
`analyze → contract/design → implement small → validate real tool → correct → document`.

Avanzar de forma autónoma hasta un gate real. No reabrir decisiones cerradas sin una regresión o nueva evidencia.

## Equipo de agentes IA — PILOT V1

Para cualquier encargo material o transversal, aplicar automáticamente:

- `00-governance/ai/CMMS_AGENT_REGISTRY_V1.yaml`;
- `00-governance/ai/prompts/RUN_ENGINEERING_ORCHESTRATOR.md`.

El usuario no tiene que elegir qué agente usar.

El Orchestrator debe:

1. resolver primero el contexto real del repositorio;
2. seleccionar el conjunto mínimo de especialistas;
3. usar Execution Governor cuando el encargo pueda abrir/reactivar WIP material;
4. separar construcción de revisión adversarial;
5. integrar una única propuesta coherente;
6. continuar autónomamente hasta un gate real;
7. explicar el resultado de forma sencilla de asimilar.

No activar todos los agentes por defecto. Un agente solo se invoca cuando es probable que cambie el diseño, la decisión, la implementación o la validación.

Los contratos transversales del equipo viven en `rubensv74/functional-engineering-knowledge-base`; este repositorio conserva únicamente la configuración y las reglas específicas de CMMS 2.0.

## Gobernanza premium de pantallas — OBLIGATORIA

Toda pantalla/workspace nuevo o modificado debe consultar:
- `06-ui-ux/functional-lab/design-system.md`;
- `06-ui-ux/functional-lab/architecture.md`;
- `06-ui-ux/CMMS_PREMIUM_SCREEN_STANDARD_V1.md`;
- `06-ui-ux/CMMS_PAGE_HEADER_HIERARCHY_V1.md`;
- `06-ui-ux/CMMS_COMPONENT_CATALOG_V1.md`.

La decisión de componentes sigue:
`REUSE_CMMS → ADAPT_VERIFIED_BASE → EXTEND_SHARED → CREATE_SHARED → LOCAL_ONLY`.

Antes de crear UI, revisar el catálogo CMMS y las referencias verificadas de PULSE/AssetPlan. Si aparece un gap reusable, resolverlo como componente premium compartido con contrato, provenance y gate real. Una pieza local solo es válida cuando la necesidad es deliberadamente específica.

No se considera aprobada una pantalla que duplique localmente una capacidad compartida compatible.

## Catálogo de encargos para IA

Entrada: `00-governance/ai/README.md`.
Guía rápida: `00-governance/ai/CMMS_AI_WORK_CATALOG_QUICK_REFERENCE.md`.

Cuando el usuario invoque una plantilla por nombre, abrir `00-governance/ai/prompts/<PLANTILLA>.md`, resolver las referencias aplicables y continuar desde el estado real del repositorio.

## Gates de Power Apps

`render/import` no equivale a `VALIDATED`. Cuando exista implementación real, la validación exige como mínimo render, save, close, reopen, smoke test relevante y App Checker cuando corresponda.

Mientras la Foundation siga sin baseline real, geometrías/controles dependientes de Studio deben permanecer `TO_VALIDATE`.
