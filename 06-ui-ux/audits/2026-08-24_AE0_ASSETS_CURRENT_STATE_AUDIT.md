# CMMS 2.0 — AE-0 Assets Current-State Audit

**Fecha:** 2026-08-24  
**Track:** Asset Experience Redefinition  
**Gate:** `AE-G0`  
**Veredicto:** `PASS / READY_FOR_AE-1`  
**Estado:** `BASELINE_AUDITED / NO_PRODUCTIVE_ASSETS_SCREEN_FOUND`

## 1. Objetivo

Cerrar `AE-0` con una foto real de lo que existe hoy en CMMS 2.0 antes de diseñar la nueva experiencia Assets.

Se auditan:

- prototipos actuales de Asset Model y ADR;
- arquitectura funcional ya decidida;
- sistema visual y jerarquía vigente;
- branding e iconografía;
- catálogo de componentes CMMS;
- referencias reusables de AssetPlan;
- gaps que deben resolverse en `AE-1`.

La conclusión principal es que **CMMS no dispone todavía de una pantalla Assets operativa/productiva que deba ser retocada**. Existen prototipos conceptuales sólidos para configurar el Asset Model y registrar la estructura ADR, pero no una experiencia `Assets List / Asset Detail` equivalente a un Object 360 técnico-operativo.

---

## 2. Evidencia revisada

### CMMS

- `06-ui-ux/html-prototypes/02_modelo_activos_corporativo_revision_04.html`
- `06-ui-ux/html-prototypes/03_registro_activos_fisicos_revision_14.html`
- `06-ui-ux/CMMS_PREMIUM_SCREEN_STANDARD_V1.md`
- `06-ui-ux/CMMS_PAGE_HEADER_HIERARCHY_V1.md`
- `06-ui-ux/CMMS_COMPONENT_CATALOG_V1.md`
- `06-ui-ux/branding/README.md`
- `06-ui-ux/branding/docs/ASSET-CATALOG.md`
- `06-ui-ux/branding/icons/icon-index.json`
- `06-ui-ux/functional-lab/design-system.md`
- `06-ui-ux/CMMS_ASSET_EXPERIENCE_REDEFINITION_V1.md`

### AssetPlan como fuente reusable

Se revisan únicamente capacidades con valor para CMMS, conservando su estado real:

- Premium UI Foundation validada en Studio para AssetPlan;
- AP Line 24 / Premium Icon Registry como referencia gobernada, con gate visual completo todavía pendiente en su línea específica;
- Technical Fields foundation como modelo reusable, actualmente en evolución;
- `AssetPlan Industrial Technical 3D`, baseline integrado y cerrado en 183 PNG.

Ninguna evidencia AssetPlan se convierte automáticamente en `VALIDATED_CMMS`.

---

# 3. Estado funcional actual

## 3.1 Asset Model — sólido y reusable

El prototipo `02_modelo_activos_corporativo_revision_04.html` define un modelo de configuración previo al registro físico.

Principios que deben conservarse:

```text
Published FLH
→ Asset Model
→ allowed taxonomy / rules
→ published version
→ Asset Classification Template
→ Physical Asset Registry
```

La taxonomía está estructurada como:

```text
Discipline
→ Typology
→ Family
→ Subfamily
```

`EquipmentTypeCode` actúa como clave gobernada de clasificación. La ruta taxonómica se deriva de esa clave y no debe reescribirse manualmente en cada activo.

También están modeladas reglas relevantes:

- parent-child físico;
- ubicación propia o heredada;
- criticidad gobernada;
- máximo de un padre físico;
- relación física por defecto editable;
- versionado/publicación del Asset Model;
- preservación de la versión con la que fue clasificado un activo existente.

**Veredicto:** `REUSE / FUNCTIONAL FOUNDATION`.

---

## 3.2 ADR — sólido y reusable

El prototipo `03_registro_activos_fisicos_revision_14.html` mantiene una separación conceptual correcta:

```text
FLH       = ¿dónde está instalado?
Taxonomy  = ¿qué tipo de activo es?
ADR       = ¿de qué forma parte físicamente?
```

La composición física utiliza:

```text
AssetCode
ParentAssetCode
LocationCode
EquipmentTypeCode
RelationshipType
LocationMode
Criticality
Description
```

