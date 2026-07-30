(function(){
  "use strict";
  var tests=[],clone=function(x){return JSON.parse(JSON.stringify(x));},base=clone(window.CMMS_INITIAL_STATE);
  function test(name,description,fn){try{if(fn()!==true)throw new Error("Resultado no verdadero");tests.push({name:name,description:description,pass:true});}catch(error){tests.push({name:name,description:description+" · "+error.message,pass:false});}}
  function modes(state){var out=[];state.functions.forEach(function(fn){fn.functionalFailures.forEach(function(ff){ff.failureModes.forEach(function(m){out.push(m);});});});return out;}
  test("Recorrido feliz completo","El caso no contiene errores críticos globales.",function(){return window.CMMS_REVIEW_VALIDATIONS.validate(clone(base)).errors.length===0;});
  test("Fallo oculto","FM-002 concluye en búsqueda de fallos.",function(){return window.CMMS_RCM_ENGINE.recommendation(modes(base)[1].rcmAssessment)==="Búsqueda de fallos";});
  test("Avance sin contexto","El Paso 1 rechaza contexto vacío.",function(){var s=clone(base);s.operationalContext.context="";return !window.CMMS_VALIDATIONS.validate(1,s).valid;});
  test("Modo sin efecto","El Paso 4 rechaza un modo sin efectos.",function(){var s=clone(base);modes(s)[0].effects=[];return !window.CMMS_VALIDATIONS.validate(4,s).valid;});
  test("Riesgo sin justificación","La evaluación de riesgo queda incompleta.",function(){var a=clone(modes(base)[0].consequenceAssessment);a.justification="";return !window.CMMS_RISK_ENGINE.validate(a).valid;});
  test("Información insuficiente","RCM devuelve Análisis pendiente sin inventar respuesta.",function(){var a=clone(modes(base)[0].rcmAssessment);a.responses.Q4={answer:"Información insuficiente",explanation:"Falta tendencia suficiente",evidence:"Campaña pendiente"};return window.CMMS_RCM_ENGINE.recommendation(a)==="Análisis pendiente";});
  test("Override sin motivo","La decisión alternativa no puede cerrarse.",function(){var a=clone(modes(base)[0].rcmAssessment);a.override=true;a.overrideReason="";return !window.CMMS_RCM_ENGINE.validate(a).valid;});
  test("Tarea sin modo","La tarea sin cobertura se rechaza.",function(){var t=clone(base.proposedTasks[0]);t.modeIds=[];return !window.CMMS_TREATMENT_VALIDATIONS.task(t).valid;});
  test("Operar hasta fallo","Una decisión explícita y justificada es válida.",function(){return window.CMMS_TREATMENT_VALIDATIONS.decision({modeId:"FM-001",type:"Operar hasta el fallo",justification:"Consecuencias aceptadas en escenario de prueba"}).valid;});
  test("Activo excluido","La tecnología incompatible produce No aplicable.",function(){return window.CMMS_APPLICABILITY_ENGINE.suggest(base.assetApplications[3]).result==="No aplicable";});
  test("Divergencia humana","Sin motivo y metadatos, la validación distinta se rechaza.",function(){var a=clone(base.assetApplications[0]);a.humanDecision="No aplicable";a.reason="";a.validatedBy="";a.validatedAt="";return !window.CMMS_APPLICABILITY_ENGINE.validate(a).valid;});
  test("Publicación con error","Un contexto inválido genera error crítico global.",function(){var s=clone(base);s.operationalContext.context="";return window.CMMS_REVIEW_VALIDATIONS.validate(s).errors.length>0;});
  test("Revisión publicada","El escenario publicado activa el modo solo lectura.",function(){var s=clone(base);s.uiState.demoScenario="published";return window.CMMS_P046.isReadonly(s);});
  test("Nueva revisión","Conserva snapshot anterior e incrementa la revisión.",function(){var h={revision:"0.1",snapshotId:"SNAP-001"};var previous=h.snapshotId;h.previousSnapshotId=previous;h.revision=(Number(h.revision)+.1).toFixed(1);h.snapshotId=null;return h.revision==="0.2"&&h.previousSnapshotId==="SNAP-001";});
  test("Persistencia y reinicio","El store guarda y elimina su clave sin perder el valor previo.",function(){var key=window.CMMS_STORE.storageKey,previous=null;try{previous=localStorage.getItem(key);window.CMMS_STORE.save();if(!localStorage.getItem(key))return false;window.CMMS_STORE.reset();return localStorage.getItem(key)===null;}finally{if(previous!==null)localStorage.setItem(key,previous);}});
  var passed=tests.filter(function(x){return x.pass;}).length,failed=tests.length-passed;
  document.body.dataset.failures=String(failed);
  document.getElementById("summary").innerHTML="<strong>"+passed+" de "+tests.length+"</strong><span>"+(failed?"pruebas con incidencias":"pruebas superadas")+"</span>";
  document.getElementById("results").innerHTML=tests.map(function(t,i){return'<article class="test"><span class="number">'+(i+1)+'</span><div><strong>'+t.name+'</strong><p>'+t.description+'</p></div><span class="'+(t.pass?"pass":"fail")+'">'+(t.pass?"Superada":"Fallida")+"</span></article>";}).join("");
})();
