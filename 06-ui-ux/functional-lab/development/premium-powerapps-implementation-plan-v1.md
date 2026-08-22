# CMMS 2.0 Functional Lab — Premium Power Apps Implementation Plan v1

**Estado:** active plan  
**Fecha:** 2026-08-22  
**Rama:** `baseline/premium-powerapps-v1`

## 1. Objetivo

Construir una versión premium y ejecutable del CMMS 2.0 Functional Lab en Power Apps con datos sintéticos locales, manteniendo desde el principio una arquitectura que permita sustituir posteriormente el proveedor de datos por SQL + Power Automate y, cuando corresponda, por una API/backend modular.

## 2. Estrategia

Se trabajará mediante vertical slices pequeños y verificables.

Cada incremento deberá producir algo visible en Power Apps Studio y conservar la separación:

```text
Presentation
↔ Functional State
↔ Contract
↔ Provider
```

La primera versión del Provider será local y sintética.

## 3. Fases

### P0 — Freeze de baseline

**Estado:** completed — 2026-08-22.

**Objetivo:** evitar que el desarrollo arranque sobre decisiones contradictorias.

Entregables completados:

- baseline consolidada;
- decisiones `confirmed`, `to_validate` y `future architecture` separadas;
- mapa actual de workspaces;
- lista de gates funcionales;
- reglas de no-hardcode;
- estrategia de sustitución del Data Provider;
- contrato inicial de Mock Data Provider;
- shell premium candidato;
- DDL core candidato deliberadamente limitado a dominios maduros.

Documentos principales:

- `00-governance/consolidated-baseline-premium-powerapps-v1.md`;
- `06-ui-ux/functional-lab/development/mock-data-provider-contract-v1.md`;
- `06-ui-ux/functional-lab/development/premium-shell-specification-v1.md`;
- `07-it-handoff/data-provider-transition-strategy.md`;
- `07-it-handoff/sql/cmms-core-ddl-candidate-v0.1.sql`.

### P1 — Canvas App real y baseline técnica

**Estado:** ready / blocked only by real Canvas App.

**Objetivo:** eliminar la incertidumbre que actualmente bloquea F01-01.

Acciones:

1. crear/identificar `CMMS 2.0 Functional Lab`;
2. registrar formato Source Code que acepta la app;
3. registrar resolución y configuración responsive;
4. inventariar controles modernos/clásicos disponibles;
5. inventariar componentes reutilizables instalados;
6. obtener App Checker baseline;
7. documentar convenciones de nombres;
8. capturar baseline visual;
9. conservar un specimen Source Code mínimo validado.

Documento operativo:

- `06-ui-ux/functional-lab/development/p1-power-apps-baseline-gate.md`.

**Gate:** no generar bloques complejos antes de validar el dialecto real de la app.

### P2 — Premium App Shell Foundation

**Objetivo:** crear la arquitectura visual definitiva desde el inicio.

Incluir:

- sidebar/navigation rail;
- page header;
- workspace host;
- context strip;
- action area;
- overlay/modal layer;
- loading/empty/error surfaces;
- tokens de spacing, radius, typography y semantic states.

Especificación candidata:

- `06-ui-ux/functional-lab/development/premium-shell-specification-v1.md`.

No incluir todavía lógica AMEF/RCM.

**Criterios:**

- apariencia enterprise/premium;
- jerarquía visual clara;
- navegación comprensible en reunión;
- sin clipping/scroll accidental;
- focus/hover/selected/disabled definidos;
- geometría reusable.

### P3 — Mock Data Provider Foundation

**Objetivo:** disponer de datos de demo realistas sin acoplarlos a pantallas.

Crear:

- catálogo de colecciones;
- contrato de campos;
- dataset P-101;
- configuración de demo;
- rutina central de carga;
- reset/reload del caso;
- IDs estables.

Familias:

```text
colCfg_*
colData_*
colState_*
colView_*
```

Contrato:

- `06-ui-ux/functional-lab/development/mock-data-provider-contract-v1.md`.

**Regla:** ningún workspace crea su propio universo de datos mediante `ClearCollect` dispersos.

### P4 — Runtime State Foundation

**Objetivo:** separar fixture y estado mutable.

Debe distinguir:

- source data;
- user changes;
- system calculations;
- system recommendations;
- human decisions;
- gate results;
- structured outputs.

Estados mínimos:

```text
NoCase
LoadingCase
Loaded
Dirty
Calculating
Blocked
Warning
Success
Error
```

### P5 — Navigation + Demo Mode

**Objetivo:** permitir una demo fluida sin falsificar el estado funcional.

Debe permitir:

- avanzar cuando gate lo permita;
- retroceder;
- saltar en modo presentación;
- visualizar qué etapas están completas, pendientes, bloqueadas o simuladas;
- regresar al resumen del caso.

El modo presentación no debe marcar automáticamente gates como aprobados.

### P6 — Vertical Slice WS-01

**Objetivo:** validar de extremo a extremo el patrón de desarrollo.

Implementar:

1. contexto del caso;
2. datos existentes;
3. inputs humanos;
4. edición local;
5. gate de evidencia;
6. explicación del bloqueo;
7. output estructurado hacia WS-02;
8. dirty/reset;
9. empty/error states;
10. Visual QA.

**Gate de salida:** WS-01 debe quedar usable en reunión y técnicamente preparado para cambiar de proveedor de datos.

### P7 — WS-02 Funciones y fallos

Construir únicamente tras validar WS-01.

Objetivo:

```text
Asset / Context
→ Functions
→ Functional Failures
→ Failure Modes
```

Debe demostrar edición, relaciones y trazabilidad.

