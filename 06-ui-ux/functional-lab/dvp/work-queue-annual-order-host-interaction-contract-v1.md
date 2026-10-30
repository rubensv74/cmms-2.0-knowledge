# CMMS Lab — Host interaction contract v1

**Status:** candidate host contract; not imported or validated in Power Apps Studio  
**Screens:** Work Queue → Annual Order Detail → Work Queue with preserved queue context  
**Data mode:** deterministic synthetic projection; read-only. No SQL or Power Automate call is part of this slice.

## 1. Host-owned read model

The host adapts the existing synthetic projection into one normalized queue collection, `colAnnualOrders`. This is a UI projection contract, not a new database schema.

| Field | Type | Used for |
|---|---|---|
| `WorkOrderId` | Text | Stable row key, selection and detail lookup |
| `WorkOrderNo` | Text | Search and first grid column |
| `AssetDisplayName` | Text | Search and grid |
| `ActivityName` | Text | Search and grid |
| `CycleKey` | Text | Search and cycle filter |
| `ParentDisplayState` | Text | Search, state filter and grid |
| `CompletedActionCount` | Number | Grid and summaries |
| `TotalActionCount` | Number | Grid and summaries |
| `NextScheduledAt` | Date/time or blank | Search display and date sort |
| `IsEnabled` | Boolean | Enables the row selection action |

The adapter must map these fields from the checked-in v1.1 projection without manufacturing missing values. If a source value is absent, leave it blank and let the screen's empty/partial-data state explain the gap.

## 2. Queue state and preservation

Keep queue state in a single app-scope record, `gblWorkQueueState`, so it survives navigation to Detail:

`SearchText, StateFilter, AssetFilter, ActivityFilter, CycleFilter, SortKey, SortDirection, Page, PageSize, SelectedWorkOrderId`.

Initialize defaults once when the queue state is blank: empty search and filters, a documented default sort, page 1, and a page size selected during responsive measurement. Do not reset this record in `OnVisible`.

Any change to search/filter/sort resets `Page=1`. Detail navigation changes only `SelectedWorkOrderId`. Returning from Detail does not reconstruct or clear the queue state.

## 3. Event and binding contract

| Control / component | Input or event | Host behavior |
|---|---|---|
| `cmp_IAP_PageHeaderPhotoPro` in Work Queue | `ShowAction=true`, `ActionText="How it works"`, `ActionEnabled=true`, `ActionBusy=false`; `OnAction` | Set `locScreenHelpOpen=true`; no query, navigation or write. |
| `cmp_IAP_PageHeaderPhotoPro` in Detail | Same visible action settings; `OnAction` | Set Detail's `locScreenHelpOpen=true`; no query, navigation or write. |
| `cmp_CMMS_ScreenHelpDecisionModal` instance | `Visible=locScreenHelpOpen`; `OnClose` | Set the screen's `locScreenHelpOpen=false`; preserve all queue/detail state. |
| Local search input | `OnChange` | Store trimmed text in `gblWorkQueueState.SearchText`; set Page to 1. |
| `cmp_IAP_FilterChips` | `OnFilterSelect(FilterKey)` | Host opens the matching value picker. The component emits the key only; host owns selected value and filter application. `OnClearAll` clears the four filters and returns to page 1. |
| `cmp_IAP_DataGridPro` | `OnSort(SortKey)` | Host toggles direction for the same key or selects ascending for a new key; returns page to 1 and supplies `SortKeyIn/SortDirectionIn`. |
| `cmp_IAP_DataGridPro` | `OnRowSelect(RowKey)` | Store the key as `SelectedWorkOrderId`; navigate to Annual Order Detail. |
| Host pager | Previous / next / page number | Update only `Page`, clamped to 1…PageCount; disable Previous on first page and Next on last page. |
| Detail planned-action list | `OnSelect(PlannedActionId)` | Store selected action key; show only its linked ExecutionRecord if one exists. |
| Detail Back button | `OnSelect` | Navigate to Work Queue without resetting `gblWorkQueueState`. |

### Candidate header and modal formulas

For the Work Queue header instance:

```powerfx
ShowAction = true
ActionText = "How it works"
ActionEnabled = true
ActionBusy = false
OnAction = UpdateContext({locScreenHelpOpen: true})
```

For its modal instance:

```powerfx
Visible = locScreenHelpOpen
OnClose = UpdateContext({locScreenHelpOpen: false})
```

Use the same bindings on Annual Order Detail with that screen's own `locScreenHelpOpen`. The event formula is host-owned; PageHeaderPhotoPro does not access data or decide what the modal contains.

## 4. Derived queue pipeline

Apply the transformations in this order:

1. Start with `colAnnualOrders`, already restricted to annual preventive rows in the synthetic projection.
2. Apply search across WorkOrderNo, AssetDisplayName, ActivityName, CycleKey and ParentDisplayState.
3. Apply State, Asset, Activity and Cycle filters together with AND semantics.
4. Sort the filtered set by the selected normalized field and direction.
5. Compute `ResultCount` and `PageCount = Max(1, RoundUp(ResultCount / PageSize, 0))`; clamp current Page if filtering reduces PageCount.
6. Pass only the current page to DataGridPro as its normalized `Rows` records (RowKey plus visible C1…Cn slots). Pass the selected ID and sort inputs separately.

This gives the grid one job: display the host's current page and emit row/sort intent. It does not fetch, filter, search, sort, or paginate data by itself. The host pager displays the total filtered result count, current page and page count. A zero-result filter shows the no-results state and disables both page controls.

## 5. Detail binding and return

Resolve the order using `SelectedWorkOrderId`. The detail host binds its planned-action list and their linked execution records from the projection. Selecting a planned action without an ExecutionRecord displays an explicit “No execution recorded” state; it must not infer or invent actual dates, results, performer or completion.

The Back action returns to the existing Work Queue state. Search text, all four filters, sort key/direction, page and selection remain unchanged. Opening or closing either screen's help modal changes only `locScreenHelpOpen`.

## 6. Error and empty states

- The current DVP uses local synthetic data; do not show a fake loading animation or refresh success.
- An empty projection uses the grid's EMPTY state.
- A search/filter with zero matches uses the no-results message and an explicit clear-filters action.
- Missing optional fields remain blank and are described as partial synthetic data; do not substitute a plausible value.
- The read-error state is retained as a design state for a future real source, but is not claimed as exercised in this static fixture.
- All controls remain read-only except local navigation, selection, filters, sort, paging and help open/close.

## 7. Verification record

**Checked against current source contracts:** FilterChips emits filter key and clear-all; DataGridPro emits RowKey and SortKey and accepts selected/sort inputs; neither component provides local search or paging. PageHeaderPhotoPro's integrated action raises `OnAction`. The modal is a host Canvas overlay.

**Still to verify:** exact v1.1 projection-to-`colAnnualOrders` field mapping; component-instance event syntax; responsive page size and clipping; modal focus/keyboard behavior; import/render/interactions in Studio. This document defines the intended host contract and does not claim these checks passed.
