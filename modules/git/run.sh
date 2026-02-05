#!/usr/bin/env bash
set -euo pipefail

# shellcheck source=../utils/utils.sh
source "$ROOT_DIR/utils/utils.sh"

GITCONFIG_PATH="$HOME/.config/git"

mkdir -p "$GITCONFIG_PATH"

BASE_CONFIG="$GITCONFIG_PATH/config"
PERSONAL_CONFIG="$GITCONFIG_PATH/config-personal"
WORK_CONFIG="$GITCONFIG_PATH/config-work"

TEMPLATE_DIR="${GIT_TEMPLATE_DIR:-$ROOT_DIR/templates/git}"
BASE_TEMPLATE="$TEMPLATE_DIR/base.config"
WORK_TEMPLATE="$TEMPLATE_DIR/work.config"
PERSONAL_TEMPLATE="$TEMPLATE_DIR/personal.config"

if [[ ! -f "$BASE_CONFIG" ]]; then
  if [[ -f "$BASE_TEMPLATE" ]]; then
    cp "$BASE_TEMPLATE" "$BASE_CONFIG"
    info "Installed base git config: $BASE_CONFIG"
  else
    warn "Base template not found: $BASE_TEMPLATE"
  fi
else
  info "Base git config already exists: $BASE_CONFIG"
fi

if [[ ! -f "$WORK_CONFIG" ]]; then
  if [[ -f "$WORK_TEMPLATE" ]]; then
    work_name="$(prompt_value "Work git name: ")"
    work_email="$(prompt_value "Work git email: ")"

    work_name_escaped="$(escape_sed_replacement "$work_name")"
    work_email_escaped="$(escape_sed_replacement "$work_email")"

    sed -e "s|WORK_NAME|$work_name_escaped|g" \
        -e "s|WORK_EMAIL|$work_email_escaped|g" \
        "$WORK_TEMPLATE" > "$WORK_CONFIG"
    info "Installed work git config: $WORK_CONFIG"
  else
    warn "Work template not found: $WORK_TEMPLATE"
  fi
else
  info "Work git config already exists: $WORK_CONFIG"
fi

if [[ ! -f "$PERSONAL_CONFIG" ]]; then
  if [[ -f "$PERSONAL_TEMPLATE" ]]; then
    cp "$PERSONAL_TEMPLATE" "$PERSONAL_CONFIG"
    info "Installed personal git config: $PERSONAL_CONFIG"
  else
    warn "Personal template not found: $PERSONAL_TEMPLATE"
  fi
else
  info "Personal git config already exists: $PERSONAL_CONFIG"
fi

WORK_DIR="$HOME/Developer/work"
PERSONAL_DIR="$HOME/Developer/personal"

mkdir -p "$WORK_DIR"
mkdir -p "$PERSONAL_DIR"

if ! grep -q "dotfiles includeIf" "$BASE_CONFIG"; then
  cat <<BLOCK >> "$BASE_CONFIG"

# dotfiles includeIf
[includeIf "gitdir:${PERSONAL_DIR}/"]
  path = $PERSONAL_CONFIG
[includeIf "gitdir:${WORK_DIR}/"]
  path = $WORK_CONFIG
BLOCK
  info "Added includeIf blocks to base git config."
else
  info "includeIf blocks already present in base git config."
fi

info "Git config setup complete. Update user.name and user.email in your configs."
