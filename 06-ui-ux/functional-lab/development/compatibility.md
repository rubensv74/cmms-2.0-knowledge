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
9. no declarar `INSTANCE_SAFE` sin prueba real en Studio;
10. no diagnosticar `Navigate(scr_FL_...)` mientras el grafo canónico de pantallas esté incompleto en Studio;
11. no recuperar componentes/pantallas desde commits históricos aislados para una instalación normal;
12. preservar identidad de componente: actualización in situ o migración controlada;
13. en componentes afectados por FL-SC-004, la paleta visual base no debe depender de Inputs `Color` no validados en la instancia actual;
14. no introducir texto visible < 11 para resolver problemas de espacio.

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
| componente corregido agregado como copia nueva | instancias antiguas siguen ligadas a identidad anterior | actualizar definición in situ |
| grafo de pantallas parcial + `Navigate(scr_FL_X)` | `Name isn't valid` mientras `scr_FL_X` no exista en Studio | crear primero las 25 identidades canónicas |
| rollback por archivo histórico | puede reintroducir defectos corregidos en revisiones posteriores | recuperar ensamblaje coherente de una rama canónica |
| Input `Color` en componente afectado por FL-SC-004 | superficie/texto puede materializarse incorrectamente en Studio | conservar contrato si es necesario, pero usar safe palette en el camino visual base |

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

## Arquitectura alineada

La v2 utiliza:

```text
9 componentes canónicos
25 pantallas canónicas
```

Componentes:

```text
cmp_FL_SidebarPro
cmp_FL_PageHeaderPro
cmp_FL_TreePro
cmp_FL_ProcessRailPro
cmp_FL_DecisionPanelPro
cmp_FL_GatePanelPro
cmp_FL_RiskMatrixPro
cmp_FL_LineagePanelPro
cmp_FL_ApplicabilityMatrixPro
```

El antiguo `WorkspaceShell` queda como evidencia histórica.

## Grafo de pantallas — regla de instalación

Antes de evaluar fórmulas de navegación deben existir las 25 identidades documentadas en:

`../power-apps/screens/README.md`

Patrón:

```text
crear pantallas faltantes como Blank screen con nombre final
→ comprobar desaparición de Name isn't valid por destino ausente
→ actualizar componentes in situ
→ cargar fuente actual de pantallas
```

Un `Name isn't valid. 'scr_FL_X'` no prueba un fallo de Power Fx si `scr_FL_X` todavía no existe como objeto de Studio.

## Componente identity — regla obligatoria

Si una definición corregida ya tiene instancias:

```text
NO insertar una nueva copia
NO asumir que _1 reemplaza al componente original
```

Usar:

```text
actualización in situ de la definición existente
```

La creación de una nueva identidad solo se admite como migración deliberada y controlada.

## FL-SC-004 — safe palette

### Efecto confirmado

En esta fase se observaron instancias con superficies/textos negros al materializar determinadas propiedades visuales `Color`.

La causa interna exacta de Power Apps no se declara resuelta.

### Patrón correctivo operativo

En componentes afectados:

- mantener Inputs `Color` si forman parte del contrato que consumen pantallas existentes;
- no depender de dichos Inputs para la paleta visual base hasta que la instancia concreta se valide;
- usar `ColorValue(...)`/RGBA conocidos en la ruta segura;
- habilitar tematización del host únicamente mediante una ruta explícita y validada.

Componentes hardened al cierre del 11-08:

```text
cmp_FL_TreePro                 HARDENED SAFE PALETTE RC3
cmp_FL_LineagePanelPro         HARDENED SAFE PALETTE RC3
cmp_FL_GatePanelPro            HARDENED SAFE PALETTE RC2
cmp_FL_ApplicabilityMatrixPro  HARDENED READABILITY RC2
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

No reducir texto para evitar scroll. Reorganizar layout, aumentar altura o habilitar scroll.

No aplicar reemplazos globales de tamaños a las 25 pantallas sin validar una pantalla de referencia, porque el aumento puede requerir cambios de layout.

## Reglas funcionales que afectan al Source Code

### Biblioteca vs aplicación

Las pantallas de AnalysisCase no deben crear silenciosamente funciones/fallos/modos como si pertenecieran a P-101. Deben consumir objetos de `FmeaRevision` y registrar aplicabilidad/contexto/override cuando corresponda.

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

El bootstrap pre-auditoría está retirado para evitar reinstalaciones accidentales del modelo anterior.

## Estado de validación tras hardening 11-08

```text
cmp_FL_SidebarPro              evidencia INSTANCE_SAFE previa; revisión actual requiere smoke integrado
cmp_FL_PageHeaderPro           evidencia INSTANCE_SAFE previa; revisión actual requiere smoke integrado
cmp_FL_TreePro                 SOURCE HARDENED / Studio retest pendiente
cmp_FL_ProcessRailPro          SOURCE revisado / Studio pendiente
cmp_FL_DecisionPanelPro        SOURCE revisado / Studio pendiente
cmp_FL_GatePanelPro            SOURCE HARDENED / Studio retest pendiente
cmp_FL_RiskMatrixPro           RC4 SOURCE / Studio QA pendiente
cmp_FL_LineagePanelPro         SOURCE HARDENED / Studio retest pendiente
cmp_FL_ApplicabilityMatrixPro  SOURCE HARDENED / Studio retest pendiente
25 pantallas                   fuentes publicadas / instalación integrada pendiente
```

No promover este cuadro por inferencia. Solo Studio puede aumentar el nivel de aceptación.

## Siguiente gate

Seguir:

- `../power-apps/V2_INSTALLATION.md`
- `TOMORROW_RUNBOOK_2026-08-12.md`
- `RECOVERY_HARDENING_AUDIT_2026-08-11.md`
