# Decisión funcional — Escala AMEF de P-101

**Fecha:** 2026-08-10  
**Estado:** vigente para CMMS 2.0 Functional Lab  
**Ámbito:** caso P-101 / FL-09

## Decisión

El Functional Lab utiliza para P-101 la escala AMEF ya empleada en los prototipos revisados:

```text
Severidad     1..5
Ocurrencia    1..5
Detección     1..5
Matriz S×O    5×5 = 25 celdas
NPR           S×O×D
```

Valores de referencia del caso:

```text
S=4
O=3
D=3
S×O=12
NPR=36
```

## Evidencia de continuidad

El prototipo HTML `06-ui-ux/html-prototypes/amef-rcm-experience-center/prototipos/02-evaluar-riesgo/index.html` utilizaba expresamente:

- Severidad 4/5;
- Ocurrencia 3/5;
- Detectabilidad 3/5;
- NPR 36;
- Riesgo S×O 12.

La configuración 10×10 introducida temporalmente durante la construcción de `cmp_FL_RiskMatrixPro` no procedía de un requisito validado de las reuniones ni del prototipo anterior y queda retirada como configuración del caso P-101.

## Regla arquitectónica

Esta decisión **no limita** `cmp_FL_RiskMatrixPro` a 5×5.

El componente permanece configurable mediante `RowScale`, `ColumnScale` y `MatrixCells`, por lo que podrá representar posteriormente una escala corporativa diferente sin reconstrucción.

## Umbrales de banda

Las bandas de color actuales del laboratorio son únicamente demostrativas:

```text
Bajo       S×O <= 5
Moderado   S×O <= 10
Alto       S×O <= 15
Crítico    S×O > 15
```

Estos umbrales **no se consideran aprobados** por la organización. Deben validarse funcionalmente antes de trasladarse a una especificación productiva.

## Implicaciones de desarrollo

`scr_FL_AMEF` debe:

- renderizar 25 celdas;
- limitar S/O/D a 1..5;
- iniciar P-101 en S=4, O=3 y D=3;
- mostrar S×O=12 y NPR=36;
- recalcular NPR cuando cambie S, O o D;
- mantener D fuera de la posición de la matriz;
- diferenciar claramente valoración humana, score de matriz y cálculo automático del NPR.
