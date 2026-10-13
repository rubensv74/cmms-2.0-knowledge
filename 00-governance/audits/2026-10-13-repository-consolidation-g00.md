# CMMS 2.0 — Auditoría de consolidación del repositorio — G00

**Fecha:** 2026-10-13  
**Repositorio:** rubensv74/cmms-2.0-knowledge  
**Main auditado:** 4a45ad077e74a6ef01979dc64b3b5ae0bba4eb08  
**Estado:** INVENTARIO_Y_TRIAGE_G00_COMPLETADOS / RECONCILIACIÓN_G01_PENDIENTE  
**Naturaleza:** auditoría GitHub/documental, no prueba de ejecución en SQL, Power Apps o Power Automate.

## 1. Objetivo y límites

Determinar qué documentación y código deben preservarse, reconciliarse, promoverse selectivamente o clasificarse como históricos. No fusionar ramas divergentes, borrar recursos originales o declarar válidas pantallas/flows por disponer únicamente de documentación o PaYaml.

**Evidencia recopilada:** Git tree recursivo de main, ramas y PR, comparación de 11 ramas contra main, documentos de gobierno y contratos, cotejo de nomenclatura SP/flows/SQL y comprobación de 134 enlaces relativos en 11 documentos clave.

**No realizado en G00:** prueba de importación Studio, ejecución SQL, ejecución Power Automate, análisis exhaustivo de los 167 Markdown, clasificación de confidencialidad ni prueba de las ramas candidatas. No se ha modificado ninguna fuente histórica en 08-resources.

## 2. Inventario de main — comprobado

| Elemento | Evidencia |
|---|---|
| Archivos/directorios | 300 archivos y 67 directorios; árbol completo, no truncado |
| Tamaño lógico | 32.397.452 bytes, aprox. 30,9 MiB |
| Markdown | 167 archivos |
| SQL | 7 archivos |
| PaYaml en main | 1 shell de Assets; no equivale a app completa |
| 08-resources | 17 archivos, 25.025.030 bytes; conservar originales |
| Ramas | 12 totales, 11 fuera de main |
| Clasificación ramas | 2 sin commits exclusivos, 9 divergentes |
| PR abiertas | #11 y #12, ambas reportadas como mergeable=false |
| Duplicados exactos por SHA | 0 grupos. No descarta duplicados semánticos |
| Enlaces muestreados | 134 relativos en 11 documentos principales; 0 rotos |
| Nombres core de integración | 8 procedimientos coincidentes entre contrato SP, especificación de flows y SQL; 8 flows previstos |

## 3. Hallazgos priorizados

