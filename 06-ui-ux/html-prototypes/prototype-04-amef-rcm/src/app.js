(function(){
  "use strict";
  var steps=window.CMMS_CATALOGS.steps,store=window.CMMS_STORE,demo=window.CMMS_DEMO_CASE,state=store.load(),toastTimer;
  var el=function(id){return document.getElementById(id);};
  function escapeHtml(value){return String(value).replace(/[&<>"']/g,function(c){return({"&":"&amp;","<":"&lt;",">":"&gt;",'"':"&quot;","'":"&#039;"})[c];});}
  function renderStepper(){
    el("stepper").innerHTML=steps.map(function(step){
      var active=step.number===state.uiState.currentStep?" active":"",visited=state.uiState.visitedSteps.indexOf(step.number)>=0?" visited":"";
      return '<button class="step-button'+active+visited+'" type="button" data-step="'+step.number+'" aria-current="'+(active?"step":"false")+'"><span class="step-number">'+step.number+'</span><span class="step-copy"><strong>'+escapeHtml(step.title)+'</strong><small>'+escapeHtml(step.short)+'</small></span></button>';
    }).join("");
  }
  function renderContext(){
    var c=state.operationalContext,h=state.analysisHeader;
    el("contextHeader").innerHTML=contextItem("AnÃ¡lisis",h.id+" Â· Rev. "+h.revision)+contextItem("Activo piloto",c.pilotAsset)+contextItem("Sistema",c.system)+contextItem("ConfiguraciÃ³n",c.configuration)+contextItem("Criticidad",c.criticality);
  }
  function contextItem(label,value){return '<div class="context-item"><span>'+escapeHtml(label)+'</span><strong title="'+escapeHtml(value)+'">'+escapeHtml(value)+'</strong></div>';}
  function renderLanding(){
    var journey=steps.slice(1).map(function(s){return '<div class="journey-item"><strong>'+s.number+' Â· '+escapeHtml(s.title)+'</strong><span>'+escapeHtml(s.short)+'</span></div>';}).join("");
    el("viewHost").innerHTML='<section class="landing"><div class="landing-intro"><div><span class="eyebrow">IntroducciÃ³n Â· Paso 0</span><h1>Conservar el razonamiento detrÃ¡s de cada estrategia de mantenimiento</h1><p class="lead">Este recorrido conecta lo que un activo debe hacer, cÃ³mo puede fallar y quÃ© decisiÃ³n resulta adecuada para su contexto.</p><div class="key-message">AMEF identifica y analiza los fallos. RCM decide quÃ© hacer ante ellos.</div><div class="hero-actions"><button id="startButton" class="button button-primary" type="button">Comenzar anÃ¡lisis â†’</button><button id="tourButton" class="button button-secondary" type="button">Ver recorrido guiado</button><button class="link-button" type="button" data-rules>Ver datos y reglas</button></div></div><div class="analysis-contrast"><div class="contrast-block"><strong>AMEF Â· Comprender</strong><p>Ordena funciones, fallos funcionales, modos, causas, efectos y consecuencias.</p></div><div class="contrast-block rcm"><strong>RCM Â· Decidir</strong><p>Recorre preguntas explÃ­citas para recomendar una tarea, una decisiÃ³n sin tarea o un anÃ¡lisis pendiente.</p></div></div></div><div class="journey"><h2>Un recorrido, nueve decisiones de anÃ¡lisis</h2><p class="muted">La introducciÃ³n prepara el contexto; cada etapa posterior conserva entradas, reglas y resultados.</p><div class="journey-grid">'+journey+'</div></div>'+renderCaseBand()+'</section>';
    el("viewFooter").hidden=true;
  }
  function renderCaseBand(){
    var c=demo.operationalContext;
    return '<section class="case-band" aria-labelledby="caseTitle"><div class="case-summary"><span class="eyebrow">Caso conductor</span><h2 id="caseTitle">'+escapeHtml(demo.analysisHeader.title)+'</h2><p>'+escapeHtml(c.plant)+' Â· '+escapeHtml(c.subsystem)+'</p></div><div class="case-fact"><span class="eyebrow">Activos</span><strong>'+c.pilotAsset+' / '+c.redundantAsset+'</strong><p>'+escapeHtml(c.configuration)+'</p></div><div class="case-fact"><span class="eyebrow">Servicio</span><strong>'+escapeHtml(c.service)+'</strong><p>RÃ©gimen '+escapeHtml(c.regime.toLowerCase())+'</p></div><div class="case-fact"><span class="eyebrow">Contexto inicial</span><strong>Criticidad '+escapeHtml(c.criticality.toLowerCase())+'</strong><p>PÃ©rdida de caudal puede reducir producciÃ³n.</p></div></section>';
  }
  function renderStep(step){
    var inputItems=step.inputs.map(function(i){return "<li>"+escapeHtml(i)+"</li>";}).join(""),outputItems=step.outputs.map(function(i){return "<li>"+escapeHtml(i)+"</li>";}).join("");
    el("viewHost").innerHTML='<section class="step-view"><header class="step-heading"><div><span class="eyebrow">Paso '+step.number+' Â· '+escapeHtml(step.short)+'</span><h1>'+escapeHtml(step.question)+'</h1><p>'+escapeHtml(step.why)+'</p></div><span class="stage-badge">Se implementa en '+escapeHtml(step.sprint)+'</span></header><section class="why-panel"><h2>Por quÃ© importa</h2><p>'+escapeHtml(step.why)+'</p></section><div class="placeholder-grid"><section class="placeholder-panel"><h2>InformaciÃ³n prevista</h2><ul class="item-list">'+inputItems+'</ul></section><section class="placeholder-panel"><h2>Resultado que alimentarÃ¡ el siguiente paso</h2><ul class="item-list">'+outputItems+'</ul></section></div><div class="future-note"><strong>Placeholder funcional:</strong> la navegaciÃ³n y el contrato de esta etapa estÃ¡n activos. Sus formularios, tablas y validaciones se incorporarÃ¡n en '+escapeHtml(step.sprint)+'.</div><button class="link-button" type="button" data-rules>Ver datos y reglas</button></section>';
    el("viewFooter").hidden=false;el("backButton").disabled=false;el("nextButton").disabled=step.number===steps.length-1;el("stepPosition").textContent="Paso "+step.number+" de 9";el("nextButton").textContent=step.number===steps.length-1?"Fin del recorrido":"Siguiente â†’";
  }
  function render(){
    state=store.get();renderStepper();renderContext(); if(state.uiState.currentStep===0)renderLanding(); else if(state.uiState.currentStep<=4){el("viewHost").innerHTML=window.CMMS_P042.render(state.uiState.currentStep,state);el("viewFooter").hidden=false;el("backButton").disabled=false;el("nextButton").disabled=false;el("stepPosition").textContent="Paso "+state.uiState.currentStep+" de 9";el("nextButton").textContent="Siguiente →";} else renderStep(steps[state.uiState.currentStep]); renderSaveState();bindDynamic();document.title="CMMS 2.0 · "+steps[state.uiState.currentStep].title;
  }
  function bindDynamic(){
    var start=el("startButton"),tour=el("tourButton");if(start){start.addEventListener("click",function(){goTo(1);});}if(tour){tour.addEventListener("click",openTour);}
    Array.prototype.forEach.call(document.querySelectorAll("[data-rules]"),function(button){button.addEventListener("click",openDrawer);});
    if(state.uiState.currentStep>=1&&state.uiState.currentStep<=4)window.CMMS_P042.bind(state.uiState.currentStep,state,render,showToast);
  }
  function goTo(step){if(step<0||step>=steps.length)return;if(step>state.uiState.currentStep&&state.uiState.currentStep>=1&&state.uiState.currentStep<=4){var check=window.CMMS_P042.validate(state.uiState.currentStep,state);if(!check.valid){showToast(check.errors[0]);return;}}store.setStep(step);closeMenu();render();el("mainContent").focus();}
  function renderSaveState(){var s=el("saveState");if(state.uiState.dirty){s.textContent="Cambios sin guardar";return;}s.textContent=state.uiState.lastSavedAt?"Guardado localmente":"Sin cambios";}
  function showToast(message){var t=el("toast");t.textContent=message;t.hidden=false;clearTimeout(toastTimer);toastTimer=setTimeout(function(){t.hidden=true;},2600);}
  function openDrawer(){
    var step=steps[state.uiState.currentStep];
    el("drawerContent").innerHTML='<section class="rule-group"><h3>Entidad conceptual</h3><p>'+escapeHtml(step.entity)+'</p></section><section class="rule-group"><h3>ClasificaciÃ³n de la informaciÃ³n</h3><dl class="definition-list"><div><dt>Origen</dt><dd>Caso conductor y configuraciÃ³n de demostraciÃ³n.</dd></div><div><dt>Obligatoriedad</dt><dd>Se detallarÃ¡ con las validaciones del '+escapeHtml(step.sprint)+'.</dd></div><div><dt>Regla</dt><dd>'+escapeHtml(step.why)+'</dd></div><div><dt>Salida</dt><dd>'+escapeHtml(step.outputs.join("; "))+'</dd></div><div><dt>Pendiente para IT</dt><dd>Persistencia, identidad, auditorÃ­a e integraciÃ³n productiva.</dd></div></dl></section>';
    el("drawerBackdrop").hidden=false;el("rulesDrawer").classList.add("open");el("rulesDrawer").setAttribute("aria-hidden","false");setTimeout(function(){el("closeDrawerButton").focus();},0);
  }
  function closeDrawer(){el("rulesDrawer").classList.remove("open");el("rulesDrawer").setAttribute("aria-hidden","true");el("drawerBackdrop").hidden=true;}
  function openTour(){el("tourContent").innerHTML=steps.slice(1).map(function(s){return '<div class="tour-step"><strong>'+s.number+' Â· '+escapeHtml(s.title)+'</strong><span>'+escapeHtml(s.short)+'</span></div>';}).join("");el("tourDialog").showModal();}
  function toggleMenu(){var open=!el("sidebar").classList.contains("open");el("sidebar").classList.toggle("open",open);el("menuButton").setAttribute("aria-expanded",String(open));}
  function closeMenu(){el("sidebar").classList.remove("open");el("menuButton").setAttribute("aria-expanded","false");}
  function bindStatic(){
    el("stepper").addEventListener("click",function(e){var button=e.target.closest("[data-step]");if(button)goTo(Number(button.dataset.step));});
    el("backButton").addEventListener("click",function(){goTo(state.uiState.currentStep-1);});el("nextButton").addEventListener("click",function(){goTo(state.uiState.currentStep+1);});
    el("saveButton").addEventListener("click",function(){if(store.save()){state=store.get();renderSaveState();showToast("Borrador guardado en este navegador.");}else{showToast("No se pudo guardar. La demo puede continuar.");}});
    el("resetButton").addEventListener("click",function(){el("resetDialog").showModal();});el("cancelResetButton").addEventListener("click",function(){el("resetDialog").close();});
    el("confirmResetButton").addEventListener("click",function(){store.reset();el("resetDialog").close();render();showToast("DemostraciÃ³n reiniciada.");});
    el("menuButton").addEventListener("click",toggleMenu);el("closeDrawerButton").addEventListener("click",closeDrawer);el("drawerBackdrop").addEventListener("click",closeDrawer);
    el("closeTourButton").addEventListener("click",function(){el("tourDialog").close();});el("tourStartButton").addEventListener("click",function(){el("tourDialog").close();goTo(1);});
    document.addEventListener("keydown",function(e){if(e.key==="Escape"){closeDrawer();closeMenu();}});
  }
  bindStatic();render();
})();
