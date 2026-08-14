# CL-C07-FIX-01 — ApplicabilityMatrixPro RC3 — Visual + public contract PASS

**Date:** 2026-08-14  
**Branch:** `feature/f01-premium-foundation`  
**Component:** `cmp_FL_ApplicabilityMatrixPro`  
**Candidate:** RC3  
**Status:** `VISUAL_QA_PASS / PUBLIC_CONTRACT_VALIDATED / SAVE_REOPEN_PENDING`

## Evidence reviewed

### Normal · 920 px

Selected row: `P-102`

Observed:

- five-column table remains legible;
- selected row state is visually clear;
- `SelectedAssetCodeOut = P-102`;
- `SelectedApplicationCodeOut = APP-P102-R01`;
- `SelectedRecordOut = P-102 / STD`;
- `OnSelectApplication` event count increments to `1`;
- event payload matches `P-102 / APP-P102-R01`;
- no clipping, overlap or black surfaces;
- typography preserved.

### Stress · 760 px

Selected card: `P-103-AUX-CONDENSATE-PUMP`

Observed:

- compact card representation is active;
- all three applications remain readable;
- Asset, Criticality, Applicability, Profile and Interval remain visible;
- selected card state is visually clear;
- `SelectedAssetCodeOut = P-103-AUX-CONDENSATE-PUMP`;
- `SelectedApplicationCodeOut = APP-P103-R07-AUXILIARY-SERVICE`;
- `SelectedRecordOut = P-103-AUX-CONDENSATE-PUMP / AUXILIARY-CONTINGENCY`;
- `OnSelectApplication` event count increments to `1`;
- event payload matches the selected application;
- no clipping, overlap, ellipsis or typography reduction.

## Gate status

```text
SOURCE_VALID                 PASS
COMPONENT_DEFINITION_ACCEPTED PASS
INSTANCE_SAFE                 PASS
PUBLIC_CONTRACT_VALIDATED     PASS
VISUAL_QA_VALIDATED           PASS
SAVE_REOPEN                   PENDING
READY_FOR_INTEGRATION         PENDING SAVE_REOPEN
```

## Next action

Do not promote RC3 to the canonical component yet.

1. Save the app.
2. Close Power Apps Studio.
3. Reopen CMMS Functional Lab.
4. Re-run Normal 920 and select P-102.
5. Re-run Stress 760 and select P-103.
6. If both visual representations and all outputs/event payloads persist, close `CL-C07` and promote RC3 to canonical source.
