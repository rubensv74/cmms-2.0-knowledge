# AMEF–RCM Experience Center

**Estado:** prototipo histórico / material didáctico  
**Modelo canónico actual:** CMMS Functional Lab v2 — library-first

## Importante

El Experience Center fue decisivo para validar la narrativa AMEF–RCM, pero su recorrido ejecutable v3.0 fue construido con una estructura centrada en el caso P-101.

Tras la auditoría del Functional Lab, esa estructura **ya no es el modelo canónico de datos ni de navegación**.

El modelo vigente es:

```text
Engineering Library
→ Asset Application
→ Execution Plan
→ Results & Learning
```

La referencia canónica se encuentra en:

- `../../functional-lab/README.md`;
- `../../../03-data-model/core/fmea-library-model.md`;
- `../../../03-data-model/core/traceability-layers.md`;
- `../../functional-lab/cases/P101/p101-case.v2.json`.

## Qué se conserva del Experience Center

El prototipo sigue siendo útil para:

- explicar conceptos AMEF/RCM;
- recordar decisiones y preguntas surgidas en reuniones;
- comparar la evolución del modelo;
- revisar patrones didácticos, gates y narrativa;
- reutilizar contenido visual cuando no contradiga el modelo v2.

No debe utilizarse como fuente para inferir el modelo de datos actual.

## Ejecución histórica

La versión 3.0 puede seguir abriéndose con `index.html` y funciona offline. Su recorrido de 28 etapas comienza por P-101 y representa la **foundation asset-centric anterior a la remediación**.

No se desarrollarán nuevos requisitos sobre ese runtime. Las nuevas vertical slices se implementarán en CMMS Functional Lab utilizando el fixture v2.

## Guías revisadas

Las guías de negocio y el documento `docs/RECORRIDO_GUIADO_P101.md` han sido actualizados para enseñar el modelo library-first.

Por tanto existe deliberadamente una diferencia temporal:

```text
runtime HTML v3.0       = evidencia histórica
business guides v2      = modelo conceptual actual
Functional Lab v2       = destino de implementación
```

Esto evita reescribir un prototipo histórico y confundirlo con la nueva aplicación de validación.

## Estructura

- `index.html`: recorrido guiado histórico v3.0, asset-centric.
- `mapa-maestro/`: referencia conceptual histórica.
- `prototipos/01-*` a `05-*`: módulos de detalle reutilizables como material didáctico.
- `docs/RECORRIDO_GUIADO_P101.md`: recorrido objetivo alineado con Functional Lab v2.
- `docs/GUIAS_FLUJO_NEGOCIO.md`: principios de negocio library-first.
- `assets/business-flow-guide.js`: modales de guía actualizados al modelo v2.
- `package.ps1` y `package.sh`: empaquetado histórico reproducible.

## Límite

Los datos y decisiones siguen siendo ilustrativos. Ninguna frecuencia, umbral, matriz, criticidad, autoridad o instrucción incluida en estos prototipos constituye un estándar de mantenimiento aprobado.
