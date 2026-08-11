# WS-01 — Library & Revision

**Estado:** listo para diseño técnico después de F01-00  
**Capa:** `Engineering Library`  
**Objeto primario:** `FmeaDefinition` → `FmeaRevision`  
**Etapas:** FL-01 a FL-03  
**Fixture de referencia:** `cases/P101/p101-case.v2.json`

## 1. Propósito

WS-01 establece el contexto de ingeniería reusable sobre el que continuará el análisis.

No responde a:

> ¿Qué sabemos de P-101?

Responde a:

> ¿Qué biblioteca AMEF y qué revisión concreta estamos creando, revisando o consultando?

P-101 no es necesario para completar este workspace.

## 2. Resultado funcional

El workspace debe terminar con una referencia inequívoca a:

```text
FmeaDefinition
+
FmeaRevision
+
revision status
+
validation status
+\nevidence / assumptions readiness
```

que pueda consumir WS-02 sin reconstruir contexto desde etiquetas de pantalla.

## 3. Entry conditions

Como mínimo debe existir un fixture v2 parseable o un estado runtime equivalente.

```text
fixtureVersion = 2.x
engineeringLibrary.fmeaDefinition exists
engineeringLibrary.fmeaRevision exists
fmeaRevision.fmeaDefinitionId = fmeaDefinition.fmeaDefinitionId
```

Si no se cumplen estas condiciones, WS-01 entra en estado `Error` o `Blocked` y explica el problema.

## 4. Información disponible

### `FmeaDefinition`

- `fmeaDefinitionId`;
- `code`;
- `name`;
- `description`;
- `equipmentTypeRef`;
- `functionalScopeRef`;
- `ownerRole`;
- `lifecycleStatus`.

### `FmeaRevision`

- `fmeaRevisionId`;
- `fmeaDefinitionId`;
- `revisionNumber`;
- `status`;
- `validFrom` / `validTo`;
- `changeReason`;
- `sourceRevisionId`;
- `riskMatrixVersionRef`;
- `rcmLogicVersionRef`;
- `publishedSnapshotId`;
- `validationStatus`.

### Governance/evidence

- `governance.evidenceSources[]`;
- approvals disponibles;
- estado de validación;
- snapshot publicado cuando exista.

## 5. Lo que el usuario puede hacer

El Functional Lab debe permitir simular, según el estado de la revisión:

- seleccionar una definición de biblioteca;
- seleccionar una revisión;
- iniciar conceptualmente una nueva revisión desde otra existente;
- revisar alcance y descripción;
- declarar/confirmar evidencias y supuestos;
- justificar el motivo de una revisión nueva;
- confirmar que el objeto elegido es el contexto de ingeniería correcto para continuar.

### Revisión publicada

Si:

```text
status = published
```

o existe `publishedSnapshotId`, el contenido gobernado se trata como read-only.

El laboratorio puede permitir una acción separada del tipo:

```text
Create new revision from this published revision
```

pero nunca convertir el snapshot publicado en editable.

## 6. Lo que el usuario NO puede hacer aquí

WS-01 no puede editar:

- `assetId`;
- contexto operacional de P-101;
- criticidad del activo;
- aplicabilidad sobre activos;
- intervalos efectivos por activo;
- recursos del Execution Plan;
- resultados reales;
- costes reales.

Tampoco puede crear una función/modo/tarea directamente dentro de la definición sin una `FmeaRevision` activa.

## 7. Responsabilidad persona / sistema

### Existing input

El sistema carga identidad, revisión, estado, referencias de reglas y evidencia disponible.

### User input

La persona confirma/edita únicamente campos permitidos por el estado de la revisión y declara evidencia/supuestos cuando el fixture simule una revisión editable.

### System calculations

Validaciones deterministas:

```text
definition exists
revision exists
revision belongs to definition
revision identifier is unique in runtime
published snapshot is read-only
evidence source list is structurally valid
required references exist according to demo rule
```

### System recommendation

Puede sugerir:

- continuar con revisión existente;
- crear nueva revisión si la seleccionada está publicada y el usuario intenta modificar contenido;
- completar evidencia/supuestos antes de avanzar.

Estas recomendaciones no cambian la revisión por sí solas.

### Human decision

Confirmar la definición/revisión activa para el análisis.

## 8. Gate WS-01

### Gate ID candidato

`GATE-FMEA-LIBRARY-READY-001`

### Estado

`to_validate`

### Passed cuando

```text
fmeaDefinitionId present
fmeaRevisionId present
revision.fmeaDefinitionId matches definition
revisionNumber present
status present
riskMatrixVersionRef present
rcmLogicVersionRef present
at least one evidence source in demo fixture
no forbidden edit exists on published snapshot
```

### Warning cuando

- la regla/evidencia es todavía `to_validate`;
- la revisión está publicada y la experiencia es solo lectura;
- faltan approvals no requeridos todavía por el gate de laboratorio.