### P8 — WS-03 Riesgo configurable

Gate previo: `RiskProfile` mínimo versionado.

No se permite hardcodear una matriz 5×5 como regla del producto.

El fixture puede usar 5×5, pero la UI debe consumir configuración.

### P9 — WS-04 RCM explicable

Gate previo: contrato de árbol RCM.

Debe persistir en estado local:

```text
question
answer
evidence
branch
feasibility
effectiveness
system recommendation
human confirmation
```

No scoring RCM acumulado salvo metodología validada explícita.

### P10 — WS-05 Economía y tarea

Objetivo: demostrar la transición desde política seleccionada hacia tarea de mantenimiento y frecuencia.

Las reglas económicas aún no validadas deberán marcarse como demo/configuración, no como verdad productiva.

### P11 — WS-06 Recursos, aplicabilidad y variantes

Gate previo:

- `BasePlan`;
- `CandidateAssets`;
- `ApplicabilityDecision`;
- `AssetPlanOverride`;
- contrato de agrupación inicial.

Caso de demo recomendado:

- bomba base con lubricación convencional;
- activo equivalente con lubricación por neblina;
- override específico sin mutar el plan genérico.

### P12 — WS-07 Trazabilidad y calidad

Debe permitir reconstruir:

- input utilizado;
- configuración;
- recomendación del sistema;
- decisión humana;
- razón;
- estado de validación;
- versión.

### P13 — WS-08 Revisión, publicación y handoff

Output:

```text
PublishedPlanVersion
```

Debe mostrar frontera explícita hacia:

```text
Annual Preventive Preparation
→ Work Management (discovery / to_validate)
```

No generar todavía WO como comportamiento canónico.

### P14 — WS-09 Efectividad y mejora

Usar resultados reales simulados para demostrar cierre de loop y nueva revisión/versionado.

### P15 — SQL Readiness

**Objetivo:** preparar la transición sin conectar todavía la app.

Existe ya un DDL core candidato inicial, limitado a entidades estructuralmente maduras. P15 no se considera adelantado por ello: deberá completar y validar el modelo cuando los contratos funcionales restantes estén maduros.

Entregables:

- modelo conceptual actualizado;
- DDL candidato por dominio maduro;
- claves y relaciones;
- tablas de configuración;
- tablas de decisión/trazabilidad;
- estrategia de versionado;
- índices candidatos;
- matriz Collection ↔ Contract ↔ SQL;
- operaciones read/write necesarias.

### P16 — Provider Swap: SQL + Power Automate

Sustituir gradualmente el proveedor mock.

Orden recomendado:

1. lecturas simples;
2. lecturas compuestas/proyecciones;
3. escrituras controladas;
4. decisiones y trazabilidad;
5. publicación/versionado;
6. operaciones transaccionales mediante flows/SP/API según riesgo.

Cada sustitución debe preservar el contrato consumido por la UI.

### P17 — API Readiness / Backend Modular

No implementar una API por anticipación.

Definirla cuando existan operaciones que justifiquen:

- lógica de dominio compartida;
- transacciones multi-entidad;
- integración externa;
- seguridad centralizada;
- rendimiento/control no apropiado para Canvas/Flow;
- consumo desde varios clientes.

La app debe llegar a esta fase sin depender de SQL directo en la capa de presentación.

## 4. Orden de prioridad real

La prioridad inmediata es:

```text
P0 Baseline                 COMPLETED
→ P1 Canvas real            NEXT GATE
→ P2 Premium Shell
→ P3 Mock Provider
→ P4 Runtime State
→ P5 Navigation
→ P6 WS-01 vertical slice
```

No conviene diseñar ahora todas las pantallas en detalle. Primero debe probarse una sola vertical completa y reutilizable.

## 5. Criterios de aceptación de cada workspace

Cada workspace debe aprobar cinco gates.

### Functional Gate

- responde a una tarea de usuario concreta;
- no inventa reglas `to_validate`;
- separa recomendación y decisión humana.

### Data Gate

- consume contratos definidos;
- no depende de estructura accidental de un control;
- datos sintéticos coherentes y realistas.

### Technical Gate

- App Checker sin nuevos errores no aceptados;
- comportamiento estable;
- fórmulas mantenibles;
- sin dependencias ocultas innecesarias.

### Visual Gate

- calidad premium;
- jerarquía y densidad correctas;
- estados completos;
- accesibilidad básica;
- usable en reunión sin explicación constante de la interfaz.

### Migration Gate

- origen de datos sustituible;
- reglas relevantes fuera de la UI;
- contrato documentado;
- mapeo futuro a persistencia posible.

## 6. Principales riesgos a evitar

- hardcodear datos directamente en controles;
- usar colecciones como sustituto informal de un modelo de datos;
- construir todos los workspaces antes de validar WS-01;
- cerrar DDL de dominios todavía inmaduros;
- esconder reglas en Power Fx;
- acoplar pantallas a consultas SQL futuras;
- convertir AS-IS de Los Barrios en TO-BE;
- hacer una UI de demo que después deba tirarse para conectar datos reales;
- confundir premium visual con exceso de decoración.

## 7. Resultado esperado de la primera milestone demostrable

La primera milestone debe permitir abrir la app y ejecutar una historia completa de WS-01 con calidad visual alta:

```text
seleccionar/cargar P-101
→ comprender el activo y su contexto
→ revisar evidencia
→ modificar/confirmar información
→ visualizar el gate
→ resolver faltantes
→ aprobar contexto
→ generar output hacia Funciones y Fallos
```

Eso será la prueba de que la arquitectura del prototipo funciona antes de escalar al resto del CMMS.
