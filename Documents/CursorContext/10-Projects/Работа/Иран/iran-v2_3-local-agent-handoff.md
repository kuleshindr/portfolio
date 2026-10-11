# Handoff: локальный Agent + Premiere MCP → «ИРАН v2_3» маркеры

Используй этот файл в **локальном** Cursor на Mac с Premiere (не Cloud Agent).

## Перед стартом

1. Premiere: проект открыт, активна сиквенция **ИРАН v2_3**, новая дорожка диктора на месте.
2. **Window → Extensions → MCP Bridge** → Start Bridge («Connector running»).
3. **Cursor → Customize → MCPs** → `premiere-pro` включён.

## Как передать контекст агенту

Любой из способов (можно комбинировать):

| Способ | Что сделать |
|--------|-------------|
| **@ файл** | В новом чате: `@iran-v2_3-local-agent-handoff.md` и `@iran-v2_3-markery-checlist.md` (если store в workspace — путь к store; иначе скопируй файлы в проект или открой store как folder). |
| **Ссылка на cloud-чат** | Вставь URL прошлого Cloud Agent run — локальный агент не видит историю автоматически, но ты можешь кратко: «контекст в [чеклисте](iran-v2_3-markery-checlist.md)». |
| **Google Docs** | [Разметка VO](https://docs.google.com/document/d/1cKIVP1AXE7wgQzxS7TTmbDfdyxuMeh4xTRHRwTMMPY4/edit), [Иран правки (картинка/TC)](https://docs.google.com/document/d/1o68aVywQuuF-tIhunNK5pkUnuoaFiPk9egzEMOyUApc/edit). |
| **CSV** | `@iran-v2_3-markers-template.csv` — заполнить колонки `SequenceTimecode` / `Status` после работы. |

Пути в Project Agent Store (если подключён):

- Чеклист: `docs/iran-v2_3-markery-checlist.md`
- CSV: `docs/iran-v2_3-markers-template.csv`
- Хронометраж дозаписи: `docs/iran-diktor-new-reads-timing.md`

## Готовый промпт (скопировать в локальный Agent)

```
Задача: сиквенция «ИРАН v2_3». Подменили дорожку диктора — маркеры правок слетели по таймкоду.

1) verify_premiere_connection (без лишних изменений в проекте).
2) Убедись, что активна «ИРАН v2_3». list_markers / get_timeline_summary.
3) Сверь маркеры с @iran-v2_3-markery-checlist.md:
   - vo_done: если фраза SearchInVO есть в новой VO — снять старые маркеры «переозвучить».
   - vo_cut_verify: не должно звучать (Грибоедов, Лаврентьев, «вторжения нацистской Германии»).
   - vo_verify: вставки (Орлиный коготь, Винсеннес, Сулеймани, Амини) + блок WWII/ленд-лиза.
   - picture/montage: переставить маркеры на новый TC по якорной фразе, не по старым 6:13 / 11:33 и т.д.
4) Обнови/создай маркеры с Comment = ID из чеклиста (VO-INTRO, PIC-MAP-00, …).
5) Export Markers CSV и краткий отчёт: что закрыто, что осталось, что не нашлось в VO.

Источники правок: Google Doc iran-scenariy-pravki-razmetka и «Иран правки» (картинка отдельно от VO).
```

## Ожидаемый результат

- Маркеры с актуальными TC и понятными именами (ID из чеклиста).
- Список **отменённых** правок (кусок вырезан / уже в новой озвучке).
- Список **открытых** (дозапись, картинка, субтитры «режим»).

Cloud Agent, который готовил чеклист: https://cursor.com/agents/bc-36633d04-7f81-5532-b75a-8700ebaf1647
