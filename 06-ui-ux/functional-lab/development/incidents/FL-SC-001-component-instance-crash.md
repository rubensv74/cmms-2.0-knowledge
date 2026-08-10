# FL-SC-001 — Studio se cierra al insertar instancia de CanvasComponent

**Fecha:** 2026-08-10  
**Estado:** OPEN — BLOCKING  
**Severidad:** alta para el flujo de autoría  
**Bloque afectado:** F01-00A  
**Componente:** `cmp_FL_SidebarPro`

## 1. Efecto confirmado

La definición Source Code completa inicial de `cmp_FL_SidebarPro` fue aceptada por Power Apps Studio, pero Studio se cerró al insertar una instancia.

La reducción incremental ha reproducido el cierre de nuevo en R5 y R5-T después de que R1–R4 fueran `INSTANCE_SAFE`.

## 2. Evidencia acumulada

```text
R1 root-only                         PASS
R2 identidad/texto                  PASS
R3 contenedores estáticos           PASS
R4 navegación visual sin eventos    PASS
R5 Text+Boolean+Color                FAIL
R5-T Input/Text declarado+consumido FAIL
```

### R5-T

R5-T volvió al baseline R4 validado y añadió una única CustomProperty:

```text
AppTitle
PropertyKind: Input
DataType: Text
Default: ="CMMS 2.0"
```

La propiedad se consumía únicamente en:

```text
ModernText.Text = cmp_FL_SidebarPro.AppTitle
```

Resultado real comunicado:

```text
R5-T cierra Studio
```

## 3. Causa

### Causa de proceso confirmada

`DEFINITION_ACCEPTED` no demuestra `INSTANCE_SAFE`.

### Causa técnica concreta

```text
UNKNOWN — SURFACE NARROWED TO INPUT/TEXT DECLARATION VS CONSUMPTION
```

R5-T permite descartar que sea necesaria la combinación Text+Boolean+Color para reproducir el problema: `Input/Text` declarado y consumido ya basta en ese baseline.

Todavía NO puede afirmarse si la causa está en:

- declarar una CustomProperty `Input/Text`;
- consumirla desde un control hijo;
- el binding concreto `ModernText.Text`;
- una interacción entre la propiedad y la composición R4.

## 4. Superficies descartadas como suficientes

R1–R4 no reproducen el cierre por sí solos en las configuraciones probadas:

- CanvasComponent mínimo;
- `GroupContainer@1.5.0` ManualLayout;
- `ModernText@1.0.0` estático;
- AutoLayout vertical;
- contenedores anidados estáticos;
- Rectangle/Icon/Label/Button estáticos sin eventos.

## 5. Diagnóstico actual

Siguiente correctivo:

```text
R5-TD — Input/Text DECLARADO, NO CONSUMIDO
```

Para aumentar el poder diagnóstico, R5-TD parte del baseline mínimo R1 `INSTANCE_SAFE` y añade únicamente la declaración `Input/Text`, sin ningún control que la referencie.

Interpretación:

- **FAIL** → la mera declaración `Input/Text` es suficiente para reproducir el cierre en este baseline;
- **PASS** → la declaración aislada es segura y el foco se desplaza al consumo/binding o a la interacción con la composición R4.

No se prepara R6 ni F01-00B mientras FL-SC-001 permanezca abierto.

## 6. Referencia Microsoft

La documentación vigente de Microsoft describe las propiedades Data/Input de componentes Canvas como mecanismo soportado para pasar valores como texto o color entre la app y el componente. El cierre observado se registra por tanto como incidente/incompatibilidad de autoría y no como comportamiento esperado.

## 7. Regla preventiva inmediata

Todo CanvasComponent debe atravesar:

```text
PASS_STATIC
DEFINITION_ACCEPTED
INSTANCE_SAFE
PUBLIC_CONTRACT_VALIDATED
VISUAL_QA_VALIDATED
READY_FOR_INTEGRATION
```

Cuando una etapa falla, reducir exclusivamente su delta antes de avanzar.

## 8. Criterio de cierre

FL-SC-001 solo podrá cerrarse cuando:

1. la superficie técnica esté suficientemente delimitada;
2. la fuente completa corregida sea `INSTANCE_SAFE`;
3. guardar/reabrir sea estable;
4. contrato público y Visual QA pasen;
5. el aprendizaje central se actualice si aparece una regla reusable demostrada.
