# DS-C01 — Semantic Token Roles — Studio validation

**Fecha:** 2026-08-12  
**Pantalla:** `scr_DesignSystemLab`  
**Bloque:** `DS-C01`  
**Tipo:** `C — Component/content`  
**Resultado:** `PASS`

## Evidencia

Captura Studio aportada después de sustituir exclusivamente `ph_TokenRoles`.

## Validación observada

```text
[PASS] geometría DS-S01 preservada
[PASS] ph_TokenRoles ocupa el slot congelado
[PASS] 16 roles semánticos visibles
[PASS] Background / Surface / SurfaceAlt diferenciables
[PASS] Border visible sobre Surface
[PASS] TextPrimary / TextSecondary correctos
[PASS] Primary / PrimaryHover / PrimarySelected diferenciables
[PASS] SelectedBackground / Border / Accent / Text diferenciables
[PASS] Success / Warning / Danger diferenciables
[PASS] no superficies negras inesperadas
[PASS] no clipping visual relevante
[PASS] texto del bloque legible en el viewport mostrado
```

## Roles validados en esta fase

```text
Background          #F6F8FB
Surface             #FFFFFF
SurfaceAlt          #F8FAFC
Border              #E2E8F0
TextPrimary         #0F172A
TextSecondary       #64748B
Primary             #0284C7
PrimaryHover        #0369A1
PrimarySelected     #075985
SelectedBackground  #EFF6FF
SelectedBorder      #BFDBFE
SelectedAccent      #2563EB
SelectedText        #1D4ED8
Success             #15803D
Warning             #B45309
Danger              #B91C1C
```

## Alcance del PASS

Este PASS confirma el **render visual aislado de los roles** en Studio.

No significa todavía:

```text
COLOR FOUNDATION APPROVED
component theme propagation approved
all Classic controls approved
all Modern controls approved
interaction states approved
data visualisation palette approved
```

La aprobación global de color permanece pendiente hasta cerrar `DS-C02`, `DS-C03` y `DS-C04`.

## Freeze

```text
scr_DesignSystemLab STRUCTURE = FROZEN
DS-C01 CONTENT       = VISUAL_APPROVED
COLOR FOUNDATION     = PENDING
```

`ph_TokenRoles` queda congelado. Los bloques posteriores no pueden modificarlo salvo un `DS-C01-FIX` explícito.

## Siguiente bloque permitido

```text
DS-C02 — Classic + Modern controls
```

`DS-C02` puede tocar únicamente:

```text
ph_ClassicControls
ph_ModernControls
```

No debe modificar `ph_TokenRoles` ni ninguna geometría de DS-S01.
