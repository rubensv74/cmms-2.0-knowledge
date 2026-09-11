# Maintenance Standards Library — Functional Model

**Versión:** v0.1  
**Fecha:** 2026-09-11  
**Estado:** principios funcionales confirmados; contratos detallados `to_validate`  
**Fuente principal:** [`../../05-meetings/2026/2026-09-11_revision-cmms-estandares-job-plans.md`](../../05-meetings/2026/2026-09-11_revision-cmms-estandares-job-plans.md)

## 1. Propósito

Definir la capacidad corporativa que permite reutilizar planes, tareas y Job Plans de mantenimiento por tipo de equipo sin obligar a desarrollar un RCM completo para cada activo/proyecto.

Este modelo no sustituye RCM. Introduce una segunda fuente gobernada de ingeniería de mantenimiento.

## 2. Principio funcional

CMMS 2.0 debe soportar al menos dos rutas de creación/adopción de un plan:

```text
A. RCM engineering route
Asset / context / criticality
→ RCM (incluye AMEF)
→ maintenance policy
→ maintenance tasks
→ execution definition
→ Project Maintenance Plan

B. Corporate standard route
Equipment Type / context / criticality
→ select Corporate Standard
→ review applicability
→ project adaptations
→ Project Maintenance Plan
```

Las rutas pueden mezclarse. Un proyecto puede partir de un estándar y realizar RCM específico para equipos o modos de fallo que requieran mayor profundidad.

## 3. Fuentes admitidas para un estándar

Un estándar corporativo puede derivarse de una o varias fuentes:

```text
RCM study
OEM / vendor manual
historical project maintenance plan
existing Job Plan / procedure
operational experience
specialist engineering decision
```

Toda entrada promovida al maestro debe conservar provenance y versión.

## 4. Granularidad funcional

### 4.1. Standard Maintenance Activity

Es la unidad de mantenimiento que tiene sentido planificar, programar, convertir en orden de trabajo y cerrar en CMMS.

Ejemplos conceptuales:

```text
Annual Gas Detector Maintenance
Pressure Safety Valve Major Intervention
Check Lubricant Level and Condition
```

No debe descomponerse automáticamente en decenas de subpasos con avance independiente.

### 4.2. Procedure / Checklist

Contiene el detalle operativo necesario para ejecutar la actividad:

- secuencia;
- puntos a revisar;
- ubicación/punto de medida;
- técnica;
- criterio de aceptación;
- acción ante desviación;
- instrucciones de seguridad;
- evidencia/registro requerido.

Los pasos pueden registrar resultados cuando sea necesario, pero no equivalen por defecto a actividades CMMS independientes.

### 4.3. Job Plan

Se modela provisionalmente como el **template reutilizable de ejecución** asociado a una actividad o conjunto coherente de actividades.

Debe poder relacionar:

```text
StandardMaintenanceActivity
+ ProcedureChecklist
+ ResourceRequirements
+ Tools / Special Equipment
+ Materials / Consumables / Spares
+ Safety / Permit Conditions
+ Duration / Labor Estimate
+ applicability / frequency defaults
```

La reunión confirma el concepto reutilizable y la necesidad de cuantificar recursos. La frontera exacta entre contenido embebido en `JobPlan` y documento `ProcedureChecklist` permanece `to_validate`.

## 5. Estrategia y frecuencia

Una actividad estándar debe declarar su `MaintenanceStrategy`, por ejemplo:

```text
TIME_BASED
CONDITION_BASED
RUN_TO_FAILURE
```

Un equipo puede tener varias estrategias en paralelo para distintos modos de fallo/componentes.

Una frecuencia del estándar es un **default técnico**, no una imposición universal.

Debe conservarse:

```text
frequencyValue
frequencyUnit
frequencyBasis
sourceReference
criticalityAssumption
operatingContextAssumption
```

El proyecto puede modificarla con justificación.

## 6. Modelo maestro → proyecto

### 6.1. Corporate Master

La biblioteca corporativa contiene estándares versionados por tipo de equipo y, cuando sea necesario, por variante técnica.

```text
EquipmentTypeStandard
├── StandardPlanVersion
│   ├── StandardMaintenanceActivity
│   │   └── JobPlan / ProcedureChecklist
│   └── Default applicability / frequency / resources
```

### 6.2. Project Adoption

Un proyecto adopta una versión concreta del estándar.

Conceptualmente:

