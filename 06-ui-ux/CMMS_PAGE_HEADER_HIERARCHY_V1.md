# CMMS 2.0 — Page Header Hierarchy V1

**Estado:** `ACTIVE / STRUCTURAL CONTRACT`; geometría exacta `TO_VALIDATE` hasta Foundation Studio gate.

## Jerarquía obligatoria

### N0 — Navigation
Responde: ¿a dónde puedo ir? Pertenece al shell, no al Page Header.

### N1 — Page Identity
Responde: ¿qué workspace/pantalla es esta?
Incluye título claro, subtítulo orientado a tarea/resultado y utilidades contextuales subordinadas.
No convertir el header en una tarjeta decorativa.

### N2 — Context Strip
Responde: ¿sobre qué caso/activo/configuración estoy trabajando?
Puede mostrar según workspace: activo, servicio, fase/etapa, estado de completitud, confianza, perfil/configuración activa y otros datos de contexto confirmados.
No mezcla KPIs ni decisiones del usuario con identidad de página.

### N3 — Summary / Gate — opcional
Responde: ¿qué estado requiere mi atención?
KPIs, readiness, gate status, warnings o resumen ejecutivo solo si ayudan a decidir. Es una capa separada del Page Header y del Context Strip.

### N4 — Functional Workspace
Responde: ¿qué puedo hacer aquí?
Contiene la arquitectura específica del arquetipo seleccionado.

## Orden estructural

`Navigation → Page Identity → Context Strip → Summary/Gate(optional) → Functional Workspace`.

La arquitectura actual `conLab_Header → conLab_ContextStrip → conLab_WorkspaceHost` es compatible y se mantiene como baseline conceptual.

## Invariantes

- una sola identidad principal por pantalla;
- contexto operativo visible cuando afecte al resultado;
- navegación e identidad no se fusionan;
- summary/gate no se incrusta en el header;
- acciones globales/utilitarias no compiten con la acción primaria del workspace;
- misma gramática visual entre workspaces, aunque cambie el arquetipo.

## Geometría

No fijar alturas/paddings/tipografía definitivos hasta validar el Premium App Shell Foundation en Power Apps Studio. Al cerrar F01, actualizar este documento con los valores observados y aceptados; desde ese momento pasan a ser contractuales.
