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
- `docs/`: documentación para público general, coherencia y guía de reunión.
- `package.ps1` y `package.sh`: generación reproducible del ZIP.

## Verificación de la distribución

El checksum de cada ZIP se publica fuera del paquete en `releases/SHA256SUMS.txt`. De esta forma el archivo puede reproducirse sin introducir una referencia circular a su propio hash.

## Estado

Versión conceptual integrada 2.0. Los datos, costes, escalas, estados, reglas, roles y umbrales son ejemplos de validación funcional. No constituyen un AMEF–RCM aprobado ni una instrucción operativa.