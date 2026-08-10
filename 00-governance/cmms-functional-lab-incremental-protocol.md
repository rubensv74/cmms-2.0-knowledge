# CMMS 2.0 Functional Lab — Protocolo incremental

**Versión:** 1.1  
**Estado:** Activo  
**Derivado de:** Protocolo de Implementación Incremental Asistida por IA v2.0 de Pulse  
**Complemento:** Protocolo de Construcción Modular de Pantallas Power Apps v1.0 de Pulse  
**Actualización 1.1:** gate explícito de seguridad de instancia para CanvasComponent tras FL-SC-001.

## 1. Propósito

Adaptar al CMMS 2.0 Functional Lab el método incremental que se utiliza en Pulse, sin rebajar sus controles y añadiendo una condición propia del carácter conceptual del laboratorio.

Regla general heredada:

> Analizar → diseñar → dividir → implementar una pieza → guardar → validar → corregir → documentar → continuar.

Regla adicional de CMMS 2.0:

> Validar primero la responsabilidad funcional de la pieza y después su implementación técnica.

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
- introducir y modificar datos;
- distinguir automatismos de decisiones humanas;
- mostrar gates y validaciones;
- descubrir qué workspaces o pantallas son necesarios;
- registrar decisiones de reunión;
- alimentar documentación funcional trazable.

## 3. Fuentes de verdad

Para el Functional Lab se adopta este orden:

1. decisión funcional expresamente validada;
2. documentación funcional consolidada del repositorio;
3. contratos JSON y schemas vigentes;
4. código canónico del Functional Lab;
5. resultados reales en Power Apps Studio y App Checker;
6. conocimiento reutilizable vigente en `rubensv74/functional-engineering-knowledge-base`;
7. Experience Center y prototipos históricos;
8. notas de reuniones no consolidadas;
9. hipótesis.

Una hipótesis nunca se presenta como requisito aprobado.

Para trabajo Power Apps se consultarán además, cuando apliquen:

- `15-standards/power-platform/power-apps-source-code-compatibility-standard.md`;
- `15-standards/power-platform/reusable-power-apps-component-contract.md`;
- `15-standards/ux-ui/power-apps-visual-quality-standard.md`;
- `80-learning/power-platform/POWER_APPS_UI_LESSONS_LEARNED.md`.

El conocimiento central no sustituye la revalidación en la app activa.

## 4. Gate funcional obligatorio

Antes de producir un bloque técnico debe existir una ficha funcional con:

```text
FUNCTIONAL UNIT
ID:
Name:
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

## 5. Gate de arquitectura

Antes del primer bloque de una pantalla o workspace deben quedar definidos:

- etapas funcionales que agrupa;
- árbol objetivo de controles;
- responsabilidad de cada panel;
- colecciones y estado local;
- contrato de datos de entrada;
- navegación;
- loading / empty / error;
- dirty state cuando exista edición;
- salida que deja al siguiente workspace;
- elementos fuera de alcance.

Cualquier cambio estructural que invalide bloques posteriores obliga a actualizar la arquitectura antes de continuar.

## 6. Gate técnico

Cada bloque Power Apps debe superar:

1. revisión estática contra repositorio y compatibilidad conocida;
2. integración en Power Apps Studio;
3. guardado sin error;
4. Source Code validation cuando aplique;
5. App Checker;
6. interacción mínima definida para el bloque;
7. confirmación del responsable.

No se avanza sobre un bloque `failed`.

### 6.1. Gate técnico adicional para CanvasComponent

Un CanvasComponent no utiliza un estado genérico `validated`.

Debe recorrer explícitamente:

```text
PASS_STATIC
      ↓
DEFINITION_ACCEPTED
      ↓
INSTANCE_SAFE
      ↓
PUBLIC_CONTRACT_VALIDATED
      ↓
VISUAL_QA_VALIDATED
      ↓
