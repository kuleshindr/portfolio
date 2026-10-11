# Obsidian · вкладка «Работа» (актуальные пути)

Контекст живёт в **git**, не в Project Agent Store.

## Точка входа

- **Obsidian / @ в Cursor:** `10-Projects/Работа/00 Home — Работа.md`
- **Полный путь Mac:** `/Users/dmitrijkulesin/Documents/CursorContext/10-Projects/Работа/00 Home — Работа.md`
- **Cloud Agent:** `@Documents/CursorContext/10-Projects/Работа/00 Home — Работа.md`

## Если в Obsidian `10-Projects/10-Projects/` (лишняя вложенность)

Так бывает, если папку `10-Projects` из репо перетащили **внутрь** уже существующей `10-Projects`.

```bash
cd ~/Documents/CursorContext   # vault
bash scripts/fix-nested-10-projects.sh
# или из clone portfolio:
bash Documents/CursorContext/scripts/fix-nested-10-projects.sh
```

Должно быть: `10-Projects/Работа/`, **не** `10-Projects/10-Projects/Работа/`.

## Синхронизация Mac ↔ GitHub

```bash
cd ~/Documents/CursorContext   # или корень clone portfolio с Documents/CursorContext
git pull origin main
# после правок на Mac:
git add Documents/CursorContext && git commit -m "…" && git push origin main
```

Если vault установлен скриптом `scripts/install-to-documents.sh` — pull делай из репозитория portfolio, затем post-merge hook обновит `~/Documents/CursorContext`.

## Локальный агент

```
@Documents/CursorContext/10-Projects/Работа/00 Home — Работа.md
```

Иран v2_3: `@…/Иран/iran-v2_3-local-agent-handoff.md`.

Перенесено из project store: 2026-10-11 (cloud agent bc-36633d04).
