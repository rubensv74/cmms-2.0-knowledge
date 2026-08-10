# CMMS 2.0 Functional Lab

## Propósito

Aplicación Canvas Power Apps para validar el modelo funcional de CMMS 2.0 mediante casos ejecutables, sin convertir el prototipo en arquitectura productiva.

## Fuentes principales

- `../../01-vision/cmms-functional-lab-vision.md`
- `../../02-functional/process-model/functional-journey.md`
- `../../02-functional/process-model/human-system-decisions.md`
- `../../00-governance/cmms-functional-lab-incremental-protocol.md`
- `architecture.md`

## Contratos

- `contracts/functional-journey.schema.json`
- `contracts/case-fixture.schema.json`

## Casos

- `cases/P101/p101-case.v1.json`

P-101 es el caso inicial y procede del AMEF–RCM Experience Center existente.

## Principio de desarrollo

El laboratorio seguirá el protocolo incremental utilizado en Pulse.

Orden obligatorio:

```text
Auditoría
→ responsabilidad funcional
→ arquitectura
→ bloque pequeño
→ repositorio
→ validación en Power Apps Studio
→ corrección
→ documentación
→ siguiente bloque
```

## Estructura prevista de implementación

```text
06-ui-ux/functional-lab/
├── README.md
├── architecture.md
├── implementation-status.md
├── contracts/
├── cases/
├── development/
│   ├── compatibility.md
│   ├── screens/
│   │   └── functional-lab/
│   │       ├── README.md
│   │       ├── screen-architecture.md
│   │       ├── blocks/
│   │       └── user-guide/
│   └── adapters/
└── power-apps/
    ├── screens/
    ├── components/
    └── runtime/
```

Las carpetas de código se crearán cuando comience el primer incremento técnico. No se introducirán YAML vacíos.

## Primera vertical slice

La primera funcionalidad completa será `WS-01 Caso y contexto`:

- seleccionar/cargar P-101;
- mostrar identificación y contexto;
- mostrar evidencia disponible;
- permitir editar datos de demostración;
- distinguir datos existentes e input humano;
- ejecutar el gate de preparación;
- producir una salida consumible por WS-02.

No se implementará WS-02 hasta validar WS-01 en Power Apps Studio.

## Límite

El laboratorio no debe presentarse como:

- aplicación productiva;
- diseño final de pantallas;
- decisión de base de datos;
- definición de APIs;
- integración final con el CMMS existente.
