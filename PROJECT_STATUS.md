# Estado del proyecto

**Última actualización:** 2026-08-24

## Estado general

CMMS 2.0 continúa en la fase **Functional Lab**.

El núcleo AMEF + RCM mantiene la revisión funcional **v1.1** consolidada el 2026-08-14. La reunión del 2026-08-21 no exige rehacer ese journey, pero abre formalmente un **discovery de Gestión del Trabajo** para estudiar el proceso posterior al plan publicado.

En paralelo, el 2026-08-24 se acepta el track transversal **Asset Experience Redefinition** para revisar `Assets`, el sistema visual asociado y las pantallas de Asset Master sin crear una segunda biblioteca técnica 3D.

El laboratorio sigue teniendo como propósito validar el modelo funcional mediante casos ejecutables y producir documentación trazable para IT, sin convertir Power Apps ni el comportamiento del sistema actual en decisiones de arquitectura productiva.

## Cambio principal del 2026-08-24 — Asset Experience

Se formalizan tres decisiones:

1. **Revisar Assets** como superficie nuclear de CMMS 2.0, separando identidad, Technical Profile, Engineering Context, Visual Context y Maintenance Context.
2. **Revisar el sistema visual** que soporta esa experiencia: iconografía, jerarquía visual, semántica de estados/provenance y componentes premium compartidos.
3. **Reutilizar la colección 3D de AssetPlan** en lugar de crear una biblioteca CMMS duplicada. CMMS será consumidor gobernado de `AssetPlan Industrial Technical 3D`.

Documento canónico:

- `06-ui-ux/CMMS_ASSET_EXPERIENCE_REDEFINITION_V1.md`.

El catálogo de componentes incorpora candidatos `TO_VALIDATE` específicos del dominio Assets, y `06-ui-ux/branding/README.md` documenta la regla de iconografía y reutilización 3D.

Primer incremento ejecutable:

```text
AE-0 — Baseline y auditoría
```

Debe auditar pantalla Assets actual, componentes, iconografía, datos, fuentes y deuda antes de cerrar el diseño objetivo.

## Cambio principal del 2026-08-21

La reunión con Hernando aporta un primer flujo de referencia para órdenes de trabajo:

```text
Plan / calendario preventivo
→ inspecciones próximas
→ selección y propuesta del Maintenance Planner
→ validación o reprogramación por Maintenance Responsible
→ Supervisor opcional según estructura del proyecto
→ Technician / Executor
→ ejecución
```

Este recorrido procede del sistema actual y queda marcado como **AS-IS de referencia / `to_validate`**.

Se ha creado:

- `02-functional/process-model/work-management-discovery.md`;
- `05-meetings/2026/2026-08-21_revision-cmms-gestion-ordenes-trabajo.md`;
- `05-meetings/01_Analysis/ANL-003_revision-funcional-post-reunion-2026-08-21.md`;
- `06-ui-ux/functional-lab/work-management-extension.md`.

## Decisiones confirmadas o reforzadas

1. **Riesgo configurable:** la matriz debe adaptarse al cliente/proyecto.
2. **RCM explicable:** las preguntas y el criterio humano siguen siendo parte esencial de la decisión.
3. **Plan base + overrides:** una particularidad de un activo puede añadir/eliminar/modificar actividades sin alterar el plan genérico.
4. **Routing organizativo configurable:** Supervisor no puede ser un paso obligatorio porque la estructura cambia según el proyecto.
5. **Gestión del Trabajo es el siguiente dominio natural de discovery**, pero no se convierte todavía en workspace canónico.
6. **Assets se revisará como Object 360 técnico/operativo**, sin confundir ingeniería y mantenimiento.
7. **No se crea biblioteca 3D CMMS:** se reutiliza la colección gobernada de AssetPlan.

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

### Power Apps Foundation — F01-00 estático

- revisión de compatibilidad Source Code;
- shell técnico mínimo definido;
- secuencia F01-01 a F01-09;
- estrategia SaaS premium;
- foundation protegida contra hardcodes de riesgo, scoring RCM, relación rígida plan-activo y rutas organizativas futuras.

### Asset Experience — definición inicial

- decisión formal de revisar Assets;
- decisión formal de revisar iconografía, jerarquía visual y componentes premium;
- decisión formal de reutilizar AssetPlan Industrial Technical 3D;
- plan AE-0 → AE-7 documentado;
- candidatos de componentes registrados como `TO_VALIDATE`.

## En curso

### F01-00 — cierre en herramienta real

Falta disponer de la Canvas app real del Functional Lab para confirmar:

- schema Source Code aceptado;
- versiones reales de controles;
- baseline de App Checker;
- componentes premium instalados;
- aceptación del primer bloque en Power Apps Studio;
- baseline de calidad visual.

La revisión del 2026-08-21 **no bloquea WS-01**.

### AE-0 — Baseline y auditoría de Assets

Siguiente incremento del track Asset Experience:

- auditar Assets actual;
- inventariar componentes;
- inventariar iconografía;
- mapear datos y fuentes;
- revisar prototipos históricos de activos;
- clasificar REUSE / ADAPT / EXTEND / CREATE / RETIRE;
- identificar gaps antes del contrato AE-1.

