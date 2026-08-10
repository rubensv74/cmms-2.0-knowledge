# CMMS 2.0 Functional Lab — Design System v2

**Estado:** canónico para arquitectura v2  
**Fecha:** 2026-08-10

## 1. Objetivo

Hacer que el Functional Lab se perciba como una aplicación CMMS empresarial real y premium, no como un navegador de prototipos ni como una presentación paso a paso.

La interfaz debe comunicar simultáneamente:

1. dónde está el usuario dentro del producto;
2. qué objeto o caso está trabajando;
3. dónde está dentro de las 28 etapas metodológicas;
4. qué dato viene del maestro;
5. qué calcula o recomienda el sistema;
6. qué necesita una decisión humana;
7. qué gate permite o bloquea la progresión formal.

## 2. Dos capas de navegación

### 2.1 Navegación global — Sidebar

El Sidebar representa módulos de producto:

```text
Inicio
Activos
Estrategia de mantenimiento
Planes de mantenimiento
Gobernanza
Configuración
```

No debe enumerar las 28 etapas.

### 2.2 Navegación del AnalysisCase — Process Rail

Dentro de un caso, `cmp_FL_ProcessRailPro` representa FL-01…FL-28.

Su función es:

- mostrar progreso;
- permitir consulta experta;
- identificar etapa actual;
- mostrar responsabilidad dominante;
- hacer visible estado confirmado/draft/warning/blocked;
- navegar a la pantalla de negocio correspondiente.

No ejecuta las reglas del workflow; el host mantiene autoridad sobre gates y navegación formal.

## 3. Pantallas por trabajo real

Una pantalla existe cuando un usuario CMMS reconocería un trabajo u objeto distinto.

Ejemplos:

```text
Árbol FLH
Taxonomía
Árbol ADR
Ficha 360
Registro de análisis
Caso de análisis
Funciones
Modos de fallo
AMEF
Decisión RCM
Evaluación económica
Tarea
Paquete de plan
Trazabilidad
Aprobación
Efectividad
```

No se fusionan etapas solo para reducir el número de pantallas.

Tampoco se crea automáticamente una pantalla por stageId.

## 4. Gramática visual de responsabilidad

### Master / referencia

```text
Slate / neutral
#0F172A
#334155
#64748B
#F8FAFC
#E2E8F0
```

Uso:

- datos maestros;
- referencias externas;
- metadatos;
- información de solo lectura.

### Sistema / cálculo / recomendación

```text
Blue / cyan
#0284C7
#0369A1
#075985
#F0F9FF
#BAE6FD
```

Uso:

- cálculo;
- clasificación automática;
- recomendación;
- explicación de regla;
- navegación activa.

### Persona / autoridad

```text
Purple
#7C3AED
#6D28D9
#FAF5FF
#E9D5FF
```

Uso:

- decisión humana;
- rol con autoridad;
- confirmación;
- revisión multidisciplinar.

### Warning / excepción / override

```text
Amber / orange
#F59E0B
#B45309
#EA580C
#C2410C
#FFFBEB
#FFF7ED
#FDE68A
#FED7AA
```

Uso:

- finding;
- override;
- excepción;
- incertidumbre que permite continuar;
- acción pendiente no bloqueante.

### Error / bloqueo

```text
Red
#EF4444
#B91C1C
#FEF2F2
#FECACA
```

Uso:

- gate bloqueado;
- error;
- condición incompatible con avance formal.

### Confirmado / aprobado

```text
Green
#22C55E
#15803D
#166534
#F0FDF4
#BBF7D0
```

Uso:

- evidencia confirmada;
- gate pasado;
- aprobación;
- resultado estable.

## 5. Tipografía

Base actual: `Segoe UI` / controles modernos equivalentes.

La escala por defecto es **Cómoda**.

Valores de referencia:

```text
Eyebrow / meta         8–9
Supporting             9–10
Body                   10–11
Section title          14–17
Page title             22–24
KPI                     20–24
```

Evitar cuerpo inferior a 9 salvo metadatos secundarios.

## 6. Escala visual futura

El host será responsable de una preferencia global:

```text
Normal       100%
Cómoda       115%
Grande       130%
```

No crear zoom independiente dentro de cada componente.

Cuando se implemente, escalar conjuntamente:

