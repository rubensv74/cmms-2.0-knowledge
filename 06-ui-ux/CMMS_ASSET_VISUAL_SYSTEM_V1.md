# CMMS 2.0 — Asset Visual System V1

**Fecha:** 2026-08-24  
**Track:** Asset Experience Redefinition  
**Fase:** `AE-2`  
**Gate:** `AE-G2`  
**Estado:** `NORMATIVE_V1 / IMPLEMENTATION_TO_VALIDATE`  
**Veredicto:** `PASS_CONTRACT / READY_FOR_AE-3`

## 1. Propósito

Definir cómo se expresa visualmente el nuevo Asset Experience sin crear un segundo lenguaje de producto.

Este documento extiende, no sustituye:

- `CMMS_PREMIUM_SCREEN_STANDARD_V1.md`;
- `CMMS_PAGE_HEADER_HIERARCHY_V1.md`;
- `CMMS_COMPONENT_CATALOG_V1.md`;
- `branding/README.md`;
- `functional-lab/design-system.md`;
- `02-functional/asset-master/CMMS_ASSET_EXPERIENCE_CONTRACT_V1.md`.

Regla:

> **Asset Experience pertenece al sistema visual CMMS. No tiene una paleta, shell, tipografía, iconografía o gramática de interacción propia.**

---

# 2. Jerarquía visual obligatoria

```text
N0 Navigation
→ N1 Page Identity
→ N2 Context Strip
→ N3 Summary / Gate optional
→ N4 Functional Workspace
```

## 2.1 Asset Detail

Arquetipo dominante candidato:

```text
Object 360
```

### N1 — Page Identity

Identifica la pantalla/capability, no intenta contener toda la ficha.

Ejemplo conceptual:

```text
Asset
Technical and maintenance context
```

### N2 — Asset Context Strip

Puede incluir de forma compacta:

```text
AssetCode
Description
Equipment Type
Lifecycle Status
Criticality
Location
```

No son KPIs; son contexto del objeto.

### N3 — Summary / Attention

Solo si existen datos reales que ayuden a decidir:

```text
open work attention
next preventive due
inspection warning
stale engineering data
source conflict
```

No introducir una fila de KPI por simetría visual.

### N4 — Object 360 Workspace

Contiene las áreas de identidad técnica, technical profile, engineering, visual y maintenance context.

La división exacta en tabs/panels se resuelve en AE-4.

---

## 2.2 Assets List

Arquetipo dominante candidato:

```text
Data Explorer
```

Orden:

```text
Page Identity
→ global/project context
→ optional truthful summary
→ filters/search
→ dominant asset data surface
→ optional preview/detail rail
```

No convertir cada Asset en una gran card si el volumen exige exploración tabular.

---

## 2.3 Equipment Type Library

Arquetipo dominante candidato:

```text
Configuration Studio
```

Debe expresar claramente:

```text
Equipment Type catalogue
→ selected type
→ technical field applicability
→ visual mapping
→ governance/publish state
```

La configuración no debe parecer una ficha de Asset físico.

---

# 3. Sistema de iconografía

## 3.1 Base CMMS

La foundation existente se conserva:

```text
grid        24 px
stroke      1.8
linecap     round
linejoin    round
default     currentColor
```

No se crea un estilo `Asset Icons` separado.

## 3.2 Familias semánticas

### A — Product / Navigation

Usar primero los iconos CMMS ya existentes:

```text
asset
maintenance
work-order
documents
inventory
calendar
alerts
search
filters
settings
...
```

### B — Equipment Type

Nueva extensión gobernada.

Primer conjunto candidato:

```text
pump
motor
compressor
valve
heat-exchanger
tank-vessel
fan
instrument-analyzer
electrical-equipment
filter
```

La lista definitiva debe partir del catálogo real de Equipment Types y de cobertura visual, no de generar iconos por catálogo teórico.

### C — Technical Attribute

Iconos para campos técnicos de uso frecuente:

```text
flow
pressure
head
power
speed
voltage
temperature
material
connection-size
dimensions
weight
```

Regla: un Technical Field no necesita necesariamente icono. Solo se crea cuando mejora lectura frecuente y tiene significado estable.

### D — Engineering / Evidence

```text
datasheet
pid
ga-drawing
manual
certificate
engineering-source
external-link
revision
```

### E — Provenance / State

```text
source-external
sync
manual
calculated
override
stale
conflict
unavailable
```

El icono complementa label/estado. No sustituye texto en información crítica.

---

# 4. Regla de adaptación desde AssetPlan

AssetPlan `AP Line 24` y su registry son una referencia verificada de alta calidad para:

- semantic keys;
- masters SVG;
- transporte runtime mediante URI/Text cuando proceda;
- component wrapper de icono;
- gobernanza de promoción.

CMMS puede adaptar ese patrón, pero:

```text
AssetPlan icon key != CMMS icon key automatically
AssetPlan Studio PASS != CMMS validation
```

