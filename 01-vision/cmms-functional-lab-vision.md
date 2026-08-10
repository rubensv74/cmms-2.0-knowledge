# CMMS 2.0 Functional Lab — Visión

## 1. Propósito

CMMS 2.0 Functional Lab es una aplicación de validación funcional destinada a convertir el modelo conceptual de CMMS 2.0 en una experiencia ejecutable y discutible durante las reuniones de trabajo.

Su objetivo principal no es anticipar la solución técnica final, sino hacer visible el razonamiento del negocio paso a paso.

## 2. Problema que resuelve

Los prototipos HTML han permitido explicar conceptos, pero empiezan a ser insuficientes para responder preguntas como:

- qué información debe existir antes de cada paso;
- quién debe introducirla o validarla;
- qué puede calcular el sistema;
- qué puede recomendar automáticamente;
- qué decisión debe asumir una persona;
- qué condiciones impiden avanzar;
- qué salida queda disponible para el siguiente proceso;
- qué debe quedar trazado para auditoría;
- qué pantallas necesita realmente el producto.

El Functional Lab convierte esas preguntas en interacción.

## 3. Usuarios del laboratorio

El laboratorio está pensado para sesiones de revisión con perfiles como:

- Ingeniería de Fiabilidad;
- Mantenimiento;
- Operaciones;
- HSE;
- responsables de activos;
- analistas funcionales;
- representantes de IT cuando sea necesario revisar requisitos.

Los roles de la aplicación productiva se definirán posteriormente.

## 4. Resultado esperado

Al recorrer un caso, el grupo debe poder identificar y validar:

1. datos necesarios;
2. reglas de negocio;
3. cálculos automáticos;
4. recomendaciones del sistema;
5. decisiones humanas;
6. gates;
7. outputs;
8. responsabilidades;
9. necesidades de trazabilidad;
10. pantallas o workspaces necesarios.

## 5. Caso de referencia inicial

El primer caso canónico será P-101, bomba centrífuga de agua de refrigeración, ya utilizado en AMEF–RCM Experience Center.

Se conservará la coherencia del caso existente y se transformará a fixtures JSON versionados.

Los valores son ilustrativos y no constituyen una instrucción de mantenimiento aprobada.

## 6. Principios del producto

### 6.1. El ejemplo precede a la teoría

La persona debe comprender primero la situación concreta y después el concepto metodológico.

### 6.2. Una decisión funcional debe ser explicable

La aplicación debe mostrar por qué solicita un dato, qué regla utiliza y qué genera.

### 6.3. Sistema y persona no son intercambiables

La UI distinguirá claramente:

- información existente;
- input humano;
- cálculo;
- recomendación;
- decisión humana;
- gate;
- output.

### 6.4. El laboratorio no define la arquitectura productiva

Power Apps es el vehículo elegido para validar la experiencia funcional. SQL, Dataverse, APIs, flows, integración y persistencia productiva quedan sujetos a decisiones posteriores.

### 6.5. La documentación nace del recorrido

Cada workspace validado debe producir o actualizar documentación funcional estructurada para IT.

### 6.6. La trazabilidad es parte del modelo

Una decisión debe poder reconstruirse desde su contexto, datos y reglas hasta su resultado.

## 7. Frontera de la primera versión

La primera versión se centrará en Ingeniería de Fiabilidad y AMEF–RCM porque es el dominio actualmente más maduro.

Debe permitir validar el recorrido desde:

```text
Activo y contexto
→ funciones
→ fallos funcionales
→ modos y efectos
→ riesgo
→ decisión RCM
→ tratamiento
→ aplicabilidad / plan
→ revisión y publicación
→ aprendizaje
```

No se implementarán inicialmente:

- órdenes de trabajo reales;
- planificación productiva;
- integración con SAP, Maximo o Hexagon;
- persistencia corporativa definitiva;
- autenticación o permisos finales;
- optimización avanzada;
- automatizaciones consideradas todavía hipótesis.

## 8. Métrica de éxito

El éxito no se medirá por número de pantallas ni por acabado visual.

Se medirá por la capacidad del grupo para llegar a decisiones concretas y detectar:

- requisitos faltantes;
- reglas ambiguas;
- responsabilidades mal asignadas;
- automatismos incorrectos;
- pantallas innecesarias;
- información que debe heredarse de otros módulos;
- puntos que deben quedar abiertos para IT.
