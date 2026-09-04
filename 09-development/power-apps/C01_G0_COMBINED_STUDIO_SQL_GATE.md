# CMMS 2.0 — Combined G0 SQL + C01 Studio Gate

**Estado:** `WAITING_USER_EXECUTION`  
**Fecha:** 2026-09-04

## 1. Objetivo

Evitar dos rondas manuales separadas. Este gate recoge en una sola sesión la evidencia mínima que no puede obtenerse desde el repositorio:

1. bootstrap SQL real en `db-omm-dev`;
2. baseline de la Canvas app `CMMS` vacía;
3. comprobación de que la foundation Power Apps puede comenzar sin deuda previa oculta.

## 2. Parte A — SQL

Ejecutar en `db-omm-dev`, en orden:

```text
09-development/sql/001_CMMS_NAMESPACE_BOOTSTRAP.sql
09-development/sql/003_CMMS_NAMESPACE_VERIFY.sql
```

Resultado esperado:

```text
PASS_001_CMMS_NAMESPACE_BOOTSTRAP
PASS_003_CMMS_NAMESPACE_VERIFY
```

Conservar el output completo de `003`, porque aporta:

```text
ServerName
DatabaseName
LoginName
DatabaseUser
OriginalLogin
ProductVersion
Edition
DatabaseCollation
HasSpGetAppLock
schema ownership
current DDL capability checks
```

### Runtime identity decision

Power Automate ejecutará los procedimientos almacenados con el usuario de base de datos ya disponible para desarrollo y con permisos suficientes para administrar `db-omm-dev`.

No se crea ningún rol CMMS adicional en esta fase.

La cuenta SQL de conexión no sustituye la identidad funcional del usuario. Los commands iniciados desde Power Apps deberán transportar `ActorEmail`/identidad funcional cuando aplique para auditoría.

No ejecutar todavía DDL de `ReliabilityStudy`.

## 3. Parte B — Canvas app baseline

Abrir la app `CMMS` en Power Apps Studio.

Registrar:

```text
Environment
App remains empty / current screen inventory
Responsive / display settings
App Checker summary
```

La captura histórica de agosto no sustituye esta evidencia porque la app actual se declara vacía.

### B1 — App Checker

Abrir App Checker y conservar el resumen actual:

```text
Errors
Warnings / formulas when visible
Accessibility
Performance
```

Este será el nuevo baseline C01.

### B2 — Current authoring reality

Confirmar mediante una fórmula mínima o la UI de Studio la sintaxis actual:

```text
function arguments
instruction separator
```

La evidencia histórica fue `comma + semicolon`, pero se registra nuevamente si la app fue recreada.

### B3 — Component inventory

Confirmar que no existen componentes CMMS instalados actualmente, o listar cualquiera que sí exista.

No importar todavía componentes de TMS/AssetPlan directamente.

## 4. Evidencia mínima que debe volver al repositorio

```text
SQL 001 result
SQL 003 full output
Power Apps environment
App Checker baseline
Current components list
```

Capturas son válidas para Power Apps. Para SQL se prefiere output textual/tabular de `003`.

## 5. Decisión automática después del gate

### Si PASS

El siguiente incremento será C01-A y no requerirá otra ronda conceptual:

```text
C01-A Theme/Layout Foundation
→ C01-B CMMS Sidebar + Project Context + Page Header
→ C01-C Canonical Screen Template
→ I01-A Backend Common Contracts
```

### Si SQL falla

Se corrige únicamente el bootstrap/capability que falle. No se rediseña el producto.

### Si Power Apps falla

Se corrige compatibilidad de controles/source/locale antes de multiplicar componentes.

## 6. Criterio de parada

Este documento representa el siguiente gate real.

No crear aún tablas `ReliabilityStudy`, `Function`, `FailureMode` o `MaintenanceStrategy` antes de confirmar el namespace y capacidades SQL reales.

No promover componentes a `VALIDATED_CMMS` antes de Studio.
