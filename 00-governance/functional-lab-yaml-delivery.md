# Functional Lab — Protocolo de entrega YAML

**Estado:** activo  
**Fecha:** 2026-08-11  
**Autoridad:** `functional-engineering-knowledge-base/30-playbooks/power-platform/modular-power-apps-screen-construction.md`

## 1. Principio

Power Apps Studio es el centro del ciclo de construcción y validación.

GitHub se utiliza para conservar los bloques preparados y facilitar su entrega, pero **no es requisito para construir ni sustituye Studio**.

## 2. Flujo de entrega

```text
definir estructura / bloque
→ declarar contrato del bloque
→ preparar un YAML con un propósito principal
→ guardar en repositorio cuando sea útil
→ entregar ubicación
→ pegar en Power Apps Studio
→ validar
→ congelar
→ preparar siguiente bloque
```

No se preparan/entregan varios bloques dependientes antes de validar el anterior cuando eso impida aislar regresiones.

## 3. Clasificación obligatoria

```text
S — Structural
C — Component
I — Integration
FIX — repair of the failed increment
```

Cada archivo/bloque debe identificar claramente su tipo.

## 4. Contrato antes del YAML

La entrega debe indicar:

```text
BLOCK:
Operation:
Target:
Parent/anchor:
Dependencies:
Scope:
TOUCHES:
DO NOT MODIFY:
Compatibility:
Validation:
Expected status:
```

No se entrega un bloque que modifique incidentalmente piezas congeladas.

## 5. Chat / entrega remota

Por defecto, el chat no reproduce YAML extenso.

La respuesta contiene:

- ubicación remota del bloque;
- objetivo único;
- target;
- dependencias;
- `DO NOT MODIFY` relevante;
- prueba que debe ejecutar el usuario en Studio;
- estado esperado.

El YAML se muestra en chat solo si el usuario lo pide expresamente.

## 6. Estructura de carpetas

Ejemplo:

```text
power-apps/blocks/S-AMEF-01/
├── CONTRACT.md
└── S-AMEF-01_....pa.yaml   # solo cuando el gate anterior permita generarlo
```

Para Design System Lab:

```text
power-apps/labs/design-system/
├── README.md
├── DS-S01_....pa.yaml
├── DS-C01_....pa.yaml      # solo después de validar DS-S01
└── ...
```

No crear por adelantado todos los YAML de una secuencia si la geometría/contrato del bloque anterior aún no está congelado.

## 7. Pantalla completa

Un YAML full-screen es apropiado principalmente para un bloque `S` de skeleton o para una pantalla realmente nueva sin piezas congeladas.

No usar full-screen replacement como mecanismo de reparación cuando:

- la pantalla ya tiene geometría aprobada;
- solo cambia un componente;
- solo cambia comportamiento;
- el problema es cromático;
- el cambio afectaría piezas `FUNCTIONAL_FROZEN`.

En esos casos el bloque debe estar acotado al slot/elemento correspondiente.

## 8. Validación

Cada bloque se valida antes del siguiente.

Gate mínimo:

```text
[ ] Studio acepta el bloque
[ ] la app guarda
[ ] App Checker no introduce error bloqueante nuevo
[ ] la interacción principal del bloque funciona
[ ] no hay regresión de piezas congeladas
[ ] resultado visual suficiente para el estado declarado
```

Si falla:

```text
BLOCK X
→ X-FIX
→ validar
```

No continuar hasta cerrar el bloque.

## 9. Componentes reutilizables

Un componente modificado se valida aisladamente antes de integrarse:

```text
SOURCE_VALID
→ COMPONENT_DEFINITION_ACCEPTED
→ INSTANCE_SAFE
→ PUBLIC_CONTRACT_VALIDATED
→ VISUAL_QA_VALIDATED
→ READY_FOR_INTEGRATION
```

No insertar una copia `_1` como actualización de una identidad existente.

## 10. Color

El color se valida centralmente mediante roles/tokens en `scr_DesignSystemLab`.

Un bloque de Theme no debe reabrir estructura o comportamiento funcionalmente congelados salvo declaración explícita.

```text
STRUCTURE       FROZEN
BEHAVIOR        FROZEN
DATA CONTRACT   FROZEN
COLOR           PENDING
```

es un estado válido.

## 11. Relación con el protocolo principal

Este documento regula la forma de preparar y entregar YAML.

Los gates funcionales/técnicos completos se definen en:

`00-governance/cmms-functional-lab-incremental-protocol.md`
