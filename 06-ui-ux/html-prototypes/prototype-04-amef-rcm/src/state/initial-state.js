(function(){
  var seed=window.CMMS_DEMO_CASE;
  window.CMMS_INITIAL_STATE={
    analysisHeader:seed.analysisHeader,
    operationalContext:seed.operationalContext,
    functions:[],proposedTasks:[],noTaskDecisions:[],applicabilityRules:[],assetApplications:[],approvalStages:[],changeLog:[],
    uiState:{currentStep:0,visitedSteps:[0],dirty:false,lastSavedAt:null,drawerOpen:false,menuOpen:false}
  };
})();
