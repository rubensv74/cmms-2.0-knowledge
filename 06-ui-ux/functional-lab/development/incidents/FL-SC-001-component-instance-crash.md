# FL-SC-001 — Studio se cierra al insertar instancia de CanvasComponent

**Fecha:** 2026-08-10  
**Estado:** RESOLVED — CORRECTIVE PATTERN VALIDATED  
**Bloque afectado:** F01-00A  
**Componente:** `cmp_FL_SidebarPro`

## 1. Efecto inicial

La definición completa inicial de `cmp_FL_SidebarPro` fue aceptada por Power Apps Studio, pero Studio se cerró al insertar una instancia.

## 2. Evidencia acumulada

```text
R1 root-only                                  PASS
R2 identidad/texto                           PASS
R3 contenedores estáticos                    PASS
R4 navegación visual sin eventos             PASS
R5 Text+Boolean+Color por contrato reducido   FAIL
R5-T Input/Text declarado+consumido           FAIL
R5-TD Input/Text declarado, no consumido      FAIL
R5-TM Input/Text creado manualmente en Studio PASS
R5-TB binding YAML → AppTitle manual           PASS
cmp_HeatMapPro PULSE                          PASS / integrated
RC2 Sidebar contrato HeatMap-style             PASS / INSTANCE_SAFE
```

## 3. Corrección de diagnóstico

Se había promovido demasiado pronto la hipótesis de que `CustomProperties` dentro del Source Code era la causa.

Esa generalización queda retirada de forma definitiva.

`cmp_HeatMapPro` aporta un contraejemplo real y mucho más fuerte: utiliza numerosos Inputs Text, Boolean, Number, Color y Table, además de Outputs y Events, y se integra correctamente en PULSE.

Por tanto:

```text
CustomProperties != causa demostrada
```

## 4. Diferencial estructural relevante

La declaración original del Sidebar simplificaba sus Inputs:

```yaml
PropertyKind: Input
DataType: ...
Default: ...
```

La referencia estable `cmp_HeatMapPro` utiliza de forma sistemática:

```yaml
PropertyKind: Input
DisplayName: ...
Description: ...
DataType: ...
Default: ...
```

Esta diferencia se utilizó para construir RC2.

## 5. RC2 — correctivo aplicado

RC2 restauró el Sidebar completo con:

- `CustomProperties`;
- Inputs Text, Boolean, Color y Table;
- `SelectedKey` Output;
- `OnSelectItem` Event;
- Gallery y bindings internos;
- geometría expandida/colapsada;
- metadatos de Input siguiendo el patrón `cmp_HeatMapPro`.

La prueba se realizó sobre un componente limpio para evitar contaminación de las propiedades manuales creadas durante el diagnóstico R5.

Resultado comunicado por el usuario:

```text
RC2 funciona correctamente
la instancia se inserta
Studio permanece estable
```

## 6. Causa y alcance

### Causa de proceso confirmada

```text
DEFINITION_ACCEPTED != INSTANCE_SAFE
```

### Patrón correctivo confirmado

> Un contrato público completo modelado a partir de un componente real `INSTANCE_SAFE`, incluyendo los metadatos que usa esa referencia para los Inputs, permite instanciar correctamente el Sidebar completo con `CustomProperties`.

### Causa técnica exacta

No se declara que `DisplayName` o `Description` sean individualmente la causa única del cierre original porque RC2 también se creó sobre una definición limpia. El detalle interno de hidratación/estado anterior no se aisló y no aporta valor suficiente para seguir investigándolo.

## 7. Regla preventiva

Para nuevos CanvasComponents:

```text
1. elegir referencia instance-safe equivalente
2. copiar el patrón completo de CustomProperties por PropertyKind
3. no simplificar metadatos por intuición
4. validar definición
5. insertar instancia aislada
6. guardar/reabrir
7. validar contrato y comportamiento
```

Una evidencia negativa aislada no debe convertirse en prohibición de una característica si existen contraejemplos positivos en el mismo entorno.

## 8. Cierre

FL-SC-001 queda cerrado porque:

1. el Sidebar completo con contrato público vuelve a ser `INSTANCE_SAFE`;
2. `CustomProperties` queda rehabilitado como patrón válido;
3. existe un correctivo reproducible basado en una referencia estable de PULSE;
4. el aprendizaje queda documentado localmente y en la base de conocimiento central.

Si un futuro componente falla con propiedades custom, se abrirá un incidente nuevo y se comparará directamente contra el componente estable más cercano.
