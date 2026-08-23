# CMMS 2.0 — Guía rápida de encargos para IA

| Ámbito | Acción | Plantilla de la frase para hacer la llamada |
|---|---|---|
| UI | Continuar pantalla/workspace | `Usa CONTINUE_SCREEN_EDITING y continúa con [PANTALLA/WORKSPACE].` |
| UI | Crear pantalla/workspace | `Usa CREATE_NEW_SCREEN para crear [PANTALLA/WORKSPACE].` |
| UI | Auditar pantalla | `Usa REVIEW_SCREEN para auditar [PANTALLA/WORKSPACE].` |
| UI | Crear componente premium | `Usa CREATE_SHARED_COMPONENT para crear/adaptar un componente reusable para [NECESIDAD].` |
| UI | Revisar componente | `Usa REVIEW_SHARED_COMPONENT para revisar [COMPONENTE].` |
| UI | Preparar Visual Gate | `Usa PREPARE_VISUAL_GATE para preparar [PANTALLA] para el Visual Gate.` |
| UI | Coherencia visual | `Usa REVIEW_VISUAL_CONSISTENCY para comparar [PANTALLA/S] con el estándar CMMS.` |
| Funcional | Continuar feature | `Usa CONTINUE_FEATURE_DEVELOPMENT y continúa con [FUNCIONALIDAD].` |
| Funcional | Diseñar flujo | `Usa DESIGN_FUNCTIONAL_FLOW para diseñar [PROCESO].` |
| Funcional | Revisar modelo | `Usa REVIEW_FUNCTIONAL_MODEL para auditar [ÁREA/MODELO].` |
| CMMS | Continuar Functional Lab | `Usa CONTINUE_FUNCTIONAL_LAB y continúa el Functional Lab desde el último gate válido.` |
| CMMS | Continuar AMEF/RCM | `Usa CONTINUE_AMEF_RCM y continúa el modelo AMEF/RCM desde el estado real.` |
| CMMS | Continuar Work Management | `Usa CONTINUE_WORK_MANAGEMENT_DISCOVERY y continúa Work Management sin promover discovery a regla aprobada.` |
| Datos | Diseñar contrato | `Usa DESIGN_DATA_CONTRACT para definir [CONTRATO/OBJETO].` |
| Datos/SQL | Crear incremento SQL | `Usa DESIGN_SQL_INCREMENT para implementar [OBJETIVO SQL].` |
| Datos/SQL | Revisar SQL | `Usa REVIEW_SQL_CHANGE para revisar [OBJETO/SCRIPT].` |
| Datos/SQL | Optimizar SQL | `Usa OPTIMIZE_SQL_QUERY para optimizar [QUERY/VISTA/SP].` |
| Datos/SQL | Auditar BD | `Usa AUDIT_DATABASE_CHANGE para auditar [CAMBIO/MODELO].` |
| Datos | Investigar discrepancia | `Usa INVESTIGATE_DATA_DISCREPANCY para investigar [FUENTE A] vs [FUENTE B].` |
| Power Platform | Crear incremento Power Apps | `Usa CREATE_POWER_APPS_INCREMENT para construir [ID/NOMBRE].` |
| Power Platform | Revisar incremento | `Usa REVIEW_POWER_APPS_INCREMENT para revisar [ID/NOMBRE].` |
| Power Platform | Crear flow | `Usa CREATE_POWER_AUTOMATE_FLOW para crear [FLOW/OBJETIVO].` |
| Power Platform | Revisar flow | `Usa REVIEW_POWER_AUTOMATE_FLOW para auditar [FLOW].` |
| Calidad | Auditar repositorio | `Usa AUDIT_REPOSITORY_CONTEXT antes de trabajar en [ÁREA].` |
| Calidad | Planificar incrementos | `Usa PLAN_IMPLEMENTATION_INCREMENT para convertir [NECESIDAD] en incrementos verificables.` |
| Calidad | Revisar incremento | `Usa REVIEW_INCREMENT para revisar [INCREMENTO].` |
| Calidad | Preparar release/gate | `Usa PREPARE_RELEASE_GATE para preparar [CAMBIO] con evidencias y rollback.` |
| Calidad | Investigar defecto | `Usa INVESTIGATE_DEFECT para diagnosticar [ERROR].` |
| Documentación | ADR/decisión | `Usa DOCUMENT_DECISION_ADR para documentar [DECISIÓN].` |
| Documentación | Lección aprendida | `Usa DOCUMENT_LESSON_LEARNED para documentar [APRENDIZAJE].` |
| Documentación | Actualizar documentación | `Usa UPDATE_PROJECT_DOCUMENTATION tras [CAMBIO].` |

Para UI aplicar siempre `REUSE_CMMS → ADAPT_VERIFIED_BASE → EXTEND_SHARED → CREATE_SHARED → LOCAL_ONLY`.
