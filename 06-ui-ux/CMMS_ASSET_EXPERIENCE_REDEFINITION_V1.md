# CMMS 2.0 — Asset Experience Redefinition V1

**Fecha:** 2026-08-24  
**Estado:** `ACCEPTED / PLANNED / PRE-IMPLEMENTATION`  
**Ámbito:** Assets, Asset Master, sistema visual y superficies relacionadas de CMMS 2.0.

## 1. Propósito

Formalizar la evolución de la experiencia de activos de CMMS 2.0 a partir de tres decisiones aceptadas:

1. revisar la pantalla `Assets` y su arquitectura de información;
2. revisar el sistema visual aplicable a activos —iconografía, jerarquía visual y componentes premium—;
3. rediseñar las pantallas afectadas sobre esa foundation, sin crear una biblioteca 3D específica de CMMS.

La finalidad no es decorar `Assets`. La finalidad es permitir que CMMS represente el activo como objeto técnico y de mantenimiento de forma coherente, reusable y visualmente reconocible.

---

# 2. Decisiones aceptadas

## DEC-AE-001 — Revisar Assets

`Assets` debe revisarse como superficie nuclear del producto.

La revisión debe separar explícitamente, cuando apliquen:

```text
Asset identity
→ Technical profile
→ Engineering context
→ Visual context
→ Maintenance context
```

La pantalla no debe convertirse en una acumulación de cards. La jerarquía y la densidad deben derivarse de la tarea principal del usuario y del arquetipo premium correspondiente.

### Capacidades a evaluar

- identidad: tag, descripción, tipo, fabricante, modelo, serie, estado, criticidad y localización;
- perfil técnico dinámico según tipo de equipo;
- contexto de ingeniería y procedencia de datos;
- documentos técnicos vinculados;
- contexto visual;
- jerarquía funcional / ubicación;
- resumen de mantenimiento e inspección;
- trazabilidad de datos heredados, sincronizados o introducidos manualmente.

No se aprueba todavía una composición final. Primero debe cerrarse el contrato funcional y visual.

---

## DEC-AE-002 — Revisar el sistema visual de activos

La evolución de `Assets` obliga a revisar de forma transversal:

### Iconografía

Distinguir al menos:

- iconos de navegación;
- iconos de entidades y tipos de equipo;
- iconos de atributos técnicos;
- iconos de contexto de ingeniería/documentos;
- iconos de mantenimiento/inspección;
- estados, badges y señales de procedencia.

La revisión no implica sustituir automáticamente toda la iconografía existente. Debe auditarse primero el catálogo actual y aplicar:

```text
REUSE_CMMS
→ ADAPT_VERIFIED_BASE
→ EXTEND_SHARED
→ CREATE_SHARED
→ LOCAL_ONLY
```

### Jerarquía visual

La jerarquía debe continuar gobernada por:

- `CMMS_PREMIUM_SCREEN_STANDARD_V1.md`;
- `CMMS_PAGE_HEADER_HIERARCHY_V1.md`;
- `functional-lab/design-system.md`;
- `functional-lab/architecture.md`.

La nueva experiencia no crea una jerarquía paralela para Assets.

### Componentes premium

Todo patrón reusable detectado en la revisión debe convertirse en componente compartido cuando proceda. Los primeros candidatos están registrados en `CMMS_COMPONENT_CATALOG_V1.md` como necesidades `TO_VALIDATE` y no como componentes ya validados.

---

## DEC-AE-003 — Reutilizar la biblioteca 3D de AssetPlan

CMMS 2.0 **no creará una segunda biblioteca de ilustraciones técnicas 3D**.

Fuente visual externa gobernada:

```text
Repository: rubensv74/app_preserv
Collection: AssetPlan Industrial Technical 3D
Canonical path in its governed gallery:
assets/equipment-illustrations/3d/runtime-hero-tight/r01/
```

La colección AssetPlan dispone de manifiesto, inventario y reglas runtime propias. CMMS debe reutilizar esos assets por referencia/copia de distribución controlada según la arquitectura de despliegue que se defina, conservando provenance.

### Regla

```text
ONE TECHNICAL 3D SOURCE
→ MANY PRODUCT CONSUMERS
```

No se permiten:

- una copia CMMS mantenida manualmente como segunda fuente de verdad;
- regenerar en CMMS una ilustración que ya existe en la colección gobernada de AssetPlan;
- modificar silenciosamente geometría/estilo de una ilustración común;
- asumir que una ilustración genérica representa un modelo de ingeniería real.

