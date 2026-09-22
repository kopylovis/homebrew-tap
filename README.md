# kopylovis/tap

Одной командой — Homebrew, GitHub CLI, вход в GitHub, mnrh и подключение к Claude Code:

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/kopylovis/homebrew-tap/main/install.sh)
```

Скрипт можно запускать повторно: сделанные шаги он пропускает, а mnrh обновляет.

Вручную, если вход в GitHub уже настроен (`gh auth login` и `gh auth setup-git`):

```bash
brew install kopylovis/tap/mnrh
mnrh claude setup
```

Обновление: `brew upgrade mnrh`.
