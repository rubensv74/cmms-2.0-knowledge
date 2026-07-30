(function(){
  function get(id){return window.CMMS_P046_SCENARIOS.filter(function(x){return x.id===id;})[0]||window.CMMS_P046_SCENARIOS[0];}
  function decorate(state){
    var scenario=get(state.uiState.demoScenario||"complete"),host=document.getElementById("viewHost");
    document.querySelectorAll(".scenario-banner,.scenario-state").forEach(function(x){x.remove();});
    if(scenario.id==="complete")return;
    if(scenario.id==="loading"){host.innerHTML='<section class="scenario-state"><span class="loading-ring" aria-hidden="true"></span><h1>Cargando análisis</h1><p>'+scenario.message+'</p></section>';return;}
    if(scenario.id==="empty"){host.innerHTML='<section class="scenario-state"><span class="scenario-icon" aria-hidden="true">○</span><h1>Sin funciones todavía</h1><p>'+scenario.message+'</p><button class="button button-primary" type="button" disabled>Añadir primera función</button></section>';return;}
    var banner=document.createElement("div");banner.className="scenario-banner "+scenario.tone;banner.setAttribute("role",scenario.tone==="danger"?"alert":"status");banner.innerHTML="<strong>Escenario: "+scenario.label+"</strong><span>"+scenario.message+"</span>";host.prepend(banner);
  }
  function isReadonly(state){return state.analysisHeader.status==="Publicada"||state.uiState.demoScenario==="published";}
  window.CMMS_P046={get:get,decorate:decorate,isReadonly:isReadonly};
})();