### Semántica visual

Los niveles permanecen separados:

```text
TYPE ILLUSTRATION
  ilustración reusable del tipo de equipo

MODEL IMAGE
  imagen/documentación representativa del fabricante/modelo

ASSET PHOTO
  evidencia visual del activo físico concreto
```

Una `Type Illustration` es identificación visual; no sustituye CAD, BIM, GA drawing, P&ID, datasheet ni fotografía del activo.

### Gate de integración

Antes de usar la colección en runtime CMMS debe verificarse:

- estabilidad de la fuente/versionado AssetPlan utilizada;
- mapping `EquipmentType → IllustrationKey`;
- formato y peso compatibles con Power Apps/runtime CMMS;
- fallback cuando no exista ilustración;
- provenance/version del asset consumido;
- comportamiento de caché/distribución si aplica.

---

# 3. Arquitectura conceptual objetivo

```text
                    ENGINEERING / SOURCES
                  ALEP + documents + catalogues
                             │
                             ▼
                    Asset Technical Profile
                    ├─ Identity
                    ├─ Technical fields
                    ├─ Model/manufacturer
                    ├─ Engineering context
                    └─ Provenance
                             │
            ┌────────────────┼────────────────┐
            ▼                ▼                ▼
        CMMS Assets      Maintenance      Visual context
                         / Inspection      ├─ Type illustration
                                           ├─ Model image
                                           └─ Asset photos
```

Principio: CMMS consume y contextualiza ingeniería; no debe crear un segundo maestro de ingeniería por conveniencia de la UI.

---

# 4. Plan detallado de implementación

## Fase AE-0 — Baseline y auditoría

**Objetivo:** conocer exactamente qué existe antes de rediseñar.

### Trabajo

1. auditar la pantalla `Assets` actual y sus variantes;
2. inventariar los componentes que utiliza;
3. inventariar iconos actuales y su procedencia;
4. identificar estilos locales/duplicados;
5. mapear datos visibles y sus fuentes reales;
6. revisar los prototipos históricos de modelo/registro de activos;
7. clasificar deuda: funcional, visual, componente, datos, integración.

### Entregables

- `Assets Current-State Audit`;
- mapa `screen → component → data source`;
- inventario de iconografía afectada;
- matriz `REUSE / ADAPT / EXTEND / CREATE / RETIRE`;
- lista de gaps que bloquean el rediseño.

### Gate AE-G0

No avanzar a composición final mientras no se sepa qué elementos existentes son reutilizables y cuáles son legacy.

---

## Fase AE-1 — Contrato de Asset Experience

**Objetivo:** cerrar qué debe representar Assets antes de decidir cómo se dibuja.

### Trabajo

Definir el contrato mínimo de:

```text
AssetIdentity
AssetTechnicalProfile
TechnicalFieldDefinition
TechnicalFieldValue
EngineeringContext
AssetVisualContext
AssetDocumentContext
MaintenanceSummary
DataProvenance
```

Resolver explícitamente:

- qué datos pertenecen a CMMS;
- qué datos proceden de ALEP u otras fuentes;
- qué puede heredarse por Equipment Type o Model;
- qué puede sobrescribirse por Asset;
- qué es solo lectura;
- cómo se muestra la procedencia y sincronización;
- tratamiento de datos no disponibles o no aplicables.

### Entregables

- contrato funcional de `Assets`;
- arquitectura de información;
- mapa de fuentes de verdad;
- estados `READY / LOADING / EMPTY / ERROR / UNAVAILABLE / STALE` cuando apliquen;
- requisitos para Technical Profile y Visual Context.

### Gate AE-G1

No diseñar Technical Specification Grid ni Engineering Context como componentes productivos hasta cerrar semántica y fuente de cada dato.

---

## Fase AE-2 — Sistema visual para Asset Experience

**Objetivo:** preparar el lenguaje visual común que necesitarán Assets y las pantallas posteriores.

### Workstream AE-2A — Iconografía

1. auditar `06-ui-ux/branding/icons/`;
2. clasificar iconos por rol semántico;
3. detectar gaps de dominio;
4. buscar primero reutilización/adaptación verificable;
5. extender o crear solo los iconos que falten;
6. definir tamaño, stroke, estados y uso permitido;
7. validar legibilidad en Power Apps.

Familias objetivo:

```text
Navigation
Entity / Equipment Type
Technical Attribute
Engineering / Document
Maintenance / Inspection
Status / Provenance
```

### Workstream AE-2B — Jerarquía visual

