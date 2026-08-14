# CMMS 2.0 Functional Lab

## Propósito

Aplicación Canvas Power Apps para validar el modelo funcional de CMMS 2.0 mediante casos ejecutables, sin convertir el prototipo en arquitectura productiva.

## Fuentes principales

- `../../01-vision/cmms-functional-lab-vision.md`
- `../../02-functional/process-model/functional-journey.md`
- `../../02-functional/process-model/human-system-decisions.md`
- `../../00-governance/cmms-functional-lab-incremental-protocol.md`
- `../../05-meetings/01_Analysis/ANL-002_revision-funcional-post-reunion-2026-08-14.md`
- `architecture.md`

## Revisión funcional 2026-08-14

La foundation se ha revisado con las conclusiones de la reunión del 14 de agosto.

El laboratorio debe respetar desde ahora estos principios:

- riesgo configurable por proyecto/cliente; una matriz 5×5 es solo una configuración de ejemplo;
- RCM representado como árbol lógico sin scoring acumulado;
- criterios de factibilidad técnica y efectividad visibles y trazables;
- plan genérico + candidatos de aplicabilidad + decisión humana + overrides por activo;
- agrupación de actividades compatible con frecuencia/activo, sin inventar todavía el algoritmo exacto de duración/horas-hombre;
- publicación con handoff conceptual hacia generación anual explícita de órdenes preventivas;
- planning/scheduling, ejecución, costes y facturación permanecen `to_validate` y no se simularán como procesos cerrados.

## Contratos

- `contracts/functional-journey.schema.json`
- `contracts/case-fixture.schema.json`

Antes de implementar WS-03, WS-04 y WS-06 deberán añadirse contratos mínimos específicos para `RiskProfile`, árbol RCM y aplicabilidad/overrides respectivamente.

## Casos

- `cases/P101/p101-case.v1.json`

P-101 es el caso inicial y procede del AMEF–RCM Experience Center existente. Desde fixture v1.1, cualquier matriz o valor de configuración utilizado en el caso se declara como ejemplo y no como estándar fijo del producto.

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

La revisión funcional del 2026-08-14 no bloquea WS-01, pero el runtime state no debe introducir supuestos rígidos que impidan después soportar perfiles configurables, aplicabilidad y overrides.

## Límite

El laboratorio no debe presentarse como:

- aplicación productiva;
- diseño final de pantallas;
- decisión de base de datos;
- definición de APIs;
- integración final con el CMMS existente;
- sistema real de órdenes de trabajo;
- motor productivo de planificación/programación;
- sistema de costes o facturación.

Cuando un workspace alcance una frontera todavía abierta, la demo mostrará el output y el siguiente proceso esperado, pero lo etiquetará claramente como pendiente de validación.
