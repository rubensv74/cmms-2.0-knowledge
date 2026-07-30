(function(){
  var state=window.CMMS_INITIAL_STATE;
  state.schemaVersion="P04.3";
  state.uiState.selectedRiskModeId=state.uiState.selectedRiskModeId||"FM-001";
  state.uiState.selectedRcmModeId=state.uiState.selectedRcmModeId||"FM-001";
  state.uiState.selectedRcmQuestionId=state.uiState.selectedRcmQuestionId||"Q1";
  state.functions.forEach(function(fn){fn.functionalFailures.forEach(function(ff){ff.failureModes.forEach(function(mode){
    if(mode.id==="FM-001"){
      mode.consequenceAssessment={matrixVersion:"DEMO-RISK-5X5-v1",dimensions:{safety:"Baja",environment:"Moderada",operation:"Alta",quality:"Baja",directCost:"Moderado",nonOperational:"Baja"},severity:4,probability:3,residualSeverity:3,residualProbability:2,safeguards:"Bomba de reserva, alarmas de proceso y rutas de inspección",justification:"La parada de la bomba en servicio puede reducir producción si la reserva no está disponible.",residualJustification:"Evaluación ilustrativa tras considerar reserva disponible y detección temprana."};
      mode.rcmAssessment={treeVersion:"DEMO-RCM-v1",responses:{Q1:r("No","El modo es observable mediante vibración, temperatura y fuga.","Tendencias e inspección"),Q2:r("No","En el escenario base no domina seguridad ni medioambiente.","Contexto operacional"),Q3:r("Sí","Puede provocar parada y reducción de producción.","Consecuencia operacional"),Q4:r("Sí","Existe degradación detectable antes del fallo.","Tendencias de condición"),Q5:r("Sí","El intervalo permite planificar intervención.","Experiencia de mantenimiento"),Q6:r("Sí","Vibración, fuga y temperatura detectan degradación.","Programa predictivo")},recommendation:"Mantenimiento basado en condición",adoptedDecision:"Mantenimiento basado en condición",override:false,overrideReason:""};
    }else{
      mode.consequenceAssessment={matrixVersion:"DEMO-RISK-5X5-v1",dimensions:{safety:"Baja",environment:"Baja",operation:"Alta",quality:"Baja",directCost:"Moderado",nonOperational:"Baja"},severity:4,probability:2,residualSeverity:3,residualProbability:2,safeguards:"Prueba funcional periódica y alarma de indisponibilidad",justification:"El fallo permanece oculto hasta una demanda y elimina la redundancia disponible.",residualJustification:"Evaluación ilustrativa después de una prueba funcional vigente."};
      mode.rcmAssessment={treeVersion:"DEMO-RCM-v1",responses:{Q1:r("Sí","El fallo no se revela durante operación normal.","Prueba de demanda"),Q8:r("Sí","Una prueba funcional revela si la reserva arranca.","Procedimiento de prueba")},recommendation:"Búsqueda de fallos",adoptedDecision:"Búsqueda de fallos",override:false,overrideReason:""};
    }
  });});});
  function r(answer,explanation,evidence){return{answer:answer,explanation:explanation,evidence:evidence,user:"Laura Martín · Fiabilidad",date:"2026-07-30"};}
})();
