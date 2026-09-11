# ANL-004 — Revisión funcional posterior a reunión 2026-09-11

**Fecha:** 2026-09-11  
**Estado:** análisis funcional aplicado  
**Fuente:** [`../2026/2026-09-11_revision-cmms-estandares-job-plans.md`](../2026/2026-09-11_revision-cmms-estandares-job-plans.md)

## 1. Objetivo

Traducir los comentarios de la reunión en cambios controlados del modelo de CMMS 2.0 y de CMMS Functional Lab, diferenciando:

- decisiones suficientemente confirmadas;
- hipótesis que deben seguir `to_validate`;
- impactos de arquitectura funcional;
- cambios de demo que conviene preparar sin inventar datos.

## 2. Hallazgo principal

El modelo anterior tenía una tendencia implícita a presentar el journey AMEF + RCM como vía principal para llegar a un plan de mantenimiento.

La reunión demuestra que el producto necesita un modelo superior:

```text
Maintenance Engineering
├── Route A — RCM specific engineering
└── Route B — Corporate maintenance standard adoption
```

Ambas rutas convergen en un `ProjectMaintenancePlanVersion` publicable y trazable.

Este cambio evita dos errores:

1. obligar a ejecutar RCM donde no aporta valor;
2. obligar a reconstruir en cada proyecto conocimiento de mantenimiento que ya existe corporativamente o en OEM/vendor documentation.

## 3. Impacto sobre el Functional Journey

### 3.1. El journey actual sigue siendo válido

Las 28 etapas actuales continúan siendo útiles como **RCM Engineering Route** y no deben eliminarse.

### 3.2. Corrección de alcance

El documento `functional-journey.md` debe dejar explícito que no representa el único camino de creación de planes.

La nueva ruta estándar converge funcionalmente en el tramo de tarea/plan:

```text
Corporate Standard / OEM / Existing Plan
→ applicability + tailoring
→ reusable task / Job Plan / procedure
→ resources + frequency
→ Project Plan
→ governance/publication
```

### 3.3. FL-18..FL-22

Estas etapas deben poder consumir dos tipos de origen:

```text
RCM_DERIVED
STANDARD_DERIVED
```

Y conservar `sourceBasis` / provenance.

## 4. Impacto sobre AMEF y RCM

### Confirmado

- AMEF forma parte del proceso RCM.
- El intervalo P–F pertenece al razonamiento sobre el modo de fallo y a la selección/intervalo de tareas basadas en condición.
- La `F` representa fallo funcional, no necesariamente rotura física.
- Time-based, condition-based y run-to-failure son estrategias/políticas que pueden coexistir dentro de un mismo equipo.

### Consecuencia documental

La UI de WS-04 no debe presentar AMEF como un producto totalmente independiente que luego “pasa” a RCM. Debe mostrar que funciones, fallos, modos y efectos son parte del análisis que alimenta la decisión RCM.

## 5. Granularidad de actividad

### Confirmado

El CMMS no debe modelar cada paso detallado del procedimiento como una actividad que requiera cierre independiente.

Debe distinguir:

```text
Maintenance Activity
└── Job Plan / Procedure / Checklist
    ├── detailed step
    ├── detailed step
    └── detailed step
```

### Por qué importa

Si cada paso se convierte en actividad CMMS:

- aumenta artificialmente el número de tareas;
- se obliga a registrar avance innecesario;
- se deteriora la experiencia del técnico;
- planning/scheduling trabaja con unidades demasiado pequeñas;
- el historial deja de ser legible.

## 6. Job Plan y procedimiento

La reunión confirma una separación funcional pero no cierra la taxonomía definitiva.

### Suficientemente confirmado

`JobPlan` es reutilizable y debe reunir o referenciar la información necesaria para preparar la ejecución:

- actividad;
- operaciones/procedimiento;
- recursos;
- herramientas/equipos;
- materiales;
- condiciones de seguridad;
- estimaciones.

### Sigue abierto

No está cerrado si el procedimiento/checklist:

- vive dentro de Job Plan;
- es un objeto independiente referenciado por Job Plan;
- o admite ambas modalidades.

Por tanto, el modelo debe conservar desacoplamiento entre `JobPlan` y `ProcedureChecklist` hasta MSL-G02.

## 7. Roles

La conversación distingue:

```text
Planner       → qué tareas deben ejecutarse
Programmer    → cómo, con quién y con qué recursos
```

Pero la terminología no se considera todavía corporativa.

