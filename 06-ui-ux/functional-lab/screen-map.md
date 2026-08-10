# CMMS 2.0 Functional Lab — Mapa real de pantallas

**Estado:** aprobado para implementación  
**Fecha:** 2026-08-10

## 1. Regla

Las pantallas representan objetos o trabajos reconocibles. No se fusionan únicamente para reducir su número.

## 2. Mapa

| Orden | Pantalla | Módulo | Trabajo principal | Estado objetivo |
|---:|---|---|---|---|
| 01 | `scr_FL_Home` | Inicio | Ver trabajo, casos activos, alertas y accesos recientes | Foundation |
| 02 | `scr_FL_FLH` | Activos | Navegar la jerarquía FLH y situar P-101 | Foundation |
| 03 | `scr_FL_Taxonomy` | Activos | Navegar clasificación/taxonomía del activo | Foundation |
| 04 | `scr_FL_ADR` | Activos | Navegar relaciones/dependencias ADR | Foundation |
| 05 | `scr_FL_Asset360` | Activos | Ver ficha 360 de P-101 y enlaces a análisis/planes | Foundation |
| 06 | `scr_FL_AnalysisRegister` | Estrategia | Buscar, filtrar y abrir AnalysisCase | Foundation |
| 07 | `scr_FL_CaseOverview` | Estrategia | Ver estado integral del caso y journey 28 etapas | Foundation |
| 08 | `scr_FL_Context` | Estrategia | FL-01..03: alcance, contexto y preparación | Rebuild de WS-01 |
| 09 | `scr_FL_Functions` | Estrategia | FL-04..05: funciones y fallos funcionales | Rebuild de WS-02 |
| 10 | `scr_FL_FailureModes` | Estrategia | FL-06: modos relevantes, recomendación y decisión | Rebuild de WS-02 |
| 11 | `scr_FL_AMEF` | Estrategia | FL-07..11: efectos, consecuencias, S/O/D, controles y gate | Journey |
| 12 | `scr_FL_RCM` | Estrategia | FL-12..16: lógica RCM y estrategia explicable | Journey |
| 13 | `scr_FL_Economics` | Estrategia | FL-17: comparación económica de alternativas | Journey |
| 14 | `scr_FL_Task` | Estrategia | FL-18..19: tarea ejecutable e intervalo | Journey |
| 15 | `scr_FL_PlanPackage` | Estrategia | FL-20..22: recursos, alcance y gate del plan | Journey |
| 16 | `scr_FL_Traceability` | Estrategia | FL-23..24: trazabilidad y calidad | Journey |
| 17 | `scr_FL_ReviewApproval` | Estrategia | FL-25..26: revisión multidisciplinar, aprobación, snapshot | Journey |
| 18 | `scr_FL_Effectiveness` | Estrategia | FL-27..28: datos reales y mejora/cambio | Journey |
| 19 | `scr_FL_MaintenancePlans` | Planes | Ver planes derivados y estado de publicación | Preview inicial |
| 20 | `scr_FL_Governance` | Gobernanza | Versiones, aprobaciones, findings y cambios | Preview inicial |
| 21 | `scr_FL_Settings` | Configuración | Preferencias y catálogos conceptuales | Preview inicial |

## 3. Navegación principal

Sidebar:

```text
Inicio
Activos
Estrategia
Planes
Gobernanza
Configuración
```

Cada módulo puede abrir un landing o recordar la última pantalla visitada. En Foundation se utilizará navegación explícita y comprensible.

## 4. Navegación dentro de Activos

Subnavegación visible en cabecera/toolbar:

```text
FLH | Taxonomía | ADR | Ficha 360
```

Las tres primeras son pantallas separadas y usan `cmp_FL_TreePro` con datasets distintos.

## 5. Navegación dentro de AnalysisCase

Toda pantalla de las posiciones 07–18 debe incluir:

- identificación de caso;
- estado Draft/Confirmed/Approved cuando aplique;
- `cmp_FL_ProcessRailPro`;
- acceso a Overview del caso;
- responsabilidad actual;
- gate/estado de etapa;
- navegación hacia etapas accesibles.

## 6. Mapeo de etapas a pantallas

```text
FL-01 ─┐
FL-02  ├─ scr_FL_Context
FL-03 ─┘

FL-04 ─┐
FL-05 ─┴─ scr_FL_Functions

FL-06 ─── scr_FL_FailureModes

FL-07 ─┐
FL-08  │
FL-09  ├─ scr_FL_AMEF
FL-10  │
FL-11 ─┘

FL-12 ─┐
FL-13  │
FL-14  ├─ scr_FL_RCM
FL-15  │
FL-16 ─┘

FL-17 ─── scr_FL_Economics
FL-18 ─┐
FL-19 ─┴─ scr_FL_Task
FL-20 ─┐
FL-21  ├─ scr_FL_PlanPackage
FL-22 ─┘
FL-23 ─┐
FL-24 ─┴─ scr_FL_Traceability
FL-25 ─┐
FL-26 ─┴─ scr_FL_ReviewApproval
FL-27 ─┐
FL-28 ─┴─ scr_FL_Effectiveness
```

## 7. Estados visuales de pantalla

Toda pantalla productiva soportará conceptualmente:

```text
loading
ready
empty
error
draft
blocked
warning
confirmed
approved
read-only
```

No todos requieren una implementación visual completa en el primer bloque, pero el layout no debe impedirlos.

## 8. Criterios de autenticidad

Una pantalla no se acepta si:

- su contenido principal explica el prototipo en lugar de permitir trabajo;
- usa `WS-xx` como concepto dominante visible;
- oculta la procedencia de una recomendación;
- no distingue input, cálculo, recomendación y decisión;
- usa el botón Siguiente como única representación de un gate;
- no deja claro qué objeto quedará persistido.
