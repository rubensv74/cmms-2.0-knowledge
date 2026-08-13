# CL-C04 — GatePanelPro — Source precheck

**Fecha:** 2026-08-12  
**Componente:** `cmp_FL_GatePanelPro` RC2  
**Harness:** `CL-C04_GatePanelPro_isolated_validation.pa.yaml`  
**Estado:** `SOURCE PRECHECK PASS / STUDIO PENDING`

## Contrato del bloque

```text
BLOCK       CL-C04
TYPE        C — Component validation harness
TARGET      scr_ComponentLab / ph_ComponentUnderTest + ph_TestControls
DEPENDS ON  CL-S01 STRUCTURE FROZEN + COLOR FOUNDATION APPROVED
TOUCHES     contenido de los dos slots solamente
DO NOT      modificar geometría del lab ni componentes ya aprobados
```

## Pre-flight

Comprobado antes de entregar:

```text
[PASS] raíz compatible con reemplazo de Children existentes
[PASS] no hay GroupContainer anidado dentro de Gallery
[PASS] no hay SVG inline
[PASS] no hay Label@2.5.1 con Radius*
[PASS] no hay Classic/Button@2.2.0 con AccessibleLabel
[PASS] no hay scalar Power Fx inline con literal sensible ': '
[PASS] no hay scalar Power Fx inline con literal sensible ' #'
[PASS] fórmulas Switch multilínea usan bloque |-
[PASS] texto visible >=11
[PASS] safe palette RC2 preservada
[PASS] identidad del componente debe actualizarse in situ
```

## Semántica funcional a validar

```text
blocked  -> CanContinue=false
warning  -> CanContinue=false
passed   -> CanContinue=true
passed + Continuar -> OnContinue / CONTINUE
```

El color informa del estado, pero no controla la autorización. La autorización depende explícitamente de `CanContinue`.

## Gate Studio

La revisión solo puede pasar a `READY_FOR_INTEGRATION` después de observar en Studio:

- los tres estados;
- botón Continuar deshabilitado en bloqueado/advertencia;
- botón habilitado en superado;
- evento `OnContinue` funcionando;
- contenido completo sin clipping;
- ausencia de superficies negras accidentales.
