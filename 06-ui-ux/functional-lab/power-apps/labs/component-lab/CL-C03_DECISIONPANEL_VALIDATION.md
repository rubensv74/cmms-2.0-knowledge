# CL-C03 — DecisionPanelPro isolated validation

**Componente:** `cmp_FL_DecisionPanelPro`  
**Harness:** `scr_ComponentLab`  
**Dependencia:** `CL-S01 STRUCTURE FROZEN` + `COLOR FOUNDATION APPROVED`

## 1. Definición in situ

Actualizar la definición EXISTENTE `cmp_FL_DecisionPanelPro` con:

`../../components/cmp_FL_DecisionPanelPro.pa.yaml`

No crear una segunda identidad ni `_1`.

## 2. Instalar harness

En `scr_ComponentLab`, sustituir únicamente:

```text
ph_ComponentUnderTest
ph_TestControls
```

usando `CL-C03_DecisionPanelPro_isolated_validation.pa.yaml`.

## 3. Cargar fixture

Pulsar:

```text
Cargar fixture
```

Estado inicial esperado:

```text
Sistema            Resultado lógico RCM · Tarea aplicable
Recomendación      Mantenimiento por condición
Decisión humana    Pendiente de decisión
Override           No
Confirmar          Habilitado
Último evento      READY
```

Visualmente deben distinguirse el bloque de sistema y el bloque de autoridad humana.

## 4. Confirmar recomendación

Dentro del propio `cmp_FL_DecisionPanelPro`, pulsar:

```text
Confirmar recomendación
```

Esperado:

```text
Último evento      CONFIRM
Decisión            Mantenimiento por condición
Override            No
```

La decisión humana confirma la recomendación, pero sigue representándose como decisión humana; no se fusionan ambas capas.

## 5. Override

Pulsar `Restablecer decisión` y después, dentro del componente:

```text
Modificar decisión
```

Esperado:

```text
Último evento      OVERRIDE
Decisión            Preventivo calendarizado
Override            Sí
```

El bloque humano debe cambiar visualmente a semántica de override/advertencia y mostrar la justificación.

## 6. Estado deshabilitado

Pulsar:

```text
Deshabilitar confirmar
```

Esperado:

```text
Confirmar          Deshabilitado
```

El botón `Confirmar recomendación` del componente debe quedar realmente deshabilitado. `Modificar decisión` debe seguir disponible.

Volver a habilitar antes de cerrar el smoke.

## 7. Visual QA

Comprobar a zoom 100%:

```text
[ ] no hay superficies negras inesperadas
[ ] textos visibles >=11 y legibles
[ ] sistema y decisión humana son visualmente distintos
[ ] override es claramente distinto de confirmación normal
[ ] explicación y motivo no se pisan ni generan mini-scrollbars
[ ] botones no se solapan
[ ] confirmación deshabilitada tiene estado inequívoco
```

## 8. Save / reopen

Guardar la app, recargar/reabrir Studio, volver a `scr_ComponentLab`, cargar fixture y ejecutar una confirmación o un override.

## PASS

Si todo es correcto:

```text
CL-C03 DECISIONPANEL PASS
```

Promoción esperada:

```text
SOURCE_VALID
→ COMPONENT_DEFINITION_ACCEPTED
→ INSTANCE_SAFE
→ PUBLIC_CONTRACT_VALIDATED
→ VISUAL_QA_VALIDATED
→ READY_FOR_INTEGRATION
```

## Failure rule

Si algo falla, detener CL-C03 y crear `CL-C03-FIX-xx` limitado al delta demostrado. No modificar pantallas funcionales para compensar un fallo del componente.
