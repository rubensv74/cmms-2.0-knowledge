#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")" && pwd)"
RELEASE="$ROOT/releases"
STAGE="$(mktemp -d)"
OUTPUT="${1:-$RELEASE/AMEF_RCM_Experience_Center_v2.0.zip}"
trap 'rm -rf "$STAGE"' EXIT

mkdir -p "$(dirname "$OUTPUT")"
for item in README.md manifest.json index.html mapa-maestro prototipos docs; do
  cp -R "$ROOT/$item" "$STAGE/"
done
find "$STAGE" -name 'index.repo.html' -delete
rm -f "$OUTPUT"
(cd "$STAGE" && zip -qr "$OUTPUT" .)

if command -v sha256sum >/dev/null 2>&1; then
  HASH="$(sha256sum "$OUTPUT" | awk '{print $1}')"
elif command -v shasum >/dev/null 2>&1; then
  HASH="$(shasum -a 256 "$OUTPUT" | awk '{print $1}')"
else
  HASH="no-disponible"
fi
printf '%s  %s\n' "$HASH" "$(basename "$OUTPUT")" > "$RELEASE/SHA256SUMS.txt"
echo "Paquete creado: $OUTPUT"
echo "SHA256: $HASH"