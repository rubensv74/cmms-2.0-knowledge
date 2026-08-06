# AMEF–RCM Experience Center

Paquete integrado de demostración funcional para CMMS 2.0 destinado a mantener la coherencia entre las reuniones semanales, la propuesta funcional y los prototipos HTML.

## Ejecución

Descomprimir el ZIP y abrir `index.html`. No requiere servidor, instalación ni dependencias externas.

## Contenido

- `index.html`: entrada única.
- `mapa-maestro/`: 17 etapas del recorrido completo.
- `prototipos/01-*`: comprender el activo y sus fallos.
- `prototipos/02-*`: evaluar y priorizar el riesgo.
- `prototipos/03-*`: tomar una decisión RCM explicable.
- `prototipos/04-*`: convertir la decisión en tareas y plan.
- `prototipos/05-*`: gobernar, aprobar, versionar y mejorar.
- `assets/`: recursos compartidos de las guías prácticas.
- `docs/`: documentación para público general, coherencia y guía de reunión.
- `package.ps1` y `package.sh`: generación reproducible del ZIP.

## Guías del flujo de negocio

Cada prototipo incorpora un icono `ⓘ` que abre una guía práctica centrada en el proceso de negocio. La guía no explica controles ni botones: presenta la pregunta de negocio, el flujo lógico, los roles, las decisiones, el resultado esperado, los errores habituales y un ejemplo aplicado a la bomba P-101.

La definición editorial se encuentra en `docs/GUIAS_FLUJO_NEGOCIO.md`.

## Verificación de la distribución

El checksum de cada ZIP se publica fuera del paquete en `releases/SHA256SUMS.txt`. De esta forma el archivo puede reproducirse sin introducir una referencia circular a su propio hash.

## Estado

Versión conceptual integrada 2.1. Los datos, costes, escalas, estados, reglas, roles y umbrales son ejemplos de validación funcional. No constituyen un AMEF–RCM aprobado ni una instrucción operativa.
