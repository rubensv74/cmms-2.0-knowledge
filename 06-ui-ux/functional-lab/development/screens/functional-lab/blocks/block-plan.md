# F01 — Plan de bloques incrementales

**Estado:** preparado; YAML bloqueado hasta TG-001  
**Pantalla objetivo:** `scr_FunctionalLab`  
**Primera vertical slice:** WS-01 Library & Revision

## 1. Regla

Cada bloque tiene una responsabilidad principal y no se redacta el siguiente YAML hasta validar el anterior en Power Apps Studio.

La secuencia se puede reordenar únicamente si la app baseline demuestra una dependencia técnica real.

## 2. F01-01 — Premium App Shell Foundation

### Responsabilidad

Crear únicamente la geometría y zonas del shell.

### Incluye

```text
scr_FunctionalLab
conFL_Root
conFL_Navigation
conFL_Content
conFL_Header
conFL_LayerContext
conFL_WorkspaceHost
conFL_StatusBar
conFL_OverlayLayer
```

### No incluye

- datos de fixture;
- P-101;
- lógica de navegación final;
- RCM/risk;
- gates funcionales;
- persistencia.

### Gate Studio

```text
[ ] Source Code accepted
[ ] screen saves
[ ] App Checker no new structural errors
[ ] no clipping/overflow accidental
[ ] desktop/tablet geometry viable
[ ] overlay layer not clipped
```

---

## 3. F01-02 — Layered Runtime State

### Responsabilidad

Inicializar estado por capa sin datos reales todavía o con records mínimos controlados.

### Conceptos

```text
LibraryState
AssetApplicationState
ExecutionPlanState
ResultsState
TraceState
AdapterDiagnostics
```

### Regla

No crear `P101CaseState` monolítico.

### Gate

```text
[ ] each aggregate can be dirty/read-only independently
[ ] published library can be read-only without freezing later layers
[ ] active layer/workspace state is independent from domain data
```

---

## 4. F01-03 — Runtime Adapter v2

### Responsabilidad

Cargar el fixture v2 al estado por capas.

### Entrada

`p101-case.v2.json` mediante el mecanismo confirmado en F01-00.

### Salida

Colecciones/records equivalentes al contrato de `runtime-adapter-v2.md`.

### Gate

```text
[ ] fixtureVersion validated
[ ] v1 rejected explicitly
[ ] library refs resolved
[ ] task-mode N:M preserved
[ ] asset criticality separate
[ ] plan refs resolved
[ ] result refs resolved
[ ] diagnostics visible
```

---

## 5. F01-04 — Navigation & Layer Context

### Responsabilidad

Implementar navegación base y hacer visible la capa/objeto activo.

### Incluye

- grupos Library/Application/Plan/Results;
- active workspace;
- layer context strip;
- lineage source label;
- disabled/simulated states básicos.

### Gate

```text
[ ] WS-01 shows Library as active layer
[ ] P-101 is not global context
[ ] WS-07 can show P-101 + source revision
[ ] navigation does not mutate domain state
```

---

## 6. F01-05 — WS-01 Definition & Revision

### Responsabilidad

Mostrar identidad reusable y revisión.

### Consume

```text
engineeringLibrary.fmeaDefinition
engineeringLibrary.fmeaRevision
```

### Incluye

- code/name/scope/owner;
- revision/status;
- source revision;
- rule version refs;
- published/read-only state.

### Gate

```text
[ ] definition/revision IDs visible or inspectable
[ ] published state unambiguous
[ ] no Asset fields
[ ] no edits allowed on published governed content
```

---

## 7. F01-06 — WS-01 Evidence & Revision Work

### Responsabilidad

Mostrar evidencia/supuestos y permitir únicamente el trabajo humano válido para la revisión simulada.

### Incluye

- evidence sources;
- validation state;
- change reason when appropriate;
- warnings `to_validate`;
- dirty state local de Library.

### No incluye

- funciones/modos;
- P-101;
- criticidad.

### Gate

```text
[ ] LibraryDirty changes only for library edits
[ ] published snapshot stays read-only
[ ] warnings distinguish demo rules from approved rules
```

---

## 8. F01-07 — WS-01 Gate

### Responsabilidad

Materializar `GATE-FMEA-LIBRARY-READY-001`.

### Comprueba

- definition/revision identity;
- parent relation;
- rule references;
- evidence demo condition;
- forbidden edits on published snapshot.

### UI

Gate panel explica:

```text
status
reason
object
rule/version
suggested action
validation status
```

### Gate Studio

```text
[ ] blocked state reproduced
[ ] warning state reproduced
[ ] passed state reproduced
[ ] CTA and gate explanation stay synchronized
```

---

## 9. F01-08 — WS-01 Output & Trace

### Responsabilidad

Producir el output estructurado para WS-02 y registrar trace event conceptual.

### Output

```text
layer
fmeaDefinitionId
fmeaRevisionId
revisionNumber
status
validationStatus
publishedSnapshotId
```

### Trace

```text
stageId
layer
objectType
objectId
sourceObjectId
humanDecision
actorRole
timestamp
validationStatus
```

### Gate

```text
[ ] output has no AssetId
[ ] output is ID-based
[ ] trace source is FmeaDefinition
[ ] WS-02 can consume without screen-text parsing
```

---

## 10. F01-09 — Hardening

### Responsabilidad

Cerrar la vertical slice WS-01.

### Estados

```text
NoFixture
LoadingFixture
Loaded
LoadedWithWarnings
Dirty
Blocked
Warning
ReadOnlyPublished
UnsupportedLegacyFixture
SaveLocalSuccess
Error
```

### Validación

```text
[ ] loading
[ ] empty
[ ] malformed/invalid fixture
[ ] legacy fixture
[ ] read-only published
[ ] dirty
[ ] blocked gate
[ ] warning
[ ] happy path
[ ] keyboard/focus
[ ] accessible labels
[ ] responsive desktop/tablet
[ ] App Checker
```

### Documentación

Actualizar:

- implementation status;
- compatibility si aparece error;
- screen specification;
- user guide;
- requirement/rule catalogs afectados.

---

## 11. Condición de salida de F01

No se considera finalizado por tener una pantalla visualmente completa.

F01 termina cuando:

1. el fixture v2 carga de forma controlada;
2. el runtime mantiene las cuatro capas separadas;
3. WS-01 permite identificar Definition/Revision;
4. published es read-only;
5. gate es explicable;
6. output es estructurado y no contiene asset;
7. App Checker y pruebas manuales están aceptables;
8. la documentación refleja exactamente lo construido.

## 12. Siguiente unidad

Solo después:

```text
F02 / WS-02 — Functions & Failure Structure
```

Su primer bloque deberá volver a pasar Domain Ownership Gate antes de YAML.
