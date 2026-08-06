# AMEF–RCM Experience Center — Contexto, estado y decisiones

**Proyecto:** Revisión conceptual CMMS 2.0  
**Fecha de referencia:** 6 de agosto de 2026  
**Caso conductor:** bomba centrífuga P-101  
**Finalidad:** aportar a NotebookLM el contexto necesario para generar un vídeo fiel al estado real del trabajo.

## 1. Qué es el Experience Center

El AMEF–RCM Experience Center es una demostración funcional y pedagógica creada para explicar cómo podría organizarse en CMMS 2.0 el proceso que transforma el conocimiento de un activo en una estrategia y un plan de mantenimiento justificables.

No es una aplicación implantada, una especificación técnica cerrada ni un plan de mantenimiento aprobado. Es un artefacto de análisis funcional destinado a mantener la coherencia entre las reuniones semanales, las decisiones del negocio, los prototipos HTML y la futura especificación para IT.

La versión actual utiliza un caso realista, P-101, y recorre 28 etapas encadenadas. Cada etapa muestra:

- la pregunta que debe responder el negocio;
- la información disponible;
- la acción que debe realizar el equipo;
- la decisión que debe registrarse;
- el gate que controla el avance;
- la salida que recibe la etapa siguiente.

Los cinco bloques son:

1. Comprender el problema.
2. Evaluar el riesgo mediante AMEF.
3. Tomar una decisión mediante RCM.
4. Convertir la decisión en un plan ejecutable.
5. Gobernar, aprobar y mejorar con datos reales.

La idea central es que el plan de mantenimiento no se genera por defecto ni por costumbre: aparece como resultado de un razonamiento estructurado, trazable y revisable.

## 2. Por qué se ha creado

En muchos entornos las tareas preventivas se incorporan porque ya existían, porque las recomienda un fabricante o porque alguien con experiencia considera que son adecuadas. Ese conocimiento es valioso, pero no siempre queda documentado qué función protege cada tarea, qué modo de fallo controla, qué riesgo la justifica o por qué se eligió una frecuencia concreta.

El planteamiento de CMMS 2.0 busca conservar explícitamente esta cadena:

**Activo y contexto → funciones → fallos funcionales → modos de fallo → efectos y consecuencias → riesgo AMEF → decisión RCM → tarea → intervalo → recursos → plan → aprobación → resultados reales → revisión.**

La interfaz sirve como herramienta didáctica. El objetivo real es validar el proceso de negocio antes de cerrar el modelo de datos o solicitar un desarrollo a IT.

## 3. Qué existe actualmente

- Mapa maestro del recorrido completo.
- Cinco prototipos, uno por bloque funcional.
- Recorrido guiado principal de 28 etapas.
- Caso P-101 coherente de extremo a extremo.
- Gates que explican qué falta para avanzar.
- Registro acumulado de decisiones.
- Persistencia local y exportación JSON.
- Documentación para público general.
- Guías prácticas del flujo de negocio.
- Paquete offline ejecutable desde un único `index.html`.
- Rama y pull request en borrador, sin integración todavía en `main`.

El material representa una propuesta funcional avanzada. No define todavía la tecnología, la integración exacta, el workflow aprobado, los catálogos corporativos ni las reglas definitivas.

## 4. Principios consolidados en las reuniones

Estos principios deben presentarse como base ya aceptada conceptualmente:

1. El proceso comienza entendiendo el activo y sus funciones, no definiendo tareas preventivas.
2. AMEF y RCM son complementarios: AMEF estructura efectos, consecuencias y riesgo; RCM estructura la elección de la política.
3. El plan es un resultado del análisis.
4. Las decisiones deben ser trazables y justificables.
5. El enfoque debe ser pedagógico antes de entrar en detalles técnicos.
6. Las alternativas descartadas, evidencias y responsables deben conservarse.
7. El análisis no termina al publicar el plan; debe aprender de la ejecución real.
8. La integración técnica se definirá después. El trabajo actual es análisis funcional y prototipado.

## 5. Caso P-101

### Identificación y contexto

- Código: P-101.
- Equipo: bomba centrífuga de agua de refrigeración.
- Unidad: Unidad de proceso A.
- Servicio: transferir agua de refrigeración al intercambiador E-201.
- Frontera: desde la brida de aspiración hasta la brida de descarga, incluyendo motor M-101, acoplamiento y protecciones.
- Demanda: 120 m³/h a 6 bar.
- Redundancia: P-102 en reserva automática.
- Restricción: una pérdida de caudal superior a 20 minutos afecta a producción y puede elevar la temperatura del proceso.

### Evidencias

