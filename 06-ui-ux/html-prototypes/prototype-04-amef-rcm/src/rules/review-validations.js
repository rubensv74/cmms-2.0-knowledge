(function(){
  function validate(state){
    var errors=[],warnings=[];
    [1,2,3,4].forEach(function(step){window.CMMS_VALIDATIONS.validate(step,state).errors.forEach(function(x){errors.push("Paso "+step+": "+x);});});
    state.functions.forEach(function(fn){fn.functionalFailures.forEach(function(ff){ff.failureModes.forEach(function(mode){
      window.CMMS_RISK_ENGINE.validate(mode.consequenceAssessment).errors.forEach(function(x){errors.push(mode.id+" · Riesgo: "+x);});
      window.CMMS_RCM_ENGINE.validate(mode.rcmAssessment).errors.forEach(function(x){errors.push(mode.id+" · RCM: "+x);});
    });});});
    window.CMMS_TREATMENT_VALIDATIONS.all(state).errors.forEach(function(x){errors.push("Tratamiento: "+x);});
    state.assetApplications.forEach(function(asset){window.CMMS_APPLICABILITY_ENGINE.validate(asset).errors.forEach(function(x){errors.push(asset.id+" · Aplicabilidad: "+x);});});
    state.approvalStages.forEach(function(stage){if(stage.status!=="Aprobada")warnings.push(stage.name+": "+stage.status);});
    return{valid:errors.length===0,errors:errors,warnings:warnings,canPublish:errors.length===0&&warnings.length===0};
  }
  window.CMMS_REVIEW_VALIDATIONS={validate:validate};
})();
