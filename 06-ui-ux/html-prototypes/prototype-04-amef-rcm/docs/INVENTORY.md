# Arquitectura e inventario

## Convenciones reutilizadas

- Prototipos en `06-ui-ux/html-prototypes/`, autonomos, en espanol y sin build.
- `Segoe UI`/`Inter`, fondo neutro, superficies blancas, azul de accion y navegacion oscura.
- Shell lateral, cabecera, progreso, paneles, tablas, estados, avisos y modales.
- JavaScript nativo con vistas y datos simulados.

Se conserva el lenguaje visual, con radio maximo de 8 px, y se separan datos, reglas y presentacion.

## Arquitectura local minima

```text
prototype-04-amef-rcm/
|-- index.html
|-- README.md
|-- docs/
|-- src/
|   |-- app.js
|   |-- state/{initial-state,store}.js
|   |-- data/{demo-case,catalogs}.js
|   |-- rules/{validations,risk-engine,rcm-engine,applicability-engine}.js
|   |-- components/
|   |-- views/
|   `-- styles/{tokens,base,components,responsive}.css
`-- tests/{validation,rcm,applicability}-tests.js
```

P04.0 materializa el control y la documentacion. Los archivos de runtime nacen cuando su sprint aporte comportamiento verificable.

## Vistas

| Vista | Responsabilidad | Sprint |
|---|---|---|
| Landing pedagogica | Paso 0, caso y recorrido | P04.1 |
| Workspace | Pasos 1-9, stepper y contexto | P04.1-P04.5 |
| Arbol AMEF ampliado | Funcion a efectos | P04.2 |
| Arbol RCM | Preguntas, evidencia y resultado | P04.3 |
| Aplicabilidad | Reglas, perfiles y activos | P04.4 |
| Revision y aprobacion | Completitud, etapas y snapshot | P04.5 |
| Trazabilidad | Cadena extremo a extremo | P04.5 |

## Componentes

`AppShell`, `WizardStepper`, `ContextHeader`, `WhyThisMatters`, `FormSection`, `EditableDataTable`, `FmeaTree`, `RiskMatrix`, `RcmDecisionTree`, `DecisionEvidencePanel`, `TaskCoverageMatrix`, `ApplicabilityTable`, `ApprovalTimeline`, `TraceabilityDrawer`, `ValidationSummary`, `StatusBadge`, `Toast` y `ConfirmDialog`.

Todos incorporan foco visible, etiqueta/ayuda, estados con texto y color, correccion accionable y acceso a `Ver datos y reglas`.

## Estado

Una raiz `prototypeState` contiene `analysisHeader`, `operationalContext`, `functions`, `proposedTasks`, `noTaskDecisions`, `applicabilityRules`, `assetApplications`, `approvalStages`, `changeLog` y `uiState`. Las relaciones usan IDs legibles y los datos derivados no se duplican.

`uiState` conserva paso/vista, modo seleccionado, cambios sin guardar, escenario, paneles, errores y persistencia. No contiene datos de negocio.

## Datos, configuracion y reglas

- `demo-case.js`: `P-101A`, `P-101B`, modo principal, modo oculto, tareas y cuatro activos.
- `catalogs.js`: tipos, causas, efectos, consecuencias, matriz 5x5, arbol RCM, roles, evidencias, unidades, estados y aprobaciones.
- `validations.js`: avance, integridad, justificaciones, cierre, publicacion e inmutabilidad.
- `risk-engine.js`: resultado reproducible desde configuracion versionada.
- `rcm-engine.js`: siguiente pregunta y recomendacion, incluida informacion insuficiente.
- `applicability-engine.js`: sugerencia explicable, exclusion, revision y perfiles.

## Supuestos de prototipo

- `localStorage` es opcional, reiniciable y solo para la demo.
- Autores, fechas, evidencias, aprobaciones y snapshots se etiquetan como simulados.
- No se presupone CDN. Los iconos se resolveran con recursos locales o simbolos accesibles.
