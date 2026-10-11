# Obsidian · вкладка «Работа» (актуальные пути)

Контекст живёт в **git**, не в Project Agent Store.

## Точка входа

- **Obsidian / @ в Cursor:** `10-Projects/Работа/00 Home — Работа.md`
- **Полный путь Mac:** `/Users/dmitrijkulesin/Documents/CursorContext/10-Projects/Работа/00 Home — Работа.md`
- **Cloud Agent:** `@Documents/CursorContext/10-Projects/Работа/00 Home — Работа.md`

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