### Blocked cuando

- definición/revisión no existen;
- la revisión apunta a otra definición;
- se intenta modificar contenido publicado;
- no puede determinarse la revisión activa;
- el fixture no es v2.

### Mensaje de bloqueo

Debe responder:

```text
What is blocked?
Why?
Which object?
Which rule/version?
What action resolves it?
Is the rule approved or only simulated?
```

## 9. Output de WS-01

Contrato mínimo:

```json
{
  "layer": "library",
  "fmeaDefinitionId": "FMEA-CWPUMP-001",
  "fmeaRevisionId": "FMEAR-CWPUMP-001-R1",
  "revisionNumber": 1,
  "status": "published",
  "validationStatus": "to_validate",
  "publishedSnapshotId": "SNAP-FMEAR-CWPUMP-001-R1"
}
```

**No debe contener `assetId`.**

## 10. Trazabilidad generada

Al confirmar contexto se registra conceptualmente:

```text
stageId = FL-03
layer = library
objectType = FmeaRevision
objectId = fmeaRevisionId
sourceObjectId = fmeaDefinitionId
humanDecision = selected_for_analysis
actorRole
timestamp
validationStatus
```

No es necesario resolver todavía identidad productiva del actor; el laboratorio puede utilizar un actor demo.

## 11. Arquitectura de interacción candidata

### Arquetipo

`Configuration Studio`

### Composición

```text
scr_FunctionalLab
└─ conLab_Content
   ├─ cmp_LayerContextHeader
   ├─ conWS01_Main
   │  ├─ pnlDefinition
   │  ├─ pnlRevision
   │  └─ pnlEvidenceAssumptions
   ├─ cmp_GatePanel
   └─ conWS01_Actions
```

### Panel A — Definition

Muestra identidad estable y alcance reusable.

### Panel B — Revision

Muestra revisión, estado, lineage desde revisión origen y referencias de reglas.

### Panel C — Evidence & assumptions

Muestra evidencia de biblioteca y elementos pendientes de validar.

### Gate panel

Explica preparación/bloqueos.

## 12. Componentes prioritarios

- `cmp_LayerContextHeader`;
- `cmp_RevisionStatusBadge`;
- `cmp_GatePanel`;
- patrón de selección/listado reutilizable si la app baseline ya dispone de uno;
- empty/error pattern de Pulse cuando sea compatible.

No se creará un componente específico de P-101 en WS-01.

## 13. Estados de pantalla

Obligatorios:

```text
NoFixture
LoadingFixture
Loaded
Dirty
Blocked
Warning
ReadOnlyPublished
SaveLocalSuccess
Error
```

### `ReadOnlyPublished`

Debe ser visualmente inequívoco y no depender solo de un color.

## 14. Accesibilidad

Como mínimo:

- foco visible;
- orden lógico de navegación;
- labels comprensibles para código/revisión/estado;
- mensajes de gate asociados a la acción bloqueada;
- no usar color como única señal de published/warning/error;
- controles deshabilitados con explicación accesible.

## 15. Datos usados del fixture P-101 v2

En WS-01 solo se consume:

```text
engineeringLibrary.fmeaDefinition
engineeringLibrary.fmeaRevision
engineeringLibrary.governance
```

No se parseará visualmente `assetApplication` para completar este workspace, aunque el Runtime Adapter pueda cargarlo en memoria para etapas posteriores.

## 16. Fuera de alcance de WS-01

- edición de funciones/modos;
- evaluación AMEF;
- lógica RCM;
- tareas;
- aplicabilidad;
- P-101;
- criticidad;
- plan;
- resultados;
- persistencia productiva;
- aprobación productiva;
- permisos definitivos.

## 17. Preguntas que siguen `to_validate`

No bloquean la arquitectura de WS-01:

- catálogo definitivo de estados de revisión;
- número mínimo real de evidencias;
- workflow/roles de aprobación;
- política exacta de vigencia;
- nomenclatura corporativa definitiva de códigos;
- regla final para determinar cuándo crear una revisión nueva.

El laboratorio puede simular estos aspectos siempre que se etiqueten como `to_validate`.

## 18. Criterio de aceptación funcional

WS-01 estará funcionalmente validado cuando una persona en reunión pueda responder sin ambigüedad:

1. qué biblioteca está revisando;
2. qué revisión exacta está activa;
3. si puede modificarla;
4. qué evidencia/supuestos la soportan;
5. qué falta para avanzar;
6. qué objeto estructurado consumirá WS-02;
7. por qué P-101 todavía no forma parte de esta decisión.

## 19. Gate técnico pendiente

No se redacta YAML en este documento.

Antes del Bloque F01-01 debe completarse `F01-00 — Auditoría Power Apps Foundation` sobre una Canvas app real para confirmar dialecto Source Code, controles y componentes instalados.
