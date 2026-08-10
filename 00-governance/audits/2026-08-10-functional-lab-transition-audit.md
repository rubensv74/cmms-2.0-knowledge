# Auditoría de transición — CMMS 2.0 Functional Lab

**Fecha:** 2026-08-10  
**Estado:** Base para la nueva fase  
**Rama de trabajo:** `agent/functional-lab-foundation`

## 1. Objetivo

Evaluar si el repositorio actual está preparado para pasar de prototipos HTML conceptuales a un laboratorio funcional ejecutable en Power Apps, manteniendo la trazabilidad hacia la documentación funcional que deberá recibir IT.

## 2. Fuentes inspeccionadas

Se han revisado, como mínimo:

- `README.md`
- `MASTER_INDEX.md`
- `PROJECT_STATUS.md`
- `ROADMAP.md`
- `CHANGELOG.md`
- `00-governance/DOCUMENTATION_RULES.md`
- `05-meetings/02-Specifications/SPC-001_ESPECIFICACION_CODEX_AMEF_RCM.md`
- `06-ui-ux/html-prototypes/amef-rcm-experience-center/README.md`
- `06-ui-ux/html-prototypes/amef-rcm-experience-center/docs/RECORRIDO_GUIADO_P101.md`
- `06-ui-ux/html-prototypes/amef-rcm-experience-center/assets/guided-core.js`
- `06-ui-ux/html-prototypes/amef-rcm-experience-center/assets/guided-stages-1.js`
- `06-ui-ux/html-prototypes/amef-rcm-experience-center/assets/guided-stages-2.js`

Como referencia metodológica externa al repositorio se ha revisado la versión activa del protocolo de Pulse:

- `rubensv74/app_pulse/docs/development/PROTOCOLO_IMPLEMENTACION_INCREMENTAL_ASISTIDA.md` — v2.0.
- `rubensv74/app_pulse/docs/development/PROTOCOLO_CONSTRUCCION_MODULAR_PANTALLAS_POWER_APPS.md` — v1.0.

## 3. Hallazgos

### 3.1. El conocimiento funcional ya supera al vehículo HTML

El Experience Center contiene un recorrido P-101 de 28 etapas con pregunta de negocio, datos, acciones, validaciones, gates y salidas. Esto ya constituye un modelo de interacción funcional y no solo un prototipo visual.

Conclusión: los HTML deben conservarse como evidencia y material explicativo, pero dejan de ser el vehículo principal de descubrimiento.

### 3.2. Existe suficiente base para iniciar el Functional Lab

El repositorio ya contiene:

- decisiones funcionales cerradas;
- entidades y relaciones preliminares;
- requisitos funcionales y reglas de negocio;
- un caso P-101 coherente de extremo a extremo;
- un recorrido didáctico de 28 etapas;
- criterios de AMEF, RCM, plan, aprobación y mejora continua.

No es necesario inventar un nuevo modelo para comenzar.

### 3.3. La estructura documental declarada y la real no coinciden

`MASTER_INDEX.md` referencia áreas como `01-vision/`, `02-functional/`, `03-data-model/` y `04-diagrams/`, pero parte de esa estructura todavía no existe en el repositorio actual.

Consecuencia: el conocimiento maduro sigue viviendo principalmente dentro de reuniones, especificaciones para prototipos y carpetas de UI/UX.

### 3.4. El estado y el roadmap están retrasados respecto del repositorio

`PROJECT_STATUS.md` y `CHANGELOG.md` siguen centrados en el ciclo P04 de julio, mientras el Experience Center v3 y el dossier posterior ya avanzaron el modelo durante agosto.

`ROADMAP.md` mezcla tres dimensiones que deben separarse:

1. mapa funcional del producto;
2. secuencia de validación conceptual;
3. madurez real de cada dominio.

### 3.5. El caso P-101 debe convertirse, no recrearse

Los valores del caso están actualmente embebidos en JavaScript (`guided-core.js`). Deben convertirse a fixtures JSON canónicos para que puedan alimentar:

- el Functional Lab;
- pruebas;
- documentación;
- futuras conversiones a otras fuentes de datos.

### 3.6. JSON es fuente canónica de ejemplos, no una decisión de backend

Power Fx dispone de `ParseJSON` para interpretar texto JSON, pero el hecho de almacenar fixtures en JSON dentro del repositorio no obliga a que Power Apps lea archivos JSON remotos en producción.

Para la fase conceptual se separarán dos capas:

- **fixture canónico:** JSON versionado en GitHub;
- **adaptador runtime:** mecanismo concreto que cargue ese fixture en colecciones Power Apps durante el prototipo.

La persistencia productiva queda fuera de alcance hasta que exista una decisión arquitectónica específica.

## 4. Riesgos

### R-01 — Convertir Power Apps en arquitectura de producto

El Functional Lab puede sesgar decisiones si se interpreta como diseño técnico final.

**Mitigación:** cada documento y pantalla debe distinguir requisito funcional, decisión del prototipo y decisión técnica pendiente para IT.

### R-02 — Confundir etapa de negocio con pantalla

Las 28 etapas del recorrido no deben producir 28 pantallas.

**Mitigación:** agrupar etapas en workspaces coherentes y mantener el journey como contrato independiente de la UI.

### R-03 — Codificar reglas antes de validarlas

Un cálculo o gate implementado demasiado pronto puede parecer una regla corporativa aprobada.

**Mitigación:** cada regla tendrá estado `hypothesis`, `to_validate`, `validated` o `approved`.

### R-04 — Crear documentación monolítica

Un único documento funcional acabaría mezclando proceso, reglas, datos, pantallas, roles e integración.

**Mitigación:** documentación modular con trazabilidad cruzada.

### R-05 — Mezclar datos de prueba con datos reales

Los fixtures P-101 son ejemplos realistas, no datos aprobados de mantenimiento.

**Mitigación:** carpetas `cases/` y `fixtures/` separadas, metadatos explícitos y prohibición de tratarlos como instrucciones operativas.

## 5. Decisión de transición

Se adopta el siguiente principio de trabajo:

> El Functional Lab será una aplicación de validación funcional. Su misión es hacer ejecutable el razonamiento de negocio, descubrir pantallas y decisiones y producir documentación funcional trazable. No define por sí mismo la arquitectura productiva de CMMS 2.0.

## 6. Método de desarrollo

El desarrollo seguirá el Protocolo de Implementación Incremental Asistida por IA usado en Pulse, con una adaptación adicional:

> **Gate funcional antes de gate técnico.**

Ningún bloque de pantalla se implementará hasta que su responsabilidad funcional tenga definidos al menos:

- objetivo;
- inputs;
- regla o cálculo automático;
- decisión humana;
- gate de avance;
- outputs;
- trazabilidad documental.

Después se aplicará el gate técnico de Power Apps Studio / App Checker correspondiente al protocolo de Pulse.

## 7. Resultado de la auditoría

**READY WITH FOUNDATION WORK**

El proyecto está preparado para iniciar el Functional Lab, pero el primer incremento debe ser documental y contractual, no visual.

Orden inmediato:

1. consolidar visión y principios;
2. formalizar el Functional Journey;
3. formalizar el contrato JSON;
4. convertir P-101 a fixture canónico;
5. definir arquitectura de workspaces;
6. solo entonces iniciar el primer bloque Power Apps.
