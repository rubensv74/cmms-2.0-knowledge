#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OUTPUT="${1:-$ROOT/releases/AMEF_RCM_Experience_Center_v1.0.zip}"

mkdir -p "$(dirname "$OUTPUT")"
rm -f "$OUTPUT"

cd "$ROOT"
zip -r "$OUTPUT" \
  index.html \
  mapa-maestro \
  prototipos \
  docs \
  README.md \
  manifest.json \
  -x "releases/*"

if command -v sha256sum >/dev/null 2>&1; then
  sha256sum "$OUTPUT"
elif command -v shasum >/dev/null 2>&1; then
  shasum -a 256 "$OUTPUT"
fi

echo "Paquete creado: $OUTPUT"
