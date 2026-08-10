# FL-SC-001 — Studio se cierra al insertar instancia de CanvasComponent

**Fecha:** 2026-08-10  
**Estado:** OPEN — BLOCKING  
**Severidad:** alta para el flujo de autoría  
**Bloque afectado:** F01-00A  
**Componente:** `cmp_FL_SidebarPro`

## 1. Efecto confirmado

La definición Source Code completa inicial de `cmp_FL_SidebarPro` fue integrada en Power Apps Studio sin errores aparentes.

Al insertar una instancia del componente completo inicial en la app `CMMS 2.0 Functional Lab`, Power Apps Studio se cerró.

La reducción incremental ha reproducido de nuevo el cierre en `F01-00A-R5`, después de que R1–R4 fueran `INSTANCE_SAFE`.

## 2. Evidencia acumulada

```text
R1 root-only                         PASS
R2 identidad/texto                  PASS
R3 contenedores estáticos           PASS
R4 navegación visual sin eventos    PASS
R5 custom inputs Text+Boolean+Color FAIL — Studio closes on instance
```

R5 introducía únicamente estas propiedades custom primitivas sobre el baseline R4 ya validado:

- `AppTitle` — Input / Text;
- `ShowEnvironment` — Input / Boolean;
- `AccentColor` — Input / Color.

Las tres propiedades eran consumidas por controles ya validados:

- Text → `ModernText.Text`;
- Boolean → `ModernText.Visible`;
- Color → `ModernText.Color` y `Rectangle.Fill`.

R5 seguía sin contener:

- `Table`;
- `Gallery`;
- `Output`;
- `Event`;
- `OnSelect`;
- `ThisItem`;
- navegación real.

## 3. Causa

### Causa de proceso confirmada

`DEFINITION_ACCEPTED` no es suficiente para integrar un CanvasComponent. El gate `INSTANCE_SAFE` es obligatorio.

### Causa técnica concreta

```text
UNKNOWN — SURFACE NARROWED TO R5 DELTA
```

R5 demuestra únicamente que **algún elemento dentro del delta de propiedades custom primitivas o su consumo** es necesario en esta reproducción.

Todavía NO puede afirmarse que:

- todas las CustomProperties sean inseguras;
- `Text` sea la causa;
- `Boolean` sea la causa;
- `Color` sea la causa;
- el problema sea declarar la propiedad frente a consumirla.

## 4. Superficies descartadas como suficientes

R1–R4 permiten afirmar, para las configuraciones concretas probadas, que no reproducen el cierre por sí solas:

- CanvasComponent mínimo;
- `GroupContainer@1.5.0` ManualLayout;
- `ModernText@1.0.0` estático;
- AutoLayout vertical;
- contenedores anidados estáticos;
- `Rectangle@2.3.0` estático;
- `Classic/Icon@2.5.0` estático;
- `Label@2.5.1` sin `Radius*`;
- `Classic/Button@2.2.0` sin `AccessibleLabel` y sin `OnSelect`.

## 5. Estrategia de diagnóstico actual

R5 se subdivide por tipo de propiedad antes de introducir cualquier otra responsabilidad:

```text
R5-T  Text input only
→ si PASS: probar Boolean y Color por separado
→ si FAIL: subdividir declaración vs consumo de Text
```

El siguiente correctivo es `F01-00A-R5-T` y partirá del baseline R4 validado, añadiendo exclusivamente una propiedad custom `Text` consumida por el título.

No se prepara R6 ni F01-00B mientras FL-SC-001 permanezca abierto.

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

Cuando una etapa falle, reducir únicamente el delta de esa etapa. No avanzar a nuevas responsabilidades ni promover hipótesis a causa sin reproducer reducido.

## 7. Criterio de cierre

FL-SC-001 solo podrá cerrarse cuando:

1. la superficie técnica esté suficientemente delimitada;
2. la fuente completa corregida sea `INSTANCE_SAFE`;
3. guardar/reabrir sea estable;
4. el contrato público y Visual QA pasen;
5. el aprendizaje reutilizable central se actualice si aparece una regla nueva demostrada.
