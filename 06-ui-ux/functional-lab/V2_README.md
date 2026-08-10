# CMMS 2.0 Functional Lab — Modelo alineado

Este documento es el punto de entrada canónico del Functional Lab después de la auditoría de alineación con las últimas reuniones.

## Propósito

El laboratorio se experimenta como una aplicación CMMS real, pero protege una idea fundamental:

> **la ingeniería AMEF/RCM reusable existe antes que el caso de un activo concreto.**

El flujo canónico es:

```text
Biblioteca AMEF
→ Revisión versionada
→ Aplicación a activos
→ Criticidad / contexto de planta
→ AnalysisCase
→ AMEF + RCM contextual
→ tarea ejecutable
→ recursos / alcance / agrupación
→ Job Plan / PM / WO
→ resultado real
→ mejora de aplicación o biblioteca
```

## Leer primero

1. [Guía guiada para la demostración](guides/GUIA_DEMOSTRACION_CMMS_FUNCTIONAL_LAB.md)
2. [Guía de experiencia funcional del usuario](guides/GUIA_EXPERIENCIA_FUNCIONAL_USUARIO.md)
3. [Auditoría de alineación D-01…D-14](development/AUDITORIA_ALINEACION_ULTIMAS_REUNIONES_2026-08-10.md)
4. [Arquitectura](architecture.md)
5. [Estado canónico](V2_STATUS.md)
6. [ADRs](adr/README.md)
7. [Mapa de pantallas](screen-map.md)
8. [Contratos de dominio](domain-contracts.md)
9. [Catálogo de componentes](component-catalog.md)
10. [Instalación y smoke tests](power-apps/V2_INSTALLATION.md)

## Cambios protegidos por la auditoría

El modelo ya incorpora:

- biblioteca AMEF reusable por familia de equipo;
- revisión AMEF inmutable/versionada;
- aplicación de una revisión a múltiples activos;
- criticidad de planta separada del riesgo AMEF;
- perfiles/variantes contextuales;
- causas/mecanismos de fallo;
- relación N:M tarea ↔ modo;
- procedimiento/checklist opcional;
- condiciones de ejecución por tarea;
- duración, cuadrilla y H-H;
- economía preliminar, coste planificado y coste real separados;
- lógica RCM versionable;
- alcance físico por TechnicalObject;
- Job Plan / PM / WO / ExecutionResult diferenciados;
- reglas de agrupación sin pérdida de identidad por tag.

## Power Apps

### Foundation — 9 componentes

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

### Pantallas — 25

La lista canónica está en:

`power-apps/screens/README.md`

Las cuatro pantallas añadidas por la auditoría son:

```text
scr_FL_AssetCriticality
scr_FL_FmeaLibrary
scr_FL_FmeaRevision
scr_FL_AssetApplication
```

### Runtime

El runtime conceptual alineado está en:

`power-apps/runtime/functional-lab-aligned-bootstrap.powerfx`

Además, `scr_FL_Home.OnVisible` contiene el fixture necesario para ejecutar la experiencia alineada en la app de validación.

## AMEF P-101

Configuración demostrativa actual:

```text
S = 4 / 5
O = 3 / 5
D = 3 / 5
S×O = 12
NPR = 36
```

La matriz es **Matriz de riesgo AMEF**.

La criticidad de P-101 es un dato contextual independiente (`Alta` en el fixture), no un resultado de S/O/D.

## Journey

Las 28 etapas siguen existiendo y se muestran mediante `cmp_FL_ProcessRailPro`.

La corrección no elimina etapas. Cambia su interpretación inicial:

```text
FL-01..03   confirmar aplicación y contexto
FL-04..05   revisar funciones/fallos heredados
FL-06       seleccionar modos/causas aplicables
FL-07..11   contextualizar efectos y riesgo AMEF
FL-12..16   decisión RCM versionable
FL-17       economía preliminar
FL-18..19   tarea ejecutable e intervalo
FL-20..22   recursos, alcance y agrupación
FL-23..24   trazabilidad y calidad
FL-25..26   revisión, aprobación y snapshot
FL-27..28   resultados reales y mejora
```

## Decisiones todavía abiertas

El Functional Lab **no fija todavía**:

- escalas AMEF corporativas;
- umbrales/bandas/colores;
- reglas oficiales de criticidad;
- árbol RCM definitivo;
- reglas P–F / intervalo;
- autoridades finales;
- evidencias mínimas;
- reglas de sobreclasificación;
- criterios de aprobación;
- KPIs de efectividad;
- reglas corporativas definitivas de agrupación;
- CMMS destino e integración;
- arquitectura física de datos.

Estas son las siguientes decisiones funcionales a validar una vez que la arquitectura alineada supere Studio.

## Estado de validación

La corrección de modelo y Source Code está implementada.

El siguiente paso es:

```text
revalidación estática integral
→ instalación de 9 componentes
→ instalación de 25 pantallas
→ 7 smoke tests integrados
→ Visual QA
→ decisiones corporativas abiertas
```

No declarar `INSTANCE_SAFE` ni `VISUAL_QA_VALIDATED` para elementos nuevos hasta comprobarlos en Power Apps Studio.
