# AS-01 — Power Fx fixture and IAP grid binding candidate V1

**Status:** host-formula candidate; not a complete screen, not imported, not Studio-validated.  
**Screen:** AS-01 Assets List.  
**Authority:** `CMMS_ASSETS_LIST_READ_CONTRACT_V1` (logical read contract accepted; physical source deferred and fixture explicitly allowed); AS-01 UX contract.  
**Grid source candidate:** `cmp_IAP_DataGridPro`, blob SHA `d0f5e601fb46c97a02480bab1e65a965f3421553`.  
**Flows:** out of scope and paused.

This is the first executable lab increment after refreshing the current Studio baseline and verifying the host controls/components. It supplies a deterministic synthetic source and maps it to the pinned IAP grid contract. It does not claim the IAP component is installed or runtime-safe.

## 1. Component decision

Use the IAP DataGridPro main candidate for the first AS-01 lab pass, pending import and Studio validation:

- Its input is deliberately normalized to 1–10 slots and its host owns domain mapping, filtering and sorting.
- It supports the AS-01 read-only states and exposes `OnRowSelect(p_key)` and `OnSort(p_sortKey)`.
- The PULSE `cmp_DataTableProV2` source has useful pagination and richer selection, but its contract also exposes bulk actions, checkboxes, column selection and context actions that AS-01 does not need. Its rows must already be filtered, sorted and paged by the host.
- The IAP PR #10 alternative remains on hold because it shares the Canvas component identity. Do not import both sources.

This selects a candidate for the isolated lab. It does not promote the source to a CMMS canonical or validated component.

## 2. Expected host controls

Use the following names in the formulas, or replace them consistently in Studio:

| Control | Expected item fields |
|---|---|
| `txtAS01_Search` | Text input |
| `ddAS01_Type` | `{Code, Label}` |
| `ddAS01_Location` | `{Code, Label}` |
| `ddAS01_Lifecycle` | `{Code, Label}` |
| `ddAS01_Criticality` | `{Code, Label}` |
| `cmp_IAP_DataGridPro_AS01` | Imported candidate component instance |

The component properties below must be confirmed against the imported Studio instance before pasting formulas. Existing `cmp_FL_*` components remain the visible baseline; they are not assumed to have IAP-compatible contracts.

## 3. Screen OnVisible — synthetic fixture

Use only in Functional Lab. All values are invented examples.

```powerfx
ClearCollect(
    colAS01_Fixture,
    {
        AssetId: "AST-0001",
        AssetCode: "P-102A",
        Description: "Cooling water transfer pump",
        EquipmentTypeCode: "PUMP_CENTRIFUGAL",
        EquipmentTypeLabel: "Centrifugal pump",
        EquipmentTypeIconKey: "Pump",
        LocationCode: "PLANT-A/AREA-01",
        LocationLabel: "Plant A · Area 01",
        CriticalityCode: "C2",
        CriticalityLabel: "High",
        LifecycleStatusCode: "IN_SERVICE",
        LifecycleStatusLabel: "In service",
        ManufacturerName: "Northstar",
        ModelName: "NC-420",
        SerialNumber: "SYN-102A",
        FreshnessStatus: "SYNTHETIC"
    },
    {
        AssetId: "AST-0002",
        AssetCode: "M-204",
        Description: "North process mixer",
        EquipmentTypeCode: "MIXER",
        EquipmentTypeLabel: "Mixer",
        EquipmentTypeIconKey: "Mixer",
        LocationCode: "PLANT-A/AREA-02",
        LocationLabel: "Plant A · Area 02",
        CriticalityCode: "C3",
        CriticalityLabel: "Medium",
        LifecycleStatusCode: "IN_SERVICE",
        LifecycleStatusLabel: "In service",
        ManufacturerName: "Example Works",
        ModelName: "MX-20",
        SerialNumber: "SYN-204",
        FreshnessStatus: "SYNTHETIC"
    },
    {
        AssetId: "AST-0003",
        AssetCode: "F-031",
        Description: "Instrument air filter",
        EquipmentTypeCode: "FILTER",
        EquipmentTypeLabel: "Filter",
        EquipmentTypeIconKey: "Filter",
        LocationCode: "PLANT-B/UTILITIES",
        LocationLabel: "Plant B · Utilities",
        CriticalityCode: "C4",
        CriticalityLabel: "Low",
        LifecycleStatusCode: "STANDBY",
        LifecycleStatusLabel: "Standby",
        ManufacturerName: Blank(),
        ModelName: Blank(),
        SerialNumber: Blank(),
        FreshnessStatus: "SYNTHETIC"
    },
    {
        AssetId: "AST-0004",
        AssetCode: "P-102B",
        Description: "Standby cooling water transfer pump",
        EquipmentTypeCode: "PUMP_CENTRIFUGAL",
        EquipmentTypeLabel: "Centrifugal pump",
        EquipmentTypeIconKey: "Pump",
        LocationCode: "PLANT-A/AREA-01",
        LocationLabel: "Plant A · Area 01",
        CriticalityCode: "C2",
        CriticalityLabel: "High",
        LifecycleStatusCode: "IN_SERVICE",
        LifecycleStatusLabel: "In service",
        ManufacturerName: "Northstar",
        ModelName: "NC-420",
        SerialNumber: "SYN-102B",
        FreshnessStatus: "SYNTHETIC"
    }
);

Set(varAS01_DataState, "READY");
Set(varAS01_SortKey, "AssetCode");
Set(varAS01_SortDirection, "ASC");
Set(varAS01_SelectedAssetCode, Blank());

Select(btnAS01_ApplyFilters);
```

## 4. Hidden host button — filter and sort fixture

Create a button named `btnAS01_ApplyFilters`, set `Visible = false`, and use this `OnSelect`:

