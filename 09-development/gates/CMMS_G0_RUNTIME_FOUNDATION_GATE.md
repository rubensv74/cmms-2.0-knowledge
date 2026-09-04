# CMMS 2.0 — G0 Runtime Foundation Gate

**Estado:** WAITING_REAL_TOOL_EVIDENCE  
**Fecha:** 2026-09-04  
**Bloquea:** C01 Premium App Shell + I01 Backend Pilot implementation

---

## 1. Propósito

Este es el primer gate que ya no puede cerrarse solo con documentación.

Su objetivo es confirmar la realidad técnica del entorno en el que se construirá CMMS 2.0 antes de generar una foundation Power Apps/SQL que luego haya que rehacer.

No reabre decisiones funcionales ya tomadas.

---

## 2. Evidencia Power Apps requerida

### G0-PA-01 — Canvas app target

Confirmar:

```text
Environment:
App name:
App ID / URL if available:
Owner / maker context:
Desktop-first canvas:
```

Resultado esperado:

`PASS — existe una app real objetivo para comenzar la foundation`.

Si todavía no existe, crear una Canvas app vacía es parte del gate.

### G0-PA-02 — Source Code reality

Confirmar en la app real:

- Source Code schema aceptado;
- authoring locale;
- versiones reales de `GroupContainer` y controles que vayamos a usar;
- posibilidad real de copiar/pegar Source Code/YAML conforme al patrón utilizado en AssetPlan/TMS.

No se generará una cadena larga de pantallas antes de confirmar esto.

### G0-PA-03 — App Checker baseline

Capturar baseline antes de introducir CMMS foundation:

```text
Errors:
Warnings:
Accessibility:
Performance suggestions:
```

El objetivo no es exigir cero warnings de una app vacía, sino distinguir deuda previa de defectos nuevos.

### G0-PA-04 — Component reality

Auditar primero candidatos reales de AssetPlan/TMS/PULSE para:

```text
Sidebar
Project Context
Page Header
Action Button
State Panel
Skeleton Loader
Icon resolver
```

Por cada candidato:

```text
REUSE_CMMS
ADAPT_VERIFIED_BASE
EXTEND_SHARED
CREATE_SHARED
DO_NOT_USE
```

Ningún componente se marca `VALIDATED_CMMS` por existir en otro repositorio.

---

## 3. Evidencia SQL requerida

### G0-SQL-01 — Database target

Confirmar:

```text
SQL platform / service:
Server:
Database:
Development environment:
Existing schemas relevant to CMMS:
Collation if material:
```

No se requiere todavía diseñar el modelo completo.

### G0-SQL-02 — Runtime identity

Confirmar qué identidad utilizará Power Automate para ejecutar SQL en desarrollo.

Registrar:

```text
Connection identity:
Authentication mechanism:
Existing role/permissions:
Can EXECUTE stored procedures?:
Can SELECT approved views/read contracts?:
Direct table DML currently available?:
```

Objetivo final:

```text
runtime
→ EXECUTE/SELECT approved cmms_api contracts
→ NO direct DML on cmms tables
```

### G0-SQL-03 — DDL authority

Confirmar qué identidad/persona ejecutará scripts de instalación/migración durante desarrollo.

Separar:

```text
Deployment / DDL identity
!=
Runtime Flow identity
```

cuando sea posible.

### G0-SQL-04 — Feature availability

Confirmar soporte para:

- schemas;
- `rowversion`;
- transactions;
- unique indexes/constraints;
- Stored Procedures;
- `sp_getapplock` si el motor/plataforma lo permite y llega a necesitarse.

---

## 4. Evidencia Power Automate requerida

### G0-FLOW-01 — SQL connector reality

Confirmar que el environment puede crear/usar un Flow invocado desde Power Apps con conexión SQL al target de desarrollo.

### G0-FLOW-02 — Contract transport

El primer Flow deberá ser fino:

```text
Power Apps request
→ validate transport fields
→ execute cmms_api read/command contract
→ return normalized result
```

No introducir reglas de negocio del Reliability Study en el Flow.

---

## 5. Gate PASS

G0 se considera PASS cuando exista evidencia suficiente de:

```text
[ ] Canvas app real identificada/creada
[ ] Source Code reality confirmada
[ ] App Checker baseline capturado
[ ] foundation component strategy real confirmada
[ ] SQL dev target identificado
[ ] runtime SQL identity identificada
[ ] DDL/deployment authority conocida
[ ] least-privilege direction viable
[ ] rowversion/transactions/SP supported
[ ] Power Apps → Power Automate → SQL connector path viable
```

---

## 6. Acciones inmediatamente posteriores al PASS

No habrá nueva fase conceptual.

Secuencia:

```text
G0 PASS
→ C01-A Theme/Layout Foundation
→ C01-B Shell Components
→ C01-C Canonical Screen Template
→ I01-A Common Backend Contracts
→ I01-B First Read Slice
→ I01-C Safe Study Scope Command
→ C02 P-101 Reliability Backbone
```

---

## 7. Regla de parada

Si G0 detecta una incompatibilidad real de Source Code, permisos SQL o conectividad, se corrige el diseño de foundation antes de multiplicar artefactos.

Eso es un gate técnico real, no una razón para volver a discutir conceptos de CMMS ya consolidados.
