# MSL-G01 — Source Normalization

**Gate:** MSL-G01  
**Fecha:** 2026-09-11  
**Estado:** `IN_PROGRESS / EXTERNAL_INPUT_REQUIRED`  
**Objetivo:** registrar y normalizar evidencia real de planes de mantenimiento antes de definir contratos MSL-G02 o crear fixtures de biblioteca.

## 1. Regla de trabajo

Este gate no convierte documentación histórica en modelo canónico de forma automática.

La secuencia aplicada es:

```text
real source
→ provenance
→ source extraction
→ normalization candidates
→ gaps / ambiguity
→ MSL-G01 gate decision
```

No se inventan actividades, frecuencias, Job Plans, recursos ni procedimientos que no estén visibles en la evidencia.

## 2. Fuentes registradas

### MSL-SRC-001 — Presentación histórica de planes de mantenimiento

| Campo | Valor |
|---|---|
| SourceId | `MSL-SRC-001` |
| Título | `2026.07.22 Presentación Planes de Mantto - O&M - TR.pptm.pptx` |
| Tipo | Historical maintenance-plan reference / presentation |
| Fecha de referencia | 2026-07-22 |
| Authority | `EVIDENCE_ONLY` |
| Uso permitido | Source normalization / discovery |
| Uso no permitido | Convertir directamente Model 1/2/3 en arquitectura CMMS 2.0 |
| Provenance status | `REGISTERED` |

La fuente describe un caso industrial real de desarrollo y migración de planes de mantenimiento, con AMEF/MCC, clasificación ISO 14224, frecuencias, actividades, ejecutores, recursos y criterios de agrupación.

También documenta una lección operacional importante: modelar el mantenimiento con excesiva granularidad produjo volúmenes inmanejables de hojas de ruta y planes. El llamado Modelo 3 redujo el volumen agrupando trabajo homogéneo, pero esa solución histórica se conserva como evidencia y no como diseño obligatorio para CMMS 2.0.

### MSL-SRC-002 — Transcripción de revisión de planes históricos

| Campo | Valor |
|---|---|
| SourceId | `MSL-SRC-002` |
| Título | `Audio file.docx` |
| Tipo | Meeting transcript / source walkthrough |
| Fecha de referencia | 2026-07-24 |
| Authority | `EVIDENCE_ONLY` |
| Relación | Companion evidence for `MSL-SRC-001` |
| Provenance status | `REGISTERED` |

La transcripción permite recuperar la semántica de columnas que se mostraron en pantalla aunque el detalle fila a fila del fichero original no esté disponible en el repositorio.

### MSL-SRC-003 — Revisión CMMS 2026-09-11

| Campo | Valor |
|---|---|
| SourceId | `MSL-SRC-003` |
| Título | `05-meetings/2026/2026-09-11_revision-cmms-estandares-job-plans.md` |
| Tipo | Confirmed meeting evidence |
| Fecha de referencia | 2026-09-11 |
| Authority | `CONFIRMED_FUNCTIONAL_EVIDENCE` |
| Provenance status | `REGISTERED` |

Esta fuente confirma que durante la sesión se revisaron ejemplos reales para gas detector, gas turbine, pressure safety valve, generators/equipment associated, fans y otros auxiliares. También confirma que los documentos contienen frecuencias, Job Plans, operations/checklists, resources/disciplines y tools. Los ficheros detallados que contienen esas filas no están actualmente disponibles como evidencia legible en este repositorio.

## 3. Equipment Type piloto normalizado

Para no inventar filas del material mostrado el 2026-09-11, el primer piloto se apoya en el tipo de equipo cuya estructura de plan sí quedó descrita explícitamente en la evidencia disponible:

```text
Equipment Type candidate: COMPRESSOR
Example technical object: K-001
Source basis: MSL-SRC-001 + MSL-SRC-002
```

`COMPRESSOR` es por ahora un **candidate normalized label**. Su `EquipmentTypeCode` corporativo definitivo debe resolverse contra la taxonomía vigente durante MSL-G02 o en el contrato de integración correspondiente; no se genera un código nuevo en G01.

