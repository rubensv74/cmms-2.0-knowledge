(function(){
  "use strict";
  var verbs=["transferir","mantener","proporcionar","detectar","proteger","contener","controlar","permitir","impedir","suministrar","arrancar"];
  function result(errors){return{valid:errors.length===0,errors:errors};}
  function scope(state){
    var c=state.operationalContext,errors=[];
    if(!String(c.context||"").trim())errors.push("Describe las condiciones operacionales y su impacto.");
    if(!String(c.source||"").trim()&&!String(c.assumptions||"").trim())errors.push("Declara al menos una fuente técnica o un supuesto.");
    return result(errors);
  }
  function functions(state){
    var errors=[],seen={};
    if(!state.functions.length)errors.push("Añade al menos una función.");
    state.functions.forEach(function(fn){
      var text=String(fn.description||"").trim(),first=text.split(/\s+/)[0].toLowerCase();
      if(verbs.indexOf(first)<0)errors.push(fn.id+": comienza la función con un verbo de acción.");
      if(!String(fn.performanceStandard||"").trim()&&!String(fn.qualitativeReason||"").trim())errors.push(fn.id+": indica un estándar medible o justifica que sea cualitativo.");
      var key=text.toLowerCase();if(seen[key])errors.push(fn.id+": la función está duplicada.");seen[key]=true;
    });
    return result(errors);
  }
  function failures(state){
    var errors=[],count=0;
    state.functions.forEach(function(fn){(fn.functionalFailures||[]).forEach(function(ff){count++;if(!ff.functionId)errors.push(ff.id+": selecciona una función.");if(!String(ff.description||"").trim())errors.push(ff.id+": describe el incumplimiento funcional.");});});
    if(!count)errors.push("Añade al menos un fallo funcional asociado a una función.");
    return result(errors);
  }
  function modes(state){
    var errors=[],count=0;
    state.functions.forEach(function(fn){(fn.functionalFailures||[]).forEach(function(ff){(ff.failureModes||[]).forEach(function(mode){count++;if(!String(mode.description||"").trim())errors.push(mode.id+": describe el modo.");if(!(mode.effects||[]).length)errors.push(mode.id+": documenta al menos un efecto.");});});});
    if(!count)errors.push("Añade al menos un modo asociado a un fallo funcional.");
    return result(errors);
  }
  function validate(step,state){return({1:scope,2:functions,3:failures,4:modes}[step]||function(){return result([]);})(state);}
  window.CMMS_VALIDATIONS={validate:validate};
})();