Validar que `Assets` utiliza la jerarquía CMMS vigente y definir cómo encajan:

```text
Page Identity
Context
Summary opcional
Primary Object / Asset Identity
Technical Workspace
Related Context
Actions / overlays
```

No crear un Page Header específico para Assets.

### Workstream AE-2C — Semántica visual

Definir:

- badges de estado;
- chips de fuente/provenance;
- diferencia visual entre valor heredado, sincronizado, manual y override;
- tratamiento de unavailable/not applicable/stale;
- prioridad de acciones;
- tratamiento de documentos e imágenes.

### Entregables

- actualización de branding/iconografía;
- especificación de semántica visual de Asset Experience;
- reglas de provenance/status;
- gaps confirmados de componentes.

### Gate AE-G2

La foundation visual debe demostrar que no crea un segundo lenguaje CMMS y que los nuevos elementos son reutilizables más allá de una única pantalla.

---

## Fase AE-3 — Componentes premium compartidos

**Objetivo:** convertir los patrones estables en piezas reutilizables antes de construir las pantallas finales.

### Candidatos iniciales

- `Asset Identity Hero`;
- `Technical Specification Grid`;
- `Engineering Context Panel`;
- `Asset Visual Gallery`;
- `Hierarchy Path`;
- `Maintenance Summary`;
- `Document Link / Document Set`;
- `Provenance Badge`;
- `Technical Value`;
- `Equipment Type Card`;
- `Model Template Summary`.

### Para cada componente

Documentar:

- propósito;
- inputs/outputs/events;
- estados;
- responsive behavior;
- accessibility;
- tokens;
- provenance si deriva de AssetPlan/PULSE;
- consumidores previstos;
- lifecycle: `TO_VALIDATE → CMMS_RC → VALIDATED_CMMS`.

### Gate AE-G3

Ningún componente pasa a `VALIDATED_CMMS` por existir en GitHub. Debe validarse dentro de la app real según los gates de CMMS.

---

## Fase AE-4 — Rediseño de pantallas

**Objetivo:** rediseñar las superficies sobre contratos y componentes ya gobernados.

### AE-4A — Assets List / Explorer

Debe resolver búsqueda, filtrado, navegación y lectura rápida de estado sin intentar mostrar toda la ficha técnica.

Evaluar:

- Data Explorer como arquetipo principal;
- thumbnail/Equipment Type icon o illustration solo donde aporte reconocimiento;
- filtros por jerarquía/tipo/estado/criticidad;
- indicadores con datos reales únicamente;
- acceso inequívoco al Asset Detail.

### AE-4B — Asset Detail / Asset Technical Profile

Arquetipo candidato: `Object 360`.

Áreas a validar:

- Overview / Identity;
- Technical Profile;
- Engineering/Documents;
- Visuals;
- Maintenance/Inspection context.

La composición final dependerá de densidad, frecuencia de uso y evidencia real en Studio.

### AE-4C — Asset Create/Edit

Separar claramente:

- datos editables CMMS;
- datos sincronizados/read-only;
- overrides permitidos;
- validaciones;
- provenance.

No duplicar datos de ingeniería si CMMS no es su autoridad.

### AE-4D — Equipment Type Library

Superficie de configuración para gobernar:

- tipos de equipo;
- technical fields aplicables;
- orden/categorías/unidades;
- vínculo con ilustración reusable;
- relación con model templates;
- mapping con fuentes de ingeniería cuando corresponda.

### AE-4E — Model Template Detail

Solo si el modelo funcional confirma necesidad real de defaults/herencia por modelo.

Debe evitar crear un segundo fabricante/model master si la autoridad está en otra fuente.

### AE-4F — Visual Library / Visual Mapping

No es una biblioteca 3D nueva.

Si se necesita una superficie CMMS, su propósito será **mapear/seleccionar/consumir** visuales gobernados, no mantener una colección duplicada.

### Gate AE-G4

Cada pantalla debe declarar `PRIMARY_USER_TASK`, `SUCCESS_CRITERION`, `PRIMARY_ARCHETYPE`, `SECONDARY_PATTERNS` y `PREMIUM_COMPONENTS` antes de la implementación, conforme al Premium Screen Standard.

---

## Fase AE-5 — Integración con la colección 3D de AssetPlan

**Objetivo:** hacer reusable la colección existente sin duplicar ownership.

### Trabajo

1. fijar contrato `EquipmentType → IllustrationKey`;
2. definir cómo CMMS obtiene/distribuye el PNG;
3. conservar source repository/path/version;
4. definir fallback;
5. probar peso y render real;
6. comprobar visual con fondos/sizes CMMS;
7. separar `Type Illustration`, `Model Image`, `Asset Photo` en UI y datos.

