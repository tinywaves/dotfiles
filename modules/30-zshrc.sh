#!/usr/bin/env bash
set -euo pipefail

# shellcheck source=../utils/lib.sh
source "$ROOT_DIR/utils/lib.sh"

TEMPLATE_PATH="${OMZ_TEMPLATE:-$ROOT_DIR/templates/omz/.zshrc}"
TARGET_ZSHRC="$HOME/.zshrc"
BACKUP_ZSHRC="$HOME/.zshrc.backup"

if [[ ! -f "$TEMPLATE_PATH" ]]; then
  warn "Template not found: $TEMPLATE_PATH"
  warn "Place your Oh My Zsh template there or set OMZ_TEMPLATE to a file path."
else
  if [[ -f "$TARGET_ZSHRC" ]]; then
    cp "$TARGET_ZSHRC" "$BACKUP_ZSHRC"
    info "Backed up existing .zshrc to $BACKUP_ZSHRC"
  fi
  cp "$TEMPLATE_PATH" "$TARGET_ZSHRC"
  info "Applied Oh My Zsh template to $TARGET_ZSHRC"
fi

BLOCK_START="# >>> dotfiles:base >>>"
BLOCK_END="# <<< dotfiles:base <<<"

if ! grep -q "$BLOCK_START" "$TARGET_ZSHRC" 2>/dev/null; then
  cat <<BLOCK >> "$TARGET_ZSHRC"

$BLOCK_START
export DOTFILES_DIR="$ROOT_DIR"
source "$ROOT_DIR/snippets/ohmyzsh-plugins.zsh"
source "$ROOT_DIR/snippets/nvm.zsh"
$BLOCK_END
BLOCK
  info "Appended dotfiles block to .zshrc"
else
  info "dotfiles block already present in .zshrc"
fi
