# Functional Lab — Power Apps Source Code Compatibility

**Estado:** activo antes de cualquier YAML  
**Origen:** evidencia real de Functional Lab, PULSE y conocimiento curado central.  
**Actualizado:** 2026-08-10

## Gate obligatorio pre-YAML

Antes de redactar, corregir o publicar cualquier `.pa.yaml` del Functional Lab:

1. leer la versión vigente de este documento;
2. confirmar control y versión exactos contra referencias ya probadas;
3. comparar con componentes reales que ya funcionen en PULSE cuando exista un equivalente;
4. no asumir que una hipótesis diagnóstica es una regla general;
5. separar aceptación de definición y seguridad de instancia;
6. registrar cualquier error nuevo y corregir también cualquier conclusión previa que quede refutada;
7. para nuevas `CustomProperties`, copiar el contrato completo del componente estable de referencia por `PropertyKind`;
8. revisar las fórmulas inline que contengan `: ` dentro de literales de texto y convertirlas a bloque YAML `|-`;
9. dentro de plantillas `Gallery`, evitar `GroupContainer` con `Children` anidados; usar controles planos para badges/chips salvo validación específica.

## Niveles de validación obligatorios

```text
PASS_STATIC
DEFINITION_ACCEPTED
INSTANCE_SAFE
PUBLIC_CONTRACT_VALIDATED
VISUAL_QA_VALIDATED
READY_FOR_INTEGRATION
```

> `DEFINITION_ACCEPTED` no implica `INSTANCE_SAFE`.

## Reglas de compatibilidad confirmadas

| Patrón | Riesgo / efecto confirmado | Regla preventiva |
|---|---|---|
| `Label@2.5.1` + Radius* | `PA2108` | Radios en el contenedor, no en Label. |
| `Classic/Button@2.2.0` + AccessibleLabel | `PA2108` | No declarar sin validación específica. |
| `TabList@2.2.30` + Reset() | error de fórmula | Gestionar selección mediante variable. |
| CanvasComponent solo en GitHub | `PA2301` | Confirmar instalación real en la app. |
| Definición aceptada | puede cerrar Studio al instanciar | Smoke test aislado obligatorio. |
| SVG inline como sustituto visual | renderizado poco fiable | No usar como fallback automático. |
| `ModernText@1.0.0` estático | clipping/mini-scroll con altura rígida | `AutoHeight=true` por defecto. |
| `CustomProperties:` en Source Code | compatible cuando el contrato está bien formado | No prohibir; usar componente instance-safe como plantilla. |
| Input nuevo reutilizable | contrato reducido puede no ser equivalente | Preservar `PropertyKind + DisplayName + Description + DataType + Default` cuando ese sea el patrón de referencia. |
| Fórmula Power Fx inline cuyo literal contiene `: ` | `PA1001 YamlInvalidSyntax / invalid mapping` | Bloque YAML `|-` con `=` en la línea siguiente. |
| `Classic/TextInput@2.3.2` | patrón estable PULSE PunchReview | Reutilizar para edición. |
| `GroupContainer` con `Children` dentro de `Gallery` | `PA1001 Expected Scalar, got SequenceStart` observado en TreePro | usar badge/chip plano dentro de la plantilla; no anidar hasta tener contraejemplo positivo. |

## PA1001 — literales con `: ` dentro de fórmulas inline

Durante F01-02/03 una fórmula como:

```yaml
Text: ="Unidad: " & varFL_Plant
```

produjo:

```text
PA1001
YamlInvalidSyntax
While scanning a plain scalar value, found invalid mapping
```

Patrón preventivo:

```yaml
Text: |-
  ="Unidad: " & varFL_Plant
```

Ante un `PA1001 invalid mapping`, revisar toda la clase de scalars inline con `: ` y corregirla en bloque antes de pedir otra validación.

## PA1001 — contenedor anidado en plantilla Gallery

Durante `F01-TREE-02` el badge visual `ACTIVO` estaba implementado mediante un `GroupContainer` con `Children` dentro de la plantilla de una Gallery.

Studio devolvió:

```text
PA1001
Expected 'Scalar', got 'SequenceStart'
```

La línea indicada correspondía a `Children:` del badge.

Corrección validada estáticamente:

- sustituir el badge anidado por un `Classic/Button@2.2.0` plano;
- conservar geometría y aspecto sin introducir una segunda jerarquía de controles en el template.

Alcance de la regla:

> No se afirma que cualquier anidación futura sea universalmente imposible. En este Functional Lab se evita este patrón hasta disponer de un contraejemplo `INSTANCE_SAFE` en el mismo schema.

## FL-SC-001 — diagnóstico corregido

Las primeras pruebas del Sidebar demostraron que una definición podía ser aceptada y aun cerrar Studio al instanciar. Eso nunca fue prueba suficiente para invalidar `CustomProperties` como característica.

`cmp_HeatMapPro` de PULSE aportó el contraejemplo decisivo:

- Inputs Text, Boolean, Number, Color y Table;
- Outputs de varios tipos;
- Events;
- bindings internos;
- instancia estable.

Regla retirada:

```text
FALSO COMO REGLA GENERAL:
"CustomProperties en Source Code es inseguro"
```

## RC2 — patrón HeatMap aplicado al Sidebar

El Sidebar se reconstruyó en un componente limpio con contrato completo:

```yaml
PropertyKind: Input
DisplayName: ...
Description: ...
DataType: ...
Default: ...
```

Resultado comunicado por el usuario:

```text
DEFINITION_ACCEPTED PASS
INSTANCE_SAFE PASS
```

Esto valida el patrón práctico, sin afirmar que DisplayName/Description sean por sí solos requisitos universales ni la única causa del fallo inicial.

## Referencias positivas

```text
PULSE cmp_HeatMapPro
PULSE cmp_SidebarNav / patrones de navegación
PULSE Classic/TextInput@2.3.2
CMMS cmp_FL_SidebarPro RC2
CMMS cmp_FL_PageHeaderPro
CMMS App Shell v1
CMMS Runtime P-101
CMMS WS-01
CMMS WS-02
```

## Architecture v2 — control estático

El 2026-08-10 se descargó la rama `feature/f01-premium-foundation` y se revisaron los `.pa.yaml` del Functional Lab.

Resultado:

```text
PASS_STATIC
```

Se comprobó:

- parse YAML;
- resolución de referencias `Navigate(scr_FL_...)` dentro del conjunto de pantallas;
- resolución de `ComponentName: cmp_FL_...`;
- ausencia de `Label@2.5.1 + Radius*`;
- ausencia de `Classic/Button@2.2.0 + AccessibleLabel`;
- ausencia de la clase conocida de fórmula inline con literal `: `;
- ausencia de `GroupContainer` con `Children` dentro de Gallery en el conjunto revisado.

Ver:

`V2_STATIC_VALIDATION_2026-08-10.md`

## Estado actual

```text
cmp_FL_SidebarPro          INSTANCE_SAFE PASS
cmp_FL_PageHeaderPro       INSTANCE_SAFE PASS
F01-01 App Shell v1        VALIDATED PASS
F01-02/03 Runtime P-101    VALIDATED PASS
WS-01 v1                   VALIDATED PASS
WS-02 v1                   VALIDATED PASS
TreePro motor 11 niveles   DEFINITION/PAGE LOAD observado; Premium visual candidate pendiente de nueva QA
Architecture v2            PASS_STATIC
ProcessRailPro             PASS_STATIC / Studio pending
DecisionPanelPro           PASS_STATIC / Studio pending
GatePanelPro               PASS_STATIC / Studio pending
21 pantallas v2            PASS_STATIC / Studio integrated QA pending
```

## Siguiente gate

Seguir `../power-apps/V2_INSTALLATION.md`.

La estrategia de validación es integrada:

```text
Foundation components
→ Home
→ FLH
→ Case Overview / Process Rail
→ Failure Modes / DecisionPanel
→ AMEF / calculation + decision + gate
```

No solicitar 21 ciclos independientes si los smoke tests representativos pueden validar primero la arquitectura completa.