### Entregables

- contrato de mapping visual;
- inventario de Equipment Types CMMS con cobertura/no cobertura;
- mecanismo de consumo/distribución;
- evidencia runtime de varios tipos representativos.

### Gate AE-G5

PASS solo si CMMS puede consumir los assets sin convertirse en segunda fuente de verdad y sin degradar rendimiento o claridad visual.

---

## Fase AE-6 — Implementación incremental en Power Apps

**Objetivo:** materializar las nuevas superficies sin big-bang.

Orden recomendado:

```text
shared foundation
→ Asset Detail baseline
→ technical profile
→ engineering/visual context
→ maintenance context
→ Assets List integration
→ create/edit/configuration surfaces
```

Para cada incremento:

1. contract/design;
2. componente/shared pattern;
3. implementación pequeña;
4. import/render;
5. save/close/reopen;
6. smoke test;
7. App Checker cuando aplique;
8. Visual Design Gate;
9. documentar estado real.

No sustituir la pantalla productiva anterior hasta que la nueva ruta haya superado sus gates.

### Gate AE-G6

La primera pantalla candidato solo puede convertirse en referencia del resto cuando exista evidencia real suficiente y alcance la madurez visual requerida.

---

## Fase AE-7 — Convergencia y rollout

**Objetivo:** eliminar fragmentación después de validar el nuevo patrón.

### Trabajo

- migrar consumidores compatibles a componentes compartidos;
- retirar estilos/iconos locales obsoletos;
- actualizar catálogo de componentes;
- actualizar branding/iconografía;
- revisar navegación y rutas legacy;
- comprobar consistencia desktop/tablet;
- registrar deuda no resuelta;
- congelar referencias canónicas únicamente con evidencia.

### Gate AE-G7

No declarar convergencia completa mientras existan superficies activas que utilicen deliberadamente un segundo lenguaje visual sin excepción documentada.

---

# 5. Dependencias y orden de ejecución

```text
AE-0 Audit
  ↓
AE-1 Asset Experience contract
  ↓
AE-2 Visual system
  ↓
AE-3 Shared premium components
  ↓
AE-4 Screen redesign
  ↓
AE-5 AssetPlan 3D consumption
  ↓
AE-6 Power Apps implementation
  ↓
AE-7 Convergence
```

AE-2 y AE-1 pueden solaparse parcialmente en discovery, pero no deben cerrar componentes productivos hasta conocer el contrato de datos y semántica.

La integración 3D puede prepararse en paralelo después de AE-G1, pero no debe bloquear el contrato principal de Assets: una ficha técnica debe funcionar correctamente aunque no exista ilustración para un tipo concreto.

---

# 6. Criterios de éxito

La iniciativa se considera lograda cuando:

1. `Assets` representa de forma clara identidad, perfil técnico, ingeniería, visuales y mantenimiento sin confundir autoridades;
2. Technical Fields no dependen de columnas fijas por cada clase de equipo;
3. iconografía y jerarquía pertenecen al sistema visual CMMS, no a una solución local;
4. los patrones repetibles existen como componentes premium compartidos;
5. las ilustraciones 3D de AssetPlan se reutilizan sin duplicar ownership;
6. `Type Illustration`, `Model Image` y `Asset Photo` permanecen semánticamente separados;
7. todas las superficies muestran states/provenance veraces;
8. existe evidencia Power Apps real antes de `VISUAL_APPROVED` o equivalente;
9. el rediseño no crea un segundo maestro de ingeniería dentro de CMMS.

---

# 7. No objetivos

Este incremento no decide todavía:

- tecnología final para CAD/BIM/3D engineering viewer;
- repositorio documental corporativo final;
- mecanismo definitivo de sincronización ALEP ↔ CMMS;
- ownership empresarial de todos los atributos técnicos;
- creación de una nueva biblioteca 3D CMMS;
- aprobación visual final de los mockups conceptuales generados durante discovery.

Esos puntos requieren contratos/evidencia propios.

---

# 8. Primera acción ejecutable

Comenzar por `AE-0 — Baseline y auditoría` sobre la pantalla Assets existente, el catálogo CMMS, branding/iconografía y prototipos de activos actuales.

El resultado de AE-0 debe producir el paquete mínimo necesario para cerrar AE-G0 y entrar en el contrato de Asset Experience sin rediseñar a ciegas.
