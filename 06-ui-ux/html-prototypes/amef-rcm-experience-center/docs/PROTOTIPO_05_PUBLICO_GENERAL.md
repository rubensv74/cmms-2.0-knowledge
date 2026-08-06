# Prototipo 5 — Gobernar y mejorar

## Para qué sirve

Este prototipo muestra cómo una propuesta AMEF–RCM se convierte en un expediente controlado: trazable, revisable, aprobable, versionado y preparado para aprender de los resultados reales.

La publicación del plan no cierra el análisis. Fija una versión aprobada y define qué cambios, fallos, costes o desviaciones obligarán a revisarla.

## Recorrido que verá el usuario

1. **Expediente.** Se selecciona un paquete procedente del Prototipo 4 y se recuperan su estrategia, tareas, alcance físico, costes y condiciones pendientes.
2. **Trazabilidad integral.** Se recorre la cadena activo → función → fallo funcional → modo de fallo → AMEF → decisión RCM → tarea → plan.
3. **Validador de calidad.** Se comprueban reglas metodológicas y se distingue entre errores críticos, advertencias y reglas conformes.
4. **Revisión multidisciplinar.** Las discrepancias entre áreas se registran con posiciones, impacto, responsable, decisión y estado.
5. **Aprobación y versión.** Cada rol aprueba su propio ámbito. Los cambios posteriores generan una versión nueva y no sobrescriben la versión anterior.
6. **Informe explicable.** La gerencia recibe una lectura ejecutiva con acceso al detalle técnico, las evidencias y los pendientes.
7. **Mejora continua.** Los resultados reales se comparan con las hipótesis aprobadas y pueden abrir una solicitud de cambio.

## Qué conviene observar durante la demostración

- Una tarea puede reconstruirse hasta la función que la originó.
- Un expediente completo puede seguir bloqueado si conserva una consecuencia crítica sin aprobar.
- Resolver una observación exige documentar qué se hizo; no basta con ocultarla.
- Las discrepancias no se eliminan: se resuelven o se aceptan explícitamente como excepción.
- Mantenimiento, Operaciones, Fiabilidad, HSE y el responsable del activo no aprueban exactamente lo mismo.
- Una versión aprobada permanece inmutable. Cualquier modificación crea un nuevo borrador vinculado a su causa.
- Una desviación real del intervalo P–F, del coste o de la frecuencia de fallo puede reabrir AMEF, RCM y plan.

## Mensaje principal

AMEF–RCM no es un documento que se archiva después de crear el plan. Es un ciclo de decisión controlado que debe conservar su historia y aprender de la ejecución real.

## Resultado generado

El prototipo produce un expediente con:

- cadena completa de trazabilidad;
- puntuación y reglas de calidad;
- discrepancias y decisiones multidisciplinares;
- aprobaciones por rol;
- versión, snapshots e historial de cambios;
- informe técnico y resumen ejecutivo;
- señales operativas comparadas con las hipótesis;
- solicitudes de cambio y alcance de reapertura;
- gate de publicación o revisión.

## Estados principales

- **Bloqueado:** existe una condición crítica, una aprobación obligatoria pendiente o una trazabilidad rota.
- **Condicionado:** puede revisarse, pero mantiene discrepancias, advertencias o aprobaciones pendientes.
- **Preparado:** el expediente puede publicarse como versión controlada.
- **Revisión requerida:** los datos reales han superado un umbral y debe abrirse una nueva versión.

## Decisiones corporativas todavía pendientes

Antes de trasladar este modelo a IT deberán definirse:

- workflow definitivo de revisión y aprobación;
- permisos y segregación de funciones;
- firmas o evidencias de aprobación;
- nomenclatura y reglas de versionado;
- catálogo corporativo de reglas de calidad;
- tratamiento formal de excepciones;
- KPIs de efectividad y fuentes de datos reales;
- umbrales que disparan revisiones ordinarias o de emergencia;
- integración con órdenes de trabajo, costes, incidentes y cambios del contexto operacional.

## Límite de la demostración

Los roles, reglas, puntuaciones, umbrales y estados incluidos son ejemplos funcionales. Sirven para evaluar el proceso y no constituyen todavía el workflow corporativo aprobado.