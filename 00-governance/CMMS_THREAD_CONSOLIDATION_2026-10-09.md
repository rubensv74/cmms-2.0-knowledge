# CMMS 2.0 — Consolidación de conversaciones y foco operativo

**Fecha:** 2026-10-09  
**Estado:** RECOMENDACIÓN DOCUMENTADA / PENDIENTE DE APLICAR EN LA INTERFAZ DE CHATGPT  
**Alcance:** organización del trabajo conversacional; **no** representa cierre funcional ni técnico de módulos del producto.

## 1. Objetivo y regla general

Reducir el ruido visual del proyecto App CMMS a **dos hilos operativos ACTIVE**, sin borrar conversaciones, perder fuentes ni fragmentar tareas entre múltiples chats.

- **GitHub** guarda actas, análisis, decisiones, contratos, gates y evidencias.
- **Los hilos** sirven para producir/revisar esos artefactos, no para sustituir el repositorio.
- **CLOSED** significa *objetivo del hilo concluido o absorbido por una línea vigente*; nunca implica que el módulo esté completamente implementado.
- **HOLD** significa *iniciativa conservada y aplazada*, no descartada.
- Los nombres son **propuestas de renombrado**: el repositorio no puede cambiar automáticamente el título/estado de los chats en ChatGPT.

## 2. Hilos concretos identificados en la revisión

> **Inventario parcial:** basado en las cinco conversaciones del proyecto identificables en el contexto de la auditoría, no en un listado exhaustivo verificado de la barra lateral. No clasificar como CLOSED otros hilos que no hayan sido revisados.

| Hilo conocido | Acción propuesta | Nuevo nombre propuesto | Justificación / continuidad |
|---|---|---|---|
| `Notas reunión CMMS 2.0` | **ACTIVE** | `ACTIVE_CMMS — Reuniones y Decisiones` | Transcripciones de Teams, actas, acuerdos, contradicciones y actualización trazable del registro de decisiones |
| `ACTIVE_CMMS — Modelo de Datos SQL y Motor de Mantenimiento` | **ACTIVE** | Sin cambio | Modelo transversal, contratos, SQL, SP, flows, Power Apps y gates runtime; desarrollo técnico prioritario |
| `ACTIVE_CMMS — Maintenance Standards — MSL-G01` | **CLOSED** | `CLOSED_CMMS — Maintenance Standards — MSL-G01/G02` | MSL-G01/G02 cuentan con PASS documentados; MSL-G03/G04 siguen pendientes pero se rastrean en ROADMAP y se ejecutan desde el hilo técnico |
| `Revisar hilos` | **CLOSED** | `CLOSED_CMMS — Revisión y Priorización de Hilos` | La revisión organizativa se centraliza en este documento, evitando otra conversación activa de seguimiento |
| `Nombres para CMMS` | **HOLD** | `HOLD_CMMS — Branding y Naming del Producto` | Naming y marca de producto/ecosistema no aprobados definitivamente; mantener los candidatos como exploración, no alterar branding oficial sin decisión |

**No se han renombrado, eliminado ni archivado hilos en ChatGPT.** La ejecución del cambio de títulos corresponde a la interfaz de conversaciones.

## 3. Contrato operativo entre los dos hilos ACTIVE

### ACTIVE — Reuniones y Decisiones

Entrada: transcripción o notas de la reunión.

Salida mínima:
1. minuta con fecha, participantes conocidos, hechos y cuestiones pendientes (sin inventar acuerdos);
2. decisiones CONFIRMED / OPEN / HOLD / SUPERSEDED, vinculadas a fuente y fecha;
3. impacto sobre Product Truth, contratos, roadmap y pruebas;
4. cambios documentales rastreables en `05-meetings/`, `DECISION_REGISTER.md` y los contratos afectados.

No convertir una interpretación de reunión en modificación SQL o implementación aprobada sin pasar por contratos/gates.

### ACTIVE — Modelo de Datos SQL y Motor de Mantenimiento

Entrada: decisiones confirmadas, contratos técnicos, baseline y evidencias.

Salida mínima:
1. alcance y dependencias;
2. contrato entre interfaz Power Apps → Power Automate → SQL (nombres, parámetros, tipos, payloads y respuestas);
3. implementación aditiva/versionada y control de duplicados, concurrencia e idempotencia;
4. evidencia de gate runtime y actualización de `PROJECT_STATUS.md`, `ROADMAP.md` y `CHANGELOG.md`.

**Próximo gate:** `PA-G01-RUNTIME-MIN`, con `CMMS_CORE_WorkQueue_List` y `CMMS_CORE_WorkOrder_Materialize`. Los gates DB-G01-RUNTIME y SP-G01 constan como PASS en sus expedientes de 2026-10-08; no confundirlos con flows probados.

## 4. Trabajo pendiente que no requiere otro hilo ACTIVE

| Línea | Continuidad | Documento/gate |
|---|---|---|
| Project Standard Adoption y feedback al master | Hilo de modelo de datos al priorizarse | `MSL-G03`, `MSL-G04` |
| Power Automate core | **NEXT** en hilo técnico | `PA-G01-RUNTIME-MIN` |
| Work Management específico de cada proyecto | Contraste con especialistas después del benchmark | `WM-G03` y `WM-G05` (contratos benchmarked; AS-IS local pendiente) |
| Functional Lab y Asset Experience | HOLD en desarrollo runtime/Studio, sin confundir con documentación concluida | `06-ui-ux/functional-lab/implementation-status.md` y gates AE |
| Wizard AMEF | HOLD como UX futura, no como master persistente | `DEC-016` |
| Costes, contratos, compras, facturación y KPI definitivo | Discovery posterior, fuera del núcleo SQL congelado | `WM-G04` / DM-G02 |
| Branding y nombre del ecosistema | HOLD | Hilo de naming; no modificar identidad aprobada sin resolución |

## 5. Condiciones antes de marcar un hilo como CLOSED

1. Su objetivo original tiene resultado verificable o queda absorbido de manera explícita por uno de los dos hilos ACTIVE.
2. Toda decisión con efecto vigente está en `DECISION_REGISTER.md` y toda deuda futura está en `ROADMAP.md` o artefacto de gate.
3. No queda una prueba runtime fallida ni una dependencia técnica oculta presentada como superada.
4. El hilo no se borra: renombrar y, si se desea, archivar **solo después** de comprobar los puntos anteriores.
5. Un hilo no inventariado queda **SIN CLASIFICAR** hasta ser revisado individualmente.

## 6. Fuentes y vigencia

Orden canónico de evidencia: reunión → análisis post-reunión → Product Truth → contrato vigente → gate → implementación probada. Si un gate posterior modifica una hipótesis, registrarlo sin reescribir la transcripción original.

- [Estado actual](../PROJECT_STATUS.md)
- [Roadmap vigente](../ROADMAP.md)
- [Product Truth 2026-10-02 (principios)](CMMS_PRODUCT_TRUTH_BASELINE_V1.md)
- [Decisiones reconciliadas](../05-meetings/decisions/DECISION_REGISTER.md)
- [Índice maestro](../MASTER_INDEX.md)

**Límite de la auditoría:** el repositorio certifica qué está documentado, no la lista íntegra de hilos visibles ni el estado real de Power Apps/Power Automate sin evidencia runtime. Al recibir el inventario completo de títulos del proyecto, ampliar esta tabla antes de renombrar otros hilos.
