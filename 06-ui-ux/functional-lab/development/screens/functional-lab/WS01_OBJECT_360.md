# WS-01 — Caso y contexto / Objeto 360

**Estado:** candidato F01-05 para validación en Power Apps Studio  
**Caso:** P-101  
**Idioma visible:** Español  
**Densidad:** Comfortable

## Responsabilidad funcional

WS-01 agrupa las etapas canónicas:

- `FL-01` Definir el activo y sus límites.
- `FL-02` Describir el contexto operacional.
- `FL-03` Comprobar la preparación de datos.

El workspace no decide la estrategia de mantenimiento. Su salida es el contexto confirmado que consumirá WS-02.

## Patrón de experiencia

Arquetipo: **Objeto 360**.

```text
Información existente
→ revisión/edición humana
→ evidencia disponible
→ confirmación humana
→ gate explicable
→ output estructurado
```

## Datos existentes mostrados

- código y nombre del activo;
- unidad;
- caudal y presión de servicio;
- redundancia;
- fuentes de evidencia;
- nivel de confianza.

## Inputs humanos editables v1

- servicio requerido;
- límite físico del análisis;
- restricciones operativas.

La edición actualiza el estado local y marca el caso como `Dirty`.

## Confirmación de evidencia

El revisor funcional debe confirmar explícitamente que la evidencia disponible es suficiente. El sistema no sustituye esta decisión humana.

## Gate conceptual v1

El candidato considera preparado WS-01 cuando:

1. existe servicio requerido;
2. existe límite físico;
3. existen restricciones operativas;
4. hay al menos tres fuentes de evidencia;
5. el revisor ha confirmado la evidencia.

Esta regla es una hipótesis funcional del laboratorio y debe validarse en las sesiones de revisión antes de convertirse en requisito productivo.

## Output

Al continuar se construye `colFL_WS01Output` con:

- CaseId;
- AssetCode;
- AssetName;
- Plant;
- Service;
- Boundary;
- DutyFlowM3h;
- DutyPressureBar;
- Redundancy;
- Constraints;
- DataConfidence;
- EvidenceCount;
- EvidenceConfirmed;
- StageStatus;
- ConfirmedAt.

El botón de avance cambia `varFL_ActiveKey` a `Functions`, preparando la entrada de WS-02.

## Referencias técnicas reutilizadas

- `GroupContainer@1.5.0`;
- `ModernText@1.0.0`;
- `Gallery@2.15.0`;
- `Classic/Button@2.2.0`;
- `Classic/TextInput@2.3.2`, contrastado con PULSE PunchReview.

No se ha creado un nuevo CanvasComponent para el workspace. La primera vertical slice permanece en la pantalla host hasta validar su responsabilidad y geometría; la extracción a componente se justificará solo si aparece reutilización real.

## Validación Studio

```text
[ ] YAML aceptado
[ ] pantalla estable
[ ] campos editables
[ ] Dirty state cambia
[ ] evidencia visible
[ ] confirmación humana funciona
[ ] gate cambia de estado
[ ] motivo del gate es explícito
[ ] Continue genera colFL_WS01Output
[ ] navegación pasa a Functions
[ ] save/reopen estable
```
