# CMMS 2.0 Knowledge Repository

Repositorio de conocimiento funcional del programa CMMS 2.0 y fuente trazable del **CMMS 2.0 Functional Lab**.

## Objetivo

Mantener una fuente consistente para:

- visión del producto;
- decisiones y reuniones;
- modelo funcional;
- reglas de negocio;
- modelo conceptual de datos;
- prototipos/evidencias históricas;
- Functional Lab en Power Apps;
- documentación funcional modular para IT.

## Fase actual

El proyecto está construyendo un **laboratorio funcional ejecutable en Power Apps** sobre el modelo ya alineado AMEF/RCM + activos + planes + trazabilidad.

El laboratorio no representa la arquitectura productiva final. Sirve para validar qué información necesita cada proceso, qué calcula/recomienda el sistema, qué debe decidir una persona, qué controles de avance existen y qué outputs se entregan al siguiente nivel.

## Navegación rápida

- [Estado actual](PROJECT_STATUS.md)
- [Estado Functional Lab](06-ui-ux/functional-lab/V2_STATUS.md)
- [Roadmap](ROADMAP.md)
- [Índice maestro](MASTER_INDEX.md)
- [Historial de cambios](CHANGELOG.md)
- [Visión del Functional Lab](01-vision/cmms-functional-lab-vision.md)
- [Functional Journey](02-functional/process-model/functional-journey.md)
- [Persona vs sistema](02-functional/process-model/human-system-decisions.md)
- [Functional Lab](06-ui-ux/functional-lab/README.md)
- [Paquete documental para IT](07-it-handoff/functional-document-set.md)

## Método de trabajo Power Apps

La autoridad de construcción modular es el playbook central:

`functional-engineering-knowledge-base/30-playbooks/power-platform/modular-power-apps-screen-construction.md`

Regla operativa:

```text
responsabilidad funcional
→ arquitectura
→ skeleton completo
→ placeholders
→ bloque S/C/I
→ Power Apps Studio
→ validar
→ freeze
→ siguiente bloque
```

Los fallos se corrigen mediante `FIX` del incremento afectado.

Power Apps Studio es el entorno principal de implementación/validación. GitHub conserva fuentes, documentación y evidencia, pero no es requisito para construir ni sustituye el runtime.

### Blindajes

- `S — Structural`, `C — Component`, `I — Integration`, `FIX` obligatorios;
- un propósito principal por bloque;
- `TOUCHES` y `DO NOT MODIFY` antes del YAML;
- geometría congelada después de aprobar skeleton;
- componentes reutilizables validados aisladamente antes de integración;
- identidad de componente preservada in situ;
- estructura, comportamiento, contrato de datos y color se congelan por separado;
- color/tokens se validan primero en `scr_DesignSystemLab`;
- no se propagan cambios cromáticos a piezas funcionalmente congeladas sin evidencia;
- no se avanza sobre un bloque fallido.

## Principios funcionales

1. Toda decisión relevante debe quedar documentada.
2. Las hipótesis se distinguen de requisitos validados.
3. Los recursos originales de `08-resources` no se modifican.
4. Los prototipos históricos se conservan como evidencia, no como fuente automática de requisitos.
5. JSON es la fuente canónica de los casos de ejemplo del Functional Lab, no una decisión de persistencia productiva.
6. `PROJECT_STATUS.md` y el Freeze Register deben reflejar el estado real, no el esperado.
