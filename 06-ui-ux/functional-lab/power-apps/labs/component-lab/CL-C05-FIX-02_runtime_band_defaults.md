# CL-C05-FIX-02 — RiskMatrix RC5 runtime hardening

## Status

`FIX — runtime contract repair`

## Trigger

Studio evidence on 2026-08-12 showed that RC5 visual composition is correct, cell selection and NPR arithmetic work, but the hosted instance renders every matrix cell with the critical/red band and `MatrixBandOut` is blank (`Banda S×O · —`).

Observed working values in the same capture:

```text
Selected S = 2
Selected O = 4
S×O = 8
D = 3
NPR = 24
```

Therefore selection, S×O and NPR are not the failing layer.

## Scope

### TOUCHES

- threshold evaluation inside `cmp_FL_RiskMatrixPro`;
- `MatrixBandOut` calculation;
- band-dependent visual formulas inside RC5;
- explicit demo threshold bindings in the Component Lab instance.

### DO NOT MODIFY

- RC5 geometry;
- 900×650 contract;
- matrix selection mechanics;
- S/O/D semantics;
- NPR formula;
- public property names;
- `scr_ComponentLab` geometry;
- other components or functional screens.

## Repair rule 1 — defensive numeric thresholds

Any internal formula that evaluates risk bands must treat unmaterialized/blank host values defensively.

Use these effective values:

```text
LowMax       = Coalesce(cmp_FL_RiskMatrixPro.LowMax, 5)
ModerateMax  = Coalesce(cmp_FL_RiskMatrixPro.ModerateMax, 10)
HighMax      = Coalesce(cmp_FL_RiskMatrixPro.HighMax, 20)
```

Apply the same fallback logic consistently to:

- matrix-cell `Fill`;
- current-band `BorderColor`;
- current-band `Fill`;
- current-band text color;
- `MatrixBandOut`.

Do not hardcode a second independent threshold model elsewhere.

## Repair rule 2 — MatrixBandOut must calculate its own score

`MatrixBandOut` must not depend on another Output custom property as its intermediate value.

Calculate the score directly from the selected values inside the output formula:

```text
_score = SelectedSeverityOut * SelectedOccurrenceOut
```

Then evaluate the effective thresholds and return the effective label.

Use defensive text fallbacks:

```text
LowLabel       = Coalesce(cmp_FL_RiskMatrixPro.LowLabel, "Bajo")
ModerateLabel  = Coalesce(cmp_FL_RiskMatrixPro.ModerateLabel, "Moderado")
HighLabel      = Coalesce(cmp_FL_RiskMatrixPro.HighLabel, "Alto")
CriticalLabel  = Coalesce(cmp_FL_RiskMatrixPro.CriticalLabel, "Crítico")
```

This keeps the public contract unchanged while removing an unnecessary output-to-output dependency.

## Repair rule 3 — Component Lab fixture binds demonstration thresholds explicitly

The CL-C05 `cmpCLRisk` instance must explicitly provide the non-corporate demonstration values used by the smoke test:

```text
LowMax       = 5
ModerateMax  = 10
HighMax      = 20
LowLabel     = "Bajo"
ModerateLabel= "Moderado"
HighLabel    = "Alto"
CriticalLabel= "Crítico"
```

These are fixture values only. They do not resolve the future corporate AMEF scale decision.

## Expected visual result

The 5×5 matrix must again show multiple semantic bands rather than a uniform critical/red surface. The selected border remains blue and independent from the risk-band fill.

For S2/O4/D3:

```text
S×O = 8
Band = Moderado
NPR = 24
```

For S4/O3/D3:

```text
S×O = 12
Band = Alto
NPR = 36
```

For S5/O5/D3:

```text
S×O = 25
Band = Crítico
NPR = 75
```

Changing only D from 3 to 4 at S5/O5 must produce:

```text
S×O = 25
Band = Crítico
NPR = 100
selected matrix cell unchanged
```

## Validation gate

One integrated Studio test only:

```text
load 4/3/3
→ confirm 12 / Alto / 36 and multi-band matrix
→ select 5/5
→ confirm 25 / Crítico / 75
→ change only D to 4
→ confirm 25 / Crítico / 100 with same selected cell
→ reload 4/3/3
```

PASS requires:

- multi-band matrix restored;
- `MatrixBandOut` non-blank and correct;
- selection border remains blue;
- D does not move the matrix cell;
- no clipping or black surfaces;
- RC5 geometry unchanged.

Only after this PASS may RC5 be promoted to the canonical `cmp_FL_RiskMatrixPro.pa.yaml` and `READY_FOR_INTEGRATION`.
