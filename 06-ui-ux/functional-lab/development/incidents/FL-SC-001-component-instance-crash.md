# FL-SC-001 — Studio se cierra al insertar instancia de CanvasComponent

**Fecha:** 2026-08-10  
**Estado:** OPEN — BLOCKING  
**Severidad:** alta para el flujo de autoría  
**Bloque afectado:** F01-00A  
**Componente:** `cmp_FL_SidebarPro`

## 1. Efecto confirmado

La definición Source Code completa inicial de `cmp_FL_SidebarPro` fue aceptada por Power Apps Studio, pero Studio se cerró al insertar una instancia.

La reducción incremental ha reproducido el mismo cierre con una definición mínima que contiene una sola `CustomProperty` `Input/Text`, incluso **sin consumirla desde ningún control hijo**.

## 2. Evidencia acumulada

```text
R1 root-only                              PASS
R2 identidad/texto                       PASS
R3 contenedores estáticos                PASS
R4 navegación visual sin eventos         PASS
R5 Text+Boolean+Color                     FAIL
R5-T Input/Text declarado+consumido       FAIL
R5-TD Input/Text declarado, no consumido  FAIL
```

### R5-TD — resultado real

Configuración:

- `CanvasComponent`;
- una única CustomProperty `AppTitle`;
- `PropertyKind: Input`;
- `DataType: Text`;
- `Default: ="CMMS 2.0"`;
- root `GroupContainer@1.5.0` ManualLayout;
- ningún control consume `AppTitle`;
- sin Gallery, Table, Output, Event, OnSelect ni datos dinámicos.

Resultado:

```text
DEFINITION_ACCEPTED PASS
INSTANCE_SAFE       FAIL — Studio closes on insertion
```

## 3. Interpretación actual

### Causa de proceso confirmada

`DEFINITION_ACCEPTED` no demuestra seguridad de instancia. `INSTANCE_SAFE` es un gate independiente y obligatorio.

### Causa técnica

```text
UNKNOWN — SURFACE NARROWED TO SOURCE-CODE-CREATED INPUT/TEXT DECLARATION PATH
```

R5-TD demuestra que, en el baseline probado, **la declaración Source Code de una única propiedad custom `Input/Text` es suficiente para reproducir el cierre**.

Esto todavía NO demuestra que:

- las propiedades `Input/Text` creadas manualmente en Studio sean inseguras;
- el runtime de Canvas Components no soporte inputs de texto;
- todas las CustomProperties creadas por Source Code fallen;
- Boolean, Color, Table, Output o Event compartan la misma causa.

## 4. Evidencia oficial relevante

Microsoft documenta las propiedades Data/Input como mecanismo soportado para pasar valores —incluidos texto y color— desde la app host hacia un componente Canvas.

Microsoft también advierte que el esquema `.pa.yaml` está en desarrollo activo; el formato Source Code actual está orientado a control de código fuente y la edición externa está soportada únicamente mediante Power Platform Git Integration.

Referencias oficiales:

- `https://learn.microsoft.com/power-apps/maker/canvas-apps/component-properties`
- `https://learn.microsoft.com/power-apps/maker/canvas-apps/power-apps-yaml`

## 5. Siguiente prueba discriminante — R5-TM

No se genera otro YAML todavía.

Objetivo: separar el **motor real de CustomProperties** del **camino de creación mediante Source Code**.

Prueba manual en Studio:

1. volver a un componente mínimo instance-safe sin CustomProperties;
2. crear manualmente desde el panel del componente una propiedad custom Data/Input/Text;
3. no consumirla en ningún control;
4. guardar;
5. insertar una instancia nueva;
6. registrar si Studio permanece estable.

Interpretación:

- **manual PASS** → el runtime de Input/Text es viable y el foco pasa al camino Source Code/serialización/hidratación de la CustomProperty;
- **manual FAIL** → el foco pasa al motor/configuración de Enhanced component properties en la app/Studio activo.

No se prueban Boolean, Color, Gallery, Table, Output ni Event hasta cerrar esta bifurcación.

## 6. Regla preventiva inmediata

Todo CanvasComponent debe atravesar:

```text
PASS_STATIC
DEFINITION_ACCEPTED
INSTANCE_SAFE
PUBLIC_CONTRACT_VALIDATED
VISUAL_QA_VALIDATED
READY_FOR_INTEGRATION
```

Cuando una etapa falla, reducir únicamente su delta. No continuar añadiendo responsabilidades.

Además, hasta resolver FL-SC-001:

> No crear contratos públicos de componentes del Functional Lab exclusivamente mediante Source Code y asumirlos válidos por aceptación de definición. Toda CustomProperty deberá demostrar seguridad de instancia; cuando sea necesario se comparará creación Source Code frente a creación manual en Studio.

## 7. Criterio de cierre

FL-SC-001 solo podrá cerrarse cuando:

1. se determine si el fallo pertenece al camino Source Code o al motor de propiedades custom;
2. exista una estrategia de autoría reproduciblemente instance-safe;
3. la fuente completa corregida sea estable al insertar, guardar y reabrir;
4. contrato público y Visual QA pasen;
5. el aprendizaje reutilizable central se actualice con la regla demostrada.
