#!/usr/bin/env bash
set -euo pipefail

# shellcheck source=../utils/utils.sh
source "$ROOT_DIR/utils/utils.sh"

if [[ -d "$HOME/.oh-my-zsh" ]]; then
  info "Oh My Zsh already installed."
  exit 0
fi

info "Installing Oh My Zsh (RUNZSH=no, CHSH=no)..."
RUNZSH=no CHSH=no KEEP_ZSHRC=yes \
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

info "Oh My Zsh installation complete."
