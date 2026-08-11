# F03 — Validación estática — HISTORICAL EVIDENCE

**Estado:** `REFERENCE_ONLY` desde 2026-08-11.  
**No utilizar este documento para promover componentes o `scr_FL_AMEF` en su revisión actual.**

## Qué demuestra todavía

La validación F03 conserva evidencia útil sobre:

```text
baseline Comfortable
no Label@2.5.1 + Radius*
no Classic/Button@2.2.0 + AccessibleLabel
ModernText estático → AutoHeight=true
contratos públicos completos
identidad de componente preservada
S4/O3/D3 → S×O12 / NPR36 como fixture P-101
criticidad de activo separada de riesgo AMEF
```

## Por qué ya no es gate de la revisión actual

Después de F03 cambiaron varias fuentes y se produjo una regresión de pantalla. Por tanto:

```text
PASS_STATIC histórico
≠ PASS_STATIC de una revisión posterior
≠ DEFINITION_ACCEPTED
≠ INSTANCE_SAFE
≠ VISUAL_QA_VALIDATED
```

Además, la estrategia actual ya no valida ocho definiciones juntas.

## Gate vigente

Componentes:

```text
SOURCE_VALID
→ COMPONENT_DEFINITION_ACCEPTED
→ INSTANCE_SAFE
→ PUBLIC_CONTRACT_VALIDATED
→ VISUAL_QA_VALIDATED
→ READY_FOR_INTEGRATION
```

Pantallas:

```text
S skeleton
→ validate/freeze
C placeholder replacement
→ validate/freeze
I integration
→ validate/freeze
Theme pass
```

## Color

La semántica histórica neutral/system/human/warning/danger/success se conserva como intención, pero la paleta se valida centralmente en `scr_DesignSystemLab`.

F03 deja de ser autoridad de color.

## AMEF

El YAML monolítico AMEF asociado a F03/F04 no es el siguiente bloque de construcción.

Referencia vigente:

`../S-AMEF-01/CONTRACT.md`

## Auditoría actual

Consultar:

```text
../../../../development/STATIC_SOURCE_AUDIT_2026-08-11.md
../../../../development/RECOVERY_HARDENING_AUDIT_2026-08-11.md
../../../../development/TOMORROW_RUNBOOK_2026-08-12.md
```
