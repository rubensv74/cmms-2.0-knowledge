# CL-C06 — LineagePanelPro RC3 — VISUAL QA FAILURE

**Fecha:** 2026-08-14  
**Resultado Studio:** `CL-C06 FAIL_VISUAL_QA`  
**Componente:** `cmp_FL_LineagePanelPro` RC3

## Evidencia de Studio

Se ejecutó el harness `CL-C06_LineagePanelPro_isolated_validation.pa.yaml` en los dos escenarios previstos.

### Normal · 900 px

La cadena principal se mantiene reconocible:

```text
Biblioteca / revisión → Aplicación → Activo / contexto → Handoff
```

Los valores nominales son legibles y las flechas conservan la separación. No aparecen superficies negras.

Sin embargo, el hint inferior queda recortado verticalmente dentro del host de 126 px. Por tanto, Normal 900 no alcanza Visual QA completo.

### Stress · 700 px

Con los códigos y estados largos del harness se observa truncamiento con elipsis en las cuatro etapas:

- Biblioteca / revisión;
- Aplicación;
- Activo / contexto;
- Handoff.

El hint inferior continúa recortado. La secuencia general aún puede reconocerse, pero se pierde información de trazabilidad y contexto.

## Diagnóstico

El defecto tiene dos manifestaciones:

1. **Overflow vertical**: el contrato de host de 126 px no deja margen suficiente para el hint inferior de RC3.
2. **Overflow horizontal**: los valores usan `Wrap=false` dentro de cuatro columnas porcentuales; a 700 px la información larga se sustituye por elipsis.

No es un problema de tipografía. Reducir `Size` solo ocultaría la insuficiencia geométrica y contravendría el estándar del Functional Lab.

## Decisión

No congelar RC3 y no ejecutar el gate Save/Reopen como evidencia de cierre.

Abrir:

```text
CL-C06-FIX-01 — LineagePanelPro responsive overflow repair
```

## Invariantes del FIX

El FIX no puede cambiar:

- identidad `cmp_FL_LineagePanelPro`;
- propiedades públicas `LibraryCode`, `RevisionCode`, `AssetCode`, `ApplicationCode`, `CriticalityLabel`, `ExecutionLabel`, `Title`;
- roles semánticos de color;
- significado de la cadena de trazabilidad;
- separación conceptual entre criticidad contextual y riesgo AMEF;
- tipografía Comfortable.

La solución debe resolver el problema mediante layout, wrapping y geometría del host, no mediante reducción de fuente ni eliminación de contenido.
