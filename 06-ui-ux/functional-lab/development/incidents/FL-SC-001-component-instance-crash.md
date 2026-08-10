# FL-SC-001 — Studio se cierra al insertar instancia de CanvasComponent

**Fecha:** 2026-08-10  
**Estado:** OPEN — BLOCKING UNTIL FULL COMPONENT RECOVERY  
**Severidad:** alta para el flujo de autoría  
**Bloque afectado:** F01-00A  
**Componente:** `cmp_FL_SidebarPro`

## 1. Efecto inicial

La definición Source Code completa inicial de `cmp_FL_SidebarPro` fue aceptada por Power Apps Studio, pero Studio se cerró al insertar una instancia.

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
R5-TS Source Code visible tras R5-TM           AppTitle OMITIDO
R5-TB binding YAML → AppTitle manual           PASS
```

## 3. Hallazgo demostrado

R5-TB prueba que un control definido mediante Source Code puede consumir de forma estable una propiedad pública `Data / Input / Text` creada manualmente en Studio:

```text
Contrato público AppTitle → creado en Studio
ModernText.Text            → =cmp_FL_SidebarPro.AppTitle
CustomProperties:          → NO presente en YAML pegable
INSTANCE_SAFE              → PASS
```

Por tanto:

1. `Input/Text` es viable en la app activa.
2. El binding desde el cuerpo Source Code hacia una propiedad creada por Studio es viable.
3. El cierre se reproduce cuando el contrato público se intenta crear inyectando `CustomProperties:` en la superficie YAML pegable probada.
4. El Source Code visible de Studio no representa completamente el contrato público, porque `AppTitle` existe pero no aparece serializado en esa superficie.

## 4. Causa

### Causa de proceso confirmada

`DEFINITION_ACCEPTED` no demuestra `INSTANCE_SAFE`.

### Causa operativa suficientemente delimitada

```text
UNSAFE AUTHORING PATH:
CustomProperties metadata injected through the tested pasteable Source Code surface

SAFE AUTHORING PATH DEMONSTRATED FOR TEXT INPUT:
public property created in Studio
+
visual/body YAML consumes that property
```

El detalle interno exacto de serialización/hidratación permanece no observable en esta superficie, pero ya existe un workaround estable y reproducible para continuar el desarrollo.

## 5. Estrategia de autoría corregida

```text
CONTRATO PÚBLICO
Inputs / Outputs / Events → crear/configurar primero en Studio

CUERPO DEL COMPONENTE
Controls / layout / formulas → Source Code incremental validado

BINDING
Source Code puede referenciar propiedades ya creadas en Studio, tras smoke test
```

No volver a introducir `CustomProperties:` en el YAML pegable del Functional Lab salvo nueva evidencia explícita de compatibilidad.

## 6. Siguiente validación

Antes de reconstruir el Sidebar completo se validarán los tipos públicos que realmente necesita, uno por uno y Studio-first.

Siguiente incremento:

```text
R5-BM — Data / Input / Boolean creado manualmente en Studio
         + binding simple Visible desde YAML
```

No se introduce todavía geometría condicional compleja.

## 7. Gate de cierre

FL-SC-001 permanecerá abierto hasta que:

1. el Sidebar completo reconstruido sea `INSTANCE_SAFE`;
2. guardar/reabrir sea estable;
3. el contrato público requerido quede validado;
4. Visual QA pase;
5. el aprendizaje central permanezca actualizado.
