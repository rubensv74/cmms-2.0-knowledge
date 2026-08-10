# FL-SC-001 — Studio se cierra al insertar instancia de CanvasComponent

**Fecha:** 2026-08-10  
**Estado:** OPEN — BLOCKING UNTIL FULL COMPONENT RECOVERY  
**Severidad:** alta para el flujo de autoría  
**Bloque afectado:** F01-00A  
**Componente:** `cmp_FL_SidebarPro`

## 1. Efecto inicial

La definición Source Code completa inicial de `cmp_FL_SidebarPro` fue aceptada por Power Apps Studio, pero Studio se cerró al insertar una instancia.

## 2. Evidencia acumulada

```text
R1 root-only                                  PASS
R2 identidad/texto                           PASS
R3 contenedores estáticos                    PASS
R4 navegación visual sin eventos             PASS
R5 Text+Boolean+Color por CustomProperties    FAIL
R5-T Input/Text declarado+consumido           FAIL
R5-TD Input/Text declarado, no consumido      FAIL
R5-TM Input/Text creado manualmente en Studio PASS
R5-TS Source Code visible tras R5-TM           AppTitle OMITIDO
R5-TB binding YAML → AppTitle manual           PASS
R5-BM Boolean binding                          BLOCKED — ShowEnvironment not recognized
```

## 3. Hallazgo demostrado para Text

R5-TB prueba que un control definido mediante Source Code puede consumir de forma estable una propiedad pública `Data / Input / Text` creada manualmente en Studio:

```text
Contrato público AppTitle → creado en Studio
ModernText.Text            → =cmp_FL_SidebarPro.AppTitle
CustomProperties:          → NO presente en YAML pegable
INSTANCE_SAFE              → PASS
```

Por tanto:

1. `Input/Text` es viable en la app activa.
2. El binding desde el cuerpo Source Code hacia una propiedad creada por Studio es viable.
3. El cierre se reproduce cuando el contrato público se intenta crear inyectando `CustomProperties:` en la superficie YAML pegable probada.
4. El Source Code visible de Studio no representa completamente el contrato público, porque `AppTitle` existe pero no aparece serializado en esa superficie.

## 4. Nuevo hallazgo R5-BM

Se aplicó un cuerpo Source Code que referencia:

```powerfx
cmp_FL_SidebarPro.ShowEnvironment
```

Power Apps Studio permaneció abierto, pero la fórmula devolvió:

```text
Name isn't valid. 'ShowEnvironment' isn't recognized.
```

Estado correcto de esta prueba:

```text
STUDIO_CRASH              NO
BOOLEAN_CONTRACT_RESOLVED NO
BINDING_VALID             NO
R5-BM                     BLOCKED
```

Este resultado NO permite afirmar que `Input/Boolean` sea incompatible. Solo demuestra que `ShowEnvironment` no está disponible con ese nombre en el contrato público de `cmp_FL_SidebarPro` en el momento de la prueba.

Antes de generar o modificar más YAML debe verificarse en Studio:

1. que `ShowEnvironment` pertenece a `cmp_FL_SidebarPro` y no a otro componente;
2. el nombre interno exacto de la propiedad;
3. que la propiedad existe después de guardar;
4. si `AppTitle` sigue también presente.

## 5. Causa operativa delimitada

```text
UNSAFE AUTHORING PATH:
CustomProperties metadata injected through the tested pasteable Source Code surface

SAFE AUTHORING PATH DEMONSTRATED FOR TEXT INPUT:
public property created in Studio
+
visual/body YAML consumes that property
```

## 6. Estrategia de autoría corregida

```text
CONTRATO PÚBLICO
Inputs / Outputs / Events → crear/configurar primero en Studio

CUERPO DEL COMPONENTE
Controls / layout / formulas → Source Code incremental validado

BINDING
Source Code puede referenciar propiedades ya creadas en Studio, tras smoke test
```

No volver a introducir `CustomProperties:` en el YAML pegable del Functional Lab salvo nueva evidencia explícita de compatibilidad.

## 7. Siguiente validación

`R5-BM` permanece detenido hasta resolver el contrato Boolean en Studio. No se modifica el YAML mientras `ShowEnvironment` no sea una propiedad pública reconocida del componente.

## 8. Gate de cierre

FL-SC-001 permanecerá abierto hasta que:

1. el Sidebar completo reconstruido sea `INSTANCE_SAFE`;
2. guardar/reabrir sea estable;
3. el contrato público requerido quede validado;
4. Visual QA pase;
5. el aprendizaje central permanezca actualizado.
