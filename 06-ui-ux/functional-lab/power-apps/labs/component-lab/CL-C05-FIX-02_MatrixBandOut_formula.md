# CL-C05-FIX-02 — MatrixBandOut formula repair

## ACTION

Update **only** the custom Output property `MatrixBandOut` of the existing `cmp_FL_RiskMatrixPro` identity.

Do not modify any control geometry or other custom property.

## Replace formula

Use this Power Fx formula for `MatrixBandOut`:

```powerfx
With(
    {
        _score:
            cmp_FL_RiskMatrixPro.SelectedSeverityOut *
            cmp_FL_RiskMatrixPro.SelectedOccurrenceOut,
        _low: Coalesce(cmp_FL_RiskMatrixPro.LowMax, 5),
        _moderate: Coalesce(cmp_FL_RiskMatrixPro.ModerateMax, 10),
        _high: Coalesce(cmp_FL_RiskMatrixPro.HighMax, 20)
    },
    If(
        _score <= _low,
        Coalesce(cmp_FL_RiskMatrixPro.LowLabel, "Bajo"),
        If(
            _score <= _moderate,
            Coalesce(cmp_FL_RiskMatrixPro.ModerateLabel, "Moderado"),
            If(
                _score <= _high,
                Coalesce(cmp_FL_RiskMatrixPro.HighLabel, "Alto"),
                Coalesce(cmp_FL_RiskMatrixPro.CriticalLabel, "Crítico")
            )
        )
    )
)
```

## Why

The previous formula used `MatrixScoreOut` as an intermediate Output property. Studio evidence from the hosted Component Lab instance shows that selection outputs and `MatrixScoreOut` evaluate, while `MatrixBandOut` remains blank. This repair removes the output-to-output dependency and calculates the band directly from the selected S and O outputs.

The `Coalesce` fallbacks also keep the output deterministic if a host does not materialize a numeric threshold or text label.

## Expected result

```text
S2/O4 -> score 8  -> Moderado
S4/O3 -> score 12 -> Alto
S5/O5 -> score 25 -> Crítico
```

D must not affect `MatrixBandOut`.
