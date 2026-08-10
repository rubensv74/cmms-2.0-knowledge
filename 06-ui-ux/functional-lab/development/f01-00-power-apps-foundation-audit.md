# F01-00 — Auditoría Power Apps Foundation

**Fecha:** 2026-08-10  
**Estado:** parcialmente completada — requiere validación en la app real antes de YAML

## 1. Objetivo

Cumplir el gate técnico previo al primer bloque Source Code del CMMS 2.0 Functional Lab.

## 2. Fuentes técnicas revisadas

Se han utilizado como referencia del método y del dialecto Power Apps ya probado:

- `rubensv74/app_pulse/docs/development/PROTOCOLO_IMPLEMENTACION_INCREMENTAL_ASISTIDA.md`
- `rubensv74/app_pulse/docs/development/PROTOCOLO_CONSTRUCCION_MODULAR_PANTALLAS_POWER_APPS.md`
- `rubensv74/app_pulse/docs/development/screens/punch-review/POWER_APPS_SOURCE_CODE_COMPATIBILITY.md`
- `rubensv74/app_pulse/docs/development/screens/home-pds/blocks/01_screen_shell.pa.yaml`

Como referencias obligatorias de diseño se adoptan además las piezas curadas en `rubensv74/functional-engineering-knowledge-base`:

- `20-patterns/ux-ui/saas-interface-archetype-selection.md`;
- `15-standards/ux-ui/power-apps-visual-quality-standard.md`;
- `15-standards/power-platform/reusable-power-apps-component-contract.md`;
- `30-playbooks/power-platform/modular-power-apps-screen-construction.md`.

La estrategia específica del proyecto queda documentada en:

- `06-ui-ux/functional-lab/design-system.md`.

## 3. Conclusiones transferibles confirmadas

### 3.1. Construcción por bloques

La pantalla debe construirse por piezas y validarse en Studio antes de avanzar.

### 3.2. El repositorio no demuestra que un CanvasComponent esté instalado

Una definición disponible en GitHub no garantiza que la app activa conozca ese componente.

Esto **no significa** que el Functional Lab se construya sin componentes premium.

La decisión vigente es:

- la arquitectura visual será premium desde Foundation;
- los componentes premium se reutilizarán o crearán de forma explícita;
- ningún YAML instanciará un componente hasta confirmar que está instalado en la app activa;
- si un componente fundacional es necesario y no está instalado, su incorporación se convierte en un paso previo del bloque.

### 3.3. No asumir propiedades por similitud

Las incompatibilidades registradas en Pulse obligan a confirmar control y versión antes de reutilizar propiedades.

### 3.4. El Runtime Adapter debe ser independiente

La carga del fixture P-101 se implementará después del shell y del runtime state, no embebida dentro del layout.

### 3.5. Datos de prueba separados

El fixture JSON canónico permanece en `cases/P101/`. Cualquier Power Fx generado para cargarlo será un adaptador, no otra fuente de verdad.

### 3.6. Arquetipo antes que controles

Antes del Bloque 01 de cada pantalla o workspace se declararán:

```text
PRIMARY_USER_TASK
SUCCESS_CRITERION
PRIMARY_ARCHETYPE
SECONDARY_PATTERNS
PREMIUM_COMPONENTS
```

Una etapa funcional no equivale automáticamente a una pantalla y no se impondrá un único arquetipo a toda la aplicación.

## 4. Arquitectura técnica inicial

Nombre lógico inicial del área host:

```text
scr_FunctionalLab
```

Árbol mínimo de referencia:

```text
scr_FunctionalLab
└── conFL_Root
    ├── conFL_Navigation
    └── conFL_Content
        ├── conFL_Header
        └── conFL_WorkspaceHost
```

Esta estructura no congela todavía el número final de pantallas. La selección de arquetipos por workspace puede demostrar que conviene separar workspaces en pantallas diferentes.

## 5. F01-01 — Premium App Shell Foundation

El Bloque 01 seguirá siendo pequeño y verificable, pero no será un shell visualmente provisional.

Debe establecer la base definitiva de:

- geometría global;
- navegación;
- jerarquía de superficies;
- tokens visuales mínimos;
- zonas de header y workspace;
- estados visuales fundamentales.

No incluirá todavía:

- fixture P-101;
- ParseJSON;
- navegación funcional completa entre las 28 etapas;
- cálculos funcionales;
- gates de negocio;
- flows;
- SQL;
- persistencia.

Los componentes premium fundacionales podrán formar parte del bloque si su instalación en la app activa ha sido confirmada previamente.

## 6. Secuencia técnica aprobada para F01

| Bloque | Responsabilidad | Dependencia |
|---|---|---|
| 01 | Premium App Shell Foundation | app base + componentes fundacionales confirmados |
| 02 | runtime state tipado | bloque 01 validado |
| 03 | adaptador P-101 | bloque 02 validado |
| 04 | navegación base | bloque 03 validado |
| 05 | WS-01 contexto visual | bloque 04 validado |
| 06 | WS-01 edición | bloque 05 validado |
| 07 | WS-01 gate | bloque 06 validado |
| 08 | WS-01 output | bloque 07 validado |
| 09 | hardening y documentación | bloque 08 validado |

## 7. Información que NO puede confirmarse todavía

Sin la app real abierta en Power Apps Studio no se puede confirmar de forma honesta:

- schema Source Code aceptado por esa app;
- versión efectiva de los controles que Studio insertará/aceptará;
- variables de tema existentes;
- componentes premium instalados;
- App Checker baseline;
- comportamiento al pegar el primer bloque;
- calidad visual real del shell.

## 8. Requisito mínimo para desbloquear Bloque 01

Debe existir una Canvas app vacía o baseline destinada al laboratorio, preferiblemente denominada:

```text
CMMS 2.0 Functional Lab
```

Antes del YAML se realizará un inventario de componentes disponibles en esa app y se decidirá cuáles son fundacionales para el shell.

## 9. Componentes premium de Pulse

Los componentes activos o candidatos maduros de Pulse son fuentes prioritarias de reutilización, no dependencias automáticas.

Candidatos iniciales:

```text
cmp_PageHeaderPro
cmp_SidebarNav
cmp_ActionToolbarPro
cmp_DataTableProV2
cmp_EmptyState
cmp_SkeletonLoader
cmp_KpiCardPro
cmp_DonutPro
cmp_HeatMapPro
cmp_PieChartPro
```

Criterio:

- reutilizar cuando el contrato encaje;
- no reutilizar solo por estética;
- confirmar instalación en Studio;
- validar visualmente con datos realistas;
- crear un componente nuevo cuando exista una necesidad reusable no cubierta.

## 10. Gate F01-00

```text
Static audit: PASSED
Architecture: PASSED
SaaS archetype strategy: PASSED
Premium component strategy: PASSED
Compatibility register: CREATED
Real Power Apps baseline: PENDING
Premium component inventory in active app: PENDING
Studio/App Checker baseline: PENDING
Visual baseline: PENDING
F01-01 YAML: BLOCKED until real app baseline exists
```

## 11. Próxima acción exacta

Crear/identificar la Canvas app del Functional Lab. Después:

1. inventariar controles y componentes disponibles;
2. confirmar qué componentes premium fundacionales se incorporan al shell;
3. declarar arquetipo, tarea y criterio de éxito del primer workspace;
4. redactar F01-01;
5. validar sintaxis, App Checker y calidad visual en Power Apps Studio.
