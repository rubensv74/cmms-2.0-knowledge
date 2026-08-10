# WS-02 — Funciones y fallos

**Incremento:** F01-06  
**Estado:** candidato funcional  
**Etapas:** FL-04, FL-05, FL-06  
**Entrada:** `colFL_WS01Output`  
**Salida:** `colFL_WS02Output`

## Propósito

Transformar el contexto confirmado del activo en una descripción funcional defendible y seleccionar el modo de fallo que se utilizará para continuar el análisis AMEF/RCM.

## Flujo funcional

```text
WS-01 confirmado
→ definir/revisar funciones medibles
→ definir/revisar fallos funcionales
→ mostrar modos de fallo candidatos
→ sistema conserva recomendación de modo focal
→ persona selecciona el modo a analizar
→ si contradice la recomendación, motivo obligatorio
→ gate explicable
→ colFL_WS02Output
→ WS-03 Efectos y riesgo
```

## FL-04 — Funciones

P-101 parte de dos funciones de demostración:

- principal: transferir 120 m³/h de agua de refrigeración a 6 bar durante operación normal;
- secundaria: contener el fluido sin fuga visible y transmitir potencia sin vibración perjudicial.

Ambas son revisables por la persona. La UI no debe tratar el texto del fixture como una decisión ya aprobada.

## FL-05 — Fallos funcionales

Se distinguen explícitamente:

- fallo total;
- fallo parcial.

Ambos permanecen revisables y deben quedar estructurados de forma separada.

## FL-06 — Modos relevantes

Candidatos del fixture:

- FM-01 Degradación del sello mecánico;
- FM-03 Degradación de rodamientos;
- FM-06 Fallo oculto de la bomba de reserva;
- FM-07 Obstrucción parcial en aspiración.

El fixture marca `FM-03` como modo focal. En el laboratorio esto se presenta como **recomendación del sistema**, nunca como decisión automática.

La persona debe seleccionar explícitamente un modo. Si selecciona uno distinto de FM-03, debe introducir un motivo. La salida conserva:

```text
systemRecommendedMode
humanSelectedMode
override
reason
```

La exclusión del caso también se mantiene visible:

> Rotura catastrófica del eje: tratada como consecuencia secundaria, sin evidencia de mecanismo dominante en el histórico actual.

## Gate conceptual WS-02

El gate pasa cuando:

1. existe `colFL_WS01Output`;
2. función principal informada;
3. función secundaria informada;
4. fallo total informado;
5. fallo parcial informado;
6. la persona ha seleccionado explícitamente un modo de fallo;
7. si existe override de FM-03, se ha documentado motivo.

Esta es una regla conceptual del Functional Lab, no una regla productiva definitiva.

## Output

`colFL_WS02Output` debe conservar como mínimo:

```text
CaseId
AssetCode
MainFunction
SecondaryFunction
FullFailure
PartialFailure
SystemRecommendedModeCode
SystemRecommendedModeName
HumanSelectedModeCode
HumanSelectedModeName
IsOverride
DecisionReason
ExcludedMode
StageStatus
ConfirmedAt
```

## Controles

Solo se utilizan patrones ya contrastados:

- `GroupContainer@1.5.0`;
- `ModernText@1.0.0` con `AutoHeight=true`;
- `Gallery@2.15.0`;
- `Classic/Button@2.2.0`;
- `Classic/TextInput@2.3.2`.

No se introduce un CanvasComponent nuevo para WS-02.
