#!/usr/bin/env bash
set -euo pipefail

REPO="kopylovis/mnrh-utils"
FORMULA="kopylovis/tap/mnrh"
BREW_ENV="$HOME/.homebrew/brew.env"
MIN_BREW="7.0.8"

step() { printf '\n\033[1m==> %s\033[0m\n' "$1"; }
fail() { printf '\n\033[31m%s\033[0m\n' "$1" >&2; exit 1; }

[ "$(uname -s)" = "Darwin" ] || fail "mnrh работает только на macOS."

step "Homebrew"
if ! command -v brew >/dev/null 2>&1; then
  for candidate in /opt/homebrew/bin/brew /usr/local/bin/brew; do
    [ -x "$candidate" ] && eval "$("$candidate" shellenv)" && break
  done
fi
if ! command -v brew >/dev/null 2>&1; then
  echo "Homebrew не найден — ставлю официальным установщиком."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  for candidate in /opt/homebrew/bin/brew /usr/local/bin/brew; do
    [ -x "$candidate" ] && eval "$("$candidate" shellenv)" && break
  done
fi
command -v brew >/dev/null 2>&1 || fail "Homebrew так и не появился в PATH."
brew_version="$(brew --version | sed -n '1s/^Homebrew \([0-9.]*\).*/\1/p')"
if [ "$(printf '%s\n%s\n' "$MIN_BREW" "$brew_version" | sort -V | head -1)" != "$MIN_BREW" ]; then
  brew update
fi
echo "ok: $(brew --version | head -1)"

step "Доступ к $REPO"
if ! grep -q '^HOMEBREW_GITHUB_API_TOKEN=' "$BREW_ENV" 2>/dev/null; then
  echo "Нужен fine-grained токен GitHub: владелец kopylovis, репозиторий $REPO, Contents: Read-only."
  echo "Создать: https://github.com/settings/personal-access-tokens/new"
  read -rsp "Токен: " token </dev/tty
  echo
  [ -n "$token" ] || fail "Токен не введён."
  mkdir -p "$(dirname "$BREW_ENV")"
  touch "$BREW_ENV"
  chmod 600 "$BREW_ENV"
  printf 'HOMEBREW_GITHUB_API_TOKEN=%s\n' "$token" >> "$BREW_ENV"
fi
token="$(sed -n 's/^HOMEBREW_GITHUB_API_TOKEN=//p' "$BREW_ENV" | tail -1)"
curl -fsS -o /dev/null -H "Authorization: Bearer $token" "https://api.github.com/repos/$REPO" \
  || fail "Токен из $BREW_ENV не открывает $REPO. Удалите из файла строку HOMEBREW_GITHUB_API_TOKEN и запустите скрипт снова."
unset token
echo "ok: доступ к $REPO есть"

step "mnrh"
if brew list --formula mnrh >/dev/null 2>&1; then
  brew upgrade "$FORMULA" || true
else
  brew install "$FORMULA"
fi
MNRH="$(brew --prefix)/bin/mnrh"
echo "ok: mnrh $("$MNRH" --version)"

step "Настройка mnrh"
MNRH_NO_MENU=1 "$MNRH" init || echo "Пропущено. Настроить позже: mnrh init setup"
if command -v claude >/dev/null 2>&1; then
  echo "Если подключили Claude Code — перезапустите его один раз вручную."
fi

printf '\n\033[32mГотово.\033[0m Обновление: brew upgrade mnrh\n'
