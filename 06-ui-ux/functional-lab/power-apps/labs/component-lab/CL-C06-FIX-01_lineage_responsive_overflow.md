# CL-C06-FIX-01 — LineagePanelPro responsive overflow repair

**Type:** `FIX`  
**Target:** existing `cmp_FL_LineagePanelPro` identity  
**Base:** RC3  
**Candidate:** RC4  
**Dependency:** `CL-C06_VISUAL_QA_FAILURE_2026-08-14.md`  
**Expected result:** `CL-C06-FIX-01 PASS` → `CL-C06 LINEAGEPANEL PASS`

## Defect

RC3 pierde información en dos ejes:

- a 900 px, el hint inferior queda cortado por el host fijo de 126 px;
- a 700 px, los valores de las cuatro etapas se truncan por `Wrap=false` y por mantener una única fila horizontal.

El problema es de layout y geometría. No se reduce tipografía y no se elimina información.

## Estrategia RC4

RC4 mantiene el contrato público y hace adaptativa únicamente la presentación interna.

### Modo wide

```text
Width >= 780
Height recomendado = 160

Biblioteca / revisión → Aplicación → Activo / contexto → Handoff
```

- se conserva la composición horizontal;
- los valores pasan a `Wrap=true`;
- el hint usa `Wrap=true` y dispone de margen inferior real;
- no se cambia ningún tamaño tipográfico.

### Modo compact

```text
Width < 780
Height recomendado = 246

Biblioteca / revisión  →  Aplicación
                         ↓
Activo / contexto      →  Handoff
```

- dos columnas y dos filas;
- valores con wrapping;
- las tres flechas siguen representando la secuencia;
- el hint inferior permanece visible;
- los códigos no se sustituyen por elipsis silenciosa.

## Por qué se modifica la altura del host

El contrato histórico de 126 px ha fallado en Studio incluso en Normal 900. La evidencia visual demuestra que mantener esa altura obligaría a recortar contenido o reducir tipografía.

RC4 establece un **responsive host envelope**:

```powerfx
If(LineageWidth < 780, 246, 160)
```

Esto no añade propiedades públicas ni modifica la semántica del componente. Es un requisito de geometría para las instancias que lo integren.

## Contrato preservado

No se modifican:

- `LibraryCode`;
- `RevisionCode`;
- `AssetCode`;
- `ApplicationCode`;
- `CriticalityLabel`;
- `ExecutionLabel`;
- `Title`;
- propiedades de color conservadas por compatibilidad;
- identidad `cmp_FL_LineagePanelPro`.

## Artefactos

```text
CL-C06-FIX-01_LineagePanelPro_RC4_candidate.pa.yaml
CL-C06-FIX-01_LineagePanelPro_RC4_validation.pa.yaml
```

El candidato no debe reemplazar todavía la fuente canónica `power-apps/components/cmp_FL_LineagePanelPro.pa.yaml`. Primero debe ser aceptado y validado visualmente en Studio.

## Static precheck del candidato

Comprobado antes de publicar el artefacto:

- YAML parseable;
- identidad preservada;
- sin `AccessibleLabel` en Classic Button;
- sin superficies `#000000`;
- tipografía visible `>= 11`;
- break responsive explícito en 780 px;
- valores e hint con wrapping;
- no se añade Gallery, SVG ni contrato de eventos.

## Gate de revalidación

1. actualizar **in situ** `cmp_FL_LineagePanelPro` con el candidato RC4;
2. confirmar aceptación de la definición en Studio;
3. cargar el harness RC4;
4. ejecutar `Normal · 900 px`;
5. ejecutar `Stress · 700 px`;
6. verificar contenido íntegro, secuencia y ausencia de clipping;
7. Save/Reopen;
8. repetir Normal 900.

Si todo pasa:

```text
CL-C06-FIX-01 PASS
CL-C06 LINEAGEPANEL PASS
cmp_FL_LineagePanelPro RC4 READY_FOR_INTEGRATION
```
