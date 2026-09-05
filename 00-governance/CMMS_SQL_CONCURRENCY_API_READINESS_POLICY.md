# CMMS 2.0 — Mandatory SQL Concurrency & API Readiness Policy

**Estado:** MANDATORY / ACTIVE FOR NEW DEVELOPMENT  
**Actualizado:** 2026-09-05  
**Ámbito:** SQL, Power Automate y contratos backend de CMMS 2.0

---

## 1. Arquitectura actual

```text
Power Apps
    ↓
Power Automate
    ↓
SQL Server / Azure SQL
    ↓
db-omm-dev
    ↓
cmms
```

No se implementará una API HTTP en esta fase.

La arquitectura deberá permitir una evolución futura hacia:

```text
Power Apps / Web / Mobile / Integrations
              ↓
        Corporate API
              ↓
     stable business contracts
              ↓
          SQL Server
```

La futura API no debe exigir reconstruir UX, reglas de negocio o modelo funcional por haber acoplado la aplicación a tablas físicas o lógica específica de Power Automate.

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
- audit y persistencia transaccional.

Power Apps expresa una intención.  
Power Automate transporta/orquesta esa intención.  
Ninguna de estas capas sustituye las garantías del backend.

No se considera protección suficiente:

- deshabilitar un botón;
- comprobar desde Power Apps que algo no existe antes de insertar;
- confiar en que un Flow no tendrá retry;
- usar solo `Concurrency Control = 1` en un Flow;
- encadenar varios cambios esperando que todos terminen;
- ocultar un command en UI para intentar garantizar integridad.

---

## 3. Schema y application boundary actual

La instrucción vigente de implementación es:

```text
Database = db-omm-dev
CMMS implementation schema = cmms
```

Todos los nuevos business tables, read procedures y command procedures de I01 se publican bajo `cmms`.

Schemas creados durante el bootstrap previo:

```text
cmms
cmms_api
cmms_cfg
cmms_audit
cmms_stage
```

pueden permanecer existentes. I01 no necesita crear nuevos objetos fuera de `cmms`.

La preparación para una API futura **no depende** del nombre del schema. Depende de que:

1. Power Apps no haga DML directo sobre tablas;
2. Power Automate invoque Stored Procedures/read contracts estables;
3. los Stored Procedures expresen intenciones de negocio, no CRUD genérico;
4. SQL conserve invariantes, transacciones y concurrencia;
5. el consumidor no necesite conocer el modelo físico para operar.

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

Ejemplo:

```text
EVITAR
LOCK ApproveReliabilityStudy

PREFERIR
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
→ 0 affected rows because version changed = CONFLICT
```

Nunca se sobrescribe silenciosamente una modificación posterior a la lectura original.

Formato contractual inicial del token:

```text
varchar(18)
0x + 16 hexadecimal characters
```

Candidatos iniciales a evaluar:

- ReliabilityStudy;
- StudyRevision / editable draft;
- StudyScope;
- Function;
- FunctionalFailure;
- FailureMode / FMEA assessment;
- MaintenanceStrategy;
- MaintenanceAction;
- configuration/versioned profiles;
- mutable Asset master data cuando CMMS sea autoridad del campo.

`ConcurrencyToken` y `IdempotencyKey` tienen semánticas distintas.

---

## 7. Transacciones para commands compuestos

Toda intención de negocio que deba ser atómica se encapsula en una transacción SQL.

Ejemplos previsibles:

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

La UI puede anticipar un error por usabilidad, pero SQL sigue siendo la autoridad.

---

## 9. Idempotencia, retry y doble ejecución

Los commands críticos/no repetibles deben evaluar protección idempotente.

Riesgos reales:

- double click;
- repeated submit;
- Power Automate retry;
- timeout con resultado ambiguo;
- reconnect;
- reintento manual del usuario.

Cuando aplique el contrato transportará:

```text
IdempotencyKey
RequestId
ExpectedConcurrencyToken
```

Semántica:

- `IdempotencyKey`: misma intención lógica / mismo efecto;
- `RequestId`: traza la petición/ejecución;
- `ConcurrencyToken`: detecta edición contra versión obsoleta.

Power Automate debe conservar la misma `IdempotencyKey` durante retries de la misma intención.

---

## 10. Locking y serialización

Pessimistic locking no es el patrón por defecto.

Solo se utilizará cuando una invariante requiera exclusión real, por ejemplo:

- asignación de número/secuencia de negocio;
- transición única de workflow;
- aprobación/freeze irreversible;
- una sola versión efectiva/activa;
- generación controlada de un paquete único.

Mecanismos posibles según caso:

- `UPDLOCK`;
- `HOLDLOCK`;
- transaction isolation apropiado;
- `sp_getapplock`.

