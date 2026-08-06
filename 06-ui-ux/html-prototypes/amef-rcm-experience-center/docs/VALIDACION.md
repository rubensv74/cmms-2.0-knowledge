# Validación del AMEF–RCM Experience Center

Fecha: 06/08/2026  
Versión: 3.0.0-guided

## Alcance

- `index.html` único de entrada.
- Recorrido guiado P-101 con 28 etapas operativas.
- Cinco bloques funcionales enlazados con sus prototipos de detalle.
- Progresión por gates, modo presentación, registro de decisiones, persistencia y exportación.
- Funcionamiento offline sin dependencias externas.

## Pruebas

- Renderizado del punto de entrada mediante Chromium.
- Navegación secuencial y desbloqueo de etapas.
- Navegación libre en modo presentación.
- Edición de campos, selecciones, rangos y listas.
- Cálculo dinámico de NPR, riesgo, viabilidad P–F, economía e intervalo.
- Mensajes de gate cuando faltan requisitos.
- Registro de decisiones y actualización del progreso.
- Persistencia local y exportación JSON.
- Enlaces al mapa maestro y cinco prototipos.
- Apertura y cierre del modal de enfoque.

## Resultado

La versión es apta para demostración funcional y pedagógica. El caso mantiene un hilo continuo desde el activo P-101 hasta una solicitud de cambio basada en datos reales.

## Limitaciones

No se validan como configuración corporativa definitiva las escalas, costes, frecuencias, roles, autoridades, umbrales ni decisiones de mantenimiento del ejemplo.
