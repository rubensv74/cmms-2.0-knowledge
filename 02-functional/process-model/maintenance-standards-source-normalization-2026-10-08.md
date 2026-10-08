# MSL-G01 — Source Normalization: TouatGaz Maintenance Manuals

**Date:** 2026-10-08  
**Status:** PASS_WITH_RECORDED_AMBIGUITIES  
**Sources:** FAC10005-TRE-103/300/303/404-MAI-MAN-0001 packages supplied as real project evidence.

## 1. Evidence package

Each package contains a consistent source structure:

- unit Asset Register;
- `06-Job Plan & PM-*` legacy workbook linking PM, asset/tag, Job Plan, frequency/interval and sequence;
- `07-Job Plan-*` workbook with Job Plan header, operation sequence, labor/resources, item/material sheet and tools;
- Maintenance Manual (`.docx`) providing engineering context and preventive-maintenance basis.

Units reviewed: 103, 300, 303 and 404/406.

## 2. Pilot normalized case — Unit 303 Compressor

Source Job Plan workbook: `APPENDIX 33 07-Job Plan COMPRESSORS.xlsx`.

### Source objects observed

| Source value | Normalized interpretation |
|---|---|
| `303-KJ-003A-MO-6` | Job Plan identity: Compressor Functional Verification |
| `303-KJ-003A-AN-1` | Job Plan identity: Compressor Minor Intervention |
| `303-KJ-003A-AN-3` | Job Plan identity: Compressor Major Intervention |
| `303-KJ-003A` | Asset/tag reference |
| 24 h / 24 h / 84 h | Planned Job Plan duration respectively |

Equivalent Job Plans also exist for `303-KJ-003B`.

### Operations

The source contains ordered operations (`JOBPLAN_OPERATION_NUM`) and detailed operation descriptions.

Examples from Functional Verification:

1. visual inspection and operating observation;
2. check unusual parameters/noise/vibration;
3. record operating data and gauge readings;
4. check vibration and bearing overheating using vibration meter / IR thermometer;
5. functional checks of change-over valves;
6. external cleaning;
7. load activity report in CMMS.

Minor and Major interventions contain their own ordered sequences including isolation, alignment, wear/corrosion inspection, disassembly/reassembly and performance verification.

### Resources

Observed planned resource requirements include:

- Maintenance Machinery — quantity 2;
- Operation — quantity 2;
- Maintenance Electrical — quantity 2 for intervention Job Plans.

### Tools

Observed tools include:

- Vibration meter;
- Thermometer (IR);
- Greaser.

### Frequency / trigger evidence

The paired `06-Job Plan & PM` workbooks explicitly contain source fields:

- `FREQUENCE`;
- `Frequence_Unit`;
- `Job_Plan_Interval`;
- PM Number;
- PM Tag Number;
- Job Plan Number;
- Sequence / sequential indicator.

The Maintenance Manuals also distinguish:

- condition-based preventive maintenance;
- scheduled/on-demand/continuous monitoring;
- maintenance at predetermined time intervals;
- maintenance based on units of use.

Important: the exact legacy numeric frequency values in the binary `.xls` source are retained as source evidence but are not guessed when not structurally extracted. MSL-G01 permits unresolved source ambiguity provided it is recorded rather than invented.

## 3. Cross-source consistency

The same source pattern repeats across multiple equipment classes:

- Pumps;
- Compressors;
- Gas Turbine;
- Electric Generator;
- Fire & Gas;
- Safety Valves;
- Transmitters;
- Valves;
- Pressure Vessels;
- Air Coolers / Filters / Heat Exchangers / Motors depending on unit.

This is sufficient evidence that the pattern is not a one-off spreadsheet structure.

## 4. Normalization mapping

| Source concept | CMMS canonical concept |
|---|---|
| Equipment tag | Asset reference |
| Job Plan Number | JobPlan + JobPlanRevision identity |
| Job Plan Description | JobPlanRevision title/description |
| Job Plan total duration | planned duration |
| Operation Number | JobPlanOperation sequence |
| Operation description/detail | JobPlanOperation instruction |
| Labor/Craft | ResourceRequirement |
| Tool | ToolRequirement |
| Item Code | MaterialRequirement when populated |
| PM + asset + Job Plan association | Project Maintenance Activity / plan binding |
| Frequency / unit / interval | MaintenanceTriggerPolicy + TriggerRule |
| Sequence flag | PM/trigger scheduling metadata, not Job Plan instruction |

## 5. Decisions supported by evidence

1. **Frequency does not belong inside JobPlan.** It lives in the PM/plan association layer.
2. **JobPlan is reusable execution knowledge.** It contains ordered operations and planned resources/tools.
3. **Operations are not independent MaintenanceActivities by default.** They are execution steps within JobPlan.
4. **Asset binding and JobPlan are separate concepts.** Historical files bind them, but the canonical model must avoid cloning reusable JobPlan content per asset.
5. **Resources/tools/materials need their own child contracts.** They are not free-text notes.
6. **Provenance must preserve source document, appendix, unit and source Job Plan/PM identifiers.**

## 6. Ambiguities recorded

- Legacy Job Plan codes encode information (`MO-6`, `AN-1`, `AN-3`) but CMMS must not infer semantics solely from code syntax.
- Exact frequency values from binary `.xls` must be imported/validated by an ingestion path capable of preserving the original fields.
- Some source resource/tool rows do not populate duration/quantity completely.
- Material sheets may be empty for some Job Plans.
- Historical source is asset-specific in places; corporate reuse must be normalized without losing provenance.

## 7. Gate result

`MSL-G01 — Source Normalization = PASS_WITH_RECORDED_AMBIGUITIES`.

The evidence is real, repeatable across units/equipment classes and sufficient to design MSL-G02 without creating synthetic maintenance knowledge.