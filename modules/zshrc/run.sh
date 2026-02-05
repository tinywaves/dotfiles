#!/usr/bin/env bash
set -euo pipefail

# shellcheck source=../utils/utils.sh
source "$ROOT_DIR/utils/utils.sh"

TEMPLATE_PATH="${OMZ_TEMPLATE:-$ROOT_DIR/templates/.zshrc}"
TARGET_ZSHRC="$HOME/.zshrc"
BACKUP_ZSHRC="$HOME/.zshrc.backup"

if [[ ! -f "$TEMPLATE_PATH" ]]; then
  warn "Template not found: $TEMPLATE_PATH"
  warn "Place your Oh My Zsh template there or set OMZ_TEMPLATE to a file path."
else
  if [[ -f "$TARGET_ZSHRC" ]]; then
    backup_path="$BACKUP_ZSHRC"
    if [[ -f "$BACKUP_ZSHRC" ]]; then
      timestamp="$(date +%Y%m%d-%H%M%S)"
      backup_path="${BACKUP_ZSHRC}.${timestamp}"
    fi
    cp "$TARGET_ZSHRC" "$backup_path"
    info "Backed up existing .zshrc to $backup_path"
  fi
  cp "$TEMPLATE_PATH" "$TARGET_ZSHRC"
  info "Applied Oh My Zsh template to $TARGET_ZSHRC"
fi
