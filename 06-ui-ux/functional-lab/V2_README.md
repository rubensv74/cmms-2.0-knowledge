# CMMS 2.0 Functional Lab — Architecture v2

Este documento es el punto de entrada canónico para la reconstrucción v2.

## Propósito

El Functional Lab sigue siendo un laboratorio conceptual, pero desde v2 se experimenta como una **aplicación CMMS real**:

- navegación por módulos de producto;
- objetos técnicos;
- registro de casos;
- AnalysisCase como objeto raíz;
- pantallas de trabajo especializadas;
- 28 etapas visibles mediante Process Rail;
- cálculo, recomendación y decisión humana diferenciados;
- gates explicables;
- borrador + confirmaciones explícitas;
- contratos preparados para persistencia futura.

## Leer primero

1. [Arquitectura](architecture.md)
2. [Estado v2](V2_STATUS.md)
3. [ADRs](adr/README.md)
4. [Mapa de pantallas](screen-map.md)
5. [Contratos de dominio](domain-contracts.md)
6. [Design System v2](design-system-v2.md)
7. [Catálogo de componentes](component-catalog.md)
8. [Instalación Power Apps v2](power-apps/V2_INSTALLATION.md)
9. [Validación estática](development/V2_STATIC_VALIDATION_2026-08-10.md)

## Power Apps

### Componentes

`power-apps/components/`

Foundation v2:

```text
cmp_FL_SidebarPro
cmp_FL_PageHeaderPro
cmp_FL_TreePro
cmp_FL_ProcessRailPro
cmp_FL_DecisionPanelPro
cmp_FL_GatePanelPro
```

### Pantallas

`power-apps/screens/`

La lista canónica y el significado de cada pantalla están en:

`power-apps/screens/README.md`

### Runtime

`power-apps/runtime/functional-lab-v2-bootstrap.powerfx`

P-101 sigue siendo el fixture funcional inicial, pero la UI consume conceptos de dominio preparados para sustituir el adapter por persistencia real.

## Journey

El proceso canónico sigue siendo FL-01…FL-28.

No se ha reducido ni fusionado metodológicamente para ahorrar pantallas.

La relación es:

```text
Product Navigation
      ↓
AnalysisCase Object Page
      ↓
Process Rail FL-01…FL-28
      ↓
Business Work Screen
      ↓
Draft / calculation / recommendation / human decision / gate
```

## Activos antes del journey

FLH, Taxonomía y ADR no forman parte de las 28 etapas.

Son tres vistas maestras de Activos que aportan contexto estructural al mismo objeto P-101 antes y durante el AnalysisCase.

La Ficha 360 consolida el objeto sin duplicar la edición maestra dentro del análisis.

## Backend

La arquitectura favorece una futura implementación Azure SQL, pero el laboratorio no depende de SQL.

Frontera:

```text
Canvas UI
→ application contracts
→ repository/service adapter
→ backend
```

## Estado de validación

```text
Architecture / ADRs      COMPLETE
Screen map               COMPLETE
Domain contracts         COMPLETE
Components generated     COMPLETE
21 screens generated     COMPLETE
Runtime v2 generated     COMPLETE
Static validation        PASS_STATIC
Studio integrated QA     PENDING
```

El siguiente paso no es diseñar más arquitectura.

Es instalar la v2 siguiendo `power-apps/V2_INSTALLATION.md` y ejecutar los seis smoke tests integrados.
