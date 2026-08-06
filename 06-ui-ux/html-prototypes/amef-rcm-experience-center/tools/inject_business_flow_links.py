from pathlib import Path
import re
import sys

root = Path(sys.argv[1]).resolve() if len(sys.argv) > 1 else Path(__file__).resolve().parents[1]
prototypes = {
    "01-comprender-problema": "01",
    "02-evaluar-riesgo": "02",
    "03-decision-rcm": "03",
    "04-convertir-en-plan": "04",
    "05-gobernar-mejorar": "05",
}
css_link = '<link rel="stylesheet" href="../../assets/business-flow-guide.css">'
script_template = '<script src="../../assets/business-flow-guide.js" data-business-guide="{guide_id}"></script>'

for folder, guide_id in prototypes.items():
    path = root / "prototipos" / folder / "index.html"
    html = path.read_text(encoding="utf-8")
    html = re.sub(r'<link[^>]+business-flow-guide\.css[^>]*>\s*', '', html)
    html = re.sub(r'<script[^>]+business-flow-guide\.js[^>]*></script>\s*', '', html)
    html = html.replace('</head>', css_link + '\n</head>', 1)
    html = html.replace('</body>', script_template.format(guide_id=guide_id) + '\n</body>', 1)
    path.write_text(html, encoding="utf-8")

print(f"Business flow guides injected into {len(prototypes)} prototypes under {root}")
