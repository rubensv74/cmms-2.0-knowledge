# CMMS 2.0 — AE6-S01 Asset Detail Pre-Studio Implementation

**Fecha:** 2026-08-24  
**Track:** Asset Experience Redefinition  
**Fase:** AE-6  
**Incremento:** `AE6-S01`  
**Estado:** `READY_FOR_STUDIO_AFTER_AE-G5 / NO_PRODUCTIVE_BACKEND`

## 1. Objetivo

Construir el primer `Asset Detail / Object 360` de CMMS utilizando exclusivamente el fixture P-101 y contratos de presentación ya cerrados.

S01 no pretende demostrar integración productiva. Debe demostrar:

- arquitectura Object 360;
- jerarquía visual premium;
- Asset Identity;
- Technical Profile dinámico;
- provenance;
- estados de datos incompletos;
- Type Illustration gobernada;
- navegación entre secciones sin pérdida de estado;
- ausencia de capacidades ficticias.

---

# 2. Preconditions

Debe existir evidencia suficiente de:

```text
AE-G0 = PASS
AE-G1 = PASS_WITH_DEFERRED_ITEMS
AE-G2 = PASS_CONTRACT
AE-G3 = PASS_CONTRACT
AE-G4 = PASS_CONTRACT
AE-G5 = PASS_RUNTIME
```

Si `AE-G5 != PASS_RUNTIME`, S01 puede montarse sin imagen real para validar estructura, pero **no puede declararse visualmente aprobado ni cerrar AE-G6**.

---

# 3. Fuentes S01

Contrato:

```text
02-functional/asset-master/CMMS_ASSET_DETAIL_READ_CONTRACT_V1.md
```

Fixture:

```text
06-ui-ux/functional-lab/cases/P101/p101-asset-detail.v1.json
```

Visual esperado:

```text
AssetKey = ap-eq-pump-centrifugal-horizontal
VisualKind = TYPE_ILLUSTRATION
```

No consultar ALEP, SQL, SharePoint ni APIs en S01.

---

# 4. Screen declaration

```text
SCREEN_ID          = AS-02
SCREEN_NAME        = Asset Detail
PRIMARY_USER_TASK  = Understand one asset as a maintenance object and inspect its technical, engineering, visual and maintenance context.
SUCCESS_CRITERION  = The user can identify the asset, understand where it belongs, inspect governed technical values and distinguish available, unavailable and referenced information without ambiguity.
PRIMARY_ARCHETYPE  = Object 360
SECONDARY_PATTERNS = Tabbed Detail + Context Panels + Dynamic Technical Grid
```

---

# 5. Composición objetivo

```text
CMMS Shell
└─ N1 Page Identity
   Asset Detail
   Technical and maintenance context for one asset

└─ N2 Context Strip
   P-101 | Pump — Centrifugal Horizontal | Unidad de proceso A | Criticality A

└─ N4 Functional Workspace
   ├─ Asset Identity Hero
   │  ├─ P-101
   │  ├─ description
   │  ├─ lifecycle / criticality
   │  ├─ hierarchy/location
   │  └─ Type Illustration
   │
   ├─ Section navigation
   │  Overview | Technical Profile | Engineering | Visuals | Maintenance
   │
   └─ Section host
      ├─ Overview
      ├─ Technical Profile
      ├─ Engineering
      ├─ Visuals
      └─ Maintenance
```

No introducir KPI strip en S01. Todavía no existe una necesidad demostrada que justifique KPIs en Asset Detail.

---

# 6. Component strategy

## Adapt first

```text
cmp_CMMS_PageHeaderPro
cmp_CMMS_StatePanelPro
cmp_CMMS_ActionButtonPro
cmp_CMMS_IconPro
```

No se crean variantes locales si la adaptación puede resolver el contrato.

## Asset components consumed

```text
cmp_CMMS_AssetIdentityHero_RC0
cmp_CMMS_TechnicalValue_RC0
cmp_CMMS_TechnicalSpecificationGrid_RC0
cmp_CMMS_EngineeringContextPanel_RC0
cmp_CMMS_AssetVisualGallery_RC0
cmp_CMMS_MaintenanceSummary_RC0
cmp_CMMS_HierarchyPath_RC0
```

`cmp_CMMS_ProvenanceBadge_RC0` solo se materializa si S01 demuestra que el patrón se repite y no puede resolverse limpiamente dentro de Technical Value / Engineering Context.

---

# 7. Incremental blocks

## S01-00 — App reality audit

Antes de pegar source:

- confirmar authoring locale;
- confirmar Canvas source-code format disponible;
- inventariar componentes ya instalados;
- comprobar nombres/versión de controles;
- ejecutar App Checker baseline;
- registrar resolución desktop usada para el gate.

**Gate:** `S01-00_REALITY_PASS`.

## S01-01 — Fixture state only

