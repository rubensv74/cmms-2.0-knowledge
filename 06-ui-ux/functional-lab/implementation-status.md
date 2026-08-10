# Functional Lab — Implementation Status

**Fecha:** 2026-08-10  
**Estado general:** F01 — Power Apps Premium Foundation  
**Último gate superado:** `F01-00A-R5-TB hybrid Text binding` — INSTANCE_SAFE PASS  
**Gate actual:** `F01-00A-R5-BM Boolean contract` — BLOCKED BY PROPERTY RESOLUTION

## 1. Estado de incrementos

| Incremento | Estado | Resultado |
|---|---|---|
| F00-01..F00-09 | completed | Base funcional, journey, fixture, arquitectura y handoff definidos. |
| F01-00 Auditoría Power Apps Foundation | partial | Diagnóstico real de compatibilidad y reconstrucción en curso. |
| F01-00A cmp_FL_SidebarPro | review-required | Reconstrucción incremental tras FL-SC-001. |
| F01-00A-R1 root-only | validated-pass | Baseline mínimo instance-safe. |
| F01-00A-R2 identity/text | validated-pass | ModernText estático instance-safe. |
| F01-00A-R3 static-containers | validated-pass | AutoLayout + contenedores anidados instance-safe. |
| F01-00A-R4 static-navigation | validated-pass | Rectangle + Icon + Label + Button sin eventos instance-safe. |
| F01-00A-R5 primitive inputs via `CustomProperties:` | failed-instance | El camino de autoría por YAML reproduce el cierre. |
| F01-00A-R5-T | failed-instance | Input/Text declarado+consumido por YAML falla. |
| F01-00A-R5-TD | failed-instance | Input/Text solo declarado por YAML falla. |
| F01-00A-R5-TM | validated-pass | Input/Text creado manualmente en Studio es instance-safe. |
| F01-00A-R5-TS | completed | Studio Source Code visible omite la propiedad pública manual. |
| F01-00A-R5-TB | validated-pass | YAML puede consumir `AppTitle` creado en Studio; estrategia híbrida demostrada. |
| F01-00A-R5-BM | blocked-contract-resolution | Studio no se cierra, pero `cmp_FL_SidebarPro.ShowEnvironment` devuelve `Name isn't valid`; verificar contrato/nombre exacto en Studio antes de continuar. |
| F01-00B cmp_FL_PageHeaderPro | blocked-by-FL-SC-001 | No se prepara todavía. |
| F01-01 Premium App Shell Foundation | blocked-by-components | No se prepara todavía. |

## 2. Conclusión operativa vigente

```text
PUBLIC CONTRACT     → Studio
VISUAL COMPONENT    → Source Code incremental
BINDING TO CONTRACT → Source Code, tras smoke test
```

Para `Input/Text` este patrón ha alcanzado `INSTANCE_SAFE = PASS`.

No volver a inyectar `CustomProperties:` dentro del YAML pegable de esta superficie.

## 3. R5-BM — estado real

El cuerpo R5-BM está cargado y Studio permanece abierto, pero el binding Boolean no es válido:

```text
Visible = cmp_FL_SidebarPro.ShowEnvironment
          ↓
Name isn't valid. 'ShowEnvironment' isn't recognized.
```

Por tanto:

```text
Boolean manual creation  NO CONFIRMADA
Boolean binding          FAIL FORMULA RESOLUTION
Instance crash           NO
```

La prueba queda detenida. Antes de corregir código debe verificarse el contrato real en Studio: componente propietario, nombre interno exacto y persistencia de la propiedad después de guardar.

## 4. Incidente FL-SC-001

El incidente sigue abierto porque el Sidebar completo aún no ha sido recuperado, pero la superficie problemática y el workaround para Text están suficientemente delimitados.

## 5. Regla de continuidad

> No se genera otro YAML ni se avanza a Color mientras `ShowEnvironment` no exista y sea reconocida como propiedad pública de `cmp_FL_SidebarPro`.
