# CL-C07 — ApplicabilityMatrixPro RC2 — VISUAL QA FAILURE

**Fecha:** 2026-08-14  
**Resultado Studio:** `FAIL_VISUAL_QA`  
**Componente:** `cmp_FL_ApplicabilityMatrixPro` RC2

## Evidencia

### Normal 920

La matriz se renderiza correctamente con tres aplicaciones nominales:

- cabeceras distinguibles;
- filas legibles;
- selección inicial visible;
- sin superficies negras;
- tipografía Comfortable preservada.

Resultado: `NORMAL_920_PASS`.

### Stress 760

El host restringido activa el fixture con códigos, perfiles e intervalos largos. La tabla mantiene las cinco columnas físicas de escritorio y aparecen defectos severos:

1. el nombre/código de activo se trunca por `Wrap=false`;
2. `PROFILE` se fuerza a múltiples líneas dentro de ~80 px;
3. `INTERVALO` queda comprimido hasta formar una columna casi vertical;
4. el contenido de intervalo invade visualmente varias filas;
5. la densidad destruye la lectura fila/columna aunque no se haya reducido tipografía;
6. la tabla deja de ser utilizable como unidad de decisión.

Resultado: `STRESS_760_FAIL`.

## Contrato público

El fallo visual es suficiente para bloquear promoción. La validación explícita de selección/evento sigue pendiente: las capturas aportadas mantienen P-101 seleccionado y `OnSelect event = 0`.

No declarar todavía `PUBLIC_CONTRACT_VALIDATED`.

## Decisión

Abrir:

```text
CL-C07-FIX-01 — ApplicabilityMatrixPro RC3 responsive cards
```

El FIX debe conservar:

```text
Items
OnSelectApplication
SelectedAssetCodeOut
SelectedApplicationCodeOut
SelectedRecordOut
UseHostTheme
Title
```

No se eliminarán campos, no se reducirá tipografía y no se resolverá la densidad con elipsis silenciosa.
