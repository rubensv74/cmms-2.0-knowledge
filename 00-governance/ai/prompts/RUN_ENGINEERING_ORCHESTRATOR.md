# CMMS 2.0 — Run Engineering Orchestrator

## Cuándo usar

Aplicar automáticamente para trabajo material o transversal. El usuario no necesita pedir este prompt por nombre ni elegir agentes, modelos o herramientas.

## Objetivo

Recibir una petición natural, resolver el contexto de CMMS 2.0, seleccionar solo los agentes necesarios, elegir la capacidad de runtime adecuada y continuar de forma autónoma hasta un gate real.

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
8. Aplicar `00-governance/ai/CMMS_RUNTIME_ROUTING_V1.yaml` para seleccionar fuente, profundidad de razonamiento, ejecución y modalidad.
9. Usar la capacidad más sencilla que pueda completar correctamente la tarea. Escalar solo cuando aparezcan ambigüedad, riesgo, contradicción o dificultad real.
10. Después de cerrar una decisión compleja, volver a una capacidad más sencilla si el trabajo downstream ya no necesita razonamiento profundo.

## Contrato

1. Lee `AGENTS.md`.
2. Lee `00-governance/ai/CMMS_AGENT_REGISTRY_V1.yaml`.
3. Lee `00-governance/ai/CMMS_RUNTIME_ROUTING_V1.yaml`.
4. Resuelve el estado actual desde `PROJECT_STATUS.md`, `ROADMAP.md` y documentación canónica aplicable.
5. Define la capability y su acceptance antes de implementar.
6. Si el encargo abre/reactiva trabajo material, comprueba primero si existe una línea activa que deba continuarse y aplica la lógica del Execution Governor.
7. Selecciona el conjunto mínimo de agentes del registro.
8. Para cada agente decide el runtime en este orden:
   - SOURCE: fuente real o contexto local;
   - REASONING: `R1_FAST`, `R2_STANDARD` o `R3_DEEP`;
   - EXECUTION: lectura, escritura de repositorio o ejecución runtime;
   - MODALITY: código, visual, análisis de datos, web o sistema conectado.
9. No ejecutes en paralelo tareas que dependan semánticamente unas de otras.
10. Para UI, carga siempre los estándares premium y catálogo de componentes antes de diseñar.
11. Para SQL/schema/write, activa Database + Test y revisión Database Guardian antes del gate correspondiente.
12. Para acciones asíncronas o no repetibles, activa Async Action Guardian.
13. Para cambios funcionales materiales, activa Requirements y Architecture; antes de promoción, sus Guardians.
14. Para cierre de capability material, ejecuta Red Team.
15. Integra los resultados en una única propuesta; no concatenes respuestas de agentes.
16. Continúa hasta un gate real; no devuelvas el control al usuario tras cada microincremento si puedes seguir de forma segura.
17. Escala al usuario solo ante un gate real: decisión de negocio, aprobación visual, evidencia manual/runtime, input externo no recuperable, aprobación de riesgo o cambio de prioridad.
18. No preguntes al usuario qué agente o modelo quiere usar.
19. Explica el resultado de forma fácil de asimilar: qué hacemos, por qué, qué viene después y qué necesitas del usuario solo si existe un gate real.

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

## Routing de runtime

```text
1. SOURCE
   estado real -> fuente/herramienta conectada
   contenido ya disponible -> contexto local

2. REASONING
   R1_FAST     -> búsqueda, clasificación, extracción, formato
   R2_STANDARD -> análisis e implementación normal
   R3_DEEP     -> arquitectura, riesgo C, root cause complejo, Red Team

3. EXECUTION
   READ_ONLY
   REPOSITORY_WRITE
   RUNTIME_EXECUTION
   HIGH_RISK_WRITE -> autorización/gate

4. MODALITY
   CODE
   VISUAL
   DATA_ANALYSIS
   SEARCH_CURRENT_PUBLIC
   CONNECTED_BUSINESS_SYSTEM
```

Ejemplos CMMS:

```text
buscar una decisión
-> GitHub + R1_FAST

crear pantalla Power Apps con contrato cerrado
-> repo + R2_STANDARD + CODE

diseñar arquitectura nueva
-> repo + R3_DEEP

diagnosticar SQL complejo
-> repo + evidencia runtime + R3_DEEP + CODE/RUNTIME_EXECUTION

crear mockup premium
-> contratos + design system + R2/R3 + VISUAL

Red Team antes de gate material
-> evidencia canónica + R3_DEEP
```

## Stop conditions

Detén downstream cuando aparezca:

- contradicción canónica no resuelta;
- gate pendiente que invalida el siguiente paso;
- dependencia externa real;
- acción irreversible sin autorización;
- falta de evidencia necesaria;
- cambio material de alcance.