```text
Corporate Standard Version
→ Project Adoption Snapshot
→ Project Overrides
→ Published Project Plan Version
```

El proyecto debe poder:

- aceptar una actividad;
- desactivarla como `not applicable`;
- cambiar frecuencia;
- ajustar recursos;
- sustituir procedimiento/Job Plan;
- añadir una nueva actividad específica;
- documentar el motivo.

### 6.3. No mutación accidental

Un cambio de proyecto nunca modifica automáticamente el maestro.

Debe existir una acción separada y gobernada:

```text
Project Learning
→ Change Proposal
→ Corporate Review
→ New Corporate Standard Version
```

## 7. Variantes de Equipment Type

Cuando un equipo nuevo difiere de un estándar existente de forma relevante, el sistema debe permitir:

- mantener el estándar base;
- registrar una variante;
- describir la diferencia técnica;
- reutilizar el resto del plan común;
- evaluar posteriormente si la variante merece promoción corporativa.

No debe forzarse la duplicación completa del estándar por una diferencia parcial.

## 8. Relación con criticidad y RCM

La criticidad influye en la profundidad de análisis y en el plan, pero no excluye equipos del CMMS.

Principios:

1. Todos los equipos gestionables deben poder existir en CMMS.
2. Un equipo crítico/especial puede requerir RCM específico.
3. Un equipo no crítico puede utilizar estándar/OEM/expert judgement.
4. `RUN_TO_FAILURE` es una decisión de estrategia, no ausencia de modelo.
5. El sistema puede sugerir una ruta a partir de criticidad/configuración, pero la elección debe quedar gobernada y trazada.

## 9. Objetos conceptuales candidatos

```text
MaintenanceStandardLibrary
EquipmentTypeStandard
StandardPlanVersion
StandardMaintenanceActivity
MaintenanceStrategy
JobPlan
ProcedureChecklist
ResourceRequirement
ToolRequirement
MaterialRequirement
SourceReference
ProjectStandardAdoption
ProjectPlanOverride
ProjectMaintenancePlanVersion
CorporateChangeProposal
```

Estos nombres todavía no constituyen esquema SQL ni API.

## 10. Decisiones persona vs sistema

| Acción | Sistema | Persona | Estado |
|---|---|---|---|
| Encontrar estándar por Equipment Type | Puede sugerir | Especialista confirma | principio confirmado |
| Copiar/adoptar versión a proyecto | Puede preparar snapshot | Usuario autorizado decide | `to_validate` workflow |
| Marcar actividad no aplicable | Puede validar dependencias | Especialista decide y justifica | principio confirmado |
| Ajustar frecuencia | Puede mostrar baseline/fuente | Especialista decide | principio confirmado |
| Añadir actividad de proyecto | Puede asistir | Especialista decide | principio confirmado |
| Promover cambio al maestro | Nunca automático | Gobierno corporativo aprueba | principio confirmado |
| Seleccionar ruta RCM vs estándar | Puede recomendar | Autoridad funcional decide | `to_validate` regla |

## 11. Trazabilidad mínima

Cada plan de proyecto debe permitir responder:

```text
¿De qué estándar/version parte?
¿Qué actividades se conservaron?
¿Cuáles se desactivaron?
¿Qué cambió y por qué?
¿Qué se añadió localmente?
¿Qué fuente técnica soporta cada elemento?
¿Qué aprendizaje se propuso devolver al maestro?
```

## 12. Gates de consolidación

### MSL-G01 — Source normalization

Normalizar al menos un conjunto real de documentación histórica por tipo de equipo.

### MSL-G02 — Core contract

Cerrar contratos de:

- standard plan;
- activity;
- Job Plan;
- procedure/checklist;
- resources;
- frequency;
- source/provenance.

### MSL-G03 — Project adoption

Validar snapshot, overrides y versioning proyecto vs maestro.

### MSL-G04 — Corporate feedback loop

Definir propuesta, revisión, aprobación y publicación de nuevas versiones corporativas.

## 13. Relación con Work Management

Gestión del Trabajo debe recibir **actividades ejecutables**, no cada paso del checklist como candidato de WO.

```text
Published Project Maintenance Plan
→ Scheduled Maintenance Activity
→ Work Candidate / Work Order
   └── references JobPlan / ProcedureChecklist
```

Esto reduce carga operativa y mantiene el detalle técnico disponible durante la ejecución.
