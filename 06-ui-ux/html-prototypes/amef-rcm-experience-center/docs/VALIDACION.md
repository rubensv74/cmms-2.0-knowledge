# Validación del paquete AMEF–RCM Experience Center

Fecha: 06/08/2026

## Comprobaciones realizadas

- Presencia del `index.html` único de entrada.
- Resolución de enlaces internos entre inicio, mapa maestro y cinco prototipos.
- Renderizado de los siete HTML principales sin errores JavaScript durante la prueba.
- Navegación secuencial de seis etapas en cada prototipo.
- Comprobación de interacciones del escenario P–F en el Prototipo 3.
- Revisión de diseño adaptable para escritorio y anchuras reducidas.
- Generación del ZIP de distribución y comprobación de su estructura.

## Paquete validado para la reunión

- Archivo: `AMEF_RCM_Experience_Center_v1.0.zip`
- Entrada después de descomprimir: `index.html`
- SHA256 de la entrega validada: `239ed437a1637f67131b748916ef25b09ad214fe17896bc5f05c9318aefd38f8`

## Limitación del entorno de prueba

La política del navegador de validación bloqueó la navegación directa mediante `file://` y el acceso a un servidor local. Se validaron el contenido HTML y JavaScript en navegador, la interacción de las vistas y la integridad estática de todas las rutas relativas. El paquete permanece diseñado para ejecución local sin servidor.

## Alcance

Esta validación comprueba el funcionamiento de la demostración. No valida las escalas de riesgo, costes, frecuencias, roles o decisiones técnicas como configuración corporativa definitiva.
