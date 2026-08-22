# CMMS 2.0 — Equipment Taxonomy Library Foundation v1

**Fecha:** 2026-08-22  
**Estado:** research baseline / active design input  
**Scope:** fundamentos de la biblioteca corporativa de clases de equipo.

## 1. Objetivo

Definir una base sólida para construir una `Equipment Taxonomy Library` corporativa reutilizable en todos los proyectos CMMS 2.0.

La biblioteca no debe ser una lista improvisada de equipos ni una copia literal de una única norma. Debe ser un modelo corporativo gobernado, extensible y trazable a fuentes industriales reconocidas.

## 2. Conclusión principal del estudio

No existe una única fuente que cubra exactamente todas las necesidades de CMMS 2.0.

Las fuentes revisadas aportan piezas complementarias:

### ISO 14224:2016

Aporta una base específica para datos de confiabilidad y mantenimiento, incluyendo taxonomía de equipos, atributos, datos de fallos y datos de mantenimiento.

Valor para CMMS:

- lenguaje de reliability/maintenance;
- separación de equipment data, failure data y maintenance data;
- patrones de clasificación y atributos relevantes para R&M;
- vocabulario útil de fallos.

Limitación:

- su ámbito principal es petroleum, petrochemical and natural gas;
- no debe convertirse en la única taxonomía para todos los sectores.

Fuente pública: https://www.iso.org/standard/64076.html

### IEC 81346-1:2022 + IEC 81346-2:2019

Aportan principios horizontales para estructurar sistemas y clasificar objetos técnicos mediante reference designations y clases.

Valor para CMMS:

- separación entre vistas/estructuras de un mismo sistema;
- identificación inequívoca;
- clasificación horizontal aplicable a múltiples disciplinas/industrias;
- evita mezclar función, localización y producto físico.

Fuentes públicas:

- https://www.iso.org/standard/82229.html
- https://webstore.iec.ch/en/publication/29181

### IEC 81346-14:2026

Amplía los principios de 81346 para manufacturing and processing systems.

Valor para CMMS:

- especialmente relevante para plantas industriales de proceso/manufactura;
- refuerza la necesidad de estructuras y clasificaciones coherentes para identificación y documentación.

Fuente pública: https://www.iso.org/standard/86477.html

### CFIHOS / JIP36

Aporta un Reference Data Library y un modelo explícito de clases de tag/equipment, propiedades, sinónimos, mappings, source standards y relaciones entre clases, equipos, modelos y tags.

Valor para CMMS:

- diseño de gobernanza de clases;
- IDs estables;
- sinónimos;
- trazabilidad de fuente;
- propiedades asociadas a clases;
- mapping con otros códigos/estándares;
- separación entre class, tag, equipment y model/part;
- patrón muy útil para handover → asset master.

Fuentes públicas:

- https://www.jip36-cfihos.org/how-it-works/
- https://www.jip36-cfihos.org/datamodel/v2.0/EARoot/EA2/EA168.htm
- https://www.jip36-cfihos.org/wp-content/uploads/2022/08/CFIHOS-RDL-Development-Guide.pdf

### ETIM

Aporta un modelo maduro de clasificación de productos técnicos con groups, classes, synonyms, features, values y units, con IDs independientes del idioma.

Valor para CMMS:

- patrón de propiedades técnicas por clase;
- sinónimos y búsqueda;
- IDs estables;
- product-class semantics;
- utilidad como referencia complementaria, sobre todo para ámbitos eléctricos/técnicos.

Fuentes públicas:

- https://www.etim-international.com/classification/
- https://www.etim-international.com/classification/model-information/

### ECLASS

Aporta una clasificación y descripción semántica extensa para productos/objetos industriales y un modelo de propiedades técnicas con identificadores únicos.

Valor para CMMS:

- semántica y propiedades;
- engineering/CAx reference;
- mapping de clases y atributos;
- patrón de identificadores estables.

Fuentes públicas:

- https://eclass.eu/en/eclass-standard/basic-advanced
- https://eclass.eu/support/technical-specification/structure-and-elements/classification-class

### MIMOSA CCOM

Aporta un information model orientado a intercambio de información del ciclo de vida de activos y conceptos de Equipment Class Template, Product Model y Serialized Asset con hojas O&M y parámetros.

Valor para CMMS:

- separación `Equipment Class → Product Model → Serialized Asset`;
- atributos O&M por clase/modelo/activo;
- metadatos de parámetros;
- futura interoperabilidad.

Fuentes públicas:

- https://www.mimosa.org/mimosa-ccom/
- https://www.mimosa.org/mimosa-ccom/managing-complex-machinery-specifications/

### ISO 55000:2024

No define una taxonomía de equipos, pero aporta el marco general de asset management y ciclo de vida.

