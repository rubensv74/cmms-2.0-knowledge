# Revalidación dirigida de Activos — TreePro RC3

**Fecha:** 2026-08-12  
**Dependencia:** `CL-C01 TREEPRO PASS`  
**Objetivo:** confirmar que las pantallas funcionales congeladas siguen funcionando con la identidad actualizada in situ de `cmp_FL_TreePro`.

## Alcance

```text
scr_FL_FLH
scr_FL_Taxonomy
scr_FL_ADR
```

No se pega YAML nuevo y no se reconstruye ninguna pantalla.

## Smoke integrado

### FLH

Abrir `scr_FL_FLH` y confirmar:

```text
[ ] árbol visible
[ ] P-101 visible/resaltado
[ ] búsqueda usable
[ ] selección de P-102 cambia el panel de detalle
[ ] collapse/expand de una rama funciona
[ ] sin superficies negras
[ ] sin clipping relevante
```

### Taxonomía

Abrir `scr_FL_Taxonomy` y confirmar:

```text
[ ] árbol visible
[ ] selección cambia el detalle
[ ] búsqueda usable
[ ] jerarquía/indentación legible
[ ] sin superficies negras
[ ] sin clipping relevante
```

### ADR

Abrir `scr_FL_ADR` y confirmar:

```text
[ ] árbol/relaciones visibles
[ ] selección cambia el detalle
[ ] búsqueda usable
[ ] jerarquía/indentación legible
[ ] sin superficies negras
[ ] sin clipping relevante
```

## PASS integrado

Si las tres pantallas cumplen:

```text
ASSET TREE REVALIDATION PASS
```

Esto cierra la condición pendiente de TreePro RC3 sobre FLH, Taxonomía y ADR sin reabrir su geometría.

## Regla de fallo

Si una sola pantalla falla, crear un `FIX` específico de integración para esa pantalla. No modificar `cmp_FL_TreePro` salvo que el mismo defecto sea reproducible de nuevo en `scr_ComponentLab`.
