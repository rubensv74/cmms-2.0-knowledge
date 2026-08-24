# CMMS 2.0 — ASSETS UX Contract V1

**Fecha:** 2026-08-24  
**Screen:** `AS-01 Assets`  
**Arquetipo:** `Data Explorer`  
**Estado:** `ACCEPTED / READY_FOR_INCREMENTAL_BUILD`

## 1. Jerarquía

La pantalla debe seguir la anatomía CMMS:

```text
ROOT
├─ Navigation
└─ Content
   ├─ N1 Page Identity
   ├─ N2 Context Strip
   ├─ N3 Summary optional — OMIT V1
   ├─ N4 Functional Workspace
   └─ Overlay Layer only when needed
```

## 2. N1 — Page Identity

```text
Title: Assets
Subtitle: Explore and manage maintainable assets
```

Usar `cmp_CMMS_PageHeaderPro_RC0` existente.

No mostrar Asset seleccionado ni KPIs en N1.

## 3. N2 — Context Strip

Usar `cmp_CMMS_ProjectContextPro_RC0` existente cuando el contrato actual encaje.

Debe expresar el proyecto/contexto activo sin repetir filtros del workspace.

Candidatos posteriores, solo con datos gobernados:

- Asset Model version;
- data freshness/material source status.

## 4. N3 — Summary

**Omitido en V1.**

No crear KPI strip hasta disponer de read model decisional real.

## 5. N4 — Workspace

Orden funcional:

```text
Search + Filters
→ Data Surface
→ Selection / Row action
→ State surface when applicable
```

### Search baseline

Buscar al menos:

```text
AssetCode
Description
```

Ampliar a Manufacturer/Model/Serial solo cuando el read model real lo soporte.

### Filters baseline

```text
Equipment Type
FLH Location / hierarchy scope
Lifecycle Status
Criticality
```

No implementar todos en el Shell. El contrato define su destino.

### Data surface baseline

Columnas objetivo:

```text
Type icon
AssetCode
Description
Equipment Type
Location
Criticality
Lifecycle Status
Manufacturer / Model optional
```

Reglas:

- no imágenes 3D grandes por fila;
- Equipment Type icon preferido para lectura rápida;
- thumbnail solo si el rendimiento demuestra que aporta valor;
- Manufacturer/Model ausente = `—` cuando la columna exista;
- selección no persiste ni modifica datos.

### Primary action

```text
Open Asset
```

Debe ser accesible por fila y navegar a Asset Detail con identidad explícita.

### Secondary actions

```text
Create Asset
```

solo en incremento de interacción/escritura y tras validar permisos/contrato.

## 6. Estados visuales

```text
INITIAL
LOADING
READY
EMPTY
ERROR
UNAVAILABLE_SOURCE
```

`cmp_CMMS_StatePanelPro_RC0` se reutiliza para states que encajen. Si el componente necesita un delta, se documenta antes de modificarlo.

## 7. Responsive contract

La app real está en modo `Responsive` con aspect ratio/orientation desbloqueados.

Por tanto:

- usar auto-layout containers cuando sea posible;
- no fijar arquitectura a 1366×768;
- sidebar y content responden a ancho disponible;
- filtros pueden pasar de barra horizontal a composición compacta cuando el ancho lo requiera;
- la data surface debe conservar acceso a columnas esenciales sin clipping destructivo;
- el gate visual se captura en desktop, pero no convierte esa geometría en contrato fijo.

## 8. Sistema visual

Fuente obligatoria:

- `CMMS_PREMIUM_SCREEN_STANDARD_V1.md`;
- `CMMS_PAGE_HEADER_HIERARCHY_V1.md`;
- `functional-lab/design-system.md`;
- globals físicos `gblTheme` y `gblLayout`.

No crear tokens locales salvo gap real.

## 9. Component classification

### A — existentes / REUSE

```text
cmp_CMMS_SidebarPro_RC0
cmp_CMMS_ProjectContextPro_RC0
cmp_CMMS_PageHeaderPro_RC0
cmp_CMMS_StatePanelPro_RC0
```

### B — variante

Ninguna aprobada todavía.

### C — reusable a validar/crear más adelante

```text
cmp_CMMS_FilterBarPro_RC0 candidate
cmp_CMMS_DataGridPro_RC0 candidate
cmp_CMMS_IconPro_RC0 candidate if repeated semantic icon rendering requires it
```

No se materializan en Incremento 1.

### D — local

```text
screen root containers
workspace host
temporary shell placeholders used only for layout validation
```

## 10. Gate UX

`ASSETS_UX_CONTRACT_V1 = PASS`

El contrato permite empezar Shell sin inventar el read adapter ni los componentes de datos.
