# AMEF–RCM Experience Center

Versión guiada del modelo funcional AMEF–RCM para CMMS 2.0.

## Ejecución

Descomprimir el ZIP y abrir `index.html`. No requiere servidor, instalación ni dependencias externas.

## Punto de entrada

La versión 3.0 comienza directamente con el caso realista de la bomba **P-101**. El usuario recorre 28 etapas y confirma las acciones y decisiones necesarias para avanzar desde el contexto operacional hasta la mejora continua.

El mapa maestro sigue disponible como referencia conceptual y los cinco prototipos se conservan como módulos de detalle.

## Capacidades del recorrido

- caso P-101 precargado y editable;
- progresión secuencial mediante gates;
- explicación de requisitos pendientes;
- registro acumulado de decisiones;
- salida explícita de cada etapa;
- modo presentación para reuniones;
- persistencia local;
- exportación JSON;
- funcionamiento offline.

## Estructura

- `index.html`: recorrido guiado principal.
- `mapa-maestro/`: arquitectura conceptual de 17 etapas.
- `prototipos/01-*` a `05-*`: módulos funcionales de detalle.
- `docs/RECORRIDO_GUIADO_P101.md`: explicación del enfoque.
- `docs/`: documentación para público general y reunión.
- `package.ps1` y `package.sh`: generación del ZIP reproducible.

## Estado

Versión conceptual guiada 3.0. Los datos y decisiones del caso son realistas, pero no constituyen un AMEF–RCM aprobado ni una instrucción operativa.