- texto;
- padding;
- altura de controles;
- separación;
- iconos;
- targets interactivos.

## 7. Layout responsive

Objetivo completo:

```text
Desktop
Tablet landscape
Tablet portrait cuando el contenido lo permita
```

Móvil completo queda fuera de v2.

Principios:

- Sidebar colapsable;
- contenido principal usa `Parent.Width` y proporciones;
- paneles de dos columnas deben poder convertirse posteriormente a flujo vertical;
- evitar coordenadas que dependan del ancho exacto 1200 salvo componentes canónicos ya probados;
- no diseñar información crítica solo para hover.

## 8. Page Header

`cmp_FL_PageHeaderPro` identifica:

- pantalla / archetype;
- objeto o case code;
- journey position cuando aplica;
- review state;
- progreso.

En pantallas de `AnalysisCase` puede mostrar journey.

En pantallas de Activos no debe fingir una etapa del journey si el usuario está fuera del análisis.

## 9. TreePro

`cmp_FL_TreePro` es foundation para:

- FLH;
- Taxonomía;
- ADR.

Principios:

- profundidad variable;
- modelo plano padre-hijo;
- icono semántico mediante `RowIconKey`;
- P-101 resaltado sin perder selección;
- breadcrumb;
- search;
- expand/collapse;
- compresión de indentación en profundidad;
- descripción detallada preferentemente en panel derecho.

No usar 11 galerías anidadas para 11 niveles.

## 10. Process Rail

El rail debe mostrar de forma compacta:

```text
estado
grupo/fase
stageId
etapa
responsabilidad dominante
```

Código visual de responsabilidad actual:

```text
H  human
R  recommendation
C  calculation
G  gate
```

Estos códigos son compactos; el contexto de pantalla debe explicar su significado cuando sea necesario.

## 11. Decision Panel

`cmp_FL_DecisionPanelPro` debe evitar que una recomendación parezca una decisión.

Estructura conceptual:

```text
SISTEMA
- resultado
- recomendación
- explicación

DECISIÓN HUMANA
- valor
- motivo
- autoridad
- override cuando existe
```

Nunca ocultar la recomendación original después de un override.

## 12. Gate Panel

`cmp_FL_GatePanelPro` sustituye el patrón pobre de simplemente deshabilitar `Siguiente`.

Todo gate visible debe expresar:

```text
estado
resumen
motivo
acción necesaria
responsable
output que se producirá
acción de continuar
```

## 13. Borrador vs confirmación

Interacción ordinaria:

```text
editar
→ draft
```

Decisión con autoridad:

```text
review
→ Confirmar / Aprobar
→ decisión trazable
```

No obligar a guardar manualmente cada edición del formulario.

## 14. Master data

En pantallas de análisis, master data se representa como:

```text
DATO MAESTRO · SOLO LECTURA
```

El análisis puede consumirlo y referenciarlo.

No debe permitir editar:

- código de activo;
- nombre maestro;
- jerarquía FLH;
- taxonomía;
- relaciones ADR maestras.

Una corrección del maestro pertenece a otro proceso.

## 15. Localization-ready

Idioma actual visible: español.

Keys internas independientes del idioma:

```text
Home
Assets
Strategy
Plans
Governance
Settings
Context
Functions
AMEF
RCM
...
```

La v2 contiene un catálogo ES/EN inicial.

No activar selector bilingüe hasta que **todos** los textos visibles hayan sido migrados a keys. Una interfaz mitad ES / mitad EN no cumple el estándar.

## 16. Honestidad del prototipo

Todo módulo aún conceptual debe decirlo claramente.

Ejemplos:

- Planes: no fingir PM/JobPlan/WO real;
- Gobernanza: no fingir persistencia de auditoría remota;
- Settings: no fingir seguridad productiva;
- Azure SQL: no fingir que ya es el backend.

El objetivo premium no justifica simular capacidades inexistentes.

## 17. Criterio premium

Premium significa:

- jerarquía clara;
- densidad controlada;
- consistencia;
- acciones previsibles;
- responsabilidad visible;
- estados explicables;
- componente reusable;
- responsive;
- accesibilidad;
- ausencia de ruido visual;
- acabado comparable a SaaS empresarial moderno.

No significa añadir sombras, colores o controles por decoración.
