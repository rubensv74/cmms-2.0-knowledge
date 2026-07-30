(function(){
  var seed=window.CMMS_DEMO_CASE;
  window.CMMS_INITIAL_STATE={
    schemaVersion:"P04.2",
    analysisHeader:Object.assign({},seed.analysisHeader,{analysisType:"Tipo de equipo",taxonomyScope:"Mechanical > Rotating Equipment > Pump > Centrifugal Horizontal"}),
    operationalContext:Object.assign({},seed.operationalContext,{
      flh:"Planta Norte > Servicios > Agua de refrigeración > Impulsión principal",
      adrRoot:"P-101A",relatedAssets:["P-101A","P-101B"],
      fluid:"Agua de refrigeración",context:"Operación continua con configuración 2 x 100 %. La pérdida prolongada de caudal puede obligar a reducir producción.",
      source:"Manual del fabricante, histórico y experiencia de mantenimiento",
      assumptions:"La bomba de reserva está disponible y el fluido permanece dentro de los límites de diseño."
    }),
    functions:[{
      id:"FUN-001",description:"Transferir agua de refrigeración desde el depósito de cabecera al colector principal",type:"Primaria",
      performanceStandard:"Caudal mínimo 450 m³/h y presión de descarga mínima 5,5 bar",value:"450",unit:"m³/h",tolerance:"Mínimo",condition:"Operación normal",source:"Especificación de proceso y manual del fabricante",qualitativeReason:"",
      functionalFailures:[{
        id:"FF-001",functionId:"FUN-001",type:"Pérdida total o parcial",description:"Incapacidad total o parcial para suministrar el caudal y la presión requeridos",detectionCondition:"Caudal inferior a 450 m³/h o presión inferior a 5,5 bar",
        failureModes:[
          {id:"FM-001",functionalFailureId:"FF-001",description:"Degradación del conjunto de rodamientos y sello mecánico que provoca vibración creciente, pérdida de estanqueidad y reducción de capacidad",mechanism:"Desgaste y degradación progresiva",historicalEvidence:"Tendencias de vibración, temperatura y avisos de fuga",detectability:"Detectable",degradationSpeed:"Progresiva",hidden:false,
            causes:[{id:"CAU-001",description:"Lubricación insuficiente o contaminada",category:"Lubricación",control:"Ruta de lubricación",evidence:"Histórico de análisis de aceite"},{id:"CAU-002",description:"Desalineación bomba-motor",category:"Montaje",control:"Alineación láser",evidence:"Informe de montaje"},{id:"CAU-003",description:"Cavitación por baja presión de aspiración",category:"Operación",control:"Indicador de presión",evidence:"Tendencia de proceso"}],
            effects:[{id:"EFF-001",level:"Local",description:"Aumento progresivo de vibración y temperatura; fuga visible en el sello"},{id:"EFF-002",level:"Equipo",description:"Degradación del rendimiento y parada de la bomba en servicio"},{id:"EFF-003",level:"Sistema/planta",description:"Arranque de reserva y posible reducción de producción si no está disponible"}]},
          {id:"FM-002",functionalFailureId:"FF-001",description:"El arranque automático de la bomba de reserva no responde cuando se demanda",mechanism:"Fallo latente de la función de respaldo",historicalEvidence:"Prueba funcional o demanda real",detectability:"Oculto en operación normal",degradationSpeed:"Indeterminada",hidden:true,
            causes:[{id:"CAU-004",description:"Fallo del circuito de arranque o lógica de demanda",category:"Control",control:"Prueba funcional",evidence:"Registro de pruebas"}],
            effects:[{id:"EFF-004",level:"Local",description:"La bomba de reserva permanece parada ante la demanda"},{id:"EFF-005",level:"Sistema/planta",description:"Se pierde la redundancia y aumenta la exposición a pérdida de caudal"}]}
        ]
      }]
    }],
    proposedTasks:[],noTaskDecisions:[],applicabilityRules:[],assetApplications:[],approvalStages:[],changeLog:[],
    uiState:{currentStep:0,visitedSteps:[0],dirty:false,lastSavedAt:null,drawerOpen:false,menuOpen:false,selectedFunctionId:"FUN-001",selectedFailureId:"FF-001",selectedModeId:"FM-001"}
  };
})();
