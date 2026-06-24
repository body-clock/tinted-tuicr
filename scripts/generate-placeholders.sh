#!/usr/bin/env bash
# generate-placeholders.sh  —  Create placeholder .toml files for every
# base16 scheme so Tinty can resolve theme file paths for the tinted-tuicr
# [[items]] entry.
#
# Run once after cloning or whenever new base16 schemes are released.
# The placeholder files are intentionally empty — all real theme generation
# happens at runtime via `scripts/generate.sh` using Tinty env vars.
#
# Usage: ./scripts/generate-placeholders.sh

set -euo pipefail

THEMES_DIR="$(cd "$(dirname "$0")/../themes" && pwd)"
TINTY_DATA="${TINTY_DATA:-$HOME/.local/share/tinted-theming/tinty}"
SCHEMES_DIR="${TINTY_DATA}/repos/schemes/base16"

if [ ! -d "$SCHEMES_DIR" ]; then
  echo "ERROR: base16 schemes not found at $SCHEMES_DIR" >&2
  echo "       Run 'tinty install' first." >&2
  exit 1
fi

count=0
for yaml in "$SCHEMES_DIR"/*.yaml; do
  [ -f "$yaml" ] || continue
  slug="$(basename "$yaml" .yaml)"
  placeholder="$THEMES_DIR/base16-${slug}.toml"
  if [ ! -f "$placeholder" ]; then
    echo "# tinted-tuicr placeholder — theme generated at runtime" > "$placeholder"
    count=$((count + 1))
  fi
done

echo "Created $count new placeholder theme files in $THEMES_DIR"
echo "Total: $(ls "$THEMES_DIR"/*.toml 2>/dev/null | wc -l | tr -d ' ') .toml files"
