# Estado del proyecto

**Última actualización:** 2026-08-11  
**Rama de trabajo:** `feature/f01-premium-foundation`

## Estado general

CMMS 2.0 se encuentra en fase **Functional Lab**. El modelo funcional está alineado y el foco actual es estabilizar la construcción Power Apps sin perder el conocimiento ya validado.

El laboratorio sigue siendo un instrumento de análisis funcional ejecutable, no una decisión de arquitectura productiva para IT.

## Modelo funcional consolidado

```text
Biblioteca AMEF reusable
→ revisión versionada
→ aplicación a activos
→ contexto / criticidad
→ AnalysisCase / 28 etapas
→ AMEF + RCM
→ tarea ejecutable
→ alcance / agrupación
→ Job Plan / PM / WO
→ ExecutionResult
→ efectividad / mejora
```

P-101 consume `AMEF-BOMBA-CENTRIFUGA / R01`; no posee la ingeniería AMEF.

Las desviaciones funcionales D-01…D-14 identificadas durante la auditoría están alineadas en el modelo conceptual y UI.

## Evidencia Studio conservada

```text
HOME OK
ACTIVOS OK
BIBLIOTECA AMEF OK
APLICACIÓN MULTI-ACTIVO OK
HOME BASELINE PASS
FLH PASS
TAXONOMÍA PASS
ADR PASS
```

Esta evidencia se conserva y evita reconstruir piezas ya aprobadas.

## Incidente de recuperación

Durante la evolución de AMEF se mezclaron simultáneamente cambios de shell, navegación, Process Rail, matriz, tipografía y color.

Después, un rollback por archivos históricos reintrodujo:

- dependencias visuales antiguas;
- superficies negras inesperadas;
- ruido de `Name isn't valid` causado en parte por un grafo de pantallas incompleto en Studio.

La arquitectura funcional no se descarta. Se cambia el método de construcción.

## Estrategia Power Apps vigente

Autoridad:

`functional-engineering-knowledge-base/30-playbooks/power-platform/modular-power-apps-screen-construction.md`

Método obligatorio:

```text
SKELETON
→ PLACEHOLDERS
→ BLOCK S / C / I
→ POWER APPS STUDIO
→ VALIDATE
→ FREEZE
→ NEXT BLOCK
```

Los fallos utilizan un bloque `FIX` independiente.

No se sustituirán de forma rutinaria componentes/pantallas completos por lotes.

## Freeze actual

### Functional foundation

```text
Home                         FUNCTIONAL_FROZEN
FLH                          FUNCTIONAL_FROZEN / Tree RC3 revalidation required
Taxonomía                    FUNCTIONAL_FROZEN / Tree RC3 revalidation required
ADR                          FUNCTIONAL_FROZEN / Tree RC3 revalidation required
Biblioteca AMEF              FUNCTIONAL_FROZEN
Revisión AMEF                FUNCTIONAL_FROZEN
Aplicación multi-activo      FUNCTIONAL_FROZEN / Applicability RC2 revalidation required
```

Color permanece `PENDING` hasta validación centralizada.

### AMEF

```text
scr_FL_AMEF
STATUS       IN_CONSTRUCTION
STRUCTURE    OPEN
BEHAVIOR     OPEN
COLOR        PENDING
```

AMEF se reconstruirá `skeleton first`.

## Componentes

Fuentes actuales:

```text
cmp_FL_SidebarPro              evidencia positiva previa
cmp_FL_PageHeaderPro           evidencia positiva previa
cmp_FL_TreePro                 HARDENED SAFE PALETTE RC3
cmp_FL_ProcessRailPro          source revisado
cmp_FL_DecisionPanelPro        source revisado
cmp_FL_GatePanelPro            HARDENED SAFE PALETTE RC2
cmp_FL_RiskMatrixPro           Premium 5×5 RC4
cmp_FL_LineagePanelPro         HARDENED SAFE PALETTE RC3
cmp_FL_ApplicabilityMatrixPro  HARDENED READABILITY RC2
```

Una revisión modificada no se considera `INSTANCE_SAFE` hasta pasar Studio.

## Design System Lab

Se crea una utility screen técnica:

```text
scr_DesignSystemLab
```

No forma parte de las 25 pantallas funcionales ni de la navegación del producto.

Primer bloque preparado:

```text
DS-S01 — skeleton + placeholders
```

No se preparará `DS-C01` hasta validar y congelar DS-S01 en Studio.

El laboratorio se utilizará para cerrar:

```text
tokens semánticos
color
contraste
Classic/Modern controls
hover / pressed / selected / disabled / focus
data visualisation palette
```

## Siguiente acción exacta

Mañana:

1. completar las identidades de pantallas canónicas que falten para eliminar ruido de dependencias;
2. crear `scr_DesignSystemLab` y pegar únicamente `DS-S01`;
3. validar geometría y congelarla;
4. continuar DS-C01…DS-C04 uno a uno;
5. validar las revisiones actuales de componentes en aislamiento;
6. integrar solo la pieza aprobada en las pantallas ya congeladas;
7. preparar y validar `S-AMEF-01`;
8. sustituir progresivamente placeholders AMEF mediante C/I.

Guía detallada:

`06-ui-ux/functional-lab/development/TOMORROW_RUNBOOK_2026-08-12.md`

## Fuentes de verdad operativas

```text
00-governance/cmms-functional-lab-incremental-protocol.md
00-governance/functional-lab-yaml-delivery.md
06-ui-ux/functional-lab/V2_STATUS.md
06-ui-ux/functional-lab/development/compatibility.md
06-ui-ux/functional-lab/development/FREEZE_REGISTER_2026-08-11.md
06-ui-ux/functional-lab/development/RECOVERY_HARDENING_AUDIT_2026-08-11.md
06-ui-ux/functional-lab/development/STATIC_SOURCE_AUDIT_2026-08-11.md
06-ui-ux/functional-lab/development/TOMORROW_RUNBOOK_2026-08-12.md
```

## Riesgos principales controlados

- no confundir laboratorio con arquitectura productiva;
- no automatizar hipótesis;
- no asociar automáticamente etapa funcional = pantalla;
- no asumir componente GitHub = componente validado en Studio;
- no crear copias `_1` como actualización;
- no diagnosticar Navigate sobre un grafo incompleto;
- no usar commits históricos como catálogo de piezas;
- no reducir tipografía para hacer caber contenido;
- no propagar color sin DesignSystemLab;
- no modificar piezas congeladas desde otro bloque.

## Decisiones deliberadamente abiertas

Continúan abiertas las escalas/bandas AMEF corporativas, criticidad oficial, árbol RCM definitivo, reglas P-F/intervalo, autoridades, evidencia mínima, sobreclasificación, criterios de aprobación, KPIs de efectividad, agrupación final, sistema destino, integración y arquitectura física de datos.
