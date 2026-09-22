#!/usr/bin/env bash
set -euo pipefail

REPO="kopylovis/mnrh-utils"
FORMULA="kopylovis/tap/mnrh"

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
echo "ok: $(brew --version | head -1)"

step "GitHub CLI"
command -v gh >/dev/null 2>&1 || brew install gh
echo "ok: $(gh --version | head -1)"

step "Вход в GitHub"
if gh auth status --hostname github.com >/dev/null 2>&1; then
  echo "ok: уже выполнен"
else
  gh auth login --hostname github.com --git-protocol https --web
fi
gh auth setup-git --hostname github.com
gh repo view "$REPO" >/dev/null 2>&1 \
  || fail "У этого аккаунта GitHub нет доступа к $REPO. Войдите под нужным: gh auth login"
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
"$MNRH" init || echo "Пропущено. Настроить позже: mnrh init"
if command -v claude >/dev/null 2>&1; then
  echo "Если подключили Claude Code — перезапустите его один раз вручную."
fi

printf '\n\033[32mГотово.\033[0m Обновление: brew upgrade mnrh\n'
