# ADR-003 — Pantallas por objeto o proceso de negocio

**Estado:** Aprobado  
**Fecha:** 2026-08-10

## Contexto

Agrupar etapas para reducir el número de pantallas degradó la autenticidad de la aplicación y mezcló trabajos de usuario distintos.

## Decisión

El número de pantallas no es una métrica de optimización. Una pantalla existe cuando representa un objeto o trabajo coherente y reconocible.

Se permite que una pantalla cubra varias etapas cuando comparten objeto y tarea; también se divide una agrupación anterior cuando contiene responsabilidades o decisiones diferentes.

Separaciones explícitas:

- Funciones/fallos funcionales ≠ selección de modos de fallo.
- Economía ≠ diseño de tarea/intervalo.
- Trazabilidad/calidad ≠ revisión/aprobación.

## Consecuencias

- El mapa inicial contiene más pantallas que la hipótesis de nueve workspaces.
- Las pantallas pueden crecer o dividirse por evidencia de uso, no por estética.
- Los antiguos `WS-*` se conservan como evidencia histórica, no como arquitectura definitiva de UI.
