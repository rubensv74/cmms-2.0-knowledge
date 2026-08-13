# CL-C04 — GatePanelPro — Studio validation

## Objetivo

Validar que `cmp_FL_GatePanelPro` representa correctamente el control formal de avance y que la autorización para continuar depende de `CanContinue`, no del color mostrado.

## Secuencia única

1. Selecciona `1 · Bloqueado`.
   - superficie roja suave;
   - resumen `No se puede iniciar RCM`;
   - `CanContinue · false`;
   - botón `Continuar a lógica RCM` deshabilitado.

2. Selecciona `2 · Advertencia`.
   - superficie ámbar suave;
   - resumen `Revisión adicional recomendada`;
   - `CanContinue · false`;
   - botón sigue deshabilitado.

3. Selecciona `3 · Superado`.
   - superficie verde suave;
   - resumen `Etapa preparada para continuar`;
   - `CanContinue · true`;
   - botón habilitado.

4. Pulsa `Continuar a lógica RCM`.
   - `Último evento · CONTINUE`.

5. Guarda/reabre y repite al menos el estado Superado + Continuar.

## Visual QA

```text
[ ] no superficies negras accidentales
[ ] título, resumen, razón, acción y rol legibles
[ ] no clipping con el contenido representativo
[ ] botón no invade el contenido
[ ] estados blocked/warning/passed claramente diferenciables
[ ] texto visible >=11
```

## PASS

Si la secuencia completa funciona:

```text
CL-C04 GATEPANEL PASS
```

Promoción esperada:

```text
SOURCE_VALID                    PASS
COMPONENT_DEFINITION_ACCEPTED   PASS
INSTANCE_SAFE                   PASS
PUBLIC_CONTRACT_VALIDATED       PASS
VISUAL_QA_VALIDATED             PASS
READY_FOR_INTEGRATION           PASS
```
