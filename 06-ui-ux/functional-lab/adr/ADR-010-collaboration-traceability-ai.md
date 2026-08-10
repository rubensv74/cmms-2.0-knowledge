# ADR-010 — Colaboración multirrol, trazabilidad e IA como recomendación

**Estado:** Aprobado  
**Fecha:** 2026-08-10

## Decisión

El `AnalysisCase` se diseña para participación de varios roles, aunque el laboratorio pueda simular identidad y concurrencia.

Toda decisión relevante conserva rol, evidencia y timestamp. `SystemRecommendation` es una abstracción de origen: puede proceder de regla, analítica, motor experto o IA.

La IA no recibe autoridad implícita para aprobar decisiones.

## Roles iniciales

- Ingeniería de Fiabilidad;
- Mantenimiento / Planificación;
- Operaciones;
- Asset Owner / Aprobador;
- Administrador.

## Consecuencias

- Las pantallas muestran autoridad requerida cuando aplique.
- Review y Approval son objetos persistentes, no simples flags visuales.
- Un futuro motor de IA puede incorporarse sin cambiar el contrato de decisión humana.
- La trazabilidad debe reconstruir inputs, recomendación, decisión, actor y versión.
