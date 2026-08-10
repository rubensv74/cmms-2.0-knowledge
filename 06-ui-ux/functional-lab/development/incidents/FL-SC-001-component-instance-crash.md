# FL-SC-001 — Studio se cierra al insertar instancia de CanvasComponent

**Fecha:** 2026-08-10  
**Estado:** RESOLVED — OPERATIONAL WORKAROUND VALIDATED  
**Severidad original:** alta para el flujo de autoría  
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
R5-BM Boolean micro-test                       STOPPED — no aporta valor proporcional
RC1 Sidebar premium completo                   PASS — user validated in Studio
```

## 3. Causa operativa delimitada

El detalle interno de serialización/hidratación de Microsoft no es observable desde la superficie Source Code usada por el maker. Sin embargo, la frontera operativa quedó demostrada:

```text
UNSAFE AUTHORING PATH OBSERVED
CustomProperties metadata injected through the tested pasteable Source Code surface

SAFE AUTHORING PATH
public properties created/maintained in Studio when required
+
visual/body YAML without CustomProperties
```

La propiedad `Input/Text` creada manualmente en Studio fue instance-safe y pudo ser consumida desde YAML. El Source Code visible de Studio no mostraba esa propiedad pública, por lo que no debe tratarse como representación completa del contrato.

## 4. Correctivo aplicado

Se abandonó la validación microscópica por tipo de propiedad y se reconstruyó el Sidebar premium completo como RC1:

- identidad CMMS 2.0 / Functional Lab;
- 10 destinos del Functional Journey;
- `Gallery@2.15.0` con selección local;
- estados active/hover/pressed;
- caso P-101;
- sin `CustomProperties:`;
- sin globals;
- sin assets externos.

Resultado comunicado por el usuario:

```text
RC1 funciona
```

Se considera por tanto `INSTANCE_SAFE` para continuar la Foundation.

## 5. Regla preventiva permanente

Para el flujo de Source Code pegable usado en Functional Lab:

```text
PUBLIC CONTRACT
→ Studio, solo cuando se necesite

VISUAL BODY / LAYOUT / FORMULAS
→ Source Code incremental

CustomProperties:
→ NO inyectar en YAML pegable salvo nueva evidencia explícita de soporte
```

Todo componente reutilizable sigue obligado a superar:

```text
PASS_STATIC
DEFINITION_ACCEPTED
INSTANCE_SAFE
PUBLIC_CONTRACT_VALIDATED
VISUAL_QA_VALIDATED
READY_FOR_INTEGRATION
```

## 6. Cierre

FL-SC-001 queda cerrado operacionalmente porque:

1. existe una estrategia de autoría estable y reproducible;
2. el Sidebar completo RC1 ha sido validado en Studio por el usuario;
3. el patrón inseguro queda documentado y excluido del flujo normal;
4. el aprendizaje está incorporado en la compatibilidad local y la base de conocimiento central.

Si un futuro contrato público concreto falla, se abrirá un incidente nuevo y acotado; no se reabre FL-SC-001 por defecto.
