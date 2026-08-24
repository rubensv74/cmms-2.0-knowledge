# CMMS 2.0 — ASSETS Functional Baseline V1

**Fecha:** 2026-08-24  
**Screen ID:** `AS-01`  
**Nombre de producto:** `Assets`  
**Arquetipo:** `Data Explorer`  
**Estado:** `ACCEPTED / READY_FOR_INCREMENTAL_BUILD`

## 1. Propósito

`Assets` es la superficie principal para localizar activos mantenibles dentro del contexto activo del proyecto y abrir el registro correcto.

No es una ficha técnica, una pantalla de mantenimiento ni un dashboard.

Su trabajo principal es:

```text
scope
→ search / filter
→ identify correct asset
→ open Asset Detail
```

La pantalla debe reducir ambigüedad entre activos similares y permitir exploración rápida con densidad controlada.

## 2. Usuario

Usuarios objetivo:

- Maintenance Planner;
- Maintenance Responsible;
- Supervisor;
- Reliability / Maintenance Engineer;
- Asset Master / Configuration roles cuando necesiten localizar un activo;
- otros perfiles con permiso de lectura del Asset Master.

La pantalla no asume permisos de edición por defecto.

## 3. Entradas

### Contexto mínimo

```text
SelectedProject / active project context
User permission context
Assets screen state
Optional incoming search/filter context
```

### Contratos funcionales reutilizados

```text
AssetCode
Description
EquipmentTypeCode
EquipmentTypeLabel
LocationCode / LocationLabel
CriticalityCode / CriticalityLabel
LifecycleStatus
ManufacturerName optional
ModelName optional
```

### No entradas V1

No se requiere para cargar la pantalla:

- Asset seleccionado previamente;
- AMEF/RCM;
- Work Order activa;
- mantenimiento histórico;
- BIM/CAD;
- Technical Profile completo.

## 4. Salidas

### Salida primaria

```text
Open Asset Detail
```

Debe transmitir inequívocamente la identidad del Asset seleccionado.

### Salidas secundarias

```text
Change filters
Change search
Change sort
Reset filters
Create Asset (solo cuando exista permiso y contrato de escritura)
```

### Diferidas

```text
Export current view
Bulk actions
Create Work Order
Mass edit
Engineering sync actions
```

No se implementan hasta existir necesidad y contrato explícitos.

## 5. Estados

Modelo mínimo:

```text
INITIAL
LOADING
READY
EMPTY
ERROR
UNAVAILABLE_SOURCE
```

Estados de acciones futuras:

```text
PROCESSING
SUCCESS
```

solo cuando se introduzcan operaciones que los necesiten.

### Reglas

- `EMPTY` significa lectura correcta sin registros para el scope/filtro actual;
- `ERROR` significa fallo de lectura y nunca debe parecer una lista vacía válida;
- `UNAVAILABLE_SOURCE` significa que la fuente requerida no está disponible/configurada;
- `READY` requiere una colección/read model válido, incluso si algunos campos opcionales son `UNAVAILABLE`;
- no representar Manufacturer/Model ausente como dato vacío ambiguo; usar `—` cuando esas columnas se muestren.

## 6. Trabajo principal del usuario

```text
PRIMARY_USER_TASK
Find the asset I need and understand enough context to open the correct record.
```

## 7. Criterio de éxito

```text
SUCCESS_CRITERION
The user can identify an asset by identity, type, location or filters and open the correct Asset Detail without interpreting ambiguous data.
```

## 8. Límites funcionales V1

`Assets` no debe:

- duplicar Asset Detail;
- mostrar Technical Profile completo en la tabla;
- cargar ilustraciones 3D grandes por fila;
- ejecutar mantenimiento desde cada fila;
- mezclar administración de Equipment Types con exploración de Assets;
- ocultar errores de fuente detrás de una tabla vacía;
- introducir KPIs sin read model gobernado.

## 9. Dependencias

### Ya disponibles en app real

```text
cmp_CMMS_SidebarPro_RC0
cmp_CMMS_ProjectContextPro_RC0
cmp_CMMS_PageHeaderPro_RC0
cmp_CMMS_StatePanelPro_RC0
gblTheme
gblLayout
gblSidebarCollapsed
gblSelectedNavKey
gblShellReady
```

### Necesidades posteriores

```text
FilterBar/Data Explorer filtering pattern
DataGrid/list pattern
Asset list read adapter
Asset Detail navigation contract
Equipment Type icon mapping
```

Cada necesidad debe pasar por su incremento; no se crea toda la infraestructura en el Shell.

## 10. Gate funcional

`ASSETS_FUNCTIONAL_BASELINE_V1 = PASS`

No existe decisión funcional pendiente que impida construir el Shell.
