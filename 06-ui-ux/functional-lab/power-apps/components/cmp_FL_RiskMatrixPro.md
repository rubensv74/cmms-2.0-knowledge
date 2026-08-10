# cmp_FL_RiskMatrixPro

**Estado:** PASS_STATIC / Power Apps Studio pending  
**Ámbito:** componente premium reutilizable de criticidad AMEF.

## Propósito

Representar visualmente la relación entre **Severidad (S)** y **Ocurrencia (O)** mediante una matriz 10×10, sin confundir esta representación con el NPR.

La Detección (D) permanece separada y el host calcula el NPR como:

```text
S × O × D
```

## Principio funcional

```text
Selección humana S/O
        ↓
Matriz S×O
        ↓
Banda visual de criticidad

S/O + D
        ↓
Cálculo NPR del sistema
```

El componente no decide la criticidad corporativa ni sustituye la decisión humana.

## Contrato principal

### Inputs

- `SeverityValue`
- `OccurrenceValue`
- `DetectionValue`
- `RiskScore`
- `CriticalOverride`
- `LowMax`
- `ModerateMax`
- `HighMax`
- colores de banda y tokens visuales
- textos visibles y nota de escala

### Outputs

- `SelectedSeverityOut`
- `SelectedOccurrenceOut`
- `MatrixScoreOut`
- `MatrixBandOut`

### Event

- `OnSelectCell`

El host conserva el estado y la regla de negocio. El componente renderiza y emite la selección.

## Configuración demostrativa P-101

```text
Bajo       S×O <= 20
Moderado   S×O <= 40
Alto       S×O <= 70
Crítico    S×O > 70
```

Estos valores son únicamente datos del laboratorio. No constituyen una escala corporativa aprobada.

## Integración actual

`scr_FL_AMEF.pa.yaml` utiliza el componente en FL-09. Al seleccionar una celda:

1. el host actualiza `varFLSeverity` y `varFLOccurrence`;
2. recalcula `varFLRiskScore` con la Detección vigente;
3. marca FL-09 como draft;
4. mantiene recomendación, decisión humana y gate como conceptos independientes.

## Reutilización futura

El diseño permite que umbrales y colores procedan posteriormente de configuración persistente —por ejemplo Azure SQL— sin modificar el motor visual del componente.

## Gate de validación

Antes de promover a Component Library:

```text
[ ] DEFINITION_ACCEPTED
[ ] INSTANCE_SAFE
[ ] selección 10×10 correcta
[ ] outputs S/O correctos
[ ] recalculo NPR en host
[ ] visual QA desktop
[ ] visual QA tablet
[ ] accesibilidad y foco
```