El ejemplo utiliza ficha técnica, P&ID, histórico de órdenes de trabajo, manual O&M y entrevista con Operaciones. La confianza inicial es media-alta. El mínimo de cuatro fuentes utilizado por el gate es una propuesta conceptual pendiente de validación.

### Funciones

- Función principal: transferir 120 m³/h de agua de refrigeración a 6 bar durante la operación normal.
- Función secundaria: contener el fluido sin fuga visible y transmitir potencia sin vibración perjudicial.

### Fallos funcionales

- Fallo total: no entregar caudal cuando el sistema lo requiere.
- Fallo parcial: entregar menos de 108 m³/h, trabajar por debajo de 5,5 bar o hacerlo con fuga o vibración fuera del límite.

### Modos de fallo

- FM-01: degradación del sello mecánico.
- FM-03: degradación de rodamientos.
- FM-06: fallo oculto de la bomba de reserva.
- FM-07: obstrucción parcial en aspiración.

El hilo principal utiliza FM-03. La rotura catastrófica del eje se excluye como mecanismo dominante por falta de evidencia en el histórico actual.

## 6. Bloque 1 — Comprender el problema

El equipo define activo y límites, documenta el contexto operacional, comprueba la preparación de datos, formula funciones con estándares medibles, identifica fallos funcionales y selecciona modos de fallo relevantes.

No se debe pasar a AMEF si la frontera es ambigua, las funciones no son medibles, los fallos están redactados como causas o la evidencia depende únicamente de memoria no documentada.

La salida es un paquete de contexto, funciones, fallos, modos, evidencias, exclusiones y confianza.

## 7. Bloque 2 — Evaluar el riesgo mediante AMEF

Para FM-03 se documenta:

- efecto local: aumento progresivo de vibración y temperatura;
- efecto en el sistema: inestabilidad mecánica y posible daño secundario;
- efecto operacional: reducción de capacidad y parada no planificada;
- consecuencia principal: operacional.

Valoración ilustrativa:

- Severidad: 4.
- Ocurrencia: 3.
- Detectabilidad: 3.
- NPR: 36.
- Riesgo S×O: 12.

El NPR es un indicador secundario. No decide por sí solo la prioridad. El modelo comprueba seguridad, medioambiente, fallos ocultos y confianza baja. En el ejemplo no se aplica sobreclasificación.

Los controles actuales son medición mensual de vibración y temperatura y rondas operativas. La confianza AMEF es media. Permanece una condición: confirmar el baseline de vibración después de la próxima alineación.

La salida es un modo de fallo priorizado, con controles, evidencia, confianza y excepciones.

## 8. Bloque 3 — Tomar la decisión RCM

El fallo se considera evidente. Existe degradación detectable antes del fallo funcional. La evidencia procede de tendencias históricas y equipos equivalentes.

- Ventana P–F estimada: 45 días.
- Tiempo necesario para intervenir: 14 días.
- Probabilidad de detección: 85 %.
- Relación con la edad: no demostrada.
- Política basada en condición: aplicable y efectiva.

Decisión ilustrativa:

- Estrategia principal: mantenimiento basado en condición.
- Alternativa: restauración o sustitución condicionada.
- Autoridad: Fiabilidad, Mantenimiento y Operaciones.

RCM no es un algoritmo autónomo. Estructura preguntas, comprueba coherencia y conserva evidencia, pero la decisión sigue siendo humana y multidisciplinar.

## 9. Bloque 4 — Convertir la decisión en un plan

### Economía conceptual

- Coste esperado sin política: 75.000 €/año.
- Coste directo anual de la política: aproximadamente 3.371 €.
- Riesgo económico residual: 23.625 €/año.
- Coste total con política: aproximadamente 26.996 €/año.
- Ahorro anual esperado: aproximadamente 48.004 €.

Son datos de demostración, no costes corporativos aprobados.

### Tarea

- Nombre: medir vibración global, espectro y temperatura de rodamientos.
- Técnica: medir en puntos normalizados DE/NDE, registrar carga y comparar con baseline.
- Criterio: sin alarma de tendencia, dentro del límite corporativo y sin incremento sostenido superior al 25 %.
- Acción: generar aviso de ingeniería, aumentar frecuencia y planificar inspección, alineación o sustitución.

### Intervalo

- Intervalo propuesto: 21 días.
- P–F: 45 días.
- Factor conceptual máximo: 0,5.
- Máximo resultante: 22 días.
- Ventana restante: 24 días.
- Ventana mínima de planificación: 14 días.

El intervalo supera el gate del ejemplo, pero el factor 0,5 no es una regla corporativa definitiva.

### Recursos y alcance

