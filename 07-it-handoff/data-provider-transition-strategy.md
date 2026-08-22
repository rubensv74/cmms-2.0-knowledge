# CMMS 2.0 — Data Provider Transition Strategy

**Estado:** active guidance  
**Fecha:** 2026-08-22  
**Rama:** `baseline/premium-powerapps-v1`

## Objetivo

Permitir que el prototipo Power Apps empiece con datos sintéticos sin acoplar las pantallas al origen físico de los datos.

## Patrón obligatorio

```text
Screen / Component
→ Functional State / View Model
→ Data Contract
→ Provider
```

Fases previstas:

```text
v1 Mock Collections
→ v2 SQL + Power Automate
→ v3 service layer when justified
```

La UI debe conservar el mismo significado funcional aunque cambie el Provider.

## Contratos antes que tablas

Cada vertical funcional debe definir primero el contrato lógico que necesita la interfaz.

Ejemplo:

```text
AssetContext
- assetId
- assetCode
- assetName
- plant
- unit
- service
- boundary
- operatingModes
- redundancy
- constraints
- evidenceStatus
```

El futuro modelo SQL puede estar normalizado y reconstruir este contrato mediante vistas, stored procedures u otra capa de servicio.

## DDL incremental

El DDL se elaborará únicamente cuando el dominio tenga suficiente madurez funcional.

Orden:

```text
journey validado
→ contrato estable
→ modelo conceptual
→ DDL candidato
→ validación técnica
```

Conviene preparar pronto modelos candidatos para:

- activos y contexto;
- funciones;
- fallos funcionales;
- modos de fallo;
- perfiles de riesgo;
- decisiones y trazabilidad;
- plan base;
- aplicabilidad;
- overrides;
- publicación y versionado.

No se congelarán todavía esquemas definitivos para planning/scheduling, Work Orders, routing organizativo, costes, contratos o facturación mientras permanezcan en discovery o `to_validate`.

## IDs estables desde el prototipo

Los datos sintéticos deben usar identificadores estables.

No usar como clave:

- posición de galería;
- índice temporal;
- texto visible;
- número de fila circunstancial.

Ejemplos:

```text
assetId
functionId
failureModeId
analysisCaseId
configurationId
versionId
```

## Read models

Cada workspace puede consumir una proyección específica.

Durante el prototipo:

```text
colView_CaseContext
colView_FunctionFailure
colView_RiskAssessment
colView_RCMDecision
colView_Applicability
colView_Traceability
colView_PublicationReview
```

Después estas mismas proyecciones lógicas podrán provenir de SQL o de una capa intermedia.

Una `colView_*` nunca será fuente de verdad.

## Write operations

Las escrituras deben expresarse como acciones funcionales, no como dependencia directa de una tabla.

Ejemplos:

```text
UpdateCaseContext
ConfirmEvidence
RecordHumanDecision
ApplyAssetOverride
PublishPlanVersion
```

En la primera versión pueden modificar estado local. Más adelante podrán ejecutarse mediante SQL, Flow o una capa de servicio sin cambiar la intención de la interfaz.

## Matriz obligatoria antes de SQL

Antes de conectar una vertical a SQL debe existir:

```text
Collection field
↔ Contract field
↔ SQL candidate field
↔ Read/Write responsibility
```

## Secuencia de migración

1. congelar el contrato de una vertical ya aprobada;
2. diseñar DDL candidato;
3. construir la proyección SQL que reproduce el contrato;
4. sustituir la lectura mock;
5. añadir escrituras reales de forma controlada;
6. comprobar que el mismo escenario produce comportamiento funcional equivalente.

## Power Automate

Puede utilizarse para orquestación, notificaciones, aprobaciones e integración, y como puente temporal hacia operaciones SQL.

No debe convertirse por defecto en el único lugar donde vive toda la lógica del dominio.

## Capa de servicio futura

Se evaluará cuando exista una necesidad real: operaciones compartidas por varios clientes, transacciones complejas, integraciones, reglas de dominio centralizadas, requisitos de seguridad o volumen que justifiquen separar la lógica de Power Platform.

No se implementará por anticipación solo para cumplir una arquitectura teórica.

## Regla antiacoplamiento

Evitar como patrón dominante:

```text
Screen
→ query SQL específica
→ control
```

y también:

```text
Screen
→ Flow específico
→ respuesta con forma exclusiva de esa pantalla
```

La pantalla debe depender del contrato, no del mecanismo concreto que lo suministra.

## Definition of Ready para SQL

Una vertical estará preparada para persistencia real cuando tenga:

- journey funcional validado;
- contrato documentado;
- dataset sintético estable;
- IDs estables;
- operaciones read/write identificadas;
- reglas relevantes fuera de controles;
- estados de error definidos;
- necesidades de concurrencia e idempotencia evaluadas;
- matriz Collection ↔ Contract ↔ SQL preparada.
