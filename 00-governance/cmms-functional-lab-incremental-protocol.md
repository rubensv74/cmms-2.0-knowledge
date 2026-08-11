# CMMS 2.0 Functional Lab — Protocolo incremental

**Versión:** 2.0  
**Estado:** Activo  
**Derivado de:** Protocolo de Implementación Incremental Asistida por IA v2.0 de Pulse  
**Complemento:** Protocolo de Construcción Modular de Pantallas Power Apps v1.0 de Pulse

## 1. Propósito

Adaptar al CMMS 2.0 Functional Lab el método incremental que se utiliza en Pulse, sin rebajar sus controles y añadiendo condiciones específicas para impedir que una simplificación de interfaz altere el modelo funcional.

Regla general heredada:

> Analizar → diseñar → dividir → implementar una pieza → guardar → validar → corregir → documentar → continuar.

Regla adicional de CMMS 2.0:

> Validar primero la responsabilidad funcional, la capa de dominio y el objeto propietario del dato; después diseñar su implementación técnica.

## 2. Naturaleza del Functional Lab

El Functional Lab es un instrumento de análisis funcional ejecutable.

No es:

- el CMMS 2.0 productivo;
- una decisión de arquitectura para IT;
- una definición obligatoria de backend;
- una especificación de integración final;
- un sustituto de la documentación funcional.

Sí debe permitir:

- recorrer casos realistas;
- reutilizar conocimiento de ingeniería entre activos;
- introducir y modificar únicamente los datos que pertenecen a la capa activa;
- distinguir automatismos de decisiones humanas;
- mostrar gates y validaciones;
- descubrir qué workspaces o pantallas son necesarios;
- registrar decisiones de reunión;
- conservar lineage entre capas;
- alimentar documentación funcional trazable.

## 3. Modelo de dominio rector

Para Ingeniería de Fiabilidad se adopta obligatoriamente:

```text
Engineering Library
→ Asset Application
→ Execution Plan
→ Results & Learning
```

Reglas estructurales:

1. `FmeaDefinition` es la identidad reusable del AMEF.
2. `FmeaRevision` gobierna el contenido versionado.
3. Un activo consume una revisión mediante `FmeaAssetApplication`; nunca es su padre.
4. Riesgo AMEF y criticidad del activo son conceptos separados.
5. `MaintenanceTask` ↔ `FailureMode` es N:M.
6. `MaintenanceTask`, `MaintenanceProcedure` e `InspectionFormat` son objetos distintos.
7. Una decisión RCM puede terminar en tarea o `NoScheduledTaskDecision`.
8. `EconomicAssessment`, `MaintenanceCostEstimate` y `ActualMaintenanceCost` no se fusionan.
9. Las revisiones publicadas son inmutables.
10. Toda capa conserva referencias suficientes para reconstruir lineage.

Cualquier propuesta técnica que contradiga estas reglas queda bloqueada antes de producir código.

## 4. Fuentes de verdad

Para el Functional Lab se adopta este orden:

1. decisión funcional expresamente validada;
2. modelo conceptual canónico en `03-data-model/`;
3. documentación funcional consolidada del repositorio;
4. contratos JSON y schemas vigentes;
5. código canónico del Functional Lab;
6. resultados reales en Power Apps Studio y App Checker;
7. Experience Center y prototipos históricos;
8. notas de reuniones no consolidadas;
9. hipótesis.

Una hipótesis nunca se presenta como requisito aprobado.

Si una pantalla o fixture contradice `03-data-model/`, se corrige la pantalla o fixture; no se degrada el modelo para acomodar la interfaz.

## 5. Gate de propiedad de dominio

Antes del gate funcional debe responderse:

```text
DOMAIN OWNERSHIP
Active layer:
Primary domain object:
Parent / source object:
Reusable or asset-specific?:
Lifecycle / revision owner:
Can this change modify a published library revision?:
Required lineage IDs:
Critical cardinalities:
```

El bloque se detiene si no es posible responder con claridad a alguna de estas preguntas:

- ¿El dato pertenece a Library, Asset Application, Execution Plan o Results?
- ¿El objeto es reusable o contextual a un activo?
- ¿Quién posee su revisión/ciclo de vida?
- ¿Un cambio aquí debe crear nueva `FmeaRevision` o solo modificar aplicación/plan?
- ¿La UI está intentando sustituir una relación N:M por un campo único?
- ¿Se está mezclando riesgo AMEF con criticidad del activo?
- ¿Se está fusionando una tarea con procedimiento/formato?
- ¿Se está sobrescribiendo una hipótesis/estimación con un resultado real?

