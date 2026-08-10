# Functional Lab — Implementation Status

**Fecha:** 2026-08-10  
**Estado general:** F01 — Power Apps Premium Foundation  
**Último gate superado:** `F01-00A-R5-TM manual Text input` — INSTANCE_SAFE PASS  
**Gate actual:** `F01-00A-R5-TS Studio serialization comparison` — PENDING USER CAPTURE

## 1. Estado de incrementos

| Incremento | Estado | Resultado |
|---|---|---|
| F00-01..F00-09 | completed | Base funcional, journey, fixture, arquitectura y handoff definidos. |
| F01-00 Auditoría Power Apps Foundation | partial | Diagnóstico real de seguridad de instancia en curso. |
| F01-00A cmp_FL_SidebarPro | review-required | La versión completa inicial cerraba Studio al insertar instancia; FL-SC-001 abierto. |
| F01-00A-R1 root-only | validated-pass | CanvasComponent + root GroupContainer ManualLayout instance-safe. |
| F01-00A-R2 identity/text | validated-pass | ModernText estático instance-safe. |
| F01-00A-R3 static-containers | validated-pass | AutoLayout + contenedores anidados estáticos instance-safe. |
| F01-00A-R4 static-navigation | validated-pass | Rectangle + Icon + Label + Button estáticos sin eventos instance-safe. |
| F01-00A-R5 primitive inputs | failed-instance | Text + Boolean + Color por Source Code reproducen el cierre. |
| F01-00A-R5-T Text input | failed-instance | Un único Input/Text declarado+consumido por Source Code reproduce el cierre. |
| F01-00A-R5-TD Text declaration only | failed-instance | Un único Input/Text declarado por Source Code y no consumido reproduce el cierre. |
| F01-00A-R5-TM manual Text input | validated-pass | El mismo contrato Data/Input/Text creado manualmente en Studio es instance-safe. |
| F01-00A-R5-TS Studio serialization | pending-user-capture | Comparar el bloque que Studio genera para AppTitle contra R5-TD. |
| F01-00B cmp_FL_PageHeaderPro | blocked-by-FL-SC-001 | No se prepara. |
| F01-01 Premium App Shell Foundation | blocked-by-components | No se prepara. |

## 2. Incidente actual — FL-SC-001

```text
R1 root-only: PASS
R2 identity/text: PASS
R3 static containers: PASS
R4 static navigation: PASS
R5 Text+Boolean+Color via Source Code: FAIL
R5-T Text declared+consumed via Source Code: FAIL
R5-TD Text declaration only via Source Code: FAIL
R5-TM Text property created manually in Studio: PASS
```

Interpretación vigente:

- `Input/Text` no es intrínsecamente inseguro en esta app;
- el consumo/binding no es necesario para reproducir el cierre;
- la diferencia observada está asociada al camino de autoría/serialización/hidratación de la CustomProperty desde Source Code;
- todavía falta identificar qué diferencia concreta existe entre nuestro bloque R5-TD y la representación creada por Studio.

## 3. Estrategia de corrección

No se genera R6 ni otro YAML de CustomProperties hasta capturar la representación real producida por Studio.

Prueba actual:

```text
R5-TS — abrir Source Code del componente que contiene AppTitle creado manualmente
         y capturar exactamente el bloque serializado por Studio.
```

Después:

```text
Studio-generated AppTitle
          ↓ compare
R5-TD AppTitle escrito manualmente
          ↓
identificar delta
          ↓
reproducer mínimo Source Code basado en esquema real
```

## 4. Regla de autoría temporal

Hasta cerrar FL-SC-001:

> Las CustomProperties del Functional Lab se crean primero en Studio. No se generarán contratos públicos nuevos directamente en YAML hasta demostrar que la representación usada es la misma que Studio serializa y que alcanza `INSTANCE_SAFE`.

## 5. Componentes premium fundacionales

```text
F01-00A  cmp_FL_SidebarPro        ← FL-SC-001 / serialization diagnosis
F01-00B  cmp_FL_PageHeaderPro     ← BLOCKED
F01-01   Premium App Shell        ← BLOCKED
```

## 6. Regla de continuidad

> No se prepara F01-00B ni ningún bloque dependiente hasta disponer de una estrategia de CustomProperties reproduciblemente instance-safe.
