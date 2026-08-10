# TreePro — catálogo semántico de iconos

**Fecha:** 2026-08-10  
**Estado:** `candidate`  
**Componente:** `cmp_FL_TreePro`

## Objetivo

Separar la semántica del nodo de su profundidad jerárquica.

El árbol no debe decidir el icono con `RowLevel`. Cada fila declara un `RowIconKey` y el componente resuelve su apariencia.

## Catálogo compatible actual

El candidato premium utiliza exclusivamente iconos clásicos ya presentes en componentes PULSE/Functional Lab para no introducir un riesgo de Source Code adicional durante la pasada visual.

| RowIconKey | Uso conceptual | Resolución actual |
|---|---|---|
| `home` | grupo / site / planta | Home |
| `folder` | área / unidad / agrupador | Folder |
| `settings` | sistema / conjunto / equipo funcional | Settings |
| `flag` | estación / hito | Flag |
| `lock` | nodo protegido / gobernado | Lock |
| `message` | nodo informativo / comentario | Message |
| `trend` | circuito / flujo / evolución | Trending |
| `document` | activo / tag / registro hoja | Document |

El catálogo es semántico, no taxonómico. FLH, Taxonomía y ADR podrán mapear sus propios `NodeType` a estas claves sin cambiar el componente.

## Evolución prevista

Microsoft documenta el control moderno Icon como un control Fluent con una biblioteca amplia y selección de icono por nombre. Esto abre una segunda fase potencial para sustituir la resolución Classic/Icon por Fluent cuando confirmemos el tipo/version Source Code exactos en nuestro entorno.

No se introduce ese cambio en F01-TREE-02 porque la mejora visual y la prueba de un nuevo control no deben mezclarse en el mismo gate.

## Iconografía industrial específica

Para equipos de planta donde un catálogo genérico se quede corto —bomba, motor, válvula, intercambiador, compresor, instrumento, tanque— se mantiene abierta una capa opcional de iconografía industrial propia.

Restricciones actuales:

- no usar SVG como fallback automático;
- evitar que los recursos gráficos determinen la lógica del árbol;
- el componente debe seguir funcionando con el catálogo estándar si no existe un icono industrial específico;
- cualquier media asset debe ser pequeño, consistente y reutilizable.

## Regla de diseño

```text
NodeType / contexto de negocio
        ↓
RowIconKey
        ↓
resolver visual del TreePro
        ↓
icono / chip / color
```

Nunca:

```text
RowLevel → icono
```

La profundidad describe posición; no significado.
