# Fuentes para NotebookLM — AMEF–RCM Experience Center

## Objetivo

Esta carpeta contiene las fuentes maestras para generar un Resumen de vídeo de NotebookLM que explique fielmente el estado actual del análisis funcional AMEF–RCM de CMMS 2.0.

NotebookLM debe recibir documentos estructurados y no únicamente el ZIP navegable. El Experience Center sigue siendo la evidencia funcional principal, pero su contenido se acompaña con un dossier que explica el contexto, los acuerdos alcanzados, las propuestas conceptuales y las decisiones corporativas todavía pendientes.

## Fuentes recomendadas

1. `CONTEXTO_ESTADO_Y_DECISIONES.md`
   - Fuente principal del relato.
   - Explica dónde estamos, qué existe y qué falta validar.

2. `../RECORRIDO_GUIADO_P101.md`
   - Describe las 28 etapas del caso P-101.

3. `PROMPT_PERSONALIZACION_VIDEO.md`
   - Instrucciones para personalizar el Resumen de vídeo.

4. Experience Center v3.0
   - Demostración navegable offline desde `index.html`.
   - Debe transformarse en PDF o capturas para utilizarlo como fuente visual de NotebookLM, ya que el ZIP se conserva como artefacto de distribución y revisión humana.

## Regla de fidelidad

El vídeo debe distinguir siempre tres niveles:

- **Validado conceptualmente:** principios y orden lógico aceptados en las reuniones.
- **Propuesta funcional:** mecanismos incluidos en los prototipos para facilitar la discusión.
- **Pendiente de decisión:** configuraciones, reglas, roles, umbrales e integraciones todavía no aprobadas.

## Mensaje principal

El plan de mantenimiento no es el punto de partida. Es el resultado de una cadena de razonamiento que comienza con las funciones del activo, evalúa sus modos de fallo, selecciona una política mediante RCM y conserva trazabilidad, aprobación y capacidad de revisión con datos reales.

## Paquete distribuible

Los PDF, imágenes y el ZIP preparado para cargar o consultar se generan fuera del repositorio a partir de estas fuentes maestras. El repositorio mantiene como fuente primaria los documentos editables y el Experience Center.