La profundidad ADR es flexible y no replica niveles FLH. Se soportan relaciones como `PartOf`, `AuxiliarySystem` e `Instrumentation`, así como ubicación propia o heredada.

También existe una ruta de carga masiva distinta de la plantilla de clasificación raíz, lo que evita mezclar dos contratos diferentes.

**Veredicto:** `REUSE / FUNCTIONAL FOUNDATION`.

---

# 4. Lo que todavía NO existe

El modelo actual llega bien hasta **clasificar y estructurar físicamente un activo**, pero no llega a describirlo como objeto técnico-operativo completo.

Faltan contratos explícitos para:

```text
Asset Identity extended
Manufacturer / Model / Serial
Asset Technical Profile
Technical Fields by Equipment Type
Technical Units
Engineering Context
Engineering Documents
Data Provenance
Type Illustration
Model Image
Asset Photos
Maintenance Summary
Inspection Summary
Stale / Sync / Override semantics
```

Por tanto, no debe intentarse diseñar directamente una ficha premium con datos cuya autoridad y semántica todavía no estén cerradas.

---

# 5. Auditoría visual

## 5.1 Prototipos históricos

Los dos prototipos de activos utilizan un sistema visual local:

- wizard lateral propio;
- logos locales `AM` / `ADR`;
- tokens locales;
- `Segoe UI / Arial` o `Inter / Segoe UI / Arial`;
- azul `#1677ff`;
- navegación navy local;
- cards, notices, tags, buttons y tablas definidos dentro de cada HTML;
- encabezados de tabla hardcodeados;
- geometrías locales.

Estos prototipos fueron útiles para validar lógica, pero son anteriores a la foundation premium actual.

**Veredicto:** `FUNCTIONAL_REFERENCE_ONLY / VISUAL_RETIRE`.

No deben convertirse en baseline visual ni copiarse a Power Apps como nueva pantalla Assets.

---

## 5.2 Jerarquía visual actual CMMS

La nueva experiencia debe aplicar el contrato vigente:

```text
N0 Navigation
→ N1 Page Identity
→ N2 Context Strip
→ N3 Summary / Gate optional
→ N4 Functional Workspace
```

Para `Asset Detail`, el arquetipo candidato es `Object 360`.

Para `Assets List`, el arquetipo candidato es `Data Explorer`.

Para `Equipment Type Library`, el arquetipo candidato es `Configuration Studio`.

Estos arquetipos son candidatos de diseño; la pantalla definitiva debe declarar su tarea principal, criterio de éxito, arquetipo y componentes antes de implementación.

---

# 6. Auditoría de iconografía

## 6.1 Foundation existente

La librería CMMS dispone de una base consistente:

```text
grid        24 px
stroke      1.8
linecap     round
linejoin    round
color       currentColor
```

Actualmente cubre 24 iconos funcionales genéricos:

- alerts;
- analytics;
- asset;
- buildings;
- calendar;
- checklist;
- costs;
- dashboard;
- documents;
- energy;
- filters;
- fluids;
- inventory;
- maintenance;
- purchases;
- reports;
- safety;
- search;
- settings;
- tools;
- users;
- vehicles;
- warehouse;
- work-order.

**Veredicto:** `REUSE / EXTEND_SHARED`.

No se necesita una nueva estética de iconos.

## 6.2 Gaps confirmados

### Equipment Type

Faltan representaciones semánticas para tipos como:

- pump;
- motor;
- compressor;
- valve;
- heat exchanger;
- tank/vessel;
- fan;
- instrument/analyzer;
- electrical equipment;
- otros tipos según catálogo real.

### Technical Attribute

Faltan iconos para atributos de alto uso:

- flow;
- pressure;
- head;
- power;
- speed;
- voltage;
- temperature;
- material;
- connection;
- dimensions / weight cuando proceda.

### Engineering / Provenance

Faltan claves visuales para:

- datasheet;
- P&ID;
- GA drawing;
- certificate;
- engineering source;
- synchronized;
- inherited;
- manual;
- override;
- stale / source unavailable.

**Decisión AE-0:** extender la familia existente; no crear un segundo sistema iconográfico.

---

# 7. Componentes — clasificación de reutilización

