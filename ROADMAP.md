# Roadmap CMMS 2.0

## 1. Cómo leer este roadmap

Se distinguen:

1. **mapa funcional del producto** — capacidades que CMMS 2.0 debe cubrir;
2. **roadmap de validación** — orden de aprendizaje/consolidación dentro del Functional Lab.

El orden de validación no decide el orden productivo final.

---

# 2. Mapa funcional del producto

## A. Fundamentos de activos

- jerarquía funcional FLH;
- taxonomía;
- ADR / relaciones;
- activo 360;
- contexto operacional;
- criticidad.

**Madurez conceptual:** media-alta.

## B. Ingeniería de mantenimiento y fiabilidad

- biblioteca AMEF reusable;
- revisiones/versionado;
- aplicabilidad multi-activo;
- AMEF contextual;
- RCM;
- economía;
- estrategia/tarea;
- revisión de efectividad.

**Madurez conceptual:** alta y dominio principal del Functional Lab actual.

## C. Gestión del trabajo

- Job Plan / Route;
- preventive maintenance plan;
- work candidates;
- planificación/programación;
- work orders;
- ejecución;
- cierre técnico;
- resultados.

**Madurez conceptual:** parcial; se valida el handoff desde estrategia antes de ampliar el dominio.

## D. Gestión económica y empresarial

- costes reales;
- materiales/servicios;
- reporting;
- KPIs;
- integraciones;
- roles/seguridad.

**Madurez conceptual:** temprana/parcial.

---

# 3. Foundation funcional

## FL-0 — Modelo conceptual y Functional Journey

**Estado:** consolidado.

- visión/límites;
- Functional Journey FL-01…FL-28;
- persona vs sistema;
- fixture P-101;
- arquitectura conceptual;
- contratos/schemas;
- auditoría D-01…D-14;
- biblioteca AMEF separada de aplicación/contexto;
- criticidad separada del riesgo AMEF;
- tarea/JobPlan/PM/WO/resultado separados.

---

# 4. Roadmap de construcción Power Apps

La construcción sigue obligatoriamente:

`30-playbooks/power-platform/modular-power-apps-screen-construction.md`

```text
skeleton
→ placeholders
→ S/C/I
→ Studio validation
→ freeze
→ siguiente bloque
```

## FL-1 — Recovery / Design Foundation

**Estado:** en curso.

Objetivos:

```text
resolver grafo de identidades
crear scr_DesignSystemLab
validar tokens/color/estados
revalidar componentes reutilizables actuales en aislamiento
preservar piezas ya aprobadas
```

Gate:

```text
DesignSystemLab geometry frozen
COLOR FOUNDATION APPROVED
componentes requeridos READY_FOR_INTEGRATION
sin modificación incidental de foundation congelada
```

## FL-2 — Foundation funcional revalidada

Revalidar sin reconstruir:

```text
Home
FLH
Taxonomía
ADR
Criticidad
Asset 360
Biblioteca AMEF
Revisión AMEF
Aplicación multi-activo
```

Gate:

```text
0 errores estructurales bloqueantes
P-101 estable
Tree RC3 validado
Applicability RC2 validado
criticidad separada de AMEF
```

## FL-3 — AnalysisCase foundation

Construir/consolidar incrementalmente:

```text
Analysis Register
Case Overview
Contexto
Funciones
Modos de fallo
```

Cada pantalla nueva/abierta usa skeleton first y freeze.

## FL-4 — AMEF

`scr_FL_AMEF` está `IN_CONSTRUCTION`.

Secuencia:

```text
S-AMEF-01 skeleton
→ geometry freeze
C-AMEF-* placeholders
→ I-AMEF-* integrations
→ FUNCTIONAL_FROZEN
→ Theme pass
→ FINAL_FROZEN
```

Fixture protegido:

```text
S4 / O3 / D3
S×O12
NPR36
```

## FL-5 — RCM y economía

- RCM versionable;
- sistema/recomendación/decisión humana;
- economía preliminar;
- reglas corporativas aún abiertas identificadas como tales.

## FL-6 — Tarea ejecutable y paquete de plan

Validar:

```text
ProposedMaintenanceTask
TaskProfileVariant
MaintenanceTask
MaintenanceProcedure opcional
resources / crew / H-H
operating/shutdown/isolation/permit
PlanScopeItem
agrupación manteniendo identidad por tag
```

## FL-7 — Trazabilidad / revisión / aprobación

- Biblioteca → Aplicación → AnalysisCase → Tarea → Plan;
- evidencia;
- revisión/aprobación;
- snapshot;
- autoridad humana.

## FL-8 — Handoff / efectividad

- JobPlan/Route;
- PM;
- WO;
- ExecutionResult;
- coste real;
- efectividad;
- cambio de aplicación o nueva revisión de biblioteca.

## FL-9 — Consolidación para IT

- requisitos funcionales;
- reglas de negocio;
- modelo conceptual de datos;
- mapa de pantallas;
- roles/autoridades;
- dependencias;
- preguntas de arquitectura/integración.

## FL-10 — Siguiente dominio

Solo después de cerrar suficientemente el circuito AMEF/RCM → ejecución → efectividad se seleccionará el siguiente dominio del CMMS para llevar al laboratorio.

---

# 5. Regla de avance

No se considera progreso “tener más YAML”.

Se considera progreso:

```text
bloque validado
+ estado congelado
+ no regresión de bloques anteriores
+ evidencia en Studio
+ documentación actualizada
```
