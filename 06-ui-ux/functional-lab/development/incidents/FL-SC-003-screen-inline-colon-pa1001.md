# FL-SC-003 — Pantallas no importables por literal `: ` en scalar Power Fx inline

**Fecha:** 2026-08-11  
**Estado:** corregido en Source Code / retest Studio pendiente

## Efecto confirmado

Las pantallas siguientes no podían importarse en Power Apps Studio:

- `scr_FL_ADR`
- `scr_FL_Effectiveness`
- `scr_FL_FmeaRevision`

## Causa identificada

Las tres contenían fórmulas Power Fx escritas como scalar YAML inline cuyo literal de texto incluía la secuencia `: `.

Esta clase de error ya estaba documentada como `PA1001 / YamlInvalidSyntax / invalid mapping`.

Ocurrencias corregidas:

```text
scr_FL_ADR
"...padre-hijo físicas: accionamiento..."

scr_FL_Effectiveness
"...análisis aprobado: generan evidencia..."

scr_FL_FmeaRevision
"Causas: " & ...
"Cubre: " & ...
```

## Corrección

Todas las fórmulas afectadas se han convertido a bloque YAML `|-` sin cambiar la fórmula Power Fx ni la lógica funcional.

Patrón:

```yaml
Text: |-
  ="Causas: " & ...
```

## Dependencias

Además:

- `scr_FL_ADR` consume `cmp_FL_TreePro`;
- `scr_FL_Effectiveness` consume `cmp_FL_ProcessRailPro` y `cmp_FL_GatePanelPro`.

Por tanto, esos componentes deben existir en Studio antes de importar las pantallas consumidoras. Esto es independiente del PA1001 corregido.

## Retest único

1. asegurar que los componentes canónicos requeridos ya están instalados;
2. importar `scr_FL_ADR`;
3. importar `scr_FL_Effectiveness`;
4. importar `scr_FL_FmeaRevision`;
5. guardar y revisar App Checker.

Si alguna sigue fallando, conservar el mensaje exacto de Studio para atacar el delta restante.

## Regla preventiva

Antes de publicar cualquier `.pa.yaml`, buscar fórmulas inline que contengan un literal con `: ` y convertir toda esa clase a bloque `|-`.