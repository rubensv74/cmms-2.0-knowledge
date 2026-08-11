# CMMS 2.0 — Registro de gates de arquitectura

**Fecha:** 2026-08-11  
**Estado:** activo

## 1. Propósito

Distinguir claramente tres tipos de incertidumbre:

1. **desviación:** contradice una decisión/modelo ya cerrado y debe corregirse;
2. **validación funcional:** regla o dato que el negocio todavía debe confirmar, pero que no cambia la arquitectura;
3. **gate de arquitectura:** decisión estructural que cambia ownership, lifecycle, cardinalidades, límites de sistema o implementación productiva y requiere decisión explícita antes de continuar.

Esta separación permite trabajar de forma autónoma sin pedir decisiones innecesarias y evita cerrar por accidente asuntos que siguen abiertos.

## 2. Gates cerrados para AMEF/RCM

Los siguientes puntos se consideran decisiones estructurales ya adoptadas para el modelo conceptual:

| ID | Decisión | Estado |
|---|---|---|
| AG-CLOSED-001 | Modelo `Engineering Library → Asset Application → Execution Plan → Results & Learning`. | closed |
| AG-CLOSED-002 | `FmeaDefinition` como identidad estable reusable. | closed |
| AG-CLOSED-003 | `FmeaRevision` para gobernar/versionar contenido. | closed |
| AG-CLOSED-004 | `FmeaAssetApplication` separada del AMEF reusable. | closed |
| AG-CLOSED-005 | Criticidad del activo separada de riesgo AMEF. | closed |
| AG-CLOSED-006 | `FailureCause`/mecanismo explícito. | closed |
| AG-CLOSED-007 | `MaintenanceTask` ↔ `FailureMode` N:M. | closed |
| AG-CLOSED-008 | `MaintenanceTask` separada de `MaintenanceProcedure` e `InspectionFormat`. | closed |
| AG-CLOSED-009 | Salida RCM explícita sin tarea mediante `NoScheduledTaskDecision`. | closed |
| AG-CLOSED-010 | Economía separada en assessment, estimate y actual. | closed |
| AG-CLOSED-011 | Revisiones publicadas inmutables. | closed |
| AG-CLOSED-012 | Lineage por identificadores entre todas las capas. | closed |

Cambiar cualquiera de estos puntos requiere reabrir un gate de arquitectura, no una edición local de pantalla.

## 3. Validaciones funcionales abiertas — NO son gates de arquitectura

Estos asuntos pueden seguir `to_validate` dentro del Functional Lab sin detener la construcción conceptual:

| ID | Asunto | Tratamiento actual |
|---|---|---|
| FV-001 | Matriz corporativa de riesgo y escalas. | Simulación versionada, visible como `to_validate`. |
| FV-002 | Fórmula final de priorización AMEF. | No asumir como estándar. |
| FV-003 | Esquema/valores definitivos de criticidad de activos. | Fixture usa esquema demo separado. |
| FV-004 | Árbol RCM definitivo. | Lógica demo versionada. |
| FV-005 | Roles y workflow final de aprobación. | Roles funcionales candidatos. |
| FV-006 | Umbrales corporativos P–F. | Hipótesis de caso. |
| FV-007 | Fórmulas, tarifas y horizonte económico. | Datos demo. |
| FV-008 | Nomenclatura final de estados/códigos. | Catálogos provisionales. |
| FV-009 | Criterio exacto para exigir procedimiento/formato. | Regla pendiente. |
| FV-010 | Frecuencias y límites técnicos del caso P-101. | Ilustrativos. |

Su validación podrá cambiar reglas, valores o UX, pero no obliga por sí sola a cambiar las cuatro capas.

## 4. Gates de arquitectura futuros — no bloquean la remediación actual

Estos temas necesitarán decisión explícita cuando el desarrollo llegue a su frontera.

### AG-OPEN-001 — Persistencia productiva

**Pregunta futura:** ¿qué tecnología y modelo físico almacenarán Library, Application, Plan y Results?

Candidatos no evaluados aquí:

- Azure SQL;
- Dataverse;
- combinación por dominios;
- otros servicios aprobados por IT.

**Trigger:** cuando el Functional Lab deje de usar fixtures/local state o IT solicite diseño físico.