Cargar únicamente:

```text
gblAE6_DataMode
recAE6_Asset
colAE6_TechnicalValues
colAE6_EngineeringSources
colAE6_Documents
colAE6_Visuals
recAE6_Maintenance
```

Sin UI nueva salvo labels temporales de smoke test.

**Gate:** fixture carga sin errores y los conteos esperados son correctos.

Expected:

```text
Asset                1
Technical Values     5
Engineering Sources  1
Documents            3
Visuals              1
```

## S01-02 — Page + Identity Hero

Montar:

- Page Header;
- Context Strip;
- Asset Identity Hero;
- Type Illustration si AE-G5 ya pasó.

No montar tabs todavía.

**Gate:** identidad inequívoca; imagen etiquetada `Type illustration`; Manufacturer/Model ausentes no rompen layout.

## S01-03 — Technical Profile

Montar Technical Specification Grid con los cinco valores del fixture.

Debe probar simultáneamente:

```text
READY numeric + unit
READY text
UNAVAILABLE Manufacturer
UNAVAILABLE Model
provenance visible on demand / subordinate
```

**Gate:** `UNAVAILABLE = —`, nunca 0 ni empty-looking field.

## S01-04 — Engineering + Visuals

Añadir tabs/sections:

```text
Overview
Technical Profile
Engineering
Visuals
```

Engineering muestra referencias, no falsos adjuntos.

Visuals muestra Type Illustration y estados preparados para futuras `MODEL_IMAGE` / `ASSET_PHOTO` sin inventarlas.

**Gate:** ninguna acción apunta a recurso inexistente.

## S01-05 — Maintenance read-only

Añadir Maintenance con:

- estrategia conceptual del fixture claramente marcada;
- métricas de WO como `UNAVAILABLE`;
- sin botones de generar WO, schedule, execute o close.

**Gate:** Work Management no se sobredeclara.

## S01-06 — Hardening

Validar:

- READY / LOADING / UNAVAILABLE / ERROR en superficies aplicables;
- focus/keyboard en controles interactivos;
- ausencia de clipping;
- selección de sección clara;
- responsive desktop razonable;
- App Checker;
- reopen smoke;
- ningún write/Flow/DML.

**Gate:** candidato `AE6-S01_STUDIO_PASS`.

---

# 8. State rules

## Loading

No usar overlay de página completo salvo bloqueo total real.

Cada panel mantiene su geometría y usa State/Skeleton local.

## Unavailable

```text
Manufacturer = —
Model        = —
WO counts    = —
```

No usar:

```text
Unknown manufacturer
N/A model
0 open WOs
```

salvo que esos textos/valores procedan del contrato de datos.

## Error

Un error de Technical Profile no debe convertir Asset Identity en error si su lectura sigue disponible.

El read model permite degradación por sección.

---

# 9. Visual truthfulness

En S01 la imagen principal representa:

```text
Pump — Centrifugal Horizontal
TYPE_ILLUSTRATION
```

No representa:

```text
P-101 actual
modelo del fabricante
fotografía de campo
modelo CAD/3D interactivo
```

Por tanto quedan prohibidos:

```text
Rotate
Orbit
Explode
CAD view
3D model
```

---

# 10. No-write boundary

S01 no contiene:

- Save;
- Edit Asset productivo;
- document upload;
- technical value override;
- source refresh;
- mapping write;
- maintenance action;
- Power Automate;
- SQL DML.

Cualquier botón de Edit que se use como prueba visual debe estar `DISABLED / NOT AVAILABLE IN THIS INCREMENT` o no existir.

---

# 11. Evidence to capture

Para cerrar S01 guardar:

1. captura completa de Asset Detail;
2. captura Technical Profile con valores READY + UNAVAILABLE;
3. captura de provenance/source detail;
4. captura Visuals con label `Type illustration`;
5. App Checker result;
6. reopen smoke result;
7. resolución usada;
8. component versions/import notes;
9. AE-G5 reference;
10. lista de defectos conocidos.

---

# 12. Promotion rule

```text
SOURCE PREPARED
    ≠ STUDIO PASS

STUDIO PASS
    ≠ VISUAL APPROVED

VISUAL APPROVED
    ≠ PRODUCTIVE DATA VALIDATED
```

S01 puede promocionar componentes a `CMMS_RC` o `VALIDATED_CMMS` solo según la evidencia real obtenida para cada componente; no se promociona toda la familia por transitividad.

---

# 13. Siguiente incremento después de PASS

```text
AE6-S02 — Asset Detail real read adapter
```

S02 debe definir la frontera física de lectura y conectar progresivamente:

```text
Asset Master
→ Technical Profile
→ Engineering Context
→ Visual mapping
→ Maintenance read model
```

sin cambiar el contrato UI de S01 salvo que la evidencia revele un gap real.
