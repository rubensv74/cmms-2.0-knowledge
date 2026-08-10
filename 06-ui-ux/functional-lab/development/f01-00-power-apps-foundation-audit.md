# F01-00 — Auditoría Power Apps Foundation

**Fecha:** 2026-08-10  
**Estado:** parcialmente completada — requiere validación en la app real antes de YAML

## 1. Objetivo

Cumplir el gate técnico previo al primer bloque Source Code del CMMS 2.0 Functional Lab.

## 2. Fuentes técnicas revisadas

Se han utilizado como referencia del método y del dialecto Power Apps ya probado:

- `rubensv74/app_pulse/docs/development/PROTOCOLO_IMPLEMENTACION_INCREMENTAL_ASISTIDA.md`
- `rubensv74/app_pulse/docs/development/PROTOCOLO_CONSTRUCCION_MODULAR_PANTALLAS_POWER_APPS.md`
- `rubensv74/app_pulse/docs/development/screens/punch-review/POWER_APPS_SOURCE_CODE_COMPATIBILITY.md`
- `rubensv74/app_pulse/docs/development/screens/home-pds/blocks/01_screen_shell.pa.yaml`

## 3. Conclusiones transferibles confirmadas

### 3.1. Construcción por bloques

La pantalla debe construirse por piezas y validarse en Studio antes de avanzar.

### 3.2. El repositorio no demuestra que un CanvasComponent esté instalado

Una definición disponible en GitHub no garantiza que la app activa conozca ese componente.

Por tanto, el primer shell del Functional Lab no dependerá de componentes premium.

### 3.3. No asumir propiedades por similitud

Las incompatibilidades registradas en Pulse obligan a confirmar control y versión antes de reutilizar propiedades.

### 3.4. El Runtime Adapter debe ser independiente

La carga del fixture P-101 se implementará después del shell y del runtime state, no embebida dentro del layout.

### 3.5. Datos de prueba separados

El fixture JSON canónico permanece en `cases/P101/`. Cualquier Power Fx generado para cargarlo será un adaptador, no otra fuente de verdad.

## 4. Arquitectura técnica inicial del primer screen

Nombre propuesto:

```text
scr_FunctionalLab
```

Árbol inicial mínimo:

```text
scr_FunctionalLab
└── conFL_Root
    ├── conFL_Navigation
    └── conFL_Content
        ├── conFL_Header
        └── conFL_WorkspaceHost
```

El Bloque 01 solo debe demostrar que la pantalla y el layout base son aceptados por Studio.

No incluirá:

- fixture P-101;
- ParseJSON;
- navegación funcional completa;
- componentes premium;
- cálculos;
- gates;
- flows;
- SQL;
- persistencia.

## 5. Secuencia técnica aprobada para F01

| Bloque | Responsabilidad | Dependencia |
|---|---|---|
| 01 | shell mínimo | app base creada |
| 02 | runtime state tipado | bloque 01 validado |
| 03 | adaptador P-101 | bloque 02 validado |
| 04 | navegación base | bloque 03 validado |
| 05 | WS-01 contexto visual | bloque 04 validado |
| 06 | WS-01 edición | bloque 05 validado |
| 07 | WS-01 gate | bloque 06 validado |
| 08 | WS-01 output | bloque 07 validado |
| 09 | hardening y documentación | bloque 08 validado |

## 6. Información que NO puede confirmarse todavía

Sin la app real abierta en Power Apps Studio no se puede confirmar de forma honesta:

- schema Source Code aceptado por esa app;
- versión efectiva de los controles que Studio insertará/aceptará;
- variables de tema existentes;
- componentes instalados;
- App Checker baseline;
- comportamiento al pegar el primer bloque.

## 7. Requisito mínimo para desbloquear Bloque 01

Debe existir una Canvas app vacía o baseline destinada al laboratorio, preferiblemente denominada:

```text
CMMS 2.0 Functional Lab
```

Una vez creada, el primer bloque se diseñará para esa app y se validará en Power Apps Studio antes de preparar Bloque 02.

## 8. Componentes de Pulse

Los componentes premium de Pulse podrán evaluarse de forma incremental, pero no se importarán todos por defecto.

Criterio:

- reutilizar cuando reduzca riesgo y mantenga coherencia;
- no añadir una dependencia solo por estética;
- registrar incorporación y validación del componente antes de instanciarlo.

## 9. Gate F01-00

```text
Static audit: PASSED
Architecture: PASSED
Compatibility register: CREATED
Real Power Apps baseline: PENDING
Studio validation: PENDING
F01-01 YAML: BLOCKED until real app baseline exists
```

## 10. Próxima acción exacta

Crear/identificar la Canvas app del Functional Lab y utilizarla como entorno real de validación. Después se podrá redactar el Bloque 01 `screen shell` sin asumir componentes ni contratos no confirmados.
