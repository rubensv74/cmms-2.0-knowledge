# CMMS 2.0 — AE-G6 Asset Detail S01 Studio Gate

**Fecha:** 2026-08-24  
**Gate:** `AE-G6 / AE6-S01`  
**Estado actual:** `PENDING_POWER_APPS_STUDIO`

## Objetivo

Validar en la Canvas app real que `Asset Detail / Object 360` puede construirse con el contrato AE-1, el sistema visual AE-2, los componentes AE-3 y el consumo visual AE-5 sin fabricar datos ni capacidades.

---

# 1. Preconditions

```text
[ ] Canvas app real disponible
[ ] authoring locale confirmado
[ ] Source Code format confirmado
[ ] App Checker baseline registrado
[ ] AE-G5 runtime PASS para Type Illustration o imagen desactivada explícitamente
[ ] fixture p101-asset-detail.v1.json disponible
[ ] Power Fx fixture loader revisado para locale
```

Si AE-G5 no ha pasado, puede validarse estructura parcial pero el veredicto máximo será:

```text
PASS_STRUCTURE_ONLY / VISUAL_RUNTIME_HOLD
```

---

# 2. Fixture smoke

Después de ejecutar el loader:

```text
CountRows(colAE6_HierarchyPath)       = 4
CountRows(colAE6_TechnicalValues)     = 5
CountRows(colAE6_EngineeringSources)  = 1
CountRows(colAE6_Documents)           = 3
CountRows(colAE6_Visuals)             = 1
```

Además:

```text
recAE6_Asset.AssetCode = P-101
ManufacturerName       = Blank()
ModelName              = Blank()
```

Gate:

```text
[ ] PASS
```

---

# 3. Header hierarchy

```text
[ ] N0 Navigation pertenece al shell
[ ] N1 Page Identity contiene Asset Detail + subtitle
[ ] N2 Context Strip contiene contexto del activo
[ ] no KPI incrustado en N1
[ ] no segunda identidad principal
[ ] no breadcrumb innecesario heredado de AssetPlan
```

---

# 4. Asset Identity Hero

```text
[ ] P-101 domina la identidad
[ ] descripción legible
[ ] Equipment Type visible
[ ] lifecycle visible sin dominar
[ ] criticality visible con semántica correcta
[ ] location/hierarchy disponible
[ ] Manufacturer vacío no rompe layout
[ ] Model vacío no rompe layout
[ ] visual etiquetado Type illustration
[ ] no Rotate / Orbit / Explode
```

---

# 5. Technical Profile

Debe existir evidencia simultánea de:

```text
[ ] Duty flow      = 120 m³/h / READY
[ ] Duty pressure  = 6 bar / READY
[ ] Redundancy     = texto / READY
[ ] Manufacturer   = — / UNAVAILABLE
[ ] Model          = — / UNAVAILABLE
```

Y:

```text
[ ] unidad separada del label
[ ] provenance subordinado pero accesible
[ ] unavailable no se representa como 0
[ ] no hay conversiones técnicas en Power Fx
[ ] orden procede de metadata
```

---

# 6. Engineering Context

```text
[ ] source P-101 conceptual case visible como referencia
[ ] Datasheet / P&ID / Manual O&M están marcados REFERENCE_ONLY
[ ] no existe botón Open cuando no hay OpenReference
[ ] no se presenta referencia como attachment almacenado
[ ] EMPTY/UNAVAILABLE/ERROR conservan geometría
```

---

# 7. Visuals

```text
[ ] TYPE_ILLUSTRATION se distingue de MODEL_IMAGE y ASSET_PHOTO
[ ] mapping usa AssetKey gobernado
[ ] UI no muestra path GitHub
[ ] fallback controlado
[ ] imagen conserva transparencia/aspect ratio
[ ] reopen conserva recurso correctamente
```

---

# 8. Maintenance

```text
[ ] estrategia demo marcada como conceptual
[ ] open WO = —
[ ] overdue WO = —
[ ] next due = —
[ ] no Generate WO
[ ] no Schedule
[ ] no Execute
[ ] no Close
```

---

# 9. Interaction

```text
[ ] tabs/sections tienen selected state inequívoco
[ ] hover != selected
[ ] focus visible
[ ] hit areas razonables
[ ] acciones disabled explican estado cuando proceda
[ ] no navegación oculta dentro de componentes shared
```

---

# 10. Responsive desktop

Registrar al menos una resolución de referencia y comprobar:

```text
[ ] no clipping horizontal accidental
[ ] no text overlap
[ ] Technical Profile refluye de forma legible
[ ] Hero no colapsa identidad por mantener la imagen
[ ] side/context panels no roban superficie dominante
```

No congelar geometría contractual hasta evidencia real.

---

# 11. Technical quality

```text
[ ] App Checker sin nuevos errores críticos
[ ] no datasource productivo
[ ] no Flow
[ ] no SQL DML
[ ] no hard-coded ALEP columns
[ ] no global variables ocultas salvo state declarado
[ ] no duplicated icon Switch fuera del resolver acordado
[ ] no component-specific business rules
```

---

# 12. Reopen smoke

Guardar, cerrar/reabrir y validar:

```text
[ ] app abre
[ ] fixture vuelve a cargar
[ ] componentes renderizan
[ ] Type Illustration sigue disponible
[ ] tabs funcionan
[ ] App Checker no regresa
```

---

# 13. Evidence package

Guardar referencia a:

```text
E01 full Asset Detail screenshot
E02 Technical Profile screenshot
E03 Engineering source/provenance screenshot
E04 Visuals screenshot
E05 App Checker
E06 reopen result
E07 resolution + environment notes
E08 imported/adapted component versions
E09 AE-G5 evidence
E10 known defects
```

---

# 14. Verdict

Valores permitidos:

```text
PASS_STUDIO
PASS_STRUCTURE_ONLY / VISUAL_RUNTIME_HOLD
PASS_WITH_WARNINGS
HOLD
FAIL
```

`PASS_STUDIO` autoriza preparar `AE6-S02 — real read adapter`.

No autoriza por sí solo:

- writes;
- productive data validation;
- Asset Edit;
- Work Management capabilities;
- promoción de componentes no probados.
