# Notas de reunión — Revisión CMMS 2.0: AMEF, RCM y mantenimiento basado en riesgo

**Fecha:** 2026-07-31  
**Participantes:** Rubén Seijo Vilaboy, Hernando Alberto Gómez de la Vega, Eduardo Goitia  
**Fuente:** transcripción de Teams archivada fuera del repositorio  
**Ámbito:** validación conceptual desde funciones/fallos hasta estrategia de mantenimiento justificada.

## Hallazgo principal

CMMS 2.0 no debe partir de tareas preventivas heredadas simplemente porque siempre se hayan realizado. El razonamiento funcional comienza por activo/contexto, función esperada, fallo, consecuencias, riesgo y respuesta de mantenimiento.

El mantenimiento se entiende como un mecanismo de mitigación del riesgo, no como un catálogo aislado de actividades.

## Criterios confirmados

1. La estrategia debe justificarse por función, fallo, consecuencia y riesgo.
2. AMEF/FMEA estructura funciones, fallos funcionales, modos, causas, efectos y consecuencias.
3. RCM utiliza ese conocimiento para seleccionar la respuesta de mantenimiento.
4. El sistema guía y conserva evidencia; la autoridad técnica humana sigue siendo necesaria.
5. Publicar una estrategia no cierra el ciclo: ejecución y resultados deben retroalimentar revisiones futuras.
6. El objetivo no es hacer más mantenimiento, sino demostrar que se realiza el mantenimiento adecuado sobre el activo adecuado por una razón conocida.

## Implicaciones para el producto

- El prototipo AMEF/RCM es una herramienta de validación funcional, no una arquitectura productiva cerrada.
- Las tareas son salida del razonamiento, no su punto de partida.
- Debe existir trazabilidad desde necesidad funcional/riesgo hasta tarea, plan, ejecución y revisión.
- Una experiencia wizard puede ayudar al usuario, pero el wizard no es el modelo de dominio.

## Evolución posterior

Las reuniones del 14/08, 21/08, 11/09 y 25/09 refinan este baseline. Cuando exista conflicto, prevalece la decisión posterior documentada y registrada en el Decision Register.