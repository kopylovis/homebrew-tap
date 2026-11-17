# kopylovis/tap

Одной командой — Homebrew, mnrh и подключение к Claude Code:

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/kopylovis/homebrew-tap/main/install.sh)
```

Скрипт можно запускать повторно: сделанные шаги он пропускает, а mnrh обновляет.

Вручную:

```bash
brew install kopylovis/tap/mnrh
mnrh init
```

Обновление: `brew upgrade mnrh`.

## agentmeister

Запуск Claude Code и Codex в выбранном проекте, прокси для отдельных сессий, хуки и MCP-сервер.
`am` открывает то же меню, что и `agentmeister`. [agentmeister на GitHub](https://github.com/kopylovis/agentmeister)

```bash
brew install kopylovis/tap/agentmeister
agentmeister
```

Для обновления используй `brew upgrade agentmeister`.

## promptsill

Строка состояния для Claude Code. Команда `promptsill codex` выводит состояние сессии Codex и данные о проекте.
[promptsill на GitHub](https://github.com/kopylovis/promptsill)

```bash
brew install kopylovis/tap/promptsill
promptsill install
```

Обновление: `brew upgrade promptsill`.