Este gate existe precisamente para evitar regresiones asset-centric.

## 6. Gate funcional obligatorio

Antes de producir un bloque técnico debe existir una ficha funcional con:

```text
FUNCTIONAL UNIT
ID:
Name:
Active layer:
Primary domain object:
Business purpose:
Actor / owner:
Inputs:
Existing information:
System calculations:
System recommendation:
Human decision:
Gate:
Outputs:
Audit evidence:
Lineage output:
Open questions:
Rule status:
```

Estados permitidos para una regla o decisión:

```text
hypothesis
proposed
to_validate
validated
approved
superseded
```

No se codificará como automatismo corporativo una regla en estado `hypothesis`, `proposed` o `to_validate` sin identificarla visualmente como simulación.

## 7. Gate de arquitectura de interacción

Antes del primer bloque de una pantalla o workspace deben quedar definidos:

- capa activa;
- objeto primario;
- etapas funcionales que agrupa;
- arquetipo de interacción;
- árbol objetivo de controles;
- responsabilidad de cada panel;
- colecciones y estado local;
- contrato de datos de entrada;
- referencias de lineage que debe conservar;
- navegación;
- loading / empty / error;
- dirty state cuando exista edición;
- comportamiento read-only para snapshots publicados;
- salida que deja al siguiente workspace;
- elementos fuera de alcance.

Cualquier cambio estructural que invalide bloques posteriores obliga a actualizar la arquitectura antes de continuar.

## 8. Gate técnico

Cada bloque Power Apps debe superar:

1. revisión estática contra repositorio y compatibilidad conocida;
2. integración en Power Apps Studio;
3. guardado sin error;
4. Source Code validation cuando aplique;
5. App Checker;
6. interacción mínima definida para el bloque;
7. confirmación del responsable.

No se avanza sobre un bloque `failed`.

No se generará YAML que presuma:

- un componente no confirmado en la Canvas app;
- una versión de control no verificada;
- propiedades no comprobadas;
- un dialecto Source Code supuesto;
- una integración remota inexistente.

## 9. Unidad mínima de incremento

Un incremento tendrá una responsabilidad principal.

Ejemplos correctos en el modelo v2:

- crear shell del Functional Lab;
- cargar fixture compuesto v2;
- inicializar `LibraryState`;
- mostrar `FmeaDefinition` / `FmeaRevision`;
- implementar navegación entre workspaces;
- implementar una decisión humana RCM;
- calcular una recomendación;
- implementar un gate;
- mostrar una relación N:M tarea–modo;
- crear una `FmeaAssetApplication` demostrativa;
- registrar un resultado de ejecución;
- añadir un estado empty/error;
- documentar una pantalla validada.

Ejemplos que ya no son correctos:

```text
cargar P-101 como raíz del AMEF
mostrar contexto del activo en WS-01
crear una tarea con un único FailureMode embebido
editar criticidad desde la tarjeta de riesgo AMEF
actualizar el coste estimado con el coste real
```

No se mezclarán en un mismo bloque, salvo dependencia inseparable:

- layout;
- contratos;
- persistencia;
- automatización;
- integración remota;
- cambios de modelo de datos.

## 10. Contrato de cada incremento

Cada bloque debe indicar:

```text
INCREMENT [N]
Name:
Operation:
Functional unit:
Active layer:
Primary domain object:
Target file:
Target element:
Parent / anchor:
Dependencies:
Required lineage:
Scope:
Out of scope:
Functional rule status:
Compatibility constraints:
Static validation:
Power Apps validation:
Expected result:
Documentation impacted:
```

## 11. Datos de ejemplo

Los casos se mantendrán como fixtures JSON versionados.

Reglas:

- JSON es la fuente canónica del ejemplo;
- el fixture canónico debe mantener separadas Library, Application, Plan y Results;
- los datos de prueba se separan del código de pantalla;
- cada fixture declara versión, finalidad y carácter ficticio/ilustrativo;
- cualquier transformación a Power Fx se considera un adaptador runtime;
- no se duplica manualmente la lógica del caso en varias pantallas;
- una modificación funcional del caso debe reflejarse en el fixture y en su documentación asociada;
- un fixture legacy no puede cargarse silenciosamente como si cumpliera el contrato vigente.

