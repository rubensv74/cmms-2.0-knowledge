# Estado del proyecto

**Última actualización:** 2026-08-22  
**Rama de consolidación activa:** `baseline/premium-powerapps-v1`

## Estado general

CMMS 2.0 ha superado la etapa en la que el `Functional Lab` servía como principal modelo de construcción.

La aplicación que se construirá en Power Apps es la **interfaz funcional futura de CMMS 2.0**, usando datos sintéticos únicamente como proveedor temporal hasta incorporar SQL + Power Automate y, cuando se justifique, una capa API/backend.

El alcance de la primera gran versión termina en:

```text
Published Maintenance Plan
```

Work Management, scheduling, work orders, ejecución, costes reales y facturación permanecen fuera de este primer scope de construcción hasta completar discovery.

## Decisión principal del 2026-08-22

Se confirma:

1. construir la aplicación completa hasta publicación del plan, no una demo basada en un caso;
2. `ADR` es el registro físico maestro de activos;
3. `FLH`, `Equipment Taxonomy` y `ADR` son tres estructuras diferentes y relacionadas;
4. existirán bibliotecas corporativas + extensiones project-specific + promoción gobernada;
5. Risk Profile / Matrix Configuration es una función explícita de Project Setup;
6. Equipment Taxonomy tendrá una biblioteca visual 3D gobernada;
7. los datos sintéticos implementan temporalmente contratos de producto y no determinan la arquitectura de la UI.

Documento de decisión:

- `00-governance/decisions/2026-08-22-product-interface-scope.md`

## Fuentes rectoras nuevas

### Product Map

- `01-vision/cmms-2.0-product-map-v1.md`

Define módulos, alcance, relación Corporate/Project y recorrido completo hasta publicación.

### Screen Catalog

- `06-ui-ux/product-screen-catalog-v1.md`

Define las pantallas canónicas, tarea dominante, arquetipo SaaS y patrones secundarios.

### Equipment Taxonomy Foundation

- `02-functional/master-data/equipment-taxonomy-library-foundation-v1.md`

Consolida el estudio inicial de ISO 14224, IEC 81346, CFIHOS, ETIM, ECLASS, MIMOSA CCOM e ISO 55000 y define el modelo de biblioteca corporativa.

## Mapa funcional activo

```text
HOME / PORTFOLIO
        ↓
PROJECT SETUP
        ↓
CORPORATE LIBRARIES
        ↓
FLH + PROJECT TAXONOMY + ADR
        ↓
ASSET REGISTER / ASSET 360
        ↓
CRITICALITY
        ↓
AMEF / FMEA
        ↓
RCM
        ↓
TASKS / JOB PLANS / STRATEGIES
        ↓
APPLICABILITY + ASSET OVERRIDES
        ↓
MAINTENANCE PLAN
        ↓
REVIEW / APPROVAL / VERSION
        ↓
PUBLISHED MAINTENANCE PLAN
```

## Pantallas canónicas

El catálogo v1 contiene 33 superficies agrupadas en:

- Home / Portfolio;
- Project Setup;
- Corporate Libraries;
- Assets;
- Maintenance Engineering;
- Maintenance Planning;
- Governance;
- Administration.

Las pantallas históricas WS-01…WS-09 siguen siendo conocimiento útil para AMEF/RCM, pero ya no representan la navegación ni el roadmap de construcción de la app.

## Tres árboles / estructuras maestras

### FLH

Estructura funcional/localización del proyecto.

### Equipment Taxonomy

Clasificación del tipo de equipo.

### ADR

Registro de activos físicos y composición parent/child.

Un activo ADR se enlaza con:

- Functional Location;
- Taxonomy Class;
- technical data;
- manufacturer/model;
- documents;
- criticality;
- maintenance engineering;
- maintenance plan.

## Risk Profile

Cada proyecto debe poder seleccionar o derivar un perfil versionado.

Debe soportar:

- dimensiones configurables;
- niveles por dimensión;
- rangos/labels;
- matriz/bandas;
- thresholds;
- colores semánticos;
- reglas de override/sobreclasificación;
- versionado y aprobación;
- impact analysis.

No existe una matriz 5×5 fija como regla del producto.

## Equipment Taxonomy Library

### Resultado del primer estudio

No se adopta una única norma como taxonomía completa.

Se utilizarán de forma complementaria:

- ISO 14224 para reliability/maintenance data y vocabulario de fallos/equipos cuando aplique;
- IEC 81346 para principios de estructuración/clasificación e identificación;
- CFIHOS para patrones de RDL, propiedades, mappings, sinónimos y governance;
- ETIM/ECLASS como referencias de clasificación semántica y propiedades técnicas;
- MIMOSA CCOM como referencia de `Equipment Class → Product Model → Serialized Asset` e interoperabilidad O&M;
- estándares específicos de equipo (API/ISO/IEC/etc.) cuando aporten subtipos o atributos útiles.

### Modelo corporativo

Cada clase podrá relacionarse con:

- technical field profile;
- failure knowledge;
- maintenance knowledge;
- synonyms;
- external mappings;
- standards/documents;
- 3D equipment visuals;
- version/governance.

## Equipment Visual Library

Las imágenes 3D se convierten en contenido corporativo gobernado vinculado a Taxonomy Class.

Uso principal:

- Equipment Taxonomy Library;
- Project Taxonomy Builder;
- ADR Builder;
- Asset Register thumbnail;
- Asset 360 hero/fallback.

En AMEF/RCM se utilizarán solo como contexto secundario.

## Datos y arquitectura técnica

La regla vigente continúa siendo:

```text
Premium UI
→ Functional State / View Model
→ Data Contract
→ Provider
```

Proveedor inicial:

```text
Synthetic Power Apps Collections
```

Evolución:

```text
Mock Provider
→ SQL + Power Automate
→ API / backend when justified
```

No se permiten datos maestros embebidos accidentalmente en controles.

## Estado de trabajo

### Completado / consolidado

- reuniones y aprendizaje AMEF/RCM anteriores;
- Functional Journey AMEF/RCM como fuente funcional;
- discovery inicial Work Management;
- baseline antiacoplamiento de proveedor;
- visión premium;
- decisión de construir producto funcional completo;
- Product Map v1;
- Screen Catalog v1;
- Equipment Taxonomy Library research foundation v1;
- matriz de riesgo identificada como configuración canónica de proyecto;
- biblioteca visual 3D incorporada al modelo.

### Siguiente bloque de diseño

Antes de construir pantallas complejas en Power Apps se deben cerrar los contratos de las superficies fundacionales:

1. Premium App Shell / navegación;
2. Project Profile + Maintenance Configuration;
3. Risk Profile;
4. Equipment Taxonomy Library;
5. Project Taxonomy Builder;
6. FLH Builder;
7. ADR Builder;
8. Asset Register / Asset 360.

En paralelo debe continuar la investigación de la taxonomía por familias, empezando por `Rotating Equipment`.

## Próximo gate Power Apps

Crear/identificar la Canvas App real destinada a CMMS 2.0 y validar:

- Source Code dialect;
- layout/resolution;
- componentes disponibles;
- theme/tokens;
- App Checker baseline;
- responsive behavior;
- premium shell.

La app ya no debe denominarse ni organizarse conceptualmente como `Functional Lab`.

Nombre recomendado:

```text
CMMS 2.0
```

## Discovery que permanece abierto

### Work Management

Continúan pendientes:

- flujo objetivo de WO;
- check sheets;
- planning/scheduling;
- capacidad/turnos;
- asignación;
- execution feedback.

### Costes / contratos

Pendiente incorporar conocimiento de perfiles responsables antes de modelar:

- actual maintenance cost;
- contract/subcontract allocation;
- billing/integration.

## Riesgos principales

- volver a diseñar el producto alrededor de un único caso de demo;
- confundir FLH, Taxonomy y ADR;
- copiar una norma industrial como taxonomía completa sin adaptar a necesidad funcional;
- crear demasiadas subclases por fabricante/modelo/tamaño;
- duplicar clases por disciplina;
- hardcodear Risk Matrix;
- permitir que un proyecto cambie silenciosamente Corporate Library;
- usar imágenes 3D como decoración en vez de como sistema visual de clase;
- ocultar reglas de negocio en Power Fx;
- cerrar SQL antes de estabilizar contratos;
- diseñar Work Management antes de completar discovery.

## Fuentes de verdad principales

- `00-governance/decisions/2026-08-22-product-interface-scope.md`
- `01-vision/cmms-2.0-product-map-v1.md`
- `02-functional/master-data/equipment-taxonomy-library-foundation-v1.md`
- `06-ui-ux/product-screen-catalog-v1.md`
- `02-functional/process-model/functional-journey.md`
- `02-functional/process-model/human-system-decisions.md`
- `02-functional/process-model/work-management-discovery.md`
- `07-it-handoff/data-provider-transition-strategy.md`
- `ROADMAP.md`