Antes de copiar un master SVG se debe:

1. comprobar significado equivalente;
2. comprobar licencia/origen interno;
3. registrar provenance;
4. ajustar naming CMMS;
5. validar en la app CMMS.

---

# 5. Type Illustration vs icon

No confundir dos recursos:

```text
Equipment Type Icon
= símbolo lineal 24 px
= navegación, listas, chips, compact context

Type Illustration
= PNG industrial 3D
= reconocimiento visual de alto nivel
= hero / visual panel / detail
```

No usar una ilustración 3D reducida a 24 px como icono.

No usar un icono lineal grande como sustituto de una ilustración cuando el objetivo sea reconocimiento morfológico.

---

# 6. Regla crítica — la biblioteca 3D es estática

La colección `AssetPlan Industrial Technical 3D` está compuesta por PNG estáticos.

Por tanto, CMMS **no puede mostrar controles que impliquen una capacidad inexistente**, por ejemplo:

```text
Rotate
Explode
3D orbit
section cut
live model
BIM selection
```

salvo que una futura integración implemente realmente esa capacidad.

Un botón `Fullscreen` puede existir únicamente como ampliación de imagen si se implementa; no debe etiquetarse como visor 3D interactivo.

Esta regla corrige una tentación visual observada en mockups conceptuales: una imagen con apariencia 3D no es un modelo 3D navegable.

---

# 7. Technical Value visual grammar

Un valor técnico debe poder leerse sin abrir metadata secundaria.

Anatomía candidata:

```text
optional icon
Label
Value + Unit
optional provenance/state indicator
```

Ejemplo:

```text
Flow
145 m³/h
ALEP · synced
```

## 7.1 Prioridad visual

```text
Value > Label > Provenance metadata
```

La procedencia debe estar disponible, pero no competir permanentemente con el valor salvo conflicto/stale/override.

## 7.2 Valores ausentes

```text
UNAVAILABLE      → — + “Unavailable”
NOT_APPLICABLE   → N/A + “Not applicable”
STALE            → último valor + stale indicator
ERROR            → no presentar valor como válido
```

Nunca:

```text
UNAVAILABLE → 0
ERROR       → blank silencioso
```

---

# 8. Provenance visual grammar

## 8.1 Estados de provenance

```text
IMPORTED
SYNCED
MANUAL
DERIVED
OVERRIDE
```

Pueden expresarse mediante `Provenance Badge` o metadata compacta.

### Normal

Provenance queda subordinado visualmente.

### Stale / source changed / conflict

Sube en jerarquía y debe ser visible sin hover.

## 8.2 Color

Color es secundario al texto/icono.

Semántica:

```text
neutral/blue   = information/source/sync normal
amber          = stale/review required
red            = conflict/error
```

No asignar colores arbitrarios diferentes a ALEP, Manual, CMMS, etc. solo para decorar.

---

# 9. Criticality visual grammar

La criticidad puede ser configurable por proyecto/cliente.

Por tanto, el sistema visual no debe asumir product-wide:

```text
A = red
B = amber
C = green
```

Regla:

- mostrar `CriticalityCode`/label siempre;
- aplicar color semántico solo si el perfil de criticidad publicado incluye una semántica de color gobernada;
- no inferir severidad por orden alfabético.

---

# 10. Engineering document grammar

Un documento se representa como evidencia/enlace, no como una card decorativa por cada PDF.

Campos visibles según densidad:

```text
Document Type
Document Number / Title
Revision
Status
Source
```

Acciones:

```text
Open
View details
Copy reference
```

solo cuando existan realmente.

No utilizar icono PDF para todo documento si el tipo documental aporta más significado.

---

# 11. Visual Context grammar

## 11.1 Capas

```text
Type Illustration
Model Image
Asset Photos
```

Deben permanecer identificadas explícitamente.

## 11.2 Availability

Si una capa no existe:

- no fabricar placeholder que parezca imagen real;
- usar empty/unavailable state;
- puede ocultarse una tab secundaria si no añade valor, siempre que el usuario no pierda una acción esperada.

## 11.3 Primary visual

Orden candidato:

```text
Asset Photo primary when useful and available
otherwise Type Illustration
Model Image only when model governance exists
```

No se fija como regla universal hasta AE-4; depende de tarea y contexto.

---

# 12. Asset Identity Hero

El hero no debe convertirse en un megacard que repita todo el asset.

Debe resolver únicamente:

```text
What asset is this?
What kind of equipment is it?
Where is it / what state is it in?
```

Contenido máximo candidato:

- visual principal;
- AssetCode;
- Description;
- Equipment Type;
- Manufacturer/Model cuando disponibles;
- lifecycle status;
- criticality;
- location.

Technical Fields extensos no pertenecen al hero.

---

# 13. States de panel

Cualquier panel remoto o dependiente de integración debe preservar geometría con estados explícitos:

```text
READY
LOADING
EMPTY
UNAVAILABLE
STALE
ERROR
BLOCKED
```