### AG-OPEN-002 — Frontera de API/backend

**Pregunta futura:** ¿qué capacidades pertenecen a APIs/backend modular frente a Power Platform u otros consumidores?

**Trigger:** cuando se definan integraciones o servicios productivos.

### AG-OPEN-003 — Identidad y autorización

**Pregunta futura:** ¿cómo se representan usuarios, roles, autoridad de override y firmas/aprobaciones?

**Trigger:** cuando una decisión deje de ser simulada y necesite enforcement productivo.

### AG-OPEN-004 — Motor de reglas

**Pregunta futura:** ¿las matrices/rules/RCM logic se implementan como datos configurables, servicio de reglas, código u otra estrategia?

**Trigger:** cuando una regla deba ser compartida por varios clientes/canales o administrada fuera de la app.

### AG-OPEN-005 — Estrategia física de versionado/snapshots

**Pregunta futura:** ¿cómo se materializan revisiones y snapshots inmutables en la persistencia elegida?

**Trigger:** diseño físico productivo.

El concepto de revisión/snapshot ya está cerrado; lo abierto es su implementación técnica.

### AG-OPEN-006 — Integración con Asset Master / FLH / Taxonomía / ADR

**Pregunta futura:** ¿qué sistema es maestro de cada identidad/contexto y cómo se intercambian snapshots/referencias?

**Trigger:** cuando WS-07 deje de utilizar fixture y necesite datos reales.

### AG-OPEN-007 — Generación de objetos de ejecución CMMS

**Pregunta futura:** ¿cómo se transforma `ExecutionPlan` en Job Plans, PM, Forecast/Work Candidates/WO u objetos equivalentes del CMMS 2.0?

**Trigger:** al conectar Reliability Engineering con Work Management productivo.

### AG-OPEN-008 — Modelo de documentos técnicos

**Pregunta futura:** ¿procedimientos, formatos, evidencias y documentos viven como entidades/versiones, referencias a DMS o una combinación?

**Trigger:** cuando se defina almacenamiento/integración documental productiva.

### AG-OPEN-009 — Multi-cliente / alcance corporativo

**Pregunta futura:** ¿qué nivel de tenancy/organización gobierna bibliotecas, reglas, catálogos y revisiones?

**Trigger:** cuando la solución deba materializar separación/configuración entre clientes, compañías o proyectos.

## 5. Dependencia técnica actual — NO es gate de arquitectura

### TG-001 — Canvas app baseline

Antes de escribir YAML Source Code del Functional Lab debe inspeccionarse una Canvas app real para conocer:

- dialecto Source Code aceptado;
- controles disponibles;
- componentes premium instalados;
- propiedades compatibles;
- restricciones de la versión;
- baseline de App Checker.

Esto es una dependencia técnica verificable, no una decisión estructural del dominio.

No debe resolverse inventando YAML.

## 6. Cuándo elevar una nueva cuestión a gate de arquitectura

Una duda solo se eleva si cambia al menos uno de estos aspectos:

```text
ownership de un objeto
topología de las cuatro capas
cardinalidad estructural
ciclo de vida / versionado
inmutabilidad
frontera entre sistemas
autoridad/enforcement productivo
persistencia física
contrato productivo compartido
```

No se eleva si solo cambia:

```text
texto de UI
orden de campos
valor de ejemplo
matriz todavía configurable
frecuencia demo
estilo visual
nombre provisional de un estado
validación técnica de un control
```

## 7. Protocolo de decisión

Cuando aparezca un gate real:

1. detener únicamente el trabajo afectado;
2. documentar el problema y su impacto;
3. presentar opciones comparables;
4. indicar recomendación y trade-offs;
5. registrar la decisión;
6. actualizar modelo, contratos y workspaces afectados;
7. reanudar el trabajo incremental.

## 8. Estado actual

A fecha 2026-08-11:

- las 14 desviaciones de la foundation asset-centric están corregidas conceptualmente;
- no existe un nuevo gate de arquitectura bloqueante para la remediación documental;
- el siguiente bloqueo del código Power Apps es `TG-001`, una dependencia técnica de baseline;
- los gates `AG-OPEN-*` permanecen dormidos hasta que el alcance llegue a ellos.
