# kopylovis/tap

Одной командой — Homebrew, доступ к приватному mnrh-utils, mnrh и подключение к Claude Code:

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/kopylovis/homebrew-tap/main/install.sh)
```

Скрипт можно запускать повторно: сделанные шаги он пропускает, а mnrh обновляет.

Вручную: нужен Homebrew 7.0.8+ и строка `HOMEBREW_GITHUB_API_TOKEN=<токен>` в `~/.homebrew/brew.env` (fine-grained токен только на чтение `kopylovis/mnrh-utils`), затем:

```bash
brew install kopylovis/tap/mnrh
mnrh init
```

Обновление: `brew upgrade mnrh`.

## promptsill

Строка состояния для Claude Code, открытый проект: https://github.com/kopylovis/promptsill

```bash
brew install kopylovis/tap/promptsill
promptsill install
```

Обновление: `brew upgrade promptsill`.
