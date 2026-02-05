#!/usr/bin/env bash
set -euo pipefail

# shellcheck source=../utils/utils.sh
source "$ROOT_DIR/utils/utils.sh"

# Rime configuration directory for Squirrel on macOS
RIME_CONFIG_DIR="$HOME/Library/Rime"
TEMPLATE_DIR="${GIT_TEMPLATE_DIR:-$ROOT_DIR/templates/rime-config}"
SYNC_DIR="$RIME_CONFIG_DIR/sync"

# Create Rime config directory if it doesn't exist
mkdir -p "$RIME_CONFIG_DIR"

# Check if template directory exists
if [[ ! -d "$TEMPLATE_DIR" ]]; then
  die "Rime template directory not found: $TEMPLATE_DIR. Run: make submodule-sync"
fi

section "Install Rime Configuration to $RIME_CONFIG_DIR"
# Copy all files from template to Rime config directory (excluding .git)
for item in "$TEMPLATE_DIR"/*; do
  filename=$(basename "$item")
  # Skip .git directory
  if [[ "$filename" == ".git" ]]; then
    continue
  fi

  target="$RIME_CONFIG_DIR/$filename"

  if [[ -e "$target" ]]; then
    info "Already exists: $filename"
  else
    if [[ -f "$item" ]]; then
      cp "$item" "$target"
      info "Installed: $filename"
    elif [[ -d "$item" ]]; then
      cp -r "$item" "$target"
      info "Installed: $filename/"
    fi
  fi
done

section "Copy rime-config to sync directory"
# Copy entire template directory to sync (for git sync)
if [[ ! -d "$SYNC_DIR" ]]; then
  cp -r "$TEMPLATE_DIR" "$SYNC_DIR"
  info "Copied rime-config to: $SYNC_DIR"
else
  info "Sync directory already exists: $SYNC_DIR"
fi

section "Deploy Rime Configuration"
info "Rime configuration files have been installed to: $RIME_CONFIG_DIR"
info "Your sync repository is at: $SYNC_DIR"
info "To sync your changes:"
info "  1. Edit files in: $RIME_CONFIG_DIR"
info "  2. Use Rime menu -> Sync user data"
info "  3. Commit and push in: $SYNC_DIR"
info ""
info "Please deploy the configuration by:"
info "  1. Clicking the Squirrel icon in the menu bar"
info "  2. Selecting 'Deploy' from the menu"
info "Or by restarting the input method (killall Squirrel && open -a Squirrel)"
