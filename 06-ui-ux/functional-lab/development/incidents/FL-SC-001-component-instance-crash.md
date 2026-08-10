# FL-SC-001 — Studio se cierra al insertar instancia de CanvasComponent

**Fecha:** 2026-08-10  
**Estado:** OPEN — BLOCKING  
**Severidad:** alta para el flujo de autoría  
**Bloque afectado:** F01-00A  
**Componente:** `cmp_FL_SidebarPro`

## 1. Efecto confirmado

La definición Source Code completa inicial de `cmp_FL_SidebarPro` fue aceptada por Power Apps Studio, pero Studio se cerró al insertar una instancia.

La reducción incremental ha aislado una diferencia crítica entre dos caminos de autoría del mismo contrato `Data / Input / Text`.

## 2. Evidencia acumulada

```text
R1 root-only                                  PASS
R2 identidad/texto                           PASS
R3 contenedores estáticos                    PASS
R4 navegación visual sin eventos             PASS
R5 Text+Boolean+Color por Source Code         FAIL
R5-T Input/Text declarado+consumido           FAIL
R5-TD Input/Text declarado, no consumido      FAIL
R5-TM Input/Text creado manualmente en Studio PASS
R5-TS Source Code visible tras R5-TM           CAPTURED
```

### R5-TD — Source Code

Baseline mínimo R1 + una única CustomProperty `AppTitle` (`Input/Text`), no consumida.

```text
DEFINITION_ACCEPTED PASS
INSTANCE_SAFE       FAIL — Studio closes on insertion
```

### R5-TM — creación manual en Studio

Se creó desde la interfaz de Studio:

```text
Display name: App Title
Property name: AppTitle
Property type: Data
Definition: Input
Data type: Text
```

La propiedad no se consumió.

```text
INSTANCE_SAFE PASS
```

### R5-TS — captura del Source Code visible

Después de R5-TM, el Source Code mostrado por Studio fue capturado completo.

Hallazgo:

```text
NO aparece CustomProperties:
NO aparece AppTitle
```

El código visible contiene únicamente `DefinitionType`, `Properties` y `Children`, aunque `AppTitle` existe funcionalmente en el componente y la instancia es estable.

## 3. Interpretación actual

### Causa de proceso confirmada

`DEFINITION_ACCEPTED` no demuestra seguridad de instancia. `INSTANCE_SAFE` es un gate independiente y obligatorio.

Además, el Source Code visible de esta superficie no puede tratarse como representación completa del contrato público del CanvasComponent.

### Superficie técnica delimitada

```text
SOURCE-CODE-INJECTED CustomProperties BLOCK IS SUFFICIENT TO REPRODUCE
STUDIO-CREATED Input/Text IS INSTANCE-SAFE
STUDIO VISIBLE SOURCE OMITS THAT CUSTOM PROPERTY
```

No está demostrado el detalle interno exacto de serialización/hidratación que provoca el cierre, pero sí existe una frontera operativa suficiente para corregir el método de trabajo.

## 4. Evidencia oficial relevante

Microsoft documenta `Data/Input` como capacidad soportada de Canvas Components.

Microsoft también indica que el YAML de canvas apps está en desarrollo activo, puede estar incompleto y está orientado a revisión/control de código fuente; la edición externa soportada se vincula a Power Platform Git Integration.

Referencias oficiales:

- `https://learn.microsoft.com/power-apps/maker/canvas-apps/component-properties`
- `https://learn.microsoft.com/power-apps/maker/canvas-apps/power-apps-yaml`

## 5. Estrategia de autoría corregida

A partir de R5-TS:

```text
CONTRATO PÚBLICO DEL COMPONENTE
Custom properties → crear/configurar en Studio

CUERPO VISUAL DEL COMPONENTE
Controls / layout / fórmulas → puede construirse incrementalmente con Source Code validado
```

No volver a inyectar un bloque `CustomProperties:` en el YAML pegable del Functional Lab mientras no exista evidencia explícita de soporte para esa superficie de autoría.

## 6. Siguiente prueba — R5-TB

Objetivo: comprobar si un control definido por Source Code puede consumir de forma estable una propiedad `AppTitle` que ya fue creada manualmente en Studio.

R5-TB:

1. mantener `AppTitle` creado manualmente;
2. pegar Source Code **sin `CustomProperties:`**;
3. añadir un único `ModernText` cuyo `Text` sea `cmp_FL_SidebarPro.AppTitle`;
4. guardar;
5. insertar instancia nueva;
6. comprobar save/reopen.

Interpretación:

- PASS → queda demostrada una estrategia híbrida estable: contrato en Studio + cuerpo por Source Code;
- FAIL → el binding desde código hacia una propiedad manual requiere una reducción adicional.

No se avanza a R6 ni F01-00B antes de esta prueba.

## 7. Regla preventiva inmediata

```text
PASS_STATIC
DEFINITION_ACCEPTED
INSTANCE_SAFE
PUBLIC_CONTRACT_VALIDATED
VISUAL_QA_VALIDATED
READY_FOR_INTEGRATION
```

Para CustomProperties en el flujo actual:

> No declarar `CustomProperties:` en YAML pegable. Crear primero el contrato en Studio, probar instancia y después validar por separado cualquier fórmula Source Code que consuma ese contrato.

## 8. Criterio de cierre

FL-SC-001 podrá cerrarse cuando:

1. exista una estrategia de autoría reproduciblemente instance-safe;
2. el componente completo sea estable al insertar, guardar y reabrir;
3. el contrato público y Visual QA pasen;
4. el aprendizaje reutilizable central quede actualizado.
