(function(){
  var state=window.CMMS_INITIAL_STATE;
  state.schemaVersion="P04.4";
  state.proposedTasks=[
    task("TASK-001","Medición de vibraciones","Basada en condición","Análisis de vibraciones","FM-001","Cada 30 días","Intervalo P-F y experiencia de mantenimiento","En servicio","Fiabilidad","Técnico predictivo","Tendencia dentro de límites y sin escalada de alarma"),
    task("TASK-002","Inspección de fuga y temperatura","Inspección","Inspección visual y termografía","FM-001","Cada 7 días","Señales observables del efecto local","En servicio","Mecánica","Técnico mecánico","Sin fuga anormal ni temperatura fuera de límite"),
    task("TASK-003","Análisis de aceite cuando la configuración lo permita","Análisis de lubricante","Análisis de aceite","FM-001","Cada 90 días","Condición del lubricante y configuración del activo","En servicio","Fiabilidad","Técnico predictivo","Resultados dentro de límites técnicos"),
    task("TASK-004","Revisión del intervalo con seis meses de resultados","Revisión de intervalo","Revisión de datos","FM-001","Después de 6 meses","Resultados acumulados de condición","Indiferente","Fiabilidad","Ingeniero de fiabilidad","Intervalo confirmado o cambio justificado"),
    task("TASK-005","Prueba periódica del arranque automático de la bomba de reserva","Búsqueda de fallos","Prueba funcional","FM-002","Periodicidad por validar","Necesidad de revelar el fallo oculto; intervalo pendiente de validación técnica","Reserva disponible","Operaciones","Operador de campo","La reserva arranca automáticamente ante la señal de demanda")
  ];
  state.noTaskDecisions=[];
  state.applicabilityRules=[
    {id:"APR-001",field:"Tipo de equipo",operator:"Igual a",value:"Bomba centrífuga horizontal",effect:"Candidato"},
    {id:"APR-002",field:"Servicio",operator:"Igual a",value:"Agua de refrigeración",effect:"Candidato"},
    {id:"APR-003",field:"Régimen",operator:"Igual a",value:"Continuo",effect:"Aplicable"},
    {id:"APR-004",field:"Tecnología de rodamientos",operator:"Incompatible",value:"Sí",effect:"No aplicable"},
    {id:"APR-005",field:"Instrumentación de vibraciones",operator:"No disponible",value:"Sí",effect:"Revisión manual"}
  ];
  state.assetApplications=[
    asset("P-101A","Servicio continuo","Alta","Bomba centrífuga horizontal","Agua de refrigeración","Continuo",false,true,"PERF-ALTA","Aplicable","Aplicable","Caso piloto"),
    asset("P-101B","Reserva automática","Alta","Bomba centrífuga horizontal","Agua de refrigeración","Reserva",false,true,"PERF-RESERVA","Parcial","Revisión","Añadir prueba funcional"),
    asset("P-202A","Servicio intermitente","Media","Bomba centrífuga horizontal","Agua de refrigeración","Intermitente",false,false,"PERF-MEDIA","Parcial","Pendiente","Ajustar frecuencia"),
    asset("P-301A","Tecnología incompatible","Baja","Bomba centrífuga horizontal","Agua de refrigeración","Continuo",true,true,"PERF-BAJA","No aplicable","No aplicable","Regla de exclusión")
  ];
  state.uiState.selectedTaskId=state.uiState.selectedTaskId||"TASK-001";
  state.uiState.treatmentMode=state.uiState.treatmentMode||"task";
  function task(id,title,type,technique,modeId,frequency,foundation,operationalState,discipline,role,criterion){return{id:id,title:title,type:type,technique:technique,description:title,modeIds:[modeId],frequency:frequency,foundation:foundation,operationalState:operationalState,discipline:discipline,role:role,duration:"Orientativa",resources:"Según procedimiento",acceptanceCriterion:criterion,evidenceRequired:"Registro fechado y resultado",technicalLimits:"Por validar técnicamente",justification:"Tratamiento propuesto a partir del recorrido RCM",status:"Propuesta"};}
  function asset(id,context,criticality,equipmentType,service,regime,incompatible,hasInstrumentation,profileId,suggested,human,reason){return{id:id,context:context,criticality:criticality,equipmentType:equipmentType,service:service,regime:regime,incompatibleBearingTechnology:incompatible,hasVibrationInstrumentation:hasInstrumentation,profileId:profileId,suggestedResult:suggested,humanDecision:human,reason:reason,validatedBy:"Carlos Vega · Ingeniería de mantenimiento",validatedAt:"2026-07-30"};}
})();
