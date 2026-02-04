#!/usr/bin/env bash
set -euo pipefail

# shellcheck source=../utils/lib.sh
source "$ROOT_DIR/utils/lib.sh"

mkdir -p "$HOME/.config/git"

BASE_CONFIG="$HOME/.config/git/config"
WORK_CONFIG="$HOME/.gitconfig-work"
PERSONAL_CONFIG="$HOME/.gitconfig-personal"

if [[ ! -f "$BASE_CONFIG" ]]; then
  cp "$ROOT_DIR/gitconfig/gitconfig.base" "$BASE_CONFIG"
  info "Installed base git config: $BASE_CONFIG"
else
  info "Base git config already exists: $BASE_CONFIG"
fi

if [[ ! -f "$WORK_CONFIG" ]]; then
  cp "$ROOT_DIR/gitconfig/gitconfig.work" "$WORK_CONFIG"
  info "Installed work git config: $WORK_CONFIG"
else
  info "Work git config already exists: $WORK_CONFIG"
fi

if [[ ! -f "$PERSONAL_CONFIG" ]]; then
  cp "$ROOT_DIR/gitconfig/gitconfig.personal" "$PERSONAL_CONFIG"
  info "Installed personal git config: $PERSONAL_CONFIG"
else
  info "Personal git config already exists: $PERSONAL_CONFIG"
fi

WORK_DIR="${GIT_WORK_DIR:-$HOME/work/}"
PERSONAL_DIR="${GIT_PERSONAL_DIR:-$HOME/code/}"

if ! grep -q "dotfiles includeIf" "$BASE_CONFIG"; then
  cat <<BLOCK >> "$BASE_CONFIG"

# dotfiles includeIf
[includeIf "gitdir:${WORK_DIR}"]
  path = $WORK_CONFIG
[includeIf "gitdir:${PERSONAL_DIR}"]
  path = $PERSONAL_CONFIG
BLOCK
  info "Added includeIf blocks to base git config."
else
  info "includeIf blocks already present in base git config."
fi

info "Git config setup complete. Update user.name and user.email in your configs."
