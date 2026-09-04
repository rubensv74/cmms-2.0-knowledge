# CMMS 2.0 — C01-B Shared Shell Studio Gate

**State:** `READY_FOR_REAL_STUDIO`  
**Date:** 2026-09-04  
**Purpose:** replace the successful native C01-A probe with canonical shared CMMS components and the first retained Reliability Engineering product screen.

## 1. What this gate proves

C01-A already proved current Studio / Source Code compatibility.

C01-B now proves:

```text
canonical component definitions
→ host-owned component inputs/events
→ responsive shared shell
→ disabled unreleased routes
→ retained Reliability Engineering landing screen
```

No SQL/Flow dependency exists yet.

## 2. Replace App.Formulas baseline

Replace the current C01-A App.Formulas with the complete content of:

```text
09-development/power-apps/C01_B_APP_FORMULAS.powerfx.txt
```

This preserves theme/layout contracts and changes:

- `CMMSBuild.Increment` to `C01-B`;
- navigation to explicit `IsVisible` / `IsEnabled` contracts;
- only `Reliability Engineering` is enabled at this stage;
- foundation state vocabulary is added: READY / LOADING / EMPTY / ERROR / CONFLICT.

No App.OnStart replacement is required.

## 3. Install components

Install/paste the three complete component definitions:

```text
08-resources/power-apps/components/foundation/cmp_CMMS_SidebarPro_C01B.pa.yaml
08-resources/power-apps/components/foundation/cmp_CMMS_ProjectContextPro_C01B.pa.yaml
08-resources/power-apps/components/foundation/cmp_CMMS_PageHeaderPro_C01B.pa.yaml
```

Canonical Power Apps identities must appear exactly as:

```text
cmp_CMMS_SidebarPro
cmp_CMMS_ProjectContextPro
cmp_CMMS_PageHeaderPro
```

Do not add RC/version suffixes inside the Canvas app.

The repository filenames carry `C01B` only for traceability.

### Important component design rule

These C01-B components are deliberately independent from App Scope for visual tokens.

They do not require a component-level `Access app scope` dependency to render. The host supplies only data/state/intent properties.

## 4. Install retained Reliability Engineering screen

Paste the complete screen source:

```text
08-resources/power-apps/screens/reliability/scr_ReliabilityEngineering_C01B.pa.yaml
```

Canonical screen identity:

```text
scr_ReliabilityEngineering
```

This is not a disposable probe. If it passes, it becomes the retained landing screen for the module.

Keep `scr_CMMS_Foundation_C01` temporarily as rollback/reference until C01-B PASS.

## 5. Expected visual differences from C01-A

The overall visual language remains intentionally stable, but the implementation changes materially:

```text
native sidebar block        → cmp_CMMS_SidebarPro
native project context      → cmp_CMMS_ProjectContextPro
native page header          → cmp_CMMS_PageHeaderPro
```

Navigation behavior changes:

- `Reliability Engineering` remains enabled/active;
- unreleased modules remain visible as roadmap context but render disabled;
- clicking a disabled route must not move the active state;
- the component never calls `Navigate()` internally.

The P-101 backbone also shows the canonical state vocabulary for future async/concurrency UX.

## 6. Interaction checks

### Sidebar

```text
[ ] collapse button works
[ ] expand button works
[ ] width changes 280 ↔ 72 without overlap
[ ] Reliability Engineering remains active
[ ] clicking Home/Assets/Maintenance/etc. does not activate a dead route
```

### Project Context

```text
[ ] No project selected renders when context is blank
[ ] Actor email may render when available
[ ] no backend call is made
```

### Page Header

```text
[ ] Reliability eyebrow
[ ] Reliability Engineering title
[ ] subtitle renders without clipping
```

### Responsive

Test at normal desktop width and a reduced Studio width.

```text
[ ] no accidental horizontal scroll at supported desktop widths
[ ] sidebar/content remain structurally separated
[ ] cards remain usable
[ ] P-101 stage strip remains visible/useful
```

## 7. App Checker

Capture App Checker after installation.

Gate blocks on any new Formula/Runtime error attributable to C01-B.

Accessibility/performance warnings are classified before acceptance; they are not silently ignored.

## 8. PASS evidence

Return:

```text
1. normal-width screenshot of scr_ReliabilityEngineering
2. screenshot with Sidebar collapsed
3. reduced-width screenshot
4. App Checker summary
```

If Source Code fails, return the complete Power Apps error text instead of attempting local redesign.

## 9. PASS marker

```text
C01_B_SHARED_SHELL_STUDIO_PASS
```

## 10. After PASS

No more foundation prototyping.

```text
C01-B PASS
→ C01-C canonical screen template frozen
→ I01-A common SQL/result contracts
→ I01-B Project / Asset / Reliability Study read slice
→ first real Reliability Studies list
```

The next development work therefore begins coupling the retained UI to synthetic/SQL-backed application contracts rather than creating more shell variants.
