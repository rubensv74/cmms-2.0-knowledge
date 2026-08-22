# Estado del proyecto

**Última actualización:** 2026-08-22  
**Rama de consolidación activa:** `baseline/premium-powerapps-v1`

## Estado general

CMMS 2.0 continúa en fase **Functional Lab**, pero ya existe una baseline suficientemente consolidada para iniciar construcción real en Power Apps.

El núcleo AMEF + RCM mantiene la revisión funcional **v1.1**. La Gestión del Trabajo permanece en discovery y no se convierte todavía en modelo objetivo.

La estrategia de implementación queda fijada así:

```text
Premium Power Apps UI
→ Functional State
→ Data Contract
→ Data Provider
```

Proveedor inicial:

```text
Mock Collections
```

Evolución prevista:

```text
Mock Collections
→ SQL + Power Automate
→ API / backend modular cuando exista una necesidad real
```

La UI no debe depender del origen físico de los datos.

## Cambio principal del 2026-08-22

Se ha creado la rama:

```text
baseline/premium-powerapps-v1
```

Su objetivo es servir como punto estable para desarrollar el prototipo premium sin seguir mezclando decisiones consolidadas, hipótesis y arquitectura futura.

### P0 — Consolidated Baseline

**Estado:** completed.

Se han incorporado:

- `00-governance/consolidated-baseline-premium-powerapps-v1.md`;
- `06-ui-ux/functional-lab/development/premium-powerapps-implementation-plan-v1.md`;
- `07-it-handoff/data-provider-transition-strategy.md`.

### Preparación repositorio hasta el siguiente gate real

Se han añadido además:

- `06-ui-ux/functional-lab/development/mock-data-provider-contract-v1.md`;
- `06-ui-ux/functional-lab/development/premium-shell-specification-v1.md`;
- `06-ui-ux/functional-lab/development/p1-power-apps-baseline-gate.md`;
- `07-it-handoff/sql/cmms-core-ddl-candidate-v0.1.sql`.

Con esto están preparados desde repositorio:

- contrato inicial de colecciones;
- contrato mínimo de WS-01;
- estrategia de IDs estables;
- separación `colCfg_*`, `colData_*`, `colState_*`, `colView_*`;
- operaciones funcionales del proveedor mock;
- shell premium candidato;
- estados visuales y de gate;
- procedimiento exacto para cerrar P1 en Power Apps Studio;
- primer DDL candidato conservador para la parte estructuralmente madura.

## Decisiones congeladas para desarrollo

1. **Power Apps será un laboratorio funcional ejecutable**, no la definición de la arquitectura productiva.
2. **Premium desde Foundation**: no habrá una UI provisional que deba rediseñarse después.
3. **Datos sintéticos en colecciones**, pero únicamente detrás de un proveedor/adaptador central.
4. **No se permiten datos fuente hardcodeados dentro de controles o pantallas.**
5. **JSON sigue siendo fixture documental canónico**, pero Power Apps no está obligado a leer JSON en cada demo.
6. **Datos fuente, estado mutable y vistas derivadas se separan.**
7. **La UI consume contratos lógicos**, no SQL, Flow o JSON directamente.
8. **DDL contract-first e incremental.**
9. **Riesgo configurable** por proyecto/cliente.
10. **RCM explicable y sin scoring inventado.**
11. **Recomendación del sistema separada de decisión humana.**
12. **Plan base separado de overrides por activo.**
13. **Routing organizativo configurable** donde dependa del proyecto.
14. **No convertir discovery en comportamiento canónico.**

## DDL candidato

El primer DDL se ha limitado deliberadamente a:

```text
AnalysisCase
AssetContext snapshot
OperatingMode
EvidenceSource
AssetFunction
FunctionalFailure
FailureMode
FailureEffect
DecisionTrace
GateResult
V_CaseContext
```

No se han creado todavía tablas físicas para:

- matriz/perfil de riesgo detallado;
- árbol RCM;
- plan físico definitivo;
- aplicabilidad/overrides definitivos;
- work orders;
- planning/scheduling;
- costes;
- contratos;
- facturación.

Motivo: esas áreas todavía tienen gates funcionales o discovery pendiente. Crear tablas ahora produciría falsa sensación de cierre.

## Completado

### Foundation Functional Lab — F00

