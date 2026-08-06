# Validación del paquete AMEF–RCM Experience Center

Fecha: 06/08/2026  
Versión validada: 2.0.0-conceptual

## Alcance validado

- `index.html` único de entrada.
- Mapa maestro y cinco prototipos conectados.
- Documentación explicativa para público general.
- Funcionamiento sin librerías ni servicios externos.
- Empaquetado reproducible para Windows y Linux.

## Pruebas realizadas

- Renderizado de los siete HTML principales mediante Chromium.
- Cero errores JavaScript durante la carga y navegación secuencial.
- Prototipos 1 y 2: seis etapas disponibles.
- Prototipos 3, 4 y 5: siete etapas disponibles.
- Prototipo 3: selección de modo, árbol RCM, escenarios P–F, robustez, persistencia y exportación.
- Prototipo 4: decisiones RCM, recálculo económico, edición estable de tareas, intervalos, recursos, alcance y gate.
- Prototipo 5: selección de expediente, trazabilidad, ocho reglas de calidad, discrepancias, aprobaciones, versiones y cuatro señales reales.
- Revisión de 24 referencias relativas internas; ninguna ruta inexistente.
- Comprobación de que el ZIP contiene `index.html` en su raíz.
- Exclusión de archivos auxiliares `index.repo.html` y de la carpeta de releases del paquete distribuible.

## Paquete validado

- Archivo: `AMEF_RCM_Experience_Center_v2.0.zip`
- Archivos incluidos: 26
- Entrada después de descomprimir: `index.html`
- SHA256: `5d552c8236a99c9ce7df9ee34fb3a858a77c9148c11281d04d31c89145b4c6ce`

## Resultado

El paquete es apto para una demostración funcional offline. Las pruebas verifican la aplicación HTML, su navegación y su coherencia estructural. No validan como configuración corporativa definitiva las decisiones de mantenimiento utilizadas en el ejemplo.

## Limitaciones funcionales

Siguen pendientes de validación corporativa:

- escalas AMEF y reglas de sobreclasificación;
- árbol RCM y evidencia mínima;
- criterios económicos y fuentes de coste;
- reglas de intervalos;
- catálogos de disciplinas y puestos;
- workflow de aprobación, firmas y permisos;
- códigos ISO 14224 y mapeos de exportación;
- umbrales de mejora continua.