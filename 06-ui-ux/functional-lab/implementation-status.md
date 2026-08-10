# Functional Lab — Implementation Status

**Fecha:** 2026-08-10  
**Estado general:** F01 — Power Apps Premium Foundation  
**Último gate superado:** `F01-00A-RC2 HeatMap-style custom property contract` — INSTANCE_SAFE PASS  
**Gate actual:** `F01-00B cmp_FL_PageHeaderPro` — READY TO CONTINUE

## 1. Estado de incrementos

| Incremento | Estado | Resultado |
|---|---|---|
| F00-01..F00-09 | completed | Base funcional, journey, fixture, arquitectura y handoff definidos. |
| F01-00 Auditoría Power Apps Foundation | active | Compatibilidad contrastada con referencias reales PULSE. |
| F01-00A cmp_FL_SidebarPro | validated-pass | RC2 completo con CustomProperties y contrato HeatMap-style es instance-safe. |
| F01-00A-R1..R4 | validated-pass | Baselines y controles estáticos validados. |
| F01-00A-R5 | failed-instance | La forma reducida de contrato usada inicialmente reprodujo el cierre. |
| F01-00A-R5-TM / TB | validated-pass | Propiedad Studio + binding YAML demostraron que el tipo Text no era la causa. |
| F01-00A-RC2 | validated-pass | Sidebar completo: Inputs, Table, Output, Event y bindings; instancia estable. |
| F01-00B cmp_FL_PageHeaderPro | current | Debe construirse usando como referencia contractual un componente PULSE instance-safe. |
| F01-01 Premium App Shell Foundation | blocked-by-pageheader | Se prepara tras validar PageHeader. |
| F01-02 Runtime state mínimo | planned | Estado local del laboratorio. |
| F01-03 Adaptador P-101 | planned | JSON → colecciones Power Fx. |
| F01-04 Navegación base | planned | Navegación real entre workspaces. |
| F01-05 WS-01 Contexto visual premium | planned | Object 360 para caso/contexto. |

## 2. Hallazgo RC2

`cmp_HeatMapPro` de PULSE demostró que `CustomProperties` es compatible con Source Code en componentes complejos.

El Sidebar original utilizaba una declaración reducida de Inputs, mientras la referencia estable utiliza:

```text
PropertyKind
DisplayName
Description
DataType
Default
```

RC2 restauró el contrato público completo del Sidebar y normalizó sus Inputs según ese patrón.

Resultado real:

```text
DEFINITION_ACCEPTED PASS
INSTANCE_SAFE       PASS
```

## 3. Regla de diseño/autoría vigente

```text
CustomProperties       → PERMITIDO
Contrato nuevo         → copiar referencia instance-safe equivalente
Inputs                 → preservar patrón completo de metadatos de la referencia
Outputs / Events       → copiar patrón por PropertyKind, no por intuición
Instance smoke test    → obligatorio
```

No se elimina el contrato público como workaround por defecto.

## 4. FL-SC-001

**Estado:** `RESOLVED — CORRECTIVE PATTERN VALIDATED`.

La causa interna exacta no se persigue más porque RC2 aporta un patrón correctivo suficiente para continuar el producto sin riesgo conocido.

## 5. Continuidad

El siguiente incremento vuelve al objetivo funcional:

```text
F01-00B cmp_FL_PageHeaderPro
        ↓
INSTANCE_SAFE
        ↓
F01-01 Premium App Shell Foundation
```

Antes del YAML de PageHeader se debe seleccionar y comparar una referencia PULSE estable con contrato público similar.
