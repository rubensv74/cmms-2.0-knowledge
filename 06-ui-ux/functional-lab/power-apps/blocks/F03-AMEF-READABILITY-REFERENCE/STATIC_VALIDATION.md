# F03 — Validación estática de la referencia AMEF legible

**Fecha:** 2026-08-11  
**Estado:** `PASS_STATIC`  
**Autoridad runtime:** Power Apps Studio  
**Objetivo:** validar el candidato de referencia antes de actualizar definiciones existentes en Studio.

## 1. Alcance revisado

F03 afecta únicamente a estas definiciones existentes:

```text
cmp_FL_SidebarPro
cmp_FL_PageHeaderPro
cmp_FL_ProcessRailPro
cmp_FL_LineagePanelPro
cmp_FL_RiskMatrixPro
cmp_FL_DecisionPanelPro
cmp_FL_GatePanelPro
scr_FL_AMEF
```

No se crean nuevas identidades de componente.

No forman parte de este bloque:

```text
cmp_FL_TreePro
cmp_FL_ApplicabilityMatrixPro
resto de pantallas
```

## 2. Tipografía

La referencia aplica el baseline `Comfortable` definido en `TYPOGRAPHY_AND_DENSITY_STANDARD.md`.

Comprobaciones:

```text
visible minimum       >= 11
supporting            >= 12
body/input            >= 13 cuando es contenido principal
section title         >= 16
page title            24
button                >= 12
```

En `scr_FL_AMEF` no se mantiene intencionadamente ningún texto visible con `Size < 11`.

El patrón elimina el enfoque anterior de reducir tipografía para encajar más contenido.

## 3. Geometría de referencia

Target:

```text
1366×768
browser zoom 100%
Comfortable density
```

Distribución candidata:

```text
Sidebar                 220
PageHeader               100 host height
ProcessRail              300 width + scroll
Lineage/context          108
Effects                  304
RiskMatrix               304
DecisionPanel            216
GatePanel                216
```

La pantalla reduce altura mediante reorganización y consolidación de información, no mediante miniaturización de texto.

## 4. Reglas de compatibilidad aplicadas

Se ha respetado el gate activo de compatibilidad:

```text
Label@2.5.1 + Radius*                 evitado
Classic/Button@2.2.0 + AccessibleLabel evitado
ModernText estático                   AutoHeight=true
Power Fx con literal ': ' inline      usar bloque cuando aplica
GroupContainer con Children en Gallery evitado
SVG fallback                          no usado
```

Los componentes continúan utilizando contratos públicos completos y los mismos nombres canónicos.

## 5. Identidad de componentes

F03 incorpora expresamente el aprendizaje de identidad de Canvas Components:

> las definiciones se deben actualizar in situ en Studio; no se deben agregar nuevas copias esperando que las instancias existentes cambien de componente automáticamente.

El procedimiento obligatorio está documentado en:

`STUDIO_IN_PLACE_UPDATE.md`

## 6. Paleta

Los componentes afectados por FL-SC-004 conservan una paleta interna segura como comportamiento estándar.

La interfaz de referencia mantiene la gramática:

```text
neutral/slate       master / referencia
blue/cyan           sistema / cálculo / recomendación
purple              decisión humana
amber/orange        warning / override
red                  bloqueo / error
green                confirmado / aprobado
```

Esto no cierra los colores corporativos de las bandas de riesgo, que siguen pendientes de validación.

## 7. Semántica AMEF preservada

Fixture P-101:

```text
Severidad     4/5
Ocurrencia    3/5
Detección     3/5
S×O           12
NPR           36
```

La matriz sigue representando `S×O`, no criticidad de activo.

La criticidad del activo sigue siendo un input contextual independiente.

## 8. Resultado de la revisión estática

```text
SOURCE / YAML REVIEW            PASS
KNOWN COMPATIBILITY SCAN        PASS
TYPOGRAPHY BASELINE             PASS_STATIC
REFERENCE GEOMETRY              PASS_STATIC
COMPONENT IDENTITY STRATEGY     DOCUMENTED
```

Todavía no se declara:

```text
DEFINITION_ACCEPTED          pendiente
INSTANCE_SAFE                pendiente
PUBLIC_CONTRACT_VALIDATED    pendiente para esta revisión
VISUAL_QA_VALIDATED          pendiente
READY_FOR_INTEGRATION        no
```

## 9. Único smoke requerido

Después de actualizar las ocho definiciones **in situ**:

```text
Home
→ Registro de análisis
→ P101-AMEF-RCM-001
→ AMEF
```

Validar en una sola ejecución:

```text
paleta
legibilidad
no duplicación de componentes
ProcessRail + scroll
Lineage
Effects
5×5 RiskMatrix
D=3
NPR=36
DecisionPanel
GatePanel
uso a 1366×768 / 100%
```

Si el resultado es satisfactorio, F03 puede avanzar a `VISUAL_QA_VALIDATED` y el patrón se propagará al resto del Functional Lab.
