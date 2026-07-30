(function(){
  if(window.CMMS_INITIAL_STATE)window.CMMS_INITIAL_STATE.schemaVersion="P04.6";
  window.CMMS_P046_SCENARIOS=[
    {id:"complete",label:"Contenido completo",step:null,tone:"success",message:"Caso conductor completo y listo para recorrer."},
    {id:"loading",label:"Carga inicial",step:0,tone:"info",message:"Cargando configuración, catálogos y caso conductor…"},
    {id:"empty",label:"Paso vacío",step:2,tone:"neutral",message:"Aún no hay funciones en esta vista de demostración."},
    {id:"validation",label:"Error de validación",step:1,tone:"danger",message:"Falta contexto operacional. Complétalo antes de avanzar."},
    {id:"incomplete",label:"Datos incompletos",step:4,tone:"warning",message:"El modo necesita al menos un efecto documentado."},
    {id:"saved",label:"Guardado correcto",step:null,tone:"success",message:"Borrador guardado localmente con fecha simulada."},
    {id:"dirty",label:"Cambio sin guardar",step:null,tone:"warning",message:"Hay cambios sin guardar en la etapa actual."},
    {id:"insufficient",label:"Información insuficiente RCM",step:6,tone:"warning",message:"La evidencia no permite cerrar el recorrido. Resultado: Análisis pendiente."},
    {id:"override",label:"Override sin justificar",step:6,tone:"danger",message:"El override no puede guardarse hasta indicar un motivo."},
    {id:"app-review",label:"Aplicabilidad en revisión",step:8,tone:"warning",message:"La sugerencia automática requiere decisión humana y motivo."},
    {id:"returned",label:"Aprobación devuelta",step:9,tone:"danger",message:"La etapa fue devuelta con comentarios y requiere cambios."},
    {id:"published",label:"Revisión publicada",step:9,tone:"published",message:"Snapshot publicado. La revisión se muestra en modo solo lectura."},
    {id:"recoverable",label:"Error recuperable",step:null,tone:"danger",message:"No se pudo completar la operación simulada. Los datos locales se conservan y se puede reintentar."}
  ];
})();
