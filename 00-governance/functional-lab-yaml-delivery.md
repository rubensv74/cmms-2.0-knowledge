# Functional Lab — Protocolo de entrega YAML remota

**Estado:** activo  
**Fecha:** 2026-08-10

## Regla de entrega

A partir de F01-06, los incrementos Power Apps se entregan con enfoque `remote-first`:

```text
analizar
→ preparar YAML completo del incremento
→ guardar en GitHub
→ entregar enlace remoto
→ aplicar todos los bloques del incremento
→ una validación funcional completa
→ documentar resultado
→ continuar
```

## Chat

Por defecto, el chat no reproducirá bloques YAML extensos.

La respuesta contendrá únicamente:

- enlace a la carpeta o archivo remoto;
- objetivo del incremento;
- orden de aplicación cuando exista más de un edit surface;
- validación única esperada;
- estado del gate.

El YAML se mostrará en el chat solo cuando el usuario lo solicite expresamente.

## Estructura por incremento

Cuando un incremento afecte varios edit surfaces se creará una carpeta:

```text
power-apps/blocks/<incremento>/
├── README.md
├── 01_....pa.yaml
├── 02_....pa.yaml
└── ...
```

Cada archivo debe contener un bloque completo para su target concreto. El `README.md` identifica el target y el orden de aplicación.

Cuando sea seguro y práctico sustituir una pantalla completa, se podrá entregar un único `.pa.yaml` full-screen en lugar de varios bloques.

## Validación

No se solicitarán micropruebas entre bloques de un mismo incremento salvo error de Studio.

Regla:

> aplicar el incremento completo → ejecutar un único recorrido discriminante → PASS o diagnóstico del error exacto.

Si aparece un error, se corrige toda la clase de problema identificada antes de solicitar una nueva validación.

## Relación con el protocolo incremental

Este documento cambia el mecanismo de entrega, no los gates técnicos ni funcionales del protocolo incremental principal.
