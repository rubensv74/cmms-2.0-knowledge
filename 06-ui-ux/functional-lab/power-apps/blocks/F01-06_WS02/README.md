# F01-06 — WS-02 Funciones y fallos

Estado: `READY FOR STUDIO VALIDATION`

Este incremento se entrega mediante archivos YAML remotos. El chat no necesita reproducir el código.

## Orden de aplicación

1. `01_HEADER_REVIEW_PROPERTIES.pa.yaml`
   - Target: `cmpFL_Header > Properties`.
   - Sustituir las propiedades completas `ReviewHint` y `ReviewState`.

2. `02_WS02_CONTAINER.pa.yaml`
   - Target: `conFL_Workspace > Children`.
   - Insertar el hijo completo `conFL_WS02` después de `conFL_WS01` y antes de `conFL_WorkspacePending`.

3. `03_PENDING_VISIBILITY.pa.yaml`
   - Target: `conFL_WorkspacePending > Properties`.
   - Sustituir la propiedad completa `Visible`.

## Validación única

No realizar micropruebas entre archivos. Aplicar los tres bloques y después ejecutar un único recorrido:

1. completar WS-01;
2. entrar en `Funciones y fallos`;
3. comprobar funciones y fallos cargados;
4. seleccionar `FM-03` y verificar que el gate permite continuar;
5. seleccionar otro modo y comprobar que el gate exige motivo;
6. introducir el motivo;
7. pulsar `Continuar a efectos y riesgo`;
8. comprobar navegación a `Risk` y estabilidad de Studio.

Resultado esperado: `WS-02 OK`.

## Regla funcional clave

`FM-03` es una recomendación del sistema. La decisión sigue siendo humana. Si se selecciona otro modo, la salida conserva recomendación, decisión final y motivo del override.

## Archivos

- `01_HEADER_REVIEW_PROPERTIES.pa.yaml`
- `02_WS02_CONTAINER.pa.yaml`
- `03_PENDING_VISIBILITY.pa.yaml`

Especificación funcional relacionada: `../../../development/screens/functional-lab/WS02_FUNCTIONS_FAILURES.md`.
