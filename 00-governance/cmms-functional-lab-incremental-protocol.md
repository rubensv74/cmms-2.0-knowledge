# CMMS 2.0 Functional Lab — Protocolo incremental

**Versión:** 1.2  
**Estado:** Activo  
**Actualización 1.2:** adopción obligatoria del playbook modular vigente, skeleton/placeholders, freeze por capas, bloques S/C/I/FIX y validación cromática aislada.

## 1. Autoridad Power Apps

Para cualquier nueva pantalla, componente o evolución mediante YAML, la referencia principal es:

`functional-engineering-knowledge-base/30-playbooks/power-platform/modular-power-apps-screen-construction.md`

Este protocolo adapta ese método al contexto funcional del CMMS 2.0; no lo sustituye.

Power Apps Studio continúa siendo el entorno principal de implementación y validación.

Git/GitHub pueden conservar fuentes, contratos y evidencia, pero no son requisito de construcción ni sustituyen Studio.

## 2. Regla general

```text
comprender función
→ definir arquitectura
→ construir skeleton completo
→ crear placeholders contratados
→ entregar un bloque S/C/I
→ pegar en Studio
→ validar
→ congelar
→ siguiente bloque
```

Si un incremento falla:

```text
BLOCK X ❌
→ BLOCK X-FIX
→ validar
→ BLOCK X ✅
```

No se utiliza un bloque posterior para reparar silenciosamente uno anterior.

## 3. Naturaleza del Functional Lab

El Functional Lab es un instrumento de análisis funcional ejecutable.

No es:

- el CMMS 2.0 productivo;
- una decisión irreversible de arquitectura para IT;
- una definición obligatoria de backend;
- una especificación de integración final;
- un sustituto de documentación funcional.

Sí debe permitir:

- recorrer casos realistas;
- introducir/modificar datos donde corresponda;
- distinguir automatismos de decisiones humanas;
- mostrar controles de avance y validaciones;
- descubrir workspaces/pantallas necesarios;
- registrar decisiones de reunión;
- producir documentación funcional trazable.

## 4. Fuentes de verdad

Orden:

1. decisión funcional expresamente validada;
2. documentación funcional consolidada;
3. contratos JSON/schemas vigentes;
4. estado/freeze registrado de la app;
5. código canónico del Functional Lab;
6. resultados reales en Power Apps Studio y App Checker;
7. conocimiento reutilizable central vigente;
8. prototipos históricos y Experience Center;
9. notas no consolidadas;
10. hipótesis.

Una hipótesis nunca se presenta como requisito aprobado.

Para Power Apps deben consultarse además:

```text
30-playbooks/power-platform/modular-power-apps-screen-construction.md
15-standards/power-platform/power-apps-source-code-compatibility-standard.md
15-standards/power-platform/reusable-power-apps-component-contract.md
15-standards/ux-ui/power-apps-visual-quality-standard.md
15-standards/ux-ui/enterprise-design-system-token-governance.md
80-learning/power-platform/POWER_APPS_UI_LESSONS_LEARNED.md
```

Antes de cada YAML se consulta también `06-ui-ux/functional-lab/development/compatibility.md`.

## 5. Gate funcional