Todo lock tendrá scope mínimo y justificado.

---

## 11. Stored Procedures como commands de negocio

Las escrituras no se exponen como CRUD libre desde Power Apps/Power Automate.

Ejemplos conceptuales vigentes:

```text
cmms.usp_ReliabilityStudy_Create
cmms.usp_ReliabilityStudyScope_UpdateDraft
cmms.usp_FailureMode_SaveAssessment
cmms.usp_RcmDecision_Confirm
cmms.usp_MaintenanceStrategy_Save
cmms.usp_ReliabilityStudy_SubmitReview
cmms.usp_ReliabilityStudy_ApproveRevision
```

Parámetros comunes solo cuando tienen semántica real:

```text
@ProjectId
@ActorEmail / future @ActorId
@IdempotencyKey
@RequestId
@ExpectedConcurrencyToken
```

Los nombres físicos de tablas no deben filtrarse innecesariamente al consumidor.

---

## 12. Read Models

Las pantallas consumirán read models orientados a su tarea, no el modelo relacional completo.

Primeros consumers:

```text
Project Context
Asset Context
Reliability Studies list
Study header/context
Study Scope detail
```

Posteriormente:

```text
Functions & Failures tree
FMEA work item
RCM decision context
Maintenance Strategy detail
Review summary
```

El read model puede implementarse mediante Stored Procedure o View interna según filtros, paginación y coste, pero Power Automate consume el contrato publicado.

Reglas:

- forma estable;
- semántica explícita;
- null no se convierte en dato positivo;
- paginación/orden determinista cuando aplique;
- `ConcurrencyToken` incluido cuando el consumer pueda editar;
- `ProjectId` no se delega a un filtro visual.

---

## 13. Identidad y auditoría

La cuenta técnica utilizada por Flow/SQL no es el actor funcional.

Durante desarrollo:

```text
SQL connection = existing user tradminomm
Functional actor = ActorEmail from Power Apps
```

Cuando el usuario sea conocido, se transportará y conservará explícitamente.

Campos a evaluar por entidad:

```text
CreatedAtUtc
CreatedBy
ModifiedAtUtc
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
ActorEmail
StartedAtUtc
CompletedAtUtc
OutcomeCode
ErrorCode
```

No se almacenará información sensible innecesaria en audit payloads.

---

## 14. Result Contract

Power Apps no debe inferir outcomes leyendo texto libre.

Vocabulary inicial:

```text
SUCCESS
VALIDATION
PERMISSION_DENIED
CONFLICT
DUPLICATE_REPLAY
NOT_FOUND
ERROR
```

Envelope baseline:

```text
contractVersion
requestId
ok
outcomeCode
message
entityId
concurrencyToken
dataJson
isReplay
generatedAtUtc
```

Para listas podrán añadirse:

```text
count
hasMore
continuationToken
```

`CONFLICT` es un outcome esperado y debe tener tratamiento UX específico.

---

## 15. Preparación para futura API

Queda prohibido introducir acoplamientos nuevos que obliguen a una futura reescritura material.

Por tanto:

- ninguna pantalla depende del nombre de una tabla física;
- ningún Flow es la única ubicación de una regla crítica;
- los commands son intenciones de negocio;
- read/command contracts son versionables;
- concurrency/idempotency/request identifiers son transportables;
- SQL devuelve outcomes contractuales;
- seguridad funcional no depende solo de controles visibles.

Una futura API podrá envolver/reutilizar estas intenciones sin duplicar lógica de integridad.

La API futura tendrá su propia decisión de auth, authorization, ownership, versioning, observability, deployment y operations.

---

## 16. Connection Identity — Development Decision

Durante el desarrollo actual:

```text
Power Automate
→ existing database user: tradminomm
→ db-omm-dev
```

No se crea `cmms_runtime` ni ningún otro rol/principal CMMS adicional.

Guardrails obligatorios aunque la cuenta técnica disponga de permisos amplios:

- Power Apps no hace DML directo sobre tablas CMMS;
- Power Automate ejecuta Stored Procedures/read contracts;
- SQL conserva autoridad transaccional y de concurrencia;
- la identidad técnica no sustituye `ActorEmail`;
- los contratos no dependen funcionalmente de privilegios administrativos.

El endurecimiento de permisos de producción será una decisión de deployment/security sin rediseñar pantallas ni contratos.

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
[ ] RequestId cuando aplica
[ ] PK/FK/UNIQUE/CHECK/nullability revisados
[ ] authorization boundary funcional definida cuando aplica
[ ] locking/serialization justificado y mínimo
[ ] ActorEmail/audit definido
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

Si documentación histórica del Functional Lab contradice esta baseline de ejecución, se considera histórica hasta que se promueva explícitamente al baseline actual.
