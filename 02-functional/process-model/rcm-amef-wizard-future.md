# Future Capability — RCM / AMEF Engineering Wizard

**Fecha:** 2026-09-11  
**Estado:** `FUTURE / NOT_ACTIVE`  
**Relación:** Maintenance Engineering / Maintenance Standards Library  
**No forma parte de:** MSL-G01, MSL-G02 ni del primer incremento Power Apps

## 1. Decisión funcional

AMEF/FMEA no debe implementarse como una pantalla aislada basada en cuestionarios ni como puerta de entrada obligatoria para crear todos los planes de mantenimiento.

AMEF forma parte de la ruta RCM cuando un equipo, contexto o riesgo requieren ingeniería específica.

La ruta principal del producto se apoya en conocimiento reutilizable:

```text
Equipment Type
→ Corporate Maintenance Standard
→ Project Adoption / Tailoring
→ Project Maintenance Plan
→ Work Management
```

La ruta RCM/AMEF actúa como profundización de ingeniería:

```text
Equipment / Operating Context
→ RCM / AMEF Wizard
→ Maintenance Recommendation
→ Project Maintenance Plan
→ Execution / Experience
→ Corporate Change Proposal
→ Corporate Review
→ Maintenance Standards Master vNext
```

## 2. Regla de gobernanza

El wizard **no escribe directamente en el Maintenance Standards Master**.

Su salida inmediata es una propuesta/recomendación estructurada para el plan de mantenimiento del proyecto.

Una conclusión RCM solo puede convertirse en conocimiento corporativo reutilizable mediante un proceso gobernado:

```text
RCM Result
→ Project Maintenance Activity
→ Project Validation / Operating Experience
→ Corporate Change Proposal
→ Review / Approval
→ New StandardPlanVersion
```

Motivo: una frecuencia, estrategia o actividad válida para un activo concreto puede depender de servicio, fluido, criticidad, ambiente, diseño o filosofía del cliente y no debe propagarse automáticamente a todos los equipos del mismo tipo.

## 3. Propósito del wizard

El wizard no pretende 'rellenar un AMEF'.

Debe guiar el razonamiento de ingeniería hasta responder:

> ¿Qué mantenimiento debemos realizar, por qué y bajo qué condiciones?

Flujo conceptual:

```text
Function
→ Functional Failure
→ Failure Mode
→ Effect / Consequence
→ Risk / Criticality Context
→ Detectability / P-F when applicable
→ Maintenance Decision
→ Maintenance Recommendation
```

## 4. Salida estructurada esperada

Una salida candidata del wizard debe poder expresar:

```text
MaintenanceRecommendation
  equipmentTypeRef
  assetRef?
  operatingContextRef?
  functionRef
  functionalFailureRef
  failureModeRef
  effectRef?
  consequenceRef?
  maintenanceStrategy
  maintenanceActivity
  frequencyOrConditionTrigger?
  applicabilityConditions?
  jobPlanRef?
  procedureChecklistRef?
  resourceRequirements?
  toolsMaterialsRequirements?
  engineeringJustification
  sourceBasis = RCM
  provenance
```

Estos campos son conceptuales y no constituyen todavía contrato SQL/API.

## 5. Integración futura con Maintenance Standards Library

MSL-G02 debe evitar un diseño que impida futuras entradas procedentes de RCM.

Por ello, el modelo maestro debería poder soportar, cuando se cierre su contrato:

- `sourceBasis`;
- provenance;
- `failureMode` o referencia técnica equivalente cuando exista;
- engineering justification;
- applicability / operating-context assumptions;
- variant handling;
- project-specific overrides;
- version lineage.

No todas las actividades corporativas tendrán un AMEF/RCM detrás. Una actividad puede proceder de:

```text
OEM / Vendor
Historical Maintenance Plan
Corporate Experience
Specialist Engineering
RCM Analysis
```

La fuente debe quedar trazada sin imponer una única vía de origen.

## 6. Principio de experiencia de usuario

No diseñar el wizard como una sucesión de formularios académicos o cuestionarios de scoring.

La experiencia futura debe conducir decisiones de ingeniería, por ejemplo:

```text
What function must the equipment perform?
→ How can that function be lost or degraded?
→ What can cause it?
→ What happens if it occurs?
→ Is intervention justified?
→ Can degradation be detected before functional failure?
→ Is there a technically effective task?
→ Which maintenance strategy is appropriate?
```

El riesgo y la criticidad seguirán las reglas configurables del producto; no se hardcodeará un scoring AMEF universal.

## 7. Posición en la arquitectura funcional

```text
                    MAINTENANCE ENGINEERING

                  Equipment / Equipment Type
                            │
              ┌─────────────┴─────────────┐
              ↓                           ↓
   Maintenance Standards           RCM / AMEF Engineering
       reusable baseline             specific engineering
              │                           │
              └─────────────┬─────────────┘
                            ↓
                Project Maintenance Plan
                            ↓
                       Work Management
                            ↓
                         Execution
                            ↓
                         Learning
                            ↓
                  Corporate Governance
                            ↓
               Maintenance Standards vNext
```

## 8. Condiciones para activar este desarrollo

No iniciar implementación Power Apps del wizard hasta que, como mínimo:

1. MSL-G02 cierre los contratos core del Maintenance Standards Master.
2. La frontera `Maintenance Activity ↔ Job Plan ↔ ProcedureChecklist` esté estable.
3. El contrato RCM para functions, functional failures, failure modes, effects y decision logic esté suficientemente cerrado.
4. Exista una regla clara de salida `RCM result → Project Maintenance Plan`.
5. Se haya validado el governance `Project Learning → Corporate Change Proposal`.

## 9. Estado de backlog

```text
Capability: RCM / AMEF Engineering Wizard
Status: FUTURE
Priority: after Maintenance Standards core + project adoption foundation
Current action: DOCUMENT ONLY
Do not open implementation WIP
```

La existencia de este concepto no justifica crear ahora nuevas pantallas, workspaces, SQL tables, Stored Procedures ni flows.
