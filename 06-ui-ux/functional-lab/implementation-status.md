# Functional Lab — Implementation Status

**Fecha:** 2026-08-11  
**Estado general:** Foundation v2 — library-first remediated  
**Último gate superado:** modelo conceptual, journey, contratos y fixture canónico v2  
**Validación Power Apps:** todavía no iniciada

## 1. Motivo del reset funcional

La primera foundation convirtió correctamente el recorrido P-101 a un fixture ejecutable, pero mantuvo una estructura demasiado centrada en el activo.

La auditoría posterior detectó 14 desviaciones respecto al modelo reusable ya definido para AMEF/RCM. Todas las desviaciones estructurales han sido corregidas a nivel conceptual y contractual antes de comenzar YAML.

Principio vigente:

```text
Engineering Library
→ Asset Application
→ Execution Plan
→ Results & Learning
```

## 2. Estado de incrementos

| Incremento | Estado | Resultado |
|---|---|---|
| F00-01 Auditoría de transición | completed | Riesgos, fuentes y orden inicial de trabajo identificados. |
| F00-02 Protocolo incremental CMMS | completed | Adaptación del protocolo de Pulse con gate funcional previo. |
| F00-03 Visión v1 | superseded-by-v2 | Primera frontera del Functional Lab. |
| F00-04 Journey v1 | superseded-by-v2 | 28 etapas asset-centric conservadas como antecedente. |
| F00-05 Persona vs sistema v1 | superseded-by-v2 | Primera matriz de responsabilidades. |
| F00-06 Contratos JSON v1 | legacy | Fixture monolítico asset-centric; no usar para nuevos bloques. |
| F00-07 Fixture P-101 v1 | legacy | Evidencia histórica, no fuente runtime canónica. |
| F00-08 Arquitectura v1 | superseded-by-v2 | Sustituida por arquitectura por capas. |
| F00-09 Paquete documental IT | completed | Estructura modular de handoff definida. |
| F00-R01 Auditoría library-first | completed | 14 desviaciones catalogadas y corregidas. |
| F00-R02 Modelo conceptual canónico | completed | `03-data-model/` con entidades, cardinalidades, invariantes y trazabilidad. |
| F00-R03 Contratos por capas | completed | Schemas Library, Application, Plan y Results. |
| F00-R04 Fixture P-101 v2 | completed | P-101 convertido en aplicación de una biblioteca reusable. |
| F00-R05 Journey v2 | completed | 28 etapas reorganizadas desde biblioteca hasta resultados. |
| F00-R06 Persona vs sistema v2 | completed | Responsabilidades adaptadas a cuatro capas. |
| F00-R07 Arquitectura v2 | completed | Estado, workspaces y trazabilidad runtime library-first. |
| F00-R08 Component contracts | completed | Patrones de dominio definidos sin inventar YAML. |
| F00-R09 Guías/artefactos históricos | in-progress | Alinear Experience Center y documentación didáctica. |
| F01-00 Auditoría Power Apps de foundation | planned | Confirmar dialecto Source Code, componentes y restricciones en app real. |
| F01-01 Premium App Shell Foundation | blocked-by-F01-00 | Primer bloque técnico. |
| F01-02 Layered runtime state | planned | Estado local separado en Library/Application/Plan/Results. |
| F01-03 Adaptador P-101 v2 | planned | Fixture v2 → estado/colecciones Power Fx. |
| F01-04 Navegación base | planned | Workspaces y transición visual entre capas. |
| F01-05 WS-01 Library context | planned | `FmeaDefinition` y `FmeaRevision`. |
| F01-06 WS-01 Evidence/revision work | planned | Inputs permitidos sobre revisión borrador/demostrativa. |
| F01-07 WS-01 Gate | planned | Preparación de revisión y explicación del bloqueo. |
| F01-08 WS-01 Output | planned | Referencias estructuradas hacia WS-02. |
| F01-09 Hardening WS-01 | planned | Loading/empty/error/dirty/read-only/accessibility. |

## 3. Contratos canónicos vigentes

```text
case-fixture.schema.json (v2)
├─ fmea-library.schema.json
├─ fmea-asset-application.schema.json
├─ execution-plan.schema.json
└─ maintenance-results.schema.json
```

Caso canónico:

```text
cases/P101/p101-case.v2.json
```

La v1 se conserva exclusivamente como antecedente y referencia de migración.

## 4. Gate funcional de WS-01 — Library & Revision

### Objeto activo

```text
FmeaDefinition
→ FmeaRevision
```

### Inputs existentes

- `fmeaDefinitionId`, código y nombre;
- alcance de tipo de equipo / función cuando aplique;
- revisión seleccionada;
- estado de revisión;
- versión de matriz de riesgo referenciada;
- versión de lógica RCM referenciada;
- fuentes/evidencias de biblioteca;
- estado de validación.

### Inputs humanos

Cuando la revisión sea editable/demostrativa:

- selección o creación de la definición/revisión;
- descripción y alcance;
- motivo de nueva revisión;
- confirmación de evidencia y supuestos;
- observaciones para revisión.

Una revisión publicada se muestra en solo lectura.

### Cálculos / validaciones

- integridad de IDs padre-hijo;
- existencia de definición y revisión;
- coherencia básica del estado;
- disponibilidad mínima de evidencia según regla demostrativa;
- detección de intento de edición sobre snapshot publicado.

### Decisión humana

Confirmar que la definición/revisión seleccionada es el conocimiento de ingeniería correcto sobre el que debe continuar el análisis.

### Gate

- bloquear cuando falte identidad o relación entre definición/revisión;
- bloquear edición de contenido publicado;
- explicar cualquier evidencia insuficiente;
- mostrar estado de validación de las reglas usadas.

### Output

```text
{
  fmeaDefinitionId,
  fmeaRevisionId,
  revisionNumber,
  status,
  validationStatus
}
```

listo para alimentar WS-02.

**No existe `AssetId` en el output requerido de WS-01.**

## 5. Condición para comenzar YAML

No generar código Source Code de Power Apps hasta completar F01-00.

F01-00 debe confirmar en la Canvas app real:

- schema Source Code aceptado;
- convenciones de nombres;
- controles Classic/Modern seguros;
- componentes premium reutilizables instalados;
- propiedades incompatibles conocidas;
- estrategia visual inicial;
- ubicación canónica de pantalla y bloques;
- mecanismo inicial del Runtime Adapter.

Este gate evita repetir problemas conocidos de YAML y componentes inexistentes.

## 6. Bloqueadores actuales

No queda un bloqueador conceptual de arquitectura para continuar la remediación documental.

El código Power Apps sigue bloqueado por una **dependencia técnica verificable**: aún no se ha inspeccionado la Canvas app baseline real. Esto no autoriza a inventar Source Code, versiones de controles o componentes.

## 7. Regla de continuidad

Una vez iniciado F01:

> No se prepara el siguiente bloque técnico hasta que el anterior quede integrado y validado en Power Apps Studio o exista una corrección explícita en curso.

La misma disciplina se aplicará a los cambios de capa: WS-07 no puede modificar objetos publicados de Library y WS-09 no puede sobrescribir hipótesis históricas.