READY_FOR_INTEGRATION
```

Definiciones:

- `PASS_STATIC`: revisión de schema, controles, propiedades, Power Fx y dependencias.
- `DEFINITION_ACCEPTED`: Studio acepta/guarda la definición y App Checker no muestra error atribuible.
- `INSTANCE_SAFE`: una instancia con valores por defecto puede insertarse en superficie aislada sin cierre, bloqueo o corrupción de Studio.
- `PUBLIC_CONTRACT_VALIDATED`: inputs, outputs y eventos relevantes funcionan según contrato.
- `VISUAL_QA_VALIDATED`: se ha observado el componente con contenido representativo y sin defectos visuales bloqueantes.
- `READY_FOR_INTEGRATION`: todos los gates anteriores están superados.

Regla:

> `DEFINITION_ACCEPTED` nunca se interpreta como `INSTANCE_SAFE`.

Todo componente nuevo se probará primero en una superficie aislada y solo después podrá aparecer como dependencia de una pantalla funcional.

Si Studio se cierra al insertar la instancia:

1. marcar `INSTANCE_SAFE = FAIL`;
2. detener bloques dependientes;
3. registrar incidente;
4. mantener causa técnica como `UNKNOWN` mientras no exista evidencia suficiente;
5. reducir el componente incrementalmente para obtener reproducer mínimo;
6. actualizar compatibilidad y estado;
7. revalidar desde el estadio mínimo.

Orden de reducción recomendado:

```text
root only
→ identidad/texto
→ contenedores estáticos
→ acciones sin eventos
→ custom inputs simples
→ colecciones/Table/Gallery
→ outputs/events
→ geometría completa
```

## 7. Unidad mínima de incremento

Un incremento tendrá una responsabilidad principal.

Ejemplos:

- crear shell del Functional Lab;
- crear/validar una responsabilidad de un componente premium;
- cargar fixture P-101;
- mostrar contexto del caso;
- implementar navegación entre workspaces;
- implementar una decisión humana;
- calcular una recomendación;
- implementar un gate;
- registrar el resultado de una etapa;
- añadir un estado empty/error;
- documentar una pantalla validada.

No se mezclarán en un mismo bloque, salvo dependencia inseparable:

- layout;
- contratos;
- persistencia;
- automatización;
- integración remota;
- cambios de modelo de datos.

## 8. Contrato de cada incremento

Cada bloque debe indicar:

```text
INCREMENT [N]
Name:
Operation:
Functional unit:
Target file:
Target element:
Parent / anchor:
Dependencies:
Scope:
Out of scope:
Functional rule status:
Compatibility constraints:
Static validation:
Power Apps validation:
Expected result:
Documentation impacted:
```

Para componentes se añadirá:

```text
Component validation level before test:
Component validation level expected after test:
Instance smoke test:
Public contract smoke test:
Visual QA:
```

## 9. Datos de ejemplo

Los casos se mantendrán como fixtures JSON versionados.

Reglas:

- JSON es la fuente canónica del ejemplo;
- los datos de prueba se separan del código de pantalla;
- cada fixture declara versión, finalidad y carácter ficticio/ilustrativo;
- cualquier transformación a Power Fx se considera un adaptador runtime;
- no se duplica manualmente la lógica del caso en varias pantallas;
- una modificación funcional del caso debe reflejarse en el fixture y en su documentación asociada.

## 10. Modelo de decisión usuario / sistema

Toda etapa deberá poder clasificar sus elementos como:

- `existing_input`: información ya disponible;
- `user_input`: información introducida o corregida por una persona;
- `system_calculation`: cálculo determinista;
- `system_recommendation`: propuesta automática no vinculante;
- `human_decision`: decisión que requiere responsabilidad humana;
- `gate`: condición necesaria para avanzar;
- `output`: resultado consumido por otra etapa.

La UI deberá hacer visible esta diferencia durante las reuniones.

## 11. Documentación viva

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
- registro de compatibilidad Source Code.

## 12. Condiciones de parada

El trabajo se detiene cuando aparece cualquiera de estos casos:

- decisión funcional que cambia el proceso;
- decisión de arquitectura productiva irreversible;
- contradicción entre dos fuentes de verdad relevantes;
- error nuevo en Power Apps Studio;
- cierre o bloqueo de Studio durante smoke test de instancia;
- necesidad de un contrato remoto no confirmado;
- cambio de modelo de datos que afecte a varios workspaces;
- regla que el prototipo está a punto de convertir en automatismo sin validación suficiente.

## 13. Política de errores y aprendizaje

Todo error reutilizable debe producir:

1. parada del bloque dependiente;
2. registro del efecto observado;
3. separación explícita entre efecto confirmado, hipótesis y causa confirmada;
4. corrección o reducción del bloque;
5. actualización del registro de compatibilidad;
6. regla preventiva solo cuando esté respaldada por evidencia;
7. revisión de bloques futuros donde el mismo patrón pueda aparecer;
8. promoción del aprendizaje a la base de conocimiento central cuando aporte conocimiento transversal nuevo.

Antes de generar **cada nuevo YAML o corrección YAML** se consultará siempre la versión vigente de `development/compatibility.md`.

Para CanvasComponent, una prueba de definición nunca sustituye al smoke test de instancia.

## 14. Handoff

El repositorio debe permitir retomar el trabajo sin leer conversaciones previas.

Se mantendrá un estado con:

- último incremento validado;
- incremento actual;
- siguiente incremento;
- bloqueadores;
- decisiones abiertas;
- fixtures vigentes;
- archivos canónicos;
- validaciones pendientes en Power Apps Studio;
- incidentes técnicos abiertos;
- nivel de validación real de cada componente reusable.

## 15. Criterio de éxito

El Functional Lab no se considera exitoso porque tenga muchas pantallas.

Se considera exitoso si permite responder con claridad:

- qué debe saber el sistema;
- qué debe calcular;
- qué puede recomendar;
- qué debe decidir una persona;
- qué impide avanzar;
- qué dato o decisión queda generado;
- cómo se justifica posteriormente;
- qué requisito funcional se entrega a IT.

Y desde la perspectiva técnica del laboratorio:

> ningún componente se integra por confianza estática; debe demostrar que su instancia es estable en Power Apps Studio.
