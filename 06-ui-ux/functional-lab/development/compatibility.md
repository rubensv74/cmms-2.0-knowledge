# Functional Lab — Power Apps Source Code Compatibility

**Estado:** activo antes de cualquier YAML  
**Actualizado:** 2026-08-11

## Gate obligatorio pre-YAML

Antes de redactar, corregir o publicar cualquier `.pa.yaml`:

1. leer este documento;
2. confirmar control y versión contra referencias probadas;
3. reutilizar patrones positivos de PULSE/Functional Lab cuando existan;
4. separar `PASS_STATIC`, aceptación de definición y seguridad de instancia;
5. para nuevas `CustomProperties`, usar contrato completo por `PropertyKind`;
6. convertir fórmulas inline con literales `: ` a bloque YAML `|-`;
7. evitar `GroupContainer` con `Children` dentro de plantillas Gallery salvo contraejemplo validado;
8. no usar SVG inline como fallback visual;
9. no declarar `INSTANCE_SAFE` sin prueba real en Studio.

## Niveles de validación

```text
PASS_STATIC
DEFINITION_ACCEPTED
INSTANCE_SAFE
PUBLIC_CONTRACT_VALIDATED
VISUAL_QA_VALIDATED
READY_FOR_INTEGRATION
```

> `PASS_STATIC` y `DEFINITION_ACCEPTED` no implican `INSTANCE_SAFE`.

## Reglas confirmadas

| Patrón | Riesgo confirmado | Regla |
|---|---|---|
| `Label@2.5.1` + Radius* | PA2108 | radios en contenedor |
| `Classic/Button@2.2.0` + AccessibleLabel | PA2108 | no declarar sin validación específica |
| `TabList@2.2.30` + Reset() | error de fórmula | selección mediante variable |
| CanvasComponent solo en Git | PA2301 | instalar componente antes de pantalla consumidora |
| ModernText con altura rígida | clipping/mini-scroll | `AutoHeight=true` por defecto |
| Input CustomProperty reducido | contrato inestable | usar `PropertyKind + DisplayName + Description + DataType + Default` |
| Power Fx inline con literal `: ` | PA1001 | bloque YAML `|-` |
| `Classic/TextInput@2.3.2` | patrón positivo | reutilizable para edición |
| GroupContainer anidado en Gallery | PA1001 `Expected Scalar` | controles planos dentro de template |
| SVG inline | render poco fiable | no usar como fallback |

## Evidencia positiva

```text
PULSE cmp_HeatMapPro
PULSE Sidebar/Nav patterns
PULSE Classic/TextInput@2.3.2
CMMS cmp_FL_SidebarPro RC2
CMMS cmp_FL_PageHeaderPro
CMMS App Shell v1
CMMS Runtime P-101 v1
CMMS WS-01
CMMS WS-02
```

## Estado tras auditoría funcional D-01…D-14

La arquitectura alineada amplía la v2 a:

```text
9 componentes canónicos
25 pantallas canónicas
```

Nuevos componentes:

```text
cmp_FL_LineagePanelPro
cmp_FL_ApplicabilityMatrixPro
```

Nuevas pantallas:

```text
scr_FL_AssetCriticality
scr_FL_FmeaLibrary
scr_FL_FmeaRevision
scr_FL_AssetApplication
```

El antiguo `WorkspaceShell` queda como evidencia histórica.

## Reglas funcionales que afectan al Source Code

### Biblioteca vs aplicación

Las pantallas de AnalysisCase no deben crear silenciosamente funciones/fallos/modos como si pertenecieran a P-101. Deben consumir objetos de `FmeaRevision` y registrar únicamente aplicabilidad/contexto/override cuando corresponda.

### Criticidad vs riesgo AMEF

Nunca usar `Matriz de criticidad` como título de S×O. Usar `Matriz de riesgo AMEF` o equivalente.

### Tarea

La UI debe poder representar:

```text
ProposedMaintenanceTask
TaskProfileVariant
MaintenanceTask
MaintenanceProcedure opcional
```

Parada, aislamiento, permiso, duración, cuadrilla y H-H pertenecen a la tarea ejecutable.

### Handoff

No usar como sinónimos:

```text
MaintenanceTask
MaintenanceProcedure
JobPlan / Route
PreventiveMaintenancePlan
WorkOrder
```

## Bootstrap canónico

La experiencia alineada se inicializa desde `scr_FL_Home.OnVisible` con `varFLAlignedInitialized`.

Referencia conceptual equivalente:

`../power-apps/runtime/functional-lab-aligned-bootstrap.powerfx`

El bootstrap pre-auditoría ha sido retirado para evitar reinstalaciones accidentales del modelo anterior.

## Estado de validación actual

```text
cmp_FL_SidebarPro              INSTANCE_SAFE PASS
cmp_FL_PageHeaderPro           INSTANCE_SAFE PASS
cmp_FL_TreePro                 QA final pendiente
cmp_FL_ProcessRailPro          PASS_STATIC / Studio pending
cmp_FL_DecisionPanelPro        PASS_STATIC / Studio pending
cmp_FL_GatePanelPro            PASS_STATIC / Studio pending
cmp_FL_RiskMatrixPro           PASS_STATIC / Studio pending
cmp_FL_LineagePanelPro         PASS_STATIC / Studio pending
cmp_FL_ApplicabilityMatrixPro  PASS_STATIC / Studio pending
modelo alineado 25 pantallas   validación integrada Studio pendiente
```

## Siguiente gate

Seguir `../power-apps/V2_INSTALLATION.md` y ejecutar los smoke tests integrados del modelo alineado.
