# CMMS 2.0 — C01 Component Adaptation Baseline

**Estado:** `READY_FOR_STUDIO_GATE`  
**Fecha:** 2026-09-04  
**Consumer:** CMMS Canvas app — empty current target  
**Objetivo:** definir qué foundation Power Apps se reutiliza/adapta antes de construir pantallas funcionales.

## 1. Regla

CMMS no copia visualmente AssetPlan o TMS.

Se reutilizan contratos y aprendizajes probados mediante:

```text
REUSE_CMMS
→ ADAPT_VERIFIED_BASE
→ EXTEND_SHARED
→ CREATE_SHARED
→ LOCAL_ONLY
```

Branding/tokens CMMS siguen siendo autoridad:

- `06-ui-ux/branding/README.md`
- `06-ui-ux/branding/tokens/cmms-brand-tokens.json`
- `06-ui-ux/branding/tokens/CMMSBrandTokens.powerfx.txt`

## 2. Decisión por capability foundation

| Capability | Decision | Source / rationale | C01 action |
|---|---|---|---|
| Theme / tokens | REUSE_CMMS | CMMS branding library already canonical | Load/adapt current CMMS tokens into App.OnStart or governed theme initialization |
| Sidebar contract | ADAPT_VERIFIED_BASE | TMS Sidebar RC6 proved host-owned `NavItems`, `ActiveKey`, collapse, events; AssetPlan V2 is its validated ancestry | Build `cmp_CMMS_SidebarPro` with CMMS brand/assets/navigation; do not copy TMS media or labels |
| Project Context | ADAPT_VERIFIED_BASE | TMS/AssetPlan pattern separates pending/loaded Project and host ownership | Build `cmp_CMMS_ProjectContextPro`; component emits intent, host loads context |
| Page Header | ADAPT_VERIFIED_BASE | AssetPlan R1 PageHeader geometry is cleaner for product-wide L1 identity | Build `cmp_CMMS_PageHeaderPro` without domain business logic |
| Action Button | ADAPT_VERIFIED_BASE | AssetPlan ActionButton busy/locked contract supports Async Action Guard | Build/port `cmp_CMMS_ActionButtonPro` only when first remote action consumes it |
| State Panel | ADAPT_VERIFIED_BASE | AssetPlan StatePanel R1 handles narrow/wide non-ready surfaces | Build `cmp_CMMS_StatePanelPro` with CMMS semantic states |
| Skeleton Loader | ADAPT_VERIFIED_BASE | TMS preferred foundation has localized loading rather than global blocking | Build only the minimal reusable CMMS skeleton needed by first screen |
| Icon Resolver | EXTEND_SHARED | CMMS already owns functional icon library | `cmp_CMMS_IconPro` resolves CMMS icons; never consume TMS navigation media |
| Study Stepper | CREATE_SHARED_LATER | Reliability Engineering is first real consumer | Do not create in C01 before study shell contract is frozen |
| Data Grid | DEFER | First real consumer will be Reliability Studies list | Select/adapt then, not now |
| Risk Matrix | DEFER | Requires RiskProfile contract | Build with FMEA capability, never hard-code 5x5 |
| RCM Decision Flow | DEFER | Requires RCM tree contract | Build with RCM workspace, no scoring |

## 3. Canonical component identities

Power Apps logical identities do not carry RC/version suffixes.

Target identities:

```text
cmp_CMMS_SidebarPro
cmp_CMMS_ProjectContextPro
cmp_CMMS_PageHeaderPro
cmp_CMMS_ActionButtonPro
cmp_CMMS_StatePanelPro
cmp_CMMS_SkeletonLoader
cmp_CMMS_IconPro
```

Repository artifacts may later contain revision/date suffixes for traceability, but `ComponentDefinitions`, self references and instances must use the canonical identity.

## 4. Shell contract

C01 creates infrastructure, not a disposable demo.

```text
CMMS App Shell
├─ Sidebar / primary navigation
├─ Global Project Context
├─ User / environment context
├─ Page Identity
├─ Workspace surface
└─ Local state surfaces / overlay layer
```

The shell must host future domains without structural rewrite:

```text
Home / Overview
Assets
Reliability Engineering
Maintenance
Work Management
Materials
Reports
Administration / Configuration
```

Only capabilities that actually exist become active navigation destinations. Future items may be hidden/disabled; decorative dead routes are not acceptable.

## 5. Navigation ownership

Shared navigation components never execute `Navigate()` internally.

Pattern:

```text
component selection
→ OnNavigate(Key)
→ host validates dirty state / context / permission
→ host Navigate(...)
```

This keeps navigation compatible with future guards and avoids coupling the component to physical screen names.

## 6. Project context ownership

Project is a cross-domain context, not a Reliability-only field.

Pattern:

```text
PendingProject
→ host accepts / rejects
→ loading state
→ adapter loads normalized context
→ LoadedProject
→ workspace consumes ProjectId/ProjectCode
```

No component calls SQL/Flow directly.

## 7. UI states foundation

Canonical application/surface states for C01:

```text
LOADING
READY
EMPTY
ERROR
PERMISSION_DENIED
CONFLICT
NO_PROJECT
BLOCKED
WARNING
```

Not every surface exposes every state. `CONFLICT` must exist in the visual grammar before the first optimistic-concurrency command is introduced.

## 8. C01 Studio gate

C01 is not validated by repository existence.

The current empty CMMS app must prove:

```text
[ ] CMMS theme initializes without formula errors
[ ] responsive root container works
[ ] Sidebar expands/collapses
[ ] host receives navigation event
[ ] Project Context renders without backend
[ ] Page Header renders against CMMS tokens
[ ] READY / LOADING / EMPTY / ERROR / CONFLICT surface examples render
[ ] no clipping/overlap at representative desktop widths
[ ] App Checker delta is attributable and acceptable
[ ] save / close / reopen preserves the installed foundation
```

Until that passes, component lifecycle remains `CMMS_RC / NOT VALIDATED_CMMS`.

## 9. Source provenance used for this baseline

- CMMS branding/token library: canonical CMMS source.
- AssetPlan Premium Component Foundation R1: validated geometry/state patterns.
- TMS Sidebar RC6: validated host-owned navigation contract derived from AssetPlan baseline.
- TMS Development Baseline: contract-driven shell/state/adapter separation.

No foreign branding, domain semantics, media names or physical screen routes are copied into CMMS.
