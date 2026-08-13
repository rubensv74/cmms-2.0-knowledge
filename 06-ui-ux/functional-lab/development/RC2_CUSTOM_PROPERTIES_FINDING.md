# RC2 — Hallazgo sobre CustomProperties en Canvas Components

**Fecha:** 2026-08-10  
**Componente:** `cmp_FL_SidebarPro`  
**Referencia positiva:** `cmp_HeatMapPro` de PULSE  
**Resultado:** `INSTANCE_SAFE PASS`

## Resumen

El cierre de Power Apps Studio observado inicialmente al insertar `cmp_FL_SidebarPro` llevó a sospechar de `CustomProperties:` como posible causa general.

Esa teoría quedó refutada al comparar el Sidebar con `cmp_HeatMapPro`, un componente PULSE real, complejo y estable que utiliza directamente en Source Code:

- Inputs Text, Boolean, Number, Color y Table;
- Outputs;
- Events;
- bindings internos;
- lógica de selección y Gallery.

## Diferencia relevante

El Sidebar original declaraba Inputs de forma reducida:

```yaml
PropertyKind: Input
DataType: Text
Default: ="..."
```

La referencia estable utiliza:

```yaml
PropertyKind: Input
DisplayName: ...
Description: ...
DataType: ...
Default: ...
```

## Prueba RC2

Se reconstruyó el Sidebar completo conservando su contrato público, Output, Event, Table y bindings, pero normalizando los Inputs según el patrón `cmp_HeatMapPro`.

La prueba se realizó sobre un componente limpio.

Resultado:

```text
DEFINITION_ACCEPTED PASS
INSTANCE_SAFE       PASS
```

## Conclusión aplicable

> `CustomProperties:` es compatible con Source Code. Para nuevos componentes reutilizables, el contrato debe modelarse a partir de una referencia `INSTANCE_SAFE` equivalente y conservar su estructura completa por `PropertyKind`.

## Límite de la conclusión

No se declara que `DisplayName` o `Description` sean individualmente requisitos universales ni que su ausencia sea la única causa interna del cierre original, porque RC2 también utilizó una definición limpia.

El patrón correctivo validado es el conjunto:

```text
referencia real instance-safe
→ contrato completo equivalente
→ definición limpia cuando exista contaminación diagnóstica
→ smoke test de instancia
```

## Regla para futuros desarrollos

Antes de prohibir o retirar una característica de Power Apps a partir de un fallo:

1. buscar un componente real que ya la utilice correctamente;
2. comparar ambos contratos campo por campo;
3. copiar el patrón probado en lugar de reconstruirlo por intuición;
4. validar la instancia antes de integrar;
5. documentar por separado efecto, hipótesis, patrón correctivo y causa confirmada.
