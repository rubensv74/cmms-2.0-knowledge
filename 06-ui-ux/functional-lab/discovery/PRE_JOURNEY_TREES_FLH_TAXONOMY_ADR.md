# Discovery — Contexto previo al journey: FLH, Taxonomía y ADR

**Fecha:** 2026-08-10  
**Estado:** `tree-source-located / candidate-prepared`  
**Prioridad:** alta para visión global  
**Recomendación preliminar:** B — evolucionar el árbol PULSE a profundidad variable

## 1. Propósito

Antes de las 28 etapas del Functional Lab se incorporarán conceptualmente tres vistas del mismo caso P-101:

```text
CONTEXTO DEL ACTIVO
├── Árbol FLH
├── Taxonomía
└── Árbol ADR

METODOLOGÍA DE MANTENIMIENTO
└── FL-01 .. FL-28
```

Estas vistas son contexto previo al journey y no nuevas etapas FL.

## 2. Fuente PULSE localizada

El componente indicado por el usuario ya está versionado en:

```text
rubensv74/app_pulse
power-apps/components/cmp_TreeViewPro.pa.yaml
```

Su modelo ya utiliza una tabla plana con:

```text
RowNodeId
RowParentNodeId
RowLevel
RowLabel
RowDescription
RowSortPath
```

La indentación se calcula dinámicamente a partir de `RowLevel`.

Por tanto, la experiencia actual de tres niveles **no está estructuralmente limitada a tres niveles**. La limitación observada procede principalmente del dataset, la presentación de iconos/colores y la ausencia de expansión/contracción real.

## 3. Decisión preliminar

```text
A — reutilizar sin cambios                    no recomendado
B — evolucionar a profundidad variable       recomendado
C — reconstruir completamente                no necesario por ahora
D — descartar Power Apps                      no justificado por la evidencia actual
```

La recomendación B debe confirmarse con una única prueba representativa de profundidad 11.

## 4. Evolución preparada

Se ha creado el candidato:

```text
cmp_FL_TreePro
```

Principios:

- un solo Canvas Component;
- tabla plana padre-hijo;
- profundidad como dato;
- sin 11 galerías;
- `MaxVisualDepth` e `IndentSize` configurables;
- highlight de P-101;
- breadcrumb/path;
- búsqueda;
- selección;
- evento de expandir/contraer;
- estado `RowIsVisible` / `RowIsExpanded` mantenido por el host para evitar estado global oculto entre instancias.

## 5. Prueba integrada

Se ha preparado `scr_FL_TreeLab` con una rama demostrativa de once niveles y P-101 situado en nivel 11.

El dataset sirve únicamente para validar el motor visual; no define todavía la jerarquía ISO, FLH o taxonomía definitiva.

La prueba validará de una vez:

```text
DEFINITION_ACCEPTED
INSTANCE_SAFE
DEPTH_11
SEARCH
SELECTION_PATH
HIGHLIGHT_P101
TOGGLE
STUDIO_STABLE
```

No se harán micropruebas por nivel.

## 6. Reutilización prevista

Si el candidato supera la prueba:

```text
cmp_FL_TreePro
├── dataset FLH
├── dataset Taxonomía
└── dataset ADR
```

Las tres vistas compartirán motor y mantendrán a P-101 como hilo conductor antes de entrar en WS-01.

## 7. Valor estratégico

El resultado se considera también evidencia sobre la viabilidad futura de Power Apps para CMMS 2.0. Un TreePro capaz de soportar jerarquías profundas sin componentes distintos por nivel sería un activo premium reutilizable para navegación de activos, FLH, taxonomías y ADR.

## 8. Auditoría detallada

Ver:

[`TREEPRO_PULSE_AUDIT_2026-08-10.md`](./TREEPRO_PULSE_AUDIT_2026-08-10.md)

## 9. Secuencia

```text
WS-02 VALIDATED PASS
→ TreeViewPro PULSE localizado
→ cmp_FL_TreePro candidato preparado
→ una prueba integrada de profundidad 11
→ si PASS, congelar TreePro Foundation
→ continuar WS-03
```
