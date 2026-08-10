# F01-TREE-01 — TreePro profundidad variable

## Objetivo

Validar en una única prueba integrada la evolución del árbol PULSE hacia `cmp_FL_TreePro` con una rama de hasta 11 niveles y P-101 resaltado.

## Archivos

### Componente canónico

[`../../components/cmp_FL_TreePro.pa.yaml`](../../components/cmp_FL_TreePro.pa.yaml)

Crear un Canvas Component vacío llamado:

```text
cmp_FL_TreePro
```

y sustituir todo su Source Code por el contenido del archivo canónico.

### Pantalla de prueba

[`01_scr_FL_TreeLab.pa.yaml`](./01_scr_FL_TreeLab.pa.yaml)

Crear una pantalla vacía llamada:

```text
scr_FL_TreeLab
```

y sustituir todo su Source Code por el contenido del archivo.

## Única validación

No probar nivel por nivel.

Realizar un solo recorrido:

1. abrir `scr_FL_TreeLab`;
2. confirmar que se representa la rama completa hasta nivel 11;
3. comprobar que P-101 está resaltado;
4. buscar `P-101`;
5. limpiar la búsqueda;
6. seleccionar P-101 y comprobar que el panel muestra nivel 11 y su path;
7. contraer un nodo intermedio, por ejemplo Sistema de refrigeración;
8. comprobar que desaparecen sus descendientes;
9. expandirlo de nuevo y recorrer la rama;
10. guardar y reabrir la app.

Resultado esperado:

```text
DEFINITION_ACCEPTED        PASS
INSTANCE_SAFE              PASS
DEPTH_11                   PASS
SEARCH                     PASS
SELECTION_PATH             PASS
HIGHLIGHT_P101             PASS
TOGGLE                     PASS
STUDIO_STABLE              PASS
```

Si el recorrido completo funciona, responder únicamente:

```text
TreePro 11 OK
```

## Nota

Los nombres de los once niveles del dataset son únicamente demostrativos. Esta prueba no define todavía la jerarquía ISO, FLH ni la taxonomía definitiva.

## Auditoría

La justificación técnica está documentada en:

[`../../../discovery/TREEPRO_PULSE_AUDIT_2026-08-10.md`](../../../discovery/TREEPRO_PULSE_AUDIT_2026-08-10.md)
