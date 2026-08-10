# Functional Lab — Implementation Status

**Fecha:** 2026-08-10  
**Estado general:** F01 — Power Apps Functional Foundation + primera vertical slice  
**Último gate superado:** `F01-02/03 Runtime P-101` — VALIDATED PASS  
**Gate actual:** `F01-05 WS-01 Caso y contexto / Objeto 360` — READY FOR STUDIO VALIDATION

## 1. Estado de incrementos

| Incremento | Estado | Resultado |
|---|---|---|
| F00-01..F00-09 | completed | Base funcional, journey, fixture, arquitectura y handoff definidos. |
| F01-00 Auditoría Power Apps Foundation | completed | Compatibilidad contrastada con referencias reales PULSE. |
| F01-00A cmp_FL_SidebarPro | validated-pass | RC2 completo con CustomProperties y contrato HeatMap-style es instance-safe. |
| F01-00B cmp_FL_PageHeaderPro | validated-pass | Instance-safe, composición sin solapamiento, escala Comfortable y español validados. |
| F01-01 Premium App Shell Foundation | validated-pass | Sidebar + Header integrados; navegación activa; colapsado; host responsive; interfaz española. |
| F01-02 Runtime state mínimo | validated-pass | Estado local del caso, carga, edición y bootstrap estables en Studio. |
| F01-03 Adaptador P-101 | validated-pass | Fixture canónico P-101 proyectado a variables/colecciones Power Fx y representado correctamente. |
| F01-04 Navegación funcional | active | Shell conserva navegación completa; gates empezarán a gobernar el avance del recorrido. |
| F01-05 WS-01 Caso y contexto | ready-for-studio-validation | Objeto 360: datos existentes, edición humana, evidencia, gate explicable y output WS-02. |

## 2. Resultado F01-02/03

Validación comunicada por el usuario:

```text
RUNTIME P-101 OK
Pantalla abre                         PASS
P-101 cargado                         PASS
120 m³/h / 6 bar                      PASS
P-102 reserva automática              PASS
5 fuentes de evidencia                PASS
2 funciones                           PASS
2 fallos funcionales                  PASS
4 modos de fallo                      PASS
foco FM-03                            PASS
Sidebar / navegación / colapsado      PASS
Studio estable                        PASS
```

El error previo `PA1001 invalid mapping` quedó resuelto convirtiendo a bloque YAML `|-` las fórmulas inline cuyo literal contenía `: `.

## 3. Baseline vigente

```text
Idioma visible           Español (es-ES)
Densidad base            Comfortable
Caso demostración        P-101
Fuente canónica           JSON versionado
Adaptador laboratorio     Power Fx generado desde fixture
Estado runtime            separado del fixture
Shell                     Sidebar + Header + Workspace Host
Persistencia productiva  no decidida
```

## 4. Gate actual — WS-01

WS-01 agrupa:

```text
FL-01 Definir activo y límites
FL-02 Describir contexto operacional
FL-03 Comprobar preparación de datos
```

Responsabilidad del candidato:

```text
información existente
→ revisión/edición humana
→ evidencia y confianza
→ confirmación humana
→ gate explicable
→ output estructurado colFL_WS01Output
→ habilitar WS-02 Funciones y fallos
```

Regla conceptual del gate en esta iteración:

- servicio informado;
- límite físico informado;
- restricciones operativas informadas;
- al menos tres fuentes de evidencia;
- evidencia confirmada por el revisor funcional.

Esta regla se valida funcionalmente en el laboratorio y no debe interpretarse todavía como regla productiva definitiva.

## 5. Validación esperada WS-01

```text
[ ] pantalla abre sin errores
[ ] campos existentes visibles
[ ] Service / Boundary / Constraints editables
[ ] edición marca estado Dirty
[ ] evidencia P-101 visible
[ ] Confirmar evidencia cambia el gate
[ ] gate explica qué falta
[ ] botón Continuar se habilita al superar el gate
[ ] Continuar genera colFL_WS01Output
[ ] ActiveKey cambia a Functions
[ ] Shell permanece estable
```
