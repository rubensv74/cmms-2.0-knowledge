# FL-SC-002 — TreePro / ProcessRailPro no importables en Studio

**Fecha:** 2026-08-11  
**Estado:** OPEN — corrective candidate published / Studio retest pending

## Efecto confirmado

El usuario reporta que no puede importar:

```text
cmp_FL_TreePro
cmp_FL_ProcessRailPro
```

No se dispone todavía del mensaje/código exacto de Power Apps Studio, por lo que la causa técnica no se declara confirmada.

## Comparación realizada

Se contrastaron ambos componentes contra:

```text
PULSE cmp_TreeViewPro — referencia positiva conocida
Functional Lab compatibility.md
Power Apps Source Code Compatibility Standard
POWER_APPS_UI_LESSONS_LEARNED.md
```

Inputs `Table`, Outputs `Record`, Events, Gallery y bindings de componente tienen contraejemplos positivos y no se consideran incompatibles por categoría.

## Delta sospechoso

Los dos componentes problemáticos compartían superficies `GroupContainer@1.5.0` dentro de plantillas `Gallery@2.15.0` con propiedad `OnSelect`.

Este patrón no se utiliza en la plantilla del `cmp_TreeViewPro` estable de PULSE. Dado que ambos fallan a la vez, se trata como **hipótesis de compatibilidad**, no como causa demostrada.

## Corrección aplicada

### cmp_FL_ProcessRailPro

- se eliminan superficies interactivas basadas en `GroupContainer` dentro de la Gallery;
- fila y punto de estado se renderizan mediante `Classic/Button@2.2.0`;
- se mantiene `Gallery.OnSelect` como autoridad del evento público;
- contrato público sin cambios.

### cmp_FL_TreePro

- se reconstruyen las superficies de fila e icon-chip sobre `Classic/Button@2.2.0`;
- la plantilla queda plana, sin `GroupContainer` internos;
- se conserva búsqueda, profundidad 11, breadcrumb, highlight, expansión host-driven, Outputs y Events existentes;
- se elimina `Icon.Trending` del mapping y se usa fallback `Icon.Document` para reducir un enum no contrastado;
- contrato público consumido por FLH/Taxonomía/ADR sin cambios.

## Validación estática

Los dos candidatos:

```text
YAML parser             PASS
Label@2.5.1 + Radius*   absent
Rectangle + Radius*     absent
Button + AccessibleLabel absent
GroupContainer OnSelect absent
```

Esto NO implica que Studio acepte o instancie los componentes.

## Siguiente prueba

Una única prueba integrada:

1. sustituir/importar `cmp_FL_TreePro`;
2. sustituir/importar `cmp_FL_ProcessRailPro`;
3. guardar;
4. informar `PASS` o enviar el error completo/captura si falla cualquiera.

Si ambos pasan, registrar el patrón correctivo como evidencia. Si alguno falla, reducir únicamente el delta restante respecto al componente positivo de referencia.
