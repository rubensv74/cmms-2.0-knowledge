# Functional Lab — Power Apps Block Registry

**Autoridad:** `functional-engineering-knowledge-base/30-playbooks/power-platform/modular-power-apps-screen-construction.md`

Este registro evita reutilizar por error bloques históricos como instrucciones vigentes.

## Convención vigente

```text
S — Structural
C — Component
I — Integration
FIX — repair of the failed increment
```

Una pantalla nueva o abierta a reconstrucción sigue:

```text
S skeleton
→ validate / geometry freeze
→ C placeholders
→ validate / freeze
→ I integrations
→ validate / freeze
→ Theme pass
```

## Bloques activos

### `S-AMEF-01`

**Estado:** `PLANNED`.

Contiene el contrato estructural de la próxima reconstrucción AMEF.

No existe YAML ejecutable todavía porque el playbook prohíbe generar el siguiente incremento antes de completar los gates previos de Studio.

Referencia:

`S-AMEF-01/CONTRACT.md`

## Bloques / evidencias históricas

### `F03-AMEF-READABILITY-REFERENCE`

**Estado:** `REFERENCE_ONLY`.

Conserva aprendizaje sobre legibilidad, densidad y semántica AMEF. Sus instrucciones de actualización masiva y propagación están retiradas.

### `F04-AMEF-FINAL-INTEGRATION`

**Estado:** `SUPERSEDED`.

No ejecutar. El enfoque monolítico de AMEF ha sido sustituido por S/C/I.

### `F01-06_WS02`, `F01-TREE-01`, `F01-TREE-02`, `F02-RISK-MATRIX`

**Estado:** evidencia histórica de iteraciones anteriores.

Pueden utilizarse para análisis forense o aprendizaje específico, pero no sustituyen:

```text
componentes actuales
Freeze Register
compatibility.md
runbook vigente
```

## Antes de usar cualquier bloque

Comprobar:

```text
1. estado en este registry
2. FREEZE_REGISTER_2026-08-11.md
3. compatibility.md
4. playbook modular vigente
```

No reutilizar un bloque histórico completo para reparar una pieza actual sin declarar explícitamente el delta y convertirlo en un nuevo `FIX` acotado.
