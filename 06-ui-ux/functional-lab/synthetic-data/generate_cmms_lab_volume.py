#!/usr/bin/env python3
"""Generate deterministic, linked synthetic CMMS Lab data profiles.

The data is demonstration-only. It does not create an approved maintenance
standard, real user, production asset, or corporate inventory record.
"""

from __future__ import annotations

import argparse
import json
from datetime import date, datetime, timedelta, timezone
from pathlib import Path


PROFILES = {
    "functional": {"assets": 250, "measurement_readings_per_case": 8},
    "load": {"assets": 2000, "measurement_readings_per_case": 24},
}

EQUIPMENT_TYPES = [
    ("PUMP_CENTRIFUGAL_HORIZONTAL", "PUMP"),
    ("COMPRESSOR_RECIPROCATING", "COMPRESSOR"),
    ("PRESSURE_SAFETY_VALVE", "PSV"),
    ("HEAT_EXCHANGER_SHELL_TUBE", "HX"),
    ("ELECTRIC_MOTOR", "MOTOR"),
]

SOURCE_BASES = ["RCM", "CORPORATE_STANDARD_REFERENCE", "OEM", "EXPERT"]


def stable(prefix: str, number: int, width: int = 6) -> str:
    return f"{prefix}-{number:0{width}d}"


def due_date(quarter: int) -> str:
    return ["2026-03-15", "2026-06-15", "2026-09-15", "2026-12-15"][quarter]


