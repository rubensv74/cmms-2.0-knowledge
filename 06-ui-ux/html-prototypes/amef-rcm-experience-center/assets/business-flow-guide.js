(()=>{
const GUIDES={
"01":{
  "title":"Construir conocimiento reusable antes de aplicarlo",
  "subtitle":"Crear una definición AMEF y una revisión gobernada con funciones, fallos, modos, causas, efectos y evidencia que puedan reutilizarse en activos equivalentes.",
  "question":"¿Qué conocimiento pertenece a la biblioteca y debe sobrevivir independientemente de P-101?",
  "steps":[
    ["Identificar la biblioteca","Seleccionar o crear FmeaDefinition con alcance de equipo/función y responsabilidad clara."],
    ["Abrir una revisión","Trabajar en FmeaRevision; una revisión publicada queda inmutable."],
    ["Definir funciones y fallos","Registrar funciones medibles y sus fallos funcionales con identidad propia."],
    ["Identificar modos","Relacionar cada FailureMode con el fallo funcional que puede producir."],
    ["Separar causas y efectos","Registrar FailureCause y FailureEffect como objetos trazables, no texto mezclado en el modo."],
    ["Comprobar evidencia","Confirmar fuentes, supuestos y vacíos antes de evaluar consecuencias."]
  ],
  "roles":[
    "Fiabilidad mantiene la estructura metodológica y la coherencia de biblioteca.",
    "Mantenimiento aporta mecanismos de degradación y experiencia técnica.",
    "Operaciones aporta condiciones de referencia y estándares funcionales.",
    "Ingeniería aporta diseño, límites e interfaces.",
    "HSE participa cuando funciones o efectos tienen relevancia de seguridad o medioambiente."
  ],
  "decisions":[
    "Qué conocimiento es reusable y no específico de P-101.",
    "Qué revisión se está modificando y por qué.",
    "Qué funciones, fallos y modos se incluyen o excluyen.",
    "Qué causas/efectos tienen evidencia suficiente."
  ],
  "outputs":[
    "FmeaDefinition y FmeaRevision identificadas.",
    "Árbol función → fallo → modo con IDs.",
    "Causas y efectos explícitos.",
    "Evidencias y supuestos de biblioteca.",
    "Gate preparado para consecuencia y RCM."
  ],
  "mistakes":[
    "Empezar el AMEF creando P-101 como raíz.",
    "Clonar el análisis por cada activo o nivel de criticidad.",
    "Confundir modo con causa/mecanismo.",
    "Guardar relaciones solo dentro de textos visibles."
  ],
  "example":"La función 'transferir agua de refrigeración' y el modo 'degradación de rodamientos' pertenecen a la revisión reusable FMEA-CWPUMP-001. P-101 todavía no es necesario para definirlos."
},
"02":{
  "title":"Evaluar consecuencias sin confundir riesgo y criticidad",
  "subtitle":"Aplicar una matriz AMEF versionada al modo de fallo y conservar evidencia, controles y valoración humana.",
  "question":"¿Qué consecuencia y riesgo AMEF tiene este modo según la metodología identificada?",
  "steps":[
    ["Seleccionar la matriz","Identificar la versión de matriz y el contexto/perfil utilizado para la evaluación."],
    ["Revisar efectos","Partir de FailureEffect y evidencia, no de una puntuación aislada."],
    ["Valorar consecuencias","Clasificar seguridad, medioambiente, operación, no operación u ocultas según el método vigente."],
    ["Calcular indicadores","Aplicar S/O/D u otras dimensiones únicamente según la matriz/version seleccionada."],
    ["Revisar controles","Documentar controles existentes y comprobar su eficacia/evidencia."],
    ["Superar el gate","Confirmar que el expediente puede entrar en RCM o dejar clara la excepción."]
  ],
  "roles":[
    "Fiabilidad facilita consistencia y trazabilidad.",
    "Operaciones valida efectos operacionales y detectabilidad real.",
    "Mantenimiento valida frecuencia, mecanismos y controles.",
    "HSE revisa consecuencias de seguridad y ambientales.",
    "La autoridad final sigue pendiente de validación corporativa."
  ],
  "decisions":[
    "Versión de matriz utilizada.",
    "Valores y justificaciones del ConsequenceAssessment.",
    "Evidencia suficiente o necesidad de investigación.",
    "Excepciones que deben viajar a RCM."
  ],
  "outputs":[
    "ConsequenceAssessment trazable al FailureMode.",
    "Resultado de riesgo AMEF explicable.",
    "Controles y evidencia asociados.",
    "Gate hacia RCM."
  ],
  "mistakes":[
    "Llamar 'criticidad del activo' al resultado S×O o NPR.",
    "Usar NPR como única regla de decisión.",
    "Puntuar sin versión de matriz o evidencia.",
    "Dar por eficaz un control solo porque existe."
  ],
  "example":"El riesgo AMEF de FM-CWPUMP-003 se calcula dentro de la revisión de biblioteca. La criticidad corporativa de P-101 aparecerá después, cuando esa revisión se aplique al activo."
},
"03":{
  "title":"Decidir con RCM y diseñar el tratamiento reusable",
  "subtitle":"Conservar el camino del árbol RCM, permitir una salida explícita sin tarea y diseñar tareas que puedan tratar varios modos.",
  "question":"¿Qué tratamiento técnicamente válido debe formar parte de la revisión reusable y qué evidencia lo sostiene?",
  "steps":[
    ["Ejecutar lógica RCM","Registrar respuestas sobre fallo evidente, detectabilidad, P–F y alternativas usando una versión identificada del árbol."],
    ["Conservar recomendación y decisión","Diferenciar systemRecommendation de humanDecision y documentar cualquier override."],
    ["Resolver la salida","Crear MaintenanceTask o NoScheduledTaskDecision; nunca dejar la ausencia de tarea implícita."],
    ["Relacionar tareas y modos","Usar la relación N:M para indicar qué modos detecta, previene, mitiga o verifica cada tarea."],
    ["Separar adjuntos","Asociar MaintenanceProcedure e InspectionFormat de forma opcional y versionada."],
    ["Evaluar economía y publicar","Separar MaintenanceCostEstimate de EconomicAssessment y congelar la FmeaRevision cuando supere gobernanza."]
  ],
  "roles":[
    "Fiabilidad conduce y documenta la decisión RCM.",
    "Mantenimiento confirma viabilidad técnica de tareas y procedimientos.",
    "Operaciones valida detectabilidad y condiciones de intervención.",
    "Costes aporta supuestos para estimación/comparación.",
    "Los aprobadores publican una revisión inmutable según el workflow que se valide."
  ],
  "decisions":[
    "Recomendación RCM y decisión humana final.",
    "Salida con tarea o sin tarea programada.",
    "Relaciones N:M y propósito técnico de cada vínculo.",
    "Necesidad de procedimiento y/o formato.",
    "Coste estimado y comparación económica entre alternativas técnicamente válidas."
  ],
  "outputs":[
    "RcmAssessment con respuestas y evidencia.",
    "MaintenanceTask reusable o NoScheduledTaskDecision.",
    "MaintenanceTaskFailureMode links.",
    "Procedimiento/formato opcionales.",
    "FmeaRevision publicada e inmutable."
  ],
  "mistakes":[
    "Tratar RCM como un algoritmo que sustituye autoridad humana.",
    "Forzar que todo resultado RCM genere una tarea.",
    "Vincular cada tarea a un único modo por comodidad de UI.",
    "Guardar el procedimiento completo dentro de MaintenanceTask.",
    "Permitir que un ahorro económico valide una política técnicamente inválida."
  ],
  "example":"MT-CWPUMP-001 puede monitorizar señales compatibles con degradación de rodamientos y desalineación. Una segunda tarea puede tratar también FM-CWPUMP-003: el modelo no necesita duplicar ninguna de ellas."
},
"04":{
  "title":"Aplicar la biblioteca a P-101 y construir su plan",
  "subtitle":"Evaluar una revisión publicada sobre un activo y convertir solo las tareas aplicables en un Execution Plan contextual.",
  "question":"¿Qué parte de FMEA-CWPUMP-001 Rev 1 aplica realmente a P-101 y cómo debe ejecutarse en su contexto?",
  "steps":[
    ["Crear la aplicación","Vincular FmeaRevision y Asset mediante FmeaAssetApplication."],
    ["Congelar contexto","Capturar servicio, condiciones, redundancia y restricciones relevantes de P-101."],
    ["Leer criticidad","Recibir AssetCriticalitySnapshot desde un esquema/fuente independiente del riesgo AMEF."],
    ["Evaluar aplicabilidad","El sistema sugiere y una persona valida tareas, perfiles, variantes u overrides."],
    ["Instanciar el plan","Crear ExecutionPlanTask conservando MaintenanceTaskId de origen."],
    ["Contextualizar ejecución","Definir intervalo efectivo, recursos, alcance, procedimiento/formato y agrupación sin modificar la biblioteca."]
  ],
  "roles":[
    "Fiabilidad valida la aplicabilidad de la revisión.",
    "Responsable del activo aporta/valida criticidad y contexto.",
    "Mantenimiento confirma recursos y ejecución.",
    "Operaciones valida condiciones operativas, accesos y ventanas.",
    "Planificación configura el trabajo contextual."
  ],
  "decisions":[
    "Resultado de aplicabilidad para P-101.",
    "Criticidad recibida y cualquier override autorizado.",
    "Variantes de intervalo o condición con motivo.",
    "Recursos, alcance, procedimiento/formato y agrupación del plan."
  ],
  "outputs":[
    "FmeaAssetApplication validada.",
    "AssetCriticalitySnapshot independiente del AMEF.",
    "ExecutionPlan y ExecutionPlanTask trazables a la biblioteca.",
    "Plan contextual preparado para ejecución/publicación."
  ],
  "mistakes":[
    "Copiar toda la revisión AMEF dentro de P-101.",
    "Modificar una FmeaRevision publicada para acomodar una excepción del activo.",
    "Inferir la criticidad de P-101 desde S×O o NPR.",
    "Perder el MaintenanceTaskId reusable al crear el plan."
  ],
  "example":"P-101 puede usar MT-CWPUMP-001 cada 21 días mientras otro activo equivalente usa un intervalo contextual distinto. Ambos siguen apuntando a la misma tarea reusable y revisión de biblioteca."
},
"05":{
  "title":"Registrar resultados y decidir qué debe cambiar",
  "subtitle":"Comparar ejecución real con hipótesis y distinguir un ajuste contextual de un cambio del conocimiento de ingeniería.",
  "question":"¿Los resultados reales confirman el plan y la ingeniería que lo originó o debemos abrir una revisión?",
  "steps":[
    ["Registrar resultado","Capturar MaintenanceResult, mediciones, hallazgos y evidencia contra ExecutionPlanTask."],
    ["Registrar coste real","Crear ActualMaintenanceCost sin sobrescribir MaintenanceCostEstimate."],
    ["Comparar hipótesis","Contrastar P–F, frecuencia, hallazgos, eficacia y coste con lo esperado."],
    ["Determinar el alcance","Decidir si el problema pertenece al activo/plan o cuestiona la biblioteca."],
    ["Ajustar contexto si procede","Crear nueva revisión de aplicación/plan cuando la ingeniería reusable siga siendo válida."],
    ["Reabrir ingeniería si procede","Abrir EngineeringChangeRequest y una nueva FmeaRevision sin modificar la publicada."]
  ],
  "roles":[
    "Mantenimiento registra ejecución y hallazgos.",
    "Operaciones aporta cambios de contexto y consecuencias observadas.",
    "Costes registra/importa el coste real según la futura integración.",
    "Fiabilidad ejecuta EffectivenessReview.",
    "La gobernanza decide si corresponde nueva revisión de biblioteca."
  ],
  "decisions":[
    "Si la desviación es contextual o de ingeniería.",
    "Si se mantiene o revisa el plan.",
    "Si se abre EngineeringChangeRequest.",
    "Qué hipótesis debe revalidarse sin borrar la versión anterior."
  ],
  "outputs":[
    "MaintenanceResult y ActualMaintenanceCost trazables.",
    "EffectivenessReview.",
    "Ajuste de aplicación/plan o EngineeringChangeRequest.",
    "Historia completa conservada desde biblioteca hasta resultado."
  ],
  "mistakes":[
    "Sobrescribir la estimación con el coste real.",
    "Cambiar silenciosamente una frecuencia publicada después de un hallazgo.",
    "Crear nueva revisión AMEF por cualquier variación específica de P-101.",
    "Perder la revisión exacta que originó el trabajo ejecutado."
  ],
  "example":"Si una tendencia aparece antes de lo previsto, primero se determina si P-101 necesita un ajuste contextual o si la hipótesis P–F reusable es incorrecta. Solo el segundo caso justifica revisar la biblioteca."
}
};
const esc=s=>String(s??'').replace(/[&<>"]/g,c=>({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;'}[c]));
function list(items){return items.map(x=>`<li>${esc(x)}</li>`).join('')}
function build(g){const steps=g.steps.map((x,i)=>`<div class="biz-step"><span class="biz-step-num">${String(i+1).padStart(2,'0')}</span><h3>${esc(x[0])}</h3><p>${esc(x[1])}</p></div>`).join('');return `<div class="biz-modal" id="businessGuideModal" role="dialog" aria-modal="true" aria-hidden="true" aria-labelledby="businessGuideTitle"><div class="biz-dialog"><div class="biz-head"><div><span class="biz-kicker">Guía práctica del flujo de negocio</span><h2 id="businessGuideTitle">${esc(g.title)}</h2><p>${esc(g.subtitle)}</p></div><button class="biz-close" type="button" data-biz-close aria-label="Cerrar guía">×</button></div><div class="biz-body"><div class="biz-question"><b>Pregunta que debe responder el negocio</b>${esc(g.question)}</div><h3>Flujo lógico</h3><div class="biz-flow">${steps}</div><div class="biz-grid"><div class="biz-card"><h3>Quién interviene</h3><ul>${list(g.roles)}</ul></div><div class="biz-card"><h3>Decisiones que deben quedar registradas</h3><ul>${list(g.decisions)}</ul></div><div class="biz-card output"><h3>Resultado esperado</h3><ul>${list(g.outputs)}</ul></div><div class="biz-card warning"><h3>Errores que conviene evitar</h3><ul>${list(g.mistakes)}</ul></div></div><div class="biz-example"><b>Ejemplo práctico · P-101 como aplicación</b><p>${esc(g.example)}</p></div></div><div class="biz-footer"><small>Esta guía describe el proceso de negocio propuesto para CMMS 2.0; no explica cómo utilizar la pantalla.</small><button type="button" data-biz-close>Volver al análisis</button></div></div></div>`}
function init(){const script=document.currentScript||[...document.scripts].find(s=>s.dataset.businessGuide);const id=script?.dataset.businessGuide||document.body.dataset.businessGuide;const g=GUIDES[id];if(!g||document.getElementById('businessInfoBtn'))return;const host=document.querySelector('header .actions')||document.querySelector('header nav')||document.querySelector('header');if(!host)return;const trigger=document.createElement('button');trigger.className='btn biz-info-trigger';trigger.id='businessInfoBtn';trigger.type='button';trigger.title='Guía práctica del flujo de negocio';trigger.setAttribute('aria-label','Abrir guía práctica del flujo de negocio');trigger.innerHTML='<span aria-hidden="true">ⓘ</span>';host.appendChild(trigger);document.body.insertAdjacentHTML('beforeend',build(g));const modal=document.getElementById('businessGuideModal');const close=()=>{modal.classList.remove('open');modal.setAttribute('aria-hidden','true');trigger.focus()};const open=()=>{modal.classList.add('open');modal.setAttribute('aria-hidden','false');modal.querySelector('[data-biz-close]')?.focus()};trigger.addEventListener('click',open);modal.querySelectorAll('[data-biz-close]').forEach(x=>x.addEventListener('click',close));modal.addEventListener('click',e=>{if(e.target===modal)close()});document.addEventListener('keydown',e=>{if(e.key==='Escape'&&modal.classList.contains('open'))close()})}
if(document.readyState==='loading')document.addEventListener('DOMContentLoaded',init);else init();
})();