No debe hardcodearse en roles/seguridad hasta validar vocabulario y responsabilidades con los procesos reales.

## 8. Biblioteca corporativa

Este es el cambio funcional de mayor valor.

### Confirmado

Debe existir un maestro corporativo reutilizable por tipo de equipo.

```text
Corporate Library
→ Project Snapshot
→ Project Tailoring
→ Published Project Plan
```

### Confirmado

El proyecto debe poder:

- desactivar;
- modificar;
- añadir;
- justificar.

### Confirmado

Los cambios locales no vuelven automáticamente al maestro.

### A definir

```text
Project Learning
→ Corporate Change Proposal
→ Review / Approval
→ New Master Version
```

## 9. Relación con Asset Master / Equipment Type

La biblioteca debe resolverse prioritariamente por `EquipmentTypeCode` y, cuando aplique, por variante técnica/contexto.

Esto conecta directamente con el Asset Experience Contract existente:

```text
Asset
→ EquipmentTypeCode
→ candidate maintenance standards
```

El sistema puede sugerir; el especialista confirma applicability.

## 10. Relación con Work Management

La reunión avanza parcialmente WM-G02.

Ahora existe evidencia de que una WO debe trabajar con una actividad resumida y disponer del Job Plan/checklist como soporte de ejecución.

Por tanto:

```text
WorkCandidate != checklist step
WorkOrder task != every procedure step
```

Los pasos del checklist pueden capturar resultados/evidencia cuando sea necesario, pero no deben crear por defecto órdenes o actividades planificables independientes.

**WM-G02 no se considera PASS** porque todavía falta revisar/normalizar directamente las fuentes documentales y cerrar el contrato de ejecución.

## 11. Impacto sobre CMMS Functional Lab

### 11.1. P-101 se mantiene

P-101 debe seguir representando la ruta RCM completa.

No debe simplificarse para representar el nuevo camino estándar.

### 11.2. Segundo tipo de caso

El laboratorio necesita más adelante un caso diferente:

```text
Equipment Type
→ suggested Corporate Standard
→ inspect source/version
→ adopt into project
→ deactivate / adjust / add
→ compare project vs master
→ publish project plan
```

No se crea todavía un fixture inventado. El caso debe derivarse de una fuente real normalizada de las mostradas durante la reunión.

### 11.3. Cambios necesarios en WS-05 / WS-06

Cuando se implementen, deben poder mostrar:

- `sourceBasis` de la tarea/plan;
- fuente y versión;
- estándar corporativo de origen;
- project override;
- motivo;
- impacto sobre frecuencia/recursos;
- diferencia master vs project.

### 11.4. No nuevo workspace todavía

No se añade de forma automática un décimo workspace al journey P-101.

La **Maintenance Standards Library** es una capacidad de configuración/ingeniería reusable y puede terminar necesitando una superficie propia tipo `Configuration Studio`, pero eso debe decidirse en un contrato de pantalla específico.

## 12. Cambios documentales derivados

Actualizar:

- `functional-journey.md` → scope RCM + convergencia con standard route;
- `human-system-decisions.md` → decisiones de adopción/override/promoción;
- `work-management-discovery.md` → granularidad activity vs checklist;
- `functional-lab/architecture.md` → Maintenance Standards source/layer;
- `functional-lab/implementation-status.md` → nuevo gate MSL;
- `PROJECT_STATUS.md`;
- `ROADMAP.md`;
- `MASTER_INDEX.md`;
- `CHANGELOG.md`.

Crear:

- `maintenance-standards-library.md`;
- `maintenance-standards-extension.md`.

## 13. Gates nuevos

```text
MSL-G01 Source normalization
MSL-G02 Core contracts
MSL-G03 Project adoption/versioning
MSL-G04 Corporate feedback loop
```

Hasta cerrar MSL-G01 y MSL-G02 no se debe crear un dataset corporativo ficticio ni una pantalla de biblioteca que parezca productiva.

## 14. Conclusión

La reunión no invalida el trabajo RCM. Lo coloca en el lugar correcto.

El producto objetivo deja de ser:

```text
RCM → Plan
```

para pasar a ser:

```text
Maintenance Engineering Sources
├── RCM
├── Corporate Standards
├── OEM / Vendor
└── Engineering Experience
        ↓
Governed Project Maintenance Plan
        ↓
Work Management
```

Ese modelo es más reutilizable, más realista operativamente y reduce de forma sustancial el trabajo repetido entre proyectos.
