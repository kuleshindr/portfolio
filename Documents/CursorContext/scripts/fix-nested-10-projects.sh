#!/usr/bin/env bash
# Fix accidental 10-Projects/10-Projects/ nesting in the vault.
set -euo pipefail

VAULT="${VAULT:-$HOME/Documents/CursorContext}"
NESTED="$VAULT/10-Projects/10-Projects"

if [[ ! -d "$NESTED" ]]; then
  echo "OK: no nested 10-Projects at $NESTED"
  exit 0
fi

echo "→ Flattening $NESTED into $VAULT/10-Projects/"
shopt -s dotglob nullglob
for item in "$NESTED"/*; do
  base="$(basename "$item")"
  dest="$VAULT/10-Projects/$base"
  if [[ -e "$dest" ]]; then
    echo "  skip (exists): $base"
  else
    mv "$item" "$dest"
    echo "  moved: $base"
  fi
done
rmdir "$NESTED" 2>/dev/null || {
  echo "⚠ Nested folder not empty — merge manually: $NESTED"
  exit 1
}
echo "Done. Expect: $VAULT/10-Projects/Работа/"
