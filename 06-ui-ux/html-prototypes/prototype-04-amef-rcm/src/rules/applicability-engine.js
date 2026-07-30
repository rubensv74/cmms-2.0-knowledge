(function(){
  function suggest(asset){
    if(asset.incompatibleBearingTechnology)return{result:"No aplicable",reason:"Tecnología de rodamientos incompatible con el análisis."};
    if(asset.regime==="Reserva")return{result:"Parcial",reason:"Requiere perfil de reserva y prueba funcional."};
    if(asset.regime==="Intermitente")return{result:"Parcial",reason:"Requiere ajustar frecuencia al régimen intermitente."};
    if(!asset.hasVibrationInstrumentation)return{result:"Revisión",reason:"No dispone de instrumentación para la tarea de vibraciones."};
    return{result:"Aplicable",reason:"Coincide tipo, servicio y régimen del caso conductor."};
  }
  function validate(asset){
    var errors=[],suggestion=suggest(asset);
    if(!asset.humanDecision)errors.push("Registra una decisión humana.");
    if(asset.humanDecision!==suggestion.result){if(!String(asset.reason||"").trim())errors.push("Motiva la diferencia respecto a la sugerencia.");if(!asset.validatedBy)errors.push("Conserva el usuario que valida.");if(!asset.validatedAt)errors.push("Conserva la fecha de validación.");}
    return{valid:!errors.length,errors:errors,suggestion:suggestion};
  }
  window.CMMS_APPLICABILITY_ENGINE={suggest:suggest,validate:validate};
})();
