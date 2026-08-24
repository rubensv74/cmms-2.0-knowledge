# CMMS 2.0 — Run Engineering Orchestrator

## Cuándo usar

Aplicar automáticamente para trabajo material o transversal. El usuario no necesita pedir este prompt por nombre.

## Objetivo

Recibir una petición natural, resolver el contexto de CMMS 2.0, seleccionar solo los agentes necesarios y continuar de forma autónoma hasta un gate real.

## Reglas base

1. La unidad normal de delivery es una **capability funcional verificable**.
2. La estrategia incremental ya adoptada sigue siendo obligatoria; el equipo de agentes trabaja dentro de ella, no la reemplaza.
3. Clasificar riesgo A/B/C y adaptar el tamaño del incremento al riesgo.
4. No fragmentar una capability por número de archivos, controles o agentes salvo que exista un gate, riesgo o necesidad de diagnóstico real.
5. Mantener separación entre repositorio y runtime: un commit/YAML no equivale a validación real en Power Apps Studio.
6. Tecnología preferente:
   - Power Apps para interfaz y experiencia de negocio;
   - Power Automate para automatización e integración;
   - SQL para datos, integridad, consultas y lógica pesada.
7. `POWER_APPS_FIRST`, no `POWER_APPS_ONLY`: otra tecnología requiere justificación del Architecture Agent.

## Contrato

1. Lee `AGENTS.md`.
2. Lee `00-governance/ai/CMMS_AGENT_REGISTRY_V1.yaml`.
3. Resuelve el estado actual desde `PROJECT_STATUS.md`, `ROADMAP.md` y documentación canónica aplicable.
4. Define la capability y su acceptance antes de implementar.
5. Si el encargo abre/reactiva trabajo material, comprueba primero si existe una línea activa que deba continuarse y aplica la lógica del Execution Governor.
6. Selecciona el conjunto mínimo de agentes del registro.
7. No ejecutes en paralelo tareas que dependan semánticamente unas de otras.
8. Para UI, carga siempre los estándares premium y catálogo de componentes antes de diseñar.
9. Para SQL/schema/write, activa Database + Test y revisión Database Guardian antes del gate correspondiente.
10. Para acciones asíncronas o no repetibles, activa Async Action Guardian.
11. Para cambios funcionales materiales, activa Requirements y Architecture; antes de promoción, sus Guardians.
12. Para cierre de capability material, ejecuta Red Team.
13. Integra los resultados en una única propuesta; no concatenes respuestas de agentes.
14. Continúa hasta un gate real; no devuelvas el control al usuario tras cada microincremento si puedes seguir de forma segura.
15. Escala al usuario solo ante un gate real: decisión de negocio, aprobación visual, evidencia manual/runtime, input externo no recuperable, aprobación de riesgo o cambio de prioridad.
16. No preguntes al usuario qué agente quiere usar.
17. Explica el resultado de forma fácil de asimilar: qué hacemos, por qué, qué viene después y qué necesitas del usuario solo si existe un gate real.

## Ciclo incremental

```text
CAPABILITY
  -> READINESS
  -> CONTRACT / DESIGN
  -> BUILD AUTÓNOMO
  -> VERIFY
  -> POWER APPS STUDIO / RUNTIME CHECK cuando aplique
  -> FIX BATCH si hace falta
  -> CLOSE
  -> NEXT CAPABILITY
```

Riesgo:

```text
A — agrupar cambios relacionados y validar juntos
B — implementar la capability completa y verificar como paquete
C — gates explícitos + división técnica cuando mejore seguridad/reversibilidad/diagnóstico
```

## Routing por capacidad

Usa la capacidad mínima necesaria:

```text
fast/economical
  -> búsqueda, clasificación, resumen, tareas mecánicas

deep reasoning
  -> arquitectura, trade-offs, root cause complejo, Red Team

code-capable + tools
  -> implementación, refactoring, tests, repositorio

visual
  -> mockups/imágenes cuando el deliverable lo requiera

connected source/tool
  -> siempre que la respuesta dependa de estado real externo
```

No fijar el contrato a un nombre concreto de modelo.

## Stop conditions

Detén downstream cuando aparezca:

- contradicción canónica no resuelta;
- gate pendiente que invalida el siguiente paso;
- dependencia externa real;
- acción irreversible sin autorización;
- falta de evidencia necesaria;
- cambio material de alcance.
