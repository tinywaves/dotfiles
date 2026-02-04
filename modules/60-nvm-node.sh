#!/usr/bin/env bash
set -euo pipefail

# shellcheck source=../utils/lib.sh
source "$ROOT_DIR/utils/lib.sh"

if ! command -v nvm >/dev/null 2>&1; then
  if command -v brew >/dev/null 2>&1; then
    info "nvm not in current shell. Attempting to source from Homebrew..."
    NVM_DIR="$HOME/.nvm"
    export NVM_DIR
    NVM_SH="$(brew --prefix nvm)/nvm.sh"
    if [[ -s "$NVM_SH" ]]; then
      # shellcheck source=/dev/null
      . "$NVM_SH"
    fi
  fi
fi

if ! command -v nvm >/dev/null 2>&1; then
  warn "nvm is not available in this shell. Open a new terminal or source nvm, then re-run this module."
  exit 0
fi

info "Installing latest Node via nvm..."
nvm install node
nvm alias default node

info "Installing global npm packages: yarn, pnpm"
npm install -g yarn pnpm

info "Node setup complete."
