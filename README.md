# CMMS 2.0 Knowledge Repository

Repositorio de conocimiento funcional del programa CMMS 2.0 y fuente de verdad del **CMMS 2.0 Functional Lab**.

## Objetivo

Mantener una fuente trazable para:

- visión del producto;
- decisiones y reuniones;
- modelo funcional;
- reglas de negocio;
- modelo conceptual de datos;
- prototipos y evidencias históricas;
- Functional Lab en Power Apps;
- documentación funcional modular para IT.

## Fase actual

El proyecto está pasando de prototipos HTML conceptuales a un **laboratorio funcional ejecutable en Power Apps**.

El laboratorio no representa la arquitectura productiva final. Se utiliza para validar, mediante casos de ejemplo, qué información necesita cada proceso, qué calcula el sistema, qué recomienda, qué debe decidir una persona, qué gates existen y qué outputs se generan.

## Navegación rápida

- [Estado actual](PROJECT_STATUS.md)
- [Roadmap](ROADMAP.md)
- [Índice maestro](MASTER_INDEX.md)
- [Historial de cambios](CHANGELOG.md)
- [Visión del Functional Lab](01-vision/cmms-functional-lab-vision.md)
- [Functional Journey](02-functional/process-model/functional-journey.md)
- [Persona vs sistema](02-functional/process-model/human-system-decisions.md)
- [Functional Lab](06-ui-ux/functional-lab/README.md)
- [Paquete documental para IT](07-it-handoff/functional-document-set.md)

## Método de trabajo

El Functional Lab se desarrolla con el Protocolo de Implementación Incremental Asistida por IA utilizado en Pulse y adaptado a CMMS 2.0.

Regla central:

> Validar responsabilidad funcional → definir arquitectura → implementar una pieza → guardar → validar en Power Apps Studio → corregir → documentar → continuar.

No se avanza sobre errores abiertos.

## Principios

1. Toda decisión relevante debe quedar documentada.
2. Las hipótesis se distinguen de requisitos validados.
3. Los recursos originales de `08-resources` no se modifican.
4. Los prototipos históricos se conservan como evidencia, no como fuente automática de requisitos.
5. JSON es la fuente canónica de los casos de ejemplo del Functional Lab, no una decisión de persistencia productiva.
6. `PROJECT_STATUS.md` debe reflejar el estado real del proyecto.