- auditoría de transición;
- protocolo incremental;
- visión y límites;
- Functional Journey AMEF + RCM de 28 etapas / 9 workspaces;
- matriz persona vs sistema;
- contratos JSON base;
- fixture P-101 v1.1;
- arquitectura conceptual;
- paquete documental para IT;
- revisión funcional 2026-08-14;
- revisión funcional 2026-08-21;
- discovery inicial de Gestión del Trabajo.

### Premium consolidation — P0

- baseline consolidada;
- estrategia del proveedor temporal;
- plan de implementación;
- contrato del mock provider;
- shell premium candidato;
- gate P1 documentado;
- DDL core candidato v0.1.

## En curso / siguiente gate real

### P1 — Canvas App real y baseline técnica

**Estado:** ready / blocked only by real Canvas App.

Debe existir o identificarse:

```text
CMMS 2.0 Functional Lab
```

Y registrar desde Power Apps Studio:

- schema Source Code aceptado;
- resolución/layout real;
- versiones reales de controles;
- componentes premium disponibles;
- theme baseline;
- App Checker baseline;
- specimen mínimo de Source Code;
- comportamiento visual de contenedores.

Documento operativo:

- `06-ui-ux/functional-lab/development/p1-power-apps-baseline-gate.md`.

No existe más trabajo de repositorio que justifique retrasar este gate.

## Después de P1

Orden inmediato:

```text
P1 Canvas baseline
→ P2 Premium App Shell
→ P3 Mock Data Provider
→ P4 Runtime State
→ P5 Navigation + Demo Mode
→ P6 WS-01 vertical slice
```

WS-01 deberá demostrar:

```text
mock data
→ functional state
→ premium UI
→ human edit
→ gate
→ structured output
```

No se iniciará WS-02 hasta validar WS-01 en Power Apps Studio.

## Gates funcionales posteriores

- antes de WS-03: contrato mínimo `RiskProfile`;
- antes de WS-04: contrato de árbol RCM sin scoring;
- antes de WS-06: `BasePlan`, `CandidateAssets`, `ApplicabilityDecision`, `AssetPlanOverride` y reglas de agrupación;
- antes de cerrar WS-08: output de publicación preparado para handoff operacional.

## Discovery de Gestión del Trabajo

El flujo observado sigue siendo AS-IS de referencia:

```text
Plan / calendario preventivo
→ inspecciones próximas
→ Maintenance Planner
→ validación o reprogramación por Maintenance Responsible
→ Supervisor opcional según proyecto
→ Technician / Executor
→ ejecución
```

Estado: `to_validate`.

Antes de diseñar workspaces canónicos deben superarse:

- WM-G01 — demo y observación del proceso real;
- WM-G02 — revisión de check sheets reales;
- WM-G03 — planning/scheduling;
- WM-G04 — costes y contratos.

El Functional Lab puede mostrar el handoff después de publicación, pero no debe presentar todavía una WO simulada como modelo aprobado.

## Riesgos principales

- convertir colecciones en una base de datos informal;
- hardcodear datos dentro de pantallas;
- construir nueve workspaces antes de validar WS-01;
- esconder reglas funcionales en Power Fx;
- cerrar DDL de dominios inmaduros;
- convertir el AS-IS de Los Barrios en TO-BE;
- hardcodear Supervisor como paso obligatorio;
- inventar reglas de vencimiento, agrupación o scheduling;
- avanzar a costes/facturación sin perfiles responsables;
- confundir el Functional Lab con la arquitectura productiva futura.

## Fuentes de verdad principales

- `00-governance/consolidated-baseline-premium-powerapps-v1.md`
- `02-functional/process-model/functional-journey.md`
- `02-functional/process-model/human-system-decisions.md`
- `02-functional/process-model/work-management-discovery.md`
- `06-ui-ux/functional-lab/architecture.md`
- `06-ui-ux/functional-lab/design-system.md`
- `06-ui-ux/functional-lab/development/premium-powerapps-implementation-plan-v1.md`
- `06-ui-ux/functional-lab/development/mock-data-provider-contract-v1.md`
- `06-ui-ux/functional-lab/development/premium-shell-specification-v1.md`
- `06-ui-ux/functional-lab/development/p1-power-apps-baseline-gate.md`
- `07-it-handoff/data-provider-transition-strategy.md`
- `ROADMAP.md`
