# F01-TREE-02 — TreePro Premium Visual Pass

## Objetivo

Validar una única pasada integrada sobre `cmp_FL_TreePro` después de comprobar que el motor de 11 niveles carga correctamente.

Esta versión corrige específicamente los problemas visibles de F01-TREE-01:

- descripciones superpuestas dentro del árbol;
- exceso de sangría en niveles profundos;
- iconografía dependiente del nivel;
- toggles `+ / -` con apariencia demasiado técnica;
- poco contraste entre selección, jerarquía normal y P-101 resaltado;
- falta de una capa semántica reutilizable para FLH / Taxonomía / ADR.

## Corrección PA1001 — 2026-08-10

La primera publicación de F01-TREE-02 contenía el badge `ACTIVO` como un `GroupContainer` con `Children` dentro de la plantilla de `Gallery@2.15.0`.

Power Apps devolvió:

```text
PA1001
YamlInvalidSyntax
Expected 'Scalar', got 'SequenceStart'
```

El error apuntaba al inicio de la secuencia hija del badge. La corrección aplicada mantiene el mismo resultado visual pero aplana la plantilla: el badge pasa a ser un `Classic/Button@2.2.0` directo, sin `Children` anidados.

No se modifica el contrato público, el modelo de datos ni la pantalla de prueba.

## Archivos

1. Componente canónico actualizado y corregido:
   `../../components/cmp_FL_TreePro.pa.yaml`
2. Pantalla de validación completa:
   `01_scr_FL_TreeLab.pa.yaml`
3. Catálogo semántico:
   `../../../discovery/TREEPRO_ICON_CATALOG.md`

## Aplicación

1. Sustituir el Source Code completo de `cmp_FL_TreePro` por la versión canónica actualizada.
2. Guardar el componente.
3. La pantalla `scr_FL_TreeLab` no necesita cambios si ya se aplicó la versión F01-TREE-02.
4. Si todavía no se había aplicado, sustituir su Source Code completo por `01_scr_FL_TreeLab.pa.yaml`.
5. Guardar y abrir la pantalla.

## Única validación

Comprobar en un único recorrido:

- no hay textos superpuestos;
- los 11 niveles siguen siendo legibles;
- la sangría se comprime a partir del nivel 6;
- los nodos muestran iconos/chips distintos según `RowIconKey`;
- los nodos con hijos usan chevron visual `⌄ / ›`;
- P-101 queda resaltado con badge `ACTIVO` y acento lateral;
- seleccionar nodos actualiza el panel derecho;
- expandir/contraer sigue funcionando;
- la búsqueda sigue funcionando;
- el breadcrumb sigue funcionando;
- no hay errores en App Checker atribuibles al bloque.

## Criterio de salida

Si el recorrido completo es correcto:

`TREEPRO PREMIUM PASS`

Con ese resultado, `cmp_FL_TreePro` podrá congelarse como foundation visual para las futuras vistas FLH, Taxonomía y ADR. La migración a Modern Icon / Fluent se mantendrá como mejora independiente para no reabrir un componente estable sin necesidad.
