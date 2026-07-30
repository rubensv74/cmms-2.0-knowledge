(function(){
  function answer(a,id){return a.responses[id]&&a.responses[id].answer;}
  function recommendation(a){
    var values=Object.keys(a.responses).map(function(k){return a.responses[k].answer;});
    if(values.indexOf("Información insuficiente")>=0)return"Análisis pendiente";
    if(answer(a,"Q1")==="Sí")return answer(a,"Q8")==="Sí"?"Búsqueda de fallos":"Rediseño/modificación";
    if(answer(a,"Q4")==="Sí"&&answer(a,"Q5")==="Sí"&&answer(a,"Q6")==="Sí")return"Mantenimiento basado en condición";
    if(answer(a,"Q7")==="Sí")return"Restauración programada";
    if(answer(a,"Q9")==="No")return"Rediseño/modificación";
    if(answer(a,"Q9")==="Sí")return"Operar hasta el fallo";
    return"Análisis pendiente";
  }
  function validate(a){
    var errors=[],required=answer(a,"Q1")==="Sí"?["Q1","Q8"]:["Q1","Q2","Q3","Q4"];
    if(answer(a,"Q1")!=="Sí"){if(answer(a,"Q4")==="Sí")required=required.concat(["Q5","Q6"]);if(answer(a,"Q4")==="No"||answer(a,"Q5")==="No"||answer(a,"Q6")==="No")required.push("Q7");if(answer(a,"Q7")==="No")required.push("Q9");}
    required.forEach(function(id){var r=a.responses[id];if(!r||!r.answer)errors.push(id+": selecciona una respuesta.");else{if(!String(r.explanation||"").trim())errors.push(id+": explica la respuesta.");if(!String(r.evidence||"").trim())errors.push(id+": indica evidencia.");}});
    var rec=recommendation(a);if(rec==="Análisis pendiente"&&!Object.keys(a.responses).some(function(id){return a.responses[id].answer==="Información insuficiente";}))errors.push("Completa el camino RCM hasta un resultado.");
    if(a.override&&!String(a.overrideReason||"").trim())errors.push("Justifica el override antes de guardar.");
    return{valid:errors.length===0,errors:errors,recommendation:rec};
  }
  window.CMMS_RCM_ENGINE={recommendation:recommendation,validate:validate};
})();
