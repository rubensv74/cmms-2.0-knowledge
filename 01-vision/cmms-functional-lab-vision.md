# CMMS 2.0 Functional Lab — Visión

**Última revisión:** 2026-08-14  
**Fuente de revisión:** [`../05-meetings/2026/2026-08-14_revision-modelo-conceptual-amef-rcm.md`](../05-meetings/2026/2026-08-14_revision-modelo-conceptual-amef-rcm.md)

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
- qué pantallas necesita realmente el producto;
- qué reglas deben ser configurables por cliente/proyecto y cuáles son corporativas;
- cómo se reutiliza un plan genérico sin perder las excepciones de cada activo;
- dónde termina un proceso validado y comienza otro todavía pendiente de definición.

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

A medida que se estudie la extensión operacional posterior al plan, deberán incorporarse perfiles adicionales como Planning/Scheduling y Contratos/Subcontratos.

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
10. pantallas o workspaces necesarios;
11. configuraciones por proyecto/cliente;
12. fronteras entre módulos o procesos.

## 5. Caso de referencia inicial

El primer caso canónico será P-101, bomba centrífuga de agua de refrigeración, ya utilizado en AMEF–RCM Experience Center.

Se conservará la coherencia del caso existente y se transformará a fixtures JSON versionados.

Los valores son ilustrativos y no constituyen una instrucción de mantenimiento aprobada.

El caso P-101 debe demostrar que una configuración utilizada en la demo —por ejemplo una matriz 5×5— es solo un **perfil de ejemplo**, no una limitación del futuro producto.

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

### 6.4. Configurable no significa ambiguo

El sistema debe adaptarse a perfiles de riesgo, escalas y criterios del cliente/proyecto sin hardcodear una única filosofía de criticidad.

Toda configuración debe ser versionada, trazable y visible para que un cálculo pueda reproducirse.

### 6.5. RCM se representa como lógica, no como puntuación

El Functional Lab debe mostrar el recorrido por el árbol de decisión RCM, incluyendo respuestas, evidencia, criterios de factibilidad técnica y efectividad.

No debe inventarse un score acumulado para decidir la política de mantenimiento.

### 6.6. Taxonomía y autoridad humana deben separarse

La taxonomía puede ayudar a identificar activos equivalentes y sugerir dónde podría reutilizarse un plan. La decisión de aplicabilidad corresponde al especialista.

El modelo debe permitir un plan genérico y excepciones específicas por activo sin contaminar el plan común.

### 6.7. El laboratorio no define la arquitectura productiva

Power Apps es el vehículo elegido para validar la experiencia funcional. SQL, Dataverse, APIs, flows, integración y persistencia productiva quedan sujetos a decisiones posteriores.

### 6.8. La documentación nace del recorrido

Cada workspace validado debe producir o actualizar documentación funcional estructurada para IT.

### 6.9. La trazabilidad es parte del modelo

Una decisión debe poder reconstruirse desde su contexto, datos y reglas hasta su resultado.

### 6.10. No simular certeza donde todavía hay una frontera abierta

Cuando el laboratorio llegue a un proceso todavía no estudiado, debe mostrar el output y la frontera, no inventar reglas para completar artificialmente el flujo.

## 7. Frontera de la primera versión

La primera versión se centrará en Ingeniería de Fiabilidad y AMEF–RCM porque es el dominio actualmente más maduro.

Debe permitir validar el recorrido desde:

```text
Activo y contexto
→ funciones
→ fallos funcionales
→ modos y efectos
→ riesgo configurable
→ árbol de decisión RCM
→ tratamiento
→ recursos
→ aplicabilidad / plan genérico y variantes por activo
→ revisión y publicación
→ handoff operacional simulado
→ aprendizaje
```

### 7.1. Handoff operacional que sí debe mostrarse

Después de publicar un plan, el laboratorio debe poder explicar conceptualmente:

```text
Plan publicado vigente
→ seleccionar ejercicio / contexto presupuestario
→ acción explícita: preparar/generar órdenes preventivas del año
```

Este handoff se incorpora porque fue validado en la reunión del 2026-08-14.

### 7.2. Procesos que no se implementarán todavía

No se implementarán inicialmente:

- órdenes de trabajo reales;
- planificación y programación productiva;
- asignación real de técnicos;
- ejecución en campo;
- imputación real de costes;
- relación definitiva con contratos/subcontratos y facturación;
- integración con SAP, Maximo o Hexagon;
- persistencia corporativa definitiva;
- autenticación o permisos finales;
- optimización avanzada;
- automatizaciones consideradas todavía hipótesis.

La demo puede señalar estas etapas como extensión del modelo objetivo, pero debe etiquetarlas como `to_validate`.

## 8. Métrica de éxito

El éxito no se medirá por número de pantallas ni por acabado visual.

Se medirá por la capacidad del grupo para llegar a decisiones concretas y detectar:

- requisitos faltantes;
- reglas ambiguas;
- responsabilidades mal asignadas;
- automatismos incorrectos;
- pantallas innecesarias;
- información que debe heredarse de otros módulos;
- puntos que deben quedar abiertos para IT;
- configuraciones que no deben hardcodearse;
- fronteras funcionales que requieren incorporar nuevos perfiles de negocio.
