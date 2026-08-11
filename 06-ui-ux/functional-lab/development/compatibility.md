# Functional Lab — Power Apps Source Code Compatibility

**Estado:** activo antes de cualquier YAML  
**Actualizado:** 2026-08-11

## Autoridad de construcción

Antes de redactar, corregir o publicar cualquier `.pa.yaml`, consultar primero la versión vigente de:

`functional-engineering-knowledge-base/30-playbooks/power-platform/modular-power-apps-screen-construction.md`

El método obligatorio es:

```text
SKELETON
→ PLACEHOLDER CONTRATADO
→ BLOCK S / C / I
→ PEGAR EN STUDIO
→ VALIDAR
→ FREEZE
→ NEXT BLOCK
```

Si un incremento falla, se corrige mediante `FIX` del mismo bloque. No se usa el bloque siguiente para reparar silenciosamente el anterior.

## Gate obligatorio pre-YAML

Antes de cualquier `.pa.yaml`:

1. leer el playbook modular vigente;
2. leer este documento;
3. declarar `BLOCK`, `TARGET`, `ACTION`, `DEPENDS ON`, `TOUCHES`, `DO NOT MODIFY`, `VALIDATION` y estado esperado;
4. confirmar control y versión contra referencias probadas;
5. reutilizar patrones positivos de PULSE/Functional Lab cuando existan;
6. separar fuente, definición, instancia, contrato y QA visual;
7. para nuevas `CustomProperties`, usar contrato completo por `PropertyKind`;
8. convertir fórmulas inline con literales `: ` a bloque YAML `|-`;
9. evitar `GroupContainer` con `Children` dentro de plantillas Gallery salvo contraejemplo validado;
10. no usar SVG inline como fallback visual;
11. no declarar `INSTANCE_SAFE` sin prueba real en Studio;
12. no diagnosticar `Navigate(scr_FL_...)` mientras el grafo de identidades esté incompleto en Studio;
13. no recuperar componentes/pantallas desde commits históricos aislados para una instalación normal;
14. preservar identidad de componente: actualización in situ o migración controlada;
15. no introducir texto visible <11 para resolver problemas de espacio;
16. no modificar una pieza `FUNCTIONAL_FROZEN` o `FINAL_FROZEN` salvo que el bloque lo declare expresamente;
17. separar estructura, comportamiento y color;
18. validar dudas cromáticas/render en `scr_DesignSystemLab` antes de propagarlas.

## Tipos de bloque

```text
S — Structural
C — Component
I — Integration
FIX — reparación aislada del bloque que falló
```

### S — Structural

Crea shell, containers, slots, placeholders y geometría. Una vez aprobada, la geometría queda congelada.

### C — Component

Sustituye un placeholder/slot por un componente real o modifica una pieza visual concreta. No rediseña la pantalla.

### I — Integration

Conecta piezas ya estables. No debe rehacer geometría ni rediseñar componentes.

## Niveles de validación de componentes

```text
SOURCE_VALID
→ COMPONENT_DEFINITION_ACCEPTED
→ INSTANCE_SAFE
→ PUBLIC_CONTRACT_VALIDATED
→ VISUAL_QA_VALIDATED
→ READY_FOR_INTEGRATION
```

`SOURCE_VALID` o definición aceptada no implican `INSTANCE_SAFE`.

## Estados de construcción

```text
IN_CONSTRUCTION
→ FUNCTIONAL
→ FUNCTIONAL_FROZEN
→ VISUAL_APPROVED
→ FINAL_FROZEN
```

Capas:

```text
STRUCTURE       OPEN | FROZEN
BEHAVIOR        OPEN | FROZEN
DATA CONTRACT   OPEN | FROZEN
COLOR           PENDING | APPROVED
```

El color puede permanecer `PENDING` mientras estructura, comportamiento y contrato estén congelados.

## Reglas confirmadas de Source Code

| Patrón | Riesgo confirmado | Regla |
|---|---|---|
| `Label@2.5.1` + Radius* | PA2108 | radios en contenedor |
| `Classic/Button@2.2.0` + AccessibleLabel | PA2108 | no declarar sin validación específica |
| `TabList@2.2.30` + Reset() | error de fórmula | selección mediante variable |
| CanvasComponent solo en Git | PA2301 | instalar/validar componente antes de pantalla consumidora |
| ModernText con altura rígida | clipping/mini-scroll | `AutoHeight=true` por defecto |
| Input CustomProperty reducido | contrato inestable | usar `PropertyKind + DisplayName + Description + DataType + Default` |
| Power Fx inline con literal `: ` | PA1001 | bloque YAML `|-` |
| `Classic/TextInput@2.3.2` | patrón positivo | reutilizable para edición |
| GroupContainer anidado en Gallery | PA1001 `Expected Scalar` | controles planos dentro del template |
| SVG inline | render poco fiable | no usar como fallback |
| componente corregido agregado como copia nueva | las instancias antiguas conservan la identidad anterior | actualizar definición in situ |
| grafo parcial + `Navigate(scr_FL_X)` | `Name isn't valid` mientras `scr_FL_X` no exista | crear identidad faltante antes de diagnosticar fórmula |
| rollback por archivo histórico | reintroduce defectos posteriores ya corregidos | usar rama/ensamblaje coherente; histórico solo forense |
| Color input afectado por FL-SC-004 | render visual inesperado en algunas instancias | validar rol/token en DesignSystemLab antes de propagar |