| Capacidad / patrón | Decisión AE-0 | Razón |
|---|---|---|
| CMMS Page Header hierarchy | REUSE | Contrato estructural activo |
| CMMS brand tokens / shell language | REUSE | Fuente visual CMMS |
| Generic CMMS icons | REUSE | Base consistente 24 px |
| Equipment/technical/provenance icons | EXTEND_SHARED | Gaps reales dentro del mismo lenguaje |
| FLH / Taxonomy / ADR concepts | REUSE | Foundation funcional válida |
| `EquipmentTypeCode` classification model | REUSE | Buen boundary taxonómico |
| ParentAssetCode / physical relationships | REUSE | Buen modelo ADR |
| Location own/inherit semantics | REUSE | Necesario para composición física |
| AssetPlan PageHeader / StatePanel / FilterBar / DataGrid / KeyValueCard / ActionButton / IconPro | ADAPT_VERIFIED_BASE | Foundation AssetPlan con evidencia Studio; CMMS debe adaptar contrato y validar de nuevo |
| AssetPlan AP Line 24 registry/transport pattern | ADAPT_VERIFIED_BASE | Semántica y transporte útiles; no promover directamente a CMMS |
| AssetPlan Technical Fields | ADAPT / CONCEPTUAL REUSE | Modelo y evidencia física útiles; aún tiene gates propios abiertos |
| AssetPlan 3D equipment library | REUSE_EXTERNAL_SOURCE | 183 PNG gobernados; CMMS será consumer, no owner |
| Asset Identity Hero | CREATE_SHARED candidate | No existe contrato CMMS equivalente confirmado |
| Technical Specification Grid | CREATE/EXTEND candidate | Puede apoyarse en KeyValueCard/DataGrid, pero necesita semántica técnica propia |
| Technical Value | CREATE_SHARED candidate | Necesita unidad + provenance + status |
| Engineering Context Panel | CREATE_SHARED candidate | Gap de dominio claro |
| Asset Visual Gallery | CREATE_SHARED candidate | Debe separar Type / Model / Asset visuals |
| Hierarchy Path | CREATE/ADAPT candidate | Debe representar FLH + ADR sin confundir ambos árboles |
| Maintenance Summary | CREATE/ADAPT candidate | Solo tras contrato de datos operativo |
| Provenance Badge | CREATE/EXTEND candidate | Reusable si AE-1 confirma estados |
| Historical HTML wizard shell | RETIRE_VISUAL | No pertenece al sistema premium actual |
| Local HTML cards/notices/buttons/tables | RETIRE_VISUAL | Evitar segundo design system |
| Local logos `AM` / `ADR` | RETIRE_VISUAL | Sustituir por shell/branding CMMS |

---

# 8. Reutilización de AssetPlan — estado real

## 8.1 Biblioteca 3D

La colección `AssetPlan Industrial Technical 3D` está integrada en `main` de AssetPlan con:

```text
183 PNG
183 manifest entries
0 backfill pending
transparent RGBA
max 384 px
Hero Tight
hard limit <250 KB
BASELINE_CLOSED
```

La expansión genérica está cerrada. Nuevos visuales solo deben aparecer por huecos reales demostrados.

**Decisión CMMS:** `REUSE_EXTERNAL_SOURCE`.

Contrato futuro:

```text
CMMS EquipmentType
→ IllustrationKey
→ governed AssetPlan asset
```

## 8.2 Technical Fields

AssetPlan ya demuestra que el problema debe resolverse como catálogo dinámico y no como columnas específicas por cada equipo.

La foundation observada contiene, entre otras cosas:

- Technical Fields;
- aliases;
- unidades;
- relaciones de aplicabilidad;
- fuentes/provenance;
- recognition signals.

Esto constituye evidencia fuerte para `AE-1`, pero CMMS no debe copiar físicamente el esquema antes de comparar sus requisitos con Asset Master.

**Decisión:** `ADAPT / CONCEPTUAL REUSE`.

## 8.3 Premium UI

AssetPlan dispone de componentes compartidos con evidencia Studio que fueron creados pensando también en futuras superficies `Assets` e `Inspections`.

Por tanto, CMMS debe evaluarlos antes de crear componentes equivalentes desde cero.

**Decisión:** `ADAPT_VERIFIED_BASE`, nunca `VALIDATED_CMMS` automático.

