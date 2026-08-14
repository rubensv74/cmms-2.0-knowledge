# CL-C06-FIX-01 — LineagePanelPro RC4 — Visual QA failure

**Fecha:** 2026-08-14  
**Resultado Studio:** `NORMAL_900 PASS / STRESS_700 FAIL_VISUAL_QA`  
**Componente:** `cmp_FL_LineagePanelPro` RC4 candidate

## Evidencia

### Normal 900

El modo nominal cumple:

- cuatro etapas distinguibles;
- secuencia visual correcta;
- valores completos;
- hint inferior completo;
- sin superficies negras;
- tipografía preservada.

Resultado:

```text
NORMAL 900 PASS
```

### Stress 700

El breakpoint se activa correctamente:

- ancho solicitado: 700 px;
- altura host: 246 px;
- datos largos de stress cargados;
- composición 2×2 activada;
- no se usan elipsis silenciosas.

Sin embargo, la segunda fila presenta colisión visual entre:

- `ACTIVO / CONTEXTO` y su valor;
- `HANDOFF` y su valor;
- texto de trazabilidad inferior.

El contenido se conserva, pero deja de ser legible como unidad de trazabilidad.

Resultado:

```text
STRESS 700 FAIL_VISUAL_QA
```

## Diagnóstico

RC4 corrigió el clipping de RC3, pero la estrategia 2×2 sigue siendo demasiado densa para contenido de ingeniería largo a 700 px. Añadir únicamente más altura no elimina la fragilidad porque cada celda mantiene aproximadamente media anchura y las alturas reales dependen del wrapping.

## Decisión

No promover RC4.

Abrir:

```text
CL-C06-FIX-02 — LineagePanelPro RC5 responsive flow
```

RC5 conservará la vista horizontal en escritorio y sustituirá el 2×2 estrecho por una secuencia vertical de cuatro etapas a ancho completo. Las posiciones verticales se derivarán de `AutoHeight` para evitar colisiones con contenido largo.

## Invariantes

No modificar:

- identidad `cmp_FL_LineagePanelPro`;
- custom properties públicas;
- semántica Biblioteca/Revisión → Aplicación → Activo/Contexto → Handoff;
- tamaños tipográficos;
- paleta segura;
- separación conceptual entre criticidad contextual y riesgo AMEF.