Valor para CMMS:

- recordatorio de que la clasificación es un medio para gestionar activos y valor durante el ciclo de vida, no un fin en sí mismo.

Fuente pública: https://www.iso.org/standard/83053.html

## 3. Decisión de diseño

CMMS 2.0 mantendrá una **Corporate Equipment Taxonomy propia**, con mappings explícitos a estándares externos cuando proceda.

No se copiarán tablas propietarias completas de normas de pago ni se asumirá que un código externo es el ID interno del producto.

Patrón:

```text
CMMS Taxonomy Class
├── stable internal ID
├── corporate code
├── preferred name
├── definition
├── synonyms
├── parent class
├── discipline / family
├── technical field profile
├── failure knowledge links
├── maintenance knowledge links
├── 3D visual profile
├── governance/version
└── external mappings[]
    ├── ISO 14224 when relevant
    ├── IEC 81346 class/code when relevant
    ├── CFIHOS
    ├── ETIM
    ├── ECLASS
    ├── API / ISO equipment standard
    └── client/company code
```

## 4. Taxonomy ≠ FLH ≠ ADR

### Equipment Taxonomy

Clasifica qué tipo de equipo es.

### FLH

Representa la estructura funcional/localización del proyecto.

### ADR

Contiene los activos físicos concretos y su composición.

Ejemplo:

```text
Taxonomy:
Rotating Equipment > Pumps > Centrifugal Pumps

FLH:
Plant > Unit > Cooling Water System > Pumping Area

ADR:
P-101A Pump Package
├── P-101A Pump
├── M-101A Motor
└── CPL-101A Coupling
```

No deben fusionarse en un único árbol.

## 5. Modelo de clase propuesto

Campos conceptuales mínimos:

```text
TaxonomyClassId
ClassCode
PreferredName
Definition
ParentClassId
HierarchyPath
DisciplineCode
ClassKind
IsAbstract
IsSelectableForAsset
Status
Version
ValidFrom
ValidTo
SourceType
GovernanceOwner
CreatedAt
UpdatedAt
```

### `ClassKind`

Valores candidatos:

- Family;
- EquipmentClass;
- EquipmentSubtype;
- ComponentClass;
- PackageClass.

No deben usarse estos valores para imponer una profundidad fija.

## 6. Metadata asociada a clase

### 6.1 Synonyms

Necesarios para:

- búsqueda;
- terminología cliente;
- abreviaturas;
- nombres legacy;
- términos multilingües.

### 6.2 External mappings

Cada mapping debe registrar:

```text
SourceSystemOrStandard
ExternalCode
ExternalName
ExternalVersion
MappingType
MappingConfidence
Notes
```

`MappingType` candidato:

- Exact;
- Broader;
- Narrower;
- Related;
- ClientAlias.

### 6.3 Technical Field Profile

Una clase define qué campos técnicos son:

- Required;
- Recommended;
- Optional;
- Conditional;
- NotApplicable.

El valor pertenece al activo/modelo correspondiente, no a la definición del campo.

### 6.4 Failure Knowledge

Una clase puede relacionarse con:

- typical failure modes;
- failure mechanisms;
- typical effects;
- common existing controls;
- evidence/source references.

Estos elementos son conocimiento reusable, no un AMEF aprobado automáticamente para cada activo.

### 6.5 Maintenance Knowledge

Una clase puede relacionarse con:

- candidate maintenance tasks;
- Job Plan templates;
- inspection techniques;
- condition-monitoring methods;
- recommended evidence sources.

La aplicación nunca debe convertir una relación de biblioteca en un plan aprobado sin análisis/aplicabilidad.

## 7. Equipment Visual Library

La imagen 3D se tratará como contenido gobernado vinculado a una clase.

Contrato conceptual:

```text
EquipmentVisual
├── VisualId
├── TaxonomyClassId
├── VisualRole
├── VariantCode
├── MediaReference
├── BackgroundMode
├── CameraView
├── Status
├── Version
├── Source
├── IsDefault
└── AltText
```

`VisualRole` candidato:

- Hero3D;
- Thumbnail3D;
- AlternateView3D;
- Schematic;
- Icon.

Fallback:

```text
asset real photo
→ exact class 3D
→ parent class 3D
→ equipment family visual
→ discipline generic visual
```

## 8. Corporate / Project behavior

### Corporate taxonomy

El owner corporativo puede:

- crear clases;
- editar drafts;
- definir technical fields;
- relacionar knowledge libraries;
- añadir/mantener mappings;
- gobernar visuals;
- validar impacto;
- versionar;
- publicar/deprecar.

### Project Taxonomy Builder

El proyecto puede:

