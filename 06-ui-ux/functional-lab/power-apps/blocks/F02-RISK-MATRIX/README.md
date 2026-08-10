# F02 — Risk Matrix Premium

**Objetivo:** incorporar la matriz visual de riesgo a FL-09 antes de iniciar los smoke tests integrados de arquitectura v2.

## Archivos canónicos

1. `../../components/cmp_FL_RiskMatrixPro.pa.yaml`
2. `../../screens/scr_FL_AMEF.pa.yaml`

## Orden

1. Crear o sustituir `cmp_FL_RiskMatrixPro` con el Source Code completo.
2. Guardar la definición del componente.
3. Sustituir el Source Code completo de `scr_FL_AMEF` por la versión canónica actual.
4. Abrir Home una vez si el runtime v2 todavía no está inicializado.
5. Abrir AMEF y realizar una sola validación integrada.

## Validación única

Con el caso P-101:

- la matriz 10×10 debe cargar;
- S=8 y O=4 deben identificar la celda actual del caso inicial;
- D=3 debe mostrarse aparte;
- NPR inicial esperado del fixture: 96;
- seleccionar otra celda debe actualizar S y O y recalcular NPR;
- editar D debe recalcular NPR sin mover la posición S×O;
- la banda visual de matriz debe mantenerse separada del NPR;
- consecuencia recomendada y decisión humana deben seguir diferenciadas;
- el gate debe seguir explicando el estado y permitir continuar a RCM cuando la revisión esté completa.

## Criterio de aceptación

Responder únicamente:

```text
RISK MATRIX OK
```

si la carga, interacción, cálculo y composición visual son correctos.

Si aparece un error de Studio, enviar el mensaje completo y/o captura. Se corregirá la clase completa del error antes de continuar.

## Nota metodológica

Los umbrales 20 / 40 / 70 son configuración demostrativa. No se consideran regla corporativa validada.
