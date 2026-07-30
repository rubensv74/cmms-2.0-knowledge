(function(){
  var state=window.CMMS_INITIAL_STATE;
  state.schemaVersion="P04.5";
  state.analysisHeader.status="En revisión";
  state.analysisHeader.snapshotId=null;
  state.analysisHeader.publishedAt=null;
  state.approvalStages=[
    stage("APP-01","Fiabilidad","Aprobada","Laura Martín · Fiabilidad","2026-07-28","Método y evidencias revisados."),
    stage("APP-02","Mantenimiento","Aprobada","Carlos Vega · Mantenimiento","2026-07-29","Tareas y criterios revisados."),
    stage("APP-03","Operaciones","Aprobada","Ana Ruiz · Operaciones","2026-07-30","Contexto y respuesta operacional confirmados."),
    stage("APP-04","HSE","Pendiente","","",""),
    stage("APP-05","Aprobación final","Pendiente","","","")
  ];
  state.changeLog=[
    {id:"CHG-001",date:"2026-07-28",user:"Laura Martín",action:"Análisis enviado a revisión",detail:"Revisión 0.1"},
    {id:"CHG-002",date:"2026-07-29",user:"Carlos Vega",action:"Etapa de Mantenimiento aprobada",detail:"Tareas revisadas"},
    {id:"CHG-003",date:"2026-07-30",user:"Ana Ruiz",action:"Etapa de Operaciones aprobada",detail:"Contexto confirmado"}
  ];
  state.uiState.reviewTab=state.uiState.reviewTab||"review";
  function stage(id,name,status,actor,date,comment){return{id:id,name:name,status:status,actor:actor,date:date,comment:comment};}
})();
