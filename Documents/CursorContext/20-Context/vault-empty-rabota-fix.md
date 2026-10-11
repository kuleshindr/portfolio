# Vault пустой в 10-Projects/Работа

Файлы живут в **GitHub** `kuleshindr/portfolio` → `Documents/CursorContext/10-Projects/Работа/`.  
Obsidian сам их не скачивает — нужен **git pull** или скрипт.

## Шаги на Mac (5 мин)

```bash
# 1) Клон portfolio, если ещё нет
cd ~/Documents
git clone https://github.com/kuleshindr/portfolio.git
cd portfolio
git pull origin main

# 2) Залить «Работа» в vault
VAULT=~/Documents/CursorContext bash Documents/CursorContext/scripts/sync-rabota-from-repo.sh

# 3) (опционально) весь vault обновить
VAULT=~/Documents/CursorContext bash Documents/CursorContext/scripts/install-to-documents.sh
```

В Finder: `~/Documents/CursorContext/10-Projects/Работа/` — файл **`00 Home — Работа.md`**, папки **`Иран`**, **`Meta`**, **`Cursor`**, **`РФК`**.

Obsidian: **Cmd+R** или переоткрыть vault.

## Локальный / Cloud Agent

`@Documents/CursorContext/10-Projects/Работа/00 Home — Работа.md`
