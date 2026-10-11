# Premiere MCP · когда работает

Premiere настроен на Mac пользователя (CEP Bridge, `premiere-pro-mcp`).

| Среда | Premiere MCP |
|-------|----------------|
| Cursor на Mac + MCP `premiere-pro` | ✅ |
| Cloud Agent (удалённая VM) | ❌ нет Premiere, нет MCP |
| Cloud Agent + My Machines (Mac с Premiere) | ✅ |

Цепочка локально: Cursor → premiere-pro-mcp → CEP Bridge → Premiere.

**Иран v2_3 маркеры:** облачный [Иран сценарий правки](bc-36633d04-7f81-5532-b75a-8700ebaf1647) — чеклист/CSV; живой монтаж — локальный агент или My Machines + `verify_premiere_connection`, `list_markers`.

Обход без MCP: Export Markers CSV из v2_3.

Handoff для локального агента: [iran-v2_3-local-agent-handoff.md](iran-v2_3-local-agent-handoff.md).
