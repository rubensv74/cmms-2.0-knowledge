# CMMS 2.0 — Development Baseline 1.0

**Estado:** CANDIDATE / READY FOR DEVELOPMENT GATE  
**Fecha:** 2026-09-04  
**Producto:** CMMS 2.0  
**Idioma de la aplicación:** English  
**Documentación de trabajo:** español, manteniendo nombres técnicos y UI en inglés cuando corresponda.

---

## 1. Propósito

Esta baseline marca la transición desde el **Functional Lab** hacia la construcción de una aplicación CMMS 2.0 real, incremental y ejecutable en Power Apps.

El Functional Lab, los prototipos y la documentación existente no se descartan. Se convierten en fuentes de conocimiento, fixtures, contratos y evidencia funcional para el producto real.

La regla de desarrollo pasa a ser:

```text
functional truth
→ UX contract
→ normalized data contract
→ premium Power Apps increment
→ Studio validation
→ SQL contract
→ thin Power Automate adapter
→ integration validation
→ consolidation
```

No se desarrollará el producto como tres proyectos separados de UI, SQL y Power Automate. La unidad de delivery será una **capability funcional observable**.

---

## 2. Decisiones arquitectónicas vigentes

### 2.1 Arquitectura operativa actual

```text
Power Apps
    ↓
Power Automate
    ↓
SQL Server
```

Power Apps es la experiencia de usuario.  
Power Automate transporta/orquesta la llamada.  
SQL conserva la autoridad sobre integridad, atomicidad, concurrencia, invariantes y persistencia.

### 2.2 API futura

No se implementará una API ahora.

CMMS 2.0 debe quedar preparado para que en el futuro pueda evolucionar hacia:

```text
Power Apps / Web / Mobile / Integrations
              ↓
        Corporate API
              ↓
     Stable backend contracts
              ↓
          SQL Server
```

La API futura debe poder sustituir o complementar la capa de transporte sin obligar a reconstruir pantallas, reglas de negocio o modelo funcional.

Consecuencia obligatoria:

- las pantallas no dependen de tablas físicas;
- los commands expresan intención de negocio;
- los read models se diseñan por caso de uso;
- Power Automate no redefine invariantes;
- SQL expone una frontera estable;
- errores, conflictos e idempotencia se transportan mediante contratos explícitos.

La política obligatoria se define en:

`00-governance/CMMS_SQL_CONCURRENCY_API_READINESS_POLICY.md`

---

## 3. Dirección de producto

CMMS 2.0 se construirá como un producto operacional enterprise, no como una colección de formularios.

Dirección de experiencia:

> **Industrial Operations SaaS + Asset 360 + Reliability Engineering + Maintenance Workspaces + Governed Configuration**

Principios:

1. desktop-first;
2. premium desde el primer incremento;
3. alta densidad con jerarquía clara;
4. trazabilidad visible;
5. recomendaciones del sistema separadas de decisiones humanas;
6. estados no nominales diseñados desde el inicio;
7. configuración versionable cuando una regla no sea universal;
8. ninguna pantalla debe convertirse en la única definición de una regla de negocio.

---

## 4. Navegación funcional inicial

La navegación V1 se construirá solo con capacidades reales.

Dirección inicial:

```text
Home / Overview
Assets
Reliability Engineering
Maintenance
Materials
Reports
Administration
```

No todos los destinos deben aparecer en el primer incremento. Un módulo se incorpora a navegación cuando exista al menos una capability utilizable.

### 4.1 Reliability Engineering

Nombre visible aprobado:

`Reliability Engineering`

No se divide en tres aplicaciones AMEF / RCM / Maintenance Strategy.

El usuario trabaja sobre un **Reliability Study** y avanza por una experiencia continua:

```text
Study Scope
→ Functions & Functional Failures
→ FMEA
→ RCM Decision
→ Maintenance Strategy
→ Review & Approval
→ Implementation / Handoff
```

La unidad raíz del análisis será `ReliabilityStudy / AnalysisScope`, no necesariamente un único Asset.

---

## 5. Arquitectura Power Apps

### 5.1 Shell compartido

La foundation se inspira en el método validado en AssetPlan/TMS:

```text
App Shell
├─ Sidebar
├─ Global / Project Context
├─ User / Environment Context
├─ Page Identity
├─ Workspace Surface
├─ Drawer / Overlay Layer
└─ State / Notification Layer
```

El shell se congela antes de multiplicar pantallas.

### 5.2 Pantallas independientes con experiencia continua

No se implementará Reliability Engineering como una única megapantalla Canvas.

La aplicación utilizará pantallas independientes que comparten shell, study header, navegación de etapas y estado normalizado.

La experiencia debe sentirse continua, pero cada pantalla mantiene una responsabilidad dominante.

### 5.3 Responsabilidades

```text
Canvas Component
→ presentation + semantic event

Screen / Workspace Controller
→ local UI state + selection + navigation + intent

Application Adapter
→ normalize read result / command result

Power Automate
→ transport / orchestration

SQL Contract
→ read model / command / integrity / transaction
```

### 5.4 Estado de superficie mínimo

```text
LOADING
READY
EMPTY
ERROR
PERMISSION_DENIED
CONFLICT
NO_PROJECT
BLOCKED
```

`CONFLICT` es estado de producto, no excepción genérica.

---

## 6. Estrategia premium heredada de AssetPlan

Se adopta para CMMS el aprendizaje principal de AssetPlan:

> una pantalla no se construye primero funcional y se premiumiza después.

Desde su skeleton debe pertenecer al lenguaje visual final.

Secuencia por pantalla:

```text
primary task
→ success criterion
→ interaction archetype
→ component decision
→ skeleton
→ realistic mock
→ interactions
→ loading/empty/error/conflict
→ Studio validation
→ integration
→ visual gate
```

Regla de componentes:

```text
REUSE_CMMS
→ ADAPT_VERIFIED_BASE
→ EXTEND_SHARED
→ CREATE_SHARED
→ LOCAL_ONLY
```

Las referencias AssetPlan/PULSE/TMS se reutilizan por contrato y evidencia, nunca únicamente por parecido visual.

Los componentes tendrán una única identidad lógica en Power Apps. Los sufijos de revisión pertenecen al repositorio, no deben generar componentes paralelos sin necesidad en Studio.

---

## 7. Arquitectura SQL inicial

La estructura física se cerrará incrementalmente, pero la frontera de responsabilidades queda fijada desde el primer DDL.

Schemas previstos:

```text
cmms        -- dominio transaccional
cmms_api    -- frontera estable de read models / commands para consumidores
cmms_cfg    -- configuración gobernada/versionable cuando aplique
cmms_audit  -- command audit / trazabilidad técnica y funcional
cmms_stage  -- cargas e importaciones futuras
```

`cmms_api` no significa que exista una API HTTP. Representa la **application boundary** que hoy consume Power Automate y que mañana puede consumir una API.

Reglas:

- runtime no escribe directamente tablas `cmms`;
- lecturas complejas se exponen mediante read models orientados al caso de uso;
- escrituras operativas usan Stored Procedures orientados a intención;
- constraints e invariantes permanecen en SQL;
- toda operación mutable se revisa por concurrencia;
- toda operación compuesta usa una frontera transaccional explícita;
- actor funcional y correlación se conservan cuando aplique.

---

## 8. Concurrencia desde el primer día

No se añadirá como hardening posterior.

Patrones obligatorios según riesgo:

- `ProjectId` explícito para aislar operaciones project-scoped;
- optimistic concurrency con `rowversion` / `ConcurrencyToken` en entidades mutables expuestas a lost update;
- `UNIQUE`, `FK`, `CHECK` y nullability para integridad estructural;
- transacciones para commands compuestos;
- `IdempotencyKey` para intenciones críticas/reintentables;
- `RequestId / CorrelationId` para trazabilidad;
- `ActorEmail / ActorId` funcional separado de la cuenta técnica SQL;
- bloqueo/serialización solo cuando sea necesario y con scope mínimo;
- resultado contractual explícito para `SUCCESS / VALIDATION / PERMISSION / CONFLICT / DUPLICATE_REPLAY / ERROR`.

La política detallada está en el documento de gobierno SQL obligatorio.

---

## 9. First Vertical Slice

