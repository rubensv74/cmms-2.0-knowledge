(function(){
  var seed=window.CMMS_DEMO_CASE;
  window.CMMS_INITIAL_STATE={
    schemaVersion:"P04.2",
    analysisHeader:Object.assign({},seed.analysisHeader,{analysisType:"Tipo de equipo",taxonomyScope:"Mechanical > Rotating Equipment > Pump > Centrifugal Horizontal"}),
    operationalContext:Object.assign({},seed.operationalContext,{
      flh:"Planta Norte > Servicios > Agua de refrigeraciÃ³n > ImpulsiÃ³n principal",
      adrRoot:"P-101A",relatedAssets:["P-101A","P-101B"],
      fluid:"Agua de refrigeraciÃ³n",context:"OperaciÃ³n continua con configuraciÃ³n 2 x 100 %. La pÃ©rdida prolongada de caudal puede obligar a reducir producciÃ³n.",
      source:"Manual del fabricante, histÃ³rico y experiencia de mantenimiento",
      assumptions:"La bomba de reserva estÃ¡ disponible y el fluido permanece dentro de los lÃ­mites de diseÃ±o."
    }),
    functions:[{
      id:"FUN-001",description:"Transferir agua de refrigeraciÃ³n desde el depÃ³sito de cabecera al colector principal",type:"Primaria",
      performanceStandard:"Caudal mÃ­nimo 450 mÂ³/h y presiÃ³n de descarga mÃ­nima 5,5 bar",value:"450",unit:"mÂ³/h",tolerance:"MÃ­nimo",condition:"OperaciÃ³n normal",source:"EspecificaciÃ³n de proceso y manual del fabricante",qualitativeReason:"",
      functionalFailures:[{
        id:"FF-001",functionId:"FUN-001",type:"PÃ©rdida total o parcial",description:"Incapacidad total o parcial para suministrar el caudal y la presiÃ³n requeridos",detectionCondition:"Caudal inferior a 450 mÂ³/h o presiÃ³n inferior a 5,5 bar",
        failureModes:[
          {id:"FM-001",functionalFailureId:"FF-001",description:"DegradaciÃ³n del conjunto de rodamientos y sello mecÃ¡nico que provoca vibraciÃ³n creciente, pÃ©rdida de estanqueidad y reducciÃ³n de capacidad",mechanism:"Desgaste y degradaciÃ³n progresiva",historicalEvidence:"Tendencias de vibraciÃ³n, temperatura y avisos de fuga",detectability:"Detectable",degradationSpeed:"Progresiva",hidden:false,
            causes:[{id:"CAU-001",description:"LubricaciÃ³n insuficiente o contaminada",category:"LubricaciÃ³n",control:"Ruta de lubricaciÃ³n",evidence:"HistÃ³rico de anÃ¡lisis de aceite"},{id:"CAU-002",description:"DesalineaciÃ³n bomba-motor",category:"Montaje",control:"AlineaciÃ³n lÃ¡ser",evidence:"Informe de montaje"},{id:"CAU-003",description:"CavitaciÃ³n por baja presiÃ³n de aspiraciÃ³n",category:"OperaciÃ³n",control:"Indicador de presiÃ³n",evidence:"Tendencia de proceso"}],
            effects:[{id:"EFF-001",level:"Local",description:"Aumento progresivo de vibraciÃ³n y temperatura; fuga visible en el sello"},{id:"EFF-002",level:"Equipo",description:"DegradaciÃ³n del rendimiento y parada de la bomba en servicio"},{id:"EFF-003",level:"Sistema/planta",description:"Arranque de reserva y posible reducciÃ³n de producciÃ³n si no estÃ¡ disponible"}]},
          {id:"FM-002",functionalFailureId:"FF-001",description:"El arranque automÃ¡tico de la bomba de reserva no responde cuando se demanda",mechanism:"Fallo latente de la funciÃ³n de respaldo",historicalEvidence:"Prueba funcional o demanda real",detectability:"Oculto en operaciÃ³n normal",degradationSpeed:"Indeterminada",hidden:true,
            causes:[{id:"CAU-004",description:"Fallo del circuito de arranque o lÃ³gica de demanda",category:"Control",control:"Prueba funcional",evidence:"Registro de pruebas"}],
            effects:[{id:"EFF-004",level:"Local",description:"La bomba de reserva permanece parada ante la demanda"},{id:"EFF-005",level:"Sistema/planta",description:"Se pierde la redundancia y aumenta la exposiciÃ³n a pÃ©rdida de caudal"}]}
        ]
      }]
    }],
    proposedTasks:[],noTaskDecisions:[],applicabilityRules:[],assetApplications:[],approvalStages:[],changeLog:[],
    uiState:{currentStep:0,visitedSteps:[0],dirty:false,lastSavedAt:null,drawerOpen:false,menuOpen:false,selectedFunctionId:"FUN-001",selectedFailureId:"FF-001",selectedModeId:"FM-001"}
  };
})();