---

# 9. Huecos y riesgos que pasan a AE-1

| ID | Gap | Impacto |
|---|---|---|
| AE0-GAP-01 | No existe Asset Detail / Object 360 productivo | No hay superficie que ampliar; debe diseñarse con contrato nuevo |
| AE0-GAP-02 | No existe contrato de Asset Technical Profile | Bloquea Technical Specification Grid productivo |
| AE0-GAP-03 | Autoridad de Manufacturer / Model / Serial no cerrada | Riesgo de duplicar ingeniería |
| AE0-GAP-04 | No existe provenance por valor técnico | Riesgo de no distinguir sync/manual/inherited/override |
| AE0-GAP-05 | No existe modelo de documentos/media de Asset Experience | Bloquea Engineering Context y Visual Gallery |
| AE0-GAP-06 | No existe `EquipmentType → IllustrationKey` CMMS | Bloquea consumo runtime de la biblioteca 3D |
| AE0-GAP-07 | Iconografía de dominio insuficiente | Requiere extensión gobernada, no nueva estética |
| AE0-GAP-08 | No existe contrato Maintenance Summary | No mostrar KPIs/health/PM/WO ficticios |
| AE0-GAP-09 | No está confirmada la necesidad de Model Template como entidad CMMS | No crearla por imitación de Maximo/SAP |
| AE0-GAP-10 | CMMS Premium App Shell todavía espera gate Studio | Las geometrías finales siguen `TO_VALIDATE` |

---

# 10. Decisión de arquitectura de información para AE-1

La auditoría permite fijar el objeto de estudio de la siguiente fase:

```text
ASSET
│
├─ Identity
│  ├─ AssetCode / Tag
│  ├─ Description
│  ├─ EquipmentType
│  ├─ Criticality / lifecycle state
│  └─ location / physical parent
│
├─ Technical Profile
│  ├─ Technical fields
│  ├─ units
│  ├─ applicability
│  └─ provenance / override
│
├─ Engineering Context
│  ├─ source systems
│  ├─ documents
│  └─ manufacturer/model information when governed
│
├─ Visual Context
│  ├─ Type Illustration
│  ├─ Model Image
│  └─ Asset Photos
│
└─ Maintenance Context
   ├─ plans / PM
   ├─ work orders
   ├─ inspections
   └─ history/health only where contractually available
```

Este árbol es **scope de contrato**, no una decisión de tabs o layout final.

---

# 11. Gate AE-G0

## Comprobaciones

```text
[x] pantalla/artefactos Assets actuales localizados
[x] ausencia de Assets operativo/productivo confirmada en el repositorio
[x] foundation funcional reutilizable identificada
[x] deuda visual histórica separada de verdad funcional
[x] iconografía actual inventariada
[x] gaps iconográficos clasificados
[x] componentes/referencias externas evaluados
[x] biblioteca 3D reusable identificada sin duplicar ownership
[x] gaps de datos/autoridad/provenance identificados
[x] siguiente fase definida sin diseñar a ciegas
```

## Veredicto

```text
AE-G0 = PASS
AE-0  = COMPLETE
NEXT  = AE-1 ASSET EXPERIENCE CONTRACT
```

No existe bloqueo para iniciar AE-1.

Sí existe un bloqueo deliberado para **diseñar o implementar la ficha Asset Detail como productiva** antes de cerrar AE-G1.

---

# 12. Siguiente incremento

`AE-1` debe producir como mínimo:

1. contrato de `AssetIdentity`;
2. contrato de `AssetTechnicalProfile`;
3. contrato de Technical Field / Unit / Value / Applicability;
4. matriz de autoridad/provenance por familia de datos;
5. contrato de `EngineeringContext`;
6. contrato de `AssetVisualContext`;
7. contrato mínimo de `MaintenanceSummary` o decisión explícita de diferirlo;
8. decisión sobre Model Template: `NEEDED / NOT_NEEDED / DEFERRED`;
9. estados de disponibilidad/sincronización/stale/override;
10. mapa de qué parte puede adaptarse directamente de AssetPlan y qué parte pertenece exclusivamente a CMMS.

Solo después debe congelarse la composición funcional de `Assets List`, `Asset Detail` y `Equipment Type Library`.
