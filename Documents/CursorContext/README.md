# CursorContext — vault для Cursor + Obsidian

Папка на Mac: **`~/Documents/CursorContext`**

## Быстрая установка (Mac)

```bash
# из корня этого git-репозитория:
chmod +x Documents/CursorContext/scripts/install-to-documents.sh
Documents/CursorContext/scripts/install-to-documents.sh
```

Obsidian:

1. **Open folder** → `~/Documents/CursorContext`
2. **Settings → Community plugins** → включить **Local REST API**
3. Скопировать API key → в терминале:

```bash
export OBSIDIAN_API_KEY='вставь-ключ'
Documents/CursorContext/scripts/install-to-documents.sh
```

4. Перезапустить **Cursor**

Cursor:

- **File → Open Folder** → `~/Documents/CursorContext`  
  или держи код в другом репо, но добавляй в чат `@` на файлы из vault (если vault в том же workspace / monorepo).

## Локальные vs облачные агенты

| | Локальный Agent (Mac) | Cloud Agent |
|--|------------------------|-------------|
| Чтение/запись `.md` | ✓ открытый vault в Cursor | ✓ если vault в **git-репо**, который открыт агентом |
| MCP Obsidian | ✓ Obsidian запущен + MCP | ✗ |
| Скорость | Файлы на диске + индекс Cursor | Как обычные файлы в репо |

Чтобы **cloud** видел контекст:

```bash
cd ~/Documents/CursorContext
git init
git add -A && git commit -m "Init context vault"
# private repo на GitHub/GitLab, затем push
```

В Cursor для cloud-задач открывай **этот репозиторий** или добавь vault **submodule** в основной проект:

```bash
cd /path/to/your-app
git submodule add git@github.com:YOU/cursor-context.git Documents/CursorContext
```

## Плагин Obsidian (опционально, для MCP)

- [Local REST API](https://github.com/coddingtonbear/obsidian-local-rest-api)  
- MCP URL: `https://127.0.0.1:27124/mcp/` (пример в `.cursor/mcp.json.example`)

Без MCP всё равно работает: агент правит markdown как файлы.

## Структура

См. `AGENTS.md` — правила для всех агентов.
