# Decisión — CMMS 2.0 se construye como producto funcional, no como Functional Lab

**Fecha:** 2026-08-22  
**Estado:** confirmed  
**Rama:** `baseline/premium-powerapps-v1`

## Decisión

La aplicación Power Apps que se construirá a partir de esta baseline es la **interfaz funcional futura de CMMS 2.0** hasta la publicación del plan de mantenimiento.

No se construirá como prototipo didáctico basado en un único caso de uso.

Los datos sintéticos se utilizarán únicamente como **proveedor temporal de datos** durante las primeras fases de desarrollo.

```text
Future CMMS 2.0 UI
        ↓
Functional contracts
        ↓
Provider abstraction
        ↓
NOW: synthetic Power Apps collections
LATER: SQL + Power Automate
FUTURE: API / backend when justified
```

La UI, navegación, funciones, permisos conceptuales y contratos se diseñarán como los de la aplicación futura.

## Alcance funcional de la primera gran versión

La primera gran versión cubre desde la configuración del proyecto hasta la publicación de un plan de mantenimiento.

```text
Corporate Libraries
        ↓
Project Setup
        ↓
FLH + Project Taxonomy + ADR
        ↓
Asset Register / Asset 360
        ↓
Criticality
        ↓
AMEF / FMEA
        ↓
RCM
        ↓
Maintenance Tasks / Job Plans / Strategies
        ↓
Applicability + Asset Overrides
        ↓
Maintenance Plan
        ↓
Review / Approval / Version
        ↓
Published Maintenance Plan
```

Work Management, scheduling, work orders, execution, feedback operativo, costes reales, contratos y facturación permanecen fuera de este primer alcance de construcción y seguirán su proceso de discovery antes de entrar en producto.

## Tres estructuras maestras confirmadas

### FLH — Functional Location Hierarchy

Responde principalmente a:

> ¿Dónde está instalado / dónde cumple su función?

Representa la estructura funcional y de localización del proyecto.

### Equipment Taxonomy

Responde principalmente a:

> ¿Qué tipo de equipo es?

Clasifica los activos mediante una biblioteca corporativa de clases y una selección/extensión gobernada a nivel de proyecto.

### ADR — Asset Detail Register

Responde principalmente a:

> ¿Qué activos físicos existen y cómo están construidos/relacionados?

ADR es el registro físico maestro de activos del proyecto.

Un activo físico puede enlazar, entre otros, con:

- Functional Location;
- Taxonomy Class;
- parent/child physical asset;
- manufacturer/model;
- technical fields;
- documents;
- criticality;
- AMEF/RCM;
- maintenance strategy;
- maintenance plan.

## Corporate + Project-specific + promoción gobernada

Se confirma el siguiente modelo:

```text
Corporate Library
      ↓ consume
Project Configuration
      ↓ extend locally when needed
Project-specific item
      ↓ optional promotion request
Corporate Governance Review
      ↓ approve / reject
New corporate version
```

Estados conceptuales mínimos para una extensión local:

- `Corporate`;
- `ProjectSpecific`;
- `CorporateCandidate`;
- `PromotionUnderReview`;
- `Promoted`;
- `Rejected`;
- `Superseded`.

Una extensión de proyecto no altera silenciosamente la biblioteca corporativa.

## Risk Profile configurable

Cada proyecto debe poder seleccionar o derivar un `RiskProfile` versionado.

La configuración debe admitir al menos:

- dimensiones;
- niveles por dimensión;
- etiquetas;
- rangos;
- thresholds;
- bandas / categorías de riesgo;
- colores semánticos;
- reglas de sobreclasificación/override;
- versión;
- estado;
- fuente corporativa o project-specific.

No existe una matriz 5×5 fija como regla del producto.

AMEF, criticidad y cualquier otra superficie que valore riesgo deben consumir el perfil configurado para el proyecto.

## Biblioteca visual 3D

La taxonomía de equipos tendrá una `Equipment Visual Library` asociada.

Las imágenes 3D representan **tipos/clases de equipo**, no sustituyen la fotografía real de un activo.

Prioridad de representación de un activo:

```text
real asset photo when available
→ equipment model/class 3D visual
→ parent family visual
→ discipline fallback
```

La biblioteca visual se considera parte del producto y de la experiencia premium, no decoración accidental.

## Consecuencia documental

Los documentos históricos del `Functional Lab` conservan valor como fuente de decisiones AMEF/RCM y aprendizaje, pero dejan de ser el mapa rector de las pantallas que se construirán.

Las nuevas fuentes rectoras son:

1. `01-vision/cmms-2.0-product-map-v1.md`;
2. `06-ui-ux/product-screen-catalog-v1.md`;
3. `02-functional/master-data/equipment-taxonomy-library-foundation-v1.md`;
4. la baseline consolidada y decisiones funcionales confirmadas de las reuniones.
