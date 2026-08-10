# Functional Lab — Implementation Status

**Fecha:** 2026-08-10  
**Estado general:** F01 — Power Apps Premium Foundation  
**Gate actual:** `F01-00A-RC2 HeatMap-style custom property contract` — PENDING STUDIO VALIDATION

## 1. Estado de incrementos

| Incremento | Estado | Resultado |
|---|---|---|
| F00-01..F00-09 | completed | Base funcional, journey, fixture, arquitectura y handoff definidos. |
| F01-00 Auditoría Power Apps Foundation | active | Compatibilidad real en revisión con referencias PULSE. |
| F01-00A cmp_FL_SidebarPro | review-required | FL-SC-001 reabierto tras aparecer un contraejemplo funcional con CustomProperties. |
| F01-00A-R1..R4 | validated-pass | Baselines y controles estáticos validados. |
| F01-00A-R5 | failed-instance | La declaración concreta de CustomProperties usada en el Sidebar reprodujo cierre. |
| F01-00A-R5-TM / TB | validated-pass | Input/Text creado en Studio y binding desde YAML funcionaron. |
| F01-00A-RC2 | pending-user-validation | Sidebar completo con contrato CustomProperties corregido siguiendo `cmp_HeatMapPro`. |
| F01-00B cmp_FL_PageHeaderPro | blocked-by-sidebar | No avanzar hasta resultado RC2. |
| F01-01 Premium App Shell Foundation | blocked-by-components | Espera Sidebar + PageHeader. |

## 2. Corrección de diagnóstico

La afirmación anterior `CustomProperties en YAML = inseguro` queda retirada.

`cmp_HeatMapPro` de PULSE demuestra que un CanvasComponent puede usar extensamente CustomProperties de múltiples tipos, Outputs y Events y funcionar correctamente.

El primer diferencial objetivo encontrado es:

```text
HEATMAP FUNCIONAL
Input → PropertyKind + DisplayName + Description + DataType + Default

SIDEBAR FALLIDO
Input → PropertyKind + DataType + Default
```

El Sidebar original omitía `DisplayName` y `Description` en sus Inputs.

## 3. Próximo incremento

RC2 recupera el Sidebar completo y conserva su contrato público. Solo normaliza la definición de Inputs al patrón observado en HeatMap.

No habrá más micro-pruebas por Text/Boolean/Color/Table salvo que RC2 vuelva a fallar.

## 4. Continuidad

> Un único smoke test de RC2 decidirá el siguiente paso. Si pasa, se continúa directamente con `cmp_FL_PageHeaderPro`. Si falla, se compara el siguiente delta estructural contra `cmp_HeatMapPro`.
