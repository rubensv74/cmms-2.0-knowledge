# CMMS Branding Library

**Versión:** 1.0  
**Marca:** CMMS  
**Tagline:** `Gestiona. Mantiene. Optimiza.`

Esta carpeta es la fuente de verdad inicial para aplicar la identidad visual de CMMS en aplicaciones, documentación, prototipos y material de comunicación.

## Estructura

- `logos/` — sistema oficial de logotipos e isotipo en SVG.
- `icons/` — iconografía funcional de 24 px en SVG + sprite.
- `tokens/` — colores, tipografía, radios, sombras y tokens para Web y Power Apps.
- `docs/` — reglas de uso y catálogo.
- `examples/` — ejemplos mínimos de integración.

## Principio visual principal

El **hexágono del isotipo es el elemento de marca con tratamiento especial**. Su borde usa un degradado azul `#38BDF8 → #2563EB → #1E3A8A`, con un brillo muy sutil. El degradado no debe extenderse indiscriminadamente a botones, tarjetas, iconos funcionales o fondos.

## Logotipo recomendado

- Uso normal sobre fondo claro: `logos/cmms-logo-horizontal-color.svg`
- Sobre fondo oscuro: `logos/cmms-logo-horizontal-on-dark.svg`
- Espacios reducidos: `logos/cmms-isotype-color.svg`
- App/icono launcher: `logos/cmms-app-icon-dark.svg`
- Favicon: `logos/cmms-favicon.svg`

## Tipografía

Familia recomendada: **Montserrat**. Esta librería no distribuye archivos de fuentes. Los productos deben cargar Montserrat desde un origen autorizado o usar `Arial, sans-serif` como fallback.

## Paleta base

| Token | Hex | Uso |
|---|---|---|
| Navy | `#001B2A` | navegación y superficies oscuras |
| Navy Text | `#0D1B2A` | texto principal y wordmark |
| Blue Dark | `#1E3A8A` | profundidad de marca |
| Blue | `#2563EB` | acción/selección |
| Blue Light | `#38BDF8` | highlight del isotipo |
| Green | `#10B981` | éxito/optimización |
| Surface | `#F1F5F9` | fondos suaves |
| Slate | `#64748B` | texto secundario |

## Iconografía de dominio

La evolución de Asset Experience exige revisar la iconografía existente antes de crear nuevas familias.

Clasificación objetivo:

- navegación;
- entidades / Equipment Types;
- atributos técnicos;
- ingeniería / documentos;
- mantenimiento / inspección;
- estado / provenance.

La decisión de incorporación sigue:

`REUSE_CMMS → ADAPT_VERIFIED_BASE → EXTEND_SHARED → CREATE_SHARED → LOCAL_ONLY`.

Los iconos funcionales no deben reutilizar el tratamiento de gradiente/brillo del isotipo de marca.

## Ilustraciones técnicas 3D

CMMS **no mantiene una biblioteca 3D independiente**.

Fuente gobernada para ilustraciones técnicas de tipo de equipo:

```text
Repository: rubensv74/app_preserv
Collection: AssetPlan Industrial Technical 3D
Path: assets/equipment-illustrations/3d/runtime-hero-tight/r01/
```

CMMS puede consumir estas ilustraciones mediante un mapping gobernado `EquipmentType → IllustrationKey`, conservando provenance/version y sin crear una segunda fuente de verdad.

Semántica obligatoria:

```text
Type Illustration != Model Image != Asset Photo
```

La ilustración de tipo es un recurso de reconocimiento visual, no un modelo CAD/BIM ni evidencia fotográfica del activo concreto.

Documento de gobierno: `../CMMS_ASSET_EXPERIENCE_REDEFINITION_V1.md`.

## Regla de gobierno

No modificar colores, proporciones, gradiente, grosor del hexágono ni geometría del isotipo dentro de una pantalla. Cualquier evolución debe crear una nueva versión de esta librería.