```powerfx
ClearCollect(
    colAS01_Visible,
    SortByColumns(
        Filter(
            colAS01_Fixture,
            IsBlank(Trim(txtAS01_Search.Text)) ||
                Lower(Trim(txtAS01_Search.Text)) in Lower(AssetCode) ||
                Lower(Trim(txtAS01_Search.Text)) in Lower(Description),
            IsBlank(ddAS01_Type.Selected.Code) ||
                EquipmentTypeCode = ddAS01_Type.Selected.Code,
            IsBlank(ddAS01_Location.Selected.Code) ||
                StartsWith(LocationCode, ddAS01_Location.Selected.Code),
            IsBlank(ddAS01_Lifecycle.Selected.Code) ||
                LifecycleStatusCode = ddAS01_Lifecycle.Selected.Code,
            IsBlank(ddAS01_Criticality.Selected.Code) ||
                CriticalityCode = ddAS01_Criticality.Selected.Code
        ),
        Switch(
            varAS01_SortKey,
            "Description", "Description",
            "EquipmentTypeLabel", "EquipmentTypeLabel",
            "LocationLabel", "LocationLabel",
            "CriticalityLabel", "CriticalityLabel",
            "LifecycleStatusLabel", "LifecycleStatusLabel",
            "AssetCode"
        ),
        If(
            varAS01_SortDirection = "DESC",
            SortOrder.Descending,
            SortOrder.Ascending
        )
    )
);
```

Set each search/filter control's `OnChange` to:

```powerfx
Select(btnAS01_ApplyFilters)
```

All search and filter work is local over `colAS01_Fixture`; it is not a production data adapter and has no delegation behavior to validate.

## 5. IAP DataGridPro properties

Set the imported component instance as follows. These inputs use the candidate's declared public contract; re-check names after import.

### Columns

```powerfx
Table(
    {Order: 10, Slot: "C1", Label: "Asset code", SortKey: "AssetCode", Sortable: true, WidthWeight: 1.05, CellKind: "PRIMARY_TEXT"},
    {Order: 20, Slot: "C2", Label: "Description", SortKey: "Description", Sortable: true, WidthWeight: 1.75, CellKind: "TEXT"},
    {Order: 30, Slot: "C3", Label: "Equipment type", SortKey: "EquipmentTypeLabel", Sortable: true, WidthWeight: 1.2, CellKind: "TEXT"},
    {Order: 40, Slot: "C4", Label: "Location", SortKey: "LocationLabel", Sortable: true, WidthWeight: 1.25, CellKind: "TEXT"},
    {Order: 50, Slot: "C5", Label: "Criticality", SortKey: "CriticalityLabel", Sortable: true, WidthWeight: 0.8, CellKind: "TEXT"},
    {Order: 60, Slot: "C6", Label: "Lifecycle", SortKey: "LifecycleStatusLabel", Sortable: true, WidthWeight: 0.95, CellKind: "TEXT"}
)
```

### Rows

```powerfx
ForAll(
    colAS01_Visible As asset,
    {
        RowKey: asset.AssetCode,
        IsSelected: asset.AssetCode = varAS01_SelectedAssetCode,
        IsEnabled: true,
        C1: asset.AssetCode,
        C1Secondary: "",
        C2: asset.Description,
        C2Secondary: "",
        C3: asset.EquipmentTypeLabel,
        C3Secondary: "",
        C4: Coalesce(asset.LocationLabel, "—"),
        C4Secondary: "",
        C5: Coalesce(asset.CriticalityLabel, "—"),
        C5Secondary: "",
        C6: asset.LifecycleStatusLabel,
        C6Secondary: ""
    }
)
```

### State and sort inputs

```powerfx
If(
    varAS01_DataState <> "READY",
    varAS01_DataState,
    If(CountRows(colAS01_Visible) = 0, "EMPTY", "READY")
)
```

Set `EmptyText` to `"No assets match these search and filter values."`, `SelectedRowKeyIn` to `varAS01_SelectedAssetCode`, `SortKeyIn` to `varAS01_SortKey`, `SortDirectionIn` to `varAS01_SortDirection`, `ShowSelection` to `false`, and `ShowRowActions` to `false`.

Keep color inputs at their component defaults in this candidate pass. The DesignSystemLab palette is not approved for propagation.

## 6. Component event formulas

### OnRowSelect(p_key)

```powerfx
Set(varAS01_SelectedAssetCode, p_key);
Set(varAS01_SelectedAsset, LookUp(colAS01_Fixture, AssetCode = p_key));
```

This establishes row identity in the host. AS-02 is not present in the verified live baseline, so do not add a Navigate target until the screen exists.

### OnSort(p_sortKey)

```powerfx
If(
    varAS01_SortKey = p_sortKey,
    Set(
        varAS01_SortDirection,
        If(varAS01_SortDirection = "ASC", "DESC", "ASC")
    ),
    Set(varAS01_SortKey, p_sortKey);
    Set(varAS01_SortDirection, "ASC")
);
Select(btnAS01_ApplyFilters);
```

## 7. First Studio pass

1. Refresh the live baseline and confirm the current screen sizes, component definitions, and App Checker before creating the screen.
2. Import only the pinned IAP main candidate; do not import PR #10's alternate.
3. Verify the instance exposes the properties/events above; do not bind if the signature differs.
4. Add the fixture and host formulas to a disposable AS-01 lab screen. Keep the existing FL shell until its public contracts are confirmed.
5. Exercise search, each filter, sort direction, row selection, empty state, unavailable/error state, and Save/Reopen.
6. Record render, App Checker, source SHA, and Studio save evidence. Until then status stays candidate / not runtime-validated.

The physical read source can replace only the fixture adapter later, using the accepted logical request/response contract. No Power Automate flow is part of this increment.
