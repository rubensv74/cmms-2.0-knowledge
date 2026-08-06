from pathlib import Path
import json
import re

ROOT = Path(__file__).resolve().parents[1]
PROTOTYPES = {
    "01-comprender-problema": "01",
    "02-evaluar-riesgo": "02",
    "03-decision-rcm": "03",
    "04-convertir-en-plan": "04",
    "05-gobernar-mejorar": "05",
}
CSS_LINK = '<link rel="stylesheet" href="../../assets/business-flow-guide.css">'
SCRIPT = '<script src="../../assets/business-flow-guide.js" data-business-guide="{id}"></script>'

for folder, guide_id in PROTOTYPES.items():
    path = ROOT / "prototipos" / folder / "index.html"
    html = path.read_text(encoding="utf-8")
    html = re.sub(r'<link[^>]+business-flow-guide\.css[^>]*>\s*', '', html)
    html = re.sub(r'<script[^>]+business-flow-guide\.js[^>]*></script>\s*', '', html)
    html = html.replace('</head>', CSS_LINK + '\n</head>', 1)
    html = html.replace('</body>', SCRIPT.format(id=guide_id) + '\n</body>', 1)
    path.write_text(html, encoding="utf-8")

flow_doc = """# Guías prácticas del flujo de negocio AMEF–RCM

## Objetivo

Cada uno de los cinco prototipos incluye un icono de información `ⓘ` que abre una guía práctica del proceso de negocio representado en esa etapa.

Las guías no explican controles, botones ni navegación. Ayudan a comprender:

- qué pregunta debe resolver la organización;
- qué decisiones deben tomarse;
- qué roles intervienen;
- qué resultado debe generarse;
- qué errores metodológicos deben evitarse;
- cómo enlaza la etapa con el resto del ciclo AMEF–RCM.

## Cobertura

1. **Comprender el activo:** contexto, funciones, fallos funcionales y modos de fallo.
2. **Evaluar el riesgo:** efectos, consecuencias, controles, evidencia y prioridad AMEF.
3. **Seleccionar la política:** árbol RCM, aplicabilidad, efectividad, P–F y alternativas.
4. **Construir el plan:** tareas, intervalos, recursos, costes, alcance y exportación neutra.
5. **Gobernar y mejorar:** trazabilidad, calidad, discrepancias, aprobaciones, versiones y datos reales.

## Uso recomendado en las reuniones

Antes de entrar en los datos de una pantalla, abrir la guía y validar:

1. ¿La pregunta de negocio es correcta?
2. ¿Falta algún rol, decisión o control relevante?
3. ¿El resultado permite comenzar la siguiente etapa sin perder trazabilidad?

## Límite

Las guías describen un modelo funcional propuesto. Roles, gates, evidencias mínimas, autoridades y reglas deberán validarse corporativamente antes de convertirse en especificación para IT.
"""
(ROOT / "docs" / "GUIAS_FLUJO_NEGOCIO.md").write_text(flow_doc, encoding="utf-8")

manifest_path = ROOT / "manifest.json"
manifest = json.loads(manifest_path.read_text(encoding="utf-8"))
manifest["version"] = "2.1.0"
manifest["businessFlowGuides"] = {
    "enabled": True,
    "trigger": "information-icon",
    "stylesheet": "assets/business-flow-guide.css",
    "script": "assets/business-flow-guide.js",
    "documentation": "docs/GUIAS_FLUJO_NEGOCIO.md",
}
manifest_path.write_text(json.dumps(manifest, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")

readme = ROOT / "README.md"
text = readme.read_text(encoding="utf-8")
text = text.replace("Versión conceptual integrada 2.0.", "Versión conceptual integrada 2.1.")
if "## Guías del flujo de negocio" not in text:
    text += "\n## Guías del flujo de negocio\n\nCada prototipo incorpora un icono `ⓘ` que abre una guía práctica centrada en el proceso de negocio. La definición editorial se encuentra en `docs/GUIAS_FLUJO_NEGOCIO.md`.\n"
readme.write_text(text, encoding="utf-8")

public = ROOT / "docs" / "README_PUBLICO_GENERAL.md"
text = public.read_text(encoding="utf-8")
if "## Ayuda contextual" not in text:
    text += "\n## Ayuda contextual\n\nEn la cabecera de cada prototipo aparece un icono de información `ⓘ`. La ventana explica el flujo lógico del negocio, quién participa, qué se decide, qué resultado se espera y qué errores deben evitarse. No es un manual de la pantalla.\n"
public.write_text(text, encoding="utf-8")

validation = ROOT / "docs" / "VALIDACION.md"
text = validation.read_text(encoding="utf-8")
text = text.replace("Versión validada: 2.0.0-conceptual", "Versión validada: 2.1.0-conceptual")
if "## Validación incremental — Guías prácticas" not in text:
    text += "\n## Validación incremental — Guías prácticas del flujo de negocio\n\n- Icono `ⓘ` disponible en los cinco prototipos.\n- Contenido diferenciado para cada etapa.\n- Apertura y cierre mediante botón, fondo y tecla Escape.\n- Secciones comunes: pregunta de negocio, seis pasos, roles, decisiones, resultados, errores y ejemplo P-101.\n- Las guías describen el proceso de negocio y no el uso de la interfaz.\n"
validation.write_text(text, encoding="utf-8")

package_sh = ROOT / "package.sh"
text = package_sh.read_text(encoding="utf-8")
text = text.replace("AMEF_RCM_Experience_Center_v2.0.zip", "AMEF_RCM_Experience_Center_v2.1.zip")
text = text.replace("README.md manifest.json index.html mapa-maestro prototipos docs;", "README.md manifest.json index.html mapa-maestro prototipos docs assets;")
package_sh.write_text(text, encoding="utf-8")

package_ps = ROOT / "package.ps1"
text = package_ps.read_text(encoding="utf-8")
text = text.replace("AMEF_RCM_Experience_Center_v2.0.zip", "AMEF_RCM_Experience_Center_v2.1.zip")
if '"assets"' not in text:
    text = text.replace('"docs"', '"docs",\n    "assets"')
package_ps.write_text(text, encoding="utf-8")

release_readme = """# Releases

Esta carpeta contiene los paquetes generados para distribución y su checksum externo.

## Versión actual

- `AMEF_RCM_Experience_Center_v2.1.zip`
- `SHA256SUMS.txt`

La versión 2.1 incorpora en los cinco prototipos un icono `ⓘ` con una guía práctica del flujo de negocio.

El ZIP se genera mediante `package.ps1` o `package.sh`, contiene `index.html` en la raíz y excluye la propia carpeta `releases`.
"""
(ROOT / "releases" / "README.md").write_text(release_readme, encoding="utf-8")
