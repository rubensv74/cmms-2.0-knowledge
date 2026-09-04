# CMMS 2.0 — Mandatory SQL Concurrency & API Readiness Policy

**Estado:** MANDATORY / ACTIVE FOR NEW DEVELOPMENT  
**Fecha:** 2026-09-04  
**Ámbito:** SQL, Power Automate y contratos backend de CMMS 2.0

---

## 1. Arquitectura actual

```text
Power Apps
    ↓
Power Automate
    ↓
SQL Server
```

No se implementará una API HTTP en esta fase.

La arquitectura deberá permitir una evolución futura hacia:

```text
Power Apps / Web / Mobile / Integrations
              ↓
        Corporate API
              ↓
     Stable backend contracts
              ↓
          SQL Server
```

La futura API no debe exigir reconstruir la UX, reglas de negocio o modelo funcional por haber acoplado la aplicación a tablas físicas o lógica específica de Power Automate.

---

## 2. Principio de autoridad

SQL es la autoridad final de:

- integridad;
- atomicidad;
- invariantes de negocio;
- control de concurrencia;
- prevención de lost updates;
- restricciones estructurales;
- protección idempotente cuando aplique;
- command audit y persistencia transaccional.

Power Apps expresa una intención.  
Power Automate transporta/orquesta esa intención.  
Ninguna de estas capas sustituye las garantías del backend.

No se considera protección suficiente:

- deshabilitar un botón;
- comprobar desde Power Apps que algo no existe antes de insertar;
- confiar en que un Flow no tendrá retry;
- usar solo `Concurrency Control = 1` en un Flow;
- encadenar varios cambios esperando que todos terminen;
- ocultar un command en UI para tratar de garantizar autorización o integridad.

---

## 3. Application Boundary

Schemas iniciales previstos:

```text
cmms        -- domain data
cmms_api    -- stable application boundary
cmms_cfg    -- governed/versioned configuration
cmms_audit  -- command and decision audit
cmms_stage  -- future imports/staging
```

`cmms_api` es una frontera contractual, no una API HTTP existente.

Reglas:

1. Runtime no escribe directamente tablas `cmms` desde Power Apps.
2. Las escrituras operativas se realizan mediante Stored Procedures orientados a intención de negocio.
3. Las lecturas se exponen mediante read models apropiados al caso de uso.
4. La estructura física puede evolucionar sin romper el contrato consumidor cuando la semántica no cambie.
5. Una futura API podrá consumir la misma frontera o adaptarla sin replicar reglas críticas.

---

## 4. Revisión de concurrencia obligatoria

Todo SQL mutable nuevo o modificado debe responder antes de PASS:

1. ¿Pueden dos usuarios/procesos ejecutar la operación al mismo tiempo?
2. ¿Pueden modificar el mismo registro/agregado?
3. ¿Puede producirse un lost update?
4. ¿Puede repetirse la intención por doble clic, retry, timeout o reconexión?
5. ¿Existe una invariante que deba garantizar SQL?
6. ¿La operación afecta a varias entidades que deben confirmar/revertir juntas?
7. ¿Necesita serialización real?
8. Si necesita bloqueo, ¿puede limitarse a Project + agregado/acción?

Una operación mutable sin esta evaluación queda `NO PASS`.

---

## 5. Aislamiento por Project

CMMS 2.0 debe soportar trabajo concurrente multiproyecto.

`ProjectId` será explícito en las entidades y operaciones cuyo dominio pertenezca a un proyecto.

Nunca se aplicará una exclusión global si puede limitarse a:

```text
ProjectId
+ AggregateId
+ Command/Resource
```

Ejemplo conceptual:

```text
MAL
LOCK ApproveReliabilityStudy

MEJOR
LOCK ApproveReliabilityStudy:Project:4103:Study:127
```

---

## 6. Optimistic Concurrency como patrón por defecto

Para entidades mutables expuestas a edición concurrente se evaluará `rowversion` interno y `ConcurrencyToken` contractual opaco.

Patrón:

```text
READ
→ entity + ConcurrencyToken

COMMAND
→ ExpectedConcurrencyToken
→ conditional UPDATE
→ 0 rows affected = CONFLICT
```

Nunca se sobrescribe silenciosamente una modificación posterior a la lectura original.

El consumidor debe recibir un resultado `CONFLICT` y refrescar/reconciliar según el caso de uso.

### Candidatos iniciales a evaluar

No significa que todos deban llevar token, pero deben revisarse expresamente:

- ReliabilityStudy;
- StudyRevision / editable draft;
- StudyScope;
- Function;
- FunctionalFailure;
- FailureMode / FMEA assessment;
- MaintenanceStrategy;
- MaintenanceAction;
- configuration/versioned profiles;
- mutable Asset master data cuando CMMS sea autoridad de ese campo.

`ConcurrencyToken` y `IdempotencyKey` tienen semánticas distintas.

---

## 7. Transacciones para commands compuestos

Toda intención de negocio que deba ser atómica se encapsula en una transacción SQL.

Ejemplos CMMS previsibles:

- Create Reliability Study + initial draft revision;
- change Study Scope + boundary members;
- confirm RCM decision + decision trace;
- create Strategy + Maintenance Actions;
- submit study for review;
- approve/freeze revision;
- publish governed plan/version;
- loader/import commit.

Patrón:

```text
BEGIN TRANSACTION
    validate
    command
    dependent writes
    audit
    invariants
COMMIT
```

Ante error:

```text
ROLLBACK
```

No se simulará una transacción de dominio mediante varios `Patch()` o varias acciones independientes de Flow.

---

## 8. Integridad estructural

Cuando una regla pueda protegerse declarativamente, SQL debe hacerlo.

Mecanismos:

- PK/FK;
- `UNIQUE` constraint / unique index;
- `CHECK` constraints;
- nullability;
- filtered unique index cuando proceda;
- transaction boundary;
- Stored Procedure validation cuando la regla no sea expresable declarativamente.

Ejemplo de antipatrón:

```text
Power Apps
→ SELECT existence
→ if not exists INSERT
```

si dos ejecuciones simultáneas pueden vulnerar la unicidad.

La UI puede anticipar el error por usabilidad, pero SQL sigue siendo la autoridad.

---

## 9. Idempotencia, retry y doble ejecución

Los commands críticos/no repetibles deben evaluar protección idempotente.

Riesgos:

- double click;
- repeated submit;
- Power Automate retry;
- timeout con resultado ambiguo;
- reconnect;
- reintento manual del usuario.

Cuando aplique el contrato transportará:

```text
IdempotencyKey
RequestId / CorrelationId
ExpectedConcurrencyToken
```

Semántica:

- `IdempotencyKey`: identifica la misma intención lógica y evita aplicar dos veces su efecto.
- `RequestId / CorrelationId`: traza la ejecución/cadena.
- `ConcurrencyToken`: evita lost updates sobre una versión obsoleta.

Power Automate debe conservar la misma `IdempotencyKey` durante retries de la misma intención.

El almacenamiento durable y política de replay se definirán con el primer command que lo requiera, no mediante una solución genérica sobredimensionada antes de tener consumer.

---

## 10. Locking y serialización

Pessimistic locking no es el patrón por defecto.

Solo se utilizará cuando una invariante requiera exclusión real, por ejemplo:

- asignación de número/secuencia de negocio;
- transición única de workflow;
- aprobación/freeze irreversible de una revisión;
- elección de una sola versión efectiva/activa;
- generación controlada de un paquete único;
- invariantes que no puedan resolverse de forma suficiente con constraints + optimistic concurrency.

Mecanismos a evaluar según caso:

- `UPDLOCK`;
- `HOLDLOCK`;
- transaction isolation apropiado;
- `sp_getapplock`.

Todo lock tendrá scope mínimo y justificado.

---

## 11. Stored Procedures como commands de negocio

Las escrituras no se expondrán como CRUD libre desde Power Apps/Power Automate.

Ejemplos conceptuales:

```text
cmms_api.usp_ReliabilityStudy_Create
cmms_api.usp_ReliabilityStudyScope_Update
cmms_api.usp_FailureMode_SaveAssessment
cmms_api.usp_RcmDecision_Confirm
cmms_api.usp_MaintenanceStrategy_Save
cmms_api.usp_ReliabilityStudy_SubmitReview
cmms_api.usp_ReliabilityStudy_ApproveRevision
```

Parámetros comunes solo cuando tengan semántica real:

```text
@ProjectId
@ActorEmail / @ActorId
@IdempotencyKey
@RequestId / @CorrelationId
@ExpectedConcurrencyToken
```

Los nombres físicos de tablas no deben filtrarse innecesariamente al consumidor.

---

## 12. Read Models

Las pantallas consumirán read models orientados a su tarea, no el modelo relacional completo.

Ejemplos:

```text
Reliability Studies list
Study header/context
Study scope detail
Functions & Failures tree
FMEA work item
RCM decision context
Maintenance Strategy detail
Review summary
```

El read model puede implementarse mediante View o Stored Procedure según filtros, seguridad, paginación y coste.

