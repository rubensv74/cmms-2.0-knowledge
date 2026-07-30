(function(){
  window.CMMS_P043_CATALOGS={
    risk:{
      version:"DEMO-RISK-5X5-v1",
      disclaimer:"Ejemplo configurable. No representa una matriz corporativa aprobada.",
      severity:[{value:1,label:"Insignificante"},{value:2,label:"Menor"},{value:3,label:"Moderada"},{value:4,label:"Mayor"},{value:5,label:"Crítica"}],
      probability:[{value:1,label:"Rara"},{value:2,label:"Improbable"},{value:3,label:"Posible"},{value:4,label:"Probable"},{value:5,label:"Casi segura"}],
      dimensions:["Seguridad","Medioambiente","Operación/producción","Calidad","Coste directo","No operacional"]
    },
    rcm:{
      version:"DEMO-RCM-v1",
      answers:["Sí","No","Información insuficiente"],
      questions:[
        {id:"Q1",plain:"¿El fallo es oculto?",technical:"¿La pérdida de función no resulta evidente para el personal en operación normal?"},
        {id:"Q2",plain:"¿Afecta a seguridad o medioambiente?",technical:"¿Puede incumplir requisitos de seguridad o ambientales?"},
        {id:"Q3",plain:"¿Afecta significativamente a operación?",technical:"¿Tiene consecuencias operacionales relevantes?"},
        {id:"Q4",plain:"¿Existe degradación detectable antes del fallo?",technical:"¿Hay una condición potencial identificable?"},
        {id:"Q5",plain:"¿El intervalo P-F permite actuar?",technical:"¿El tiempo entre condición potencial y fallo funcional es suficiente?"},
        {id:"Q6",plain:"¿Una tarea basada en condición es eficaz?",technical:"¿La tarea detecta la condición con intervalo y criterio adecuados?"},
        {id:"Q7",plain:"¿Existe restauración o sustitución programada eficaz?",technical:"¿La edad condiciona la probabilidad y la tarea reduce el riesgo?"},
        {id:"Q8",plain:"¿Es necesaria una búsqueda de fallos?",technical:"¿Una prueba funcional periódica revela el fallo oculto?"},
        {id:"Q9",plain:"¿Es aceptable operar hasta el fallo?",technical:"Si no existe tarea eficaz: Sí conduce a operar hasta fallo; No requiere rediseño/modificación."}
      ],
      results:["Mantenimiento basado en condición","Restauración programada","Sustitución programada","Búsqueda de fallos","Operar hasta el fallo","Rediseño/modificación","Análisis pendiente"]
    }
  };
})();