## Próximos incrementos técnicos

### Functional Lab

1. F01-01 — Premium App Shell Foundation.
2. F01-02 — Runtime state mínimo compatible con configuración y decisiones trazadas.
3. F01-03 — Adaptador P-101 v1.1.
4. F01-04 — Navegación base.
5. F01-05 — WS-01 contexto visual premium.
6. F01-06 — WS-01 edición.
7. F01-07 — WS-01 gate de evidencia.
8. F01-08 — WS-01 output.
9. F01-09 — Hardening, Visual QA y documentación.

No se iniciará WS-02 hasta validar WS-01 en Power Apps Studio.

### Asset Experience

1. AE-0 — Baseline y auditoría.
2. AE-1 — Contrato de Asset Experience.
3. AE-2 — Sistema visual: iconografía, jerarquía y semántica.
4. AE-3 — Componentes premium compartidos.
5. AE-4 — Rediseño de pantallas.
6. AE-5 — Consumo gobernado de ilustraciones 3D AssetPlan.
7. AE-6 — Implementación incremental Power Apps.
8. AE-7 — Convergencia y rollout.

## Gates funcionales ya identificados

- antes de WS-03: contrato mínimo `RiskProfile`;
- antes de WS-04: contrato de árbol RCM sin scoring;
- antes de WS-06: `BasePlan`, `CandidateAssets`, `ApplicabilityDecision`, `AssetPlanOverride` y reglas de agrupación;
- antes de cerrar WS-08: output de publicación preparado para handoff operacional.

## Gates Asset Experience

- `AE-G0`: baseline Assets/visual auditado;
- `AE-G1`: contrato de datos, autoridad y semántica cerrado;
- `AE-G2`: sistema visual compatible con CMMS y reusable;
- `AE-G3`: componentes con contrato/lifecycle veraz;
- `AE-G4`: cada pantalla declara tarea, criterio de éxito, arquetipo y componentes;
- `AE-G5`: reuso 3D sin segunda fuente de verdad y con rendimiento aceptable;
- `AE-G6`: evidencia Power Apps real antes de promoción visual;
- `AE-G7`: convergencia sin rutas visuales legacy no gobernadas.

## Discovery de Gestión del Trabajo

Antes de diseñar workspaces de órdenes de trabajo deben superarse:

### WM-G01 — Demo del proceso real

Revisar la aplicación actual de Los Barrios y registrar:

- actores;
- secuencia;
- estados;
- decisiones;
- excepciones.

### WM-G02 — Check sheets reales

Separar correctamente:

- tarea de mantenimiento;
- procedimiento/checklist;
- orden de trabajo;
- captura de ejecución.

### WM-G03 — Planning/Scheduling

Validar:

- horizonte de selección;
- agrupación;
- ventanas;
- reprogramación;
- capacidad;
- turnos;
- asignación.

### WM-G04 — Costes y contratos

Abrir esta parte solo después de trabajar con Eduardo y/o perfiles de Contratos/Subcontratos.

## Impacto sobre la demo

El Functional Lab podrá explicar después de WS-08:

```text
PublishedPlanVersion
→ Annual Preventive Preparation
→ Work Management (discovery / to_validate)
```

Pero no debe presentar todavía una WO simulada como modelo aprobado ni ampliar P-101 con reglas de planning no validadas.

El ejemplo de **bomba con lubricación convencional vs lubricación por neblina** se conserva como caso pedagógico futuro para demostrar overrides en WS-06.

## Riesgos principales

- convertir el AS-IS de Los Barrios en TO-BE sin análisis;
- hardcodear Supervisor como paso obligatorio;
- inventar reglas de vencimiento, agrupación o scheduling;
- mezclar tarea, procedimiento y WO antes de revisar ejemplos reales;
- avanzar a costes/facturación sin los perfiles responsables;
- confundir el Functional Lab con la arquitectura productiva futura;
- convertir hipótesis conceptuales en automatismos;
- rediseñar Assets antes de cerrar fuentes y semántica de Technical Profile;
- crear componentes locales para patrones que deben ser compartidos;
- duplicar la colección 3D de AssetPlan dentro de CMMS;
- presentar Type Illustration como si fuera un modelo de ingeniería real.

## Fuentes de verdad principales

- `00-governance/cmms-functional-lab-incremental-protocol.md`
- `02-functional/process-model/functional-journey.md`
- `02-functional/process-model/human-system-decisions.md`
- `02-functional/process-model/work-management-discovery.md`
- `05-meetings/2026/2026-08-21_revision-cmms-gestion-ordenes-trabajo.md`
- `05-meetings/01_Analysis/ANL-003_revision-funcional-post-reunion-2026-08-21.md`
- `06-ui-ux/functional-lab/architecture.md`
- `06-ui-ux/functional-lab/implementation-status.md`
- `06-ui-ux/functional-lab/work-management-extension.md`
- `06-ui-ux/CMMS_ASSET_EXPERIENCE_REDEFINITION_V1.md`
- `06-ui-ux/CMMS_COMPONENT_CATALOG_V1.md`
- `06-ui-ux/branding/README.md`
- `ROADMAP.md`