| ID | Severidad | Hallazgo | Decisión inicial |
|---|---|---|---|
| C-01 | CRÍTICA | 9 ramas divergentes guardan desarrollos no reconciliados. La rama feature/f01-premium-foundation está 413 ahead/214 behind e incluye 202 rutas distintas y 68 PaYaml. | Rescatar por capability después de comparar contratos, nunca merge total |
| C-02 | ALTA | [PR #11](https://github.com/rubensv74/cmms-2.0-knowledge/pull/11) Development Baseline: 53 ahead/147 behind, 31 archivos, 5 PaYaml y 09-development no existente en main; no mergeable. | Conservar; extraer selectivamente componentes, backend y pruebas históricas tras revisión |
| C-03 | ALTA | [PR #12](https://github.com/rubensv74/cmms-2.0-knowledge/pull/12) MSL-G01: draft, 2 ahead/134 behind, no mergeable, documenta MSL-G01 bloqueado cuando main ya registra PASS con ambigüedades. | No fusionar contenido antiguo; recuperar solo evidencia/propuesta futura ausente, después valorar cierre |
| C-04 | ALTA | baseline/premium-powerapps-v1 aporta 17 PaYaml y feat/assets-capability-payaml 1 PaYaml fuera de main. | Candidatos para validación selectiva; no restaurar estado/gates antiguos |
| C-05 | ALTA | agent/functional-lab-foundation contiene 42 cambios contra main, incluidos modelos/fixtures anteriores. | Comparar con DM-G02 y Journey v1.3; no convertir un modelo antiguo en autoridad actual |
| C-06 | MEDIA | Dos archivos SPC-001 de AMEF/RCM comparten código: uno versión 0.1.0 y otro 0.2.0, contenidos distintos. | Mantener los dos históricos; documentar lineage y no usarlos sobre Product Truth |
| C-07 | MEDIA | Planning/Scheduling v0.1 y v1.0 coexisten; documentos cronológicos aún incluyen gates históricos en secciones inferiores. | Versionar referencias y avisos; WM-G03 v1.0 benchmarked es referencia de contrato actual |
| C-08 | ALTA | DB-G01 y SP-G01 muestran PASS runtime documentado, pero PA-G01 es diseño. El gate PA-G01-RUNTIME-MIN no está acreditado. | Prioridad de ejecución intacta: WorkQueue_List + WorkOrder_Materialize con JSON, requestId e incidencias |
| C-09 | MEDIA | Algunos prototipos/guías históricos expresan WorkCandidate universal o materialización anual hoy superados. | Clasificar como HISTORICAL / NO NORMATIVO sin borrar originales |
| C-10 | MEDIA | Screen Map V1 es propuesta UX; imágenes PlanWise no equivalen a marca aprobada y existe branding CMMS V1. | Mantener propuesta separada de aprobación del shell y branding |
| C-11 | ALTA | Repositorio de visibilidad PUBLIC con referencias y materiales de proyectos industriales; no se hizo clasificación de confidencialidad. | Auditar accesos/material; no afirmar filtración ni cambiar visibilidad sin evaluación |
| C-12 | MEDIA | MASTER_INDEX no enlaza en sección propia los contratos y runbook de PA-G01. | Completar el índice, sin modificar esos contratos |

El resultado 0 duplicados SHA **solo** descarta archivos idénticos byte a byte; dos documentos de contenido parecido y un ZIP con fuentes internas necesitan comparación semántica.

## 4. Matriz de ramas — acciones propuestas, sin borrados

| Rama | Ahead/Behind de main | Clasificación | Razón |
|---|---:|---|---|
| agent/amef-rcm-experience-center | 0 / 224 | CLOSE_CANDIDATE | Sin aportes exclusivos; revisar referencias antes de eventual retirada |
| docs/cmms-premium-governance-ai-catalog | 0 / 191 | CLOSE_CANDIDATE | Sin aportes exclusivos |
| agent/cmms-development-baseline-01 | 53 / 147 | HOLD_EXTRACT | PR #11; foundation, G0 y backend; conflicto |
| agent/functional-lab-f01-foundation | 5 / 218 | HOLD_RECONCILE | Foundation antigua |
| agent/functional-lab-foundation | 66 / 219 | HOLD_RECONCILE | Modelos/fixtures históricos con posible valor |
| baseline/premium-powerapps-v1 | 74 / 192 | HOLD_EXTRACT | Candidatos premium y PaYaml |
| feat/assets-capability-payaml | 6 / 147 | HOLD_EXTRACT | Candidato Assets sujeto a contratos AS-01…AS-04 |
| feat/msl-g01-source-normalization | 2 / 134 | CLOSE_AFTER_REVIEW | PR #12; estados históricos superados |
| feature/f01-premium-foundation | 413 / 214 | PRIORITY_RESCUE | Mayor deuda de código posiblemente recuperable; alto riesgo |
| governance/cmms-ai-agent-team-v1 | 4 / 171 | HOLD_COMPARE | Comparar AGENTS/registro de agentes vigentes |
| governance/cmms-runtime-routing-v1 | 4 / 159 | HOLD_COMPARE | Comparar routing de main |

**Resultado real:** 0 merges, 0 deletes, 0 cierres de PR y 0 cambios sobre ramas. CLOSE_CANDIDATE no autoriza borrar sin evidencia de uso e integración.

## 5. Fuentes de verdad para reconciliar

| Dominio | Autoridad vigente |
|---|---|
| Estado y siguiente gate | [PROJECT_STATUS](../../PROJECT_STATUS.md) y [ROADMAP](../../ROADMAP.md), resumen 2026-10-09 |
| Principios y decisiones | [Product Truth](../CMMS_PRODUCT_TRUTH_BASELINE_V1.md), [Decision Register](../../05-meetings/decisions/DECISION_REGISTER.md) |
| Modelo lógico | [DM-G02](2026-10-08-data-model-g02.md) y [Domain Boundaries](../../07-it-handoff/04-data/domain-boundaries.md) |
| RCM | [Functional Journey v1.3](../../02-functional/process-model/functional-journey.md); wizard AMEF en HOLD |
| Estándares | MSL-G01/G02 PASS con salvedades; MSL-G03/G04 pendientes |
| Triggering | TRG-G01: Policy, State, Forecast derivado, Occurrence persistente, DueEvent; ReleaseAt distinto de DueAt |
| Work Management | WM-G02 PASS con PTW/LOTO externo; WM-G03/WM-G05 PASS por benchmark, no aceptación AS-IS local |
| SQL/SP | DB-G01-RUNTIME y SP-G01 PASS según evidencias 2026-10-08 |
| Flows | PA-G01 DESIGN_READY; PA-G01-RUNTIME-MIN pendiente |
| UX | [Screen Map V1](../../07-it-handoff/05-ui/screen-map.md) propuesta, y AS-01…AS-04 [Asset Architecture](../../06-ui-ux/CMMS_ASSET_SCREEN_ARCHITECTURE_V1.md) |
| Evidencia | Reuniones, prototipos y 08-resources conservados sin autoridad automática |

## 6. Registro de tareas y gates

| ID | Prioridad | Trabajo verificable | Estado tras G00 |
|---|---|---|---|
| A01 | P0 | Inventario main, ramas, PR y tamaños | DONE |
| A02 | P0 | Fuente de verdad y jerarquía de decisiones | DONE |
| A03 | P0 | Cotejo nominal de contratos SQL/SP/PA | DONE_STATIC, no runtime |
| A04 | P1 | Auditoría enlaces docs centrales | DONE_SAMPLE (11 documentos, 134 enlaces) |
| A05 | P1 | Indexar la auditoría y contratos PA | DOCUMENTAL_G00 |
| A06 | P0 | Visibilidad, clasificación de documentos, secretos y acceso | OPEN / NO AUDITADO |
| A07 | P0 | Matriz archivo-a-archivo de 9 ramas divergentes: PROMOTE, REWRITE, HISTORICAL, DISCARD_CANDIDATE | NEXT_G01 |
| A08 | P0 | Dictamen de PR #11 y #12, sin merge directo | NEXT_G01 |
| A09 | P1 | Lineage SPC-001 0.1/0.2 y avisos WM v0.1/v1.0 | NEXT_G01 |
| A10 | P1 | Recuperar capacidades Power Apps una a una y ejecutar gate Studio | EXTERNAL_RUNTIME_GATE |
| A11 | P1 | Completar cobertura de enlaces para los 167 MD y localizar duplicados semánticos | NEXT_G01 |
| A12 | P0 | Validar 2 flows PA-G01 con idempotencia, READY/JSON, errores, rollback y prueba real | PA-G01-RUNTIME-MIN, PENDING |
| A13 | P2 | Índice histórico de prototipos y recursos sin alterar fuentes | NEXT_G01 |
| A14 | P2 | Validar Screen Map, permisos y branding con negocio | FUNCTIONAL_GATE |
| A15 | P1 | Informe de cierre de G01 y propuesta segura de cierre de ramas | AFTER_RECONCILIATION |

## 7. Criterio de promoción y próximos gates

**Toda recuperación desde ramas:** identificar archivo/commit → comparar autoridad y contratos actuales → resolver dependencias → clasificar → comprobar formatos de entrada/salida, tipos, nombres, revisiones, concurrencia e idempotencia → validar código estáticamente → probar Studio/SQL/Flow real según corresponda → actualizar gobierno → promover. **Nunca** copiar de la rama histórica PROJECT_STATUS o ROADMAP sobre los vigentes.

**G00 cerrado solo en inventario y triage.** No se declara consolidado el repositorio ni rescatado su código.  
**Siguiente gate documental autónomo:** G01_RECONCILIATION.  
**Siguiente gate técnico externo del proyecto:** PA-G01-RUNTIME-MIN, sin cambios.
