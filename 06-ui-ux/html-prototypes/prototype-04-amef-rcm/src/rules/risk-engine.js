(function(){
  function level(score){if(score<=4)return{label:"Bajo",className:"low"};if(score<=9)return{label:"Moderado",className:"medium"};if(score<=16)return{label:"Alto",className:"high"};return{label:"Crítico",className:"critical"};}
  function calculate(severity,probability){var score=Number(severity)*Number(probability);return{score:score,level:level(score)};}
  function validate(assessment){var errors=[];if(!assessment)errors.push("Completa la evaluación de consecuencias.");else{if(!assessment.justification.trim())errors.push("Justifica la puntuación inherente.");if(!assessment.residualJustification.trim())errors.push("Justifica la evaluación residual.");if(!assessment.matrixVersion)errors.push("Registra la versión de la matriz.");}return{valid:errors.length===0,errors:errors};}
  window.CMMS_RISK_ENGINE={calculate:calculate,validate:validate};
})();