Antes de un bloque técnico debe estar clara la unidad funcional:

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
Control de avance:
Outputs:
Audit evidence:
Open questions:
Rule status:
```

Estados de regla:

```text
hypothesis
proposed
to_validate
validated
approved
superseded
```

No automatizar como regla corporativa algo que siga siendo `hypothesis`, `proposed` o `to_validate` sin identificarlo como simulación.

## 6. Gate de arquitectura — skeleton first

Antes del primer bloque de una pantalla nueva o abierta a reconstrucción deben definirse:

- propósito de la pantalla;
- arquetipo de trabajo;
- árbol estructural;
- placeholders;
- función de cada placeholder;
- geometría X/Y/Width/Height o contrato responsive;
- datos esperados;
- eventos/outputs previstos;
- dependencias;
- loading/empty/error;
- navegación;
- elementos fuera de alcance.

La primera implementación será estructural:

```text
S01 — full screen skeleton
```

No se integran componentes reales hasta validar la geometría.

Una vez aprobada:

```text
STRUCTURE = FROZEN
```

Los siguientes bloques no pueden modificar esa geometría salvo que lo declaren expresamente y justifiquen reabrirla.

## 7. Placeholders

Cada placeholder debe tener contrato explícito:

```text
Placeholder:
Purpose:
Geometry:
Future component/content:
Expected inputs:
Expected outputs/events:
Behavior expectations:
Status:
```

Estados útiles:

```text
STRUCTURAL
PLANNED
READY_FOR_REPLACEMENT
REPLACED
FROZEN
```

## 8. Tipos de bloque

### S — Structural

Crea estructura, slots, placeholders y geometría. No implementa lógica compleja.

### C — Component

Sustituye un placeholder/slot por un componente real o modifica una pieza visual concreta. No rediseña la pantalla.

### I — Integration

Conecta piezas ya estables. No debe rehacer componentes ni geometría.

### FIX

Repara exclusivamente el incremento que falló.

## 9. Contrato obligatorio antes de cada YAML

```text
BLOCK [TYPE]-[NN] — [Name]
Operation:
Target control/property:
Parent/anchor:
Dependencies:
Scope:
TOUCHES:
DO NOT MODIFY:
Functional rule status:
Compatibility constraints:
Validation:
Expected result:
Expected construction status:
```

Para componentes:

```text
Component validation level before test:
Component validation level expected after test:
Instance smoke test:
Public contract smoke test:
Visual QA:
```

## 10. Freeze model

Estados de construcción:

```text
IN_CONSTRUCTION
FUNCTIONAL
FUNCTIONAL_FROZEN
VISUAL_APPROVED
FINAL_FROZEN
```

Capas:

```text
STRUCTURE       OPEN | FROZEN
BEHAVIOR        OPEN | FROZEN
DATA CONTRACT   OPEN | FROZEN
COLOR           PENDING | APPROVED
```

Una pieza `FUNCTIONAL_FROZEN` puede conservar `COLOR=PENDING`.

Un problema puramente cromático no reabre automáticamente estructura/comportamiento.

Antes de cada bloque se consulta el Freeze Register de la app activa.

## 11. Gate técnico de CanvasComponent

Todo componente modificado debe recorrer:

```text
SOURCE_VALID
→ COMPONENT_DEFINITION_ACCEPTED
→ INSTANCE_SAFE
→ PUBLIC_CONTRACT_VALIDATED
→ VISUAL_QA_VALIDATED
→ READY_FOR_INTEGRATION
```

Definiciones:

- `SOURCE_VALID`: revisión estática del schema, controles, propiedades, Power Fx y dependencias.
- `COMPONENT_DEFINITION_ACCEPTED`: Studio acepta/guarda la definición.
- `INSTANCE_SAFE`: una instancia puede insertarse en una superficie aislada sin cierre/bloqueo/corrupción.
- `PUBLIC_CONTRACT_VALIDATED`: inputs/outputs/eventos esenciales funcionan.
- `VISUAL_QA_VALIDATED`: contenido representativo sin defecto visual bloqueante.
- `READY_FOR_INTEGRATION`: todos los gates anteriores superados.

`COMPONENT_DEFINITION_ACCEPTED` nunca equivale a `INSTANCE_SAFE`.

## 12. Diagnóstico de componentes — referencia positiva primero

Si un componente falla al instanciarse:

1. registrar `INSTANCE_SAFE=FAIL`;
2. detener bloques dependientes;
3. mantener la causa como `UNKNOWN` si no hay evidencia;
4. comparar primero con un componente PULSE `INSTANCE_SAFE` equivalente;
5. hacer diff de contrato, cuerpo, Gallery/ThisItem, outputs/events y versiones de controles;
6. publicar un candidato completo corregido;
7. ejecutar **un** smoke de instancia;
8. usar reducción controlada solo si el problema persiste.

Referencias positivas principales:

```text
PULSE cmp_HeatMapPro
PULSE cmp_SidebarNav
PULSE Classic/TextInput@2.3.2
```

La reducción `root only → ...` es segunda línea de diagnóstico, no la respuesta automática.

## 13. Identidad de componentes

Si un componente existente tiene instancias:

```text
NO crear copia _1 como actualización
NO asumir que las instancias se reasocian
```

Actualizar la definición **in situ** preservando identidad o ejecutar una migración explícita/controlada.

## 14. Color y Theme

Los componentes no deben inventar paletas independientes.

Roles compartidos mínimos:

```text
Background
Surface
SurfaceAlt
Border
TextPrimary
TextSecondary
Primary
PrimaryHover
PrimarySelected
SelectedBackground
SelectedBorder
SelectedAccent
SelectedText
Success
Warning
Danger
Chart01…Chart06
```

Las dudas de render/color se reproducen primero en:

```text
scr_DesignSystemLab
```

antes de propagarlas a pantallas funcionales.

Los HEX/fallbacks existentes pueden conservarse por compatibilidad, pero no son una segunda fuente semántica definitiva.

## 15. Tipografía / Visual QA

Baseline actual:

```text
visible mínimo  11
supporting      12
labels          12–13
body            13–14
card title      15–17
section title   16–18
page title      24–28
button          12–13
```

No reducir texto para evitar scroll. Cambiar layout/overflow mediante bloque explícito.

No aplicar reemplazos globales de tamaños o color.

## 16. Grafo de pantallas y Navigate

En una app con navegación cruzada, una referencia a `scr_FL_X` no puede diagnosticarse correctamente si esa identidad aún no existe en Studio.

Se permite crear primero `Blank screen` con los nombres canónicos para completar dependencias.

Eso **no autoriza** a pegar el contenido de todas las pantallas en un único lote.

## 17. Datos de ejemplo

Los casos siguen como fixtures JSON versionados.

Reglas:

- JSON es fuente canónica del ejemplo;
- datos separados del código de pantalla;
- versión/finalidad/caracter ficticio documentados;
- Power Fx es adaptador runtime;
- no duplicar lógica del caso en múltiples pantallas.

## 18. Modelo usuario / sistema

Cada etapa clasifica sus elementos como:

```text
existing_input
user_input
system_calculation
system_recommendation
human_decision
gate / control de avance
output
```

La UI debe hacer visible la diferencia.

## 19. Condiciones de parada

Detener el bloque cuando aparezca:

- decisión funcional que cambia el proceso;
- arquitectura productiva irreversible;
- contradicción relevante;
- error nuevo bloqueante en Studio;
- cierre/bloqueo durante smoke de instancia;
- cambio de contrato/datos que afecte piezas congeladas;
- necesidad de modificar una pieza `FINAL_FROZEN` no declarada en el bloque;
- intento de propagar color no validado;
- regla no aprobada a punto de convertirse en automatismo.

## 20. Documentación viva

Cada bloque validado actualiza cuando aplique:

- freeze register;
- especificación funcional;
- catálogo de reglas;
- decisiones humano/sistema;
- especificación de pantalla;
- modelo de datos;
- contratos;
- preguntas abiertas;
- manual;
- lecciones aprendidas;
- compatibilidad Source Code.

## 21. Handoff

El repositorio debe permitir retomar trabajo sin leer conversaciones.

Estado mínimo:

```text
último bloque validado
bloque actual
siguiente bloque permitido
piezas congeladas
color pending/approved
bloqueadores
fixtures vigentes
fuentes canónicas
component validation levels
Studio gates pendientes
```

## 22. Criterio de éxito

El Functional Lab es exitoso si permite responder:

- qué debe saber el sistema;
- qué calcula;
- qué recomienda;
- qué decide una persona;
- qué impide avanzar;
- qué output queda generado;
- cómo se justifica;
- qué requisito funcional se entrega a IT.

Y técnicamente:

> ningún incremento destruye silenciosamente uno aprobado; ningún componente se integra solo por confianza estática; y la capa cromática no obliga a reabrir piezas funcionalmente estables.
