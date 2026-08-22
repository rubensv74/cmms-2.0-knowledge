# Estado del proyecto

**Última actualización:** 2026-08-22  
**Rama activa:** `baseline/premium-powerapps-v1`

## Estado general

CMMS 2.0 se construirá como la **interfaz funcional futura del producto**, usando datos sintéticos únicamente como provider temporal.

El alcance activo v1 termina en:

```text
Published Maintenance Plan
```

Las reuniones continuarán ampliando la cobertura conceptual de Work Management, ejecución, materiales, costes y capacidades EAM posteriores, pero esas áreas no bloquean el desarrollo de lo ya maduro.

## Fuentes rectoras

- `01-vision/cmms-2.0-product-map-v1.md`
- `01-vision/cmms-2.0-capability-coverage-v1.md`
- `06-ui-ux/product-screen-catalog-v1.md`
- `02-functional/master-data/equipment-taxonomy-library-foundation-v1.md`
- `ROADMAP.md`

El antiguo Functional Lab es conocimiento histórico reutilizable, no el mapa de navegación de la app.

## Cobertura conceptual

### Fuerte / desarrollable ahora

- Project Setup;
- Corporate/Project governance;
- FLH;
- Equipment Taxonomy;
- Technical Fields;
- ADR;
- Asset Register / Asset 360;
- Risk Profile / Matrix;
- Criticality;
- AMEF / FMEA;
- RCM;
- Maintenance Tasks;
- Job Plans;
- Maintenance Strategies;
- Applicability / Asset Overrides;
- Maintenance Plan;
- Review / Approval / Versioning / Publication;
- Audit & Traceability;
- Corporate promotion workflow.

### Discovery / futuro

- Work Candidates / backlog;
- Work Orders;
- planning/scheduling;
- execution/check sheets/mobile;
- actual cost;
- inventory/storerooms;
- contracts/billing;
- advanced condition/predictive;
- reliability performance analytics.

Detalle:

- `01-vision/cmms-2.0-capability-coverage-v1.md`.

## Decisiones congeladas

1. La app no se construye alrededor de un caso de demo.
2. Los datos sintéticos implementan contratos de producto.
3. `ADR` es el registro físico maestro.
4. `FLH`, `Taxonomy` y `ADR` son estructuras distintas y relacionadas.
5. Corporate Libraries y Project Configuration están separados.
6. Project-specific definitions pueden promoverse mediante governance.
7. Risk Profile es configurable/versionable y no existe una 5×5 fija.
8. Equipment Visual Library 3D forma parte del modelo corporativo.
9. AMEF/RCM separan recomendación del sistema y autoridad humana.
10. Plan base y asset overrides permanecen separados.
11. Published versions son inmutables.
12. UI → contract → provider; SQL/Flow/API no se incrustan en la presentación.

## Incremento activo — P01 Foundation + Project Setup

**Estado:** contracts ready; Power Apps runtime gate next.

### Documentos creados

- `06-ui-ux/product-development/p01-foundation-project-setup-plan-v1.md`;
- `06-ui-ux/product-development/p01-synthetic-provider-contract-v1.md`;
- `06-ui-ux/screen-contracts/p01-shell-project-setup-screen-contracts-v1.md`.

### Alcance P01

```text
Premium Shell
├── grouped sidebar
├── Corporate / Project context
├── global search shell
├── Needs Attention entry
├── page/command/content hosts
├── inspector/drawer host
├── overlay/modal host
├── dirty guard
└── loading/empty/error/focus states

Project Setup
├── SCR-010 Project Profile
├── SCR-011 Maintenance Configuration
├── SCR-012 Risk Profile / Matrix Configuration
└── SCR-013 Project Teams & Roles

Entry
├── SCR-001 Portfolio minimum
└── SCR-002 Project Home minimum
```

## Synthetic Provider P01

Se utilizarán al menos dos proyectos para demostrar aislamiento y variabilidad real.

### Project A

- setup completo;
- Risk Profile 5×5 activo;
- roles requeridos cubiertos.

### Project B

- configuración parcialmente heredada;
- Risk Profile alternativo estructuralmente distinto;
- rol requerido pendiente;
- Needs Attention visible.

Acceptance principal:

> cambiar entre ambos proyectos debe reconstruir Project Setup y Risk Matrix desde contratos/provider sin cambiar las fórmulas base de la pantalla.

## Siguiente gate real — Power Apps Studio

Crear o identificar la Canvas App:

```text
CMMS 2.0
```

Registrar antes de construir superficies densas:

- Source Code dialect;
- layout/resolution;
- responsive behavior;
- Modern/Classic controls disponibles;
- componentes premium instalados;
- theme/tokens;
- App Checker baseline;
- visual baseline.

Después:

```text
Canvas baseline
→ Premium Shell
→ Navigation
→ Synthetic Provider
→ Project Profile
→ Maintenance Configuration
→ Risk Profile
→ Teams & Roles
→ P01 hardening
```

## Trabajo paralelo

### Equipment Taxonomy

Continuar estudios por familia empezando por `Rotating Equipment`.

Cada familia:

```text
sources
→ class tree
→ technical fields
→ failure knowledge
→ maintenance knowledge
→ external mappings
→ 3D visual requirements
```

### EAM discovery

Las reuniones seguirán moviendo capacidades desde `DISCOVERY` hacia `CONCEPTUAL_COVERED` sin interrumpir el scope activo.

## Riesgos principales

- volver a diseñar una demo en vez del producto;
- hardcodear datos sintéticos en controles;
- convertir Risk Matrix en un componente 5×5 fijo;
- mezclar FLH, Taxonomy y ADR;
- copiar una norma como taxonomía completa;
- permitir que Project modifique Corporate silenciosamente;
- diseñar Work Management antes de entenderlo;
- cerrar SQL antes de estabilizar contratos;
- esconder reglas funcionales en Power Fx.

## Próximo resultado visible esperado

Una Canvas App `CMMS 2.0` con shell premium definitivo y Project Setup funcional sobre provider sintético, preparada para incorporar Corporate Libraries y Asset Foundation sin rehacer navegación ni arquitectura de datos.