Contrato actual:

```text
case-fixture.schema.json
├─ fmea-library.schema.json
├─ fmea-asset-application.schema.json
├─ execution-plan.schema.json
└─ maintenance-results.schema.json
```

## 12. Modelo de decisión usuario / sistema

Toda etapa deberá poder clasificar sus elementos como:

- `existing_input`: información ya disponible;
- `user_input`: información introducida o corregida por una persona;
- `system_calculation`: cálculo determinista;
- `system_recommendation`: propuesta automática no vinculante;
- `human_decision`: decisión que requiere responsabilidad humana;
- `gate`: condición necesaria para avanzar;
- `output`: resultado consumido por otra etapa.

La UI deberá hacer visible esta diferencia durante las reuniones.

Una recomendación nunca se sobrescribe con la decisión humana final. Cuando exista override se conservan ambos valores y su motivo/autoridad.

## 13. Reglas específicas de versionado

Antes de guardar un cambio debe clasificarse:

### Cambio de biblioteca

Puede requerir una nueva `FmeaRevision` si altera conocimiento reusable publicado:

- función;
- fallo funcional;
- modo/causa/efecto;
- evaluación/hipótesis de ingeniería;
- decisión RCM reusable;
- tarea reusable;
- relación técnica tarea–modo.

### Cambio contextual

No crea una nueva revisión AMEF si solo afecta a:

- aplicabilidad sobre un activo;
- criticidad del activo;
- intervalo contextual;
- recurso ejecutor;
- alcance físico;
- agrupación del plan;
- resultado real.

Debe revisarse la aplicación o el plan correspondiente conservando la referencia de biblioteca.

## 14. Documentación viva

Cada incremento validado debe actualizar, cuando aplique:

- especificación funcional del módulo;
- catálogo de reglas;
- catálogo de decisiones humano/sistema;
- especificación de pantalla;
- modelo de datos conceptual;
- contrato JSON;
- registro de preguntas abiertas;
- manual de uso del Functional Lab;
- lecciones aprendidas técnicas;
- registro de arquitectura/gates si aparece una decisión estructural.

## 15. Condiciones de parada

El trabajo se detiene y requiere decisión cuando aparece alguno de estos casos:

- cambio en una regla estructural del modelo canónico;
- duda real sobre propiedad de un objeto entre las cuatro capas;
- nueva cardinalidad que altera varios workspaces;
- cambio de política de versionado/inmutabilidad;
- decisión de arquitectura productiva irreversible;
- contradicción entre dos fuentes de verdad equivalentes y vigentes;
- necesidad de introducir un backend, contrato remoto o persistencia como requisito del diseño conceptual;
- regla que el prototipo está a punto de convertir en automatismo sin validación suficiente.

Un error técnico reproducible de Power Apps no es una decisión de arquitectura: se corrige y documenta. Si el error demuestra que la arquitectura propuesta no es implementable sin cambiar el modelo/contrato, entonces sí se eleva como gate.

## 16. Política de errores y aprendizaje

Todo error reutilizable debe producir:

1. corrección del bloque;
2. actualización del registro de compatibilidad;
3. regla preventiva;
4. revisión de bloques futuros donde el mismo patrón pueda aparecer.

Antes de generar nuevos YAML se consultará siempre el registro de compatibilidad y lecciones aprendidas del Functional Lab.

## 17. Handoff

El repositorio debe permitir retomar el trabajo sin leer conversaciones previas.

Se mantendrá un estado con:

- último incremento validado;
- incremento actual;
- siguiente incremento;
- capa/objeto activos;
- bloqueadores;
- decisiones abiertas;
- fixtures vigentes;
- archivos canónicos;
- validaciones pendientes en Power Apps Studio.

## 18. Criterio de éxito

El Functional Lab no se considera exitoso porque tenga muchas pantallas.

Se considera exitoso si permite responder con claridad:

- en qué capa vive cada dato;
- qué conocimiento puede reutilizarse;
- qué pertenece a un activo concreto;
- qué debe saber el sistema;
- qué debe calcular;
- qué puede recomendar;
- qué debe decidir una persona;
- qué impide avanzar;
- qué objeto y relación quedan generados;
- qué revisión/version originó el resultado;
- cómo se justifica posteriormente;
- qué requisito funcional se entrega a IT.