- Disciplina: Mecánica.
- Puesto: técnico predictivo.
- Cuadrilla: una persona.
- Herramientas: analizador de vibraciones, termómetro IR, tablet y puntos marcados.
- Alcance: bomba, motor y acoplamiento.
- Agrupación: ruta predictiva del tren P-101.
- Salida: modelo interno neutro con mapeo posterior al CMMS destino.

El resultado es un paquete preparado para revisión, no una orden publicada automáticamente.

## 10. Bloque 5 — Gobernar y mejorar

La trazabilidad completa es:

**P-101 → función de transferencia → fallo funcional parcial → FM-03 → AMEF S4/O3/D3 → mantenimiento basado en condición → tarea de vibración y temperatura → ruta predictiva del tren P-101.**

El control de calidad comprueba funciones medibles, vínculos, evidencia, decisión RCM, criterio de tarea, intervalo, recursos y cierre de condiciones.

La revisión conserva posiciones diferentes:

- Fiabilidad propone 21 días por el P–F.
- Mantenimiento propone frecuencia mensual por la ruta existente.
- Operaciones acepta 21 días durante seis meses para reducir incertidumbre.

La resolución es mantener 21 días durante seis meses y revisar con datos reales. El responsable es Ingeniería de Fiabilidad.

Tras la aprobación de Mantenimiento, Operaciones, Fiabilidad y responsable del activo, se congela la versión 1.0.

Datos reales ilustrativos:

- detección real: 28 días frente a 45 estimados;
- coste real anual: 11.200 €;
- un fallo observado frente a 1,2 fallos/año estimados.

La desviación abre una solicitud de cambio. Se revisan P–F, intervalo y baseline, mientras la estrategia basada en condición se mantiene provisionalmente.

## 11. Tres niveles que el vídeo debe diferenciar

### Validado conceptualmente

- Orden general del proceso.
- Inicio por funciones.
- Relación AMEF–RCM.
- Plan como resultado.
- Trazabilidad.
- Enfoque pedagógico.
- Revisión continua.
- Independencia conceptual del sistema destino.

### Propuesta funcional para validar

- Las 28 etapas exactas.
- Gates automáticos.
- Mínimo de evidencias.
- Escalas S/O/D.
- Reglas de sobreclasificación.
- Árbol RCM.
- Umbrales de detección.
- Factor P–F.
- Modelo económico.
- Campos mínimos de tarea.
- Reglas de agrupación.
- Workflow, calidad y versiones.

### Decisiones corporativas pendientes

- Escalas y matriz de criticidad oficiales.
- Reglas de seguridad, medioambiente y fallos ocultos.
- Evidencia mínima y tratamiento de excepciones.
- Árbol RCM corporativo y autoridades.
- Política para estimar P–F e intervalos.
- Catálogos de tareas, disciplinas, puestos, herramientas y repuestos.
- Fuentes de costes.
- Relación con FLH, ADR, modelo de activos e ISO 14224.
- Entidades, columnas, relaciones y versionado.
- Roles, firmas, permisos y segregación de funciones.
- KPIs y umbrales de revisión.
- Arquitectura e integración con el CMMS y sistemas destino.

## 12. Qué debe transmitir el vídeo

1. El problema: un plan no debe depender de costumbre sin justificación.
2. P-101 proporciona un caso concreto y comprensible.
3. Las funciones conducen a fallos y modos de fallo.
4. AMEF contextualiza y prioriza el riesgo sin reducirlo al NPR.
5. RCM estructura una decisión humana y explicable.
6. La estrategia se convierte en tarea, frecuencia, recursos y coste.
7. El expediente se aprueba, versiona y revisa con datos reales.
8. El proyecto dispone de una visión coherente, pero aún debe validar reglas corporativas antes de entregar requisitos definitivos a IT.

Mensaje de cierre:

**CMMS 2.0 no debería limitarse a almacenar planes. Debe conservar el razonamiento que los origina, controlar su aprobación y permitir que evolucionen cuando la realidad contradiga las hipótesis iniciales.**

## 13. Afirmaciones que deben evitarse

No afirmar que:

- el módulo está implantado;
- el workflow está aprobado;
- las cifras P-101 son valores corporativos reales;
- las frecuencias son instrucciones vigentes;
- el NPR decide automáticamente;
- RCM sustituye al equipo humano;
- las integraciones están definidas;
- el modelo de datos está cerrado;
- los gates o roles son definitivos;
- el pull request está integrado en `main`.

Utilizar expresiones como “propuesta funcional”, “caso realista”, “modelo conceptual”, “pendiente de validación” y “base para la futura especificación de IT”.