## 4. Extracción observada para COMPRESSOR

La evidencia describe para un plan de compresor los siguientes datos fuente:

| Dato observado | Normalización candidata | Estado |
|---|---|---|
| Equipment tag | `technicalObjectRef` | `OBSERVED` |
| Equipment denomination | `equipmentDescription` | `OBSERVED` |
| Task to execute | `maintenanceActivityText` | `OBSERVED_STRUCTURE_ONLY` |
| Failure mode avoided/treated | `failureModeRefOrText` | `OBSERVED_STRUCTURE_ONLY` |
| Failure cause | `failureCauseRefOrText` | `OBSERVED_STRUCTURE_ONLY` |
| Maintenance strategy/category | `maintenanceStrategy` | `OBSERVED_STRUCTURE_ONLY` |
| Equipment category | `equipmentCategory` | `OBSERVED_STRUCTURE_ONLY` |
| Duration | `estimatedDuration` | `OBSERVED_STRUCTURE_ONLY` |
| Executor | `executorDisciplineOrWorkCenter` | `OBSERVED_STRUCTURE_ONLY` |
| Number of executors | `laborQuantity` | `OBSERVED_STRUCTURE_ONLY` |
| Requires equipment out of service | `outageRequired` | `OBSERVED_STRUCTURE_ONLY` |
| Execution frequency | `frequency` | `OBSERVED_STRUCTURE_ONLY` |

`OBSERVED_STRUCTURE_ONLY` significa que la columna/concepto está confirmado, pero el valor de una fila concreta no se encuentra disponible como dato legible y por tanto no se rellena por inferencia.

## 5. Catálogos y valores observados en la fuente

### 5.1 Maintenance class / activity type

La fuente histórica utiliza, entre otros, estos códigos y conceptos:

| Raw code | Raw meaning observed | Normalization status |
|---|---|---|
| `210` | Condition-based maintenance | `SOURCE_VALUE` |
| `211` | Inspection / test | `SOURCE_VALUE` |
| `212` | Condition monitoring | `SOURCE_VALUE` |
| `220` | Predetermined maintenance | `SOURCE_VALUE` |
| `221` | Periodic test | `SOURCE_VALUE` |
| `222` | Scheduled replacement | `SOURCE_VALUE` |
| `223` | Scheduled service | `SOURCE_VALUE` |

Estos códigos se conservan como valores de fuente. MSL-G01 **no** los convierte en enums inmutables ni afirma que deban ser la codificación interna de CMMS 2.0.

### 5.2 Frequency

Se observan códigos de frecuencia como:

```text
D, S, Q, M, A, 2A, 4A, PP, REQ
```

y ejemplos de texto como:

```text
1S = 1 week
1Q = 15 days
2M = 2 months
3A = 3 years
```

La normalización candidata separa el texto/código fuente de su semántica:

```text
rawFrequencyCode
frequencyValue
frequencyUnit
frequencyBasis
sourceReference
```

No se asume que `Q`, `A`, `PP` o `REQ` tengan una semántica universal fuera de la fuente sin confirmación.

### 5.3 Resource / execution context

La fuente confirma dimensiones separadas para:

```text
executor
work center
planning group
maintenance discipline
labor quantity
estimated duration
outage requirement
```

MSL-G01 conserva esas dimensiones separadas. No se combinan en un único código compuesto.

## 6. Normalized candidate record

El registro mínimo que debe poder producir el proceso de ingestión es:

```text
SourceReference
  sourceId
  sourceTitle
  sourceDate
  sourceType
  sourceLocation
  authorityLevel

EquipmentTypeCandidate
  rawEquipmentType
  normalizedEquipmentType
  taxonomyRef?             # unresolved is valid at G01

StandardActivityCandidate
  sourceRowRef
  rawActivityCode?
  rawActivityText
  normalizedActivityText?
  maintenanceStrategy?
  failureModeRefOrText?
  failureCauseRefOrText?
  outageRequired?

FrequencyCandidate
  rawFrequencyCode
  frequencyValue?
  frequencyUnit?
  frequencyBasis?

ExecutionRequirementCandidate
  executorDisciplineOrWorkCenter?
  laborQuantity?
  estimatedDuration?
  toolRequirementText?
  materialRequirementText?

ProcedureJobPlanCandidate
  rawJobPlanId?
  rawOperationSequence?
  procedureOrChecklistText?
  classificationStatus       # JOB_PLAN / PROCEDURE / CHECKLIST / UNRESOLVED

Provenance
  sourceId
  sourcePageOrRow?
  extractionMethod
  evidenceStatus
```

Los signos `?` son deliberados: G01 debe representar ausencia de dato sin fabricar contenido.

## 7. Reglas de normalización obtenidas

1. Un texto como `2A Insp.Visual Tanque Alm. 02547` puede conservarse como `rawDisplayText`, pero frecuencia, actividad, Equipment Type y alcance deben existir como datos separados.
2. `Maintenance Activity` es la unidad candidata para planificación/programación/cierre; un checklist step no se convierte automáticamente en actividad.
3. Los modelos históricos de agrupación son evidencia de optimización administrativa, no una clave primaria ni una jerarquía obligatoria del nuevo sistema.
4. Una lista de objetos puede reducir carga administrativa, pero la identidad y el resultado por activo deben conservarse en el modelo posterior.
5. `executor`, `discipline`, `work center` y `planning group` son dimensiones distintas.
6. Los códigos ISO/históricos se conservan como source mappings; no se hardcodean antes de contrato.
7. Toda fila normalizada debe poder reconstruir su provenance hasta la fuente original.

## 8. Diferencia entre evidencia disponible y dato faltante

### Confirmado y utilizable ya

- provenance de una fuente histórica real;
- Equipment Type piloto `COMPRESSOR`;
- estructura de campos de un plan real de compresor;
- clases/tipos de mantenimiento observados;
- códigos y ejemplos de frecuencia;
- dimensiones de recursos y ejecución;
- criterios históricos de agrupación;
- regla de no mezclar texto visible con estructura de datos;
- necesidad de separar actividad, Job Plan y procedimiento/checklist.

### `SOURCE_REQUIRED`

Para cerrar MSL-G01 con datos normalizados fila a fila falta al menos uno de estos ficheros originales:

- plan histórico de compresor mostrado en la revisión;
- plan de gas detector mostrado el 2026-09-11;
- plan de gas turbine mostrado el 2026-09-11;
- plan de pressure safety valve mostrado el 2026-09-11;
- fichero equivalente con actividades, frecuencias, Job Plan/operations y recursos legibles.

El siguiente fichero recibido debe procesarse con el esquema de la sección 6, sin rediseñar el gate.

## 9. Gate assessment

| Acceptance criterion MSL-G01 | Resultado |
|---|---|
| Registrar una fuente real | `PASS` |
| Conservar provenance | `PASS` |
| Extraer por Equipment Type | `PARTIAL_PASS` — `COMPRESSOR` identificado y estructura extraída |
| Normalizar actividades | `BLOCKED_SOURCE_DATA` — faltan filas legibles |
| Normalizar frecuencias | `PARTIAL_PASS` — catálogo/códigos observados; falta asociación fila a fila |
| Normalizar Job Plans / procedures | `BLOCKED_SOURCE_DATA` |
| Normalizar resources | `PARTIAL_PASS` — estructura confirmada; faltan valores fila a fila |
| Evitar datos sintéticos | `PASS` |

### Veredicto

```text
MSL-G01 = IN_PROGRESS
NEXT GATE = EXTERNAL_INPUT
REQUIRED INPUT = one raw historical/OEM maintenance-plan source with readable activity rows
```

No debe iniciarse MSL-G02 como contrato definitivo ni crearse un fixture de Maintenance Standards Library hasta disponer de esa evidencia. Sí puede prepararse el mecanismo de ingestión y la plantilla de normalización, porque sus campos provienen de evidencia ya observada y están explícitamente marcados como candidatos.
