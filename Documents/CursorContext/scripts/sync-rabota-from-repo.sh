#!/usr/bin/env bash
# Copy full 10-Projects/Работа from portfolio template into ~/Documents/CursorContext
set -euo pipefail

VAULT="${VAULT:-$HOME/Documents/CursorContext}"
SOURCE="$(cd "$(dirname "$0")/.." && pwd)"
SRC_RABOTA="$SOURCE/10-Projects/Работа"
DEST="$VAULT/10-Projects/Работа"

if [[ ! -d "$SRC_RABOTA" ]]; then
  echo "ERROR: no $SRC_RABOTA — run from portfolio repo (git pull first)."
  exit 1
fi

mkdir -p "$VAULT/10-Projects"
echo "→ From: $SRC_RABOTA"
echo "→ To:   $DEST"

# Remove wrong empty folder if user created 00 Home — Работа as directory
if [[ -d "$DEST/00 Home — Работа" && ! -f "$DEST/00 Home — Работа.md" ]]; then
  echo "→ Removing mistaken folder: 00 Home — Работа/"
  rm -rf "$DEST/00 Home — Работа"
fi

if command -v rsync >/dev/null 2>&1; then
  rsync -a --delete "$SRC_RABOTA/" "$DEST/"
else
  rm -rf "$DEST"
  mkdir -p "$DEST"
  cp -a "$SRC_RABOTA/." "$DEST/"
fi

echo ""
echo "Done. Check:"
echo "  $DEST/00 Home — Работа.md"
echo "  $DEST/Иран/"
echo "  $DEST/Meta/"
ls -la "$DEST" | head -20
