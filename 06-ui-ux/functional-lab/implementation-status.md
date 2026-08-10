# Functional Lab — Implementation Status

**Fecha:** 2026-08-10  
**Estado general:** F01 — Power Apps Premium Foundation  
**Último gate superado:** `F01-00A-R4 navegación visual sin eventos` — INSTANCE_SAFE PASS  
**Gate actual:** `F01-00A-R5-TM manual Text input` — PENDING STUDIO VALIDATION

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
| F01-00A-R5 primitive inputs | failed-instance | Text + Boolean + Color reproducen el cierre. |
| F01-00A-R5-T Text input | failed-instance | Un único Input/Text declarado+consumido reproduce el cierre. |
| F01-00A-R5-TD Text declaration only | failed-instance | Un único Input/Text declarado por Source Code y no consumido reproduce el cierre en baseline mínimo. |
| F01-00A-R5-TM manual Text input | pending-user-validation | Crear manualmente Data/Input/Text en Studio sobre componente mínimo, sin consumo. |
| F01-00B cmp_FL_PageHeaderPro | blocked-by-FL-SC-001 | No se prepara. |
| F01-01 Premium App Shell Foundation | blocked-by-components | No se prepara. |

## 2. Incidente actual — FL-SC-001

```text
R1 root-only: PASS
R2 identity/text: PASS
R3 static containers: PASS
R4 static navigation: PASS
R5 Text+Boolean+Color: FAIL
R5-T Text declared+consumed: FAIL
R5-TD Text declaration only via Source Code: FAIL
R5-TM manual Text declaration in Studio: PENDING
```

Interpretación vigente:

- Boolean y Color ya no son necesarios para reproducir el incidente;
- el consumo del input tampoco es necesario;
- una declaración Source Code mínima `Input/Text` basta para reproducir el cierre;
- todavía falta determinar si el fallo pertenece al **camino Source Code** o al **motor de CustomProperties/Enhanced component properties** de la app activa.

## 3. Estrategia de corrección

No se genera R6 ni otro YAML hasta cerrar esta bifurcación.

Prueba actual:

```text
R5-TM — crear manualmente en Studio una propiedad Data / Input / Text
         sobre un componente mínimo instance-safe y no consumirla.
```

Interpretación:

- **PASS** → Input/Text funciona al crearse correctamente en Studio; investigar Source Code/serialización/hidratación y adaptar el protocolo de autoría.
- **FAIL** → investigar Enhanced component properties, app baseline y Power Apps Studio antes de continuar.

## 4. Componentes premium fundacionales

```text
F01-00A  cmp_FL_SidebarPro        ← FL-SC-001 / diagnostic reconstruction
F01-00B  cmp_FL_PageHeaderPro     ← BLOCKED
F01-01   Premium App Shell        ← BLOCKED
```

## 5. Regla de continuidad

> No se prepara F01-00B ni ningún bloque dependiente hasta disponer de una estrategia de CustomProperties que alcance `INSTANCE_SAFE` de forma reproducible.
