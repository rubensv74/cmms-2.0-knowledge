# cmp_FL_PageHeaderPro — Component Specification

**Status:** PENDING_STUDIO_VALIDATION  
**Increment:** F01-00B  
**Purpose:** cabecera premium común para contextualizar cada workspace del CMMS 2.0 Functional Lab.

## 1. Responsibility

El PageHeader debe comunicar de un vistazo:

- workspace actual;
- arquetipo/posición funcional;
- caso activo;
- posición dentro del journey;
- estado de revisión;
- progreso relativo.

No debe ejecutar lógica de negocio, cargar datos, decidir gates ni navegar por sí mismo.

## 2. Foundation visual inicial

La primera versión es body-only y está hardcodeada con el caso P-101 para validar la composición premium antes de introducir contrato público.

```text
Workspace        Case & Context
Archetype        Object 360
Case             P-101 · Centrifugal pump
Journey          01 / 28
Review state     Ready for review
```

## 3. Authoring strategy

```text
PUBLIC CONTRACT
→ Studio, cuando el App Shell lo necesite

VISUAL BODY
→ Source Code YAML

CustomProperties:
→ no se inyecta en esta superficie
```

## 4. Compatibility

- `GroupContainer@1.5.0` para superficies y radios.
- `ModernText@1.0.0` con `AutoHeight=true`.
- `Rectangle@2.3.0` para progreso.
- sin Label Radius*.
- sin Classic/Button AccessibleLabel.
- sin SVG, globals, assets externos, Event ni Output.

## 5. Validation gate

```text
[ ] DEFINITION_ACCEPTED
[ ] INSTANCE_SAFE
[ ] Save estable
[ ] Reopen estable
[ ] sin clipping ni mini-scrollbars
[ ] jerarquía título/subtítulo/contextos clara
[ ] context cards legibles
[ ] estado de revisión semántico
[ ] App Checker sin errores nuevos atribuibles
[ ] VISUAL_QA_VALIDATED
```

Si pasa este gate se avanza directamente a F01-01 Premium App Shell Foundation.
