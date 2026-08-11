# Functional Lab — Recovery Baseline R0 — SUPERSEDED

**Estado:** `SUPERSEDED` desde 2026-08-11.  
**Conservar únicamente como evidencia forense. No usar para instalar ni recuperar la app.**

## Por qué queda retirado

R0 demostró que era posible recuperar `HOME BASELINE PASS`, `FLH PASS`, `TAXONOMÍA PASS` y `ADR PASS` a partir de commits históricos. Sin embargo, el método tenía un defecto: recuperaba una fotografía antigua completa del archivo, incluyendo comportamientos visuales que posteriormente ya habían sido corregidos.

En concreto, algunas definiciones históricas utilizaban Inputs `Color` directamente para superficies, texto, selección y resaltado. Al reutilizarlas se reintrodujo el incidente de superficies negras observado en Studio.

Además, instalar pantallas una a una dejó el grafo de navegación incompleto y provocó numerosos errores `Name isn't valid. 'scr_FL_...'` para destinos canónicos que todavía no existían en Studio.

## Regla vigente

```text
NO usar commits históricos como fuente normal de instalación.
NO mezclar pantalla histórica + componentes actuales.
NO reconstruir el grafo pantalla a pantalla juzgando App Checker entre cada archivo.
```

La única fuente canónica es:

```text
branch: feature/f01-premium-foundation
```

### Componentes actuales

`06-ui-ux/functional-lab/power-apps/components/`

### Pantallas actuales

`06-ui-ux/functional-lab/power-apps/screens/`

### Auditoría que sustituye R0

`RECOVERY_HARDENING_AUDIT_2026-08-11.md`

### Procedimiento de instalación

`../power-apps/V2_INSTALLATION.md`

### Runbook operativo

`TOMORROW_RUNBOOK_2026-08-12.md`

## Evidencia histórica preservada

Los commits históricos enumerados en versiones anteriores de este documento siguen siendo útiles para análisis forense y comparación, pero **no son candidatos de instalación**.

## Regla de recuperación definitiva

> La unidad de recuperación es un ensamblaje coherente de la rama canónica, no un conjunto de archivos históricos seleccionados individualmente.
