(function(){
  var STORAGE_KEY="cmms2.prototype04.state.v6",clone=function(value){return JSON.parse(JSON.stringify(value));},state=clone(window.CMMS_INITIAL_STATE);
  function load(){
    try{
      var saved=localStorage.getItem(STORAGE_KEY),parsed=saved?JSON.parse(saved):null;
      if(parsed&&parsed.schemaVersion===window.CMMS_INITIAL_STATE.schemaVersion){state=Object.assign(clone(window.CMMS_INITIAL_STATE),parsed);state.uiState=Object.assign(clone(window.CMMS_INITIAL_STATE.uiState),parsed.uiState||{});}
    }catch(error){state=clone(window.CMMS_INITIAL_STATE);}
    return state;
  }
  function get(){return state;}
  function setStep(step){state.uiState.currentStep=step;if(state.uiState.visitedSteps.indexOf(step)<0)state.uiState.visitedSteps.push(step);state.uiState.dirty=true;}
  function markDirty(){state.uiState.dirty=true;}
  function save(){try{state.uiState.dirty=false;state.uiState.lastSavedAt=new Date().toISOString();localStorage.setItem(STORAGE_KEY,JSON.stringify(state));return true;}catch(error){return false;}}
  function reset(){state=clone(window.CMMS_INITIAL_STATE);try{localStorage.removeItem(STORAGE_KEY);}catch(error){}return state;}
  window.CMMS_STORE={load:load,get:get,setStep:setStep,markDirty:markDirty,save:save,reset:reset,storageKey:STORAGE_KEY};
})();
