# F01-02/03 — Adaptador Runtime P-101

**Estado:** candidato para validación en Studio  
**Caso canónico:** `cases/P101/p101-case.v1.json`

## Objetivo

Convertir el fixture canónico P-101 en un estado runtime simple y observable dentro del Functional Lab, manteniendo separadas:

- fuente canónica del caso;
- representación runtime de Power Apps;
- cambios futuros del usuario;
- cálculos y recomendaciones futuras.

## Decisión de laboratorio

Para este incremento se utiliza **Power Fx generado desde el fixture JSON**.

Esto es un adaptador sustituible. No define:

- persistencia productiva;
- backend;
- SQL/Dataverse;
- API;
- integración CMMS.

## Estado runtime mínimo

Variables principales:

```text
varFL_RuntimeInitialized
varFL_CaseLoaded
varFL_CaseState
varFL_CaseDirty
varFL_CaseId
varFL_CaseName
varFL_CaseDisclaimer
varFL_AssetCode
varFL_AssetName
varFL_Plant
varFL_Service
varFL_Boundary
varFL_DutyFlowM3h
varFL_DutyPressureBar
varFL_Redundancy
varFL_Constraints
varFL_DataConfidence
```

Colecciones iniciales:

```text
colFL_OperatingModes
colFL_EvidenceSources
colFL_Functions
colFL_FunctionalFailures
colFL_FailureModes
```

## Mapeo inicial

```text
asset.*                       → variables de contexto del activo
operationalContext.*          → variables + colFL_OperatingModes
evidence.sources              → colFL_EvidenceSources
evidence.dataConfidence       → varFL_DataConfidence
functions                     → colFL_Functions + colFL_FunctionalFailures
failureAnalysis.failureModes  → colFL_FailureModes
failureAnalysis.focusMode     → IsFocus=true en FM-03
```

## Estados

```text
LoadingCase
Loaded
Dirty
Error
```

En este incremento se ejercitan `LoadingCase` y `Loaded`; `Dirty` queda inicializado pero se utilizará al comenzar la edición real de WS-01.

## Validación visible

La propia pantalla debe demostrar que el adaptador funciona mostrando datos procedentes del estado runtime:

- P-101;
- nombre del activo;
- unidad;
- servicio;
- límites;
- 120 m³/h;
- 6 bar;
- P-102 en reserva automática;
- confianza Media-alta;
- fuentes de evidencia;
- funciones y modos de fallo cargados.

No se considera completado si las colecciones existen pero el usuario no puede comprobar visualmente que el caso real ha sido cargado.