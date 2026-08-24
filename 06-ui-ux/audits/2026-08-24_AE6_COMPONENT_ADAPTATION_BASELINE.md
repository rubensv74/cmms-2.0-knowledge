# CMMS 2.0 — AE6 Component Adaptation Baseline

**Fecha:** 2026-08-24  
**Track:** Asset Experience Redefinition  
**Fase:** AE-6 preparation  
**Estado:** `SOURCE_AUDITED / ADAPTATION_NOT_YET_IMPLEMENTED`

## 1. Propósito

Cerrar qué componentes reales de `rubensv74/app_preserv` pueden utilizarse como baseline de adaptación para CMMS y qué delta debe aplicarse antes de considerarlos candidatos CMMS.

Regla:

```text
verified source != CMMS component
```

Un componente de AssetPlan puede aportar estructura y comportamiento probados, pero debe eliminar acoplamientos de producto, respetar tokens/semántica CMMS y superar Studio en la app CMMS.

---

# 2. Baselines auditados

## 2.1 Page Header

Source:

```text
repository: rubensv74/app_preserv
path: power-apps/components/adapted/cmp_AP_PageHeaderPro_RC0.pa.yaml
blob SHA: f751f828f2cf99ab8150f5ee43f94774283d3af0
```

### Qué sí se reutiliza

- CanvasComponent structure;
- Title / Subtitle inputs;
- optional icon concept;
- compact premium typography structure;
- host-controlled content;
- transparent root surface.

### Qué no se copia sin cambios

- `BreadcrumbText / ShowBreadcrumb` como comportamiento por defecto;
- `ShowStatus / StatusText / StatusTone` dentro de N1;
- hard-coded `Switch()` hacia Media `ap-*`;
- geometría fija `Height = 104`;
- colores AssetPlan directos.

### Delta CMMS obligatorio

```text
cmp_AP_PageHeaderPro_RC0
    -> cmp_CMMS_PageHeaderPro_RC0
```

Debe:

1. cumplir `CMMS_PAGE_HEADER_HIERARCHY_V1`;
2. representar solo N1 Page Identity;
3. no absorber N2 Context Strip ni N3 Summary/Gate;
4. resolver iconos mediante contrato CMMS;
5. consumir tokens CMMS;
6. dejar geometría final pendiente de Studio.

**Decisión:** `ADAPT_VERIFIED_BASE`.

---

## 2.2 Action Button

Source:

```text
repository: rubensv74/app_preserv
path: power-apps/components/adapted/cmp_AP_ActionButtonPro_RC1.pa.yaml
blob SHA: 6407ed46af2ccc0566a734203764b1d4ff031d94
```

### Qué sí se reutiliza

- `Text`;
- `AccessibleLabel`;
- `IconKey`;
- `Tone`;
- `IsEnabled`;
- `IsBusy`;
- `BusyText`;
- host event `OnSelect`;
- hit-area independiente;
- `DisplayMode` bloqueado cuando `IsBusy = true`.

Este componente ya materializa correctamente el lado cliente del patrón `Async Action Guard` para el disparador visual.

### Delta CMMS obligatorio

- sustituir AP Line hard-coded Media;
- aplicar tokens CMMS;
- revisar si CMMS necesita `DESTRUCTIVE` como tone explícito;
- validar focus/keyboard/hover en Studio;
- no asumir que `IsBusy` sustituye idempotencia backend.

**Decisión:** `ADAPT_VERIFIED_BASE / HIGH_VALUE_BASELINE`.

---

## 2.3 State Panel

Source:

```text
repository: rubensv74/app_preserv
path: power-apps/components/adapted/cmp_AP_StatePanelPro_RC0.pa.yaml
blob SHA: 2e2878291ec3053db16f3e8c459c17774abafc38
```

### Qué sí se reutiliza

- geometría persistente;
- Title / Message;
- optional host action;
- busy action lock;
- state-specific icon/surface;
- no overlay global obligatorio.

### Gap funcional CMMS

Source soporta:

```text
LOADING
EMPTY
ERROR
UNAVAILABLE
NO_CONTEXT
```

CMMS necesita como mínimo:

```text
LOADING
EMPTY
UNAVAILABLE
STALE
ERROR
BLOCKED
```

`NO_CONTEXT` puede mantenerse solo en consumidores donde exista contexto global real.

### Delta CMMS obligatorio

- añadir `STALE`;
- añadir `BLOCKED`;
- no hacer que WARNING visual signifique automáticamente STALE/BLOCKED;
- resolver iconos CMMS;
- tokens CMMS;
- revisar copy por consumer.

**Decisión:** `ADAPT_VERIFIED_BASE`.

---

## 2.4 Icon renderer

Source:

```text
repository: rubensv74/app_preserv
path: power-apps/components/adapted/cmp_AP_IconPro.pa.yaml
blob SHA: 1023c60b98e1cb465d4f6f86edc929a4c0163a68
```

### Qué sí se reutiliza

- semantic `IconKey` input;
- `AccessibleLabel`;
- 24x24 primitive;
- Image/Fit renderer;
- fallback icon concept.

### Qué no se reutiliza

El `Switch()` actual resuelve directamente semantic keys a Media `ap-*`. Eso convierte la implementación AssetPlan en registry de facto y no debe trasladarse a CMMS.

### Delta CMMS obligatorio

Preferencia:

```text
semantic IconKey
    -> CMMS icon registry/resolver
    -> IconUri / Media transport
    -> Image
```

No:

```text
screen/component-specific Switch() repeated across controls
```

La semántica de iconos CMMS se mantiene en su propia familia visual; AssetPlan sirve como patrón técnico, no como ownership visual.

**Decisión:** `ADAPT_PATTERN / REIMPLEMENT_RESOLVER`.

---

# 3. Qué NO adaptar todavía

Para `AE6-S01 Asset Detail` no se justifican todavía:

```text
cmp_AP_KpiStripPro_RC0
cmp_AP_DonutSummaryPro_RC0
cmp_AP_ProgressListPro_RC0
cmp_AP_InsightListPro_RC0
cmp_AP_DataGridPro_RC0
cmp_AP_FilterBarPro_RC0
```

Motivo:

- Asset Detail S01 no necesita KPI strip;
- no necesita chart;
- no necesita Data Explorer global;
- no necesita filter bar.

`cmp_AP_KeyValueCardPro_RC0` puede estudiarse como primitive secundaria del Technical Profile, pero no debe bloquear `cmp_CMMS_TechnicalValue_RC0`, cuyo contrato es más específico.

---

# 4. Adaptation order para S01

```text
1. cmp_CMMS_IconPro / resolver mínimo
2. cmp_CMMS_PageHeaderPro_RC0
3. cmp_CMMS_StatePanelPro_RC0
4. cmp_CMMS_ActionButtonPro_RC0
5. cmp_CMMS_AssetIdentityHero_RC0
6. cmp_CMMS_TechnicalValue_RC0
7. cmp_CMMS_TechnicalSpecificationGrid_RC0
8. remaining Asset Detail panels
```

No construir el Object 360 completo antes de validar 1–4 en la app real.

---

# 5. Lifecycle

Hasta Studio:

```text
source AssetPlan component = VERIFIED_EXTERNAL_BASE
CMMS contract              = TO_VALIDATE
CMMS implemented candidate = CMMS_RC
Studio evidence PASS       = VALIDATED_CMMS (solo para scope probado)
```

No existe promoción por semejanza visual ni por copiar el YAML.