Reglas:

- forma estable;
- semántica explícita;
- null no se convierte en dato positivo;
- paginación/orden determinista cuando aplique;
- `ConcurrencyToken` incluido cuando el consumer pueda editar la entidad leída;
- `ProjectId` y autorización funcional no se delegan a un filtro visual.

---

## 13. Identidad y auditoría

La cuenta técnica utilizada por Flow/SQL no es el actor funcional.

Cuando el usuario sea conocido, se transportará y conservará explícitamente.

Campos a evaluar por entidad:

```text
CreatedAt
CreatedBy
ModifiedAt
ModifiedBy
```

Para commands relevantes se registrará además, según necesidad:

```text
CommandName
ProjectId
AggregateType
AggregateId
RequestId
IdempotencyKey
Actor
StartedAt
CompletedAt
OutcomeCode
ErrorCode
```

No se almacenará información sensible innecesaria en el audit payload.

---

## 14. Result Contract

Power Apps no debe inferir outcomes leyendo texto libre o comprobando efectos secundarios.

Los commands deberán distinguir, cuando aplique:

```text
SUCCESS
VALIDATION
PERMISSION_DENIED
CONFLICT
DUPLICATE_REPLAY
NOT_FOUND
ERROR
```

Contrato conceptual mínimo:

```text
OutcomeCode
ErrorCode
Message
EntityId
ConcurrencyToken
RequestId
IsReplay
```

No todos los commands necesitan todos los campos.

`CONFLICT` es un outcome esperado y debe tener tratamiento UX específico.

---

## 15. Preparación para futura API

Queda prohibido introducir acoplamientos nuevos que obliguen a una futura reescritura material.

Por tanto:

- ninguna pantalla depende del nombre de una tabla física;
- ningún Flow debe convertirse en la única ubicación de una regla crítica;
- los commands son intenciones de negocio;
- read/command contracts son versionables;
- identifiers de concurrency/idempotency/correlation son transportables;
- SQL devuelve outcomes contractuales;
- seguridad funcional no depende solo de controles visibles;
- la futura API podrá reutilizar la frontera sin replicar lógica de integridad.

La API futura requerirá una decisión propia sobre auth, authorization, ownership, versioning, observability, deployment y operations.

---

## 16. Connection Identity — Development Decision

Durante el desarrollo actual:

```text
Power Automate
→ existing database user with administrative capability
→ db-omm-dev
```

No se crea un rol `cmms_runtime` ni ningún otro rol CMMS adicional.

Esta decisión es deliberada para el entorno de desarrollo y no bloquea el producto.

Guardrails que siguen siendo obligatorios aunque la cuenta técnica disponga de permisos amplios:

- Power Apps no hace DML directo sobre tablas CMMS;
- Power Automate ejecuta Stored Procedures/read contracts y no contiene las invariantes de negocio;
- SQL conserva la autoridad transaccional y de concurrencia;
- la identidad técnica de conexión no sustituye `ActorEmail`/actor funcional en auditoría;
- los contratos no deben depender de que la cuenta tenga permisos administrativos.

El endurecimiento de permisos de una futura implantación productiva se tratará como decisión de deployment/security y no requiere rediseñar pantallas, contratos ni procedimientos de negocio.

---

## 17. Mandatory SQL Write Gate

Antes de aprobar cualquier command mutable:

```text
[ ] Project scope / ProjectId cuando aplica
[ ] aggregate boundary identificada
[ ] transaction boundary definida
[ ] lost-update risk evaluado
[ ] rowversion / ConcurrencyToken cuando aplica
[ ] retry / duplicate execution evaluado
[ ] IdempotencyKey cuando aplica
[ ] RequestId / CorrelationId cuando aplica
[ ] PK/FK/UNIQUE/CHECK/nullability revisados
[ ] authorization boundary funcional definida cuando aplica
[ ] locking/serialization justificado y mínimo
[ ] actor/audit definido
[ ] result/error/conflict contract definido
[ ] positive test
[ ] negative/invariant test
[ ] concurrent/conflict test o equivalente
[ ] retry/idempotency test cuando aplica
[ ] future API compatibility reviewed
```

Un punto aplicable sin resolver implica `NO PASS`.

---

## 18. Regla de precedencia

Esta política prevalece para todo desarrollo SQL nuevo o modificado posterior a su activación.

Si un documento histórico del Functional Lab dice que backend/API/persistencia están pendientes, debe interpretarse como estado histórico del laboratorio, no como permiso para ignorar esta nueva baseline de desarrollo.
