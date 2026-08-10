# FL-SC-001 — Studio se cierra al insertar instancia de CanvasComponent

**Fecha:** 2026-08-10  
**Estado:** OPEN — ROOT CAUSE UNDER REVIEW  
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
R5 Text+Boolean+Color por CustomProperties    FAIL
R5-T Input/Text declarado+consumido           FAIL
R5-TD Input/Text declarado, no consumido      FAIL
R5-TM Input/Text creado manualmente en Studio PASS
R5-TB binding YAML → AppTitle manual           PASS
```

## 3. Corrección de una conclusión anterior

Se había promovido demasiado pronto la hipótesis de que `CustomProperties` dentro del Source Code pegable era el problema.

Esa generalización queda **retirada**.

El usuario aporta como contraejemplo real `cmp_HeatMapPro`, componente usado en PULSE que contiene un contrato público mucho más complejo con:

- Inputs Text, Boolean, Number, Color y Table;
- Outputs;
- Events;
- fórmulas que consumen esas propiedades;
- Gallery y controles complejos;
- instancia e integración funcional en PULSE.

Por tanto:

```text
CustomProperties != causa demostrada
```

## 4. Nuevo contraste principal

El primer diferencial sistemático entre el HeatMap funcional y el Sidebar fallido está en los metadatos de los Inputs.

HeatMap funcional:

```yaml
PropertyKind: Input
DisplayName: ...
Description: ...
DataType: ...
Default: ...
```

Sidebar original:

```yaml
PropertyKind: Input
DataType: ...
Default: ...
```

El Sidebar omitía `DisplayName` y `Description` en todos sus Inputs.

La documentación de Microsoft sobre propiedades de componentes trata `Display name`, `Property name` y `Description` como parte del contrato definido por el maker. Esto no demuestra todavía causalidad técnica, pero convierte la omisión en el candidato principal para una prueba comparativa directa.

## 5. Próxima prueba — RC2

Se abandona el laboratorio por tipos. Se reconstruirá el Sidebar completo original con una única modificación de contrato:

```text
Todos los Inputs reciben DisplayName + Description
siguiendo el patrón de cmp_HeatMapPro.
```

No se eliminarán `CustomProperties`, `NavItems`, Output ni Event para esta prueba.

Resultado esperado:

- **PASS** → fuerte evidencia de que el fallo estaba en la forma incompleta del contrato de propiedades custom;
- **FAIL** → continuar comparación diferencial con `cmp_HeatMapPro` buscando el siguiente delta estructural.

## 6. Regla de proceso que sí permanece confirmada

```text
DEFINITION_ACCEPTED != INSTANCE_SAFE
```

Todo CanvasComponent debe superar un smoke test de instancia antes de integrarse.

## 7. Criterio de cierre

FL-SC-001 solo se cerrará cuando el Sidebar completo con contrato público alcance `INSTANCE_SAFE` de forma reproducible y la diferencia causal o el patrón correctivo estén suficientemente demostrados.
