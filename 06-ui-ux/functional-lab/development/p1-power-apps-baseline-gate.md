# P1 — Power Apps Baseline Gate

**Estado:** ready / blocked only by real Canvas App  
**Fecha:** 2026-08-22  
**Rama:** `baseline/premium-powerapps-v1`

## 1. Propósito

Cerrar la única incertidumbre que no puede resolverse desde el repositorio: cómo se comporta la Canvas App real que será utilizada como CMMS 2.0 Functional Lab.

Hasta completar este gate no se deben generar bloques Power Apps complejos ni asumir versiones de controles o componentes.

## 2. Aplicación objetivo

Nombre recomendado:

```text
CMMS 2.0 Functional Lab
```

Tipo:

```text
Canvas App
```

Uso inicial:

```text
Desktop / meeting-oriented Functional Lab
```

## 3. Evidencias que deben capturarse

### P1.1 — App identity

Registrar:

```text
App name
Environment
Owner
Solution, si aplica
App ID
Version
```

No es necesario introducir arquitectura productiva de ALM en este punto.

### P1.2 — Canvas configuration

Registrar:

```text
Width / height or responsive configuration
Scale to fit
Lock aspect ratio
Orientation
Modern controls setting
Experimental/preview settings relevantes
```

### P1.3 — Source Code / YAML baseline

Insertar un control o contenedor mínimo desde Studio y obtener el Source Code real aceptado por esa app.

Objetivo:

- confirmar schema;
- confirmar nombres de propiedades;
- confirmar versiones de controles;
- disponer de un specimen real para los siguientes bloques.

No se copiará a ciegas YAML procedente de Pulse u otra app.

### P1.4 — Component inventory

Registrar qué componentes están realmente disponibles en la app.

Candidatos prioritarios a comprobar:

```text
cmp_PageHeaderPro
cmp_SidebarNav
cmp_ActionToolbarPro
cmp_EmptyState
cmp_SkeletonLoader
cmp_StatusBadge / equivalente
```

La ausencia de un componente no bloquea la estrategia premium; solo determina si debe incorporarse o crearse.

### P1.5 — Control inventory

Comprobar al menos:

```text
containers
labels/text
buttons
icons
modern controls relevantes
classic controls requeridos
components
```

### P1.6 — Theme baseline

Registrar:

- theme activo;
- variables existentes;
- tipografía disponible;
- colores heredados de la app si existen;
- cualquier dependencia visual ya presente.

### P1.7 — App Checker baseline

Antes de añadir el shell:

```text
Errors
Warnings
Accessibility findings
Performance findings
Formula findings
```

El objetivo es poder distinguir deuda previa de problemas introducidos por CMMS.

### P1.8 — Visual specimen

Crear una pantalla mínima vacía y capturar:

- resolución real;
- comportamiento de contenedores;
- clipping;
- scroll;
- comportamiento de sidebar candidato;
- renderizado de fuentes y controles.

## 4. Prueba mínima requerida

La app debe aceptar y renderizar correctamente un bloque estructural equivalente a:

```text
Screen
└── Root horizontal container
    ├── Sidebar placeholder
    └── Main vertical container
        ├── Header placeholder
        └── Workspace placeholder
```

No debe contener todavía datos de P-101 ni reglas funcionales.

## 5. Resultado documental

Al completar P1 deben actualizarse:

```text
06-ui-ux/functional-lab/development/compatibility.md
06-ui-ux/functional-lab/development/f01-00-power-apps-foundation-audit.md
06-ui-ux/functional-lab/implementation-status.md
```

Y debe conservarse un specimen Source Code mínimo validado.

Ruta recomendada:

```text
06-ui-ux/functional-lab/development/specimens/
```

## 6. Gate de salida P1

```text
[ ] Canvas App real creada/identificada
[ ] configuración de canvas registrada
[ ] Source Code specimen obtenido desde esa app
[ ] dialecto/schema confirmado
[ ] control inventory registrado
[ ] component inventory registrado
[ ] theme baseline registrado
[ ] App Checker baseline registrado
[ ] prueba estructural mínima renderizada correctamente
[ ] comportamiento visual básico revisado
```

Solo después:

```text
P1 PASSED
→ P2 Premium App Shell Foundation
```

## 7. Qué NO debemos hacer antes

- diseñar nueve pantallas en YAML;
- asumir componentes instalados;
- importar fórmulas complejas;
- conectar SQL;
- crear flows;
- introducir matriz de riesgo;
- implementar RCM;
- copiar sin validar propiedades de otra Canvas App.

## 8. Información que debe devolver la validación

Al cerrar el gate debe existir una respuesta clara a estas preguntas:

1. ¿Qué estructura Source Code acepta realmente esta app?
2. ¿Qué controles debemos utilizar para el shell?
3. ¿Qué componentes premium podemos reutilizar ya?
4. ¿Qué componentes faltan?
5. ¿Cuál es la resolución/layout real de referencia?
6. ¿Qué deuda reporta App Checker antes de empezar?
7. ¿Hay alguna incompatibilidad que obligue a modificar `premium-shell-specification-v1.md`?

Con esas respuestas se puede redactar P2 sin especulación.
