# CMMS 2.0 — C01-A Studio Gate

**State:** `READY_FOR_REAL_STUDIO`  
**Date:** 2026-09-04  
**Purpose:** validate the CMMS theme/layout foundation and one complete native-control screen before extracting shared components.

## Why this gate exists

G0 confirmed that the current Canvas app is clean and responsive. The next uncertainty is no longer conceptual: it is the real Source Code/control compatibility of the current Power Apps Studio.

The safest sequence is:

```text
App.Formulas foundation
→ App.OnStart runtime state
→ one complete native-control screen
→ Studio validation
→ shared component extraction/adaptation
```

Do not create Sidebar/PageHeader/ProjectContext components before this screen renders correctly.

## Step 1 — App.Formulas

Open `App` in the Tree view and select the `Formulas` property.

Paste the complete content of:

`09-development/power-apps/C01_A_APP_FORMULAS.powerfx.txt`

Expected result: no formula error.

This installs:

```text
CMMSTheme
CMMSLayout
CMMSBuild
CMMSNavItems
CMMSReliabilityStages
```

## Step 2 — App.OnStart

Paste the complete content of:

`09-development/power-apps/C01_A_APP_ONSTART.powerfx.txt`

Run `App.OnStart`.

Expected runtime state:

```text
gblCMMSUserEmail
gblCMMSUserName
gblCMMSEnvironmentLabel
gblCMMSNavKey
gblCMMSSidebarCollapsed
gblCMMSProjectId
gblCMMSProjectCode
gblCMMSProjectName
gblCMMSBusy
gblCMMSInitialized
```

## Step 3 — Source Code screen

Create a new blank screen temporarily or use the Source Code create/paste workflow available in Studio.

Import/paste the complete source from:

`08-resources/power-apps/screens/foundation/scr_CMMS_Foundation_C01.pa.yaml`

The target screen name is:

```text
scr_CMMS_Foundation_C01
```

Do **not** replace `Screen1` yet. The existing clean screen remains rollback evidence until C01 passes.

## Expected visual result

The screen should show:

```text
Dark CMMS left navigation
Project context bar
Reliability Engineering header
3 reliability area cards
P-101 Reliability Study Backbone panel
Scope → Functions & Failures → FMEA → RCM → Strategy → Review
```

The screen intentionally uses only native controls. No AssetPlan/TMS component dependency exists in this gate.

## Interaction checks

1. Click items in the left navigation.
   - active state should move;
   - no navigation to another screen occurs yet.
2. Resize Studio width.
   - content must remain inside the responsive root;
   - no accidental horizontal overflow at normal desktop widths.
3. Confirm the current user appears in the sidebar/context.
4. Confirm environment footer shows `ENV PRE TR 162`.

## App Checker comparison

G0 baseline:

```text
Accessibility = 1
Formulas      = no visible count
Runtime       = no visible count
Performance   = no visible count
Data source   = no visible count
```

After C01-A, capture App Checker again.

Any new **error** attributable to C01 blocks PASS. Warnings are reviewed by cause; they are not automatically ignored.

## PASS evidence

Return:

```text
1. screenshot of scr_CMMS_Foundation_C01 at normal desktop width
2. screenshot after reducing the editor width
3. App Checker summary
4. exact error text if Source Code paste/import fails
```

## PASS marker

```text
C01_A_FOUNDATION_STUDIO_PASS
```

## What happens immediately after PASS

No further concept workshop is required.

```text
C01-A PASS
→ C01-B extract/adapt CMMS Sidebar
→ C01-B Project Context
→ C01-B Page Header
→ C01-B State/Action primitives
→ C01-C canonical screen template
→ I01-A common backend contracts
→ Reliability Studies real screen
```

The foundation probe screen may then be retained as a development reference or removed once the canonical component-based screen is validated.
