#!/usr/bin/env python3
"""Local validator for the CMMS Functional Lab v2 fixture.

Runs without GitHub Actions and therefore consumes no CI minutes.
With jsonschema installed it also validates the four layer schemas.
The referential-integrity checks use only the Python standard library.
"""

from __future__ import annotations

import json
import sys
from pathlib import Path
from typing import Any, Iterable


LAB_ROOT = Path(__file__).resolve().parents[2]
CONTRACTS = LAB_ROOT / "contracts"
FIXTURE = LAB_ROOT / "cases" / "P101" / "p101-case.v2.json"


class ValidationError(Exception):
    pass


def load_json(path: Path) -> dict[str, Any]:
    try:
        return json.loads(path.read_text(encoding="utf-8"))
    except FileNotFoundError as exc:
        raise ValidationError(f"Missing file: {path}") from exc
    except json.JSONDecodeError as exc:
        raise ValidationError(
            f"Invalid JSON in {path}: line {exc.lineno}, column {exc.colno}: {exc.msg}"
        ) from exc


def require(condition: bool, message: str, errors: list[str]) -> None:
    if not condition:
        errors.append(message)


def ids(items: Iterable[dict[str, Any]], key: str) -> set[str]:
    values: list[str] = []
    for item in items:
        value = item.get(key)
        if isinstance(value, str) and value:
            values.append(value)
    return set(values)


def check_unique(items: list[dict[str, Any]], key: str, errors: list[str]) -> set[str]:
    values = [item.get(key) for item in items]
    missing = [index for index, value in enumerate(values) if not isinstance(value, str) or not value]
    for index in missing:
        errors.append(f"Missing {key} at index {index}")
    present = [value for value in values if isinstance(value, str) and value]
    if len(present) != len(set(present)):
        errors.append(f"Duplicate values detected for {key}")
    return set(present)


def optional_schema_validation(fixture: dict[str, Any], errors: list[str], notes: list[str]) -> None:
    try:
        from jsonschema import Draft202012Validator
    except ImportError:
        notes.append("jsonschema not installed: structural schema validation skipped")
        return

    sections = [
        ("engineeringLibrary", "fmea-library.schema.json"),
        ("assetApplication", "fmea-asset-application.schema.json"),
        ("executionPlan", "execution-plan.schema.json"),
        ("results", "maintenance-results.schema.json"),
    ]

    for section_name, schema_name in sections:
        schema = load_json(CONTRACTS / schema_name)
        validator = Draft202012Validator(schema)
        section_errors = sorted(
            validator.iter_errors(fixture.get(section_name)),
            key=lambda error: list(error.absolute_path),
        )
        for error in section_errors:
            path = ".".join(str(part) for part in error.absolute_path) or "<root>"
            errors.append(f"Schema {schema_name} [{path}]: {error.message}")

    notes.append("Four layer schemas validated with Draft 2020-12")