- seleccionar ramas corporativas;
- excluir clases que no aplican;
- marcar clases obligatorias en el proyecto;
- añadir extensiones project-specific;
- definir overrides permitidos;
- comparar Project vs Corporate;
- solicitar promoción de una extensión;
- actualizarse a nuevas versiones corporativas mediante proceso controlado.

Nunca:

- modifica directamente la versión corporativa publicada;
- cambia otras configuraciones de proyecto;
- promueve automáticamente una clase local.

## 9. Arquitectura inicial de familias

Esta lista es una **estructura candidata de cobertura**, no una taxonomía final ni una reproducción de una norma.

```text
Equipment / Maintainable Object
├── Rotating Equipment
├── Static / Pressure Equipment
├── Heat Transfer Equipment
├── Piping, Valves & Mechanical Components
├── Electrical Equipment
├── Instrumentation, Control & Analyzers
├── Utility / Packaged Equipment
├── Material Handling Equipment
├── HVAC / Building Services Equipment
├── Civil / Structural Maintainable Assets
├── Safety / Fire Protection Equipment
└── Domain-specific Extensions
```

### Rotating Equipment — candidatos

- Pumps;
- Compressors;
- Turbines;
- Fans / Blowers;
- Motors as physical drive equipment, while retaining electrical discipline mapping;
- Gearboxes / speed changers;
- Mixers / Agitators;
- other rotating machinery where relevant.

### Static / Pressure Equipment — candidatos

- Vessels;
- Tanks;
- Columns / Towers;
- Reactors;
- Drums / Separators;
- Filters / Strainers;
- pressure-containing packages where appropriate.

### Heat Transfer — candidatos

- Shell & Tube Heat Exchangers;
- Plate Heat Exchangers;
- Air Coolers;
- Cooling Towers;
- Heaters / Boilers where relevant to project domain.

### Piping / Mechanical — candidatos

- Valves by functional/design subtype;
- piping components maintained as assets;
- expansion joints;
- mechanical seals when asset-managed independently;
- traps and specialty mechanical devices.

### Electrical — candidatos

- Motors;
- Generators;
- Transformers;
- Switchgear;
- MCCs;
- UPS;
- Batteries;
- variable speed drives;
- protection and distribution equipment.

### Instrumentation & Control — candidatos

- pressure / temperature / flow / level instrumentation;
- analyzers;
- control valves;
- actuators;
- PLC / control equipment where asset-managed;
- safety instrumented devices when relevant.

La ubicación de elementos fronterizos como motores o control valves debe resolverse mediante clasificación primaria + disciplina/mappings, evitando duplicar clases solo para satisfacer vistas diferentes.

## 10. Reglas para evitar una mala taxonomía

1. No crear una clase por cada tag.
2. No codificar ubicación dentro de la clase.
3. No usar fabricante/modelo como clase salvo caso especial gobernado.
4. No crear subtipos sin diferencia técnica útil para datos, fallos o mantenimiento.
5. No convertir cada estándar/API type en nivel obligatorio si no aporta valor funcional.
6. No duplicar una clase porque dos disciplinas la consulten.
7. No borrar clases publicadas usadas por proyectos: deprecar/versionar.
8. No permitir nombres como única identidad; usar IDs estables.
9. No imponer profundidad fija del árbol.
10. Toda extensión debe justificar por qué no puede resolverse mediante una clase existente + atributo.

## 11. Criterio para crear una subclase

Una nueva subclase se justifica si existe al menos una diferencia estable que cambia de forma relevante uno o más de estos elementos:

- technical fields requeridos;
- failure modes/mechanisms;
- maintenance strategy/tasks;
- applicable standards;
- physical composition;
- operational behavior relevante para mantenimiento;
- governance/reporting need.

Si la diferencia solo es fabricante, modelo, tamaño o valor de atributo, normalmente debe permanecer como dato del modelo/activo y no como nueva clase.

## 12. Próxima investigación necesaria

Antes de poblar masivamente la biblioteca se necesita trabajar por familias.

Orden recomendado:

1. Rotating Equipment;
2. Static / Pressure Equipment;
3. Heat Transfer;
4. Valves / Piping specialty;
5. Electrical;
6. Instrumentation & Control;
7. Utilities / Packages;
8. remaining project domains.

Para cada familia:

```text
source review
→ candidate class tree
→ technical field profile
→ typical failure knowledge
→ candidate maintenance knowledge
→ external mappings
→ 3D visual set
→ SME review
→ corporate draft version
```

## 13. Resultado esperado

La biblioteca debe permitir que un usuario encuentre y comprenda una clase, vea su representación 3D, conozca qué datos técnicos se esperan, entienda qué conocimiento de fallo/mantenimiento existe, vea de dónde procede la definición y pueda reutilizarla de forma controlada en un proyecto sin perder gobernanza corporativa.
