#!/usr/bin/env bash
# Bootstrap ~/Documents/CursorContext on macOS (or Linux).
set -euo pipefail

VAULT="${VAULT:-$HOME/Documents/CursorContext}"
SOURCE="$(cd "$(dirname "$0")/.." && pwd)"
CURSOR_MCP="$HOME/.cursor/mcp.json"
QUIET="${QUIET:-0}"

log() { [[ "$QUIET" == "1" ]] || echo "$@"; }

log "→ Vault: $VAULT"
log "→ Template: $SOURCE"

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

# Enable repo git hooks (post-merge → re-sync vault) when run from a git checkout
REPO_ROOT="$(git -C "$SOURCE" rev-parse --show-toplevel 2>/dev/null || true)"
if [[ -n "$REPO_ROOT" && -d "$REPO_ROOT/.githooks" ]]; then
  git -C "$REPO_ROOT" config core.hooksPath .githooks 2>/dev/null || true
fi

detect_obsidian_api_key() {
  if [[ -n "${OBSIDIAN_API_KEY:-}" ]]; then
    return 0
  fi
  local data="$VAULT/.obsidian/plugins/obsidian-local-rest-api/data.json"
  [[ -f "$data" ]] || return 0
  OBSIDIAN_API_KEY="$(python3 - << 'PY' "$data"
import json, sys
p = sys.argv[1]
try:
    d = json.load(open(p))
    print(d.get("apiKey") or d.get("token") or "")
except Exception:
    print("")
PY
)"
  export OBSIDIAN_API_KEY
}

merge_mcp() {
  local example="$VAULT/.cursor/mcp.json.example"
  [[ -f "$example" ]] || return 0

  detect_obsidian_api_key

  if [[ -z "${OBSIDIAN_API_KEY:-}" ]]; then
    log ""
    log "⚠ MCP Obsidian: ключ не найден (плагин Local REST API в vault или OBSIDIAN_API_KEY)."
    return 0
  fi

  mkdir -p "$(dirname "$CURSOR_MCP")"
  MCP_EXAMPLE="$example" CURSOR_MCP="$CURSOR_MCP" OBSIDIAN_API_KEY="$OBSIDIAN_API_KEY" python3 << 'PY'
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
print(f"✓ MCP Obsidian → {mcp_path}")
PY
}

merge_mcp

if [[ "$(uname -s)" == "Darwin" ]] && command -v open >/dev/null 2>&1; then
  open "obsidian://open?path=$(python3 -c "import urllib.parse,sys; print(urllib.parse.quote(sys.argv[1]))" "$VAULT")" 2>/dev/null || true
  if [[ ! -f "$VAULT/.obsidian/plugins/obsidian-local-rest-api/manifest.json" ]]; then
    open "obsidian://show-plugin?id=obsidian-local-rest-api" 2>/dev/null || true
  fi
fi

if [[ "$QUIET" != "1" ]]; then
  cat << EOF

Готово: $VAULT

Obsidian: Open folder → этот путь. Плагин Local REST API — для MCP в Cursor (ключ подхватится автоматически из vault).

EOF
fi