def validate(fixture: dict[str, Any]) -> tuple[list[str], list[str]]:
    errors: list[str] = []
    notes: list[str] = []

    require(str(fixture.get("fixtureVersion", "")).startswith("2."), "fixtureVersion must be 2.x", errors)

    for section in ("engineeringLibrary", "assetApplication", "executionPlan", "results", "traceability"):
        require(section in fixture, f"Missing top-level section: {section}", errors)

    library = fixture.get("engineeringLibrary") or {}
    application = fixture.get("assetApplication") or {}
    plan = fixture.get("executionPlan") or {}
    results = fixture.get("results") or {}

    definition = library.get("fmeaDefinition") or {}
    revision = library.get("fmeaRevision") or {}
    definition_id = definition.get("fmeaDefinitionId")
    revision_id = revision.get("fmeaRevisionId")

    require(bool(definition_id), "Missing FmeaDefinition identity", errors)
    require(bool(revision_id), "Missing FmeaRevision identity", errors)
    require(
        revision.get("fmeaDefinitionId") == definition_id,
        "FmeaRevision does not reference the active FmeaDefinition",
        errors,
    )

    functions = library.get("functions") or []
    failures = library.get("functionalFailures") or []
    modes = library.get("failureModes") or []
    causes = library.get("failureCauses") or []
    effects = library.get("failureEffects") or []
    consequences = library.get("consequenceAssessments") or []
    rcm = library.get("rcmAssessments") or []
    tasks = library.get("maintenanceTasks") or []
    links = library.get("taskFailureModeLinks") or []
    procedures = library.get("maintenanceProcedures") or []
    formats = library.get("inspectionFormats") or []
    no_task = library.get("noScheduledTaskDecisions") or []
    econ = library.get("economicAssessments") or []
    estimates = library.get("maintenanceCostEstimates") or []

    function_ids = check_unique(functions, "fmeaFunctionId", errors)
    failure_ids = check_unique(failures, "functionalFailureId", errors)
    mode_ids = check_unique(modes, "failureModeId", errors)
    check_unique(causes, "failureCauseId", errors)
    check_unique(effects, "failureEffectId", errors)
    consequence_ids = check_unique(consequences, "consequenceAssessmentId", errors)
    rcm_ids = check_unique(rcm, "rcmAssessmentId", errors)
    task_ids = check_unique(tasks, "maintenanceTaskId", errors)
    check_unique(links, "maintenanceTaskFailureModeId", errors)
    procedure_ids = check_unique(procedures, "maintenanceProcedureId", errors)
    format_ids = check_unique(formats, "inspectionFormatId", errors)
    check_unique(no_task, "noScheduledTaskDecisionId", errors)
    check_unique(econ, "economicAssessmentId", errors)
    estimate_ids = check_unique(estimates, "maintenanceCostEstimateId", errors)

    for item in functions:
        require(item.get("fmeaRevisionId") == revision_id, f"Function {item.get('fmeaFunctionId')} references another revision", errors)
    for item in failures:
        require(item.get("fmeaFunctionId") in function_ids, f"FunctionalFailure {item.get('functionalFailureId')} has unknown function", errors)
    for item in modes:
        require(item.get("functionalFailureId") in failure_ids, f"FailureMode {item.get('failureModeId')} has unknown functional failure", errors)
    for item in causes:
        require(item.get("failureModeId") in mode_ids, f"FailureCause {item.get('failureCauseId')} has unknown mode", errors)
    for item in effects:
        require(item.get("failureModeId") in mode_ids, f"FailureEffect {item.get('failureEffectId')} has unknown mode", errors)
    for item in consequences:
        require(item.get("failureModeId") in mode_ids, f"ConsequenceAssessment {item.get('consequenceAssessmentId')} has unknown mode", errors)
    for item in rcm:
        require(item.get("failureModeId") in mode_ids, f"RcmAssessment {item.get('rcmAssessmentId')} has unknown mode", errors)
        consequence_ref = item.get("consequenceAssessmentId")
        if consequence_ref:
            require(consequence_ref in consequence_ids, f"RcmAssessment {item.get('rcmAssessmentId')} has unknown consequence assessment", errors)
    for item in tasks:
        require(item.get("fmeaRevisionId") == revision_id, f"MaintenanceTask {item.get('maintenanceTaskId')} references another revision", errors)
        procedure_ref = item.get("procedureRef")
        format_ref = item.get("inspectionFormatRef")
        if procedure_ref:
            require(procedure_ref in procedure_ids, f"MaintenanceTask {item.get('maintenanceTaskId')} has unknown procedure", errors)
        if format_ref:
            require(format_ref in format_ids, f"MaintenanceTask {item.get('maintenanceTaskId')} has unknown inspection format", errors)
    for item in links:
        require(item.get("maintenanceTaskId") in task_ids, f"Task-mode link {item.get('maintenanceTaskFailureModeId')} has unknown task", errors)
        require(item.get("failureModeId") in mode_ids, f"Task-mode link {item.get('maintenanceTaskFailureModeId')} has unknown mode", errors)
    for item in no_task:
        require(item.get("fmeaRevisionId") == revision_id, f"NoScheduledTaskDecision {item.get('noScheduledTaskDecisionId')} references another revision", errors)
        require(item.get("failureModeId") in mode_ids, f"NoScheduledTaskDecision {item.get('noScheduledTaskDecisionId')} has unknown mode", errors)
        rcm_ref = item.get("rcmAssessmentId")
        if rcm_ref:
            require(rcm_ref in rcm_ids, f"NoScheduledTaskDecision {item.get('noScheduledTaskDecisionId')} has unknown RCM assessment", errors)
    for item in econ:
        require(item.get("fmeaRevisionId") == revision_id, f"EconomicAssessment {item.get('economicAssessmentId')} references another revision", errors)
        scope_ref = item.get("scopeRef")
        if scope_ref:
            require(scope_ref in rcm_ids or scope_ref in task_ids, f"EconomicAssessment {item.get('economicAssessmentId')} has unknown scopeRef", errors)
        with_policy = item.get("scenarioWithPolicy") or {}
        estimate_ref = with_policy.get("maintenanceCostEstimateRef")
        if estimate_ref:
            require(estimate_ref in estimate_ids, f"EconomicAssessment {item.get('economicAssessmentId')} has unknown maintenance cost estimate", errors)
    for item in estimates:
        if item.get("scopeType") == "maintenance_task":
            require(item.get("scopeId") in task_ids, f"MaintenanceCostEstimate {item.get('maintenanceCostEstimateId')} has unknown task scope", errors)

    application_id = application.get("fmeaAssetApplicationId")
    require(application.get("fmeaRevisionId") == revision_id, "FmeaAssetApplication references another revision", errors)
    require(bool((application.get("asset") or {}).get("assetId")), "Asset Application has no asset identity", errors)
    require(bool(application.get("operationalContextSnapshot")), "Asset Application has no operational context snapshot", errors)
    require(bool(application.get("assetCriticalitySnapshot")), "Asset Application has no asset criticality snapshot", errors)
    for item in application.get("applicabilityDecisions") or []:
        require(item.get("maintenanceTaskId") in task_ids, f"Applicability decision has unknown task {item.get('maintenanceTaskId')}", errors)

    execution_plan_id = plan.get("executionPlanId")
    require(plan.get("fmeaAssetApplicationId") == application_id, "ExecutionPlan references another Asset Application", errors)
    execution_task_ids = check_unique(plan.get("tasks") or [], "executionPlanTaskId", errors)
    for item in plan.get("tasks") or []:
        require(item.get("maintenanceTaskId") in task_ids, f"ExecutionPlanTask {item.get('executionPlanTaskId')} has unknown maintenance task", errors)
        procedure_ref = item.get("procedureRef")
        format_ref = item.get("inspectionFormatRef")
        if procedure_ref:
            require(procedure_ref in procedure_ids, f"ExecutionPlanTask {item.get('executionPlanTaskId')} has unknown procedure", errors)
        if format_ref:
            require(format_ref in format_ids, f"ExecutionPlanTask {item.get('executionPlanTaskId')} has unknown inspection format", errors)

    maintenance_results = results.get("maintenanceResults") or []
    actual_costs = results.get("actualMaintenanceCosts") or []
    reviews = results.get("effectivenessReviews") or []
    result_ids = check_unique(maintenance_results, "maintenanceResultId", errors)
    check_unique(actual_costs, "actualMaintenanceCostId", errors)
    check_unique(reviews, "effectivenessReviewId", errors)

    for item in maintenance_results:
        require(item.get("executionPlanTaskId") in execution_task_ids, f"MaintenanceResult {item.get('maintenanceResultId')} has unknown ExecutionPlanTask", errors)
    for item in actual_costs:
        require(item.get("maintenanceResultId") in result_ids, f"ActualMaintenanceCost {item.get('actualMaintenanceCostId')} has unknown result", errors)
    for item in reviews:
        require(item.get("fmeaAssetApplicationId") == application_id, f"EffectivenessReview {item.get('effectivenessReviewId')} references another application", errors)

    # Explicit model separation checks.
    risk_blob = json.dumps(consequences, ensure_ascii=False).lower()
    require("assetcriticality" not in risk_blob and "asset_criticality" not in risk_blob, "ConsequenceAssessment contains AssetCriticality terminology", errors)
    require(bool(application.get("assetCriticalitySnapshot")), "Asset criticality must exist only in Asset Application context", errors)

    # Demonstrate N:M rather than an accidental one-to-one shape.
    modes_per_task: dict[str, set[str]] = {}
    tasks_per_mode: dict[str, set[str]] = {}
    for link in links:
        modes_per_task.setdefault(link.get("maintenanceTaskId"), set()).add(link.get("failureModeId"))
        tasks_per_mode.setdefault(link.get("failureModeId"), set()).add(link.get("maintenanceTaskId"))
    require(any(len(value) > 1 for value in modes_per_task.values()), "Fixture does not demonstrate one task treating multiple failure modes", errors)
    require(any(len(value) > 1 for value in tasks_per_mode.values()), "Fixture does not demonstrate one failure mode with multiple tasks", errors)

    # Exercise both RCM branches.
    require(bool(tasks), "Fixture must demonstrate an RCM branch that produces a task", errors)
    require(bool(no_task), "Fixture must demonstrate an explicit no-scheduled-task branch", errors)

    # Traceability references: verify known IDs when types are recognized.
    known_by_type = {
        "FmeaDefinition": {definition_id} if definition_id else set(),
        "FmeaRevision": {revision_id} if revision_id else set(),
        "FailureMode": mode_ids,
        "RcmAssessment": rcm_ids,
        "MaintenanceTask": task_ids,
        "NoScheduledTaskDecision": ids(no_task, "noScheduledTaskDecisionId"),
        "FmeaAssetApplication": {application_id} if application_id else set(),
        "ExecutionPlan": {execution_plan_id} if execution_plan_id else set(),
        "ExecutionPlanTask": execution_task_ids,
        "MaintenanceResult": result_ids,
        "ActualMaintenanceCost": ids(actual_costs, "actualMaintenanceCostId"),
        "EffectivenessReview": ids(reviews, "effectivenessReviewId"),
    }
    all_known_ids = set().union(*known_by_type.values())
    for node in (fixture.get("traceability") or {}).get("lineage") or []:
        object_type = node.get("objectType")
        object_id = node.get("objectId")
        source_id = node.get("sourceObjectId")
        if object_type in known_by_type:
            require(object_id in known_by_type[object_type], f"Trace node {object_type}/{object_id} does not exist", errors)
        if source_id:
            require(source_id in all_known_ids, f"Trace node {object_type}/{object_id} has unknown sourceObjectId {source_id}", errors)

    optional_schema_validation(fixture, errors, notes)
    return errors, notes


def main() -> int:
    try:
        fixture = load_json(FIXTURE)
        errors, notes = validate(fixture)
    except ValidationError as exc:
        print(f"FAIL: {exc}")
        return 1

    print(f"Fixture: {FIXTURE}")
    for note in notes:
        print(f"NOTE: {note}")

    if errors:
        print(f"FAIL: {len(errors)} issue(s)")
        for error in errors:
            print(f" - {error}")
        return 1

    print("PASS: JSON syntax and referential/domain consistency checks completed")
    return 0


if __name__ == "__main__":
    sys.exit(main())
