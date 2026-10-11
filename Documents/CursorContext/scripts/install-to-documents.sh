#!/usr/bin/env bash
# Bootstrap ~/Documents/CursorContext on macOS (or Linux).
set -euo pipefail

VAULT="${VAULT:-$HOME/Documents/CursorContext}"
SOURCE="$(cd "$(dirname "$0")/.." && pwd)"
CURSOR_MCP="$HOME/.cursor/mcp.json"

echo "→ Vault: $VAULT"
echo "→ Template: $SOURCE"

copy_tree() {
  if command -v rsync >/dev/null 2>&1; then
    rsync -a "$@"
  else
    local src="${1%/}" dest="$2"
    mkdir -p "$dest"
    cp -a "$src"/. "$dest"/
  fi
}

mkdir -p "$VAULT"
if [[ ! -f "$VAULT/AGENTS.md" ]]; then
  copy_tree "$SOURCE" "$VAULT"
else
  for dir in 00-Inbox 10-Projects 20-Context 30-Daily templates .cursor .obsidian scripts; do
    mkdir -p "$VAULT/$dir"
    [[ -d "$SOURCE/$dir" ]] && copy_tree "$SOURCE/$dir" "$VAULT/$dir"
  done
  for f in AGENTS.md README.md .gitignore .cursorignore; do
    [[ -f "$SOURCE/$f" ]] && cp -a "$SOURCE/$f" "$VAULT/$f"
  done
fi

merge_mcp() {
  local example="$VAULT/.cursor/mcp.json.example"
  [[ -f "$example" ]] || return 0

  if [[ -z "${OBSIDIAN_API_KEY:-}" ]]; then
    echo ""
    echo "⚠ OBSIDIAN_API_KEY не задан — MCP для Obsidian настроишь после установки плагина."
    echo "  export OBSIDIAN_API_KEY='...'  # Settings → Local REST API в Obsidian"
    echo "  Затем снова: OBSIDIAN_API_KEY=... $0"
    return 0
  fi

  mkdir -p "$(dirname "$CURSOR_MCP")"
  python3 << 'PY'
import json, os, pathlib
mcp_path = pathlib.Path(os.environ["CURSOR_MCP"])
example = json.loads(pathlib.Path(os.environ["MCP_EXAMPLE"]).read_text())
key = os.environ["OBSIDIAN_API_KEY"]
entry = example["mcpServers"]["obsidian"]
if mcp_path.exists():
    data = json.loads(mcp_path.read_text())
else:
    data = {"mcpServers": {}}
data.setdefault("mcpServers", {})["obsidian"] = {
    "url": entry["url"],
    "headers": {"Authorization": f"Bearer {key}"},
}
mcp_path.write_text(json.dumps(data, indent=2) + "\n")
print(f"✓ Обновлён {mcp_path}")
PY
}

export CURSOR_MCP MCP_EXAMPLE="$VAULT/.cursor/mcp.json.example"
merge_mcp

if [[ ! -d "$VAULT/.git" ]]; then
  echo ""
  echo "→ Рекомендуется: git в vault для Cloud Agents"
  echo "  cd \"$VAULT\" && git init && git add -A && git commit -m \"Init context vault\""
  echo "  Создай private repo и: git remote add origin ... && git push -u origin main"
fi

cat << EOF

Готово.

1. Obsidian → Open folder → $VAULT
2. Community plugins → Local REST API → включить → скопировать API key
3. export OBSIDIAN_API_KEY='ключ' && $0   # запишет ~/.cursor/mcp.json
4. Cursor → Open Folder → $VAULT  (или добавь папку в multi-root)
5. Перезапусти Cursor

Cloud Agents: открой в Cursor репозиторий, куда синхронизирован этот vault (private git).

EOF
