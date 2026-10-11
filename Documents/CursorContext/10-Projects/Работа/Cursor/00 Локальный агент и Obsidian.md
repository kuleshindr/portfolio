---
tags: [cursor, obsidian, premiere]
---

# Локальный агент и Obsidian

## Единый контекст (Mac ↔ Cloud)

| Среда | Путь |
|-------|------|
| Obsidian vault (Mac) | `/Users/dmitrijkulesin/Documents/CursorContext` |
| Git (Cloud Agent) | `Documents/CursorContext/` в репо [kuleshindr/portfolio](https://github.com/kuleshindr/portfolio) |
| Эта папка «Работа» | `10-Projects/Работа/` |

После `git pull` на Mac содержимое vault и репо совпадает. **Не** используй старый пустой vault `~/Documents/Obsidian Vault`.

## Obsidian (локальный Mac)

1. Vault = `~/Documents/CursorContext` (синхрон через git portfolio).
2. **Local REST API** + MCP `obsidian` в Cursor — опционально для поиска.
3. Стартовая заметка: **[[../00 Home — Работа|00 Home — Работа]]**.

## Cloud Agent

- Только **файлы `.md`** в `Documents/CursorContext/` — **без** Obsidian MCP.
- Пример: `@Documents/CursorContext/10-Projects/Работа/00 Home — Работа.md`

## Локальный Agent (Premiere)

1. Premiere + CEP Bridge + MCP `premiere-pro`.
2. `@Documents/CursorContext/10-Projects/Работа/Иран/iran-v2_3-local-agent-handoff`
3. Промпт: [[../Иран/iran-v2_3-local-agent-handoff#Готовый промпт (скопировать в локальный Agent)|handoff Иран]]

## Правила

- Итоги чатов → `00-Inbox/` или `10-Projects/Работа/Meta/`
- Не дублировать длинные тексты — wiki-ссылки `[[...]]`
- См. корневой `Documents/CursorContext/AGENTS.md`