## Referencia positiva primero

Ante un componente `FAIL_INSTANCE`, no iniciar una batería de micropruebas si existe un componente PULSE comparable `INSTANCE_SAFE`.

Referencias principales:

```text
PULSE cmp_HeatMapPro
PULSE cmp_SidebarNav
PULSE Classic/TextInput@2.3.2
CMMS cmp_FL_SidebarPro
CMMS cmp_FL_PageHeaderPro
```

Secuencia:

```text
componente con problema
→ componente PULSE comparable
→ diff de contrato + cuerpo + versiones
→ candidato completo corregido
→ un smoke test
```

Solo después, si sigue fallando, reducción controlada.

## Arquitectura alineada

El producto funcional mantiene:

```text
9 componentes canónicos
25 pantallas funcionales canónicas
```

`scr_DesignSystemLab` es una utility screen de validación visual; no aumenta el alcance funcional ni entra en navegación del producto.

## Grafo de pantallas

Antes de evaluar referencias cross-screen pueden crearse como `Blank screen` las identidades canónicas faltantes.

Eso es preparación del grafo, no autorización para pegar 25 pantallas monolíticas.

Una pantalla nueva o una pantalla abierta a reconstrucción debe seguir:

```text
S skeleton completo
→ geometry freeze
→ C placeholder a componente
→ validate/freeze
→ I integraciones
→ Theme pass separado
```

## Identidad de componente

Si una definición ya tiene instancias:

```text
NO insertar copia nueva
NO asumir que _1 sustituye a la identidad original
```

Usar actualización in situ. Una nueva identidad exige migración explícita.

## FL-SC-004 — color y Theme

Se observaron superficies/textos negros al materializar determinadas propiedades visuales `Color`. La causa interna exacta no se declara resuelta.

Desde el playbook actualizado:

- el componente no inventa su propia paleta semántica;
- los colores responden a roles/tokens compartidos;
- los valores hardcoded actuales se consideran fallback de compatibilidad, no fuente semántica definitiva;
- la paleta se valida centralmente en `scr_DesignSystemLab`;
- un componente puede quedar `FUNCTIONAL_FROZEN` con `COLOR PENDING`.

Roles mínimos:

```text
Background
Surface
SurfaceAlt
Border
TextPrimary
TextSecondary
Primary
PrimaryHover
PrimarySelected
SelectedBackground
SelectedBorder
SelectedAccent
SelectedText
Success
Warning
Danger
Chart01…Chart06
```

## Tipografía y densidad

Baseline Comfortable:

```text
visible mínimo  11
supporting      12
labels          12–13
body            13–14
card title      15–17
section title   16–18
page title      24–28
button          12–13
```

No reducir tipografía para evitar scroll. Cambiar layout, altura o estrategia de overflow mediante un bloque explícito.

No aplicar search-and-replace global de tamaños o colores.

## Reglas funcionales que afectan al Source Code

### Biblioteca vs aplicación

AnalysisCase consume objetos de `FmeaRevision` y registra aplicabilidad/contexto/override; no recrea silenciosamente funciones/fallos/modos como propiedad de P-101.

### Criticidad vs riesgo AMEF

`AssetCriticalityAssessment` y `RiskAssessment AMEF` son conceptos separados. La matriz S×O se denomina `Matriz de riesgo AMEF`.

### Tarea

La UI debe distinguir:

```text
ProposedMaintenanceTask
TaskProfileVariant
MaintenanceTask
MaintenanceProcedure opcional
```

### Handoff

No usar como sinónimos:

```text
MaintenanceTask
MaintenanceProcedure
JobPlan / Route
PreventiveMaintenancePlan
WorkOrder
```

## Bootstrap

`scr_FL_Home.OnVisible` permanece como autoridad del fixture alineado mediante `varFLAlignedInitialized`.

No reinstalar bootstraps legacy.

## Estado de fuente al cierre del hardening 11-08

```text
cmp_FL_SidebarPro              evidencia positiva previa / no tocar sin fallo real
cmp_FL_PageHeaderPro           evidencia positiva previa / no tocar sin fallo real
cmp_FL_TreePro                 RC3 SOURCE / Studio retest pendiente
cmp_FL_ProcessRailPro          SOURCE revisado / Studio pendiente
cmp_FL_DecisionPanelPro        SOURCE revisado / Studio pendiente
cmp_FL_GatePanelPro            RC2 SOURCE / Studio retest pendiente
cmp_FL_RiskMatrixPro           RC4 SOURCE / Studio QA pendiente
cmp_FL_LineagePanelPro         RC3 SOURCE / Studio retest pendiente
cmp_FL_ApplicabilityMatrixPro  RC2 SOURCE / Studio retest pendiente
```

Consultar `FREEZE_REGISTER_2026-08-11.md` antes de declarar `TOUCHES`/`DO NOT MODIFY`.

## Siguiente gate

Seguir, en este orden:

1. `TOMORROW_RUNBOOK_2026-08-12.md`
2. `FREEZE_REGISTER_2026-08-11.md`
3. `RECOVERY_HARDENING_AUDIT_2026-08-11.md`
4. `../power-apps/V2_INSTALLATION.md`