La primera capability tangible será:

> **P-101 Reliability Study Backbone**

Objetivo: demostrar que la arquitectura completa funciona con un caso realista y datos sintéticos sin construir todavía todo CMMS.

Recorrido objetivo:

```text
Open CMMS
→ select/load Project
→ open P-101 Asset context
→ open Reliability Engineering
→ locate/create Reliability Study
→ edit Study Scope
→ save through Power Automate
→ SQL validates + persists
→ receive new ConcurrencyToken
→ reopen/refresh
→ continue to Functions & Failures placeholder
```

Este slice debe demostrar:

1. shell premium real;
2. navegación y contexto de Project/Asset;
3. contrato normalizado de lectura;
4. datos sintéticos alojados en SQL;
5. un command real de escritura seguro;
6. auditoría de actor;
7. optimistic concurrency;
8. idempotencia cuando aplique;
9. error/conflict contract;
10. sustitución futura de transporte sin cambiar la pantalla.

No intentará completar FMEA/RCM/Strategy en el mismo incremento.

---

## 10. Pantallas Reliability Engineering previstas

Secuencia funcional inicial:

```text
RE-01 Reliability Studies
RE-02 Study Scope
RE-03 Functions & Failures
RE-04 FMEA Workspace
RE-05 RCM Decision Workspace
RE-06 Maintenance Strategy
RE-07 Review & Approval
```

`Reliability Library` se introduce primero como capacidad transversal/drawer y se promociona a workspace propio cuando exista administración real de contenido.

Cada pantalla debe compartir:

- Study identity;
- revision/status;
- stage navigation;
- Evidence access;
- trace/history access cuando exista backend;
- previous/continue behavior;
- explicit gate state.

---

## 11. Qué se construye primero y qué no

### PRIMARY

1. Development Foundation.
2. Premium App Shell.
3. SQL/API-ready/concurrency foundation.
4. P-101 first vertical slice.
5. Reliability Engineering incrementalmente hasta Review & Approval.

### SUPPORTING

- Asset Detail mínimo necesario para contexto P-101;
- componentes premium compartidos;
- configuración mínima de riesgo/RCM antes de sus consumidores.

### WAITING / DO NOT START

- Work Management productivo completo mientras permanezcan gates AS-IS/TO-BE abiertos;
- costes/contratos/facturación detallados;
- API HTTP real;
- mobile app;
- todo el modelo SQL del CMMS por anticipación;
- dashboard ejecutivo sin consumers/acciones reales;
- biblioteca completa de Reliability antes de que exista un consumer validado.

---

## 12. Gates

### Development Foundation Gate

- arquitectura operativa confirmada;
- policy SQL activa;
- app language English;
- first vertical slice definido;
- orden de delivery congelado.

### Studio Foundation Gate

- Canvas app real identificada;
- Source Code schema/locale confirmado;
- shell importa/guarda/reabre;
- App Checker baseline conocido;
- componentes foundation instalados/validados.

### SQL Foundation Gate

- database target identificado;
- schemas y permisos mínimos aprobados;
- common result/error contract definido;
- first read slice probado;
- first mutable command supera concurrency/idempotency/audit tests.

### Integration Gate

- Power Apps consume el contrato a través de un Flow fino;
- loading/error/conflict se muestran correctamente;
- refresh conserva semántica;
- no existe lógica de integridad duplicada en Power Fx/Flow.

---

## 13. Definition of Done por capability

Una capability no está `DONE` por existir en GitHub.

Debe tener, cuando aplique:

- functional/UX contract;
- mock representativo;
- Power Apps candidate;
- Studio save + reopen;
- App Checker sin errores nuevos relevantes;
- backend contract;
- SQL tests positivos/negativos/concurrentes;
- Flow probado;
- runtime journey validado;
- estados no nominales;
- documentación consolidada;
- gate explícito `PASS`.

---

## 14. Regla de continuidad

CMMS 2.0 se desarrollará siguiendo el patrón demostrado en AssetPlan/TMS:

```text
small
→ observable
→ reversible
→ validated
→ consolidated
```

No se abrirá una nueva capability material si la actual tiene un error abierto o un gate aplicable sin resolver.
