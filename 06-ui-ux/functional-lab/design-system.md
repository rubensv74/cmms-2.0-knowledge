# CMMS 2.0 Functional Lab — Estrategia de diseño SaaS Premium

**Estado:** activo  
**Fecha:** 2026-08-10  
**Ámbito:** diseño de interfaz y componentes del Functional Lab.

## 1. Decisión

CMMS 2.0 Functional Lab se diseñará utilizando como referencia obligatoria el conocimiento curado en `rubensv74/functional-engineering-knowledge-base`, especialmente:

- `20-patterns/ux-ui/saas-interface-archetype-selection.md`;
- `15-standards/ux-ui/power-apps-visual-quality-standard.md`;
- `15-standards/power-platform/reusable-power-apps-component-contract.md`;
- `30-playbooks/power-platform/modular-power-apps-screen-construction.md`.

Como fuentes de implementación probada se podrán consultar además los documentos y componentes activos de `rubensv74/app_pulse`.

## 2. Regla de diseño

Antes del Bloque 01 de cada pantalla o workspace se deben declarar:

```text
PRIMARY_USER_TASK
SUCCESS_CRITERION
PRIMARY_ARCHETYPE
SECONDARY_PATTERNS
PREMIUM_COMPONENTS
```

No se empieza por controles. Primero se define el trabajo que debe realizar el usuario y después se selecciona la arquitectura de interacción.

## 3. Arquetipos

No se impone un único arquetipo a toda la aplicación.

El shell global será común, pero cada workspace deberá declarar un arquetipo dominante. Entre los candidatos más probables para el Functional Lab están:

- `Object 360` para contexto de activo/caso;
- `Operational Review Workspace` para revisión secuencial y toma de decisiones;
- `Data Explorer` para funciones, fallos, modos, tareas o relaciones cuando el volumen lo requiera;
- `Workflow Builder` para lógicas de decisión cuando la interacción sea realmente de construcción/configuración de reglas;
- `Configuration Studio` para catálogos, matrices o reglas gobernadas;
- `Audit Timeline` para trazabilidad y reconstrucción del razonamiento;
- `Exception Resolution Queue` para observaciones, bloqueos y excepciones;
- `Operational Control Tower` solo cuando exista una necesidad real de priorización agregada y drill-down operativo.

La selección se validará por workspace. Una etapa funcional no equivale automáticamente a una pantalla.

## 4. Componentes premium

La aplicación debe construirse con una biblioteca de componentes premium reutilizables.

`premium` significa aquí **calidad visual y contractual enterprise**, no una decisión sobre licenciamiento Power Apps Premium.

Principios:

1. reutilizar componentes activos o candidatos maduros de Pulse cuando su contrato encaje;
2. no reutilizar un componente solo por similitud visual;
3. importar y validar cada componente en la app activa antes de instanciarlo desde YAML;
4. crear un nuevo componente canónico cuando exista una necesidad repetible no cubierta;
5. documentar inputs, outputs, eventos, estados y forma de datos;
6. mantener estado por instancia y evitar dependencias ocultas de variables globales;
7. separar componentes visuales de reglas de negocio y orquestación.

Componentes de Pulse que se evaluarán como candidatos iniciales:

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

No todos deben instalarse. Cada incorporación debe justificarse por una necesidad funcional real.

## 5. Diseño premium desde Foundation

El enfoque incremental no significa construir primero una interfaz pobre para embellecerla después.

Desde el primer bloque deben quedar definidos:

- tokens visuales;
- shell y geometría;
- jerarquía tipográfica;
- navegación;
- superficies y bordes;
- estados de interacción;
- estrategia responsive;
- comportamiento loading/empty/error;
- criterios de accesibilidad;
- contrato de componentes previstos.

Los primeros bloques pueden ser estructuralmente mínimos, pero deben pertenecer desde el inicio a la arquitectura visual definitiva.

## 6. Gate visual

Un bloque puede superar sintaxis y App Checker y seguir fallando visualmente.

Además del gate técnico se exigirá:

```text
[ ] jerarquía visual coherente
[ ] sin clipping ni scroll accidental
[ ] contenido realista probado
[ ] estados Selected/Hover/Focus/Disabled cuando apliquen
[ ] loading/empty/error visibles
[ ] color semántico, no decorativo
[ ] foco visible
[ ] geometría consistente
[ ] densidad adecuada
[ ] revisión en Power Apps Studio
```

## 7. Consecuencia sobre F01

F01-01 seguirá siendo un incremento pequeño, pero ya no se considera un `shell neutro`.

Será el **Premium App Shell Foundation** del Functional Lab.

Antes de redactar su YAML deben estar confirmados en la app real:

- formato Source Code;
- controles y versiones disponibles;
- componentes premium que ya estén instalados;
- estrategia para incorporar los componentes fundacionales que falten;
- baseline visual y de App Checker.

No se avanzará a F01-02 hasta validar el shell en Studio.