def generate(profile: str) -> dict:
    cfg = PROFILES[profile]
    n = cfg["assets"]
    assets, plans, sources = [], [], []
    work_orders, condition_cases, observations, events, requests = [], [], [], [], []
    execution_records, actuals, occurrences, crews = [], [], [], []
    findings, follow_ups, permits, material_requirements = [], [], [], []
    recurrence_adjustments = []

    for crew_ix, discipline in enumerate(["MECHANICAL", "ELECTRICAL", "INSTRUMENT"], 1):
        crews.append({
            "crewId": stable("SYN-CREW", crew_ix),
            "discipline": discipline,
            "availability": "DEMO_AVAILABLE",
            "authority": "SYNTHETIC_ONLY",
        })

    for i in range(1, n + 1):
        equipment_type, prefix = EQUIPMENT_TYPES[(i - 1) % len(EQUIPMENT_TYPES)]
        asset_id = stable("SYN-ASSET", i)
        asset_code = f"{prefix}-{i:04d}"
        source_id = stable("SYN-SOURCE", i)
        plan_id = stable("SYN-PLAN", i)
        source_basis = SOURCE_BASES[(i - 1) % len(SOURCE_BASES)]
        source_status = "DEMO_REFERENCE_ONLY"
        assets.append({
            "assetId": asset_id,
            "assetCode": asset_code,
            "description": f"Synthetic {equipment_type.replace('_', ' ').lower()} {i:04d}",
            "equipmentTypeCode": equipment_type,
            "locationPath": ["Synthetic Plant", f"Area-{((i - 1) // 50) + 1:02d}", asset_code],
            "criticality": ["A", "B", "C"][(i - 1) % 3],
            "sourceStatus": "SYNTHETIC_FIXTURE_ONLY",
        })
        sources.append({
            "sourceId": source_id,
            "sourceBasis": source_basis,
            "reference": f"DEMO-SOURCE-{i:04d}",
            "version": "DEMO-1",
            "status": source_status,
            "corporateMasterData": False,
        })
        plans.append({
            "planVersionId": plan_id,
            "assetId": asset_id,
            "sourceId": source_id,
            "strategy": "CONDITION_BASED" if i % 5 == 0 else "TIME_BASED",
            "status": "PUBLISHED_DEMO",
            "effectiveFrom": "2026-01-01",
            "demoOnly": True,
        })

        # A single annual parent order contains four independent visit records.
        if i % 4 == 0:
            wo_id = stable("SYN-WO-ANNUAL", i)
            visits = []
            for q in range(4):
                visit_no = (i * 10) + q + 1
                visit_id = stable("SYN-VISIT", visit_no)
                visit_state = ["COMPLETED", "COMPLETED_WITH_DEVIATION", "SCHEDULED", "PLANNED"][q]
                visit = {
                    "visitId": visit_id,
                    "visitKey": f"CYCLE-2026-Q{q + 1}",
                    "plannedDueAt": due_date(q),
                    "displayState": visit_state,
                    "maintenanceOccurrenceId": stable("SYN-OCC", visit_no) if q < 3 else None,
                    "crewId": stable("SYN-CREW", ((i + q) % 3) + 1) if q in (1, 2) else None,
                }
                occurrences.append({
                        "maintenanceOccurrenceId": visit["maintenanceOccurrenceId"],
                        "workOrderVisitId": visit_id,
                        "assetId": asset_id,
                        "episodeKey": f"{plan_id}:2026:Q{q + 1}",
                        "dueAt": due_date(q),
                        "status": "FULFILLED" if q < 2 else "RELEASED" if q == 2 else "PLANNED",
                    })
                if q < 2:
                    exec_id = stable("SYN-EXEC", visit_no)
                    visit["executionRecordId"] = exec_id
                    month, day = [("03", "14"), ("06", "16")][q]
                    visit["actualStartAt"] = f"2026-{month}-{day}T07:00:00Z"
                    visit["actualFinishAt"] = f"2026-{month}-{day}T09:10:00Z"
                    visit["result"] = "COMPLETED_AS_PLANNED" if q == 0 else "COMPLETED_WITH_DEVIATION"
                    execution_records.append({
                        "executionRecordId": exec_id,
                        "workOrderVisitId": visit_id,
                        "workOrderId": wo_id,
                        "actualStartAt": visit["actualStartAt"],
                        "actualFinishAt": visit["actualFinishAt"],
                        "result": visit["result"],
                        "performedByReference": stable("SYN-ACTOR", (i % 7) + 1),
                    })
                    actuals.append({
                        "executionRecordId": exec_id,
                        "laborHours": round(1.5 + ((i + q) % 5) * 0.25, 2),
                        "materialActuals": [],
                        "inventoryAuthority": "NOT_CONNECTED",
                    })
                    finding_id = stable("SYN-FINDING", visit_no)
                    visit["findingId"] = finding_id
                    findings.append({
                        "findingId": finding_id,
                        "executionRecordId": exec_id,
                        "findingType": "DEMO_INSPECTION_FINDING" if q == 1 else "NO_ADVERSE_FINDING",
                        "disposition": "FOLLOW_UP_RECOMMENDED" if q == 1 else "NO_FOLLOW_UP",
                        "syntheticOnly": True,
                    })
                    if q == 1:
                        follow_ups.append({
                            "followUpId": stable("SYN-FOLLOWUP", visit_no),
                            "findingId": finding_id,
                            "decision": "PLANNER_REVIEW_REQUIRED",
                            "automaticWorkOrder": False,
                        })
                    permit_id = stable("SYN-PERMIT", visit_no)
                    visit["permitRequirementId"] = permit_id
                    permits.append({
                        "permitRequirementId": permit_id,
                        "workOrderVisitId": visit_id,
                        "permitType": "DEMO_HOT_WORK" if q == 1 else "DEMO_GENERAL_WORK",
                        "status": "REFERENCE_ONLY_NOT_ISSUED",
                        "externalAuthority": "NOT_CONNECTED",
                    })
                    material_requirements.append({
                        "workOrderVisitId": visit_id,
                        "materialCode": f"DEMO-SEAL-{prefix}",
                        "quantity": 1,
                        "reservationStatus": "NOT_CONNECTED",
                        "inventoryAuthority": "EXTERNAL_SYSTEM",
                    })
                visits.append(visit)
            work_orders.append({
                "workOrderId": wo_id,
                "workOrderNo": f"LAB-PM-2026-{i:05d}",
                "type": "PREVENTIVE_ANNUAL",
                "assetId": asset_id,
                "planVersionId": plan_id,
                "cycleKey": "CYCLE-2026",
                "displayState": "IN_PROGRESS_DEMO",
                "visits": visits,
                "annualClosePolicy": "OPEN_DECISION",
            })

        # Condition data are independent from annual visit cadence.
        if i % 5 == 0:
            point_id = stable("SYN-MP", i)
            readings = []
            count = cfg["measurement_readings_per_case"]
            start = date(2026, 1, 1)
            for r_ix in range(count):
                value = round(2.8 + (r_ix * 0.27) + ((i % 7) * 0.05), 2)
                measured = start + timedelta(days=r_ix * 14)
                readings.append({
                    "readingId": stable("SYN-READ", i * 100 + r_ix + 1),
                    "measurementPointId": point_id,
                    "measuredAt": measured.isoformat() + "T08:00:00Z",
                    "value": value,
                    "unit": "mm/s RMS",
                    "condition": "ACTION" if value >= 6.5 else "WARNING" if value >= 5.0 else "NORMAL",
                })
            recommendation = None
            if readings[-1]["value"] >= 6.5:
                recommendation = {
                    "recommendationId": stable("SYN-REC", i),
                    "evidenceReadingId": readings[-1]["readingId"],
                    "technicalAction": "Review trend and recommend inspection if justified.",
                    "plannerCreatesWorkOrder": True,
                    "autoCreatedFromThreshold": False,
                }
            condition_cases.append({
                "scenarioId": stable("SCN-CBM", i),
                "assetId": asset_id,
                "measurementPointId": point_id,
                "thresholdProfile": "DEMO_ONLY",
                "readings": readings,
                "recommendation": recommendation,
            })

        # Operator observation/event/request/corrective work branch.
        if i % 7 == 0:
            obs_id = stable("SYN-OBS", i)
            event_id = stable("SYN-EVENT", i)
            request_id = stable("SYN-REQUEST", i)
            observations.append({
                "observationId": obs_id,
                "assetId": asset_id,
                "observedAt": f"2026-10-{(i % 27) + 1:02d}T06:45:00Z",
                "shiftId": stable("SYN-SHIFT", (i % 3) + 1),
                "text": "Synthetic operator observation requiring assessment.",
                "classification": "OBSERVATION_ONLY",
            })
            events.append({
                "eventId": event_id,
                "observationId": obs_id,
                "assetId": asset_id,
                "category": "EQUIPMENT_CONDITION",
                "severity": "DEMO_MEDIUM",
                "status": "OPEN_DEMO",
            })
            request = {"requestId": request_id, "eventId": event_id, "assetId": asset_id, "status": "ASSESSED_DEMO"}
            if i % 2 == 0:
                wo_id = stable("SYN-WO-CORR", i)
                visit_id = stable("SYN-VISIT-CORR", i)
                exec_id = stable("SYN-EXEC-CORR", i)
                major_repair = i % 14 == 0 and i % 5 != 0
                request["workOrderId"] = wo_id
                work_orders.append({
                    "workOrderId": wo_id,
                    "workOrderNo": f"LAB-CM-2026-{i:05d}",
                    "type": "CORRECTIVE",
                    "repairScopeCode": "MAJOR_REPAIR_DEMO" if major_repair else "ROUTINE_REPAIR_DEMO",
                    "assetId": asset_id,
                    "sourceRequestId": request_id,
                    "displayState": "TECHNICALLY_CLOSED_DEMO",
                    "visits": [{
                        "visitId": visit_id,
                        "visitKey": "SINGLE-EXECUTION",
                        "displayState": "COMPLETED_WITH_DEVIATION",
                        "executionRecordId": exec_id,
                    }],
                })
                execution_records.append({
                    "executionRecordId": exec_id,
                    "workOrderVisitId": visit_id,
                    "workOrderId": wo_id,
                    "actualStartAt": "2026-10-12T07:00:00Z",
                    "actualFinishAt": "2026-10-12T10:15:00Z",
                    "result": "COMPLETED_WITH_DEVIATION",
                })
                actuals.append({"executionRecordId": exec_id, "laborHours": 3.25, "materialActuals": [], "inventoryAuthority": "NOT_CONNECTED"})
                findings.append({
                    "findingId": stable("SYN-FINDING-CORR", i),
                    "executionRecordId": exec_id,
                    "findingType": "DEMO_COMPONENT_WEAR",
                    "disposition": "FOLLOW_UP_RECOMMENDED",
                    "syntheticOnly": True,
                })
                follow_ups.append({
                    "followUpId": stable("SYN-FOLLOWUP-CORR", i),
                    "findingId": stable("SYN-FINDING-CORR", i),
                    "decision": "PLANNER_REVIEW_REQUIRED",
                    "automaticWorkOrder": False,
                })
                if major_repair:
                    recurrence_adjustments.append({
                        "adjustmentId": stable("SYN-REC-RESET", i),
                        "workOrderId": wo_id,
                        "executionRecordId": exec_id,
                        "planVersionId": plan_id,
                        "effectiveAt": "2026-10-12T10:15:00Z",
                        "affectedCadence": "TIME_BASED_ONLY",
                        "previousNextDueAt": "2026-12-15",
                        "recalculatedNextDueAt": "2027-01-10",
                        "conditionMonitoringCadenceChanged": False,
                        "authorityState": "DEMO_ONLY_REQUIRES_APPROVED_SCOPE_RULE",
                    })
                permits.append({
                    "permitRequirementId": stable("SYN-PERMIT-CORR", i),
                    "workOrderVisitId": visit_id,
                    "permitType": "DEMO_GENERAL_WORK",
                    "status": "REFERENCE_ONLY_NOT_ISSUED",
                    "externalAuthority": "NOT_CONNECTED",
                })
            requests.append(request)

    data = {
        "datasetVersion": "1.0.0",
        "datasetId": f"CMMS-LAB-SYNTH-{profile.upper()}-V1",
        "profile": profile,
        "generatedAt": "2026-10-30T00:00:00Z",
        "generatorSeed": 3102026,
        "status": "SYNTHETIC_FIXTURE_ONLY",
        "disclaimer": "All values are synthetic. Thresholds, statuses, roles, availability and references are illustrative and are not approved operating rules.",
        "records": {
            "assets": assets,
            "sources": sources,
            "planVersions": plans,
            "workOrders": work_orders,
            "maintenanceOccurrences": occurrences,
            "conditionCases": condition_cases,
            "observations": observations,
            "events": events,
            "correctiveRequests": requests,
            "executionRecords": execution_records,
            "actuals": actuals,
            "crews": crews,
            "findings": findings,
            "followUps": follow_ups,
            "permitRequirements": permits,
            "materialRequirements": material_requirements,
            "recurrenceAdjustments": recurrence_adjustments,
        },
        "openDecisions": {
            "yearEndVisitDisposition": ["KEEP_OPEN", "TRANSFER_TO_NEXT_CYCLE", "REQUIRE_NEW_ORDER"],
            "sourceOfInventory": None,
            "permitBoundary": "requirements/status/reference only until confirmed",
            "roleAuthority": "not assigned to named people",
        },
        "generationSummary": {
            "assetCount": len(assets),
            "annualOrderCount": sum(1 for w in work_orders if w["type"] == "PREVENTIVE_ANNUAL"),
            "visitCount": sum(len(w["visits"]) for w in work_orders),
            "conditionCaseCount": len(condition_cases),
            "measurementReadingCount": sum(len(c["readings"]) for c in condition_cases),
            "observationCount": len(observations),
            "eventCount": len(events),
            "correctiveWorkOrderCount": sum(1 for w in work_orders if w["type"] == "CORRECTIVE"),
            "executionRecordCount": len(execution_records),
            "majorRepairFrequencyResetExampleCount": len(recurrence_adjustments),
        },
    }

    asset_ids = {x["assetId"] for x in assets}
    plan_ids = {x["planVersionId"] for x in plans}
    work_ids = {x["workOrderId"] for x in work_orders}
    visit_ids = {v["visitId"] for w in work_orders for v in w["visits"]}
    assert len(asset_ids) == len(assets)
    assert all(p["assetId"] in asset_ids and p["sourceId"] in {s["sourceId"] for s in sources} for p in plans)
    assert all(w["assetId"] in asset_ids and ("planVersionId" not in w or w["planVersionId"] in plan_ids) for w in work_orders)
    assert all(e["workOrderId"] in work_ids and e["workOrderVisitId"] in visit_ids for e in execution_records)
    assert all(a["executionRecordId"] in {e["executionRecordId"] for e in execution_records} for a in actuals)
    assert all(event["observationId"] in {o["observationId"] for o in observations} for event in events)
    finding_ids = {f["findingId"] for f in findings}
    assert all(f["executionRecordId"] in {e["executionRecordId"] for e in execution_records} for f in findings)
    assert all(f["findingId"] in finding_ids for f in follow_ups)
    assert all(p["workOrderVisitId"] in visit_ids for p in permits)
    assert all(m["workOrderVisitId"] in visit_ids for m in material_requirements)
    assert all(a["workOrderId"] in work_ids and a["executionRecordId"] in {e["executionRecordId"] for e in execution_records} and a["planVersionId"] in plan_ids for a in recurrence_adjustments)
    return data


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--profile", choices=sorted(PROFILES), default="functional")
    parser.add_argument("--output", default="cmms-lab-synthetic-data.json")
    args = parser.parse_args()
    data = generate(args.profile)
    Path(args.output).write_text(json.dumps(data, ensure_ascii=False, separators=(",", ":")) + "\n", encoding="utf-8")
    print(json.dumps(data["generationSummary"], ensure_ascii=False))


if __name__ == "__main__":
    main()
