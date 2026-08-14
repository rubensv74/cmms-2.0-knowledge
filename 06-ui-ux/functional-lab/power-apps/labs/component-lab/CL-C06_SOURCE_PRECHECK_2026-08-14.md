# CL-C06 — LineagePanelPro — Source precheck

**Fecha:** 2026-08-14  
**Componente:** `cmp_FL_LineagePanelPro` RC3  
**Estado:** `SOURCE PRECHECK PASS / STUDIO PENDING`

## Alcance

Se revisaron la fuente canónica RC3 y el harness `CL-C06_LineagePanelPro_isolated_validation.pa.yaml` contra:

- playbook modular de construcción Power Apps;
- `development/compatibility.md`;
- reglas PaYaml observadas en DS-C04 y CL-C01;
- contrato visual Comfortable.

## Resultado

- Identidad del componente preservada; actualización in situ únicamente.
- `GroupContainer@1.5.0`, `ModernText@1.0.0` y `Classic/Button@2.2.0` son versiones ya utilizadas en el Functional Lab.
- `ModernText` estático usa `AutoHeight=true`.
- No hay `AccessibleLabel` en Classic Button.
- No hay Gallery, SVG ni controles anidados de riesgo conocido.
- Fórmulas multilínea y textos con secuencias YAML sensibles se expresan mediante `|-` cuando corresponde.
- No se reduce tipografía para resolver densidad.
- El harness no modifica la definición RC3.

## Riesgo deliberadamente abierto

`LINEAGE-R01`: el hint inferior del componente usa `Wrap=false` y las cuatro etapas también contienen valores `Wrap=false`. No se corrige preventivamente.

CL-C06 debe probar dos escenarios:

1. **Normal 900:** valores representativos y ancho nominal.
2. **Stress 700:** códigos y handoff largos sobre un host restringido.

Si en Stress 700 aparece clipping, desaparición de información o invasión entre etapas, el resultado será `CL-C06 FAIL_VISUAL_QA` y se abrirá `CL-C06-FIX-01` limitado al overflow. No se reducirá tipografía.

## Gate

`SOURCE_VALID → COMPONENT_DEFINITION_ACCEPTED → INSTANCE_SAFE → VISUAL_QA_VALIDATED → READY_FOR_INTEGRATION`
