#!/usr/bin/env bash
set -euo pipefail

# shellcheck source=../utils/utils.sh
source "$ROOT_DIR/utils/utils.sh"

section "Setup Node.js environment (nvm, Node.js, yarn, pnpm)"

NVM_DIR="$HOME/.nvm"

# Check if nvm is already installed
if [[ ! -d "$NVM_DIR" ]]; then
  section "Install nvm"
  info "Installing nvm via official install script..."
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.4/install.sh | bash
else
  info "nvm is already installed"
fi

# Load nvm (needed to use nvm commands in this script)
# shellcheck disable=SC1091
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"

section "Install latest Node.js LTS"
if nvm ls lts/* &>/dev/null; then
  info "Node.js LTS is already installed"
  nvm use lts/* || nvm install lts/*
else
  info "Installing Node.js LTS..."
  nvm install lts/*
fi

# Set lts as default
nvm alias default lts/*

section "Install yarn"
if command -v yarn >/dev/null 2>&1; then
  info "yarn is already installed"
else
  info "Installing yarn globally..."
  npm install -g yarn
fi

section "Install pnpm"
if command -v pnpm >/dev/null 2>&1; then
  info "pnpm is already installed"
else
  info "Installing pnpm globally..."
  npm install -g pnpm
fi

info "Node.js environment setup complete!"
echo ""
info "Installed versions:"
node --version
npm --version
yarn --version
pnpm --version