`STALE` puede seguir mostrando información con advertencia cuando el contrato lo permita.

`ERROR` no puede transformarse visualmente en EMPTY.

---

# 14. Actions

Jerarquía estándar CMMS:

```text
Primary
Secondary
Tertiary
Destructive
```

En Asset Detail, acciones de mantenimiento no deben mezclarse con edición de ingeniería/identity si pertenecen a workflows distintos.

Ejemplo:

```text
Edit Asset        ≠ Create Work Order
```

Pueden coexistir, pero no compiten como dos acciones primarias del mismo contexto inmediato.

Async Action Guard se aplica a acciones write/remote según el estándar transversal.

---

# 15. Densidad

Asset Experience debe ser denso pero escaneable.

Reglas:

- usar cards solo para fronteras semánticas;
- preferir grids/sections para Technical Fields;
- no dar una card independiente a cada dato;
- no usar KPI cards para identity fields;
- no duplicar AssetCode/Description en múltiples niveles salvo contexto sticky necesario;
- metadata secundaria puede vivir en inspector/drawer/detail expansion si no es parte de la tarea principal.

---

# 16. Responsive strategy

## Desktop

Objetivo principal de AE-4.

Permite:

- Object 360 multi-panel;
- technical grids;
- visual + identity composition;
- contextual rail cuando exista necesidad real.

## Tablet

Debe priorizar:

```text
identity/context
→ primary action/work
→ technical profile
→ related context
```

No intentar mantener tres columnas estrechas solo para conservar simetría desktop.

El comportamiento exacto se valida en Power Apps Studio.

---

# 17. Component mapping

| Necesidad Asset Experience | Primera estrategia |
|---|---|
| Page identity | ADAPT shared PageHeader |
| States | ADAPT StatePanel |
| Search/filter Assets | ADAPT FilterBar |
| Assets List | ADAPT DataGrid |
| Generic key/value metadata | ADAPT KeyValueCard where appropriate |
| Primary/async actions | ADAPT ActionButton |
| Icon rendering | ADAPT IconPro / CMMS icon wrapper |
| Asset Identity Hero | CREATE_SHARED candidate |
| Technical Value | CREATE_SHARED candidate |
| Technical Specification Grid | EXTEND/CREATE_SHARED candidate |
| Provenance Badge | EXTEND/CREATE_SHARED candidate |
| Engineering Context | CREATE_SHARED candidate |
| Visual Gallery | CREATE_SHARED candidate |
| Hierarchy Path | CREATE/ADAPT candidate |
| Maintenance Summary | CREATE/ADAPT after data contract |

No se crea un componente nuevo solo porque un bloque tenga borde o icono propio.

---

# 18. Anti-patterns

Quedan prohibidos como nueva baseline:

- wizard lateral histórico como Asset Detail operativo;
- logos locales `AM`, `ADR` dentro del shell;
- paleta propia de Assets;
- iconos de estilo diferente por módulo;
- giant-card stacking;
- una card por atributo técnico;
- 3D fake controls sobre PNG;
- KPIs sin fuente real;
- `UNAVAILABLE = 0`;
- color como única señal de provenance/criticality;
- tabla de datos que mezcle FLH y ADR como si fueran la misma jerarquía;
- model image generada/presentada como evidencia del activo real;
- asset photo genérica presentada como fotografía del activo.

---

# 19. Backlog iconográfico inicial

Estado: `TO_VALIDATE / DO_NOT_GENERATE_BLINDLY`.

## Tier 1 — alta prioridad para AE-4

```text
pump
motor
compressor
valve
heat-exchanger
tank-vessel
fan
instrument
flow
pressure
power
speed
voltage
temperature
datasheet
pid
ga-drawing
certificate
sync
override
stale
```

## Tier 2 — añadir con consumer real

```text
material
connection-size
dimensions
weight
manual
external-source
revision
conflict
filter
analyzer
electrical-equipment
```

No convertir esta lista en obligación de crear todos los SVG antes de existir una pantalla consumidora.

---

# 20. Gate AE-G2

```text
[x] jerarquía N0–N4 conservada
[x] no existe un design system paralelo de Assets
[x] icon foundation CMMS conservada
[x] gaps iconográficos clasificados
[x] frontera icon vs Type Illustration definida
[x] Type Illustration / Model Image / Asset Photo separados
[x] fake 3D interactions prohibidas
[x] Technical Value grammar definida
[x] provenance/freshness grammar definida
[x] criticality configurable respetada
[x] panel states definidos
[x] componentes candidatos mapeados a reuse/adapt/create
[x] anti-patterns documentados
```

## Veredicto

```text
AE-G2 = PASS_CONTRACT
AE-2  = COMPLETE
NEXT  = AE-3 SHARED PREMIUM COMPONENT CONTRACTS
```

La implementación física de iconos/componentes sigue `TO_VALIDATE` y no se declara aprobada por este documento.
