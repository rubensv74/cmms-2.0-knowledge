# Functional Lab — Implementation Status

**Fecha:** 2026-08-10  
**Estado general:** F01 — Power Apps Premium Foundation  
**Último gate superado:** `F01-00A-RC2 HeatMap-style custom property contract` — INSTANCE_SAFE PASS  
**Gate actual:** `F01-00B cmp_FL_PageHeaderPro` — PENDING SINGLE STUDIO SMOKE TEST

## 1. Estado de incrementos

| Incremento | Estado | Resultado |
|---|---|---|
| F00-01..F00-09 | completed | Base funcional, journey, fixture, arquitectura y handoff definidos. |
| F01-00 Auditoría Power Apps Foundation | active | Compatibilidad contrastada con referencias reales PULSE. |
| F01-00A cmp_FL_SidebarPro | validated-pass | RC2 completo con CustomProperties y contrato HeatMap-style es instance-safe. |
| F01-00A-RC2 | validated-pass | Sidebar completo: Inputs, Table, Output, Event y bindings; instancia estable. |
| F01-00B cmp_FL_PageHeaderPro | pending-user-validation | Candidate completo con public contract RC2-style y cuerpo premium P-101. |
| F01-01 Premium App Shell Foundation | blocked-by-pageheader | Se prepara inmediatamente si PageHeader pasa el smoke test. |
| F01-02 Runtime state mínimo | planned | Estado local del laboratorio. |
| F01-03 Adaptador P-101 | planned | JSON → colecciones Power Fx. |
| F01-04 Navegación base | planned | Navegación real entre workspaces. |
| F01-05 WS-01 Contexto visual premium | planned | Object 360 para caso/contexto. |

## 2. Estrategia F01-00B

La auditoría de PULSE confirma que su `cmp_PageHeaderPro` conserva un incidente histórico de instancia, por lo que no se usa como referencia contractual instance-safe.

Se separan dos referencias:

```text
VISUAL / BODY REFERENCE
PULSE cmp_PageHeaderPro

PUBLIC CONTRACT REFERENCE
PULSE cmp_HeatMapPro
+
cmp_FL_SidebarPro RC2
```

El nuevo Header conserva el diseño Functional Lab existente y añade Inputs completos con:

```text
PropertyKind
DisplayName
Description
DataType
Default
```

No se hacen micropruebas por tipo.

## 3. Gate único

```text
pegar componente completo
→ guardar
→ insertar una instancia aislada
→ guardar/reabrir
→ App Checker
```

PASS → avanzar directamente a `F01-01 Premium App Shell Foundation`.

FAIL → comparar el delta concreto contra las referencias positivas; no iniciar una batería R1/R2/R3 por defecto.

## 4. Regla vigente

```text
CustomProperties       → PERMITIDO
Contrato nuevo         → copiar referencia instance-safe equivalente
Inputs                 → preservar patrón completo de metadatos
Outputs / Events       → patrón por PropertyKind
Instance smoke test    → obligatorio
```
