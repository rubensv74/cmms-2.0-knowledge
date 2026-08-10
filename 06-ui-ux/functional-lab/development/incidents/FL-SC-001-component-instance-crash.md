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
```

### R5-TD — Source Code

Baseline mínimo R1 + una única CustomProperty:

```text
AppTitle
PropertyKind: Input
DataType: Text
Default: ="CMMS 2.0"
```

Ningún control consumía la propiedad.

Resultado:

```text
DEFINITION_ACCEPTED PASS
INSTANCE_SAFE       FAIL — Studio closes on insertion
```

### R5-TM — creación manual en Studio

Sobre el mismo enfoque mínimo, se creó desde la interfaz de Power Apps Studio una propiedad:

```text
Display name: App Title
Property name: AppTitle
Property type: Data
Definition: Input
Data type: Text
```

La propiedad no se consumió desde ningún control.

Resultado real comunicado:

```text
INSTANCE_SAFE PASS
```

## 3. Interpretación actual

### Causa de proceso confirmada

`DEFINITION_ACCEPTED` no demuestra seguridad de instancia. `INSTANCE_SAFE` es un gate independiente y obligatorio.

Además, ya no puede asumirse que una CustomProperty redactada manualmente en `.pa.yaml` sea equivalente a la misma propiedad creada por Studio.

### Causa técnica

```text
UNKNOWN — ISOLATED TO SOURCE-CODE AUTHORING / SERIALIZATION PATH FOR CUSTOM PROPERTY
```

La evidencia demuestra, en este baseline:

1. `Input/Text` como capacidad del componente es viable, porque la propiedad creada manualmente en Studio es instance-safe.
2. El cierre no requiere consumo/binding, porque R5-TD falla sin referencias a la propiedad.
3. El diferencial observado está en el camino usado para crear/serializar/hidratar la CustomProperty desde Source Code.

Todavía NO está demostrado cuál es la diferencia exacta de esquema o metadatos entre la declaración manual y la generada por nuestro YAML.

## 4. Superficies descartadas como suficientes

R1–R4 no reproducen el cierre por sí solas en las configuraciones probadas:

- CanvasComponent mínimo;
- `GroupContainer@1.5.0` ManualLayout;
- `ModernText@1.0.0` estático;
- AutoLayout vertical;
- contenedores anidados estáticos;
- Rectangle/Icon/Label/Button estáticos sin eventos.

R5-TM permite además descartar que `Input/Text` sea intrínsecamente inseguro en esta app.

## 5. Siguiente prueba discriminante — R5-TS

No se redactará otra CustomProperty a mano en YAML todavía.

Objetivo: capturar cómo **Power Apps Studio serializa realmente** la propiedad `AppTitle` creada manualmente y compararla con la declaración R5-TD que provocó el cierre.

Procedimiento:

1. mantener la instancia R5-TM estable;
2. abrir el Source Code de la definición del componente;
3. localizar el bloque que Studio haya generado para `AppTitle`;
4. copiar ese fragmento exacto, incluidos metadatos adicionales si existen;
5. comparar Studio-generated vs R5-TD;
6. solo después construir un reproducer Source Code basado en la serialización real de Studio.

Interpretación:

- si la serialización de Studio difiere, la diferencia pasa a ser candidata directa del incidente;
- si es idéntica, habrá que investigar metadatos no visibles, estado interno o secuencia de creación.

No se prueban R6, PageHeader ni App Shell hasta cerrar esta comparación.

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

Regla nueva demostrada:

> Una CustomProperty creada por Source Code no se considerará equivalente a una propiedad creada por Studio aunque nombre, tipo y valor por defecto parezcan iguales. Si existe un fallo de instancia, capturar primero la serialización generada por Studio y usarla como referencia de esquema.

Hasta cerrar FL-SC-001, el contrato público del Functional Lab se autorizará primero mediante Studio y después se trasladará a código únicamente cuando la representación serializada haya sido validada.

## 7. Criterio de cierre

FL-SC-001 solo podrá cerrarse cuando:

1. se identifique la diferencia real del camino Source Code o se documente un workaround estable;
2. exista una estrategia de autoría reproduciblemente instance-safe;
3. la fuente completa corregida sea estable al insertar, guardar y reabrir;
4. contrato público y Visual QA pasen;
5. el aprendizaje reutilizable central quede actualizado.
