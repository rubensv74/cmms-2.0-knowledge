(function(){
  window.CMMS_P044_CATALOGS={
    taskTypes:["Basada en condición","Inspección","Análisis de lubricante","Revisión de intervalo","Búsqueda de fallos","Restauración programada","Sustitución programada"],
    techniques:["Análisis de vibraciones","Inspección visual y termografía","Análisis de aceite","Revisión de datos","Prueba funcional"],
    disciplines:["Mecánica","Fiabilidad","Operaciones","Instrumentación"],
    roles:["Técnico predictivo","Técnico mecánico","Ingeniero de fiabilidad","Operador de campo","Técnico de instrumentación"],
    operationalStates:["En servicio","Parado","Reserva disponible","Indiferente"],
    noTaskTypes:["Operar hasta el fallo","Rediseño/modificación","Ausencia de tarea eficaz"],
    applicabilityResults:["Aplicable","Parcial","Revisión","Pendiente","No aplicable"],
    profiles:[
      {id:"PERF-ALTA",name:"Alta criticidad",effect:"Mantiene tareas y prioriza intervalos conservadores."},
      {id:"PERF-MEDIA",name:"Media criticidad",effect:"Requiere revisar frecuencia con histórico local."},
      {id:"PERF-BAJA",name:"Baja criticidad",effect:"Permite valorar operar hasta fallo si las consecuencias lo permiten."},
      {id:"PERF-RESERVA",name:"Reserva/protección",effect:"Añade prueba funcional de la función oculta."}
    ]
  };
})();
